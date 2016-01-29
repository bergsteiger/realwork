////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/Security_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Security_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garantServer/src/Services/GslUserManager/GslUserManagerC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

//forward decl
namespace GblAdapterLib {
	template <class NodeDelegateType_> class View;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class UserNodeDelegate;
} // namespace GblAdapterLib


namespace GblAdapterLib {

typedef View< UserNodeDelegate > UsersTreeDef;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

