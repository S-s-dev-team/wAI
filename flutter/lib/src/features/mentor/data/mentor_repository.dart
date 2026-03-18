import 'package:wai_api/wai_api.dart';

class MentorRepository {
  final WaiApi _api;

  MentorRepository({WaiApi? api}) : _api = api ?? WaiApi();

  /// 先輩（メンター）を作成し、チャットIDを返す。
  Future<String> createMentor({
    required String name,
    required String gender,
    required int age,
    required String occupation,
    required int annualIncome,
  }) async {
    final response = await _api.getChatsApi().createChat(
      createChatRequest: CreateChatRequest((b) => b
        ..persona.replace(CreatePersonaInput((p) => p
          ..name = name
          ..gender = gender
          ..age = age
          ..occupation = occupation
          ..annualIncome = annualIncome))),
    );

    final chatId = response.data?.id;
    if (chatId == null) {
      throw Exception('チャットの作成に失敗しました');
    }
    return chatId;
  }
}
