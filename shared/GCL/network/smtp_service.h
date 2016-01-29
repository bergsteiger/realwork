////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/network/smtp_service.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::network::smtp_service
//
// предоставляет простой интерфейс для отправки почты с помощью SMTP протокола
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_NETWORK_SMTP_SERVICE_H__
#define __SHARED_GCL_NETWORK_SMTP_SERVICE_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4503D994032C_USER_INCLUDES*
#include <string>
#include "ace/INET_Addr.h"
#include "ace/SOCK_Connector.h"
#include "ace/SOCK_Stream.h"

//#UC END# *4503D994032C_USER_INCLUDES*

namespace GCL {

//#UC START# *4503D994032C_USER_DEFINITION*
// Exceptions
class SMTPServerNotFound : public Core::Exception {
	virtual const char* uid () const /*throw ()*/ {
		return "GCL::SMTPServerNotFound";
	}
};

class BadSMTPReply : public Core::Exception {
	virtual const char* uid () const /*throw ()*/ {
		return "GCL::BadSMTPReply";
	}
};

class SMTPAuthorizationFailed : public Core::Exception {
	virtual const char* uid () const /*throw ()*/ {
		return "GCL::SMTPAuthorizationFailed";
	}
};

class SMTPMessage {
public:
	// Encoding to quoted-printable according RFC2047
	static std::string recode (const std::string& to_recode);

public:
	SMTPMessage (const std::string& from, const std::string& to, const std::string& data = "");
	
	~SMTPMessage () {
	}

	const std::string& from () const {
		return m_from;
	}
	
	void from (const std::string& from) {
		m_from = from;
	}
	
	const std::string& to () const {
		return m_to;
	}
	
	void to (const std::string& to) {
		m_to = to;
	}
	
	const std::string& data () const {
		return m_data;
	}
	
	void data (const std::string& data) {
		m_data = data;
	}
	
	void add_to_data (const std::string& data_chunk, bool to_end = true);

	void data_from (const std::string& from) {
		m_data_from = from;
	}
	
	const std::string& data_from () const {
		return m_data_from;
	}
	
	void data_to (const std::string& to) {
		m_data_to = to;
	}
	
	const std::string& data_to () const {
		return m_data_to;
	}
	
	void subject (const std::string& subject) {
		m_subject = subject;
	}
	
	const std::string& subject () const {
		return m_subject;
	}
	
	void encoding (const std::string& encoding) {
		m_encoding = encoding;
	}
	
	const std::string& encoding () const {
		return m_encoding;
	}

private:
	std::string m_from;
	std::string m_to;
	std::string m_data;
	std::string m_data_from;
	std::string m_data_to;
	std::string m_subject;
	std::string m_encoding;
};

class SMTPServer {
public:
	SMTPServer (
		const std::string& server
		, unsigned short port = 25
		, unsigned short timeout = 5
	);
	
	~SMTPServer () {}

	void connect () /*throw (SMTPServerNotFound)*/;
	
	void disconnect ();

	unsigned short timeout () {
		return static_cast<unsigned short>(m_timeout.sec ());
	}
	
	void timeout (unsigned short timeout) {
		m_timeout = timeout;
	}

	void set_auth_data (const std::string& name, const std::string& passwd);

	void send_message (const SMTPMessage& message); 
		/*throw (SMTPServerNotFound, BadSMTPReply, SMTPAuthorizationFailed)*/

private:
	void send_command (const std::string& command, bool need_recv) const;
	void send_command (const std::string& command, const char* return_code) const;

	void send_auth_info () const;
	enum AuthType {
		AT_NONFOUND,
		AT_LOGIN,
		AT_PLAIN
	};
	void auth (AuthType type) const;
	void auth_login () const;
	void auth_plain () const;

	void recv () const;
	void recv (const char* success_code) const;
	ssize_t recv_i (char* buf, size_t size) const;

private:
	std::string m_server;
	unsigned short m_port;
	ACE_SOCK_Stream m_mail_stream;
	ACE_Time_Value m_timeout;
	bool m_is_connected;

	std::string m_auth_name;
	std::string m_auth_passwd;
};
//#UC END# *4503D994032C_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_NETWORK_SMTP_SERVICE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
