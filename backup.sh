#! /bin/sh
set -e

_year=$(date +"%Y")
_month=$(date +"%m")

echo "Creating backup of ${PGDATABASE} database..."

pg_dump | gzip > backup.sql.gz

echo "Uploading backup to ${S3_BUCKET}"

s3cmd -c /config/.s3cfg put backup.sql.gz s3://${S3_BUCKET}/$_year/$_month/${PGDATABASE}_$(date +"%Y-%m-%dT%H:%M:%SZ").sql.gz || exit 2

echo "Postgres backup uploaded successfully"