#ifndef __SHARED_GCL_NETWORK_LDAPSTRINGWRAPPER_H__
#define __SHARED_GCL_NETWORK_LDAPSTRINGWRAPPER_H__
	
namespace LdapHelper {

struct LdapStringWrapper {
	LdapStringWrapper (char** value) : m_value (value) {
	}

	~LdapStringWrapper () {
		if (m_value) {
			ldap_value_free (m_value);
		}
	}

	char** get () const {
		return m_value;
	}

	char* operator [] (size_t i) const {
		return m_value[i];
	}

private:
	LdapStringWrapper (const LdapStringWrapper&);
	LdapStringWrapper& operator= (const LdapStringWrapper&);

	char** m_value;
};

struct LdapMessageWrapper {
	LdapMessageWrapper (LDAPMessage* message = 0) : m_message (message) {
	}

	~LdapMessageWrapper () {
		if (m_message) {
			ldap_msgfree (m_message);
		}
	}

	LDAPMessage* get () const {
		return m_message;
	}

	LDAPMessage** get_message_pointer_address () {
		return &m_message;
	}

private:
	LdapMessageWrapper (const LdapMessageWrapper&);
	LdapMessageWrapper& operator= (const LdapMessageWrapper&);

	LDAPMessage* m_message;
};

}

#endif //__SHARED_GCL_NETWORK_LDAPSTRINGWRAPPER_H__