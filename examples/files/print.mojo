from libc import (
    FD_STDOUT,
    c_char,
    c_int,
    c_void,
    printf,
    strlen,
    write,
)


fn main():
    var format_str = String("Hello %s\n")
    var format_ptr = format_str.unsafe_cstr_ptr()
    var name = String("world")
    var name_ptr = name.unsafe_cstr_ptr()
    _ = printf(format_ptr, name_ptr)
    var msg = String("Hello world, again\n")
    var msg_ptr = msg.unsafe_cstr_ptr()
    _ = write(FD_STDOUT, msg_ptr.bitcast[c_void](), len(msg))
