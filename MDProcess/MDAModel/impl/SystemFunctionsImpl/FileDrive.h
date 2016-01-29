////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDrive.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileDrive
// Заголовок реализации класса серванта для интерфеса 
//
// %f_file_drive(путь к файлу) - извлекает имя диска из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDRIVE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDRIVE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"

namespace SystemFunctionsImpl {

class FileDrive; // self forward Var
typedef ::Core::Var<FileDrive> FileDrive_var;
typedef ::Core::Var<const FileDrive> FileDrive_cvar;

class FileDrive_factory;

// %f_file_drive(путь к файлу) - извлекает имя диска из пути к файлу
class FileDrive:
	virtual public FilePathBase
{
	SET_OBJECT_COUNTER (FileDrive)
	friend class FileDrive_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileDrive ();

	virtual ~FileDrive ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class FileDrive

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDRIVE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
