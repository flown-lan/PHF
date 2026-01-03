// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocr_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ocrPendingCount)
final ocrPendingCountProvider = OcrPendingCountProvider._();

final class OcrPendingCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  OcrPendingCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ocrPendingCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ocrPendingCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return ocrPendingCount(ref);
  }
}

String _$ocrPendingCountHash() => r'e15b6886b8075597f9042d7934687e873d6ce898';
