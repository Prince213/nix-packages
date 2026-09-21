{
  name = "hydro-standalone-judge";

  containers = {
    machine = { config, ... }: {
      imports = import ../modules/module-list.nix;

      services.hydro = {
        enable = true;
        database.createLocally = true;
      };

      services.caddy = {
        enable = true;
        openFirewall = true;
        virtualHosts."http://".extraConfig = ''
          reverse_proxy 127.0.0.1:${toString config.services.hydro.port}
        '';
      };
    };
    judge = {
      imports = import ../modules/module-list.nix;

      services.hydro-judge = {
        enable = true;
        settings = {
          hosts = {
            primary = {
              type = "hydro";
              server_url = "http://machine";
              uname = "judge";
              password = "password";
            };
          };
        };
      };
    };
  };

  testScript = ''
    import json
    import shlex

    def hydro_json(expression):
        script = f"return JSON.stringify(await ({expression}))"
        output = machine.succeed(f"hydrooj cli execute {shlex.quote(script)}")
        return json.loads(output)

    machine.wait_for_unit("default.target")
    machine.wait_until_succeeds("curl http://localhost | grep 'Hydro is running normally'")

    uid = hydro_json('UserModel.create("alice@example.com", "alice", "password", 2)')
    t.assertEqual(uid, 2)

    uid = hydro_json('UserModel.create("judge@example.com", "judge", "password", 3)')
    t.assertEqual(uid, 3)

    machine.succeed("hydrooj cli user setJudge 3")

    judge.wait_for_unit("default.target")

    src = """\
      #include <stdio.h>
      int main() {
        int a, b;
        scanf("%d%d", &a, &b);
        printf("%d\\\\n", a + b);
      }
    """

    record_id = hydro_json(f'RecordModel.add("system", 1, 2, "c", `{src}`, true)')
    record = hydro_json(
        f'RecordModel.get("system", new ObjectId({json.dumps(record_id)}))'
    )

    t.assertEqual(record["_id"], record_id)
    t.assertEqual(record["score"], 100)
  '';
}
