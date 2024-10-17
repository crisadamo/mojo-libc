from memory import memcpy, Pointer, UnsafePointer
from sys.ffi import external_call
from sys.info import sizeof
from utils import StaticTuple

alias IPPROTO_IPV6 = 41
alias IPV6_V6ONLY = 26
alias EPROTONOSUPPORT = 93

# Adapted from https://github.com/gabrieldemarmiesse/mojo-stdlib-extensions/ . Huge thanks to Gabriel!

alias FD_STDIN: c_int = 0
alias FD_STDOUT: c_int = 1
alias FD_STDERR: c_int = 2

alias SUCCESS = 0
alias GRND_NONBLOCK: UInt8 = 1

alias char_UnsafePointer = UnsafePointer[c_char]

# Adapted from https://github.com/crisadamo/mojo-Libc . Huge thanks to Cristian!
# C types
alias c_void = UInt8
alias c_char = UInt8
alias c_schar = Int8
alias c_uchar = UInt8
alias c_short = Int16
alias c_ushort = UInt16
alias c_int = Int32
alias c_uint = UInt32
alias c_long = Int64
alias c_ulong = UInt64
alias c_float = Float32
alias c_double = Float64

# `Int` is known to be machine's width
alias c_size_t = Int
alias c_ssize_t = Int

alias ptrdiff_t = Int64
alias intptr_t = Int64
alias uintptr_t = UInt64

# --- ( error.h Constants )-----------------------------------------------------
alias EPERM = 1
alias ENOENT = 2
alias ESRCH = 3
alias EINTR = 4
alias EIO = 5
alias ENXIO = 6
alias E2BIG = 7
alias ENOEXEC = 8
alias EBADF = 9
alias ECHILD = 10
alias EAGAIN = 11
alias ENOMEM = 12
alias EACCES = 13
alias EFAULT = 14
alias ENOTBLK = 15
alias EBUSY = 16
alias EEXIST = 17
alias EXDEV = 18
alias ENODEV = 19
alias ENOTDIR = 20
alias EISDIR = 21
alias EINVAL = 22
alias ENFILE = 23
alias EMFILE = 24
alias ENOTTY = 25
alias ETXTBSY = 26
alias EFBIG = 27
alias ENOSPC = 28
alias ESPIPE = 29
alias EROFS = 30
alias EMLINK = 31
alias EPIPE = 32
alias EDOM = 33
alias ERANGE = 34
alias EWOULDBLOCK = EAGAIN

alias Bytes = List[Byte, True]


fn to_char_ptr(s: String) -> UnsafePointer[c_char]:
    """Only ASCII-based strings."""
    var ptr = UnsafePointer[c_char]().alloc(len(s) + 1)
    for i in range(len(s)):
        ptr[i] = ord(s[i])
    # Null-terminate the string
    ptr[len(s)] = 0
    return ptr


fn to_char_ptr(s: Bytes) -> UnsafePointer[c_char]:
    var ptr = UnsafePointer[c_char]().alloc(len(s))
    for i in range(len(s)):
        ptr[i] = int(s[i])
    return ptr


fn c_charptr_to_string(s: UnsafePointer[c_char]) -> String:
    return String(s.bitcast[Byte](), strlen(s))


fn cftob(val: c_int) -> Bool:
    """Convert C-like failure (-1) to Bool."""
    return rebind[Bool](val > 0)


# --- ( Network Related Constants )---------------------------------------------
alias sa_family_t = c_ushort
alias socklen_t = c_uint
alias in_addr_t = c_uint
alias in_port_t = c_ushort

# Address Family Constants
alias AF_UNSPEC = 0
alias AF_UNIX = 1
alias AF_LOCAL = AF_UNIX
alias AF_INET = 2
alias AF_AX25 = 3
alias AF_IPX = 4
alias AF_APPLETALK = 5
alias AF_NETROM = 6
alias AF_BRIDGE = 7
alias AF_ATMPVC = 8
alias AF_X25 = 9
alias AF_INET6 = 10
alias AF_ROSE = 11
alias AF_DECnet = 12
alias AF_NETBEUI = 13
alias AF_SECURITY = 14
alias AF_KEY = 15
alias AF_NETLINK = 16
alias AF_ROUTE = AF_NETLINK
alias AF_PACKET = 17
alias AF_ASH = 18
alias AF_ECONET = 19
alias AF_ATMSVC = 20
alias AF_RDS = 21
alias AF_SNA = 22
alias AF_IRDA = 23
alias AF_PPPOX = 24
alias AF_WANPIPE = 25
alias AF_LLC = 26
alias AF_CAN = 29
alias AF_TIPC = 30
alias AF_BLUETOOTH = 31
alias AF_IUCV = 32
alias AF_RXRPC = 33
alias AF_ISDN = 34
alias AF_PHONET = 35
alias AF_IEEE802154 = 36
alias AF_CAIF = 37
alias AF_ALG = 38
alias AF_NFC = 39
alias AF_VSOCK = 40
alias AF_KCM = 41
alias AF_QIPCRTR = 42
alias AF_MAX = 43

alias PF_UNSPEC = AF_UNSPEC
alias PF_UNIX = AF_UNIX
alias PF_LOCAL = AF_LOCAL
alias PF_INET = AF_INET
alias PF_AX25 = AF_AX25
alias PF_IPX = AF_IPX
alias PF_APPLETALK = AF_APPLETALK
alias PF_NETROM = AF_NETROM
alias PF_BRIDGE = AF_BRIDGE
alias PF_ATMPVC = AF_ATMPVC
alias PF_X25 = AF_X25
alias PF_INET6 = AF_INET6
alias PF_ROSE = AF_ROSE
alias PF_DECnet = AF_DECnet
alias PF_NETBEUI = AF_NETBEUI
alias PF_SECURITY = AF_SECURITY
alias PF_KEY = AF_KEY
alias PF_NETLINK = AF_NETLINK
alias PF_ROUTE = AF_ROUTE
alias PF_PACKET = AF_PACKET
alias PF_ASH = AF_ASH
alias PF_ECONET = AF_ECONET
alias PF_ATMSVC = AF_ATMSVC
alias PF_RDS = AF_RDS
alias PF_SNA = AF_SNA
alias PF_IRDA = AF_IRDA
alias PF_PPPOX = AF_PPPOX
alias PF_WANPIPE = AF_WANPIPE
alias PF_LLC = AF_LLC
alias PF_CAN = AF_CAN
alias PF_TIPC = AF_TIPC
alias PF_BLUETOOTH = AF_BLUETOOTH
alias PF_IUCV = AF_IUCV
alias PF_RXRPC = AF_RXRPC
alias PF_ISDN = AF_ISDN
alias PF_PHONET = AF_PHONET
alias PF_IEEE802154 = AF_IEEE802154
alias PF_CAIF = AF_CAIF
alias PF_ALG = AF_ALG
alias PF_NFC = AF_NFC
alias PF_VSOCK = AF_VSOCK
alias PF_KCM = AF_KCM
alias PF_QIPCRTR = AF_QIPCRTR
alias PF_MAX = AF_MAX

# Socket Type constants
alias SOCK_STREAM = 1
alias SOCK_DGRAM = 2
alias SOCK_RAW = 3
alias SOCK_RDM = 4
alias SOCK_SEQPACKET = 5
alias SOCK_DCCP = 6
alias SOCK_PACKET = 10
alias SOCK_CLOEXEC = O_CLOEXEC
alias SOCK_NONBLOCK = O_NONBLOCK

# Address Information
alias AI_PASSIVE = 1
alias AI_CANONNAME = 2
alias AI_NUMERICHOST = 4
alias AI_V4MAPPED = 8
alias AI_ALL = 16
alias AI_ADDRCONFIG = 32
alias AI_IDN = 64

alias INET_ADDRSTRLEN = 16
alias INET6_ADDRSTRLEN = 46

alias SHUT_RD = 0
alias SHUT_WR = 1
alias SHUT_RDWR = 2

alias SOL_SOCKET = 1

alias SO_DEBUG = 1
alias SO_REUSEADDR = 2
alias SO_TYPE = 3
alias SO_ERROR = 4
alias SO_DONTROUTE = 5
alias SO_BROADCAST = 6
alias SO_SNDBUF = 7
alias SO_RCVBUF = 8
alias SO_KEEPALIVE = 9
alias SO_OOBINLINE = 10
alias SO_NO_CHECK = 11
alias SO_PRIORITY = 12
alias SO_LINGER = 13
alias SO_BSDCOMPAT = 14
alias SO_REUSEPORT = 15
alias SO_PASSCRED = 16
alias SO_PEERCRED = 17
alias SO_RCVLOWAT = 18
alias SO_SNDLOWAT = 19
alias SO_RCVTIMEO = 20
alias SO_SNDTIMEO = 21
alias SO_RCVTIMEO_OLD = 20
alias SO_SNDTIMEO_OLD = 21
alias SO_SECURITY_AUTHENTICATION = 22
alias SO_SECURITY_ENCRYPTION_TRANSPORT = 23
alias SO_SECURITY_ENCRYPTION_NETWORK = 24
alias SO_BINDTODEVICE = 25
alias SO_ATTACH_FILTER = 26
alias SO_DETACH_FILTER = 27
alias SO_GET_FILTER = SO_ATTACH_FILTER
alias SO_PEERNAME = 28
alias SO_TIMESTAMP = 29
alias SO_TIMESTAMP_OLD = 29
alias SO_ACCEPTCONN = 30
alias SO_PEERSEC = 31
alias SO_SNDBUFFORCE = 32
alias SO_RCVBUFFORCE = 33
alias SO_PASSSEC = 34
alias SO_TIMESTAMPNS = 35
alias SO_TIMESTAMPNS_OLD = 35
alias SO_MARK = 36
alias SO_TIMESTAMPING = 37
alias SO_TIMESTAMPING_OLD = 37
alias SO_PROTOCOL = 38
alias SO_DOMAIN = 39
alias SO_RXQ_OVFL = 40
alias SO_WIFI_STATUS = 41
alias SCM_WIFI_STATUS = SO_WIFI_STATUS
alias SO_PEEK_OFF = 42
alias SO_NOFCS = 43
alias SO_LOCK_FILTER = 44
alias SO_SELECT_ERR_QUEUE = 45
alias SO_BUSY_POLL = 46
alias SO_MAX_PACING_RATE = 47
alias SO_BPF_EXTENSIONS = 48
alias SO_INCOMING_CPU = 49
alias SO_ATTACH_BPF = 50
alias SO_DETACH_BPF = SO_DETACH_FILTER
alias SO_ATTACH_REUSEPORT_CBPF = 51
alias SO_ATTACH_REUSEPORT_EBPF = 52
alias SO_CNX_ADVICE = 53
alias SCM_TIMESTAMPING_OPT_STATS = 54
alias SO_MEMINFO = 55
alias SO_INCOMING_NAPI_ID = 56
alias SO_COOKIE = 57
alias SCM_TIMESTAMPING_PKTINFO = 58
alias SO_PEERGROUPS = 59
alias SO_ZEROCOPY = 60
alias SO_TXTIME = 61
alias SCM_TXTIME = SO_TXTIME
alias SO_BINDTOIFINDEX = 62
alias SO_TIMESTAMP_NEW = 63
alias SO_TIMESTAMPNS_NEW = 64
alias SO_TIMESTAMPING_NEW = 65
alias SO_RCVTIMEO_NEW = 66
alias SO_SNDTIMEO_NEW = 67
alias SO_DETACH_REUSEPORT_BPF = 68


# --- ( Network Related Structs )-----------------------------------------------
@value
@register_passable("trivial")
struct in_addr:
    var s_addr: in_addr_t


@value
@register_passable("trivial")
struct in6_addr:
    var s6_addr: StaticTuple[c_char, 16]


@value
@register_passable("trivial")
struct sockaddr:
    var sa_family: sa_family_t
    var sa_data: StaticTuple[c_char, 14]


@value
@register_passable("trivial")
struct sockaddr_in:
    var sin_family: sa_family_t
    var sin_port: in_port_t
    var sin_addr: in_addr
    var sin_zero: StaticTuple[c_char, 8]


@value
@register_passable("trivial")
struct sockaddr_in6:
    var sin6_family: sa_family_t
    var sin6_port: in_port_t
    var sin6_flowinfo: c_uint
    var sin6_addr: in6_addr
    var sin6_scope_id: c_uint


@value
@register_passable("trivial")
struct addrinfo:
    var ai_flags: c_int
    var ai_family: c_int
    var ai_socktype: c_int
    var ai_protocol: c_int
    var ai_addrlen: socklen_t
    var ai_addr: UnsafePointer[sockaddr]
    var ai_canonname: UnsafePointer[c_char]
    var ai_next: UnsafePointer[c_void]

    fn __init__(inout self) -> None:
        self.ai_flags = 0
        self.ai_family = 0
        self.ai_socktype = 0
        self.ai_protocol = 0
        self.ai_addrlen = 0
        self.ai_addr = UnsafePointer[sockaddr]()
        self.ai_canonname = UnsafePointer[c_char]()
        self.ai_next = UnsafePointer[c_void]()


fn strlen(s: UnsafePointer[c_char]) -> c_size_t:
    """Libc POSIX `strlen` function
    Reference: https://man7.org/linux/man-pages/man3/strlen.3p.html
    Fn signature: size_t strlen(const char *s).

    Args: s: A UnsafePointer to a C string.
    Returns: The length of the string.
    """
    return external_call["strlen", c_size_t, UnsafePointer[c_char]](s)


# --- ( Network Related Syscalls & Structs )------------------------------------


fn htonl(hostlong: c_uint) -> c_uint:
    """Libc POSIX `htonl` function
    Reference: https://man7.org/linux/man-pages/man3/htonl.3p.html
    Fn signature: uint32_t htonl(uint32_t hostlong).

    Args: hostlong: A 32-bit integer in host byte order.
    Returns: The value provided in network byte order.
    """
    return external_call["htonl", c_uint, c_uint](hostlong)


fn htons(hostshort: c_ushort) -> c_ushort:
    """Libc POSIX `htons` function
    Reference: https://man7.org/linux/man-pages/man3/htonl.3p.html
    Fn signature: uint16_t htons(uint16_t hostshort).

    Args: hostshort: A 16-bit integer in host byte order.
    Returns: The value provided in network byte order.
    """
    return external_call["htons", c_ushort, c_ushort](hostshort)


fn ntohl(netlong: c_uint) -> c_uint:
    """Libc POSIX `ntohl` function
    Reference: https://man7.org/linux/man-pages/man3/htonl.3p.html
    Fn signature: uint32_t ntohl(uint32_t netlong).

    Args: netlong: A 32-bit integer in network byte order.
    Returns: The value provided in host byte order.
    """
    return external_call["ntohl", c_uint, c_uint](netlong)


fn ntohs(netshort: c_ushort) -> c_ushort:
    """Libc POSIX `ntohs` function
    Reference: https://man7.org/linux/man-pages/man3/htonl.3p.html
    Fn signature: uint16_t ntohs(uint16_t netshort).

    Args: netshort: A 16-bit integer in network byte order.
    Returns: The value provided in host byte order.
    """
    return external_call["ntohs", c_ushort, c_ushort](netshort)


fn inet_ntop(
    af: c_int,
    src: UnsafePointer[c_void],
    dst: UnsafePointer[c_char],
    size: socklen_t,
) -> UnsafePointer[c_char]:
    """Libc POSIX `inet_ntop` function
    Reference: https://man7.org/linux/man-pages/man3/inet_ntop.3p.html.
    Fn signature: const char *inet_ntop(int af, const void *restrict src, char *restrict dst, socklen_t size).

    Args:
        af: Address Family see AF_ aliases.
        src: A UnsafePointer to a binary address.
        dst: A UnsafePointer to a buffer to store the result.
        size: The size of the buffer.

    Returns:
        A UnsafePointer to the buffer containing the result.
    """
    return external_call[
        "inet_ntop",
        UnsafePointer[c_char],  # FnName, RetType
        c_int,
        UnsafePointer[c_void],
        UnsafePointer[c_char],
        socklen_t,  # Args
    ](af, src, dst, size)


fn inet_pton(
    af: c_int, src: UnsafePointer[c_char], dst: UnsafePointer[c_void]
) -> c_int:
    """Libc POSIX `inet_pton` function
    Reference: https://man7.org/linux/man-pages/man3/inet_ntop.3p.html
    Fn signature: int inet_pton(int af, const char *restrict src, void *restrict dst).

    Args: af: Address Family see AF_ aliases.
        src: A UnsafePointer to a string containing the address.
        dst: A UnsafePointer to a buffer to store the result.
    Returns: 1 on success, 0 if the input is not a valid address, -1 on error.
    """
    return external_call[
        "inet_pton",
        c_int,
        c_int,
        UnsafePointer[c_char],
        UnsafePointer[c_void],
    ](af, src, dst)


fn inet_addr(cp: UnsafePointer[c_char]) -> in_addr_t:
    """Libc POSIX `inet_addr` function
    Reference: https://man7.org/linux/man-pages/man3/inet_addr.3p.html
    Fn signature: in_addr_t inet_addr(const char *cp).

    Args: cp: A UnsafePointer to a string containing the address.
    Returns: The address in network byte order.
    """
    return external_call["inet_addr", in_addr_t, UnsafePointer[c_char]](cp)


fn inet_ntoa(addr: in_addr) -> UnsafePointer[c_char]:
    """Libc POSIX `inet_ntoa` function
    Reference: https://man7.org/linux/man-pages/man3/inet_addr.3p.html
    Fn signature: char *inet_ntoa(struct in_addr in).

    Args: in: A UnsafePointer to a string containing the address.
    Returns: The address in network byte order.
    """
    return external_call["inet_ntoa", UnsafePointer[c_char], in_addr](addr)


fn socket(domain: c_int, type: c_int, protocol: c_int) -> c_int:
    """Libc POSIX `socket` function
    Reference: https://man7.org/linux/man-pages/man3/socket.3p.html
    Fn signature: int socket(int domain, int type, int protocol).

    Args: domain: Address Family see AF_ aliases.
        type: Socket Type see SOCK_ aliases.
        protocol: The protocol to use.
    Returns: A File Descriptor or -1 in case of failure.
    """
    return external_call[
        "socket", c_int, c_int, c_int, c_int  # FnName, RetType  # Args
    ](domain, type, protocol)


fn setsockopt(
    socket: c_int,
    level: c_int,
    option_name: c_int,
    option_value: UnsafePointer[c_void],
    option_len: socklen_t,
) -> c_int:
    """Libc POSIX `setsockopt` function
    Reference: https://man7.org/linux/man-pages/man3/setsockopt.3p.html
    Fn signature: int setsockopt(int socket, int level, int option_name, const void *option_value, socklen_t option_len).

    Args: socket: A File Descriptor.
        level: The protocol level.
        option_name: The option to set.
        option_value: A UnsafePointer to the value to set.
        option_len: The size of the value.
    Returns: 0 on success, -1 on error.
    """
    return external_call[
        "setsockopt",
        c_int,  # FnName, RetType
        c_int,
        c_int,
        c_int,
        UnsafePointer[c_void],
        socklen_t,  # Args
    ](socket, level, option_name, option_value, option_len)


fn fcntl(fd: c_int, cmd: c_int, arg: c_int = 0) -> c_int:
    """Libc POSIX `fcntl` function
    Reference: https
    Fn signature: int fcntl(int fd, int cmd, int arg).

    Args: fd: A File Descriptor.
        cmd: The command to execute.
        arg: The argument for the command.
    Returns: The result of the command.
    """
    return external_call["fcntl", c_int, c_int, c_int, c_int](fd, cmd, arg)


fn getsockopt(
    socket: c_int,
    level: c_int,
    option_name: c_int,
    option_value: UnsafePointer[c_void],
    option_len: UnsafePointer[socklen_t],
) -> c_int:
    """Libc POSIX `getsockopt` function.

    Reference: https://man7.org/linux

    Args: socket: A File Descriptor.
        level: The protocol level.
        option_name: The option to get.
        option_value: A UnsafePointer to the value to get.
        option_len: A UnsafePointer to the size of the value.
    Returns: 0 on success, -1 on error.
    """
    return external_call[
        "getsockopt",
        c_int,  # FnName, RetType
        c_int,
        c_int,
        c_int,
        UnsafePointer[c_void],
        UnsafePointer[socklen_t],  # Args
    ](socket, level, option_name, option_value, option_len)


fn getsockname(
    socket: c_int,
    address: UnsafePointer[sockaddr],
    address_len: UnsafePointer[socklen_t],
) -> c_int:
    """Libc POSIX `getsockname` function
    Reference: https://man7.org/linux/man-pages/man3/getsockname.3p.html
    Fn signature: int getsockname(int socket, struct sockaddr *restrict address, socklen_t *restrict address_len).

    Args: socket: A File Descriptor.
        address: A UnsafePointer to a buffer to store the address of the peer.
        address_len: A UnsafePointer to the size of the buffer.
    Returns: 0 on success, -1 on error.
    """
    return external_call[
        "getsockname",
        c_int,  # FnName, RetType
        c_int,
        UnsafePointer[sockaddr],
        UnsafePointer[socklen_t],  # Args
    ](socket, address, address_len)


fn getpeername(
    sockfd: c_int,
    addr: UnsafePointer[sockaddr],
    address_len: UnsafePointer[socklen_t],
) -> c_int:
    """Libc POSIX `getpeername` function
    Reference: https://man7.org/linux/man-pages/man2/getpeername.2.html
    Fn signature:   int getpeername(int socket, struct sockaddr *restrict addr, socklen_t *restrict address_len).

    Args: sockfd: A File Descriptor.
        addr: A UnsafePointer to a buffer to store the address of the peer.
        address_len: A UnsafePointer to the size of the buffer.
    Returns: 0 on success, -1 on error.
    """
    return external_call[
        "getpeername",
        c_int,  # FnName, RetType
        c_int,
        UnsafePointer[sockaddr],
        UnsafePointer[socklen_t],  # Args
    ](sockfd, addr, address_len)


fn bind(
    socket: c_int, address: UnsafePointer[sockaddr], address_len: socklen_t
) -> c_int:
    """Libc POSIX `bind` function
    Reference: https://man7.org/linux/man-pages/man3/bind.3p.html
    Fn signature: int bind(int socket, const struct sockaddr *address, socklen_t address_len).
    """
    return external_call["bind", c_int, c_int, UnsafePointer[sockaddr], socklen_t](
        socket, address, address_len
    )


fn listen(socket: c_int, backlog: c_int) -> c_int:
    """Libc POSIX `listen` function
    Reference: https://man7.org/linux/man-pages/man3/listen.3p.html
    Fn signature: int listen(int socket, int backlog).

    Args: socket: A File Descriptor.
        backlog: The maximum length of the queue of pending connections.
    Returns: 0 on success, -1 on error.
    """
    return external_call["listen", c_int, c_int, c_int](socket, backlog)


fn accept(
    socket: c_int,
    address: UnsafePointer[sockaddr],
    address_len: UnsafePointer[socklen_t],
) -> c_int:
    """Libc POSIX `accept` function
    Reference: https://man7.org/linux/man-pages/man3/accept.3p.html
    Fn signature: int accept(int socket, struct sockaddr *restrict address, socklen_t *restrict address_len).

    Args: socket: A File Descriptor.
        address: A UnsafePointer to a buffer to store the address of the peer.
        address_len: A UnsafePointer to the size of the buffer.
    Returns: A File Descriptor or -1 in case of failure.
    """
    return external_call[
        "accept",
        c_int,  # FnName, RetType
        c_int,
        UnsafePointer[sockaddr],
        UnsafePointer[socklen_t],  # Args
    ](socket, address, address_len)


fn connect(socket: c_int, address: Pointer[sockaddr], address_len: socklen_t) -> c_int:
    """Libc POSIX `connect` function
    Reference: https://man7.org/linux/man-pages/man3/connect.3p.html
    Fn signature: int connect(int socket, const struct sockaddr *address, socklen_t address_len).

    Args: socket: A File Descriptor.
        address: A UnsafePointer to the address to connect to.
        address_len: The size of the address.
    Returns: 0 on success, -1 on error.
    """
    return external_call["connect", c_int](socket, address, address_len)


fn recv(
    socket: c_int,
    buffer: UnsafePointer[UInt8],
    length: c_size_t,
    flags: c_int,
) -> c_ssize_t:
    """Libc POSIX `recv` function
    Reference: https://man7.org/linux/man-pages/man3/recv.3p.html
    Fn signature: ssize_t recv(int socket, void *buffer, size_t length, int flags).
    """
    return external_call[
        "recv",
        c_ssize_t,  # FnName, RetType
        c_int,
        UnsafePointer[UInt8],
        c_size_t,
        c_int,  # Args
    ](socket, buffer, length, flags)


fn send(
    socket: c_int, buffer: UnsafePointer[c_void], length: c_size_t, flags: c_int
) -> c_ssize_t:
    """Libc POSIX `send` function
    Reference: https://man7.org/linux/man-pages/man3/send.3p.html
    Fn signature: ssize_t send(int socket, const void *buffer, size_t length, int flags).

    Args: socket: A File Descriptor.
        buffer: A UnsafePointer to the buffer to send.
        length: The size of the buffer.
        flags: Flags to control the behaviour of the function.
    Returns: The number of bytes sent or -1 in case of failure.
    """
    return external_call["send", c_ssize_t](socket, buffer, length, flags)


fn shutdown(socket: c_int, how: c_int) -> c_int:
    """Libc POSIX `shutdown` function
    Reference: https://man7.org/linux/man-pages/man3/shutdown.3p.html
    Fn signature: int shutdown(int socket, int how).

    Args: socket: A File Descriptor.
        how: How to shutdown the socket.
    Returns: 0 on success, -1 on error.
    """
    return external_call["shutdown", c_int, c_int, c_int](  # FnName, RetType  # Args
        socket, how
    )


fn getaddrinfo(
    nodename: UnsafePointer[c_char],
    servname: UnsafePointer[c_char],
    hints: UnsafePointer[addrinfo],
    res: UnsafePointer[UnsafePointer[addrinfo]],
) -> c_int:
    """Libc POSIX `getaddrinfo` function
    Reference: https://man7.org/linux/man-pages/man3/getaddrinfo.3p.html
    Fn signature: int getaddrinfo(const char *restrict nodename, const char *restrict servname, const struct addrinfo *restrict hints, struct addrinfo **restrict res).
    """
    return external_call[
        "getaddrinfo",
        c_int,  # FnName, RetType
        UnsafePointer[c_char],
        UnsafePointer[c_char],
        UnsafePointer[addrinfo],  # Args
        UnsafePointer[UnsafePointer[addrinfo]],  # Args
    ](nodename, servname, hints, res)


fn gai_strerror(ecode: c_int) -> UnsafePointer[c_char]:
    """Libc POSIX `gai_strerror` function
    Reference: https://man7.org/linux/man-pages/man3/gai_strerror.3p.html
    Fn signature: const char *gai_strerror(int ecode).

    Args: ecode: The error code.
    Returns: A UnsafePointer to a string describing the error.
    """
    return external_call[
        "gai_strerror", UnsafePointer[c_char], c_int  # FnName, RetType  # Args
    ](ecode)


fn inet_pton(address_family: Int, address: String) -> Int:
    var ip_buf_size = 4
    if address_family == AF_INET6:
        ip_buf_size = 16

    var ip_buf = UnsafePointer[c_void].alloc(ip_buf_size)
    var conv_status = inet_pton(
        rebind[c_int](address_family), to_char_ptr(address), ip_buf
    )
    return int(ip_buf.bitcast[c_uint]())


# --- ( File Related Syscalls & Structs )---------------------------------------
alias O_NONBLOCK = 16384
alias O_ACCMODE = 3
alias O_CLOEXEC = 524288


fn close(fildes: c_int) -> c_int:
    """Libc POSIX `close` function
    Reference: https://man7.org/linux/man-pages/man3/close.3p.html
    Fn signature: int close(int fildes).

    Args:
        fildes: A File Descriptor to close.

    Returns:
        Upon successful completion, 0 shall be returned; otherwise, -1
        shall be returned and errno set to indicate the error.
    """
    return external_call["close", c_int, c_int](fildes)


fn open[*T: AnyType](path: UnsafePointer[c_char], oflag: c_int, *args: *T) -> c_int:
    """Libc POSIX `open` function
    Reference: https://man7.org/linux/man-pages/man3/open.3p.html
    Fn signature: int open(const char *path, int oflag, ...).

    Args:
        path: A UnsafePointer to a C string containing the path to open.
        oflag: The flags to open the file with.
        args: The optional arguments.
    Returns:
        A File Descriptor or -1 in case of failure
    """
    return external_call["open", c_int](path, oflag, args)


fn printf[*T: AnyType](format: UnsafePointer[c_char], *args: *T) -> c_int:
    """Libc POSIX `printf` function
    Reference: https://man7.org/linux/man-pages/man3/fprintf.3p.html
    Fn signature: int printf(const char *restrict format, ...).

    Args: format: A UnsafePointer to a C string containing the format.
        args: The optional arguments.
    Returns: The number of bytes written or -1 in case of failure.
    """
    return external_call[
        "printf",
        c_int,  # FnName, RetType
    ](format, args)


fn read(fildes: c_int, buf: UnsafePointer[c_void], nbyte: c_size_t) -> c_int:
    """Libc POSIX `read` function
    Reference: https://man7.org/linux/man-pages/man3/read.3p.html
    Fn signature: sssize_t read(int fildes, void *buf, size_t nbyte).

    Args: fildes: A File Descriptor.
        buf: A UnsafePointer to a buffer to store the read data.
        nbyte: The number of bytes to read.
    Returns: The number of bytes read or -1 in case of failure.
    """
    return external_call["read", c_ssize_t, c_int, UnsafePointer[c_void], c_size_t](
        fildes, buf, nbyte
    )


fn write(fildes: c_int, buf: UnsafePointer[c_void], nbyte: c_size_t) -> c_int:
    """Libc POSIX `write` function
    Reference: https://man7.org/linux/man-pages/man3/write.3p.html
    Fn signature: ssize_t write(int fildes, const void *buf, size_t nbyte).

    Args: fildes: A File Descriptor.
        buf: A UnsafePointer to a buffer to write.
        nbyte: The number of bytes to write.
    Returns: The number of bytes written or -1 in case of failure.
    """
    return external_call["write", c_ssize_t, c_int, UnsafePointer[c_void], c_size_t](
        fildes, buf, nbyte
    )


struct timeval:
    var tv_sec: Int64
    var tv_usec: Int64

    fn __init__(inout self, seconds: Int64, microseconds: Int64):
        self.tv_sec = seconds
        self.tv_usec = microseconds


@value
struct fd_set:
    var fds_bits: StaticTuple[Int64, 16]

    fn __init__(inout self):
        self.fds_bits = StaticTuple[Int64, 16]()
        for i in range(16):
            self.fds_bits[i] = 0

    fn set(inout self, fd: Int):
        var word = fd // 64
        var bit = fd % 64
        self.fds_bits[word] |= 1 << bit

    fn clear(inout self, fd: Int):
        var word = fd // 64
        var bit = fd % 64
        self.fds_bits[word] &= ~(1 << bit)

    fn is_set(self, fd: Int) -> Bool:
        var word = fd // 64
        var bit = fd % 64
        var result = (self.fds_bits[word] & (1 << bit)) != 0
        return result

    fn clear_all(inout self):
        for i in range(16):
            self.fds_bits[i] = 0

    fn print_bits(self):
        for i in range(16):
            print("Word", i, ":", bin(self.fds_bits[i]))


fn select(
    nfds: c_int,
    readfds: UnsafePointer[fd_set],
    writefds: UnsafePointer[fd_set],
    exceptfds: UnsafePointer[fd_set],
    timeout: UnsafePointer[timeval],
) -> c_int:
    """Libc POSIX `select` function
    Reference: https://man7.org/linux
    Fn signature: int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout).

    Args: nfds: The highest-numbered file descriptor in any of the three sets, plus 1.
        readfds: A UnsafePointer to the set of file descriptors to read from.
        writefds: A UnsafePointer to the set of file descriptors to write to.
        exceptfds: A UnsafePointer to the set of file descriptors to check for exceptions.
        timeout: A UnsafePointer to a timeval struct to set a timeout.
    Returns: The number of file descriptors in the sets or -1 in case of failure.
    """
    return external_call[
        "select",
        c_int,  # FnName, RetType
        c_int,
        UnsafePointer[fd_set],
        UnsafePointer[fd_set],
        UnsafePointer[fd_set],
        UnsafePointer[timeval],  # Args
    ](nfds, readfds, writefds, exceptfds, timeout)


fn __test_getaddrinfo__():
    var ip_addr = "127.0.0.1"
    var port = 8083

    var servinfo = UnsafePointer[addrinfo]().alloc(1)
    servinfo[0] = addrinfo()

    var hints = addrinfo()
    hints.ai_family = AF_INET
    hints.ai_socktype = SOCK_STREAM
    hints.ai_flags = AI_PASSIVE

    var status = getaddrinfo(
        to_char_ptr(ip_addr),
        UnsafePointer[UInt8](),
        UnsafePointer.address_of(hints),
        UnsafePointer.address_of(servinfo),
    )
    var msg_ptr = gai_strerror(c_int(status))
    _ = external_call["printf", c_int, UnsafePointer[c_char], UnsafePointer[c_char]](
        to_char_ptr("gai_strerror: %s"), msg_ptr
    )
    var msg = c_charptr_to_string(msg_ptr)
    print("getaddrinfo satus: " + msg)
