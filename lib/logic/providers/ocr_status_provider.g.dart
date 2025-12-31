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

String _$ocrPendingCountHash() => r'84c45bf1363f21ea4992bc9c1bab51c4369b357d';
