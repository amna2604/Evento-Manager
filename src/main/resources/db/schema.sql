
CREATE TABLE IF NOT EXISTS cities (
                                      id   BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      name VARCHAR(80) NOT NULL UNIQUE
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS users (
                                     id            BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     username      VARCHAR(50)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name     VARCHAR(120) NOT NULL,
    role          VARCHAR(20)  NOT NULL,
    city_id       BIGINT NULL,
    active        TINYINT(1)   NOT NULL DEFAULT 1,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_city FOREIGN KEY (city_id) REFERENCES cities (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS clients (
                                       id      BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       name    VARCHAR(120) NOT NULL UNIQUE,
    contact VARCHAR(160) NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS promoters (
                                         id        BIGINT AUTO_INCREMENT PRIMARY KEY,
                                         full_name VARCHAR(120) NOT NULL,
    phone     VARCHAR(30)  NULL,
    city_id   BIGINT       NOT NULL,
    active    TINYINT(1)   NOT NULL DEFAULT 1,
    CONSTRAINT fk_promoters_city FOREIGN KEY (city_id) REFERENCES cities (id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS products (
                                        id        BIGINT AUTO_INCREMENT PRIMARY KEY,
                                        name      VARCHAR(140) NOT NULL,
    client_id BIGINT NULL,
    stock_qty INT    NOT NULL DEFAULT 0,
    CONSTRAINT fk_products_client FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS stock_changes (
                                             id         BIGINT AUTO_INCREMENT PRIMARY KEY,
                                             product_id BIGINT       NOT NULL,
                                             delta      INT          NOT NULL,
                                             reason     VARCHAR(200) NULL,
    user_id    BIGINT       NULL,
    changed_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_stock_product FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE,
    CONSTRAINT fk_stock_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS equipment (
                                         id        BIGINT AUTO_INCREMENT PRIMARY KEY,
                                         name      VARCHAR(120) NOT NULL UNIQUE,
    category  VARCHAR(60)  NULL,
    total_qty INT          NOT NULL DEFAULT 0
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS promotions (
                                          id             BIGINT AUTO_INCREMENT PRIMARY KEY,
                                          title          VARCHAR(160) NOT NULL,
    client_id      BIGINT       NOT NULL,
    city_id        BIGINT       NOT NULL,
    location       VARCHAR(200) NULL,
    promo_date     DATE         NOT NULL,
    status         VARCHAR(20)  NOT NULL DEFAULT 'PLANIRANA',
    coordinator_id BIGINT       NULL,
    notes          TEXT         NULL,
    required_promoters INT      NOT NULL DEFAULT 1,
    allowance      DECIMAL(10, 2) NOT NULL DEFAULT 0,
    created_by     BIGINT       NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_promotions_client FOREIGN KEY (client_id) REFERENCES clients (id),
    CONSTRAINT fk_promotions_city FOREIGN KEY (city_id) REFERENCES cities (id),
    CONSTRAINT fk_promotions_coordinator FOREIGN KEY (coordinator_id) REFERENCES users (id) ON DELETE SET NULL,
    CONSTRAINT fk_promotions_creator FOREIGN KEY (created_by) REFERENCES users (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS promotion_products (
                                                  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                  promotion_id  BIGINT NOT NULL,
                                                  product_id    BIGINT NOT NULL,
                                                  sent_qty      INT    NOT NULL DEFAULT 0,
                                                  sold_qty      INT    NOT NULL DEFAULT 0,
                                                  free_sent     INT    NOT NULL DEFAULT 0,
                                                  free_given    INT    NOT NULL DEFAULT 0,
                                                  remaining_qty INT    NOT NULL DEFAULT 0,
                                                  UNIQUE KEY uq_promotion_product (promotion_id, product_id),
    CONSTRAINT fk_pp_promotion FOREIGN KEY (promotion_id) REFERENCES promotions (id) ON DELETE CASCADE,
    CONSTRAINT fk_pp_product FOREIGN KEY (product_id) REFERENCES products (id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS promotion_promoters (
                                                   promotion_id BIGINT        NOT NULL,
                                                   promoter_id  BIGINT        NOT NULL,
                                                   allowance    DECIMAL(10, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (promotion_id, promoter_id),
    CONSTRAINT fk_ppr_promotion FOREIGN KEY (promotion_id) REFERENCES promotions (id) ON DELETE CASCADE,
    CONSTRAINT fk_ppr_promoter FOREIGN KEY (promoter_id) REFERENCES promoters (id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS equipment_movements (
                                                   id            BIGINT AUTO_INCREMENT PRIMARY KEY,
                                                   equipment_id  BIGINT      NOT NULL,
                                                   promotion_id  BIGINT      NULL,
                                                   city_id       BIGINT      NOT NULL,
                                                   movement_type VARCHAR(10) NOT NULL,
    qty           INT         NOT NULL,
    moved_on      DATE        NOT NULL,
    note          VARCHAR(200) NULL,
    user_id       BIGINT      NULL,
    CONSTRAINT fk_em_equipment FOREIGN KEY (equipment_id) REFERENCES equipment (id),
    CONSTRAINT fk_em_promotion FOREIGN KEY (promotion_id) REFERENCES promotions (id) ON DELETE SET NULL,
    CONSTRAINT fk_em_city FOREIGN KEY (city_id) REFERENCES cities (id),
    CONSTRAINT fk_em_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS reports (
                                       id              BIGINT AUTO_INCREMENT PRIMARY KEY,
                                       promotion_id    BIGINT      NOT NULL UNIQUE,
                                       author_id       BIGINT      NULL,
                                       summary         TEXT        NULL,
                                       status          VARCHAR(10) NOT NULL DEFAULT 'NACRT',
    submitted_at    DATETIME    NULL,
    reviewed_at     DATETIME    NULL,
    reviewer_id     BIGINT      NULL,
    manager_comment TEXT        NULL,
    CONSTRAINT fk_reports_promotion FOREIGN KEY (promotion_id) REFERENCES promotions (id) ON DELETE CASCADE,
    CONSTRAINT fk_reports_author FOREIGN KEY (author_id) REFERENCES users (id) ON DELETE SET NULL,
    CONSTRAINT fk_reports_reviewer FOREIGN KEY (reviewer_id) REFERENCES users (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS photos (
                                      id           BIGINT AUTO_INCREMENT PRIMARY KEY,
                                      promotion_id BIGINT       NOT NULL,
                                      file_name    VARCHAR(255) NOT NULL,
    caption      VARCHAR(200) NULL,
    uploaded_by  BIGINT       NULL,
    uploaded_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_photos_promotion FOREIGN KEY (promotion_id) REFERENCES promotions (id) ON DELETE CASCADE,
    CONSTRAINT fk_photos_user FOREIGN KEY (uploaded_by) REFERENCES users (id) ON DELETE SET NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;
