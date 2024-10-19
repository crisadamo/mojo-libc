# Mojo's libc support

> Note: its a work in progress. Variadic syscall not working at the moment.

## Supported Functionality
### Basic socket connections

To test the socket functionality there are two functions:
- `__test_socket_server__` that start listening for connections on 127.0.0.1:8083 and once a client connects it send the `"Hello, Mojo!"` message.
- `__test_socket_client__` that connects to 127.0.0.1:8083 send the message `"Hello, world Server"` and prints the reply from the server.

In order to test it you need to create two notebooks, on the first one you need to run the `__test_socket_server__()` and then on the second one run `__test_socket_client__()`.


### Basic file system operations
Example [here](https://github.com/crisadamo/mojo-libc/blob/main/Libc.mojo#L1636)

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
