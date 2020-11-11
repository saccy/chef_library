# Bootstrapping
Use this code to bootstrap nodes with the chef infra client. You can specify SSH or password authentication, though SSH is highly recommended when bootstrapping.

# Requirements
1. Populate a JSON file with the information required to bootstrap your node(s). Follow the `./node_list_example.json` file as an example of the required information.
1. Identify the private SSH key or password file you will be using to authenticate with your nodes. Password file must contain *only* the plain text password.
1. Identify the user you will be using to authenticate with your nodes.
1. You will need `jq` installed.
1. You will need to have `knife` configured. https://docs.chef.io/workstation/knife_setup/.
1. You can use the [chef workstation container](../workstation/docker/Dockerfile) defined in this repo to make life easier.

# To use the bootstrap_nodes.sh script
 - `./bootstrap_nodes.sh -h` will print a help message.
 - See `./node_list_example.json` for an example of how to format the node JSON file.
 - Currently, policy group and policy are required fields within the node JSON file.

```
usage: ./bootstrap_nodes.sh -c [ssh||pw] -u <user> -f </path/to/creds/file> -n </path/to/nodes.json>
  -c <connection> SSH or user:password
  -u <user> The user to authenticate as
  -f <credentials file> Path to SSH file or a file containing password
  -n <nodes JSON file> Path to JSON file containing node information
  -h <help> Display this message
example: ./bootstrap_nodes.sh -c ssh -u john -f ~/.ssh/private_key -n /nodes.json
example: ./bootstrap_nodes.sh -c pw -u mary -f ~/.creds/password -n /nodes.json
```

# Limitations
 - Linux only
 - No option to specify client version - the latest chef client version will be installed
 - Policy group required
 - Policy required

# Roadmap
 - Windows support
 - Async bootstrapping
 - Optional policy/policy group
