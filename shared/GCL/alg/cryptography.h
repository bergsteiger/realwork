////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/cryptography.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::cryptography
//
// несколько классов реализующих методы криптографии
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_ALG_CRYPTOGRAPHY_H__
#define __SHARED_GCL_ALG_CRYPTOGRAPHY_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *450133450138_USER_INCLUDES*
#include <string.h>
//#UC END# *450133450138_USER_INCLUDES*

namespace GCL {

//#UC START# *450133450138_USER_DEFINITION*
class SimpleCrypto {
public:
	struct Buffer {
		void* m_buf;
		int m_len;
		
		Buffer () : m_buf (0), m_len (0) {
		}

		Buffer (void* buf, int len) : m_buf (0), m_len (0) {
			if(buf != 0 && len > 0) {
				m_len = len;
				m_buf = new char[m_len];
				::memcpy(m_buf, buf, m_len);
			}
		}

		~Buffer() {
			if(m_buf != 0) {
				delete[] reinterpret_cast<char*>(m_buf);
			}
		}
		
		Buffer& operator= (const Buffer& other) {
			if (m_buf) {
				delete[] reinterpret_cast<char*>(m_buf);
				m_buf = 0;
				m_len = 0;
			}
			if (other.m_buf != 0 && other.m_len > 0) {
				m_len = other.m_len;
				m_buf = new char[m_len];
				::memcpy(m_buf, other.m_buf, m_len);
			}
			return *this;
		}
		
		bool operator! () {
			return (m_buf == 0 || m_len == 0) ? true : false;
		}
	};

	SimpleCrypto ();
	~SimpleCrypto ();
	
	class KeyLenError : public Core::Exception {
		const char* uid () const /*throw ()*/ {
			return "GCL::SimpleCrypto::KeyLenError";
		}
	};

	void encrypt (const Buffer& buf_in, Buffer& buf_out);
	void decrypt (const Buffer& buf_in, Buffer& buf_out);
	
private:
	unsigned char make_crypt_mask (int index, unsigned short crypt_sold);
};
//#UC END# *450133450138_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_ALG_CRYPTOGRAPHY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
