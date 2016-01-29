////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::DocumentFactoryKeyHelper
// Файл реализации утилитного набора DocumentFactoryKeyHelper
//
// Получение ключа мультифабрики по серверному документу или PID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentTypeToFactoryKey.h"

namespace GblAdapterLib {
namespace DocumentFactoryKeyHelper {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// По PID'у
FactoryKey PID_to_key (const GCD::PID& pid) {
	//#UC START# *47ED1269019D*
	return DocumentTypeToFactoryKeySingleton::instance ()->get (
		ApplicationHelper::instance ()->get_cached_document_type_resolver ()->get_type (pid)
		);
	//#UC END# *47ED1269019D*
}

// По серверному документу
FactoryKey server_document_to_key (GblPilot::Document* document) {
	//#UC START# *47ED12200202*
	return DocumentTypeToFactoryKeySingleton::instance ()->get (document->get_type ());
	//#UC END# *47ED12200202*
}

} // namespace DocumentFactoryKeyHelper
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

