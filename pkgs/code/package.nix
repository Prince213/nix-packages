{
  fetchFromGitHub,
  gitMinimal,
  lib,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "code";
  version = "0.2.188";

  src = fetchFromGitHub {
    owner = "just-every";
    repo = "code";
    tag = "v${finalAttrs.version}";
    hash = "sha256-xUhgA4poybzFehVgVWHKx1ejhncvYAnug2oxLwGNrk0=";
  };

  sourceRoot = "${finalAttrs.src.name}/code-rs";

  cargoHash = "sha256-wQHcwfBJE/qGXHgLDQ1NfBpgFdmQhuHCvfAG8KV+MHM=";

  cargoBuildFlags = [
    "--bin"
    "code"
    "--bin"
    "code-tui"
    "--bin"
    "code-exec"
  ];

  nativeCheckInputs = [
    gitMinimal
  ];

  checkFlags = [
    # pty_error: No such file or directory (os error 2)
    "--skip=exec_command::session_manager::tests::session_manager_streams_and_truncates_from_now"
    "--skip=unified_exec::tests::multi_unified_exec_sessions"
    "--skip=unified_exec::tests::reusing_completed_session_returns_unknown_session"
    "--skip=unified_exec::tests::unified_exec_persists_across_requests_jif"
    "--skip=unified_exec::tests::unified_exec_timeouts"
  ];

  postInstall = ''
    ln -s $out/bin/code $out/bin/coder
  '';

  meta = {
    description = "Fast, effective, mind-blowing, coding CLI";
    homepage = "https://github.com/just-every/code";
    downloadPage = "https://github.com/just-every/code/releases";
    changelog = "https://github.com/just-every/code/releases/tag/${finalAttrs.src.tag}";
    license = with lib.licenses; [
      asl20
      mit
    ];
    maintainers = with lib.maintainers; [ prince213 ];
    mainProgram = "code";
  };
})
