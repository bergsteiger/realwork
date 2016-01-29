////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::OverrideImplementBase
//
// базовая реализация метода добавления операции в список overload или implemented
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/OverrideImplementBase.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

OverrideImplementBase::OverrideImplementBase ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A39D9F50195_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A39D9F50195_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A39D9F50195_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A39D9F50195_BODY*
}

// prop - имя свойства, в которое будет добавляться операция
OverrideImplementBase::OverrideImplementBase (const std::string& prop, char list_tpl_command)
//#UC START# *4A39DA460099_BASE_INIT*
	: m_property_name (prop), m_list_tpl_command (list_tpl_command)
//#UC END# *4A39DA460099_BASE_INIT*
{
	//#UC START# *4A39DA460099_BODY*
	//#UC END# *4A39DA460099_BODY*
}

OverrideImplementBase::~OverrideImplementBase () {
	//#UC START# *4A39D9F50195_DESTR_BODY*
	//#UC END# *4A39D9F50195_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string OverrideImplementBase::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A39D9F50195*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string operation_guid = TemplatePainter::resolve_exp (params[0], painter);		

		IRoseItemPtr item = rad->rose_element ();
		if (item) {
			const RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (operation_guid);
			
			if (!target_rad) {
				Core::Aptr<AbstractDumperBase::ADList> derived_impl = rad->get_derived_impl ();
				Core::Aptr<AbstractDumperBase::ADList> derived_over = rad->get_derived_over ();
				
				typedef std::set<const AbstractDumperBase*> ADBSet;
				typedef std::set<const RoseAbstractDumper*> RADSet;

				ADBSet operations (derived_impl->begin (), derived_impl->end ());
				operations.insert (derived_over->begin (), derived_over->end ());
				
				RADSet founded_operations;
				size_t len = operation_guid.length ();
				for (
					ADBSet::iterator it = operations.begin ()
					; it != operations.end ()
					; ++it
				) {
					const RoseAbstractDumper* it_rad = dynamic_cast<const RoseAbstractDumper*> (*it);
					if (it_rad) {
						std::string name = (static_cast<const Base::NamedElement*> (it_rad))->get_full_name ();
						std::string::size_type pos = name.rfind (operation_guid);
						
						//проверяем, что полное имя элемента заканчивается на operation_guid
						if (pos != std::string::npos && (pos + len) == name.length ()) {
							founded_operations.insert (it_rad);
						}
					}
				}
				
				if (founded_operations.empty ()) {
					throw Base::FatalError (
						std::string ("Не удалось найти операцию: ")
						+ operation_guid
					);
				} else if (founded_operations.size () > 1) {
					throw Base::FatalError (
						std::string ("Найден более одной операции с именем: ")
						+ operation_guid
					);
				} else {
					target_rad = *(founded_operations.begin ());
				}
			}
			
			std::string target_item_type = target_rad->get_model_class_str ();
			if (target_item_type == OPERATION_TYPE || target_item_type == ATTRIBUTE_TYPE || target_item_type == CLASS_TYPE) {
				//this->add_new_overriden_element (rad, target_rad)
				Core::Aptr<InheritedItemSet> inherited_items (InheritedItemHelperFactory::get ().get_stored_inherited_items (rad, m_property_name));
				if (!inherited_items.is_nil ()) {
					if (m_property_name == std::string (_bstr_t (PROP_DERIVED_OVERLOAD))) {
						inherited_items->insert (OverloadedItemFactory::make (operation_guid, false));
					} else if (m_property_name == std::string (_bstr_t (PROP_DERIVED_IMPLEMENT))) {
						inherited_items->insert (ImplementedItemFactory::make (operation_guid, false));
					} else {
						GDS_ASSERT_MSG(0, ("Unknown overriden property name: %s", m_property_name.c_str ()));
					}

					std::string overriden_list_value = InheritedItemHelperFactory::get ().stored_value (*inherited_items.ptr ());
					rad->set_temporary_property (std::string (_bstr_t(TOOL_NAME)), m_property_name, overriden_list_value);				
				}				
				
				painter->invalidate_dumpers_list (m_list_tpl_command, rad);
			} else {
				throw Base::FatalError (
					std::string ("Элемент не является ни операцией, ни атрибутом: ")
					+ operation_guid
				);
			}
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A39D9F50195*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

