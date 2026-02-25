#!/bin/bash
# ============================================
# Restaurant Analysis — Quick Run Script
# ============================================
# This script creates a SQLite database, loads data,
# and runs all 20 analytical queries with readable output.
# Usage: ./run_analysis.sh
# ============================================

set -e

DB="restaurant.db"
SQL="restaurant_analysis.sql"

echo "================================================="
echo "  Restaurant Sales Analysis — SQL Project"
echo "  Vladislav Orekhov-Miller"
echo "================================================="
echo ""

# Check sqlite3
if ! command -v sqlite3 &> /dev/null; then
    echo "ERROR: sqlite3 is not installed."
    echo "Install: sudo apt install sqlite3  (Linux)"
    echo "         brew install sqlite        (macOS)"
    exit 1
fi

# Remove old DB if exists
rm -f "$DB"

echo "Creating database and loading data..."
sqlite3 "$DB" < "$SQL"

echo "Done! Database has:"
sqlite3 "$DB" "SELECT 'menu_items: ' || COUNT(*) FROM menu_items;"
sqlite3 "$DB" "SELECT 'orders:     ' || COUNT(*) FROM orders;"
sqlite3 "$DB" "SELECT 'order_items: ' || COUNT(*) FROM order_items;"

echo ""
echo "================================================="
echo "  To explore interactively:"
echo "  sqlite3 $DB"
echo ""
echo "  Example queries:"
echo "  SELECT * FROM menu_items LIMIT 5;"
echo "  SELECT * FROM orders LIMIT 5;"
echo "  .tables"
echo "  .schema"
echo "  .quit"
echo "================================================="
