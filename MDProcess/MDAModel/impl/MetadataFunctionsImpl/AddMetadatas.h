////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
// Заголовок реализации класса серванта для интерфеса 
//
// Функция добавления метаданных к элементу, при применении изменений эти метаданные будут
// добавлены к странице, связанной с элементом.
// _add_metadatas («дампер», «ключ метаданных», «идентификатор списка с метаданными»). Если список
// с «идентификатор списка с метаданными» не найден, то этот параметр интерпретируется как
// метаданные.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__
#define __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace MetadataFunctionsImpl {

class AddMetadatas; // self forward Var
typedef ::Core::Var<AddMetadatas> AddMetadatas_var;
typedef ::Core::Var<const AddMetadatas> AddMetadatas_cvar;

class AddMetadatas_factory;

// Функция добавления метаданных к элементу, при применении изменений эти метаданные будут
// добавлены к странице, связанной с элементом.
// _add_metadatas («дампер», «ключ метаданных», «идентификатор списка с метаданными»). Если список
// с «идентификатор списка с метаданными» не найден, то этот параметр интерпретируется как
// метаданные.
class AddMetadatas:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (AddMetadatas)
	friend class AddMetadatas_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddMetadatas ();

	virtual ~AddMetadatas ();

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
}; // class AddMetadatas

} // namespace MetadataFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
