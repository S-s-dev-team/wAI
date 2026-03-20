import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wai_api/wai_api.dart';

import '../../../api_provider.dart';
import '../data/dashboard_repository.dart';

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

class DashboardState {
  const DashboardState({
    this.categories = const [],
    this.recentInsights = const [],
    this.totalCount = 0,
    this.isLoading = false,
    this.error,
  });

  final List<DashboardCategory> categories;
  final List<Insight> recentInsights;
  final int totalCount;
  final bool isLoading;
  final String? error;

  DashboardState copyWith({
    List<DashboardCategory>? categories,
    List<Insight>? recentInsights,
    int? totalCount,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      categories: categories ?? this.categories,
      recentInsights: recentInsights ?? this.recentInsights,
      totalCount: totalCount ?? this.totalCount,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ---------------------------------------------------------------------------
// Providers
// ---------------------------------------------------------------------------

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final api = ref.watch(waiApiProvider);
  return DashboardRepository(api: api);
});

final dashboardControllerProvider =
    StateNotifierProvider.autoDispose<DashboardController, DashboardState>(
        (ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardController(repository);
});

// ---------------------------------------------------------------------------
// Controller
// ---------------------------------------------------------------------------

class DashboardController extends StateNotifier<DashboardState> {
  final DashboardRepository _repository;

  DashboardController(this._repository) : super(const DashboardState()) {
    loadDashboard();
  }

  /// ダッシュボード情報を取得する。
  Future<void> loadDashboard() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _repository.getDashboard();
      state = state.copyWith(
        categories: result.categories.toList(),
        recentInsights: result.recentInsights.toList(),
        totalCount: result.totalCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'ダッシュボードの取得に失敗しました',
        isLoading: false,
      );
    }
  }
}
