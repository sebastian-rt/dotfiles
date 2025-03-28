{pkgs, ...}: {
  home-manager.users.sebastian.home = {
    packages = with pkgs; [
      gh
    ];
    file = {
      ".config/gh/config.yml".text = ''
        # The current version of the config schema
        version: 1
        # What protocol to use when performing git operations. Supported values: ssh, https
        git_protocol: https
        # What editor gh should run when creating issues, pull requests, etc. If blank, will refer to environment.
        editor:
        # When to interactively prompt. This is a global config that cannot be overridden by hostname. Supported values: enabled, disabled
        prompt: enabled
        # Preference for editor-based interactive prompting. This is a global config that cannot be overridden by hostname. Supported values: enabled, disabled
        prefer_editor_prompt: disabled
        # A pager program to send command output to, e.g. "less". If blank, will refer to environment. Set the value to "cat" to disable the pager.
        pager:
        # Aliases allow you to create nicknames for gh commands
        aliases:
            co: pr checkout
        # The path to a unix socket through which send HTTP connections. If blank, HTTP traffic will be handled by net/http.DefaultTransport.
        http_unix_socket:
        # What web browser gh should use when opening URLs. If blank, will refer to environment.
        browser:
      '';

      ".config/gh/hosts.yml".text = ''
        github.com:
            git_protocol: ssh
            users:
                sebastian-rt:
            user: sebastian-rt
      '';
    };
  };
}
