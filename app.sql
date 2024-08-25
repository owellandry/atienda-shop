-- Tabla de usuarios
CREATE TABLE users (
    id UUID PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    username TEXT UNIQUE,
    age INTEGER,
    phone TEXT,
    email TEXT UNIQUE,
    password TEXT,
    avatar TEXT,
    banner TEXT,
    user_type TEXT CHECK (user_type IN ('buyer', 'seller')),
    theme TEXT,
    membership JSONB,
    store JSONB,
    referral_code TEXT,
    last_login DATE,
    role TEXT,
    initial_ip TEXT,
    allowed_ips TEXT[],
    two_factor_auth JSONB,
    privacy_settings JSONB,
    social_media JSONB
);

-- Tabla de publicaciones
CREATE TABLE posts (
    post_id UUID PRIMARY KEY,
    store_id UUID REFERENCES users(id),
    title TEXT,
    content TEXT,
    image TEXT,
    price NUMERIC,
    quantity INTEGER,
    colors TEXT[],
    status TEXT CHECK (status IN ('available', 'unavailable')),
    condition TEXT CHECK (condition IN ('new', 'used')),
    creation_date DATE,
    options JSONB
);

-- Tabla de beneficios de membresía
CREATE TABLE membership_benefits (
    membership_type TEXT PRIMARY KEY,
    publication_limit INTEGER,
    verified BOOLEAN,
    search_priority BOOLEAN,
    personal_advisor BOOLEAN,
    custom_domain BOOLEAN,
    platform_advertising BOOLEAN,
    font_customizations BOOLEAN,
    color_customizations BOOLEAN,
    animated_texts_customizations BOOLEAN,
    different_cards_customizations BOOLEAN
);

-- Tabla de registros de actividad
CREATE TABLE activity_logs (
    log_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    action TEXT,
    description TEXT,
    date DATE
);

-- Tabla de suscripciones
CREATE TABLE subscriptions (
    subscription_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    membership_type TEXT,
    start_date DATE,
    expiry_date DATE
);

-- Tabla de historial de pagos
CREATE TABLE payment_history (
    payment_id UUID PRIMARY KEY,
    subscription_id UUID REFERENCES subscriptions(subscription_id),
    payment_date DATE,
    amount NUMERIC,
    payment_status TEXT
);

-- Tabla de tickets de soporte
CREATE TABLE support_tickets (
    ticket_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    subject TEXT,
    description TEXT,
    creation_date DATE,
    status TEXT,
    responses JSONB
);

-- Tabla de analíticas
CREATE TABLE analytics (
    analytics_id UUID PRIMARY KEY,
    store_id UUID REFERENCES users(id),
    views INTEGER,
    clicks INTEGER,
    conversions INTEGER,
    report_date DATE
);

-- Tabla de enlaces afiliados
CREATE TABLE affiliate_links (
    link_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    source_url TEXT,
    affiliate_url TEXT,
    creation_date DATE
);

-- Tabla de historial de cambios de perfil
CREATE TABLE profile_change_history (
    change_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    field_modified TEXT,
    previous_value TEXT,
    new_value TEXT,
    change_date DATE
);

-- Tabla de lista de deseos
CREATE TABLE wishlist (
    user_id UUID REFERENCES users(id),
    product_id UUID,
    date_added DATE,
    PRIMARY KEY (user_id, product_id)
);

-- Tabla de recomendaciones
CREATE TABLE recommendations (
    user_id UUID REFERENCES users(id),
    recommended_product_id UUID,
    recommendation_reason TEXT,
    recommendation_date DATE,
    PRIMARY KEY (user_id, recommended_product_id)
);

-- Tabla de interacciones de soporte
CREATE TABLE support_interactions (
    ticket_id UUID REFERENCES support_tickets(ticket_id),
    user_id UUID REFERENCES users(id),
    interaction TEXT,
    interaction_date DATE
);

-- Tabla de feedback
CREATE TABLE feedback (
    feedback_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    feedback_type TEXT CHECK (feedback_type IN ('product', 'store', 'platform')),
    description TEXT,
    feedback_date DATE
);

-- Tabla de recompensas
CREATE TABLE rewards (
    user_id UUID REFERENCES users(id),
    points NUMERIC,
    reward_type TEXT,
    reward_date DATE,
    PRIMARY KEY (user_id, reward_type)
);

-- Tabla de configuración de notificaciones
CREATE TABLE notification_settings (
    user_id UUID REFERENCES users(id),
    notifications JSONB
);

-- Tabla de historial de navegación
CREATE TABLE browsing_history (
    user_id UUID REFERENCES users(id),
    product_id UUID,
    visit_date DATE,
    PRIMARY KEY (user_id, product_id, visit_date)
);

-- Tabla de publicaciones eliminadas
CREATE TABLE deleted_posts (
    post_id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id),
    title TEXT,
    content TEXT,
    image TEXT,
    price NUMERIC,
    quantity INTEGER,
    colors TEXT[],
    status TEXT,
    creation_date DATE,
    deletion_date DATE
);

-- Tabla de cuentas eliminadas
CREATE TABLE deleted_accounts (
    user_id UUID PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    inactivity_date DATE
);





-- Activar Row-Level Security (RLS) en todas las tablas
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE support_tickets ENABLE ROW LEVEL SECURITY;
ALTER TABLE affiliate_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE wishlist ENABLE ROW LEVEL SECURITY;
ALTER TABLE support_interactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE feedback ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE analytics ENABLE ROW LEVEL SECURITY;
ALTER TABLE profile_change_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE deleted_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE deleted_accounts ENABLE ROW LEVEL SECURITY;

-- Tabla de usuarios: Los usuarios solo pueden ver y modificar su propio perfil
CREATE POLICY users_select_policy ON users
FOR SELECT
USING (username = current_user);

CREATE POLICY users_insert_policy ON users
FOR INSERT
WITH CHECK (username = current_user);

CREATE POLICY users_update_policy ON users
FOR UPDATE
USING (username = current_user);

CREATE POLICY users_delete_policy ON users
FOR DELETE
USING (username = current_user);

-- Tabla de publicaciones: Los usuarios solo pueden ver y modificar sus propias publicaciones
CREATE POLICY posts_select_policy ON posts
FOR SELECT
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY posts_insert_policy ON posts
FOR INSERT
WITH CHECK (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY posts_update_policy ON posts
FOR UPDATE
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY posts_delete_policy ON posts
FOR DELETE
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de suscripciones: Los usuarios solo pueden ver y modificar sus propias suscripciones
CREATE POLICY subscriptions_select_policy ON subscriptions
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY subscriptions_insert_policy ON subscriptions
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY subscriptions_update_policy ON subscriptions
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY subscriptions_delete_policy ON subscriptions
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de tickets de soporte: Los usuarios solo pueden ver y modificar sus propios tickets
CREATE POLICY support_tickets_select_policy ON support_tickets
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_tickets_insert_policy ON support_tickets
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_tickets_update_policy ON support_tickets
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_tickets_delete_policy ON support_tickets
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de enlaces afiliados: Los usuarios solo pueden ver y modificar sus propios enlaces
CREATE POLICY affiliate_links_select_policy ON affiliate_links
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY affiliate_links_insert_policy ON affiliate_links
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY affiliate_links_update_policy ON affiliate_links
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY affiliate_links_delete_policy ON affiliate_links
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de lista de deseos: Los usuarios solo pueden ver y modificar su propia lista
CREATE POLICY wishlist_select_policy ON wishlist
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY wishlist_insert_policy ON wishlist
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY wishlist_delete_policy ON wishlist
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de interacciones de soporte: Los usuarios solo pueden ver y modificar sus propias interacciones
CREATE POLICY support_interactions_select_policy ON support_interactions
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_interactions_insert_policy ON support_interactions
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_interactions_update_policy ON support_interactions
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY support_interactions_delete_policy ON support_interactions
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de feedback: Los usuarios solo pueden ver y modificar su propio feedback
CREATE POLICY feedback_select_policy ON feedback
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY feedback_insert_policy ON feedback
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY feedback_update_policy ON feedback
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY feedback_delete_policy ON feedback
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de registros de actividad: Los usuarios solo pueden ver sus propios registros
CREATE POLICY activity_logs_select_policy ON activity_logs
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY activity_logs_insert_policy ON activity_logs
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY activity_logs_update_policy ON activity_logs
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY activity_logs_delete_policy ON activity_logs
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de analíticas: Los usuarios solo pueden ver y modificar sus propias analíticas
CREATE POLICY analytics_select_policy ON analytics
FOR SELECT
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY analytics_insert_policy ON analytics
FOR INSERT
WITH CHECK (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY analytics_update_policy ON analytics
FOR UPDATE
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY analytics_delete_policy ON analytics
FOR DELETE
USING (store_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de historial de cambios de perfil: Los usuarios solo pueden ver y modificar su propio historial
CREATE POLICY profile_change_history_select_policy ON profile_change_history
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY profile_change_history_insert_policy ON profile_change_history
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY profile_change_history_update_policy ON profile_change_history
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY profile_change_history_delete_policy ON profile_change_history
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de publicaciones eliminadas: Los usuarios solo pueden ver y modificar sus propias publicaciones eliminadas
CREATE POLICY deleted_posts_select_policy ON deleted_posts
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_posts_insert_policy ON deleted_posts
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_posts_update_policy ON deleted_posts
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_posts_delete_policy ON deleted_posts
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

-- Tabla de cuentas eliminadas: Los usuarios solo pueden ver y modificar sus propias cuentas eliminadas
CREATE POLICY deleted_accounts_select_policy ON deleted_accounts
FOR SELECT
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_accounts_insert_policy ON deleted_accounts
FOR INSERT
WITH CHECK (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_accounts_update_policy ON deleted_accounts
FOR UPDATE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

CREATE POLICY deleted_accounts_delete_policy ON deleted_accounts
FOR DELETE
USING (user_id IN (SELECT id FROM users WHERE username = current_user));

