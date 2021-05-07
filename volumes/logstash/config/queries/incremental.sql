SELECT
	j.journal_id, j.action_type, j.isbn,
	b.title, b.authors, b.publication_date
FROM prestamos.libros_journal j
LEFT JOIN prestamos.libros b ON b.isbn = j.isbn
WHERE j.journal_id > :sql_last_value
	AND j.action_time < NOW()
ORDER BY j.journal_id