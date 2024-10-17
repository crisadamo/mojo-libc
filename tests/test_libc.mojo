from memory import UnsafePointer
from testing import assert_equal, assert_not_equal, assert_raises
from pathlib import Path, _dir_of_current_file

from libc import (
    AF_INET,
    SOCK_STREAM,
    SOCK_DGRAM,
    AI_PASSIVE,
    addrinfo,
    c_char,
    c_charptr_to_string,
    c_int,
    external_call,
    gai_strerror,
    getaddrinfo,
    to_char_ptr,
)


fn test_getaddrinfo() raises:
    var host = String("127.0.0.1")
    var host_ptr = to_char_ptr(host)
    var my_addrinfo = rebind[addrinfo](addrinfo())
    var servinfo = UnsafePointer[addrinfo]().alloc(1)
    servinfo.init_pointee_move(my_addrinfo)

    var hints = rebind[addrinfo](addrinfo())
    hints.ai_family = AF_INET
    hints.ai_socktype = SOCK_STREAM
    hints.ai_flags = AI_PASSIVE

    var error = getaddrinfo(
        host_ptr,
        UnsafePointer[Byte](),
        UnsafePointer.address_of(hints),
        UnsafePointer.address_of(servinfo),
    )
    assert_equal(error, 0, "getaddrinfo failed")

    var addrinfo = servinfo[]

    var ai_addr = addrinfo.ai_addr
    assert_not_equal(ai_addr, ai_addr, "ai_addr is null")


fn run() raises:
    test_getaddrinfo()
