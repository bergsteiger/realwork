////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::DocumentFactoryKeyHelper
//
// Получение ключа мультифабрики по серверному документу или PID
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTFACTORYKEYHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTFACTORYKEYHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {
namespace DocumentFactoryKeyHelper {

// По серверному документу
FactoryKey server_document_to_key (GblPilot::Document* document);

// По PID'у
FactoryKey PID_to_key (const GCD::PID& pid);


} // namespace DocumentFactoryKeyHelper
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_DOCUMENTFACTORYKEYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
