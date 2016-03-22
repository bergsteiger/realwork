#include "shared/Core/sys/Logs.h"
#include "shared/Core/sys/assert.h"
#include "shared/GCL/network/CURLHelper.h"


namespace curl_helper {


void CURLHelper::change_request_timeout (long request_timeout) {
	this->set_request_timeout (request_timeout);
}

void CURLHelper::set_proxy_address (const std::string& host, unsigned short port) {
	if (host.empty () || !port) {
		return;
	}
	CURLcode code;
	CURL* curl_handle = this->get_curl_handle ();
	code = curl_easy_setopt (curl_handle, CURLOPT_PROXY, host.c_str ());
	GDS_ASSERT (code == CURLE_OK);
	code = curl_easy_setopt (curl_handle, CURLOPT_PROXYPORT, port);
	GDS_ASSERT (code == CURLE_OK);
}

void CURLHelper::set_proxy_auth (const std::string& login, const std::string& passwd) {
	if (login.empty ()) {
		return;
	}
	CURLcode code;
	CURL* curl_handle = this->get_curl_handle ();

	code = curl_easy_setopt (curl_handle, CURLOPT_PROXYUSERNAME, login.c_str ());
	GDS_ASSERT (code == CURLE_OK);

	code = curl_easy_setopt (curl_handle, CURLOPT_PROXYPASSWORD, passwd.c_str ());
	GDS_ASSERT (code == CURLE_OK);
}


bool CURLHelper::perform_post_operation (const std::string& operation, const std::string& data) {
	static const char* curl_string = "CURL";
	CURLcode code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_POST, true);
	GDS_ASSERT (code == CURLE_OK);
	code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_POSTFIELDS, data.c_str ());
	GDS_ASSERT (code == CURLE_OK);
	code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_HTTPHEADER, m_expect_100);
	GDS_ASSERT (code == CURLE_OK);
	LOG_D (("%s: Trying to open URL: '%s' with data: %s", curl_string, operation.c_str (), data.c_str ()));
	return this->perform_operation (operation);
}

bool CURLHelper::perform_get_operation (const std::string& operation) {
	static const char* curl_string = "CURL";
	CURLcode code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_HTTPGET, true);
	GDS_ASSERT (code == CURLE_OK);
	LOG_D (("%s: Trying to open URL: %s", curl_string, operation.c_str ()));
	return this->perform_operation (operation);
}

const std::string& CURLHelper::get_response () const {
	return m_response;
}

CURLHelper::CURLHelper () : m_use_ssl_connection (false), m_expect_100 (NULL) {
	this->init ();
}

CURLHelper::~CURLHelper () {
	this->shutdown ();
}

void CURLHelper::init () {
	m_curl_handle = curl_easy_init ();
	if (!m_curl_handle) {
		LOG_E (("%s: Error initializing CURL", GDS_CURRENT_FUNCTION));
	}
	// Устанавливаем таймауты на операции с CURL
	this->set_request_timeout (30);

	// Прерываем операции в случае ошибок
	curl_easy_setopt (m_curl_handle, CURLOPT_FAILONERROR, 1);

	// Для POST запросов нужно изменить заголовок
	// Expect: 100-continue на Expect:
	m_expect_100 = curl_slist_append (m_expect_100, "Expect:");

}

void CURLHelper::shutdown () {
	curl_easy_cleanup (m_curl_handle);
	curl_slist_free_all (m_expect_100);
}

bool CURLHelper::perform_operation (const std::string& operation) {
	static const char* curl_string = "CURL";
	
	CURLcode code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_WRITEFUNCTION, CURLHelper::write_data_callback);
	GDS_ASSERT (code == CURLE_OK);

	code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_WRITEDATA, &m_response);
	GDS_ASSERT (code == CURLE_OK);

	if (m_use_ssl_connection) {
		code = curl_easy_setopt(this->get_curl_handle (), CURLOPT_USE_SSL, CURLUSESSL_TRY);
		GDS_ASSERT (code == CURLE_OK);
		code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_SSL_VERIFYHOST, 0);		// не проверяем сертификаты
		GDS_ASSERT (code == CURLE_OK);
		code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_SSL_VERIFYPEER, 0);		// не проверяем сертификаты
		GDS_ASSERT (code == CURLE_OK);
	}

	code = curl_easy_setopt (this->get_curl_handle (), CURLOPT_URL, operation.c_str ());
	if (code != CURLE_OK) {
		LOG_E (("%s: invalid URL", curl_string));
		return false;
	}
	code = curl_easy_perform (this->get_curl_handle ());
	long http_code = 0; 
	curl_easy_getinfo (this->get_curl_handle (), CURLINFO_RESPONSE_CODE, &http_code); 
	if (code != CURLE_OK || http_code != 200) {
		m_response = std::string ();
		static const char* curl_string = "CURL";
		if (http_code) {
			LOG_W (("%s: %s - code: %d", curl_string, curl_easy_strerror (code), http_code));
		} else {
			LOG_W (("%s: %s", curl_string, curl_easy_strerror (code)));
		}
		return false;
	}
	return true;
}

size_t CURLHelper::write_data_callback (void* buffer, size_t size, size_t nmemb, void* userp) {
	static_cast <std::string*>(userp)->append (std::string (reinterpret_cast<char*> (buffer), size * nmemb));
	return size * nmemb;
}

void CURLHelper::set_request_timeout (long request_timeout) {
	CURL* curl_handle = this->get_curl_handle ();
	// Таймаут на соединение
	CURLcode code = curl_easy_setopt (curl_handle, CURLOPT_CONNECTTIMEOUT, request_timeout);
	GDS_ASSERT (code == CURLE_OK);
	// Таймаут на операцию - должен быть больше таймаута на соединение
	code = curl_easy_setopt (curl_handle, CURLOPT_TIMEOUT, 2 * request_timeout);
	GDS_ASSERT (code == CURLE_OK);
}

CURL* CURLHelper::get_curl_handle () {
	GDS_ASSERT (m_curl_handle);
	return m_curl_handle;
}

void CURLHelper::use_ssl_connection (bool use) {
	m_use_ssl_connection = use;
}

} // namespace curl_helper


