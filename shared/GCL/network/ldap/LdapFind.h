#ifndef __SHARED_GCL_NETWORK_LDAP_LDAPFIND_H__
#define __SHARED_GCL_NETWORK_LDAP_LDAPFIND_H__
#include <string>
#include <vector>
#include <memory>


namespace LdapHelper {

	namespace LDAPFilterSyntax {
		std::string member_of_check (const std::string& group);
		std::string user_name_check (const std::string& user_name);
		std::string or (const std::string& left, const std::string& right);
		std::string and (const std::string& left, const std::string& right);
	}

	class EntryHandler {
	public:
		virtual void operator () (const std::string& value) = 0;
		virtual ~EntryHandler () {}
		virtual std::string attribute () const = 0;
	};

	class  SearchResultHandler : public EntryHandler {
	public:
		SearchResultHandler (const std::string& attribute) : m_attribute (attribute) {
		}

		void operator () (const std::string& value) {
			if (value.empty ()) {
				return;
			}
			m_data.push_back (value);
		}

		std::string attribute () const {
			return m_attribute;
		}

		std::vector<std::string> result () const {
			return m_data;
		}
		
	private:
		std::vector<std::string> m_data;
		std::string m_attribute;
	};

	struct Request {
		Request (const std::string& base, const std::string& filter) : base (base), filter (filter) {
		}
		std::string base;
		std::string filter;	
	};

	unsigned long find (const Request& request); 
	void find (const Request& request, EntryHandler& handler); 

}
#endif //__SHARED_GCL_NETWORK_LDAP_LDAPFIND_H__