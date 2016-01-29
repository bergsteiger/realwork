////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FindIterator_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FindIterator_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FindIterator_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FindIterator_i::FindIterator_i (GTree::FindIterator* iterator)
//#UC START# *45EEC282029F_45FA9B1E03D8_45F6C42C00DA_BASE_INIT*
//#UC END# *45EEC282029F_45FA9B1E03D8_45F6C42C00DA_BASE_INIT*
{
	//#UC START# *45EEC282029F_45FA9B1E03D8_45F6C42C00DA_BODY*
	m_cur_node = GTree::ROOT_POINT;
	m_srv_iter = iterator;
	m_dir = ID_FORWARD;
	//this->next ();
	//#UC END# *45EEC282029F_45FA9B1E03D8_45F6C42C00DA_BODY*
}

FindIterator_i::~FindIterator_i () {
	//#UC START# *45F6C42C00DA_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_srv_iter)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_srv_iter.in ());
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *45F6C42C00DA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from FindIterator
// количество найденных фрагментов
const unsigned long FindIterator_i::get_count () const {
	//#UC START# *49FFDC8B015D_45F6C42C00DA_GET*
	return m_srv_iter->get_count ();
	//#UC END# *49FFDC8B015D_45F6C42C00DA_GET*
}

// implemented method from FindIterator
FindPositionList* FindIterator_i::get_position () const {
	//#UC START# *461D00B9005D_45F6C42C00DA*
	Core::Aptr<FindPositionList> pos_list = new FindPositionList (m_cur_pos->length ());
	for (CORBA::ULong i = 0; i < m_cur_pos->length (); ++i) {
		const GTree::FindPosition& srv_pos = m_cur_pos [i];

		GDS_ASSERT (srv_pos.node._d () == GTree::PT_INDEX);
		DefaultNodeBase::srv_path_to_adapter (const_cast<GTree::NodeIndexPath*> (&srv_pos.node.index_path ()), (*pos_list.ptr ())[i].node);

		(*pos_list.ptr ())[i].begin = srv_pos.begin;
		(*pos_list.ptr ())[i].end = srv_pos.end;
	}
	return pos_list.forget ();
	//#UC END# *461D00B9005D_45F6C42C00DA*
}

// implemented method from FindIterator
// возвращает true, если нельзя перейти на предыдущий фрагмент
bool FindIterator_i::is_first () const {
	//#UC START# *49FEC51501D8_45F6C42C00DA*
	return m_srv_iter->is_first ();
	//#UC END# *49FEC51501D8_45F6C42C00DA*
}

// implemented method from FindIterator
// Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за
// концом, т.е. равен end или вообще пуст
bool FindIterator_i::is_good () const {
	//#UC START# *45EEC28202A2_45F6C42C00DA*
	return (m_cur_pos.ptr () != 0) && (m_cur_pos->length () > 0);
	//#UC END# *45EEC28202A2_45F6C42C00DA*
}

// implemented method from FindIterator
// Перемещенеи итератора на следующий элемент.
void FindIterator_i::next () {
	//#UC START# *45EEC28202A0_45F6C42C00DA*
	/*if (m_dir != ID_FORWARD) {
		m_srv_iter->move_to (2);
		m_dir = ID_FORWARD;
	}*/
	m_cur_pos = m_srv_iter->next ();
	//#UC END# *45EEC28202A0_45F6C42C00DA*
}

// implemented method from FindIterator
// Перемещенеи итератора на предыдущий элемент.
void FindIterator_i::prev () {
	//#UC START# *45EEC28202A1_45F6C42C00DA*
	/*if (m_dir != ID_BACKWARD) {
		m_srv_iter->move_to (-2);
		m_dir = ID_BACKWARD;
	}*/
	m_cur_pos = m_srv_iter->prev ();
	//#UC END# *45EEC28202A1_45F6C42C00DA*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

