# test-declarative-proj-src
Declarative local creation of Hydra jobsets   

Main job "simple-program" (`jobs/release.nix`) is not local. It is pulled remotely so local changes to `jobs/release.nix` will not be registered by Hydra   

## Install
1. Create linux/nixos hydra user 
    - Generally not needed, but here paths are absolute (/home/hydra/test-declarative-proj-src) since relative paths (./) are not possible in hydra's spec.json 
    - Alternatively edit local paths in spec.json 

2. Clone this project in`/home/hydra`

3. Create postgresql user hydra and db hydra (owned by hydra) 
    - Set env var `$HYDRA_DBI` to `dbi:Pg:dbname=hydra;host=localhost;user=hydra;`   

4. Create hydra user like described in https://nixos.org/hydra/manual/

5. Login with hydra user in localhost:3000
    -  Admin -> Create Project 
        - Set enable to true
        - Choose name and description
        - Set Declarative spec file to `spec.json`
        - Set Declarative input type to `Local path` and value to spec.json directory (`/home/hydra/test-declarative-proj-src`)

6. Start `hydra-evaluator` and `hydra-queue-runner` in separate shells 

7. Jobsets should start appear in localhost:3000 interface 
    - First .jobsets` jobset, then trivial jobsets after .jobsets is evalueted and built  


