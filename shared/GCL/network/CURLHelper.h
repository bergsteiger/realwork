#ifndef CURL_HELPER_H
#define CURL_HELPER_H

#include <string>
#include "curl/curl.h"

namespace curl_helper {

class CURLHelper {
public:
	CURLHelper ();
	~CURLHelper ();
public:
	void change_request_timeout (long request_timeout);
	void set_proxy_address (const std::string& host, unsigned short port);
	void set_proxy_auth (const std::string& login, const std::string& passwd);
	bool perform_post_operation (const std::string& operation, const std::string& data);
	bool perform_get_operation (const std::string& operation);
	void use_ssl_connection (bool use);
	const std::string& get_response () const;
private:
	void init ();
	void shutdown ();
	CURL* get_curl_handle ();
	void set_request_timeout (long request_timeout);
	static size_t write_data_callback (void* buffer, size_t size, size_t nmemb, void* userp);
	bool perform_operation (const std::string& operation);

private:
	CURL* m_curl_handle;
	bool m_use_ssl_connection;
	std::string m_response;
	struct curl_slist* m_expect_100;
};

} // namespace curl_helper

#endif // CURL_HELPER_H

