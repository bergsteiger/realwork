////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"

namespace GblAdapterLib {


const char* NoDocumentList::uid () const /*throw ()*/ {
	return "CDAAA10F-25B1-40AB-AF38-E442812FC0C4";
}

const char* NoDocumentList::what () const throw () {
	//#UC START# *4570098B0157_WHAT_IMPL*
	return "NoDocumentList (Нет списка документов в ответе)";
	//#UC END# *4570098B0157_WHAT_IMPL*
}


const char* NoConnection::uid () const /*throw ()*/ {
	return "53B82DF7-4FB0-4277-8051-7B45D1BE2CFA";
}

const char* NoConnection::what () const throw () {
	//#UC START# *4570098B0159_WHAT_IMPL*
	return "NoConnection (Нет связи с сервером консультаций)";
	//#UC END# *4570098B0159_WHAT_IMPL*
}


const char* NoSubscription::uid () const /*throw ()*/ {
	return "FE9BA082-AF49-4436-9F44-BB9F311123F4";
}

const char* NoSubscription::what () const throw () {
	//#UC START# *4570098B015B_WHAT_IMPL*
	return "NoSubscription (Нет доступа с сервису - вы не подписаны на услугу)";
	//#UC END# *4570098B015B_WHAT_IMPL*
}


const char* PaymentForbidden::uid () const /*throw ()*/ {
	return "EEF53043-B518-4C31-A0BB-D5FFA24C8148";
}

const char* PaymentForbidden::what () const throw () {
	//#UC START# *4570098B015F_WHAT_IMPL*
	return "PaymentForbidden (У пользователя нет прав оплачивать консультации)";
	//#UC END# *4570098B015F_WHAT_IMPL*
}


const char* NotDeleted::uid () const /*throw ()*/ {
	return "052FCB78-0AF7-43D4-90C2-7B0483DF9778";
}

const char* NotDeleted::what () const throw () {
	//#UC START# *4570098B015D_WHAT_IMPL*
	return "NotDeleted (Нельзя удалить консультацию)";
	//#UC END# *4570098B015D_WHAT_IMPL*
}


const char* Deleted::uid () const /*throw ()*/ {
	return "0786C2ED-20EF-42D8-884B-777DD8CC206A";
}

const char* Deleted::what () const throw () {
	//#UC START# *4570098B0161_WHAT_IMPL*
	return "Deleted (Консультация удалена - все операции запрещены)";
	//#UC END# *4570098B0161_WHAT_IMPL*
}

// factory interface wrapper for Estimation
Estimation* EstimationFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return EstimationFactoryManager::Singleton::instance ()->make ();
}


const char* OldFormatConsultation::uid () const /*throw ()*/ {
	return "5B2DADE4-4723-4C2B-857C-C4AF9455B1F2";
}

const char* OldFormatConsultation::what () const throw () {
	//#UC START# *46286C980119_WHAT_IMPL*
	return "OldFormatConsultation (консультация старого формата)";
	//#UC END# *46286C980119_WHAT_IMPL*
}

// factory interface wrapper for Consultation
Consultation* ConsultationFactory::make (
	GblConsultingClient::Consultation* server_consultation
	, FoldersNode* folders_node
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultationFactoryManager::Singleton::instance ()->make (server_consultation, folders_node);
}

// factory interface wrapper for ConsultationManager
ConsultationManager* ConsultationManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultationManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for ConsultingTemplateInfo
ConsultingTemplateInfo* ConsultingTemplateInfoFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConsultingTemplateInfoFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

