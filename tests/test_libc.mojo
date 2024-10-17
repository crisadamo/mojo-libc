from memory import UnsafePointer
from testing import assert_equal, assert_not_equal, assert_raises
from pathlib import Path, _dir_of_current_file

from libc import (
    AF_INET,
    AI_PASSIVE,
    SOCK_DGRAM,
    SOCK_STREAM,
    addrinfo,
    c_char,
    c_charptr_to_string,
    c_int,
    cftob,
    external_call,
    gai_strerror,
    getaddrinfo,
    inet_pton,
    strlen,
    to_char_ptr,
)


fn test_to_char_ptr() raises:
    var s = String("Hello world")
    var ptr = to_char_ptr(s)
    var reconstructed_s = c_charptr_to_string(ptr)
    assert_equal(reconstructed_s, s, "to_char_ptr failed to convert string properly")


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


fn test_strlen() raises:
    var s = String("Hello, world!")
    var ptr = to_char_ptr(s)
    var length = strlen(ptr)
    assert_equal(length, len(s), "strlen returned incorrect length")


fn test_cftob() raises:
    assert_equal(cftob(1), True, "cftob failed for value 1")
    assert_equal(cftob(0), False, "cftob failed for value 0")
    assert_equal(cftob(-1), False, "cftob failed for value -1")
    assert_equal(cftob(100), True, "cftob failed for value 100")


# fn test_inet_pton() raises:
#     var ip_str = String("127.0.0.1")
#     var result = inet_pton(AF_INET, ip_str)
#     assert_equal(result, 0x7F000001, "inet_pton failed to convert IP address")


fn run() raises:
    # test_getaddrinfo()
    test_strlen()
    test_cftob()
    test_to_char_ptr()
    # test_inet_pton()
