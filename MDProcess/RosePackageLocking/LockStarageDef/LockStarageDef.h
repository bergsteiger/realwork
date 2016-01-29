////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LockStarageDef/LockStarageDef.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataDef::Category>> MDProcess::RosePackageLocking::LockStarageDef
//
// описание хранилища залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <list>

//forward decl
namespace RosePackageLocking {
namespace LockStarageDef {
	class PackageInfo;
} // namespace LockStarageDef
} // namespace RosePackageLocking


namespace RosePackageLocking {
namespace LockStarageDef {

// список пакетов, прочитанных из хранилища
typedef std::list < Core::Box<PackageInfo> > PackageInfoList;

} //namespace LockStarageDef
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

