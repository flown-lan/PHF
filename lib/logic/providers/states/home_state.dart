import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/record.dart';

/// ## 修复记录
/// - [issue#22] 在 `HomeState` 中增加过滤相关的状态字段（Tags, DateRange, SearchQuery）。

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<MedicalRecord> records,
    @Default(0) int pendingCount,
    List<String>? filterTags,
    DateTime? startDate,
    DateTime? endDate,
    String? searchQuery,
  }) = _HomeState;
}
