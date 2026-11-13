
-- Create the database used for prospect search auditing and manual review
CREATE DATABASE prospect_engine_audit;
GO


-- Stores information about each prospect search execution,
-- including failures, error details, and execution status.
CREATE TABLE dbo.prospect_search_runs (
    search_id NVARCHAR(100) NOT NULL PRIMARY KEY,
    execution_id NVARCHAR(100) NOT NULL,

    industry NVARCHAR(100),
    location NVARCHAR(200),
    prospect_type NVARCHAR(100),
    ideal_customer_type NVARCHAR(500),
    failed_node NVARCHAR(100),

    error_type NVARCHAR(100),
    error_message NVARCHAR(MAX),

    status NVARCHAR(50) NOT NULL DEFAULT 'running',
    created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    updated_at DATETIME2 
);
GO


-- Stores prospects that need manual review,
-- such as records with missing information or failed website requests.
CREATE TABLE dbo.prospect_review_queue (
    review_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    search_id NVARCHAR(100),

    osm_id NVARCHAR(100),
    source NVARCHAR(50),
    name NVARCHAR(255),
    industry NVARCHAR(100),
    location NVARCHAR(200),
    ideal_customer_type NVARCHAR(500),

    address NVARCHAR(MAX) DEFAULT NULL,
    website NVARCHAR(500) DEFAULT NULL,
    phone NVARCHAR(100) DEFAULT NULL,
    email NVARCHAR(255) DEFAULT NULL,
    osm_url NVARCHAR(500),

    data_quality NVARCHAR(100),
    processing_stage NVARCHAR(100),
    review_reason NVARCHAR(100),

    error_type NVARCHAR(100),
    error_message NVARCHAR(MAX),

    created_at DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

