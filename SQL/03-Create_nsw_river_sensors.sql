-- =========================================================
-- Drop if exists (safe re-run)
-- =========================================================
DROP TABLE IF EXISTS nsw_river_sensors CASCADE;

-- =========================================================
-- Create sensor metadata table
-- =========================================================
CREATE TABLE nsw_river_sensors (
    sensor_id              BIGSERIAL PRIMARY KEY,
    river_id               BIGINT NOT NULL,

    sensor_code            VARCHAR(100) UNIQUE,     -- e.g. BOM station ID
    sensor_name            VARCHAR(200),

    shire_name             VARCHAR(200),            -- optional redundancy for filtering
    latitude               NUMERIC(9,6),
    longitude              NUMERIC(9,6),

    status                 VARCHAR(50) DEFAULT 'ACTIVE',  -- ACTIVE / INACTIVE / FAULT
    flood_river_height_m   NUMERIC(10,3) NOT NULL,
    flood_flow_rate_m3s    NUMERIC(12,3) NOT NULL,	
    installation_date      DATE,
    last_maintenance_date  DATE,
    notes                  TEXT,

    created_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- =====================================================
    -- Constraints
    -- =====================================================
    CONSTRAINT fk_nsw_river_sensors_river
        FOREIGN KEY (river_id)
        REFERENCES nsw_rivers (river_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_sensor_lat
        CHECK (latitude IS NULL OR latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_sensor_lon
        CHECK (longitude IS NULL OR longitude BETWEEN -180 AND 180),
		
	CONSTRAINT chk_nsw_river_sensor_measurements_height
        CHECK (flood_river_height_m >= 0),

    CONSTRAINT chk_nsw_river_sensor_measurements_flow
        CHECK (flood_flow_rate_m3s >= 0)
);

-- =========================================================
-- Indexes
-- =========================================================

-- Fast lookup by river
CREATE INDEX ix_nsw_river_sensors_river_id
    ON nsw_river_sensors (river_id);

-- Sensor lookup
CREATE INDEX ix_nsw_river_sensors_code
    ON nsw_river_sensors (sensor_code);

-- Spatial-style lookup (basic)
CREATE INDEX ix_nsw_river_sensors_lat_lon
    ON nsw_river_sensors (latitude, longitude);