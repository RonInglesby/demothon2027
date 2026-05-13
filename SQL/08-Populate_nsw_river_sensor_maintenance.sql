INSERT INTO nsw_river_sensor_maintenance (
    sensor_id,
    maintenance_timestamp,
    error_code,
    error_notes
)
VALUES
    (1, '2026-03-18 09:15:00+08', 'BATTERY_LOW', 'Battery voltage dropped below operating threshold'),
    (1, '2026-03-19 11:30:00+08', 'FLOW_CALIB', 'Flow rate sensor required recalibration after drift detected'),
    (2, '2026-03-19 14:05:00+08', 'COMMS_FAIL', 'Telemetry link offline intermittently during storm event');