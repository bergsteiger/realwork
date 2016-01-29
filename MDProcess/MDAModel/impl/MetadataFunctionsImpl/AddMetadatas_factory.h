////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
// Заголовк реализации фабрик интерфеса  для серванта AddMetadatas
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
#ifndef __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__
#define __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace MetadataFunctionsImpl {

/// Interface-factory implementation for AddMetadatas
class AddMetadatas_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	AddMetadatas_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<AddMetadatas_factory> AddMetadatas_factory_var;

} // namespace MetadataFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

