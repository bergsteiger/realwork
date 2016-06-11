// syserror.cpp -- system_error static objects
#if defined(__CODEGEARC__) && defined(__clang__)
#include <yvals.h>
#endif
#include <cstdlib>

 #if _HAS_CPP0X
 #include <system_error>


_STD_BEGIN

struct _Sys_errtab_t
	{	// maps error_code to NTBS
	_Errc _Errcode;
	const char *_Name;
	};

static const _Sys_errtab_t _Sys_errtab[] =
	{	// table of Posix code/name pairs
	errc::address_family_not_supported, "address family not supported",
	errc::address_in_use, "address in use",
	errc::address_not_available, "address not available",
	errc::already_connected, "already connected",
	errc::argument_list_too_long, "argument list too long",
	errc::argument_out_of_domain, "argument out of domain",
	errc::bad_address, "bad address",
	errc::bad_file_descriptor, "bad file descriptor",
	errc::bad_message, "bad message",
	errc::broken_pipe, "broken pipe",
	errc::connection_aborted, "connection aborted",
	errc::connection_already_in_progress, "connection already in progress",
	errc::connection_refused, "connection refused",
	errc::connection_reset, "connection reset",
	errc::cross_device_link, "cross device link",
	errc::destination_address_required, "destination address required",
	errc::device_or_resource_busy, "device or resource busy",
	errc::directory_not_empty, "directory not empty",
	errc::executable_format_error, "executable format error",
	errc::file_exists, "file exists",
	errc::file_too_large, "file too large",
	errc::filename_too_long, "filename too long",
	errc::function_not_supported, "function not supported",
	errc::host_unreachable, "host unreachable",
	errc::identifier_removed, "identifier removed",
	errc::illegal_byte_sequence, "illegal byte sequence",
	errc::inappropriate_io_control_operation,
		"inappropriate io control operation",
	errc::interrupted, "interrupted",
	errc::invalid_argument, "invalid argument",
	errc::invalid_seek, "invalid seek",
	errc::io_error, "io error",
	errc::is_a_directory, "is a directory",
	errc::message_size, "message size",
	errc::network_down, "network down",
	errc::network_reset, "network reset",
	errc::network_unreachable, "network unreachable",
	errc::no_buffer_space, "no buffer space",
	errc::no_child_process, "no child process",
	errc::no_link, "no link",
	errc::no_lock_available, "no lock available",
	errc::no_message_available, "no message available",
	errc::no_message, "no message",
	errc::no_protocol_option, "no protocol option",
	errc::no_space_on_device, "no space on device",
	errc::no_stream_resources, "no stream resources",
	errc::no_such_device_or_address, "no such device or address",
	errc::no_such_device, "no such device",
	errc::no_such_file_or_directory, "no such file or directory",
	errc::no_such_process, "no such process",
	errc::not_a_directory, "not a directory",
	errc::not_a_socket, "not a socket",
	errc::not_a_stream, "not a stream",
	errc::not_connected, "not connected",
	errc::not_enough_memory, "not enough memory",
	errc::not_supported, "not supported",
	errc::operation_canceled, "operation canceled",
	errc::operation_in_progress, "operation in progress",
	errc::operation_not_permitted, "operation not permitted",
	errc::operation_not_supported, "operation not supported",
	errc::operation_would_block, "operation would block",
	errc::owner_dead, "owner dead",
	errc::permission_denied, "permission denied",
	errc::protocol_error, "protocol error",
	errc::protocol_not_supported, "protocol not supported",
	errc::read_only_file_system, "read only file system",
	errc::resource_deadlock_would_occur, "resource deadlock would occur",
	errc::resource_unavailable_try_again, "resource unavailable try again",
	errc::result_out_of_range, "result out of range",
	errc::state_not_recoverable, "state not recoverable",
	errc::stream_timeout, "stream timeout",
	errc::text_file_busy, "text file busy",
	errc::timed_out, "timed out",
	errc::too_many_files_open_in_system, "too many files open in system",
	errc::too_many_files_open, "too many files open",
	errc::too_many_links, "too many links",
	errc::too_many_symbolic_link_levels, "too many symbolic link levels",
	errc::value_too_large, "value too large",
	errc::wrong_protocol_type, "wrong protocol type"
	};

_CRTIMP2P const char *_PCDECL _Syserror_map(int _Errcode)
	{	// convert to name of generic error
	const _Sys_errtab_t *_Ptr = &_Sys_errtab[0];
	for (; _Ptr != _STD end(_Sys_errtab); ++_Ptr)
		if ((int)_Ptr->_Errcode == _Errcode)
			return (_Ptr->_Name);
	return (0);
	}
_STD_END
 #else /* _HAS_CPP0X */
 #endif /* _HAS_CPP0X */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
