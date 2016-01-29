////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
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
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.h"

namespace MetadataFunctionsImpl {

AddMetadatas_factory::AddMetadatas_factory () {
}

void AddMetadatas_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddMetadatas_factory::key () const {
	return "_add_metadatas";
}

TemplateFunctions::InternalFunction* AddMetadatas_factory::make () {
	AddMetadatas_var ret = new AddMetadatas ();
	return ret._retn ();
}

} // namespace MetadataFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

