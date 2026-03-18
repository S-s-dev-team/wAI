import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api_provider.dart';
import '../data/mentor_repository.dart';

/// フォームから送信される先輩作成の入力値。
class CreateMentorInput {
  const CreateMentorInput({
    required this.gender,
    required this.age,
    required this.occupation,
    required this.annualIncome,
  });

  final String gender;
  final int age;
  final String occupation;
  final int annualIncome;

  /// 職種から先輩名を自動生成する。
  String get name => '$occupation先輩';
}

class CreateMentorState {
  final bool isLoading;
  final String? error;
  final String? createdChatId;

  const CreateMentorState({
    this.isLoading = false,
    this.error,
    this.createdChatId,
  });

  CreateMentorState copyWith({
    bool? isLoading,
    String? error,
    String? createdChatId,
  }) {
    return CreateMentorState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      createdChatId: createdChatId,
    );
  }
}

// --- Providers ---

final mentorRepositoryProvider = Provider<MentorRepository>((ref) {
  final api = ref.watch(waiApiProvider);
  return MentorRepository(api: api);
});

final createMentorControllerProvider =
    StateNotifierProvider<CreateMentorController, CreateMentorState>((ref) {
  final repository = ref.watch(mentorRepositoryProvider);
  return CreateMentorController(repository);
});

// --- Controller ---

class CreateMentorController extends StateNotifier<CreateMentorState> {
  final MentorRepository _repository;

  CreateMentorController(this._repository)
      : super(const CreateMentorState());

  Future<void> createMentor(CreateMentorInput input) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final chatId = await _repository.createMentor(
        name: input.name,
        gender: input.gender,
        age: input.age,
        occupation: input.occupation,
        annualIncome: input.annualIncome,
      );
      state = state.copyWith(createdChatId: chatId);
    } catch (e) {
      state = state.copyWith(error: '先輩の作成に失敗しました');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
