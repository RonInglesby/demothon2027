-- =========================================================
-- 1) Master table: one row per river in New South Wales
-- =========================================================
DROP TABLE IF EXISTS nsw_river_course_points CASCADE;
DROP TABLE IF EXISTS nsw_rivers CASCADE;

CREATE TABLE nsw_rivers (
    river_id            BIGSERIAL PRIMARY KEY,
    river_code          VARCHAR(50) UNIQUE,              -- optional external/source code
    river_name          VARCHAR(200) NOT NULL,
    river_name_normalized VARCHAR(200),                 -- optional normalized/searchable form
    shire_name          VARCHAR(200) NOT NULL,
    state_code          CHAR(3) NOT NULL DEFAULT 'NSW',
    river_type          VARCHAR(50),                     -- e.g. perennial, intermittent, creek, tributary
    source_name         VARCHAR(200),                    -- source / origin description
    mouth_name          VARCHAR(200),                    -- river mouth / endpoint description
    source_latitude     NUMERIC(9,6),
    source_longitude    NUMERIC(9,6),
    mouth_latitude      NUMERIC(9,6),
    mouth_longitude     NUMERIC(9,6),
    approx_length_km    NUMERIC(10,2),
    catchment_name      VARCHAR(200),
    basin_name          VARCHAR(200),
    data_source         VARCHAR(200),                    -- source dataset name
    source_record_id    VARCHAR(100),                    -- source row/object id
    notes               TEXT,
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT chk_nsw_rivers_state
        CHECK (state_code = 'NSW'),

    CONSTRAINT chk_nsw_rivers_source_lat
        CHECK (source_latitude IS NULL OR (source_latitude BETWEEN -90 AND 90)),

    CONSTRAINT chk_nsw_rivers_source_lon
        CHECK (source_longitude IS NULL OR (source_longitude BETWEEN -180 AND 180)),

    CONSTRAINT chk_nsw_rivers_mouth_lat
        CHECK (mouth_latitude IS NULL OR (mouth_latitude BETWEEN -90 AND 90)),

    CONSTRAINT chk_nsw_rivers_mouth_lon
        CHECK (mouth_longitude IS NULL OR (mouth_longitude BETWEEN -180 AND 180)),

    CONSTRAINT chk_nsw_rivers_length
        CHECK (approx_length_km IS NULL OR approx_length_km >= 0)
);

-- Helpful uniqueness rule to reduce duplicates
CREATE UNIQUE INDEX ux_nsw_rivers_name_shire
    ON nsw_rivers (river_name, shire_name);

CREATE INDEX ix_nsw_rivers_river_name
    ON nsw_rivers (river_name);

CREATE INDEX ix_nsw_rivers_shire_name
    ON nsw_rivers (shire_name);

CREATE INDEX ix_nsw_rivers_catchment_name
    ON nsw_rivers (catchment_name);


-- =========================================================
-- 2) Detail table: course points every 500m along each river
-- =========================================================
CREATE TABLE nsw_river_course_points (
    course_point_id         BIGSERIAL PRIMARY KEY,
    river_id                BIGINT NOT NULL,
    point_sequence          INTEGER NOT NULL,            -- 1,2,3... in downstream order
    distance_from_source_m  INTEGER NOT NULL,            -- 0, 500, 1000, ...
    latitude                NUMERIC(9,6) NOT NULL,
    longitude               NUMERIC(9,6) NOT NULL,
    elevation_m             NUMERIC(10,2),               -- optional if known
    segment_length_m        INTEGER NOT NULL DEFAULT 500,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_nsw_river_course_points_river
        FOREIGN KEY (river_id)
        REFERENCES nsw_rivers (river_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_nsw_river_course_points_lat
        CHECK (latitude BETWEEN -90 AND 90),

    CONSTRAINT chk_nsw_river_course_points_lon
        CHECK (longitude BETWEEN -180 AND 180),

    CONSTRAINT chk_nsw_river_course_points_seq
        CHECK (point_sequence > 0),

    CONSTRAINT chk_nsw_river_course_points_distance
        CHECK (distance_from_source_m >= 0),

    CONSTRAINT chk_nsw_river_course_points_segment
        CHECK (segment_length_m > 0)
);

-- One point per river per sequence number
CREATE UNIQUE INDEX ux_nsw_river_course_points_river_seq
    ON nsw_river_course_points (river_id, point_sequence);

-- One point per river per measured distance
CREATE UNIQUE INDEX ux_nsw_river_course_points_river_distance
    ON nsw_river_course_points (river_id, distance_from_source_m);

CREATE INDEX ix_nsw_river_course_points_river_id
    ON nsw_river_course_points (river_id);


-- =========================================================
-- Optional trigger to maintain updated_at on nsw_rivers
-- =========================================================
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_set_updated_at_nsw_rivers ON nsw_rivers;

CREATE TRIGGER trg_set_updated_at_nsw_rivers
BEFORE UPDATE ON nsw_rivers
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


