////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListEntryInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DynListNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListEntryInfo_i::ListEntryInfo_i (const GblPilot::ListEntryInfo& info, const NodeBase* root)
//#UC START# *45EEDB87037E_4609165700C5_460914B6006D_BASE_INIT*
	: m_lei (info), m_data_for_compare (0)
//#UC END# *45EEDB87037E_4609165700C5_460914B6006D_BASE_INIT*
{
	//#UC START# *45EEDB87037E_4609165700C5_460914B6006D_BODY*
	// TODO: переименовать 'm_data_for_compare' в 'm_hash_key'
	this->build_entry_list (root);
	std::string str;
	for (CORBA::ULong i = 0; i < m_lei.relevance_words_list.length (); ++i) {
		str += m_lei.relevance_words_list[i].in ();
	}
	m_data_for_compare = ACE::hash_pjw (str.c_str ());
	//#UC END# *45EEDB87037E_4609165700C5_460914B6006D_BODY*
}

ListEntryInfo_i::ListEntryInfo_i (const GblPilot::ListEntryInfo& info)
//#UC START# *45EEDB87037E_4609167D0029_460914B6006D_BASE_INIT*
	:	m_lei (info), m_data_for_compare (0), m_entry_list (new GblPilotDef::SubParaList ())
//#UC END# *45EEDB87037E_4609167D0029_460914B6006D_BASE_INIT*
{
	//#UC START# *45EEDB87037E_4609167D0029_460914B6006D_BODY*
	//#UC END# *45EEDB87037E_4609167D0029_460914B6006D_BODY*
}

ListEntryInfo_i::~ListEntryInfo_i () {
	//#UC START# *460914B6006D_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_lei.doc.in ())) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_lei.doc.in ());
		}
	} catch (CORBA::TRANSIENT&) {
		// do nothing, `CORBA::TRANSIENT` exception ignored
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *460914B6006D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void ListEntryInfo_i::build_entry_list (const NodeBase* root) {
	//#UC START# *46091FE7035A*
	NodeBase_cvar doc_node;
	if (GblAdapterLib::LNT_PARA == root->get_type () || GblAdapterLib::LNT_SUB == root->get_type ()) {
		doc_node = root->get_parent ();
	} else {
		doc_node = Core::IObject::_duplicate (root);
	}

	NodeBase_cvar nb (doc_node->get_first_child ());
	NodeBase_cvar nb_ret;
	long i = 0;
	while (nb.in ()) {
		if (
			GblAdapterLib::LNT_EDITIONS_GROUP == nb->get_type ()
			|| !dynamic_cast <const DynListNode_i*> (nb.ptr ())->get_block_position ()
		) {
			nb_ret = nb->get_next ();
			nb = nb_ret._retn ();
			continue;
		}
		i++;
		nb_ret = nb->get_next ();
		nb = nb_ret._retn ();
	}

	m_entry_list = new GblPilotDef::SubParaList ();
	m_entry_list->length (i);
	if (i) {
		m_data_for_compare = i;
		nb = doc_node->get_first_child ();
		i = 0;
		while (nb.in ()) {
			if (
				GblAdapterLib::LNT_EDITIONS_GROUP == nb->get_type ()
				|| 0 == const_cast <DynListNode_i*> (dynamic_cast <const DynListNode_i*> (nb.ptr ()))->get_block_position ()
			) {
				nb_ret = nb->get_next ();
				nb = nb_ret._retn ();
				continue;
			}
		
			if (GblAdapterLib::LNT_PARA == nb->get_type ()) {
				m_entry_list[i].m_para = const_cast <DynListNode_i*> (dynamic_cast <const DynListNode_i*> (nb.ptr ()))->get_block_position ();
				m_entry_list[i].m_sub = 0;
				m_data_for_compare = (m_data_for_compare<<4)^m_entry_list[i].m_para;
			} else {
				m_entry_list[i].m_para = 0;
				m_entry_list[i].m_sub = const_cast <DynListNode_i*> (dynamic_cast <const DynListNode_i*> (nb.ptr ()))->get_block_position ();
				m_data_for_compare = (m_data_for_compare<<4)^m_entry_list[i].m_sub;
			}
	
			i++;
			nb_ret = nb->get_next ();
			nb = nb_ret._retn ();
		}
	}
	//#UC END# *46091FE7035A*
}

bool ListEntryInfo_i::operator== (const ListEntryInfo_i* lei) const {
	//#UC START# *460930D9034D*
	return m_data_for_compare == lei->m_data_for_compare
		&& m_entry_list->length () == lei->m_entry_list->length ()
		&& ACE_OS::memcmp (
				m_entry_list->get_buffer ()
				, lei->m_entry_list->get_buffer ()
				, m_entry_list->length () * sizeof (GblPilotDef::SubPara)
			) == 0;
	//#UC END# *460930D9034D*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* ListEntryInfo_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_460914B6006D*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_460914B6006D*
}

// implemented method from EntityBase
// идентификатор
const unsigned long ListEntryInfo_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_460914B6006D_GET*
	return 0;
	//#UC END# *456EE084033C_460914B6006D_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool ListEntryInfo_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_460914B6006D_GET*
	return false;
	//#UC END# *456EB3E1017D_460914B6006D_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool ListEntryInfo_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_460914B6006D_GET*
	return true;
	//#UC END# *456EB3E1017C_460914B6006D_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* ListEntryInfo_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_460914B6006D*
	throw Unsupported ();
	//#UC END# *456EB3E10178_460914B6006D*
}

// implemented method from ListEntryInfo
const Document* ListEntryInfo_i::get_doc () const {
	//#UC START# *45EEDD3202B0_460914B6006D_GET*
	Document_var document (
		DocumentFactory::make (m_lei.pid, true /* is_edition */, 0 /*name*/, DocumentFactoryKeyHelper::PID_to_key (m_lei.pid))
	);
	dynamic_cast<Document_i*> (document.ptr ())->set_list_info (this);
	return document._retn ();
	//#UC END# *45EEDD3202B0_460914B6006D_GET*
}

Document* ListEntryInfo_i::get_doc () {
	return const_cast<Document*>(((const ListEntryInfo_i*)this)->get_doc ());
}

// implemented method from ListEntryInfo
const GblPilotDef::SubParaList& ListEntryInfo_i::get_entry_list () const {
	//#UC START# *4628809400B9_460914B6006D*
	GDS_ASSERT (m_entry_list.ptr ());
	return *m_entry_list.ptr ();
	//#UC END# *4628809400B9_460914B6006D*
}

// implemented method from ListEntryInfo
const GblPilotDef::WordList& ListEntryInfo_i::get_relevance_words_list () const {
	//#UC START# *462880EC03D6_460914B6006D*
	return m_lei.relevance_words_list;
	//#UC END# *462880EC03D6_460914B6006D*
}

// implemented method from ListEntryInfo
const PId ListEntryInfo_i::get_pid () const {
	//#UC START# *48AD91AA011D_460914B6006D_GET*
	PId pid;
	pid.class_id = m_lei.pid.m_class_id;
	pid.object_id = m_lei.pid.m_object_id;
	return pid;
	//#UC END# *48AD91AA011D_460914B6006D_GET*
}

// implemented method from ListEntryInfo
unsigned long ListEntryInfo_i::get_position () const {
	//#UC START# *45EEDB870381_460914B6006D_GET*
	if (m_lei.para) {
		LOG_D (("%s: para = %d", GDS_CURRENT_FUNCTION, m_lei.para));
		return m_lei.para;
	}
	LOG_D (("%s: sub = %d", GDS_CURRENT_FUNCTION, m_lei.sub));
	return m_lei.sub;
	//#UC END# *45EEDB870381_460914B6006D_GET*
}

// implemented method from ListEntryInfo
// Релевантность. Для списков без релевантности всегда 0.
const short ListEntryInfo_i::get_relevance () const {
	//#UC START# *45EEDB870382_460914B6006D_GET*
	return m_lei.relevance;
	//#UC END# *45EEDB870382_460914B6006D_GET*
}

// implemented method from ListEntryInfo
PositionType ListEntryInfo_i::get_type () const {
	//#UC START# *45EEDB870380_460914B6006D_GET*
	if (m_lei.para) {
		return PT_PARA;
	}
	return PT_SUB;
	//#UC END# *45EEDB870380_460914B6006D_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

