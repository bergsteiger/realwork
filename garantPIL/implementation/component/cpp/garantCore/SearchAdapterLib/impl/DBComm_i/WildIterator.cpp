////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildIterator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildIterator
//
// WildIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/WildIterator.h"

namespace SearchAdapterLib {
namespace DBComm_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

WildIterator::WildIterator ()
//#UC START# *4ED488850143_BASE_INIT*
	: m_max_count (0), m_count (0)
//#UC END# *4ED488850143_BASE_INIT*
{
	//#UC START# *4ED488850143_BODY*
	//#UC END# *4ED488850143_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// get_count
size_t WildIterator::get_count () const {
	//#UC START# *4ED4AC0F03C9*
	return m_count;
	//#UC END# *4ED4AC0F03C9*
}

// get_max_count
size_t WildIterator::get_max_count () const {
	//#UC START# *4ED4ABE50165*
	return m_max_count;
	//#UC END# *4ED4ABE50165*
}

// init
bool WildIterator::init (const std::string& mask, DBCore::IIndex* index) {
	//#UC START# *4ED49A180247*
	size_t word_size = mask.size () - 1;

	m_mask = mask;
	bool is_wild = (m_mask [word_size] == '*');

	if (is_wild) {
		m_mask = m_mask.substr (0, word_size);
		m_it = index->make_iterator ();

		for (m_it->Set (m_mask.c_str ()); !m_it->End (); m_it->next (), ++m_max_count) {
			if (ACE_OS::memcmp ((const char*) m_it->Key (), m_mask.c_str (), m_mask.size ()) != 0) {
				break;
			}
		}

		m_it->Set (m_mask.c_str ());
	} 

	return is_wild;
	//#UC END# *4ED49A180247*
}

// is_best
bool WildIterator::is_best () const {
	//#UC START# *4ED4AC3002DF*
	return m_count < m_max_count;
	//#UC END# *4ED4AC3002DF*
}

// key
const char* WildIterator::key () const {
	//#UC START# *4ED4AD3C01D3*
	if (m_it.is_nil ()) {
		return m_mask.c_str ();
	} else {
		return (char*) m_it->Key ();
	}
	//#UC END# *4ED4AD3C01D3*
}

// next
void WildIterator::next () {
	//#UC START# *4ED4ABC401F0*
	++m_count;

	if (m_it.is_nil () == false) {
		m_it->next ();
	}
	//#UC END# *4ED4ABC401F0*
}

// rewind
void WildIterator::rewind () {
	//#UC START# *4ED4AB8B022E*
	m_count = 0;

	if (m_it.is_nil () == false) {
		m_it->Set (m_mask.c_str ());
	}
	//#UC END# *4ED4AB8B022E*
}

} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

