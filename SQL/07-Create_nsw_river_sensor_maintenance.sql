-- =========================================================
-- Drop if exists (safe re-run)
-- =========================================================
DROP TABLE IF EXISTS nsw_river_sensor_maintenance CASCADE;

-- =========================================================
-- Create maintenance table
-- =========================================================
CREATE TABLE nsw_river_sensor_maintenance (
    maintenance_id         BIGSERIAL PRIMARY KEY,
    sensor_id              BIGINT NOT NULL,
    maintenance_timestamp  TIMESTAMPTZ NOT NULL,
    error_code             VARCHAR(50) NOT NULL,
    error_notes            TEXT,
    created_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_nsw_river_sensor_maintenance_sensor
        FOREIGN KEY (sensor_id)
        REFERENCES nsw_river_sensors (sensor_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_nsw_river_sensor_maintenance_error_code
        CHECK (length(trim(error_code)) > 0)
);

-- =========================================================
-- Indexes
-- =========================================================

-- Fast lookup by sensor
CREATE INDEX ix_nsw_river_sensor_maintenance_sensor_id
    ON nsw_river_sensor_maintenance (sensor_id);

-- Fast time-based queries
CREATE INDEX ix_nsw_river_sensor_maintenance_timestamp
    ON nsw_river_sensor_maintenance (maintenance_timestamp);

-- Fast retrieval of maintenance history per sensor
CREATE INDEX ix_nsw_river_sensor_maintenance_sensor_timestamp
    ON nsw_river_sensor_maintenance (sensor_id, maintenance_timestamp);

-- Optional: helpful if you search/filter by error code
CREATE INDEX ix_nsw_river_sensor_maintenance_error_code
    ON nsw_river_sensor_maintenance (error_code);