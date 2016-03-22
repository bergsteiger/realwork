////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/String_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::String_i
//
// Реализация интерфейса строки.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/IO_i/String_i.h"
// by <<uses>> dependencies
#include <cstring>

namespace GCI {
namespace IO_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

String_i::String_i (const char* str)
//#UC START# *431841610361_461384D70213_4318633F03C2_BASE_INIT*
	: m_string (0), m_max (0), m_page (0)
//#UC END# *431841610361_461384D70213_4318633F03C2_BASE_INIT*
{
	//#UC START# *431841610361_461384D70213_4318633F03C2_BODY*
	this->init (str);
	//#UC END# *431841610361_461384D70213_4318633F03C2_BODY*
}

String_i::String_i (const char* str, short code_page)
//#UC START# *431841610361_433105CC02D0_4318633F03C2_BASE_INIT*
	: m_string (0), m_max (0), m_page (code_page)
//#UC END# *431841610361_433105CC02D0_4318633F03C2_BASE_INIT*
{
	//#UC START# *431841610361_433105CC02D0_4318633F03C2_BODY*
	this->init (str);
	//#UC END# *431841610361_433105CC02D0_4318633F03C2_BODY*
}

String_i::String_i (char* str, short code_page)
//#UC START# *431841610361_4613871A00EA_4318633F03C2_BASE_INIT*
	: m_string (str), m_page (code_page)
//#UC END# *431841610361_4613871A00EA_4318633F03C2_BASE_INIT*
{
	//#UC START# *431841610361_4613871A00EA_4318633F03C2_BODY*
	m_max = str ? static_cast<unsigned long> (std::strlen (str) + 1) : 0;
	//#UC END# *431841610361_4613871A00EA_4318633F03C2_BODY*
}

String_i::String_i (unsigned long maximum)
//#UC START# *431841610361_43184161036A_4318633F03C2_BASE_INIT*
	: m_string (0), m_max(maximum), m_page(0)
//#UC END# *431841610361_43184161036A_4318633F03C2_BASE_INIT*
{
	//#UC START# *431841610361_43184161036A_4318633F03C2_BODY*
	if (maximum) {
		m_string = new char[maximum];
		m_string[0]  = 0;
	}
	//#UC END# *431841610361_43184161036A_4318633F03C2_BODY*
}

String_i::~String_i () {
	//#UC START# *4318633F03C2_DESTR_BODY*
	delete[] m_string;
	//#UC END# *4318633F03C2_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// инициализирует объект переданным значением строки
void String_i::init (const char* str) {
	//#UC START# *461399A90399*
	m_max = str ? static_cast<unsigned long> (std::strlen (str) + 1) : 0;
	if (m_max) {
		m_string = new char[m_max];
		std::memcpy (m_string, str, m_max);
	}
	//#UC END# *461399A90399*
}

void String_i::init (const char* str, size_t size) {
	//#UC START# *4BB4417C016B*
	GDS_ASSERT (str);
	if (!size) {
		return;
	}
	if (str [size - 1]) { // строка без завершающего нулевого символа
		m_max = static_cast<unsigned long> (size + 1);
		m_string = new char[m_max];
		std::memcpy (m_string, str, size);
		m_string[size] = 0;
	} else {
		this->init (str);
	}
	//#UC END# *4BB4417C016B*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IO::String
// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
const char* String_i::add (const char* str) {
	//#UC START# *43185CB60312_4318633F03C2*
	if (!str) {
		return m_string;
	}

	unsigned long alen = static_cast<unsigned long> (std::strlen (str));
	unsigned long len = m_string ? static_cast<unsigned long> (std::strlen (m_string)) : 0;
	if (len + alen + 1 <= m_max) {
		GDS_ASSERT(m_string);
		std::memcpy (m_string + len, str, alen + 1);
	} else {
		char* new_str = new char [len + alen + 1];
		std::memcpy (new_str, m_string, len);
		std::memcpy (new_str + len, str, alen + 1);
		this->reset (new_str, len + alen + 1);
	}
	return m_string;
	//#UC END# *43185CB60312_4318633F03C2*
}

// implemented method from IO::String
// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
const char* String_i::add (const IO::String* str) {
	//#UC START# *43185CF2021E_4318633F03C2*
	return this->add (str->get_data ());
	//#UC END# *43185CF2021E_4318633F03C2*
}

// implemented method from IO::String
// кодовая страница
short String_i::get_code_page () const {
	//#UC START# *431860270052_4318633F03C2_GET*
	return m_page;
	//#UC END# *431860270052_4318633F03C2_GET*
}

void String_i::set_code_page (short code_page) {
	//#UC START# *431860270052_4318633F03C2_SET*
	m_page = code_page;
	//#UC END# *431860270052_4318633F03C2_SET*
}

// implemented method from IO::String
// указатель на начало аллоцированного буфера (строки)
const char* String_i::get_data () const {
	//#UC START# *431841610371_4318633F03C2_GET*
	return m_string;
	//#UC END# *431841610371_4318633F03C2_GET*
}

// implemented method from IO::String
// возвращает новую строку равную объединению текущей и переданной
char* String_i::join (const char* str) const {
	//#UC START# *43185E8E0375_4318633F03C2*
	unsigned long jlen = str ? static_cast<unsigned long> (std::strlen (str)) : 0;
	unsigned long len = m_string ? static_cast<unsigned long> (std::strlen (m_string)) : 0;
	if (!(jlen + len)) {
		return 0;
	}
	char* new_str = new char [len + jlen + 1];
	if (jlen) {
		std::memcpy (new_str, m_string, len);
		std::memcpy (new_str + len, str, jlen + 1);
	}
	else {
		std::memcpy (new_str, m_string, len + 1);
	}
	return new_str;
	//#UC END# *43185E8E0375_4318633F03C2*
}

// implemented method from IO::String
// возвращает новую строку равную объединению текущей и переданной
char* String_i::join (const IO::String* str) const {
	//#UC START# *43185EB40008_4318633F03C2*
	return this->join (str->get_data ());
	//#UC END# *43185EB40008_4318633F03C2*
}

// implemented method from IO::String
// длинна текстовой строки
unsigned long String_i::get_length () const {
	//#UC START# *43184161036F_4318633F03C2_GET*
	return m_string ? static_cast<unsigned long> (std::strlen (m_string)) : 0;
	//#UC END# *43184161036F_4318633F03C2_GET*
}

// implemented method from IO::String
// размер аллоцированого буфера, для хранения текстовой строки
unsigned long String_i::get_maximum () const {
	//#UC START# *431841610370_4318633F03C2_GET*
	return m_max;
	//#UC END# *431841610370_4318633F03C2_GET*
}

void String_i::set_maximum (unsigned long maximum) {
	//#UC START# *431841610370_4318633F03C2_SET*
	if (!maximum) {
		delete[] m_string;
		m_string = 0;
		m_max = 0;
		return;
	}

	char* temp = m_string;
	m_string = new char[maximum];
	std::memcpy (m_string, temp, std::min<unsigned long> (maximum, m_max));
	if (maximum < m_max) {
		m_string[maximum - 1] = 0;
	}
	m_max = maximum;
	delete temp;
	//#UC END# *431841610370_4318633F03C2_SET*
}

// implemented method from IO::String
// Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то
// длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА
// БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[].
void String_i::reset (char* str, unsigned long maximum) {
	//#UC START# *431841610363_4318633F03C2*
	if (str) {
		delete[] m_string;
		unsigned long len = static_cast<unsigned long> (std::strlen (str) + 1);
		m_max = std::max<unsigned long> (maximum, len);
		m_string = str;
	}
	//#UC END# *431841610363_4318633F03C2*
}

// implemented method from IO::String
// устанавливает значение строки равное переданному (переданная строка копируеться)
void String_i::reset (const char* str) {
	//#UC START# *431841610366_4318633F03C2*
	if (str == m_string) {
		return;
	}
	delete[] m_string;
	if (!str) {
		m_string = 0;
		m_max = 0;
		return;
	} else {
		m_max = static_cast<unsigned long> (std::strlen (str) + 1);
		m_string = new char[m_max];
		std::memcpy (m_string, str, m_max);
	}
	//#UC END# *431841610366_4318633F03C2*
}

// implemented method from IO::String
// возвращает бинарную копию строки
IO::String* String_i::strdup () const {
	//#UC START# *431841610362_4318633F03C2*
	return new String_i (m_string);
	//#UC END# *431841610362_4318633F03C2*
}
} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

