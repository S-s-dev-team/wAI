-- UUID拡張
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ユーザー
CREATE TABLE users (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    firebase_uid VARCHAR(128) UNIQUE NOT NULL,
    email        VARCHAR(255) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

-- プリセットキー（マスタ）
CREATE TABLE preset_keys (
    id         VARCHAR(50) PRIMARY KEY,
    label      VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 先輩の人物像（カスタム＋プリセット）
CREATE TABLE personas (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id       UUID REFERENCES users(id) ON DELETE CASCADE,
    chat_id       UUID,
    persona_type  VARCHAR(10) NOT NULL CHECK (persona_type IN ('custom', 'preset')),
    preset_key_id VARCHAR(50) REFERENCES preset_keys(id),
    name          VARCHAR(100) NOT NULL,
    gender        VARCHAR(20),
    age           INT,
    occupation    VARCHAR(100),
    annual_income INT,
    system_prompt TEXT NOT NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at    TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT check_custom_has_user CHECK (
        persona_type = 'preset' OR user_id IS NOT NULL
    ),
    CONSTRAINT check_preset_has_key CHECK (
        persona_type = 'custom' OR preset_key_id IS NOT NULL
    )
);

-- チャット
CREATE TABLE chats (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id    UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title      VARCHAR(200),
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- personas の chat_id に FK 追加
ALTER TABLE personas
    ADD CONSTRAINT fk_personas_chat
    FOREIGN KEY (chat_id) REFERENCES chats(id) ON DELETE CASCADE;

-- チャット参加先輩
CREATE TABLE chat_participants (
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chat_id    UUID NOT NULL REFERENCES chats(id) ON DELETE CASCADE,
    persona_id UUID NOT NULL REFERENCES personas(id) ON DELETE CASCADE,
    joined_at  TIMESTAMP NOT NULL DEFAULT NOW(),

    UNIQUE (chat_id, persona_id)
);

-- メッセージ
CREATE TABLE messages (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chat_id     UUID NOT NULL REFERENCES chats(id) ON DELETE CASCADE,
    sender_type VARCHAR(10) NOT NULL CHECK (sender_type IN ('user', 'persona')),
    persona_id  UUID REFERENCES personas(id) ON DELETE SET NULL,
    content     TEXT NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT check_persona_sender CHECK (
        sender_type = 'user' OR persona_id IS NOT NULL
    )
);

-- 自己分析カテゴリ（マスタ）
CREATE TABLE insight_categories (
    id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_key VARCHAR(50) UNIQUE NOT NULL,
    display_name VARCHAR(50) NOT NULL,
    description  TEXT
);

-- 自己分析インサイト
CREATE TABLE insights (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    chat_id     UUID REFERENCES chats(id) ON DELETE SET NULL,
    category_id UUID NOT NULL REFERENCES insight_categories(id),
    content     TEXT NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- インデックス
CREATE INDEX idx_chats_user_id         ON chats(user_id);
CREATE INDEX idx_messages_chat_id      ON messages(chat_id);
CREATE INDEX idx_messages_created_at   ON messages(chat_id, created_at);
CREATE INDEX idx_insights_user_id      ON insights(user_id);
CREATE INDEX idx_insights_category_id  ON insights(category_id);
CREATE INDEX idx_chat_participants_chat ON chat_participants(chat_id);

-- シードデータ: preset_keys
INSERT INTO preset_keys (id, label) VALUES
    ('yarigai', 'やりがい重視'),
    ('nenshu',  '年収重視');

-- シードデータ: insight_categories
INSERT INTO insight_categories (category_key, display_name, description) VALUES
    ('values',        '価値観',         '仕事や人生において大切にしていること'),
    ('strengths',     '強み',           '自分の得意なこと・優れている点'),
    ('weaknesses',    '弱み',           '自分の苦手なこと・改善が必要な点'),
    ('suitable_jobs', '向いている職種', '適性があると考えられる仕事・職種'),
    ('interests',     '興味・関心',     '興味を持っている分野やテーマ');

-- シードデータ: プリセット先輩
INSERT INTO personas (persona_type, preset_key_id, name, system_prompt) VALUES
    ('preset', 'yarigai', 'やりがい重視先輩',
     'あなたは仕事のやりがいや成長を最優先に考える社会人の先輩です。給与よりも「仕事の意味」「社会貢献」「自己成長」を重視した視点でアドバイスをしてください。就活生の価値観を引き出すような質問を積極的にしてください。'),
    ('preset', 'nenshu', '年収重視先輩',
     'あなたは年収・キャリアアップ・市場価値を最優先に考える社会人の先輩です。やりがいよりも「稼ぐ力」「スキルの市場価値」「昇給・転職のしやすさ」を重視した視点でアドバイスをしてください。就活生が自分の強みを経済的価値で評価できるよう導いてください。');
