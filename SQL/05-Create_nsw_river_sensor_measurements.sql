-- =========================================================
-- Drop if exists (safe re-run)
-- =========================================================
DROP TABLE IF EXISTS nsw_river_sensor_measurements CASCADE;

-- =========================================================
-- Create measurement table
-- =========================================================
CREATE TABLE nsw_river_sensor_measurements (
    measurement_id         BIGSERIAL PRIMARY KEY,
    sensor_id              BIGINT NOT NULL,
    measurement_timestamp  TIMESTAMPTZ NOT NULL,
    river_height_m         NUMERIC(10,3) NOT NULL,
    flow_rate_m3s          NUMERIC(12,3) NOT NULL,
    created_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_nsw_river_sensor_measurements_sensor
        FOREIGN KEY (sensor_id)
        REFERENCES nsw_river_sensors (sensor_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_nsw_river_sensor_measurements_height
        CHECK (river_height_m >= 0),

    CONSTRAINT chk_nsw_river_sensor_measurements_flow
        CHECK (flow_rate_m3s >= 0)
);

-- =========================================================
-- Indexes
-- =========================================================

-- Fast lookup of measurements by sensor
CREATE INDEX ix_nsw_river_sensor_measurements_sensor_id
    ON nsw_river_sensor_measurements (sensor_id);

-- Fast time-based queries
CREATE INDEX ix_nsw_river_sensor_measurements_timestamp
    ON nsw_river_sensor_measurements (measurement_timestamp);

-- Fast retrieval of a sensor's time series
CREATE INDEX ix_nsw_river_sensor_measurements_sensor_timestamp
    ON nsw_river_sensor_measurements (sensor_id, measurement_timestamp);

-- Optional: prevent duplicate readings for the same sensor at the same timestamp
CREATE UNIQUE INDEX ux_nsw_river_sensor_measurements_sensor_timestamp
    ON nsw_river_sensor_measurements (sensor_id, measurement_timestamp);