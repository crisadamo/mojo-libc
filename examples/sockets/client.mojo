from memory import UnsafePointer
from utils import StaticTuple

from libc import (
    AF_INET,
    AI_PASSIVE,
    SOCK_STREAM,
    SHUT_RDWR,
    addrinfo,
    c_char,
    connect,
    getaddrinfo,
    htons,
    in_addr,
    sizeof,
    sockaddr,
    sockaddr_in,
    socket,
    shutdown,
)


fn get_ip_address(host: String) raises -> in_addr:
    var host_ptr = host.unsafe_cstr_ptr()
    var my_addrinfo = addrinfo()
    var servinfo = UnsafePointer[addrinfo]().alloc(1)
    servinfo.init_pointee_move(my_addrinfo)

    var hints = addrinfo()
    hints.ai_family = AF_INET
    hints.ai_socktype = SOCK_STREAM
    hints.ai_flags = AI_PASSIVE

    var error = getaddrinfo(
        host_ptr,
        UnsafePointer[c_char](),
        UnsafePointer.address_of(hints),
        UnsafePointer.address_of(servinfo),
    )
    if error != 0:
        raise Error("getaddrinfo failed: {}".format(error))

    var addrinfo = servinfo[]
    var ai_addr = addrinfo.ai_addr

    return ai_addr.bitcast[sockaddr_in]()[].sin_addr


fn main() raises:
    var ip: in_addr
    var host = "localhost"
    var port = 8080
    print("Connecting to ", host, " on port ", port)

    ip = get_ip_address(host)

    # Convert ip address to network byte order.
    var addr: sockaddr_in = sockaddr_in(
        AF_INET, htons(port), ip, StaticTuple[c_char, 8](0, 0, 0, 0, 0, 0, 0, 0)
    )
    var addr_ptr = UnsafePointer[sockaddr_in].address_of(addr).bitcast[sockaddr]()
    var sock = socket(AF_INET, SOCK_STREAM, 0)

    if connect(sock, addr_ptr, sizeof[sockaddr_in]()) == -1:
        print("Failed to connect to server")
    else:
        print("Connected to server")

    _ = shutdown(sock, SHUT_RDWR)
