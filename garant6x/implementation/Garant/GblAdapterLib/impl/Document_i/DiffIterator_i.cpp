////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i.h"

//#UC START# *4B4EE41D0386_CUSTOM_INCLUDES*
#include "boost/lexical_cast.hpp"
//#UC END# *4B4EE41D0386_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4B4EE41D0386*
//#UC END# *4B4EE41D0386*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DiffIterator_i::DiffIterator_i (const GblPilot::DiffData& diff_data)
//#UC START# *4B4EE046030D_4CC96279013F_4B4EE41D0386_BASE_INIT*
: m_pos (0), m_list (diff_data.para_list.length ())
//#UC END# *4B4EE046030D_4CC96279013F_4B4EE41D0386_BASE_INIT*
{
	//#UC START# *4B4EE046030D_4CC96279013F_4B4EE41D0386_BODY*
	// см. http://mdp.garant.ru/x/UbkMIw
	// GDS_ASSERT (!m_list.empty ());

	for (size_t i = 0, size = diff_data.cur_para_index.length (); i < size; ++i) {
		m_cur_para_index [diff_data.cur_para_index [i]] = i;
	}
	
	for (size_t i = 0, size = diff_data.prev_para_index.length (); i < size; ++i) {
		m_prev_para_index [diff_data.prev_para_index [i]] = i;
	}

	for (size_t i = 0, size = diff_data.para_list.length (); i < size; ++i) {
		m_list [i].id = diff_data.para_list [i];

		std::map<unsigned long, long>::const_iterator cur_it = m_cur_para_index.find (m_list [i].id);
		if (cur_it != m_cur_para_index.end ()) {
			m_list [i].cur_para_num = (cur_it->second);
		}
		
		std::map<unsigned long, long>::const_iterator prev_it = m_prev_para_index.find (m_list [i].id);
		if (prev_it != m_prev_para_index.end ()) {
			m_list [i].prev_para_num = (prev_it->second);
		}
	}
	//#UC END# *4B4EE046030D_4CC96279013F_4B4EE41D0386_BODY*
}

DiffIterator_i::~DiffIterator_i () {
	//#UC START# *4B4EE41D0386_DESTR_BODY*
	//#UC END# *4B4EE41D0386_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DiffIterator
ParaNum DiffIterator_i::acquire_next () const {
	//#UC START# *4B601C0800C3_4B4EE41D0386*
	if (this->has_next ()) {
		GDS_ASSERT (m_pos < m_list.size ());
		return m_list [m_pos].id;
	}

	throw CanNotFindData ();
	//#UC END# *4B601C0800C3_4B4EE41D0386*
}

// implemented method from DiffIterator
ParaNum DiffIterator_i::acquire_prev () const {
	//#UC START# *4B62D7640025_4B4EE41D0386*
	if (this->has_prev ()) {
		GDS_ASSERT (m_pos > 0 && m_pos <= m_list.size ());
		return m_list [m_pos - 1].id;
	}
	
	throw CanNotFindData ();
	//#UC END# *4B62D7640025_4B4EE41D0386*
}

// implemented method from DiffIterator
bool DiffIterator_i::has_next () const {
	//#UC START# *4B4EE0E000B0_4B4EE41D0386*
	return m_pos < m_list.size ();
	//#UC END# *4B4EE0E000B0_4B4EE41D0386*
}

// implemented method from DiffIterator
bool DiffIterator_i::has_prev () const {
	//#UC START# *4B4EE1060152_4B4EE41D0386*
	return m_pos > 0;
	//#UC END# *4B4EE1060152_4B4EE41D0386*
}

// implemented method from DiffIterator
void DiffIterator_i::move_to (ParaNum para) /*throw (CanNotFindData)*/ {
	//#UC START# *4B4EE16E00EC_4B4EE41D0386*
	std::map<unsigned long, long>::const_iterator cur_it = m_cur_para_index.find (para);
	long cur_para_num = cur_it != m_cur_para_index.end () ? cur_it->second : -1;

	std::map<unsigned long, long>::const_iterator prev_it = m_prev_para_index.find (para);
	long prev_para_num = prev_it != m_prev_para_index.end () ? prev_it->second : -1;

	if (cur_para_num == -1 && prev_para_num == -1) {
		throw CanNotFindData (); 
	}

	for (size_t i = 0; i < m_list.size (); ++i) {
		if (
			   cur_para_num  != -1 && m_list[i].cur_para_num  >= cur_para_num
			|| prev_para_num != -1 && m_list[i].prev_para_num >= prev_para_num
		) {
			m_pos = i;
			return;
		}
	}
	
	m_pos = m_list.size ();
	//#UC END# *4B4EE16E00EC_4B4EE41D0386*
}

// implemented method from DiffIterator
ParaNum DiffIterator_i::next () /*throw (CanNotFindData)*/ {
	//#UC START# *4B4EE1330087_4B4EE41D0386*
	ParaNum next = this->acquire_next ();
	++m_pos;
	return next;
	//#UC END# *4B4EE1330087_4B4EE41D0386*
}

// implemented method from DiffIterator
ParaNum DiffIterator_i::prev () /*throw (CanNotFindData)*/ {
	//#UC START# *4B4EE156033B_4B4EE41D0386*
	ParaNum prev = this->acquire_prev ();
	--m_pos;
	return prev;
	//#UC END# *4B4EE156033B_4B4EE41D0386*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

