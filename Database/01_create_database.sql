-- ===========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- Database    : MySQL 8.0.43
-- Created On  : 06-Jul-2026
-- ===========================================================

-- ===========================================================
-- Project Velox
-- Database Initialization Script
-- ===========================================================
-- Purpose:
-- Creates the Project Velox database with UTF-8 encoding,
-- Unicode collation, and prepares the environment for all
-- subsequent schema creation scripts.
--
-- Execution Order:
-- 1. Run this script first.
-- 2. Then execute 02_create_tables.sql.
-- ===========================================================

DROP DATABASE IF EXISTS velox_db;

CREATE DATABASE velox_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE velox_db;