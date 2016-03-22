////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Project:   $GARANT TCP Test Tools $
// File:      $Id: TCPSendRecvTest.cpp,v 1.10 2016/01/25 11:43:33 migel Exp $
//
// Author:    $Mickael P. Golovin [migel@garant.ru] $
// Copyright: $SIE "GARANT-SERVICE-UNIVERSITY" LLC, 1990-2016 $
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"

#include "ace/Auto_Ptr.h"
#include "ace/Basic_Types.h"
#include "ace/Basic_Stats.h"
#include "ace/Event_Handler.h"
#include "ace/Get_Opt.h"
#include "ace/High_Res_Timer.h"
#include "ace/INET_Addr.h"
#include "ace/OS.h"
#include "ace/Reactor.h"
#include "ace/Sample_History.h"
#include "ace/Singleton.h"
#include "ace/Stats.h"
#include "ace/SOCK_Acceptor.h"
#include "ace/SOCK_Connector.h"
#include "ace/SOCK_Stream.h"
#include "ace/Synch.h"
#include "ace/Thread.h"
#include "ace/Thread_Manager.h"
#include "ace/Thread_Semaphore.h"
#include "ace/TP_Reactor.h"
#include "ace/TSS_T.h"

#include "shared/Core/fix/wine.h"

static const int DEFAULT_ITERATIONS = 10;

static const int DEFAULT_MESSAGE_SIZE =  16*1024*1024; //  16 MB
static const int MAXIMUM_MESSAGE_SIZE = 256*1024*1024; // 256 MB

static const int DEFAULT_PORT_NUMBER = 9999;
static const int MAXIMUM_PORT_NUMBER = 65535;

static int iterations = DEFAULT_ITERATIONS;
static int message_size = DEFAULT_MESSAGE_SIZE;
static int socket_buffer_size = 0;
static int port_number = DEFAULT_PORT_NUMBER;

static bool server_mode = false;


namespace {

class EndPointHelper {
public:
	inline static ssize_t recv (const ACE_SOCK_Stream& endpoint, unsigned char* buffer, const size_t length) {
		{
			for (size_t position = 0; position < length; /* nothing */) {
				ssize_t result = endpoint.recv (&buffer [position], length-position);

				if (result == -1) {
					return result;
				}

				ACE_DEBUG ((LM_INFO, ACE_TEXT ("EndPointHelper::recv - %d bytes received\n"), result));

				position += (ACE_Thread::yield (), static_cast <size_t> (result));
			}
		}

		return length;
	}

	inline static ssize_t recv (const ACE_SOCK_Stream& endpoint, ACE_UINT32& value) {
		return EndPointHelper::recv (endpoint, (unsigned char*)&value, sizeof (value));
	}

	inline static ssize_t send (const ACE_SOCK_Stream& endpoint, const unsigned char* buffer, const size_t length) {
		{
			for (size_t position = 0; position < length; /* nothing */) {
				ssize_t result = endpoint.send (&buffer [position], length-position);

				if (result == -1) {
					return result;
				}

				ACE_DEBUG ((LM_INFO, ACE_TEXT ("EndPointHelper::send - %d bytes sent\n"), result));

				position += (ACE_Thread::yield (), static_cast <size_t> (result));
			}
		}

		return length;
	}

	inline static ssize_t send (const ACE_SOCK_Stream& endpoint, const ACE_UINT32 value) {
		return EndPointHelper::send (endpoint, (const unsigned char*)&value, sizeof (value));
	}
}; // class EndPointHelper

class Server: public ACE_Event_Handler {
public:
	Server (const ACE_INET_Addr& addr) {
		ACE_SOCK_Acceptor acceptor; {
			if (acceptor.open (addr, 1) == -1) {
				ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - %p\n"), ACE_TEXT ("open failed")));
			}

			ACE_DEBUG (
				(
					LM_DEBUG
					, ACE_TEXT ("Server::Server - listening on \"%s:%d\"\n\n")
					, ACE_TEXT_CHAR_TO_TCHAR (addr.get_host_addr ())
					, addr.get_port_number ()
				)
			);

			if (acceptor.accept (m_endpoint) == -1) {
				ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - %p\n"), ACE_TEXT ("accept failed")));
			}
		}

		if (ACE_Reactor::instance ()->register_handler (this, ACE_Event_Handler::READ_MASK) == -1) {
			ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - can't register event handler in reactor\n")));
		}

#if !defined (ACE_LACKS_SOCKET_BUFSIZ)
		if (socket_buffer_size > 0) {
			if ((m_endpoint.set_option (SOL_SOCKET, SO_SNDBUF, (void*)&socket_buffer_size, sizeof (socket_buffer_size)) == -1) && (errno != ENOTSUP)) {
				ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - %p\n"), ACE_TEXT ("set option [SO_SNDBUF] failed")));
			}

			if ((m_endpoint.set_option (SOL_SOCKET, SO_RCVBUF, (void*)&socket_buffer_size, sizeof (socket_buffer_size)) == -1) && (errno != ENOTSUP)) {
				ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - %p\n"), ACE_TEXT ("set option [SO_RCVBUF] failed")));
			}
		}
#endif /* !defined (ACE_LACKS_SOCKET_BUFSIZ) */

		if (acceptor.close () == -1) {
			ACE_ERROR ((LM_ERROR, ACE_TEXT ("Server::Server - %p\n"), ACE_TEXT ("acceptor close failed")));
		}
	}

	virtual ~Server (void) {
		ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
		m_endpoint.close ();
	}

	virtual ACE_HANDLE get_handle (void) const {
		return this->m_endpoint.get_handle ();
	}

	virtual int handle_input (ACE_HANDLE) {
		ACE_UINT32 message_size = ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value;

		if (message_size == 0) {
			const size_t length = sizeof (ACE_UINT32);
			unsigned char* buffer = (unsigned char*)&message_size;

			if (EndPointHelper::recv (m_endpoint, buffer, length) != static_cast <ssize_t> (length)) {
				ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Server::handle_input - %p\n"), ACE_TEXT ("recv")), -1);
			}

			if (message_size == 0) {
				if (ACE_Reactor::instance ()->remove_handler (this, ACE_Event_Handler::READ_MASK) == -1) {
					ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
					ACE_ERROR_RETURN ((LM_ERROR, "Server::handle_input - can't remove event handler from reactor\n"), -1);
				}

				ACE_Reactor::end_event_loop (); // shutdown
				ACE_DEBUG ((LM_INFO, "Server::handle_input - server shutdown in progress...\n"));

				return 0;
			}

			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Server::handle_input - message size (%u) received\n"), message_size));
			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Server::handle_input - send message size (%u) back\n"), message_size));

			if (EndPointHelper::send (m_endpoint, buffer, length) != static_cast <ssize_t> (length)) {
				ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Server::handle_input - %p\n"), ACE_TEXT ("send")), -1);
			}
		} else {
			ACE_Auto_Basic_Array_Ptr <unsigned char> buffer_array; {
				unsigned char* POINTER (0); {
					ACE_NEW_NORETURN (
						POINTER
						, unsigned char [message_size]
					);
				}

				buffer_array.reset (POINTER);
			}

			unsigned char* buffer = buffer_array.get ();

			if (buffer == 0) {
				ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Server::handle_input - can't allocate buffer\n")), -1);
			}

			ssize_t result = m_endpoint.recv (buffer, message_size);

			if (result == -1) {
				ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Server::handle_input - %p\n"), ACE_TEXT ("recv")), -1);
			}

			size_t length = static_cast <size_t> (result);

			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Server::handle_input - message data (size: %u) received\n"), length));
			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Server::handle_input - send message data (size: %u) back\n"), length));

			if (EndPointHelper::send (m_endpoint, buffer, length) != static_cast <ssize_t> (length)) {
				ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = 0;
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Server::handle_input - %p\n"), ACE_TEXT ("send")), -1);
			}

			message_size -= length;
		}

		ACE_TSS_GET (TSS_MessageSizeSingleton::instance (), MessageSize)->m_value = message_size;
		return 0;
	}

	virtual int handle_close (ACE_HANDLE handle, ACE_Reactor_Mask close_mask) {
		return this->m_endpoint.close ();
	}
private:
	class MessageSize {
	public:
		MessageSize (void): m_value (0) {
		}
	public:
		ACE_UINT32 m_value;
	};

	typedef ACE_TSS_TYPE (MessageSize) TSS_MessageSize;
	typedef ACE_Singleton <TSS_MessageSize, ACE_SYNCH_MUTEX> TSS_MessageSizeSingleton;
private:
	ACE_SOCK_Stream m_endpoint;

	ACE_UNIMPLEMENTED_FUNC (Server (void))
	ACE_UNIMPLEMENTED_FUNC (Server (const Server&))
	ACE_UNIMPLEMENTED_FUNC (Server& operator= (const Server&))
}; // class Server

} // namespace


int ACE_TMAIN (int argc, ACE_TCHAR* argv []) {
	class StaticHelper {
	public:
		inline static void show_ussage (void) {
			ACE_ERROR (
				(
					LM_INFO
					, ACE_TEXT (
						"\n"
						"\nAvailable options:"
						"\n  [-c] (Run in Client Mode)"
						"\n  [-s] (Run in Server Mode)"
						"\n"
						"\n  [-m <Message Size>] (default: %d; maximum: %d)"
						"\n  [-i <Iterations>] (default: %d)"
						"\n"
						"\n  [-p <Port Number>] (default: %d; maximum: %d)"
						"\n"
						"\n  [-b <Socket Buffer Size>]"
						"\n"
						"\n  [-R <ACE_RECV_MAX_SOCKET_BUFSIZ>]"
						"\n  [-S <ACE_SEND_MAX_SOCKET_BUFSIZ>]"
						"\n  [-T <ACE_LARGE_DATA_RECV_ENABLED>]"
						"\n  [-U <ACE_LARGE_DATA_SEND_ENABLED>]"
						"\n"
						"\n  <Target Host>"
						"\n"
					)
					, DEFAULT_MESSAGE_SIZE
					, MAXIMUM_MESSAGE_SIZE
					, DEFAULT_ITERATIONS
					, DEFAULT_PORT_NUMBER
					, MAXIMUM_PORT_NUMBER
				)
			);
		}
	public:
		inline static int putenv (const ACE_TCHAR* name, const ACE_TCHAR* value) {
			ACE_Auto_Basic_Array_Ptr <ACE_TCHAR> env; {
				ACE_TCHAR* POINTER (0); {
					ACE_NEW_NORETURN (
						POINTER
						, ACE_TCHAR [
							ACE_OS::strlen (name)
							+ 1 // length of `=`
							+ ACE_OS::strlen (value)
							+ 1 // length of `\x00`
						]
					);
				}

				env.reset (POINTER);
			}

			ACE_TCHAR* env_ptr = env.get ();

			if (env_ptr != 0) {
				ACE_OS::sprintf (env_ptr, "%s=%s", name, value);
				return ACE_OS::putenv (env_ptr);
			}

			return -1;
		}
	public:
		inline static void dumpenv (const ACE_TCHAR* name) {
			StaticHelper::dumpstr (name, ACE_OS::getenv (name), ACE_TEXT ("ENVIRONMENT VALUE NOT EXIST"));
		}
	public:
		inline static void dumpbool (const ACE_TCHAR* name, const bool value) {
			StaticHelper::dumpstr (name, (value) ? (ACE_TEXT ("true")) : (ACE_TEXT ("false")));
		}

		inline static void dumpint (const ACE_TCHAR* name, const int value) {
			ACE_DEBUG ((LM_INFO, ACE_TEXT ("  %s: %d\n"), name, value));
		}

		inline static void dumpstr (const ACE_TCHAR* name, const ACE_TCHAR* value, const ACE_TCHAR* default = "") {
			ACE_DEBUG ((LM_INFO, ACE_TEXT ("  %s: \"%s\"\n"), name, (value != 0) ? (value) : (default)));
		}
	};

	ACE_DEBUG (
		(
			LM_INFO
			, ACE_TEXT ("\nGARANT TEST TOOL \"%s\" (C) SIE \"GARANT-SERVICE-UNIVERSITY\" LLC, 1990-2016")
			, ACE::basename (argv [0])
		)
	);

	static class ACE_InitializationHelper
	{
	public:
		ACE_InitializationHelper (void) {
			try {
				(ACE::init (), ACE_OS::srand (static_cast <u_int> (ACE_OS::time ())));
			} catch (...) {
			}
		}

		~ACE_InitializationHelper (void) throw () {
			try {
				(ACE_OS::srand (static_cast <u_int> (ACE_OS::time ())), ACE::fini ());
			} catch (...) {
			}
		}
	} ace_initialization_helper;


	ACE_Get_Opt getopt (argc, argv, ACE_TEXT ("csm:i:p:t:b:R:S:T:U:"));

	{
		for (ACE_Get_Opt::Option option; (option = getopt ()) != ACE_Get_Opt::eof; /* nothing */) {
			switch (option) {
				case ACE_TEXT ('c'): {
					server_mode = false;
				} break;

				case ACE_TEXT ('s'): {
					server_mode = true;
				} break;

				case ACE_TEXT ('m'): {
					message_size = ACE_OS::atoi (getopt.opt_arg ());

					if (message_size <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nMessage Size must be greater than zero\n\n")
							)
							, 1
						);
					} else if (message_size > MAXIMUM_MESSAGE_SIZE) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nMessage Size must be less than or equal %d\n\n")
								, MAXIMUM_MESSAGE_SIZE
							)
							, 1
						);
					}
				} break;

				case ACE_TEXT ('i'): {
					iterations = ACE_OS::atoi (getopt.opt_arg ());

					if (iterations <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nIterations must be greater than zero\n\n")
							)
							, 1
						);
					}
				} break;

				case ACE_TEXT ('p'): {
					port_number = ACE_OS::atoi (getopt.opt_arg ());

					if (port_number <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nPort Number must be greater than zero\n\n")
							)
							, 1
						);
					} else if (port_number > MAXIMUM_PORT_NUMBER) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nPort Number must be less than or equal %d\n\n")
								, MAXIMUM_PORT_NUMBER
							)
							, 1
						);
					}
				} break;

				case ACE_TEXT ('b'): {
					socket_buffer_size = ACE_OS::atoi (getopt.opt_arg ());

					if (socket_buffer_size <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nSocket Buffer Size must be greater than zero\n\n")
							)
							, 1
						);
					}
				} break;

				case ACE_TEXT ('R'): {
					ACE_TCHAR* opt_arg = getopt.opt_arg ();

					if (opt_arg == 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_RECV_MAX_SOCKET_BUFSIZ must have value\n\n")
							)
							, 1
						);
					} else if (ACE_OS::atoi (opt_arg) <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_RECV_MAX_SOCKET_BUFSIZ must be greater than zero\n\n")
							)
							, 1
						);
					}

					StaticHelper::putenv (ACE_TEXT ("ACE_RECV_MAX_SOCKET_BUFSIZ"), opt_arg);
				} break;

				case ACE_TEXT ('S'): {
					ACE_TCHAR* opt_arg = getopt.opt_arg ();

					if (opt_arg == 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_SEND_MAX_SOCKET_BUFSIZ must have value\n\n")
							)
							, 1
						);
					} else if (ACE_OS::atoi (opt_arg) <= 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_SEND_MAX_SOCKET_BUFSIZ must be greater than zero\n\n")
							)
							, 1
						);
					}

					StaticHelper::putenv (ACE_TEXT ("ACE_SEND_MAX_SOCKET_BUFSIZ"), opt_arg);
				} break;

				case ACE_TEXT ('T'): {
					ACE_TCHAR* opt_arg = getopt.opt_arg ();

					if (opt_arg == 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_LARGE_DATA_RECV_ENABLED must have value\n\n")
							)
							, 1
						);
					}

					StaticHelper::putenv (ACE_TEXT ("ACE_LARGE_DATA_RECV_ENABLED"), opt_arg);
				} break;

				case ACE_TEXT ('U'): {
					ACE_TCHAR* opt_arg = getopt.opt_arg ();

					if (opt_arg == 0) {
						ACE_ERROR_RETURN (
							(
								LM_ERROR
								, ACE_TEXT ("\nACE_LARGE_DATA_SEND_ENABLED must have value\n\n")
							)
							, 1
						);
					}

					StaticHelper::putenv (ACE_TEXT ("ACE_LARGE_DATA_SEND_ENABLED"), opt_arg);
				} break;

				default: {
					StaticHelper::show_ussage ();
					return 1;
				}
			}
		}
	}

	if ((argc == 1) || ((getopt.opt_ind () >= argc) && !server_mode)) {
		StaticHelper::show_ussage ();
		return 1;
	}

	ACE_Reactor::instance (new ACE_Reactor (new ACE_TP_Reactor (), 1), 1);

	ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n\nCurrent options:\n")));

	StaticHelper::dumpbool (ACE_TEXT ("Run in Server Mode"), server_mode);

	ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));

	if (!server_mode) {
		StaticHelper::dumpint (ACE_TEXT ("Message Size"), message_size);
		StaticHelper::dumpint (ACE_TEXT ("Iterations"), iterations);

		ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));
	}

	StaticHelper::dumpint (ACE_TEXT ("Port Number"), port_number);

	if (socket_buffer_size != 0) {
		ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));

		StaticHelper::dumpint (ACE_TEXT ("Socket Buffer Size"), socket_buffer_size);
	}

	ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));

	StaticHelper::dumpenv (ACE_TEXT ("ACE_RECV_MAX_SOCKET_BUFSIZ"));
	StaticHelper::dumpenv (ACE_TEXT ("ACE_SEND_MAX_SOCKET_BUFSIZ"));

	ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));

	StaticHelper::dumpenv (ACE_TEXT ("ACE_LARGE_DATA_RECV_ENABLED"));
	StaticHelper::dumpenv (ACE_TEXT ("ACE_LARGE_DATA_SEND_ENABLED"));

	ACE_DEBUG ((LM_INFO, ACE_TEXT ("\n")));

	ACE_INET_Addr addr (port_number);

	ACE_TCHAR* target_host = argv [getopt.opt_ind ()];

	if (
		(
			target_host != 0
		) && (
			(
				addr.set (port_number, (ACE_UINT32)ACE_OS::inet_addr (ACE_TEXT_ALWAYS_CHAR (target_host))) == -1
			) || (
				addr.set (port_number, target_host) == -1
			)
		)
	) {
		ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Main - server address: \"%s\" is'n valid\n"), target_host), 1);
	}

	++getopt.opt_ind ();

	if (server_mode) {
		Server server (addr);

		while (!ACE_Reactor::event_loop_done ()) {
			if (ACE_Reactor::instance ()->handle_events () == -1) {
				ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("error handling events")));
			}

			ACE_Thread::yield ();
		}
	} else {
		ACE_SOCK_Stream endpoint; {
			ACE_SOCK_Connector connector; {
				if (connector.connect (endpoint, addr) == -1) {
					ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("connect failed")), 1);
				}
			}
		}

		ACE_Auto_Basic_Array_Ptr <unsigned char> recv_buffer_array; {
			unsigned char* POINTER (0); {
				ACE_NEW_NORETURN (
					POINTER
					, unsigned char [message_size]
				);
			}

			recv_buffer_array.reset (POINTER);
		}

		unsigned char* recv_buffer = recv_buffer_array.get ();

		if (recv_buffer == 0) {
			ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Main - can't allocate receive buffer\n")), 1);
		}

		ACE_Auto_Basic_Array_Ptr <unsigned char> send_buffer_array; {
			unsigned char* POINTER (0); {
				ACE_NEW_NORETURN (
					POINTER
					, unsigned char [message_size]
				);
			}

			send_buffer_array.reset (POINTER);
		}

		unsigned char* send_buffer = send_buffer_array.get ();

		if (send_buffer == 0) {
			ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Main - can't allocate send buffer\n")), 1);
		}

		{
			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Fill send patern\n")));

			for (int i = 0; i < message_size; ++i) {
				send_buffer [i] = static_cast <unsigned char> (ACE_OS::rand () & static_cast <unsigned char> (-1));
			}

			ACE_DEBUG ((LM_INFO, ACE_TEXT ("Fill send patern done\n\n")));
		} {
			ACE_Sample_History history (iterations);

			ACE_hrtime_t test_start = ACE_OS::gethrtime ();
			for (int i = 0; i < iterations; ++i) {
				ACE_UINT32 message_header = message_size;

				if (EndPointHelper::send (endpoint, message_header) == -1) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("send message header failed")));
					break;
				}

				if (EndPointHelper::recv (endpoint, (message_header = 0, message_header)) == -1) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("recv message header failed")));
					break;
				}

				if (message_header != message_size) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - received message header is'n valid\n")));
					break;
				}

				ACE_OS::memset (recv_buffer, 0, message_size);

				ACE_hrtime_t start = ACE_OS::gethrtime ();

				if (EndPointHelper::send (endpoint, send_buffer, message_size) == -1) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("send message failed")));
					break;
				}

				if (EndPointHelper::recv (endpoint, recv_buffer, message_size) == -1) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("recv message failed")));
					break;
				}

				ACE_hrtime_t end = ACE_OS::gethrtime ();

				if (ACE_OS::memcmp (send_buffer, recv_buffer, message_size) != 0) {
					ACE_ERROR ((LM_ERROR, ACE_TEXT ("Main - received message is'n valid\n")));
					break;
				}

				history.sample (end - start);
			}
			ACE_hrtime_t test_end = ACE_OS::gethrtime ();

			ACE_UINT32 global_scale_factor = ACE_High_Res_Timer::global_scale_factor ();
			ACE_Basic_Stats latency;

			history.collect_basic_stats (latency);
			latency.dump_results (ACE_TEXT ("Client"), global_scale_factor);

			ACE_Throughput_Stats::dump_throughput (
				ACE_TEXT ("Client")
				, global_scale_factor
				, test_end - test_start
				, latency.samples_count ()
			);
		} {
			ACE_UINT32 message_size = 0;

			if (EndPointHelper::send (endpoint, message_size) == -1) {
				ACE_ERROR_RETURN ((LM_ERROR, ACE_TEXT ("Main - %p\n"), ACE_TEXT ("shutdown failed")), 1);
			}
		}
	}

	return 0;
}
