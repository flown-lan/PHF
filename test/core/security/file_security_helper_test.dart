import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:phf/core/security/file_security_helper.dart';
import 'package:phf/logic/services/interfaces/crypto_service.dart';
import 'package:uuid/uuid.dart';

@GenerateNiceMocks([MockSpec<ICryptoService>(), MockSpec<Uuid>()])
import 'file_security_helper_test.mocks.dart';

void main() {
  late MockICryptoService mockCryptoService;
  late MockUuid mockUuid;
  late FileSecurityHelper helper;

  setUp(() {
    mockCryptoService = MockICryptoService();
    mockUuid = MockUuid();
    helper = FileSecurityHelper(
      cryptoService: mockCryptoService,
      uuid: mockUuid,
    );
  });

  group('FileSecurityHelper', () {
    test('encryptMedia orchestrates key and file ops', () async {
      // Arrange
      final sourceFile = File('/tmp/source.jpg');
      final targetDir = '/sandbox/images';
      final rawKey = Uint8List.fromList([1, 2, 3]);
      
      when(mockCryptoService.generateRandomKey()).thenReturn(rawKey);
      when(mockUuid.v4()).thenReturn('test-uuid');

      // Act
      final result = await helper.encryptMedia(
        sourceFile,
        targetDir: targetDir,
      );

      // Assert
      // 1. Check Key Encoding
      expect(result.base64Key, base64Encode(rawKey));
      
      // 2. Check Path Generation
      expect(result.relativePath, 'test-uuid.enc');
      
      // 3. Verify delegate call
      verify(mockCryptoService.encryptFile(
        sourcePath: sourceFile.path,
        destPath: '$targetDir/test-uuid.enc', 
        key: rawKey,
      )).called(1);
    });

    test('decryptToTemp orchestrates decryption', () async {
      // Arrange
      final encryptedPath = '/sandbox/images/abc.enc';
      final rawKey = Uint8List.fromList([4, 5, 6]);
      final base64Key = base64Encode(rawKey);
      final tempDir = '/tmp/cache';
      
      when(mockUuid.v4()).thenReturn('temp-uuid');

      // Act
      final file = await helper.decryptToTemp(
        encryptedPath,
        base64Key,
        tempDir: tempDir,
      );

      // Assert
      expect(file.path, '$tempDir/temp-uuid.tmp');
      
      verify(mockCryptoService.decryptFile(
        sourcePath: encryptedPath,
        destPath: '$tempDir/temp-uuid.tmp',
        key: rawKey,
      )).called(1);
    });
  });
}
