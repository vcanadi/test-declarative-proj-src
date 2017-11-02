# test-declarative-proj-src
Declarative local creation of Hydra jobsets   

1 create linux/nixos hydra user 
  generally not needed, but here paths are absolute (/home/hydra/test-declarative-proj-src) since relative paths (./) are not possible in hydra's spec.json 
  alternatively edit local paths in spec.json 

2 clone this project in`/home/hydra`

3 create postgresql user hydra and db hydra (owned by hydra) 
  set env var `$HYDRA_DBI` to `dbi:Pg:dbname=hydra;host=localhost;user=hydra;`   

4 create hydra user like described in [https://nixos.org/hydra/manual/]

5 login with hydra user in localhost:3000
  Admin -> Create Project 
    set enable to true
    choose name and description
    set Declarative spec file to `spec.json`
    set Declarative input type to `Local path` and value to spec.json directory (`/home/hydra/test-declarative-proj-src`)

6 start `hydra-evaluator` and `hydra-queue-runner` in separate shells 

7 jobsets should start appear in localhost:3000 interface 
  first initial `.jobsets` jobset then trivial jobsets after .jobsets is evalueted and built  


