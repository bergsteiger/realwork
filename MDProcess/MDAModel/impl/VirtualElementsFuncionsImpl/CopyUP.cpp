////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyUP
//
// %S%f_copy_up(<УИД или имя элемента>) - копирует значения UP из элемента-источника в элемент-
// цель, при этом в элементе-цели новых свойств не создается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CopyUP::CopyUP ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9F83470132_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9F83470132_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9F83470132_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9F83470132_BODY*
}

CopyUP::~CopyUP () {
	//#UC START# *4A9F83470132_DESTR_BODY*
	//#UC END# *4A9F83470132_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CopyUP::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A9F83470132*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	const RoseAbstractDumper* source = dynamic_cast<const RoseAbstractDumper*> (self);
	if (source) {
		std::string target_uid_or_name = TemplatePainter::resolve_exp (params[0], painter);

		const RoseAbstractDumper* target = RoseAbstractDumper::find_in_tree (target_uid_or_name);

		if (!target) {
			Core::Aptr<ObjectTreeResolver::OTRVector> results = RoseAbstractDumper::find_by_name (target_uid_or_name);
			if (results->size () > 1) {
				throw Base::FatalError (
					std::string ("Найдено более одного элемента с именем: ") 
					+ target_uid_or_name
				);
			} else if (!results->empty ()) {
				target = dynamic_cast<const RoseAbstractDumper*> ((*results)[0]);
			}
		}
		
		if (!target) {
			throw Base::FatalError (
				std::string ("Не удалось найти элемент: ") 
				+ target_uid_or_name
			);
		}

		const AbstractDumperBase::Template& source_tpl = source->get_template ();
		const AbstractDumperBase::Template& target_tpl = target->get_template ();
		
		if (
			source_tpl.user_properties_group.is_nil () == false
			&& target_tpl.user_properties_group.is_nil () == false
		) {
			const AbstractDumperBase::UserPropertyMap& source_props = source_tpl.user_properties_group->get_properties ();
			const AbstractDumperBase::UserPropertyMap& target_props = target_tpl.user_properties_group->get_properties ();
			
			AbstractDumperBase::UserPropertyMap::const_iterator src_it = source_props.begin ();
			AbstractDumperBase::UserPropertyMap::const_iterator src_it_end = source_props.end ();

			IRoseElementPtr target_item = target->rose_element ();
			RoseInternal::RoseElement* virtual_obj = target_item.GetInterfacePtr ()
				? dynamic_cast<RoseInternal::RoseElement*> (target_item.GetInterfacePtr ())
				: 0;

			_bstr_t uc_tool_name (Base::USER_PROPERTY_TOOL);
			for (; src_it != src_it_end; ++src_it) {
				if (target_props.find (src_it->first) != target_props.end ()) {
					//в целевом элементе есть это свойство
					std::string source_up = source->get_user_property_str (src_it->first);
					if (virtual_obj) {
						//если элемент виртуальный, то ничего лочить не надо - просто пишем в свойства
						virtual_obj->override_property (
							std::string (uc_tool_name)
							, src_it->first
							, source_up
						);
					} else {
						target->set_temporary_property (std::string (uc_tool_name), src_it->first, source_up);						
					}					
				}
			}
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A9F83470132*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

