-- =========================================================
-- NSW rivers seed/load script
-- Uses interpolated 500m points between source and mouth.
-- This is synthetic/demo seed data, not official river-course data.
-- =========================================================

BEGIN;

-- ---------------------------------------------------------
-- 1) Insert river master rows
-- ---------------------------------------------------------
INSERT INTO nsw_rivers (
    river_code,
    river_name,
    river_name_normalized,
    shire_name,
    state_code,
    river_type,
    source_name,
    mouth_name,
    source_latitude,
    source_longitude,
    mouth_latitude,
    mouth_longitude,
    approx_length_km,
    catchment_name,
    basin_name,
    data_source,
    source_record_id,
    notes,
    is_active
)
VALUES
    ('NSW-RIV-0001', 'Murray River', 'murray river', 'Albury City', 'NSW', 'perennial', 'Australian Alps', 'Murray Mouth', -36.850000, 148.300000, -35.560000, 138.860000, 2508.00, 'Murray Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0001', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0002', 'Darling River', 'darling river', 'Bourke Shire', 'NSW', 'intermittent', 'Northern inland Queensland/NSW headwaters system', 'Murray River near Wentworth', -28.000000, 147.000000, -34.100000, 141.900000, 1472.00, 'Darling Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0002', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0003', 'Murrumbidgee River', 'murrumbidgee river', 'Snowy Valleys', 'NSW', 'perennial', 'Fiery Range', 'Murray River near Balranald', -35.600000, 148.650000, -34.650000, 143.550000, 1485.00, 'Murrumbidgee Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0003', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0004', 'Lachlan River', 'lachlan river', 'Upper Lachlan Shire', 'NSW', 'intermittent', 'Great Dividing Range near Gunning', 'Murrumbidgee system / Great Cumbung Swamp region', -34.700000, 149.350000, -33.900000, 145.900000, 1339.00, 'Lachlan Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0004', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0005', 'Macquarie River', 'macquarie river', 'Bathurst Regional', 'NSW', 'perennial', 'Great Dividing Range near Oberon', 'Barwon River system', -33.750000, 149.850000, -30.850000, 147.800000, 960.00, 'Macquarie Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0005', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0006', 'Namoi River', 'namoi river', 'Tamworth Regional', 'NSW', 'perennial', 'Great Dividing Range near Niangala', 'Barwon River near Walgett', -31.250000, 151.350000, -30.020000, 148.100000, 914.00, 'Namoi Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0006', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0007', 'Barwon River', 'barwon river', 'Walgett Shire', 'NSW', 'intermittent', 'Confluence of Macintyre and Weir systems', 'Darling River near Brewarrina/Bourke system', -29.000000, 150.300000, -29.950000, 145.950000, 700.00, 'Barwon Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0007', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0008', 'Gwydir River', 'gwydir river', 'Gwydir Shire', 'NSW', 'intermittent', 'Great Dividing Range east of Uralla', 'Barwon system / Gwydir Wetlands', -30.600000, 151.850000, -29.450000, 148.550000, 668.00, 'Gwydir Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0008', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0009', 'Peel River', 'peel river', 'Tamworth Regional', 'NSW', 'perennial', 'Liverpool Range', 'Namoi River near Carroll', -31.500000, 150.450000, -31.750000, 150.450000, 323.00, 'Namoi Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0009', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0010', 'Macintyre River', 'macintyre river', 'Moree Plains', 'NSW', 'perennial', 'Great Dividing Range near Glen Innes/Inglewood system', 'Barwon River', -28.650000, 151.550000, -29.000000, 150.300000, 319.00, 'Border Rivers Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0010', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0011', 'Warrego River', 'warrego river', 'Bourke Shire', 'NSW', 'intermittent', 'Southwest Queensland', 'Darling River near Bourke', -26.700000, 146.800000, -30.090000, 145.940000, 1380.00, 'Warrego Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0011', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0012', 'Paroo River', 'paroo river', 'Brewarrina Shire', 'NSW', 'intermittent', 'Southwest Queensland', 'Paroo overflow/wetland terminal system', -24.900000, 145.000000, -30.350000, 146.100000, 1210.00, 'Paroo Catchment', 'Lake Eyre / inland terminal system', 'Synthetic NSW Rivers Seed v1', 'SYN-0012', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0013', 'Bogan River', 'bogan river', 'Bogan Shire', 'NSW', 'intermittent', 'Near Peak Hill', 'Darling River near Bourke', -32.750000, 148.100000, -30.100000, 145.950000, 617.00, 'Bogan Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0013', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0014', 'Castlereagh River', 'castlereagh river', 'Warrumbungle Shire', 'NSW', 'intermittent', 'Great Dividing Range near Coonabarabran', 'Barwon River', -31.250000, 149.350000, -30.100000, 148.250000, 549.00, 'Castlereagh Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0014', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0015', 'Cudgegong River', 'cudgegong river', 'Mid-Western Regional', 'NSW', 'perennial', 'Great Dividing Range near Rylstone', 'Macquarie River near Dubbo/Wellington system', -32.700000, 150.150000, -32.300000, 148.900000, 258.00, 'Macquarie Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0015', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0016', 'Hunter River', 'hunter river', 'Upper Hunter Shire', 'NSW', 'perennial', 'Liverpool Range near Moonan Flat', 'Tasman Sea at Newcastle', -31.900000, 150.550000, -32.930000, 151.780000, 300.00, 'Hunter Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0016', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0017', 'Hawkesbury River', 'hawkesbury river', 'The Hills / Hawkesbury', 'NSW', 'perennial', 'Confluence of Nepean and Grose system', 'Tasman Sea at Broken Bay', -33.600000, 150.750000, -33.560000, 151.330000, 120.00, 'Hawkesbury-Nepean Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0017', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0018', 'Nepean River', 'nepean river', 'Wollondilly Shire', 'NSW', 'perennial', 'Near Robertson', 'Hawkesbury River system', -34.600000, 150.600000, -33.600000, 150.750000, 155.00, 'Hawkesbury-Nepean Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0018', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0019', 'Georges River', 'georges river', 'Campbelltown', 'NSW', 'perennial', 'Appin area', 'Botany Bay', -34.220000, 150.800000, -33.990000, 151.180000, 96.00, 'Georges Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0019', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0020', 'Parramatta River', 'parramatta river', 'Parramatta', 'NSW', 'perennial', 'Confluence of Toongabbie and Darling Mills Creeks', 'Sydney Harbour', -33.800000, 150.970000, -33.850000, 151.120000, 21.00, 'Parramatta Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0020', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0021', 'Shoalhaven River', 'shoalhaven river', 'Upper Lachlan / Shoalhaven', 'NSW', 'perennial', 'Near Euranbene Mountain', 'Tasman Sea at Shoalhaven Heads', -35.150000, 149.700000, -34.850000, 150.740000, 327.00, 'Shoalhaven Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0021', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0022', 'Clyde River', 'clyde river', 'Eurobodalla', 'NSW', 'perennial', 'Great Dividing Range west of Batemans Bay', 'Tasman Sea at Batemans Bay', -35.750000, 149.800000, -35.710000, 150.180000, 105.00, 'Clyde Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0022', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0023', 'Moruya River', 'moruya river', 'Eurobodalla', 'NSW', 'perennial', 'Near Araluen', 'Tasman Sea at Moruya Heads', -35.650000, 149.850000, -35.910000, 150.150000, 82.00, 'Moruya Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0023', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0024', 'Bega River', 'bega river', 'Bega Valley', 'NSW', 'perennial', 'Near Nimmitabel/Bemboka region', 'Tasman Sea at Tathra/Bega estuary', -36.550000, 149.350000, -36.720000, 149.980000, 108.00, 'Bega Catchment', 'South Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0024', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0025', 'Snowy River', 'snowy river', 'Snowy Monaro', 'NSW', 'perennial', 'Australian Alps near Mount Kosciuszko', 'Bass Strait / Marlo region', -36.450000, 148.250000, -37.800000, 148.550000, 352.00, 'Snowy Catchment', 'South-East Coast', 'Synthetic NSW Rivers Seed v1', 'SYN-0025', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0026', 'Tumut River', 'tumut river', 'Snowy Valleys', 'NSW', 'perennial', 'Snowy Mountains', 'Murrumbidgee River near Gundagai system', -35.700000, 148.300000, -35.050000, 148.100000, 120.00, 'Murrumbidgee Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0026', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0027', 'Tumbarumba Creek', 'tumbarumba creek', 'Snowy Valleys', 'NSW', 'perennial', 'Western slopes of Snowy Mountains', 'Murray River system', -35.800000, 148.050000, -35.980000, 147.600000, 70.00, 'Upper Murray Catchment', 'Murray-Darling Basin', 'Synthetic NSW Rivers Seed v1', 'SYN-0027', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0028', 'Clarence River', 'clarence river', 'Kyogle', 'NSW', 'perennial', 'Great Dividing Range near Tooloom', 'Tasman Sea at Yamba/Iluka', -28.450000, 152.550000, -29.430000, 153.360000, 394.00, 'Clarence Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0028', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0029', 'Richmond River', 'richmond river', 'Kyogle', 'NSW', 'perennial', 'Border Ranges / Mount Lindesay area', 'Tasman Sea at Ballina', -28.350000, 152.950000, -28.870000, 153.580000, 237.00, 'Richmond Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0029', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0030', 'Tweed River', 'tweed river', 'Tweed Shire', 'NSW', 'perennial', 'McPherson Range', 'Tasman Sea at Tweed Heads', -28.300000, 153.200000, -28.180000, 153.550000, 95.00, 'Tweed Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0030', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0031', 'Macleay River', 'macleay river', 'Walcha', 'NSW', 'perennial', 'Great Dividing Range near Guyra/Walcha', 'Tasman Sea at South West Rocks', -30.950000, 151.700000, -30.890000, 153.030000, 298.00, 'Macleay Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0031', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0032', 'Hastings River', 'hastings river', 'Port Macquarie-Hastings', 'NSW', 'perennial', 'Great Dividing Range west of Wauchope', 'Tasman Sea at Port Macquarie', -31.450000, 152.250000, -31.430000, 152.910000, 142.00, 'Hastings Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0032', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0033', 'Manning River', 'manning river', 'MidCoast', 'NSW', 'perennial', 'Barrington Tops / Gloucester region', 'Tasman Sea near Harrington', -32.100000, 151.550000, -31.870000, 152.680000, 261.00, 'Manning Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0033', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0034', 'Nambucca River', 'nambucca river', 'Nambucca Valley', 'NSW', 'perennial', 'Great Dividing Range west of Bowraville', 'Tasman Sea at Nambucca Heads', -30.700000, 152.450000, -30.650000, 153.000000, 78.00, 'Nambucca Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0034', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0035', 'Bellinger River', 'bellinger river', 'Bellingen', 'NSW', 'perennial', 'Great Dividing Range near Dorrigo', 'Tasman Sea at Urunga', -30.350000, 152.800000, -30.500000, 153.030000, 60.00, 'Bellinger Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0035', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0036', 'Orara River', 'orara river', 'Coffs Harbour', 'NSW', 'perennial', 'Range west of Coffs Harbour', 'Clarence River system', -30.250000, 152.850000, -29.650000, 153.000000, 100.00, 'Clarence Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0036', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0037', 'Mann River', 'mann river', 'Clarence Valley', 'NSW', 'perennial', 'Great Dividing Range near Guyra', 'Clarence River', -30.300000, 151.750000, -29.650000, 152.950000, 238.00, 'Clarence Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0037', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0038', 'Barnard River', 'barnard river', 'MidCoast', 'NSW', 'perennial', 'Barrington Tops', 'Manning River', -31.850000, 151.550000, -31.980000, 152.050000, 148.00, 'Manning Catchment', 'North Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0038', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0039', 'Williams River', 'williams river', 'Dungog', 'NSW', 'perennial', 'Barrington Tops region', 'Hunter River', -32.100000, 151.550000, -32.650000, 151.780000, 145.00, 'Hunter Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0039', 'Synthetic seed row with approximate coordinates and length.', TRUE),
    ('NSW-RIV-0040', 'Paterson River', 'paterson river', 'Dungog', 'NSW', 'perennial', 'Barrington foothills', 'Hunter River', -32.350000, 151.650000, -32.760000, 151.640000, 100.00, 'Hunter Catchment', 'East Coast Basins', 'Synthetic NSW Rivers Seed v1', 'SYN-0040', 'Synthetic seed row with approximate coordinates and length.', TRUE)
ON CONFLICT (river_name, shire_name) DO NOTHING;

-- ---------------------------------------------------------
-- 2) Insert 500m interval course points
--    No point_geom column is used here
-- ---------------------------------------------------------
INSERT INTO nsw_river_course_points (
    river_id,
    point_sequence,
    distance_from_source_m,
    latitude,
    longitude,
    elevation_m,
    segment_length_m
)
SELECT
    r.river_id,
    gs.idx + 1 AS point_sequence,
    gs.idx * 500 AS distance_from_source_m,
    ROUND(
        (
            r.source_latitude
            + ((r.mouth_latitude - r.source_latitude) * (gs.idx::numeric / NULLIF(pt.total_steps, 0)))
        )::numeric,
        6
    ) AS latitude,
    ROUND(
        (
            r.source_longitude
            + ((r.mouth_longitude - r.source_longitude) * (gs.idx::numeric / NULLIF(pt.total_steps, 0)))
        )::numeric,
        6
    ) AS longitude,
    NULL::numeric(10,2) AS elevation_m,
    500 AS segment_length_m
FROM nsw_rivers r
CROSS JOIN LATERAL (
    SELECT GREATEST(FLOOR((COALESCE(r.approx_length_km, 1) * 1000) / 500)::int, 1) AS total_steps
) pt
CROSS JOIN LATERAL generate_series(0, pt.total_steps) AS gs(idx)
WHERE r.data_source = 'Synthetic NSW Rivers Seed v1'
ON CONFLICT (river_id, point_sequence) DO NOTHING;

COMMIT;