////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/cryptography.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::cryptography
// Файл реализации утилитного набора cryptography
//
// несколько классов реализующих методы криптографии
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/alg/cryptography.h"

//#UC START# *450133450138_CUSTOM_INCLUDES*
//#UC END# *450133450138_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *450133450138*
const unsigned int crypto_sold_length = sizeof (short);
const unsigned int crypto_sold_size = crypto_sold_length;

SimpleCrypto::SimpleCrypto() {
	srand ((unsigned)time( 0 ));
}

SimpleCrypto::~SimpleCrypto () {
}

void SimpleCrypto::encrypt(const Buffer& buf_in, Buffer& buf_out) {
/*
	if (buf_in.m_len>=crypto_tail_length) {
		return;
	}
*/
	unsigned short crypto_sold = (unsigned short) rand ();
	buf_out.m_len = buf_in.m_len+crypto_sold_size;
	buf_out.m_buf = new char [buf_out.m_len];
	memcpy ((unsigned char*)buf_out.m_buf+crypto_sold_size, buf_in.m_buf, buf_in.m_len);
	*(unsigned short*)buf_out.m_buf = crypto_sold;
	for (unsigned i = crypto_sold_size; static_cast<int>(i)<buf_out.m_len;i++) {
		*((unsigned char*)buf_out.m_buf+i)= *((unsigned char*)buf_out.m_buf+i) ^ make_crypt_mask (i-crypto_sold_size+1,crypto_sold);
	}
}

void SimpleCrypto::decrypt(const Buffer& buf_in, Buffer& buf_out) {
	unsigned short crypto_sold;
	std::string result;
	crypto_sold = *(unsigned short*)(buf_in.m_buf);
	unsigned char* buffer = new unsigned char[buf_in.m_len];
	unsigned buf_len=0;
	for (unsigned i=crypto_sold_size; static_cast<int>(i)<buf_in.m_len;i++) {
		unsigned char crypto_tail;
		crypto_tail = *((unsigned char*)buf_in.m_buf+i);
		unsigned char ch = static_cast<unsigned char>( crypto_tail ^ make_crypt_mask (i-crypto_sold_size+1,crypto_sold)); 
		buffer[buf_len] = ch;
		buf_len++;
	}
	buf_out.m_buf = new char [buf_len];
	buf_out.m_len = buf_len;
	memcpy (buf_out.m_buf, buffer, buf_len);
	delete []buffer;
}

unsigned char SimpleCrypto::make_crypt_mask (int index, unsigned short crypt_sold) {
	unsigned char mask = (unsigned char)((crypt_sold >> (8*(index%2))) & 0xFF);
	return ~((unsigned char)(index & 0xFF)) ^ mask;
}
//#UC END# *450133450138*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

