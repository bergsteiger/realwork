////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID FoldersNode_tie::s_com_iid = {0x6B1E4393, 0x7BE4, 0x4201, {0xA8, 0xF9, 0xD3, 0xC8, 0x17, 0xC4, 0x40, 0xB5}};

FoldersNode_tie::IidRegistrator FoldersNode_tie::s_iid_registrator;

FoldersNode_tie::FoldersNode_tie () : m_impl(NULL) {
}

unsigned long __stdcall FoldersNode_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall FoldersNode_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall FoldersNode_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<FoldersNode_tie* const>(this));
	}
	return counter;
}

void FoldersNode_tie::init () {
		m_counter = 1;
	}

void FoldersNode_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* FoldersNode_tie::cast (::Core::IObject* obj) {
	FoldersNode* ret = dynamic_cast<FoldersNode*>(obj);
	if (ret) {
		ret->addref();
	}
	IFoldersNode_tie* ret_ = NULL;
	FoldersNode_tie::make_tie (ret, ret_);
	return ret_;
}

void FoldersNode_tie::make_cpp (const IFoldersNode_tie* obj, FoldersNode*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<FoldersNode*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void FoldersNode_tie::make_tie (const FoldersNode* obj, IFoldersNode_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		FoldersNode_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<FoldersNode*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void FoldersNode_tie::make_tie (const FoldersNode& obj, IFoldersNode_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	FoldersNode_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<FoldersNode*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* FoldersNode_tie::get_impl () const {
	return m_impl;
}


long __stdcall FoldersNode_tie::get_level () const {
_DLL_TRY
	return m_impl->get_level();
_DLL_CATCH
}


long __stdcall FoldersNode_tie::get_child_count () const {
_DLL_TRY
	return m_impl->get_child_count();
_DLL_CATCH
}


long __stdcall FoldersNode_tie::get_all_child_count () const {
_DLL_TRY
	return m_impl->get_all_child_count();
_DLL_CATCH
}


long __stdcall FoldersNode_tie::get_flags () const {
_DLL_TRY
	return m_impl->get_flags();
_DLL_CATCH
}


long __stdcall FoldersNode_tie::get_index () const {
_DLL_TRY
	return m_impl->get_index();
_DLL_CATCH
}


long __stdcall FoldersNode_tie::get_through_index () const {
_DLL_TRY
	return m_impl->get_through_index();
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_parent (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_parent(), ret_);
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_previous_node (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_previous_node(), ret_);
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_next_node (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_next_node(), ret_);
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_caption (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_caption(), ret_, this);
_DLL_CATCH
}
void __stdcall FoldersNode_tie::set_caption (GCI::IO::IString_tie* caption) /*throw (ConstantModify_tie, AccessDenied_tie)*/ {
_DLL_TRY
	GCI::IO::String* caption_;
	GCI::IO::String_tie::make_cpp(caption, caption_);
	m_impl->set_caption(caption_);
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_hint (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_hint(), ret_, this);
_DLL_CATCH
}
void __stdcall FoldersNode_tie::set_hint (GCI::IO::IString_tie* hint) /*throw (ConstantModify_tie, AccessDenied_tie)*/ {
_DLL_TRY
	GCI::IO::String* hint_;
	GCI::IO::String_tie::make_cpp(hint, hint_);
	m_impl->set_hint(hint_);
_DLL_CATCH
}


EntityType __stdcall FoldersNode_tie::get_object_type () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_object_type();
_DLL_CATCH
}

void __stdcall FoldersNode_tie::get_child_456FE63B01D6 (
	long index
	, INode_tie*& ret_
) /*throw (InvalidIndex_tie)*/ {
_DLL_TRY

	Node* ret = m_impl->get_child(index);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::is_same_node_456FE63B01D9 (
	const INode_tie* node
) const {
_DLL_TRY
	Node* node_;
	Node_tie::make_cpp(node, node_);

	bool ret = m_impl->is_same_node(node_);
	return ret;
_DLL_CATCH
}

void __stdcall FoldersNode_tie::open_456FE63B01DB (
	Core::IIObject_tie*& ret_
) /*throw (CanNotFindData_tie, NotEntityElement_tie)*/ {
_DLL_TRY

	Core::IObject* ret = (dynamic_cast<Node*>(m_impl))->open();
	Core::IObject_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::delete_node_456FE63B01DD () /*throw (ConstantModify_tie, AccessDenied_tie, EmptyResult_tie)*/ {
_DLL_TRY

	m_impl->delete_node();
_DLL_CATCH
}

void __stdcall FoldersNode_tie::add_child_node_456FE63B01DE (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->add_child_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::add_sibling_node_456FE63B01E0 (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, Unsupported_tie, DuplicateNode_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->add_sibling_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::move_to_location_456FE63B01E2 (
	INode_tie* destination
) /*throw (InvalidContainer_tie, MoveDisabled_tie)*/ {
_DLL_TRY
	Node* destination_;
	Node_tie::make_cpp(destination, destination_);

	m_impl->move_to_location(destination_);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::copy_to_location_456FE63B01E4 (
	INode_tie* destination
) /*throw (CopyDisabled_tie, InvalidContainer_tie)*/ {
_DLL_TRY
	Node* destination_;
	Node_tie::make_cpp(destination, destination_);

	m_impl->copy_to_location(destination_);
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_move_456FE63B01E6 () const {
_DLL_TRY
	return m_impl->can_move ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_copy_456FE63B01E7 () const {
_DLL_TRY
	return m_impl->can_copy ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_insert_456FE63B01E8 (
	INode_tie* source
) const {
_DLL_TRY
	Node* source_;
	Node_tie::make_cpp(source, source_);

	bool ret = m_impl->can_insert(source_);
	return ret;
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::is_last_456FE63B01EA () const {
_DLL_TRY
	return m_impl->is_last ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::is_first_456FE63B01EB () const {
_DLL_TRY
	return m_impl->is_first ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::has_child_456FE63B01EC () const {
_DLL_TRY
	return m_impl->has_child ();
_DLL_CATCH
}

void __stdcall FoldersNode_tie::override_child_node_456FE63B01ED (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, DuplicateNode_tie, InvalidEntityType_tie)*/ {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->override_child_node(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_modify_4AA55863036D () const {
_DLL_TRY
	return m_impl->can_modify ();
_DLL_CATCH
}
bool __stdcall FoldersNode_tie::can_load_from_xml_469757F10138 () const {
_DLL_TRY
	return m_impl->can_load_from_xml ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_save_consultation_to_xml_45EED5F00094 () const {
_DLL_TRY
	return m_impl->can_save_consultation_to_xml ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_save_to_integration_xml_46433578001F () const {
_DLL_TRY
	return m_impl->can_save_to_integration_xml ();
_DLL_CATCH
}

bool __stdcall FoldersNode_tie::can_save_to_xml_469755970138 () const {
_DLL_TRY
	return m_impl->can_save_to_xml ();
_DLL_CATCH
}


void __stdcall FoldersNode_tie::get_creation_date (Date& ret_) const {
_DLL_TRY
	ret_ = m_impl->get_creation_date();
_DLL_CATCH
}


const FolderId __stdcall FoldersNode_tie::get_id () const {
_DLL_TRY
	return m_impl->get_id();
_DLL_CATCH
}

void __stdcall FoldersNode_tie::load_from_xml_469755D1008C (
	const char* xml_file_path
) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/ {
_DLL_TRY

	m_impl->load_from_xml(xml_file_path);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::save_consultation_to_xml_45EED5F00092 (
	const char* xml_file_path
) const {
_DLL_TRY

	m_impl->save_consultation_to_xml(xml_file_path);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::save_to_integration_xml_4643355B029F (
	GCI::IO::IString_tie*& ret_
) const /*throw (InvalidEntityType_tie)*/ {
_DLL_TRY

	GCI::IO::String* ret = m_impl->save_to_integration_xml();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall FoldersNode_tie::save_to_xml_46974935032C (
	const char* xml_file_path
) const /*throw (AccessDenied_tie, InvalidEntityType_tie)*/ {
_DLL_TRY

	m_impl->save_to_xml(xml_file_path);
_DLL_CATCH
}



const ::Core::ComIID Folders_tie::s_com_iid = {0x085870DB, 0xA1B6, 0x48E7, {0xAD, 0xDD, 0x3C, 0x9F, 0x39, 0x11, 0xFE, 0xF5}};

Folders_tie::IidRegistrator Folders_tie::s_iid_registrator;

Folders_tie::Folders_tie () : m_impl(NULL) {
}

unsigned long __stdcall Folders_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Folders_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Folders_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Folders_tie* const>(this));
	}
	return counter;
}

void Folders_tie::init () {
		m_counter = 1;
	}

void Folders_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Folders_tie::cast (::Core::IObject* obj) {
	Folders* ret = dynamic_cast<Folders*>(obj);
	if (ret) {
		ret->addref();
	}
	IFolders_tie* ret_ = NULL;
	Folders_tie::make_tie (ret, ret_);
	return ret_;
}

void Folders_tie::make_cpp (const IFolders_tie* obj, Folders*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Folders*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Folders_tie::make_tie (const Folders* obj, IFolders_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Folders_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Folders*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Folders_tie::make_tie (const Folders& obj, IFolders_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Folders_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Folders*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Folders_tie::get_impl () const {
	return m_impl;
}


void __stdcall Folders_tie::get_root (INode_tie*& ret_) {
_DLL_TRY
	Node_tie::make_tie (m_impl->get_root(), ret_);
_DLL_CATCH
}


const EntityType __stdcall Folders_tie::get_filter () const {
_DLL_TRY
	return m_impl->get_filter();
_DLL_CATCH
}
void __stdcall Folders_tie::set_filter (EntityType filter) {
_DLL_TRY
	m_impl->set_filter(filter);
_DLL_CATCH
}

void __stdcall Folders_tie::find_456FEA67007E (
	const Core::IIObject_tie* entity
	, INode_tie*& ret_
) const {
_DLL_TRY
	Core::IObject* entity_;
	Core::IObject_tie::make_cpp(entity, entity_);

	Node* ret = m_impl->find(entity_);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Folders_tie::find_context_456FEA670080 (
	const char* mask
	, const SearchMode& mode
	, const INode_tie* cur_item
	, ContextSearchResult_tie& result
	, INode_tie*& ret_
) const {
_DLL_TRY
	Node* cur_item_;
	Node_tie::make_cpp(cur_item, cur_item_);
	::Core::Aptr<ContextSearchResult> result_ = 0;

	Node* ret = m_impl->find_context(mask, mode, cur_item_, result_.out());
	ContextSearchResult_tie::make_tie(*result_, result);
	Node_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Folders_tie::reset_type_filter_456FEA670085 () const {
_DLL_TRY

	m_impl->reset_type_filter();
_DLL_CATCH
}
void __stdcall Folders_tie::create_folder_45EED7A20295 (
	IFolder_tie*& ret_
) const {
_DLL_TRY

	Folder* ret = m_impl->create_folder();
	Folder_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Folders_tie::find_folder_node_45EED7A20296 (
	FolderId id
	, IFoldersNode_tie*& ret_
) const {
_DLL_TRY

	FoldersNode* ret = m_impl->find_folder_node(id);
	FoldersNode_tie::make_tie(ret, ret_);
_DLL_CATCH
}



const ::Core::ComIID DoneNotifier_tie::s_com_iid = {0xB9089580, 0xC0F0, 0x43C8, {0xB4, 0x49, 0xB2, 0xAA, 0x3A, 0x0D, 0x4F, 0xFF}};

DoneNotifier_tie::IidRegistrator DoneNotifier_tie::s_iid_registrator;

DoneNotifier_tie::DoneNotifier_tie () : m_impl(NULL) {
}

unsigned long __stdcall DoneNotifier_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall DoneNotifier_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall DoneNotifier_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<DoneNotifier_tie* const>(this));
	}
	return counter;
}

void DoneNotifier_tie::init () {
		m_counter = 1;
	}

void DoneNotifier_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* DoneNotifier_tie::cast (::Core::IObject* obj) {
	DoneNotifier* ret = dynamic_cast<DoneNotifier*>(obj);
	if (ret) {
		ret->addref();
	}
	IDoneNotifier_tie* ret_ = NULL;
	DoneNotifier_tie::make_tie (ret, ret_);
	return ret_;
}

void DoneNotifier_tie::make_cpp (const IDoneNotifier_tie* obj, DoneNotifier*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<DoneNotifier*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void DoneNotifier_tie::make_tie (const DoneNotifier* obj, IDoneNotifier_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		DoneNotifier_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<DoneNotifier*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void DoneNotifier_tie::make_tie (const DoneNotifier& obj, IDoneNotifier_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	DoneNotifier_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<DoneNotifier*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* DoneNotifier_tie::get_impl () const {
	return m_impl;
}

bool __stdcall DoneNotifier_tie::done_45EEDB8B032F () {
_DLL_TRY
	return m_impl->done ();
_DLL_CATCH
}



const ::Core::ComIID Folder_tie::s_com_iid = {0x4B736A91, 0xFDC7, 0x4F00, {0xB4, 0x45, 0x9C, 0x91, 0xCE, 0x12, 0x0A, 0xB9}};

Folder_tie::IidRegistrator Folder_tie::s_iid_registrator;

Folder_tie::Folder_tie () : m_impl(NULL) {
}

unsigned long __stdcall Folder_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return ::Core::IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
	}
}
unsigned long __stdcall Folder_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Folder_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Folder_tie* const>(this));
	}
	return counter;
}

void Folder_tie::init () {
		m_counter = 1;
	}

void Folder_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Folder_tie::cast (::Core::IObject* obj) {
	Folder* ret = dynamic_cast<Folder*>(obj);
	if (ret) {
		ret->addref();
	}
	IFolder_tie* ret_ = NULL;
	Folder_tie::make_tie (ret, ret_);
	return ret_;
}

void Folder_tie::make_cpp (const IFolder_tie* obj, Folder*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Folder*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Folder_tie::make_tie (const Folder* obj, IFolder_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Folder_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Folder*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Folder_tie::make_tie (const Folder& obj, IFolder_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Folder_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Folder*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Folder_tie::get_impl () const {
	return m_impl;
}


void __stdcall Folder_tie::get_name (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}
void __stdcall Folder_tie::set_name (GCI::IO::IString_tie* name) {
_DLL_TRY
	GCI::IO::String* name_;
	GCI::IO::String_tie::make_cpp(name, name_);
	m_impl->set_name(name_);
_DLL_CATCH
}


void __stdcall Folder_tie::get_comment (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_comment(), ret_, this);
_DLL_CATCH
}
void __stdcall Folder_tie::set_comment (GCI::IO::IString_tie* comment) {
_DLL_TRY
	GCI::IO::String* comment_;
	GCI::IO::String_tie::make_cpp(comment, comment_);
	m_impl->set_comment(comment_);
_DLL_CATCH
}
bool __stdcall Folder_tie::can_share_4AA5591A025F () const {
_DLL_TRY
	return m_impl->can_share ();
_DLL_CATCH
}


bool __stdcall Folder_tie::get_external () const {
_DLL_TRY
	return m_impl->get_external();
_DLL_CATCH
}


bool __stdcall Folder_tie::get_shared () const {
_DLL_TRY
	return m_impl->get_shared();
_DLL_CATCH
}
void __stdcall Folder_tie::set_shared (bool shared) {
_DLL_TRY
	m_impl->set_shared(shared);
_DLL_CATCH
}



void NotifyData_tie::make_cpp (const NotifyData_tie& obj, NotifyData& ret_) {
		ret_.status = obj.status;
		DoneNotifier_tie::make_cpp (obj.done_notifier, ret_.done_notifier.out (), true);
		FoldersNode_tie::make_cpp (obj.folder, ret_.folder.out (), true);
}

void NotifyData_tie::make_tie (const NotifyData& obj, NotifyData_tie& ret_) {
		ret_.status = obj.status;
		ret_.done_notifier = 0;
		DoneNotifier_tie::make_tie (obj.done_notifier.in (), ret_.done_notifier, true);
		ret_.folder = 0;
		FoldersNode_tie::make_tie (obj.folder.in (), ret_.folder, true);
}

NotifyData_tie_for_callback::~NotifyData_tie_for_callback () {
	if (done_notifier) {
		done_notifier->release ();
	}
	if (folder) {
		folder->release ();
	}

}

void NotifyData_tie_for_callback::make_cpp (const NotifyData_tie_for_callback& obj, NotifyData& ret_) {
		ret_.status = obj.status;
		DoneNotifier_tie::make_cpp (obj.done_notifier, ret_.done_notifier.out (), true);
		FoldersNode_tie::make_cpp (obj.folder, ret_.folder.out (), true);
}

void NotifyData_tie_for_callback::make_tie (const NotifyData& obj, NotifyData_tie_for_callback& ret_) {
		ret_.status = obj.status;
		ret_.done_notifier = 0;
		DoneNotifier_tie::make_tie (obj.done_notifier.in (), ret_.done_notifier, true);
		ret_.folder = 0;
		FoldersNode_tie::make_tie (obj.folder.in (), ret_.folder, true);
}


void ExternalFoldersChangeNotifier_callback_tie::fire (const NotifyData& data) const {
	NotifyData_tie_for_callback data_;
	NotifyData_tie_for_callback::make_tie(data, data_);

	m_impl->fire_45EEDD7A017A(data_);


}



ExternalFoldersChangeNotifier_callback_tie::ExternalFoldersChangeNotifier_callback_tie () : m_impl(NULL), m_counter (1) {
}

unsigned long ExternalFoldersChangeNotifier_callback_tie::release () const {
	long const counter = --m_counter;

	if (counter == 0) {
		m_counter = 1;
		m_impl->release();
		m_impl = NULL;
		MyPool::instance()->release_obj(const_cast<ExternalFoldersChangeNotifier_callback_tie* const>(this));
	}
	return counter;
}

unsigned long ExternalFoldersChangeNotifier_callback_tie::addref () const {
		return ++m_counter;
	}

unsigned long ExternalFoldersChangeNotifier_callback_tie::ref_count () const {
	return m_counter.value ();
}

void ExternalFoldersChangeNotifier_callback_tie::init () {
}

void ExternalFoldersChangeNotifier_callback_tie::done () {
	m_impl = NULL;
}

void IExternalFoldersChangeNotifier_tie::make_cpp (const IExternalFoldersChangeNotifier_tie* obj, ExternalFoldersChangeNotifier*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		ExternalFoldersChangeNotifier_callback_tie* ret = ExternalFoldersChangeNotifier_callback_tie::MyPool::instance()->new_obj();
		ret->m_impl = const_cast<IExternalFoldersChangeNotifier_tie*>(obj);
		ret->m_impl->addref ();
		ret_ = ret;
	}
}

void IExternalFoldersChangeNotifier_tie::make_tie (IExternalFoldersChangeNotifier_tie* obj, ExternalFoldersChangeNotifier_callback_tie*& ret_) {
	if (!obj) {
		ret_ = NULL;
	} else {
		//ret_ = MyPool::instance()->new_obj();
		//ret_->m_impl = obj;
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

