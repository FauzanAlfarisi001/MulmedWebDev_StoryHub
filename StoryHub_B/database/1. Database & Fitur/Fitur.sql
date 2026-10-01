









-- Subscribe

-- 1 bulan

INSERT INTO subscriptions (
    user_id,
    plan,
    end_date
)
VALUES (
    1,
    'monthly',
    DATE_ADD(NOW(), INTERVAL 1 MONTH)
);

-- 1 tahun

INSERT INTO subscriptions (
    user_id,
    plan,
    end_date
)
VALUES (
    1,
    'yearly',
    DATE_ADD(NOW(), INTERVAL 1 YEAR)
);

-- Cek apakah user masih is_langganan

SELECT *
FROM subscriptions
WHERE user_id = 1
AND cancelled_at IS NULL
AND end_date > NOW()
ORDER BY end_date DESC
LIMIT 1;

-- Cek sisa waktu is_langganan

SELECT
    end_date,
    TIMESTAMPDIFF(DAY, NOW(), end_date) AS remaining_days
FROM subscriptions
WHERE user_id = 1
AND cancelled_at IS NULL
AND end_date > NOW()
LIMIT 1;

-- Cancel Langganan (kalau perlu)

UPDATE subscriptions
SET cancelled_at = NOW()
WHERE user_id = 1
AND end_date > NOW();