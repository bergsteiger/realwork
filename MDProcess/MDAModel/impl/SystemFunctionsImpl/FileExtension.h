////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileExtension
// Заголовок реализации класса серванта для интерфеса 
//
// %f_file_extension(путь к файлу) - извлекает расширение файла из пути к файлу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"

namespace SystemFunctionsImpl {

class FileExtension; // self forward Var
typedef ::Core::Var<FileExtension> FileExtension_var;
typedef ::Core::Var<const FileExtension> FileExtension_cvar;

class FileExtension_factory;

// %f_file_extension(путь к файлу) - извлекает расширение файла из пути к файлу
class FileExtension:
	virtual public FilePathBase
{
	SET_OBJECT_COUNTER (FileExtension)
	friend class FileExtension_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileExtension ();

	virtual ~FileExtension ();

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
}; // class FileExtension

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
