////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfoNode_i_factory.h"

//#UC START# *457452900109_CUSTOM_INCLUDES*
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeServerTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
//#UC END# *457452900109_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *457452900109*
//#UC END# *457452900109*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ComplectInfo_i::ComplectInfo_i ()
//#UC START# *45744F5A030D_45F16A9002C0_457452900109_BASE_INIT*
//#UC END# *45744F5A030D_45F16A9002C0_457452900109_BASE_INIT*
{
	//#UC START# *45744F5A030D_45F16A9002C0_457452900109_BODY*
	NotifyManagerFactory::make ().register_listener_for_notify (NT_BASE_UPDATE_END, this);
	//#UC END# *45744F5A030D_45F16A9002C0_457452900109_BODY*
}

ComplectInfo_i::~ComplectInfo_i () {
	//#UC START# *457452900109_DESTR_BODY*
	//#UC END# *457452900109_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ComplectInfo
const GCI::IO::String* ComplectInfo_i::get_dealer_info () const {
	//#UC START# *45744FD9009C_457452900109_GET*
	if (m_dealer_info.is_nil ()) {
		CORBA::String_var dealer_info = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_dealer_info ();
		m_dealer_info = GCI::IO::StringFactory::make (dealer_info.in ());
	}
	return m_dealer_info._sretn ();
	//#UC END# *45744FD9009C_457452900109_GET*
}

GCI::IO::String* ComplectInfo_i::get_dealer_info () {
	return const_cast<GCI::IO::String*>(((const ComplectInfo_i*)this)->get_dealer_info ());
}

// implemented method from ComplectInfo
VisualRepresentationList* ComplectInfo_i::get_visual_representation_data () const {
	//#UC START# *53E0B7040233_457452900109*
	GblPilot::VisualRepresentationList_var server_data = ApplicationHelper::instance ()->get_cached_function_manager ()->get_visual_representation_data ();
	CORBA::ULong length = server_data->length ();
	Core::Aptr <VisualRepresentationList> adapter_data (new VisualRepresentationList (length));
	for (CORBA::ULong i = 0; i < length; ++i) {
		(*adapter_data.ptr ()) [i].name = GCI::IO::StringFactory::make (server_data [i].name.in ());
		(*adapter_data.ptr ()) [i].percent = server_data [i].percent;
	}
	return adapter_data._retn ();
	//#UC END# *53E0B7040233_457452900109*
}

// implemented method from ComplectInfo
const NodeBase* ComplectInfo_i::get_info  () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *457451200213_457452900109_GET*
	TreeBase_var node_tree = NodeServerTree<ComplectInfoNode_i>::make_tree ("AT_COMPLECT_INFO");
	if (!node_tree) {
		return 0;
	}
	return dynamic_cast<NodeBase*>(node_tree->root ());
	//#UC END# *457451200213_457452900109_GET*
}

NodeBase* ComplectInfo_i::get_info  ()
	/*throw (CanNotFindData)*/
{
	return const_cast<NodeBase*>(((const ComplectInfo_i*)this)->get_info  ());
}

// implemented method from ComplectInfo
const GCI::IO::String* ComplectInfo_i::get_old_base_warning () const {
	//#UC START# *45744FF4005D_457452900109_GET*
	if (m_old_base_warning.is_nil ()) {
		CORBA::String_var temp_base_warning = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_old_base_warning ();
		m_old_base_warning = GCI::IO::StringFactory::make (temp_base_warning.in ());
	}
	return m_old_base_warning._sretn ();
	//#UC END# *45744FF4005D_457452900109_GET*
}

GCI::IO::String* ComplectInfo_i::get_old_base_warning () {
	return const_cast<GCI::IO::String*>(((const ComplectInfo_i*)this)->get_old_base_warning ());
}

// implemented method from ComplectInfo
const GCI::IO::String* ComplectInfo_i::get_owner  () const {
	//#UC START# *45744FBC02DE_457452900109_GET*
	if (m_owner.is_nil ()) {
		CORBA::String_var owner = 
			ApplicationHelper::instance ()->get_cached_user_manager ()->get_registration_company ();
		m_owner = GCI::IO::StringFactory::make (owner.in ());
	}
	return m_owner._sretn ();
	//#UC END# *45744FBC02DE_457452900109_GET*
}

GCI::IO::String* ComplectInfo_i::get_owner  () {
	return const_cast<GCI::IO::String*>(((const ComplectInfo_i*)this)->get_owner  ());
}

// implemented method from ComplectInfo
ComplectType ComplectInfo_i::get_type () const {
	//#UC START# *45744F5A0311_457452900109_GET*
	if (m_complect_type.is_nil ()) {
		m_complect_type = new ComplectType ();
		GblPilotDef::ComplectType type = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_complect_type ();
		// TODO: сделать тайпконвертор
		switch (type) {
			case GCD::ct_Internal:
				*m_complect_type = CT_INTERNAL;
				break;
			case GCD::ct_Local:
				*m_complect_type = CT_LOCAL;
				break;
			case GCD::ct_NetOneUser:
				*m_complect_type = CT_NET_ONE_USER;
				break;
			case GCD::ct_NetManyUsers:
				*m_complect_type = CT_NET_MANY_USERS;
				break;
			default:
				GDS_ASSERT (false);
		}
	}
	return *m_complect_type;
	//#UC END# *45744F5A0311_457452900109_GET*
}

// implemented method from ComplectInfo
const GCI::IO::String* ComplectInfo_i::get_unexist_doc_message () const {
	//#UC START# *45F5280E0148_457452900109_GET*
	if (m_unexist_doc_message.is_nil ()) {
		CORBA::String_var unexist_doc_message = 
			ApplicationHelper::instance ()->get_cached_function_manager ()->get_unexist_doc_message ();
		m_unexist_doc_message = GCI::IO::StringFactory::make (unexist_doc_message.in ());
	}
	return m_unexist_doc_message._sretn ();
	//#UC END# *45F5280E0148_457452900109_GET*
}

GCI::IO::String* ComplectInfo_i::get_unexist_doc_message () {
	return const_cast<GCI::IO::String*>(((const ComplectInfo_i*)this)->get_unexist_doc_message ());
}

// implemented method from Listener
void ComplectInfo_i::fire (const Notification* notify) const {
	//#UC START# *45EEDE9D01C5_457452900109*
	m_unexist_doc_message = 0;
	m_complect_type = 0;
	m_dealer_info = 0;
	m_old_base_warning = 0;
	m_owner = 0;
	//#UC END# *45EEDE9D01C5_457452900109*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

