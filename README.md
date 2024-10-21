# Mojo's libc support

## Getting Started

The only dependency for `libc` is Mojo.

You can install Mojo following the instructions from the [Modular website](https://www.modular.com/max/mojo).

Once you have created a Mojo project using the `magic` tool,

1. Add the `mojo-community` channel to your `mojoproject.toml`, e.g:
   ```toml
   [project]
   channels = ["conda-forge", "https://conda.modular.com/max", "https://repo.prefix.dev/mojo-community"]
   ```
2. Add `libc` as a dependency:
   ```toml
   [dependencies]
   libc = ">=0.1.3"
   ```
3. Run `magic install` at the root of your project, where `mojoproject.toml` is located
4. `libc` should now be installed as a dependency. You can import libc functions from the library, e.g:
    ```mojo
    from libc import socket
    ```

## Supported Functionality

### Basic socket connections

See the examples in [examples/sockets/](examples/sockets/) directory.

### Basic file system operations

See the examples in [examples/files/](examples/files/) directory.
## Building the project

To build the project, execute the following command:

```bash
./scripts/build.sh
```

## Running the tests

To run the tests, execute the following command:

```bash
./scripts/run-tests.sh
```
