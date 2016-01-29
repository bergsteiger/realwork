////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/BinaryString_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::BinaryString_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCI/impl/IO_i/BinaryString_i.h"

//#UC START# *4EBBA53C0205_CUSTOM_INCLUDES*
#include <cstring>

#include "boost/scoped_array.hpp"
//#UC END# *4EBBA53C0205_CUSTOM_INCLUDES*

namespace GCI {
namespace IO_i {

//#UC START# *4EBBA53C0205*
//#UC END# *4EBBA53C0205*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BinaryString_i::BinaryString_i (const void* buffer, size_t size)
//#UC START# *4EBBA26A00D3_4BB43FE900B4_4EBBA53C0205_BASE_INIT*
	: m_data (reinterpret_cast<const char*> (buffer), size), m_page (0)
//#UC END# *4EBBA26A00D3_4BB43FE900B4_4EBBA53C0205_BASE_INIT*
{
	//#UC START# *4EBBA26A00D3_4BB43FE900B4_4EBBA53C0205_BODY*
	//#UC END# *4EBBA26A00D3_4BB43FE900B4_4EBBA53C0205_BODY*
}

BinaryString_i::~BinaryString_i () {
	//#UC START# *4EBBA53C0205_DESTR_BODY*
	//#UC END# *4EBBA53C0205_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IO::String
// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
const char* BinaryString_i::add (const char* str) {
	//#UC START# *43185CB60312_4EBBA53C0205*
	m_data += str;
	return m_data.data ();
	//#UC END# *43185CB60312_4EBBA53C0205*
}

// implemented method from IO::String
// добавляет к строке переданную подстроку, возвращает указатель на свой буфер
const char* BinaryString_i::add (const IO::String* str) {
	//#UC START# *43185CF2021E_4EBBA53C0205*
	m_data += std::string (str->get_data (), str->get_length ());
	return m_data.data ();
	//#UC END# *43185CF2021E_4EBBA53C0205*
}

// implemented method from IO::String
// кодовая страница
short BinaryString_i::get_code_page () const {
	//#UC START# *431860270052_4EBBA53C0205_GET*
	return m_page;
	//#UC END# *431860270052_4EBBA53C0205_GET*
}

void BinaryString_i::set_code_page (short code_page) {
	//#UC START# *431860270052_4EBBA53C0205_SET*
	m_page = code_page;
	//#UC END# *431860270052_4EBBA53C0205_SET*
}

// implemented method from IO::String
// указатель на начало аллоцированного буфера (строки)
const char* BinaryString_i::get_data () const {
	//#UC START# *431841610371_4EBBA53C0205_GET*
	return m_data.data ();
	//#UC END# *431841610371_4EBBA53C0205_GET*
}

// implemented method from IO::String
// возвращает новую строку равную объединению текущей и переданной
char* BinaryString_i::join (const char* str) const {
	//#UC START# *43185E8E0375_4EBBA53C0205*
	std::string joined (m_data);
	joined += str;
	char* result = new char [joined.size () + 1];
	std::memcpy (result, m_data.data (), joined.size ());
	result [joined.size ()] = 0;

	return result;
	//#UC END# *43185E8E0375_4EBBA53C0205*
}

// implemented method from IO::String
// возвращает новую строку равную объединению текущей и переданной
char* BinaryString_i::join (const IO::String* str) const {
	//#UC START# *43185EB40008_4EBBA53C0205*
	std::string joined (m_data);
	joined += std::string (str->get_data (), str->get_length ());
	char* result = new char [joined.size () + 1];
	std::memcpy (result, m_data.data (), joined.size ());
	result [joined.size ()] = 0;

	return result;
	//#UC END# *43185EB40008_4EBBA53C0205*
}

// implemented method from IO::String
// длинна текстовой строки
unsigned long BinaryString_i::get_length () const {
	//#UC START# *43184161036F_4EBBA53C0205_GET*
	return static_cast<unsigned long> (m_data.size ());
	//#UC END# *43184161036F_4EBBA53C0205_GET*
}

// implemented method from IO::String
// размер аллоцированого буфера, для хранения текстовой строки
unsigned long BinaryString_i::get_maximum () const {
	//#UC START# *431841610370_4EBBA53C0205_GET*
	return static_cast<unsigned long> (m_data.capacity ());
	//#UC END# *431841610370_4EBBA53C0205_GET*
}

void BinaryString_i::set_maximum (unsigned long maximum) {
	//#UC START# *431841610370_4EBBA53C0205_SET*
	m_data.reserve (maximum);
	//#UC END# *431841610370_4EBBA53C0205_SET*
}

// implemented method from IO::String
// Захватывает переданную строку. Если аргумент, задающий длину, меньше чем strlen(str) + 1, то
// длина строки принимается равной длине строки + 1. Память под передаваемый аргумент str ДОЛЖНА
// БЫТЬ ВЫДЕЛЕНА оператором new[], так как в деструкторе вызывается оператор delete[].
void BinaryString_i::reset (char* str, unsigned long maximum) {
	//#UC START# *431841610363_4EBBA53C0205*
	m_data = str;
	delete [] str;
	m_data.reserve (maximum);
	//#UC END# *431841610363_4EBBA53C0205*
}

// implemented method from IO::String
// устанавливает значение строки равное переданному (переданная строка копируеться)
void BinaryString_i::reset (const char* str) {
	//#UC START# *431841610366_4EBBA53C0205*
	m_data = str;
	//#UC END# *431841610366_4EBBA53C0205*
}

// implemented method from IO::String
// возвращает бинарную копию строки
IO::String* BinaryString_i::strdup () const {
	//#UC START# *431841610362_4EBBA53C0205*
	return new BinaryString_i (m_data.data (), m_data.size ());
	//#UC END# *431841610362_4EBBA53C0205*
}
} // namespace IO_i
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

