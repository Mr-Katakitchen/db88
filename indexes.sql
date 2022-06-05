DROP INDEX IF EXISTS idx_birthdate ON researcher;
DROP INDEX IF EXISTS idx_ends_on ON project;
DROP INDEX IF EXISTS idx_started_on ON project;

CREATE INDEX idx_birthdate ON researcher(birthdate);
CREATE INDEX idx_ends_on ON project(ends_on);
CREATE INDEX idx_started_on ON project(started_on);
