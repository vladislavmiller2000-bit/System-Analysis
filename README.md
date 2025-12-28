# 📊 System Analysis: Database Design for "Накарабине" E-commerce

This repository contains a comprehensive database system analysis and design project for an e-commerce platform specializing in clothing ("Накарабине" brand).

## 🎯 Project Overview

This is a complete **database modeling and normalization** project that includes:
- Entity-Relationship (ER) models in multiple notations (Chen, Crow's Foot)
- Detailed normalization from 1НФ through 3НФ
- Complete validation and documentation
- SVG diagrams ready for diagrams.net

## 📋 Content Structure

### 📐 ER Models & Notations
- `chen_diagram.svg` - Chen notation initial model
- `chen_diagram_full.svg` - Chen notation with all notation elements
- `chen_diagram_instructions.md` - How to interpret Chen notation
- `chen_diagram_detailed.md` - Comprehensive Chen notation theory
- `crows_foot_diagram.svg` - Crow's Foot physical model
- `crows_foot_detailed.md` - Crow's Foot notation explanation
- `crows_foot_tables.md` - Table specifications with SQL

### 🔄 Normalization Documentation
- `plan_normalization.md` - Complete normalization plan with all stages
- `normalization_stages.md` - Step-by-step normalization (1НФ → 2НФ → 3НФ)
- `normalization_theory.md` - Theory of normal forms with examples
- `normalization_analysis.md` - Analysis against each normal form
- `normalization_review.md` - Detailed analysis of violations and solutions

### ✅ Validation & Verification
- `crows_foot_validation.md` - Validates naming, keys, relationships, cardinality

### 🎨 Final Diagrams
- `final_diagram_3nf.svg` - Final 3NF model (initial version)
- `final_diagram_3nf_corrected.svg` - Final 3NF model (corrected with all fixes)

## 🗄️ Final Database Schema (3НФ)

### 5 Tables:

**1. ЗАКАЗ (Orders)**
**2. ТОВАР (Products)**
**3. ТОВАР_В_ЗАКАЗЕ (Order Items)**
**4. СВЕДЕНИЯ_О_ДОСТАВКЕ (Delivery Info)**
**5. АДРЕС (Addresses)**

## �� Project Status

✅ **COMPLETE** - All analysis, modeling, normalization, and validation completed.

**Created**: December 28, 2025  
**Subject**: Database System Analysis & Design  
**Platform**: E-commerce System - "Накарабине"
