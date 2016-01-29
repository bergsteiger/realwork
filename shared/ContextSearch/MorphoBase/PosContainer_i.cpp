////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/PosContainer_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::PosContainer_i
//
// Имплементация IPosContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/MorphoBase/PosContainer_i.h"
// by <<uses>> dependencies
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Relevancy/RelevancyFactories.h"

namespace ContextSearch {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PosContainer_i::PosContainer_i (size_t max_fragment, size_t sz)
//#UC START# *52E64CB50277_BASE_INIT*
	: m_has_block (false)
	, m_max_fragment (max_fragment + Relevancy::EXT_LEN)
	, m_pos (0)
	, m_min (0)
//#UC END# *52E64CB50277_BASE_INIT*
{
	//#UC START# *52E64CB50277_BODY*
	m_data.resize (sz);
	//#UC END# *52E64CB50277_BODY*
}

PosContainer_i::~PosContainer_i () {
	//#UC START# *52E64B30031F_DESTR_BODY*
	//#UC END# *52E64B30031F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка
bool PosContainer_i::check (unsigned long pos) {
	//#UC START# *52E67E6400F8*
	if ((m_min->front () & POS_TEXT) > pos + m_max_fragment) {
		return false;
	}

	DBCore::ULongVector::const_iterator it = m_min->begin (), it_end = m_min->end (); 

	for (; it != it_end; ++it) {
		if ((*it & POS_TEXT) > pos) {
			if ((*it & POS_TEXT) - pos < m_max_fragment) {
				break;
			}
		} else {
			if (pos - (*it & POS_TEXT) < m_max_fragment) {
				break;
			}
		}
	}

	return (it != it_end);
	//#UC END# *52E67E6400F8*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DBCore::IPosContainer
// добавить
bool PosContainer_i::add (unsigned long val) {
	//#UC START# *52E6498E03D7_52E64B30031F*
	if ((val & POS_FLAGS) == POS_INVISIBLE_BLOCK) {
		m_has_block = true;
	} else if (m_min) {
		if ((m_min->back () & POS_TEXT) + m_max_fragment < (val & POS_TEXT)) {
			return false; // break;
		}
		if (this->check (val & POS_TEXT) == false) {
			return true;  // skip
		}
	}
	m_data [m_pos].push_back (val);
	return true;
	//#UC END# *52E6498E03D7_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// добавить
bool PosContainer_i::add (unsigned long pos, unsigned long flags) {
	//#UC START# *52E651C00137_52E64B30031F*
	if (flags == POS_INVISIBLE_BLOCK) {
		m_has_block = true;
	} else if (m_min) {
		if ((m_min->back () & POS_TEXT) + m_max_fragment < pos) {
			return false; // break;
		}
		if (this->check (pos) == false) {
			return true;  // skip
		}
	}
	m_data [m_pos].push_back (flags + pos);
	return true;
	//#UC END# *52E651C00137_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// данные
const DBCore::ContextPositions& PosContainer_i::get () const {
	//#UC START# *52E65637020F_52E64B30031F*
	return m_data;
	//#UC END# *52E65637020F_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// имеет блочную позицию
bool PosContainer_i::has_block () const {
	//#UC START# *52E664D1024F_52E64B30031F*
	return m_has_block;
	//#UC END# *52E664D1024F_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// ссылка на текущий элемент
const DBCore::ULongVector& PosContainer_i::ref () const {
	//#UC START# *52E68BC80267_52E64B30031F*
	return m_data [m_pos];
	//#UC END# *52E68BC80267_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// очистить
void PosContainer_i::reset () {
	//#UC START# *52E68E890017_52E64B30031F*
	m_has_block = false;
	//#UC END# *52E68E890017_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// настроится на элемент
void PosContainer_i::set (size_t pos) {
	//#UC START# *52E664FD036F_52E64B30031F*
	m_pos = pos;
	m_data [pos].clear ();
	m_data [pos].reserve (1024);
	//#UC END# *52E664FD036F_52E64B30031F*
}

// implemented method from DBCore::IPosContainer
// указываем на вектор с минимальным набором вхождений
void PosContainer_i::set_min (const DBCore::ULongVector& in) {
	//#UC START# *52E68C0D01B8_52E64B30031F*
	m_min = &in;
	//#UC END# *52E68C0D01B8_52E64B30031F*
}
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

