package migrations

import (
	"database/sql"
	"log"
)

// v5.1.0 adds support for multiple senders and sending strategies
func v5_1_0(db *sql.DB) error {
	log.Println("Applying v5.1.0 migration...")

	// Add new columns for multiple senders support
	if _, err := db.Exec(`
		ALTER TABLE campaigns 
		ADD COLUMN IF NOT EXISTS from_emails TEXT[] DEFAULT '{}'::TEXT[],
		ADD COLUMN IF NOT EXISTS from_emails_strategy TEXT DEFAULT 'roundrobin'::TEXT;
	`); err != nil {
		return err
	}

	return nil
} 