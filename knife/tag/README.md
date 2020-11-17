# Async chef node tagging with knife
## How to tag
1. Update the node list in the relevant `node_list` file.
1. Run the [tag_nodes.sh](./tag_nodes.sh) script with the tag you want to apply to your nodes as an argument, e.g.:
```
./tag_nodes.sh 'my_tag'
```

## Conventions for node lists
The node list is very simple and needs to consist only of the chef `node name` of the servers you want to tag. For example:
```
node_list=(
    'mynode0'
    'mynode1'
    'mynode2'
)
```

## Pre-requisities
 - You will need to install the chef knife CLI.
 - You will need to have knife configured to communicate with your chef server.

## Roadmap
 - Allow users to specify per node tags.
