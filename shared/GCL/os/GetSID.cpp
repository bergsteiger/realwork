#include "boost/format.hpp"

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/os/GetSID.h"


namespace GCL {

#if defined (WIN32)
std::string get_computer_name () {
	char computer_name [MAX_COMPUTERNAME_LENGTH + 1];
	DWORD computer_name_size = MAX_COMPUTERNAME_LENGTH + 1;

	if (GetComputerName (computer_name, &computer_name_size)) {
		return std::string (&computer_name [0], computer_name_size);
	}
	return std::string ();
}

std::string error_message (DWORD error_code) {
	LPVOID error_message;
	FormatMessage(
		FORMAT_MESSAGE_ALLOCATE_BUFFER | 
		FORMAT_MESSAGE_FROM_SYSTEM |
		FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL,
		error_code,
		MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
		(LPTSTR) &error_message,
		0, NULL );
	std::string ret (static_cast <LPSTR>(error_message));
	if (error_message) {
		LocalFree (error_message);
	}
	return ret;
}

std::string sid_to_string (SID* sid) {
	PSID_IDENTIFIER_AUTHORITY psia = GetSidIdentifierAuthority (sid);
	DWORD sub_authorities_count = *GetSidSubAuthorityCount (sid);
	std::string ret = (boost::format ("S-%lu-") % SID_REVISION).str ();
	if ((psia->Value[0] != 0) || (psia->Value[1] != 0)) {
		ret += (boost::format ("0x%02hx%02hx%02hx%02hx%02hx%02hx")
			% (USHORT)psia->Value[0]
			% (USHORT)psia->Value[1]
			% (USHORT)psia->Value[2]
			% (USHORT)psia->Value[3]
			% (USHORT)psia->Value[4]
			% (USHORT)psia->Value[5]).str ();
	}
	else {
		ret += (boost::format ("%lu") % ((ULONG)(psia->Value[5]) + (ULONG)(psia->Value[4] << 8) + (ULONG)(psia->Value[3] << 16) + (ULONG)(psia->Value[2] << 24))).str ();
	}
	for (DWORD i = 0; i < sub_authorities_count; i++) {
		ret += (boost::format ("-%lu") % *GetSidSubAuthority (sid, i)).str ();
	}
	return ret;
}

std::string get_sid (const std::string& account_name) {
	DWORD size_sid = 0;
	DWORD size_domain_name = 0;
	SID_NAME_USE account_type;
	if (!LookupAccountName (NULL, account_name.c_str (), NULL, &size_sid, NULL, &size_domain_name, &account_type)) {
		DWORD error_code = GetLastError ();
		if (error_code != ERROR_INSUFFICIENT_BUFFER) {
			GDS_ASSERT (false);
			LOG_D (("Can't get computer SID for %s - %s", account_name.c_str (), error_message (error_code)));
			return std::string ();
		}
		std::auto_ptr <SID> sid ((SID*) new char [size_sid]);
		std::auto_ptr <char> domain_name (new char [size_domain_name]);
		if (!LookupAccountName (NULL, account_name.c_str (), sid.get (), &size_sid, domain_name.get (), &size_domain_name, &account_type)) {
			LOG_D (("Can't get computer SID for %s - %s", account_name.c_str (), error_message (GetLastError ())));
			return std::string ();
		}
		return sid_to_string (sid.get ());
	}
	GDS_ASSERT (false);
	return std::string ();
}
#endif


std::string get_computer_sid () {
#if defined (WIN32)
	const std::string& computer_name = get_computer_name ();
	return get_sid (computer_name);
#else
	return std::string ();
#endif
}


} // namespace GCL


