-- ==========================================================
-- Author      : Sahil Darji
-- Project     : Project Velox
-- File        : 01_create_database.sql
-- Purpose     : Create Database for Project Velox
-- ==========================================================

DROP DATABASE IF EXISTS project_velox;

CREATE DATABASE project_velox;

-- ==========================================================
-- Validate Database Creation
-- ==========================================================

show databases;

-- ==========================================================
-- Use the Project Velox Database
-- ==========================================================

USE project_velox;

-- ==========================================================
-- Validate Database Selection
-- ==========================================================

SELECT DATABASE();