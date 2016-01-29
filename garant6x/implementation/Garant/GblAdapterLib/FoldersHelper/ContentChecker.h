////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/FoldersHelper/ContentChecker.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::FoldersHelper::ContentChecker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERSHELPER_CONTENTCHECKER_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERSHELPER_CONTENTCHECKER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/ContainersC.h"

namespace GblAdapterLib {
namespace ContentChecker {

// Проверка контента на существование
bool check_content (Containers::Content* content);

// Проверка существует ли контент (лезем на сервер)
bool check_server_content (Containers::Content* content);


} // namespace ContentChecker
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERSHELPER_CONTENTCHECKER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
