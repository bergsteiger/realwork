////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.cpp"
// генератор файлов реализации C++ (.cpp)
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
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.h"

namespace MetadataFunctionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddMetadatas::AddMetadatas ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDB090196_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDB090196_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2CDB090196_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2CDB090196_BODY*
}

AddMetadatas::~AddMetadatas () {
	//#UC START# *4A2CDB090196_DESTR_BODY*
	//#UC END# *4A2CDB090196_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddMetadatas::execute_impl (
	const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2CE18202C1_4A2CDB090196*
	if (params.size () < 3) {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += " - wrong parametr count";
		throw Base::FatalError (mess);
	}
	std::string var_id = TemplatePainter::resolve_exp(params[0], painter);
	std::string::const_iterator var_id_it = var_id.begin();
	AbstractDumperBase* adb = const_cast<AbstractDumperBase*> (
		painter->get_dumper_by_template(var_id_it, var_id.end ())
	);

	if (adb) {
		std::string list_id_or_metadata = TemplatePainter::resolve_exp(params[2], painter);
		const TemplatePainter::ContainerDumper* container = get_container_if_exists (list_id_or_metadata);

		std::string key = TemplatePainter::resolve_exp(params[1], painter);
		if (container) {
			if (container->size () > 0) {
				for (
					AbstractDumperBase::VarList::const_iterator it = container->get_items ().begin ()
					; it != container->get_items ().end ()
					; ++it
				) {
					adb->add_metadata (key, (*it)->get_name_str ());
				}
			} else {
				std::string mess (GDS_CURRENT_FUNCTION);
				mess += " - can't add empty metadata";
				throw Base::FatalError (mess);
			}
		} else {
			adb->add_metadata (key, list_id_or_metadata);
		}		
	} else {
		std::string mess (GDS_CURRENT_FUNCTION);
		mess += " - can't find dumper: ";
		mess += var_id;
		throw Base::FatalError (mess);
	}
	return std::string ();

	//#UC END# *4A2CE18202C1_4A2CDB090196*
}
} // namespace MetadataFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

