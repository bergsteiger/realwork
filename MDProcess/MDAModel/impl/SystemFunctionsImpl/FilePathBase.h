////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FilePathBase
// Заголовок реализации класса серванта для интерфеса 
//
// базовый сервант для работы с файлом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class FilePathBase; // self forward Var
typedef ::Core::Var<FilePathBase> FilePathBase_var;
typedef ::Core::Var<const FilePathBase> FilePathBase_cvar;

// базовый сервант для работы с файлом
class FilePathBase:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (FilePathBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// элемент пути файла
	enum PathComponent {
		PT_DRIVE // диск
		, PT_NAME // имя файла
		, PT_EXT // расширение файла
		, PT_DIR // папка
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FilePathBase ();

	virtual ~FilePathBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Собственно реализации встроенной функции.
	const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
		, PathComponent path_component
	) const;

}; // class FilePathBase

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
