// 【開発用】UIプレビューナビゲーター
// 各画面を手動で確認するための一時的な画面です。
// 本番ビルドでは削除してください。

import 'package:flutter/material.dart';
import 'core/theme/colors.dart';
import 'core/theme/spacing.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/chat/presentation/chat_list_screen.dart';
import 'features/chat/presentation/chat_screen.dart';
import 'features/chat/widgets/chat_message_list.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/senior/presentation/create_senior_screen.dart';
import 'shared/widgets/chat_bubble.dart';

// ---------------------------------------------------------------------------
// ダッシュボード用ダミーデータ
// ---------------------------------------------------------------------------

const _dummyCoreValue = CoreValueData(
  badge: '✨',
  timestamp: '2024-03-15',
  title: '成長志向',
  description: '常に学び続けることを大切にしている',
);

const _dummyStrengths = [
  StrengthData(
    icon: Icons.lightbulb_outline_rounded,
    name: '問題解決力',
    description: '複雑な課題を分解して解決できる',
  ),
  StrengthData(
    icon: Icons.people_outline_rounded,
    name: 'コミュニケーション力',
    description: '多様な立場の人と円滑に協力できる',
  ),
];

const _dummyInsightQuotes = [
  InsightQuoteData(
    text: 'チームで協力することにやりがいを感じる',
    label: 'チームワーク',
    isFeatured: true,
  ),
  InsightQuoteData(
    text: '新しい技術を習得することが好き',
    label: '学習意欲',
  ),
];

// ---------------------------------------------------------------------------
// DevPreviewScreen
// ---------------------------------------------------------------------------

class DevPreviewScreen extends StatelessWidget {
  const DevPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dev Preview'),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.pagePadding),
        children: [
          _PreviewTile(
            label: 'login_screen',
            icon: Icons.login_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginScreen(
                onGoogleLogin: () {},
              )),
            ),
          ),
          _PreviewTile(
            label: 'chat_list_screen',
            icon: Icons.chat_bubble_outline_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChatListScreen(
                  items: [
                    ChatListItem(
                      id: '1',
                      name: '田中 健太',
                      role: 'エンジニア',
                      preview: '就活についてアドバイスします！',
                      timestamp: '14:30',
                      hasUnread: true,
                      isOnline: true,
                    ),
                    ChatListItem(
                      id: '2',
                      name: '山田 花子',
                      role: 'マーケティング',
                      preview: 'ポートフォリオを見直しましょう',
                      timestamp: '昨日',
                    ),
                  ],
                ),
              ),
            ),
          ),
          _PreviewTile(
            label: 'chat_screen',
            icon: Icons.forum_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChatScreen(
                  initialMessages: [
                    ChatMessage(
                      id: '1',
                      text: 'こんにちは！これからのキャリアについて、一緒に考えていきましょう。今の状況を教えてもらえますか？',
                      sender: ChatSender.ai,
                      senderName: 'CUSTOM SENIOR',
                    ),
                    ChatMessage(
                      id: '2',
                      text: '私は「やりがい」をどう見つけるか、自分の経験からお話しできますよ！無理せず本音で話しましょう。',
                      sender: ChatSender.ai,
                      senderName: 'やりがい重視先輩',
                    ),
                    ChatMessage(
                      id: '3',
                      text: 'ありがとうございます。今の仕事に少し迷いがあって... 毎日忙しいのですが、自分の成長が感じられなくて。',
                      sender: ChatSender.user,
                      senderName: 'あなた',
                    ),
                    ChatMessage(
                      id: '4',
                      text: 'まずは現状を客観的に整理してみましょうか。今の不満を書き出してみるのも一つの手です。具体的にどんな時に「成長していない」と感じますか？',
                      sender: ChatSender.ai,
                      senderName: '分析・戦略先輩',
                    ),
                  ],
                ),
              ),
            ),
          ),
          _PreviewTile(
            label: 'create_senior_screen',
            icon: Icons.person_add_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateSeniorScreen()),
            ),
          ),
          _PreviewTile(
            label: 'dashboard_screen',
            icon: Icons.grid_view_rounded,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DashboardScreen(
                  analysisCount: '12',
                  analysisTrend: '+3',
                  analysisTrendPositive: true,
                  insightCount: '34',
                  insightTrend: '+8',
                  insightTrendPositive: true,
                  coreValue: _dummyCoreValue,
                  strengths: _dummyStrengths,
                  interests: ['IT・通信', 'マーケティング', 'コンサルティング'],
                  insightQuotes: _dummyInsightQuotes,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _PreviewTile
// ---------------------------------------------------------------------------

class _PreviewTile extends StatelessWidget {
  const _PreviewTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(icon, color: AppColors.accent),
        title: Text(label, style: const TextStyle(fontFamily: 'monospace')),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
