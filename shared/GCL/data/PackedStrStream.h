////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/PackedStrStream.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::data::PackedStrStream
//
// объединяет любое кол-во входных данных (целых чисел, строк (без ограничения формата)) в один
// непрерывный строковый ASCII буфер, с возможностью последующего извлечения всех введенных данных
// (по принципу стека). имеет лучшие показатели размера объединенного буфера, за счет строковой
// упаковки чисел.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_PACKEDSTRSTREAM_H__
#define __SHARED_GCL_DATA_PACKEDSTRSTREAM_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *4501364F0290_USER_INCLUDES*
#include <vector>

/*
usage:
	GCL::PackedStrStream pss;
	
	const char* in1 = "abcd";
	long in2 = 100;
	long in3 = 101;

	pss << in1;
	pss << in2;
	pss << in3;

	LOG_D (("pss is \"%s\" (%d, %d)", pss.str(), pss.length(), pss.item_count()));

	Core::Aptr<char> out;
	pss >> out.out();
	LOG_D (("out1 is \"%s\"", out.ptr()));
	
	long l_out;
	pss >> l_out;
	LOG_D (("out2 is %d", l_out));
	pss >> l_out;
	LOG_D (("out2 is %d", l_out));

output:
	pss is "Дabcdфх" (7, 3)
	out1 is "abcd"
	out2 is 100
	out2 is 101

implementation buffer format:
		  byte 1    byte 2     byte 3     byte 4    byte 5
		1VVVVVVV      -          -          -          -
		01VVVVVV   VVVVVVVV      -          -          -
		001VVVVV   VVVVVVVV   VVVVVVVV      -          -
		0001VVVV   VVVVVVVV   VVVVVVVV   VVVVVVVV      -
		0000MMMM      D         D(?)       D(?)       D(?)

  V..V - value (non zerro)
  M..M - byte mask
  D    - data (non zerro)
*/

//#UC END# *4501364F0290_USER_INCLUDES*

namespace GCL {

//#UC START# *4501364F0290_USER_DEFINITION*
class PackedStrStream {
public:
	PackedStrStream (unsigned size = 0) {
		m_buf.resize(size);
		m_item_count = 0;		
	}
	
	PackedStrStream (const char* str) : m_buf (str) {
		m_item_count = 0;		
	}

	virtual ~PackedStrStream () {
	}

	bool operator < (const PackedStrStream& c) const {
		return m_buf < c.m_buf;
	}

	void operator << (const char* str) {
		size_t len = strlen(str);
		(*this) << (unsigned long)len;

		for (unsigned int l=0; l < len; l++) {
			m_buf << str[l];
		}
	}

	void operator >> (char*& str) {
		unsigned long len;
		(*this) >> len;

		str = new char[len+1];
		str[len] = 0;

		for (unsigned long l=0; l < len; l++) {
			m_buf >> str[l];
		}
	}

	void operator << (long l) {
		this->operator << ((unsigned long)l);
	}

	void operator << (unsigned long l) {
		// this code may be not optimized
		m_item_count++;

		register char first_byte = 0;
		register const char* p = (const char*) &l;
		
		if (p[3]&0xF0) {
			first_byte |= 0x08;
		}				
	
		if (p[2]) {
			if (first_byte || p[2]&0xE0) {
				first_byte |= 0x04;
				if (p[3]) {
					first_byte |= 0x08;
				}
			} 
		} else if (p[3]) {
			first_byte |= 0x08;
		}

		if (p[1]) {
			if (first_byte || p[1]&0xC0) {
				first_byte |= 0x02;
				if (p[2]) {
					first_byte |= 0x04;
				}
				if (p[3]) {
					first_byte |= 0x08;
				}
			}
		} else {
			if (p[2]) {
				first_byte |= 0x04;
			}
			if (p[3]) {
				first_byte |= 0x08;
			}
		}

		if (p[0]) {
			if (first_byte || p[0]&0x80) {
				first_byte |= 0x01;
				if (p[1]) {
					first_byte |= 0x02;
				}
				if (p[2]) {
					first_byte |= 0x04;
				}
				if (p[3]) {
					first_byte |= 0x08;
				}
			}
		} else {
			if (p[1]) {
				first_byte |= 0x02;
			}
			if (p[2]) {
				first_byte |= 0x04;
			}
			if (p[3]) {
				first_byte |= 0x08;
			}
		}

		if (first_byte) {
			m_buf << first_byte;
			if (p[3]) {
				m_buf << p[3];
			}
			if (p[2]) {
				m_buf << p[2];
			}
			if (p[1]) {
				m_buf << p[1];
			}
			if (p[0]) {
				m_buf << p[0];
			}			
		} else {
			if (p[3]) {
				first_byte = p[3];
				first_byte |= 0x10;
				m_buf << first_byte;
				m_buf << p[2];
				m_buf << p[1];
				m_buf << p[0];
			} else if (p[2]) {
				first_byte = p[2];
				first_byte |= 0x20;
				m_buf << first_byte;
				m_buf << p[1];
				m_buf << p[0];
			} else if (p[1]) {
				first_byte = p[1];
				first_byte |= 0x40;
				m_buf << first_byte;
				m_buf << p[0];
			} else {
				first_byte = p[0];
				first_byte |= 0x80;
				m_buf << first_byte;
			}
		}
	}

	void operator >> (long& l) {
		unsigned long wrap;
		this->operator >> (wrap);
		l = (long)wrap;
	}

	void operator >> (unsigned long& l) {
		l = 0;
		register char* p = (char*) &l;
		register char first_byte;
		m_buf >> first_byte;

		if ((first_byte & 0xF0) == 0x10) {
			p[3] = first_byte & 0x0F;
			m_buf >> p[2];
			m_buf >> p[1];
			m_buf >> p[0];
		} else if ((first_byte & 0xE0) == 0x20) {
			p[2] = first_byte & 0x1F;
			m_buf >> p[1];
			m_buf >> p[0];
		} else if ((first_byte & 0xC0) == 0x40) {
			p[1] = first_byte & 0x3F;
			m_buf >> p[0];
		} else if (first_byte & 0x80) {
			p[0] = first_byte & 0x7F;
		} else {
			if (first_byte & 0x08) {
				m_buf >> p[3];
			}
			if (first_byte & 0x04) {
				m_buf >> p[2];
			}
			if (first_byte & 0x02) {
				m_buf >> p[1];
			}
			if (first_byte & 0x01) {
				m_buf >> p[0];
			}
		}
	}

	const char* str () const {
		m_buf << 0;
		return m_buf.begin();		
	}
	unsigned length () {
		return m_buf.size();
	}
	unsigned item_count () {
		return m_item_count;
	}

private:
	// std::vector is not good solution for dynamic binary stream
	class IOStream: public std::vector<char> {
	public:
		IOStream () {
			m_it = 0;
		}

		IOStream (const char* str) : std::vector<char>(str, str + strlen(str)) {
			m_it = 0;
		}

		inline void operator << (char c) {
			this->push_back(c);
		}

		inline void operator >> (char& c) {
			c = *(this->begin() + m_it);
			m_it++;
		}

	protected:
		unsigned m_it;
	};

private:
	mutable IOStream m_buf;
	unsigned m_item_count;
};
//#UC END# *4501364F0290_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_DATA_PACKEDSTRSTREAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
