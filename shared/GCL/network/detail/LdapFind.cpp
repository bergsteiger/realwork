#include "ace/ACE.h"
#include "shared/GCL/network/ldap/LdapFind.h"

#include <exception>
#include "boost/lexical_cast.hpp"
#include "garantServer/src/Application/ActiveDirectoryIntegration/Ldap.h"
#include "shared/GCL/network/LdapConnection.h"
#include "shared/GCL/network/LdapStringWrappers.h" 
#include "shared/Core/sys/Exception.h"
#include "shared/GCL/network/detail/Reply.h"
#include <memory>
#include <vector>

namespace LdapHelper {

	namespace LDAPFilterSyntax {
		std::string member_of_check (const std::string& group) {
			return "(memberof=" + group + ")";
		}

		std::string user_name_check (const std::string& user_name) {
			return "(userPrincipalName=" + user_name + ")";
		}

		std::string or (const std::string& left, const std::string& right) {
			return "(|" + left + right + ")";
		}

		std::string and (const std::string& left, const std::string& right) {
			return "(&" + left + right + ")";
		}

	}
	unsigned long LdapAccessor::find (const Request& request, LDAPMessage** result) {
		return ldap_search_s (
			m_connection.get ()
			, const_cast<char*> (request.base.c_str ())
			, LDAP_SCOPE_SUBTREE
			, const_cast<char*> (request.filter.c_str ())
			, 0
			, 0
			, result
		);
	}

	unsigned long LdapAccessor::count (LDAPMessage* entry) {
		return ldap_count_entries (m_connection.get (), entry);
	}

	LDAPMessage* LdapAccessor::next (LDAPMessage* entry) {
		return ldap_next_entry (m_connection.get (), entry);
	}

	LDAPMessage* LdapAccessor::first (LDAPMessage* entry) {
		return ldap_first_entry (m_connection.get (), entry);
	}


	std::string LdapAccessor::value (LDAPMessage* entry, const std::string& attribute) {
		LdapStringWrapper result (ldap_get_values (
			m_connection.get ()
			, entry
			, const_cast<char*> (attribute.c_str ())
		));
		return result.get () ? *result.get (): "";
	}

	Reply::Reply (const Request& request) {						
		OutputDebugString ("filter= ");
		OutputDebugString (request.filter.c_str ());
		OutputDebugString ("\n");

		unsigned long return_code = m_accessor.find (request, m_data.get_message_pointer_address ());
		if (return_code != LDAP_SUCCESS) {
			throw std::exception (Core::create_exception_string ("data not found", return_code).c_str ());
		}
		m_count = m_accessor.count (m_data.get ());			
	}	

	unsigned long Reply::count () const {
		return m_count;
	}

	void Reply::for_each (EntryHandler& handler) {
		LDAPMessage* entry = 0;
		const std::string& attribute = handler.attribute ();
		for (unsigned long  i = 0; i < this->count (); ++i) {
			entry = i ? m_accessor.next (entry) : m_accessor.first (m_data.get ());
			if (!entry) {
				throw std::exception ("can`t extract data from reply");
			}
			handler (m_accessor.value (entry, attribute));
		}
	}

	unsigned long find (const Request& request) {
		return Reply (request).count ();
	}

	void find (const Request& request, EntryHandler& handler) {
		Reply reply (request);
		reply.for_each (handler);
	}

}


