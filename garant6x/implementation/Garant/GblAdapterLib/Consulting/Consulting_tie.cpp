////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting_tie.cpp"
// С++ TIE-обвязка для DLL (_tie.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting_tie.h"

namespace GblAdapterLib {

const ::Core::ComIID Estimation_tie::s_com_iid = {0xDD01B380, 0x09FE, 0x4476, {0x87, 0x89, 0x20, 0xB2, 0x29, 0x1F, 0xE4, 0x1B}};

Estimation_tie::IidRegistrator Estimation_tie::s_iid_registrator;

Estimation_tie::Estimation_tie () : m_impl(NULL) {
}

unsigned long __stdcall Estimation_tie::query_interface (
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
unsigned long __stdcall Estimation_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Estimation_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Estimation_tie* const>(this));
	}
	return counter;
}

void Estimation_tie::init () {
		m_counter = 1;
	}

void Estimation_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Estimation_tie::cast (::Core::IObject* obj) {
	Estimation* ret = dynamic_cast<Estimation*>(obj);
	if (ret) {
		ret->addref();
	}
	IEstimation_tie* ret_ = NULL;
	Estimation_tie::make_tie (ret, ret_);
	return ret_;
}

void Estimation_tie::make_cpp (const IEstimation_tie* obj, Estimation*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Estimation*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Estimation_tie::make_tie (const Estimation* obj, IEstimation_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Estimation_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Estimation*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Estimation_tie::make_tie (const Estimation& obj, IEstimation_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Estimation_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Estimation*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Estimation_tie::get_impl () const {
	return m_impl;
}


void __stdcall Estimation_tie::get_text (GCI::IO::IString_tie*& ret_) {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_text(), ret_, this);
_DLL_CATCH
}
void __stdcall Estimation_tie::set_text (GCI::IO::IString_tie* text) {
_DLL_TRY
	GCI::IO::String* text_;
	GCI::IO::String_tie::make_cpp(text, text_);
	m_impl->set_text(text_);
_DLL_CATCH
}


EstimationValue __stdcall Estimation_tie::get_value () const {
_DLL_TRY
	return m_impl->get_value();
_DLL_CATCH
}
void __stdcall Estimation_tie::set_value (EstimationValue value) {
_DLL_TRY
	m_impl->set_value(value);
_DLL_CATCH
}



const ::Core::ComIID ParasList_tie::s_com_iid = {0x216C7CF0, 0xD3B9, 0x4F53, {0xB8, 0xEF, 0x2F, 0x43, 0x72, 0x5A, 0xAC, 0x07}};

unsigned long __stdcall ParasList_tie::query_interface (
	const ::Core::ComIID& iid
	, void*& object
) {
	if (iid == s_com_iid) {
		this->addref();
		object = this;
		return 0x00000000UL;
	} else {
		return 0x80004002UL;
	}
}

unsigned long __stdcall ParasList_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ParasList_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ParasList_tie* const>(this));
	}
	return counter;
}

void ParasList_tie::init () {
	m_counter = 1;
	m_orphan = true;
}

void ParasList_tie::done () {
	if (m_orphan && m_impl) {
		delete m_impl;
	}
	m_impl = NULL;
	
	m_tie_owner.release ();
}

ParasList_tie::ParasList_tie () : m_impl(NULL), m_orphan(true) {
}

void ParasList_tie::make_cpp (const ParasList_tie* obj, ParasList*& ret_) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = obj->m_impl;
	}
}

void ParasList_tie::new_tie (ParasList* obj, ParasList_tie*& ret_) {
	Core::Aptr<ParasList> obj_aptr (obj);
	if (obj_aptr.is_nil ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}

void ParasList_tie::make_tie (ParasList* obj, ParasList_tie*& ret_) {
	Core::Aptr<ParasList> obj_aptr (obj);
	if (obj_aptr.is_nil () || obj_aptr->empty ()) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = obj_aptr.forget ();
	}
}
	
void ParasList_tie::make_tie (const ParasList& obj, ParasList_tie*& ret_) {
	if (ret_) {
		ret_->release();
	}
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = new ParasList (obj);
	} else {
		ret_ = NULL;
	}
}

void ParasList_tie::make_tie (const ParasList& obj, ParasList_tie*& ret_, const Core::TIEBase* owner) {
	GDS_ASSERT(owner);
	if (ret_) {
		ret_->release();
	}
	
	if (obj.empty () == false) {
		ret_ = MyPool::instance()->new_obj();
		ret_->m_impl = const_cast<ParasList*>(&obj);
		owner->addref ();
		ret_->m_tie_owner = owner;
		if (owner) {
			ret_->m_orphan = false;
		}
	} else {
		ret_ = NULL;
	}
}


size_t __stdcall ParasList_tie::get_count () const {
	return m_impl->size();
}

void __stdcall ParasList_tie::set_count (size_t count) {
	m_impl->resize(count);
}

void __stdcall ParasList_tie::clear () {
	m_impl->clear();
}

void __stdcall ParasList_tie::delete_item (size_t index) {
	if ((size_t)index < m_impl->size()) {
		m_impl->erase(m_impl->begin() + index);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ParasList_tie::get_item (size_t index, GCI::IO::IString_tie*& ret_) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String_tie::make_tie ((*m_impl)[index].in(), ret_, true);
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

void __stdcall ParasList_tie::set_item (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		(*m_impl)[index] = item_;
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

size_t __stdcall ParasList_tie::add (const GCI::IO::IString_tie* item) {
	GCI::IO::String* item_;
	GCI::IO::String_tie::make_cpp (item, item_, true);
	m_impl->push_back (item_);
	return m_impl->size() - 1;
}

size_t __stdcall ParasList_tie::insert (size_t index, const GCI::IO::IString_tie* item) {
	if ((size_t)index < m_impl->size()) {
		GCI::IO::String* item_;
		GCI::IO::String_tie::make_cpp (item, item_, true);
		return std::distance (m_impl->begin(), m_impl->insert (m_impl->begin() + index, item_));
	} else {
		throw Core::IndexOutOfBounds_tie ();
	}
}

const ::Core::ComIID Consultation_tie::s_com_iid = {0x69D87373, 0xCAC1, 0x4228, {0x9F, 0x26, 0x4E, 0x46, 0xD2, 0xA8, 0xCB, 0xE9}};

Consultation_tie::IidRegistrator Consultation_tie::s_iid_registrator;

Consultation_tie::Consultation_tie () : m_impl(NULL) {
}

unsigned long __stdcall Consultation_tie::query_interface (
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
unsigned long __stdcall Consultation_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall Consultation_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<Consultation_tie* const>(this));
	}
	return counter;
}

void Consultation_tie::init () {
		m_counter = 1;
	}

void Consultation_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* Consultation_tie::cast (::Core::IObject* obj) {
	Consultation* ret = dynamic_cast<Consultation*>(obj);
	if (ret) {
		ret->addref();
	}
	IConsultation_tie* ret_ = NULL;
	Consultation_tie::make_tie (ret, ret_);
	return ret_;
}

void Consultation_tie::make_cpp (const IConsultation_tie* obj, Consultation*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<Consultation*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void Consultation_tie::make_tie (const Consultation* obj, IConsultation_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		Consultation_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<Consultation*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void Consultation_tie::make_tie (const Consultation& obj, IConsultation_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	Consultation_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<Consultation*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* Consultation_tie::get_impl () const {
	return m_impl;
}


bool __stdcall Consultation_tie::get_is_saved () const {
_DLL_TRY
	return m_impl->get_is_saved();
_DLL_CATCH
}


bool __stdcall Consultation_tie::get_is_changed () const {
_DLL_TRY
	return m_impl->get_is_changed();
_DLL_CATCH
}


const unsigned long __stdcall Consultation_tie::get_eid () const /*throw (Unsupported_tie)*/ {
_DLL_TRY
	return m_impl->get_eid();
_DLL_CATCH
}

void __stdcall Consultation_tie::save_to_456EB3E10178 (
	IEntityStorage_tie* storage
	, IEntityStorage_tie*& ret_
) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/ {
_DLL_TRY
	EntityStorage* storage_;
	EntityStorage_tie::make_cpp(storage, storage_);

	EntityStorage* ret = m_impl->save_to(storage_);
	EntityStorage_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Consultation_tie::append_to_456EB3E1017A (
	IEntityStorage_tie* storage
	, IEntityStorage_tie*& ret_
) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/ {
_DLL_TRY
	EntityStorage* storage_;
	EntityStorage_tie::make_cpp(storage, storage_);

	EntityStorage* ret = m_impl->append_to(storage_);
	EntityStorage_tie::make_tie(ret, ret_);
_DLL_CATCH
}
void __stdcall Consultation_tie::create_estimation_45700805015D (
	IEstimation_tie*& ret_
) const {
_DLL_TRY

	Estimation* ret = m_impl->create_estimation();
	Estimation_tie::make_tie(ret, ret_);
_DLL_CATCH
}


void __stdcall Consultation_tie::get_creation_date (DateTime& ret_) const /*throw (Deleted_tie)*/ {
_DLL_TRY
	ret_ = m_impl->get_creation_date();
_DLL_CATCH
}


void __stdcall Consultation_tie::get_expert_info (ParasList_tie*& ret_) const /*throw (Deleted_tie)*/ {
_DLL_TRY
	ParasList_tie::make_tie (m_impl->get_expert_info(), ret_);
_DLL_CATCH
}


void __stdcall Consultation_tie::get_expert_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_expert_name(), ret_, this);
_DLL_CATCH
}

void __stdcall Consultation_tie::get_answer_457008050159 (
	IDocument_tie*& ret_
) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/ {
_DLL_TRY

	Document* ret = m_impl->get_answer();
	Document_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Consultation_tie::get_answer_data_4DA581950113 (
	bool& is_evd
	, ParasList_tie*& ret_
) const {
_DLL_TRY

	const ParasList& ret = m_impl->get_answer_data(is_evd);
	ParasList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

void __stdcall Consultation_tie::get_document_list_45700805015A (
	IDynList_tie*& ret_
) const /*throw (NoDocumentList_tie, Deleted_tie, OldFormatConsultation_tie)*/ {
_DLL_TRY

	DynList* ret = m_impl->get_document_list();
	DynList_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Consultation_tie::get_query_46BAFEDB004E (
	IDocument_tie*& ret_
) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/ {
_DLL_TRY

	Document* ret = m_impl->get_query();
	Document_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall Consultation_tie::get_query_by_paras_4D07592B0032 (
	ParasList_tie*& ret_
) const {
_DLL_TRY

	const ParasList& ret = m_impl->get_query_by_paras();
	ParasList_tie::make_tie(ret, ret_, this);
_DLL_CATCH
}

bool __stdcall Consultation_tie::has_estimation_4CEBD99E01F5 () const /*throw (Deleted_tie)*/ {
_DLL_TRY
	return m_impl->has_estimation ();
_DLL_CATCH
}

bool __stdcall Consultation_tie::has_list_4CEBD9790091 () const /*throw (Deleted_tie)*/ {
_DLL_TRY
	return m_impl->has_list ();
_DLL_CATCH
}

bool __stdcall Consultation_tie::has_payment_information_4CEBD9BE03E4 () const /*throw (Deleted_tie)*/ {
_DLL_TRY
	return m_impl->has_payment_information ();
_DLL_CATCH
}


void __stdcall Consultation_tie::get_id (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_id(), ret_, this);
_DLL_CATCH
}


void __stdcall Consultation_tie::get_modification_date (DateTime& ret_) const /*throw (Deleted_tie)*/ {
_DLL_TRY
	ret_ = m_impl->get_modification_date();
_DLL_CATCH
}


void __stdcall Consultation_tie::get_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_name(), ret_, this);
_DLL_CATCH
}

void __stdcall Consultation_tie::payment_confirm_45700805015E (
	bool answer
) /*throw (NoConnection_tie, PaymentForbidden_tie)*/ {
_DLL_TRY

	m_impl->payment_confirm(answer);
_DLL_CATCH
}


void __stdcall Consultation_tie::get_query_data (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_query_data(), ret_, this);
_DLL_CATCH
}

void __stdcall Consultation_tie::read_486B5273020E () /*throw (Deleted_tie)*/ {
_DLL_TRY

	m_impl->read();
_DLL_CATCH
}


void __stdcall Consultation_tie::get_reply_date (Date& ret_) const /*throw (Deleted_tie)*/ {
_DLL_TRY
	ret_ = m_impl->get_reply_date();
_DLL_CATCH
}

void __stdcall Consultation_tie::send_estimation_45700805015B (
	const IEstimation_tie* value
) /*throw (NoConnection_tie, NoSubscription_tie, Deleted_tie)*/ {
_DLL_TRY
	Estimation* value_;
	Estimation_tie::make_cpp(value, value_);

	m_impl->send_estimation(value_);
_DLL_CATCH
}


ConsultationStatus __stdcall Consultation_tie::get_status () const /*throw (Deleted_tie)*/ {
_DLL_TRY
	return m_impl->get_status();
_DLL_CATCH
}


void __stdcall Consultation_tie::get_user_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ {
_DLL_TRY
	GCI::IO::String_tie::make_tie (m_impl->get_user_name(), ret_, this);
_DLL_CATCH
}



const ::Core::ComIID ConsultationManager_tie::s_com_iid = {0x713794D3, 0x0F90, 0x4EE5, {0xAF, 0x5D, 0x64, 0x4D, 0x90, 0x91, 0xDA, 0x0C}};

ConsultationManager_tie::IidRegistrator ConsultationManager_tie::s_iid_registrator;

ConsultationManager_tie::ConsultationManager_tie () : m_impl(NULL) {
}

unsigned long __stdcall ConsultationManager_tie::query_interface (
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
unsigned long __stdcall ConsultationManager_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ConsultationManager_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ConsultationManager_tie* const>(this));
	}
	return counter;
}

void ConsultationManager_tie::init () {
		m_counter = 1;
	}

void ConsultationManager_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ConsultationManager_tie::cast (::Core::IObject* obj) {
	ConsultationManager* ret = dynamic_cast<ConsultationManager*>(obj);
	if (ret) {
		ret->addref();
	}
	IConsultationManager_tie* ret_ = NULL;
	ConsultationManager_tie::make_tie (ret, ret_);
	return ret_;
}

void ConsultationManager_tie::make_cpp (const IConsultationManager_tie* obj, ConsultationManager*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ConsultationManager*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ConsultationManager_tie::make_tie (const ConsultationManager* obj, IConsultationManager_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ConsultationManager_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ConsultationManager*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ConsultationManager_tie::make_tie (const ConsultationManager& obj, IConsultationManager_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ConsultationManager_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ConsultationManager*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ConsultationManager_tie::get_impl () const {
	return m_impl;
}

bool __stdcall ConsultationManager_tie::cant_receive_answer_4829A56201B6 () const {
_DLL_TRY
	return m_impl->cant_receive_answer ();
_DLL_CATCH
}

bool __stdcall ConsultationManager_tie::check_consulting_available_457009CC035D () const {
_DLL_TRY
	return m_impl->check_consulting_available ();
_DLL_CATCH
}

bool __stdcall ConsultationManager_tie::check_internet_channel_457009CC035C () const {
_DLL_TRY
	return m_impl->check_internet_channel ();
_DLL_CATCH
}

void __stdcall ConsultationManager_tie::create_query_with_notice_user_4867614C01B0 () const {
_DLL_TRY

	m_impl->create_query_with_notice_user();
_DLL_CATCH
}

void __stdcall ConsultationManager_tie::delete_consultation_457009CC035E (
	IConsultation_tie* for_delete
) const /*throw (NotDeleted_tie, Deleted_tie)*/ {
_DLL_TRY
	Consultation* for_delete_;
	Consultation_tie::make_cpp(for_delete, for_delete_);

	m_impl->delete_consultation(for_delete_);
_DLL_CATCH
}

void __stdcall ConsultationManager_tie::load_from_xml_457009CC0361 (
	const char* file_name
) const /*throw (AccessDenied_tie, InvalidXMLType_tie)*/ {
_DLL_TRY

	m_impl->load_from_xml(file_name);
_DLL_CATCH
}

unsigned long __stdcall ConsultationManager_tie::update_not_readed_consultations_457009CC0360 () const {
_DLL_TRY
	return m_impl->update_not_readed_consultations ();
_DLL_CATCH
}



const ::Core::ComIID ConsultingTemplateInfo_tie::s_com_iid = {0x3613E72E, 0x8CD0, 0x4D45, {0xB5, 0x17, 0xBD, 0x45, 0xF9, 0x76, 0x4A, 0x82}};

ConsultingTemplateInfo_tie::IidRegistrator ConsultingTemplateInfo_tie::s_iid_registrator;

ConsultingTemplateInfo_tie::ConsultingTemplateInfo_tie () : m_impl(NULL) {
}

unsigned long __stdcall ConsultingTemplateInfo_tie::query_interface (
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
unsigned long __stdcall ConsultingTemplateInfo_tie::addref () const {
	return ++m_counter;
}

unsigned long __stdcall ConsultingTemplateInfo_tie::release () const {
	long const counter = --m_counter;
	if (counter == 0) {
		MyPool::instance()->release_obj(const_cast<ConsultingTemplateInfo_tie* const>(this));
	}
	return counter;
}

void ConsultingTemplateInfo_tie::init () {
		m_counter = 1;
	}

void ConsultingTemplateInfo_tie::done () {
	m_impl->release();
	m_impl = NULL;
	
	m_tie_owner.release ();
}

void* ConsultingTemplateInfo_tie::cast (::Core::IObject* obj) {
	ConsultingTemplateInfo* ret = dynamic_cast<ConsultingTemplateInfo*>(obj);
	if (ret) {
		ret->addref();
	}
	IConsultingTemplateInfo_tie* ret_ = NULL;
	ConsultingTemplateInfo_tie::make_tie (ret, ret_);
	return ret_;
}

void ConsultingTemplateInfo_tie::make_cpp (const IConsultingTemplateInfo_tie* obj, ConsultingTemplateInfo*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = 0;
	} else {
		ret_ = dynamic_cast<ConsultingTemplateInfo*> (obj->get_impl ());
		if (interface_addref) {
			ret_->addref();
		}
	}
}

void ConsultingTemplateInfo_tie::make_tie (const ConsultingTemplateInfo* obj, IConsultingTemplateInfo_tie*& ret_, bool interface_addref) {
	if (!obj) {
		ret_ = NULL;
	} else {
		if (ret_) {
			ret_->release();
		}
		ConsultingTemplateInfo_tie* ret = MyPool::instance()->new_obj();
		ret->m_impl = const_cast<ConsultingTemplateInfo*>(obj);
		if (interface_addref) {
			ret->m_impl->addref();
		}
		ret_ = ret;
	}
}

void ConsultingTemplateInfo_tie::make_tie (const ConsultingTemplateInfo& obj, IConsultingTemplateInfo_tie*& ret_, const Core::TIEBase* owner) {
	if (ret_) {
		ret_->release();
	}
	ConsultingTemplateInfo_tie* ret = MyPool::instance()->new_obj();
	ret->m_impl = const_cast<ConsultingTemplateInfo*>(&obj);

	ret->m_impl->addref();
	owner->addref ();
	ret->m_tie_owner = owner;
	
	ret_ = ret;
}

::Core::IObject* ConsultingTemplateInfo_tie::get_impl () const {
	return m_impl;
}

void __stdcall ConsultingTemplateInfo_tie::get_answer_template_4CEBC82300CD (
	GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_answer_template();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ConsultingTemplateInfo_tie::get_dealer_info_4CEBC83F016B (
	GCI::IO::IString_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::String* ret = m_impl->get_dealer_info();
	GCI::IO::String_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ConsultingTemplateInfo_tie::get_preanswer_template_4CEBC80B00FD (
	GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_preanswer_template();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

void __stdcall ConsultingTemplateInfo_tie::get_query_template_4D075AF20237 (
	GCI::IO::IStream_tie*& ret_
) const {
_DLL_TRY

	GCI::IO::Stream* ret = m_impl->get_query_template();
	GCI::IO::Stream_tie::make_tie(ret, ret_);
_DLL_CATCH
}

TemplateType __stdcall ConsultingTemplateInfo_tie::get_template_type_4CEE5713008E (
	const IConsultation_tie* consultation
) const /*throw (Deleted_tie)*/ {
_DLL_TRY
	Consultation* consultation_;
	Consultation_tie::make_cpp(consultation, consultation_);

	TemplateType ret = m_impl->get_template_type(consultation_);
	return ret;
_DLL_CATCH
}



} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

