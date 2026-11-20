# Reproduce the CI scenario

Run `go test ./...` and `mvn -B clean verify` from the repository root. For the hosted checks, follow the Go and Java runs for the default-branch push. Their downstream jobs download and exercise the artifacts from the same run. For a cold-cache check, use a fresh dependency cache key and rerun the successful push to confirm the same key is restored. Manually dispatched runs disable the dependency cache.
