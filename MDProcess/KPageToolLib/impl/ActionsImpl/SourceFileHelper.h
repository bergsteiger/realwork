////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::KPageToolLib::ActionsImpl::SourceFileHelper
//
// Для чтения и записи данных в файл обмена
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/ActionsImpl.h"

namespace KPageToolLib {
namespace ActionsImpl {

// Для чтения и записи данных в файл обмена
class SourceFileHelper {
	SET_OBJECT_COUNTER (SourceFileHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// читает данные как вектор
	static int read_as_char_vector (CharVector& str);

	// читает из файла из настроек, в случае ошибки возвращает не ноль
	static int read_as_string (std::string& str);

	// пишет str в файл из настроек, в случае ошибки возвращает не ноль.
	static int write (const char* str);

}; // class SourceFileHelper

} // namespace ActionsImpl
} // namespace KPageToolLib


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONSIMPL_SOURCEFILEHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

