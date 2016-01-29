////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/network/smtp_service.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::network::smtp_service
// Файл реализации утилитного набора smtp_service
//
// предоставляет простой интерфейс для отправки почты с помощью SMTP протокола
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/network/smtp_service.h"

//#UC START# *4503D994032C_CUSTOM_INCLUDES*
#include <sstream>

#include "shared/GCL/str/base64_encoder.h"
#include "shared/GCL/str/str_op.h"

#include "ace/Codecs.h"
//#UC END# *4503D994032C_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *4503D994032C*
SMTPServer::SMTPServer (
	const std::string& server, unsigned short port, unsigned short timeout
) :	m_server(server), m_port(port),	m_timeout (timeout), m_is_connected (false)
{
}

void SMTPServer::connect () /*throw (SMTPServerNotFound)*/ {
	if (m_is_connected) {
		return;
	}
	ACE_SOCK_Connector connector;
	ACE_INET_Addr smtp_addr;
	if (smtp_addr.set (m_port, m_server.c_str ()) == -1) {
		throw SMTPServerNotFound ();
	}
	// Коннектимся к серверу
	if (connector.connect (m_mail_stream, smtp_addr, &m_timeout) == -1) {
		LOG_E (("Can't connect to %s:%d", m_server.c_str (), m_port));
		throw SMTPServerNotFound ();
		return;
	}
	recv ();

	m_is_connected = true;
}

void SMTPServer::disconnect () {
	if (!m_is_connected) {
		return;
	}
	m_mail_stream.close ();

	m_is_connected = false;
}

// Example:
// S: From: John Q. Public <JQP@MIT-AI.ARPA>
// S: Subject:  The Next Meeting of the Board
// S: To: Jones@BBN-Vax.ARPA
// S: Content-Type: text/plain;charset=\"windows-1251\";
// One encoding used in header and in body.
// Header encoding is compy with RFC 2047.

void SMTPServer::send_message (const SMTPMessage& message)  /*throw (SMTPServerNotFound, BadSMTPReply)*/ {
	const static std::string from("MAIL FROM:");
	const static std::string to("RCPT TO:");
	const static std::string data("DATA");
	const static std::string data_from("From: ");
	const static std::string subject("Subject: ");
	const static std::string data_to("To: ");
	const static std::string data_mime("MIME-Version: 1.0");
	const static std::string data_content("Content-Type: text/plain; charset=");
	const static std::string quit("QUIT");
	const static std::string endline("\r\n");

	this->connect ();	

	this->send_auth_info ();
	std::string from_name (m_auth_name.empty () ? message.from () : m_auth_name);
	if (from_name.find ('@') == std::string::npos) {
		from_name += '@';
		//todo по хорошему надо проверять не вида ли xxx.xxx.xxx.xxx адрес
		from_name += m_server.substr (m_server.find ('.')  + 1, std::string::npos);
	}
	send_command (from + "<" + from_name + ">" + endline, "250");
	GCL::StrVector mail_to_vec = GCL::split_string_by (message.to ().c_str (), ';');
	for (
			GCL::StrVector::iterator it = mail_to_vec.begin ()
			; it != mail_to_vec.end ()
			; ++it
	) {
		send_command (to + "<" + *it + ">" + endline, true);
	}
	send_command (data + endline, false);
	std::string header_encoding ("=?");
	if (!message.encoding ().empty ()) {
		header_encoding += message.encoding () + "?Q?";
	} else {
		header_encoding += "US-ASCII?Q?";
	}
	const static std::string header_encoding_end ("?=");
	if (!message.data_from ().empty ()) {		
		send_command (
			data_from
			+ header_encoding
			+ SMTPMessage::recode (message.data_from ()) 
			+ header_encoding_end
			+ "<"
			+ from_name
			+ ">"
			+ endline
			, false
		);
	} else {
		send_command (data_from + from_name + endline, false);
	}
	if (!message.data_to ().empty ()) {	
		GCL::StrVector mail_data_to_vec = GCL::split_string_by (message.data_to ().c_str (), ';');
		for (
				GCL::StrVector::iterator it = mail_data_to_vec.begin ()
				; it != mail_data_to_vec.end ()
				; ++it
		) {			
			send_command (
				data_to
				+ header_encoding
				+ SMTPMessage::recode (*it)
				+ header_encoding_end
				+ "<"
				+ *it
				+ ">"
				+ endline
				, false
			);
		}		
	} else {
		GCL::StrVector mail_data_to_vec = GCL::split_string_by (message.data_to ().c_str (), ';');
		for (
				GCL::StrVector::iterator it = mail_data_to_vec.begin ()
				; it != mail_data_to_vec.end ()
				; ++it
		) {
			send_command (data_to + *it + endline, false);
		}
	}
	if (!message.subject ().empty ()) {
		send_command (subject + header_encoding + SMTPMessage::recode (message.subject ()) + header_encoding_end + endline, true);
	}
	send_command (data_mime + endline, true);
	if (!message.encoding ().empty ()) {
		send_command (
			data_content + "\"" + message.encoding () + "\"" + endline, true
		);
	}
	send_command (endline, false);

	m_mail_stream.send (message.data ().c_str (), message.data ().size (), &m_timeout);

	send_command (endline + "." + endline, true);
	send_command (quit + endline, true);

	this->disconnect ();
}

void SMTPServer::set_auth_data (const std::string& name, const std::string& passwd) {
	m_auth_name = name;
	m_auth_passwd = passwd;
}

// todo: добавить исключение про авторизацию
// предпочитаем тип авторизации login, он типа более безопасный
void SMTPServer::send_auth_info () const {
	const static std::string ehlo ("EHLO ");
	const static std::string endline("\r\n");

	while (!m_auth_name.empty () && !m_auth_passwd.empty ()) {
		const size_t hostname_len = 1024;
		char hostname [hostname_len];
		ACE_OS::hostname (hostname, hostname_len);
		send_command (ehlo + hostname + endline, false);

		const static int recv_bufsize = 1024;
		static char recv_buf [recv_bufsize];
		memset (&recv_buf, 0, sizeof recv_buf);
		ssize_t recv_bytes = m_mail_stream.recv (&recv_buf, sizeof (recv_buf) - 1, &m_timeout);
		if (recv_bytes == -1) {
			LOG_W (("%s: server does not support ehlo command", GDS_CURRENT_FUNCTION));
			break;
		}
		recv_buf[recv_bytes] = 0;
		std::istringstream reply (std::string (recv_buf, recv_bytes));

		std::string next_line;
		AuthType auth_type = AT_NONFOUND;
		for (std::getline (reply, next_line); !next_line.empty (); std::getline (reply, next_line)) {
			if (next_line[0] == '5') {
				throw BadSMTPReply();
			}
			if (
				((next_line.find_first_of ("AUTH") == 4) || (next_line.find_first_of ("auth") == 4))
				&& ((next_line[8] == ' ') || (next_line[8] == '='))
			) {
				//строка, задающая типы авторизации, пока поддерживаем PLAIN и LOGIN
				if (
					(next_line.find_first_of (" LOGIN") != std::string::npos) 
					|| (next_line.find_first_of (" login") != std::string::npos)
				) {
					auth_type = AT_LOGIN;
					break;
				} else if (
					(next_line.find_first_of (" PLAIN") != std::string::npos) 
					|| (next_line.find_first_of (" plain") != std::string::npos)
				) {
					auth_type = AT_PLAIN;
					// не выходим из цикла, может поддерживается login тип авторизации
				} else {
					LOG_W (("%s: not supported auth types: %s", next_line.c_str ()));
				}
			}
		}
		if (auth_type == AT_NONFOUND) {
			LOG_W ((
				"%s: server %s does not supports authentification types login or plain"
				, GDS_CURRENT_FUNCTION
				, m_server.c_str ()
			));
			break;
		}
		auth (auth_type);

		return;
	}

	const static std::string helo("HELO ");
	send_command (helo + m_server + endline, true);
}

void SMTPServer::auth (AuthType type) const {
	try {
		GDS_ASSERT (type != AT_NONFOUND);
		switch (type) {
			case AT_LOGIN:
				auth_login ();
				break;
			case AT_PLAIN:
				auth_plain ();
				break;
			default:
				GDS_ASSERT (false && "bad value of type");
		}
	} catch (BadSMTPReply&) {
		throw SMTPAuthorizationFailed ();
	}
}

void SMTPServer::auth_login () const {
	const std::string login_auth ("AUTH LOGIN");
	const static std::string endline ("\r\n");

	send_command (login_auth + endline, "334");

	std::string data64 = GCL::encode_base64_string (m_auth_name);
	send_command (data64 + endline, "334");

	data64 = GCL::encode_base64_string (m_auth_passwd);
	send_command (data64 + endline, "235");
}

void SMTPServer::auth_plain () const {
	const std::string plain_auth ("AUTH PLAIN ");
	const static std::string endline ("\r\n");

	// ответ формируется как "\0login\0passwd" - rfc2595
	std::string data_for_encoding (1, '\0');
	data_for_encoding += m_auth_name + '\0' + m_auth_passwd;
	std::string data64 = plain_auth + GCL::encode_base64_string (data_for_encoding);
	send_command (data64 + endline, "235");
}

void SMTPServer::send_command (const std::string& command, bool need_recv) const {
//	LOG_D (("Send: %s", command.c_str ()));
	m_mail_stream.send (command.c_str (), command.size (), &m_timeout);
	if (need_recv) {
		recv ();
	}
}

void SMTPServer::send_command (const std::string& command, const char* return_code) const {
	//	LOG_D (("Send: %s", command.c_str ()));
	m_mail_stream.send (command.c_str (), command.size (), &m_timeout);
	recv (return_code);
}

const static int recv_bufsize = 1024;

void SMTPServer::recv () const {
	char recv_buf [recv_bufsize];
	ssize_t recv_bytes = this->recv_i (recv_buf, recv_bufsize);
//	LOG_D (("Recv:%s", recv_buf));

	if (recv_bytes == -1) {
		return;
	}
	if (recv_bytes) {
		std::istringstream reply (std::string (recv_buf, recv_bytes));
		std::string next_line;
		for (std::getline (reply, next_line); !next_line.empty (); std::getline (reply, next_line)) {
			if (next_line[0] == '5') {
				throw BadSMTPReply();
			}
		}
	}
}

void SMTPServer::recv (const char* success_code) const {
	GDS_ASSERT (success_code);

	char recv_buf [recv_bufsize];
	ssize_t recv_bytes = this->recv_i (recv_buf, recv_bufsize);
	//	LOG_D (("Recv:%s", recv_buf));

	if (recv_bytes > 0) {
		std::istringstream reply (std::string (recv_buf, recv_bytes));
		std::string next_line;
		for (std::getline (reply, next_line); !next_line.empty (); std::getline (reply, next_line)) {
			if (ACE_OS::strncmp (success_code, next_line.c_str (), ACE_OS::strlen (success_code))) {
				throw BadSMTPReply();
			}
		}

		return;
	}
	throw BadSMTPReply ();
}

ssize_t SMTPServer::recv_i (char* buf, size_t size) const {
	memset (buf, 0, sizeof size);
	return m_mail_stream.recv (buf, size - 1, &m_timeout);
}

const static char* const default_encoding = "windows-1251";

SMTPMessage::SMTPMessage (
	const std::string& from
	, const std::string& to
	, const std::string& data
) :	m_from(from), m_to(to), m_data(data)
	, m_data_from(""), m_data_to(""), m_subject("")
	, m_encoding(default_encoding)
{
}

void SMTPMessage::add_to_data (const std::string& data_chunk, bool to_end) {
	if (to_end) {
		m_data += data_chunk;
	} else {
		m_data = data_chunk + m_data;
	}
}

std::string SMTPMessage::recode (const std::string& to_recode) {
	std::ostringstream ret;
	for (size_t i = 0; i < to_recode.length (); i++) {
		unsigned int character = static_cast<unsigned char> (to_recode[i]);
		ret << "=" << std::hex << character;
	}
	return ret.str ();
}

/*
int main (int argc, char *argv[]) {
	ACE::init ();

	SMTPServer s ("smtp.garant.ru");
	SMTPMessage m ("dolgop@garant.ru", "evg_dolgop@mail.ru");
	m.data_from ("Evgeny <dolgop@mccinet.ru>");
	m.data_to ("Dolgopyat <evg_dolgop@mail.ru>");
	m.subject ("Test - письмо");
	m.data ("FirstString");
	m.add_to_data ("\n");
	m.add_to_data ("Вторая строка");
	s.send_message (m);

	ACE::fini ();

	return 0;
}
*/
//#UC END# *4503D994032C*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

