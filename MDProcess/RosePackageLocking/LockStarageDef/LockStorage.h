////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LockStarageDef/LockStorage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::RosePackageLocking::LockStarageDef::LockStorage
//
// хранилище информации о захваченных пакетах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_LOCKSTORAGE_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_LOCKSTORAGE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/PackageInfo.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStarageDef.h"
#include <stdio.h>
#include <fstream>

namespace RosePackageLocking {
namespace LockStarageDef {

// хранилище информации о захваченных пакетах
class LockStorage {

public:
	explicit LockStorage (const char* file_name);
	explicit LockStorage (std::istream* source_stream);

	PackageInfoList packages () /*antrl::ANTRLException*/;

private:
	Core::Aptr<std::istream> m_input_stream;
	std::string m_filename;
}; //class LockStorage
} // namespace LockStarageDef
} // namespace RosePackageLocking



#endif //__MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_LOCKSTORAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
