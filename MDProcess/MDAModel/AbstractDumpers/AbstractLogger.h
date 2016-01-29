////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractLogger
//
// абстрактный класс предоставляющий методы дял логгирования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__

#include "shared/CoreSrv/sys/std_inc.h"


// абстрактный класс предоставляющий методы дял логгирования
class AbstractLogger;
typedef Core::Var<AbstractLogger> AbstractLogger_var;
typedef Core::Var<const AbstractLogger> AbstractLogger_cvar;

class AbstractLogger :
	virtual public Core::RefCountObjectBase
{
// virtual void destructor
public:
	virtual ~AbstractLogger () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// метод для логирования ошибок
	virtual void write_error_log (const std::string& mess, bool fatal) const = 0;

	// логирование информационных сообщений
	virtual void write_info_log (const std::string& mess) const = 0;

	// логирование предупреждений
	virtual void write_warning_log (const std::string& mess) const = 0;

}; // class AbstractLogger



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

