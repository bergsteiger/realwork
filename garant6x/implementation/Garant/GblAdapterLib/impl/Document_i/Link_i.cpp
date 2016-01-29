////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Link_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Link_i.h"
// by <<uses>> dependencies
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/LinkKindConvertor.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/LinkedObjectTypeConvertor.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Link_i::Link_i (unsigned long doc_id, const Topic& topic, RedactionID redaction_id)
//#UC START# *51A6183C010F_51A6185B0344_51A6189A00F0_BASE_INIT*
//#UC END# *51A6183C010F_51A6185B0344_51A6189A00F0_BASE_INIT*
{
	//#UC START# *51A6183C010F_51A6185B0344_51A6189A00F0_BODY*
	// Что приходит на адаптер с оболочки:
	//	- локальная ссылка (ссылка на сам документ) - doc_id - идентификатор документа, из которого ссылка, 
	//												  topic.pid.object_id - 0
	//												  redaction_id - 0
	//												  topic.position - позиция в документе, на который ведет ссылка

	//	- ссылка на другой документ, на блоб		- doc_id - идентификатор документа, из которого ссылка, 
	//												  topic.pid.object_id - идентификатор документа, на который стоит ссылка
	//												  redaction_id - 0
	//												  topic.position - позиция в документе, на который ведет ссылка

	//  - ссылка на книгу							- doc_id - идентификатор документа, из которого ссылка, 
	//					 							  topic.pid.object_id - 0
	//					 							  redaction_id - 0
	//												  topic.position - позиция в документе, на который ведет ссылка

	//	- ссылка на редакцию из своей цепочки редакций - doc_id - идентификатор документа, из которого ссылка, 
	//												  topic.pid.object_id - 0
	//												  redaction_id - идентификатор документа-редакции
	//												  topic.position - позиция в документе, на который ведет ссылка

	//	- ссылка на любую другую редакцию			- doc_id - идентификатор документа, из которого ссылка, 
	//												  topic.pid.object_id - идентификатор актуальной редакции из redaction_id
	//												  redaction_id - идентификатор документа-редакции
	//												  topic.position - позиция в документе, на который ведет ссылка

	//  - мультиссыла								- doc_id - идентификатор документа, из которого ссылка, 
	//					 							  topic.pid.object_id - идентификатор параграфа из которого ссылка
	//					 							  redaction_id - 0
	//												  topic.position.point - порядковый номер ссылки в параграфе

	//  - ссылка на url, на архивный документ,      - doc_id - идентификатор документа, из которого ссылка, 
	//	  скрипт, поисковый запрос					  topic.pid.object_id - идентификатор ref топика
	//					 							  redaction_id - 0
	//												  topic.position.point - саб в ref топике, из которого читается url

	//  - ссылка на папочный контент				- doc_id - идентификатор документа, из которого ссылка, 
	//					 							  topic.pid.object_id - идентификатор папочного контента
	//					 							  redaction_id - 0
	//												  topic.position.point - 0

	GCD::PID server_pid;
	server_pid.m_class_id = topic.pid.class_id;
	if (redaction_id) {
		server_pid.m_class_id = Defines::CI_TOPIC;
		server_pid.m_object_id = redaction_id;
	} else {
		if (topic.pid.object_id == 0) {
			server_pid.m_object_id = doc_id;	//m_current_state->redaction(); я конечно могу ошибаться, но кажется что doc_id и m_current_state->redaction() 
														// это одно и тоже несмотря на все машины времени
		} else {
			server_pid.m_object_id = topic.pid.object_id;
		}
	}
	try {
		m_server_link = ApplicationHelper::instance ()->get_cached_link_manager ()->get_link (doc_id, server_pid, topic.position.point);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
		throw CanNotFindData ();
	}
	GDS_ASSERT (!CORBA::is_nil (m_server_link));
	//#UC END# *51A6183C010F_51A6185B0344_51A6189A00F0_BODY*
}

Link_i::Link_i (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id)
//#UC START# *51A6183C010F_55A3CC60010D_51A6189A00F0_BASE_INIT*
//#UC END# *51A6183C010F_55A3CC60010D_51A6189A00F0_BASE_INIT*
{
	//#UC START# *51A6183C010F_55A3CC60010D_51A6189A00F0_BODY*
	try {
		m_server_link = 
			ApplicationHelper::instance ()->get_cached_link_manager ()->get_link_from_autoreferat (
						document->get_server_doc ()
						, doc_id
						, ServerAdapterConverters::adapter_to_server (topic.pid)
						, topic.position.point
					);
	} catch (GCD::CanNotFindData&) {
		GDS_ASSERT (false);
		throw CanNotFindData ();
	}
	GDS_ASSERT (!CORBA::is_nil (m_server_link));
	//#UC END# *51A6183C010F_55A3CC60010D_51A6189A00F0_BODY*
}

Link_i::~Link_i () {
	//#UC START# *51A6189A00F0_DESTR_BODY*
	try {
		if (!CORBA::is_nil (m_server_link)) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (m_server_link.in ());
		}
	} catch (CORBA::TRANSIENT&) {
	} catch (...) {
		GDS_ASSERT ((false, "Unknown exception catched"));
	}
	//#UC END# *51A6189A00F0_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

GblPilot::Link* Link_i::get_server_link () const {
	//#UC START# *55685C610291*
	return this->m_server_link;
	//#UC END# *55685C610291*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Link
LinkKind Link_i::get_kind () const {
	//#UC START# *53E9EF9A03AB_51A6189A00F0*
	return LinkKindConvertorSingleton::instance ()->get (m_server_link->get_kind ());
	//#UC END# *53E9EF9A03AB_51A6189A00F0*
}

// implemented method from Link
LinkInfo* Link_i::get_link_info () const {
	//#UC START# *51A745CE0034_51A6189A00F0*
	LinkInfo* ret = new LinkInfo ();
	ret->kind = this->get_kind ();
	ret->hint = this->get_linked_hint ();
	return ret;
	//#UC END# *51A745CE0034_51A6189A00F0*
}

// implemented method from Link
GCI::IO::String* Link_i::get_linked_hint () const {
	//#UC START# *51AC814F0388_51A6189A00F0*
	try {
		CORBA::String_var hint = m_server_link->get_hint ();
		return GCI::IO::StringFactory::make (hint);
	} catch (...) {
	}
	return GCI::IO::StringFactory::make ("");
	//#UC END# *51AC814F0388_51A6189A00F0*
}

// implemented method from Link
Core::IObject* Link_i::get_object () const /*throw (InvalidTopicId, FolderLinkNotFound, NotAllowedInTrialMode)*/ {
	//#UC START# *51A61EF0013E_51A6189A00F0*
	ObjectFromLink_var object_from_link = 
				ObjectFromLinkFactory::make (m_server_link, LinkedObjectTypeConvertorSingleton::instance ()->get (m_server_link->get_link_object_type ()));
	return object_from_link->get_object ();
	//#UC END# *51A61EF0013E_51A6189A00F0*
}

// implemented method from Link
LinkedObjectType Link_i::get_object_type () const {
	//#UC START# *51A61ED6005B_51A6189A00F0*
	return LinkedObjectTypeConvertorSingleton::instance ()->get (m_server_link->get_link_object_type ());
	//#UC END# *51A61ED6005B_51A6189A00F0*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

