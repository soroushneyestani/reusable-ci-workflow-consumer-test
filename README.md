# Reusable CI workflow release smoke consumer

This synthetic application exercises the Go and Java workflows in the [Reusable CI Workflow Toolkit](https://github.com/soroushneyestani/reusable-ci-workflow-toolkit). Use this layout in a separate approved public consumer repository once the toolkit is public. Keep Go and Maven source, tests, both workflow files, and the license notices at the root.

## Preflight using the release candidate commit

Set the reference to the full public toolkit commit SHA recorded for the candidate. The helper updates all three reusable workflow calls and accepts only one full Git commit SHA or the exact supported release tag.

```powershell
$ref = Read-Host 'Verified public toolkit commit SHA'
pwsh -NoProfile -File ./set-toolkit-ref.ps1 -Ref $ref
```

Push this layout to the approved consumer's default branch once. Record the consumer commit and both workflow runs.

## Acceptance using the released tag

The prepared layout uses the literal `@v0.1.0` tag. If the consumer was used for preflight, switch its workflows to the release tag after verifying that it resolves to the accepted toolkit commit.

```powershell
pwsh -NoProfile -File ./set-toolkit-ref.ps1 -Ref v0.1.0
```

Push the verified caller revision and confirm Go on Ubuntu 24.04 and Windows Server 2025, and Java 21 with Maven on Ubuntu 24.04. Both workflows check outputs, download the artifacts from the same run, and execute them to verify the greeting. They request read-only repository contents and emit cache status. For each public run, check the [workflow run API result](https://docs.github.com/en/rest/actions/workflow-runs#get-a-workflow-run). Confirm the declared reusable workflow path points to the expected public repository and reference, and its resolved SHA matches the accepted toolkit commit.

[Go workflow](.github/workflows/go-consumer.yml) · [Java workflow](.github/workflows/java-consumer.yml) · [MIT license](LICENSE) · [Third-party notices](THIRD_PARTY_NOTICES.md)

The Go executable artifacts use the Go runtime and Google UUID. Their license notices accompany the hosted binary downloads and are linked in successful Go job summaries. [Go 1.27.4 license](third-party-licenses/Go-1.27.4-LICENSE.txt) · [Google UUID 1.6.0 license](third-party-licenses/Google-UUID-1.6.0-LICENSE.txt)
