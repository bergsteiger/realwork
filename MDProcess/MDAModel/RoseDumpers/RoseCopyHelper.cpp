////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseDumpers::RoseCopyHelper
// Файл реализации утилитного набора RoseCopyHelper
//
// набор вспомогательных функций для копирования элементов Розы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace RoseCopyHelper {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// метод для копирования атрибута - в результате dest - полная копия source с тем же стереотипом,
// видимостью и т.д, НО - это другой объект
void copy (IRoseAttributePtr source, IRoseAttributePtr& dest, bool copy_for_relocate) {
	//#UC START# *46E64716036B*
	GDS_ASSERT(source);
	GDS_ASSERT(dest);
	dest->Name = source->Name;
	dest->Type = source->Type;
	dest->InitValue = source->InitValue;
	dest->Stereotype = source->Stereotype;
	dest->Documentation = source->Documentation;
	
	copy_mda_property (source, (IRoseElementPtr)dest, copy_for_relocate);
	//#UC END# *46E64716036B*
}

// метод для копирования  операции - в результате dest - полная копия source с тем же стереотипом,
// видимостью и т.д, НО - это другой объект
void copy (IRoseOperationPtr source, IRoseOperationPtr& dest, bool copy_for_relocate) {
	//#UC START# *46E6558503C8*
	GDS_ASSERT(source);
	GDS_ASSERT(dest);
	dest->Name = source->Name;
	dest->ReturnType = source->ReturnType;	
	dest->Stereotype = source->Stereotype;
	dest->Documentation = source->Documentation;
		
	//копируем параметры операции
	IRoseParameterCollectionPtr params = source->GetParameters ();
	short params_count = params->Count;
	for (short i = 1; i <= params_count; ++i) {
		IRoseParameterPtr param = params->GetAt (i);
		IRoseParameterPtr new_param = dest->AddParameter (
			param->GetName ()
			, param->GetType ()
			, param->GetInitValue ()
			, i
		);
		
		copy_mda_property (param, (IRoseElementPtr)new_param, copy_for_relocate);
	}

	copy_mda_property (source, (IRoseElementPtr)dest, copy_for_relocate);
	//#UC END# *46E6558503C8*
}

// копируем все mda-свойства элемента (списки исключений, юзер-свойства и т.д)
void copy_mda_property (IRoseElementPtr source, IRoseElementPtr& dest, bool copy_for_relocate) {
	//#UC START# *46E66CC2009C*
	GDS_ASSERT(source);
	GDS_ASSERT(dest);

	IRosePropertyCollectionPtr source_props = source->GetAllProperties ();
	
	std::string src_guid = get_rose_element_uid(source);
	std::string dest_guid = get_rose_element_uid(dest);

	std::string src_parent_guid;
	std::string dest_parent_guid;

	IRoseElementPtr source_parent = RoseHelper::get_context (source);
	IRoseElementPtr dest_parent = RoseHelper::get_context (dest);

	if (source_parent != 0) {
		src_parent_guid = get_rose_element_uid(source_parent);
	}

	if (dest_parent != 0) {
		dest_parent_guid = get_rose_element_uid(dest_parent);
	}

	short props_count = source_props->Count;
	_bstr_t tool_name = TOOL_NAME;
	_bstr_t tool_uc_name = Base::USER_PROPERTY_TOOL;
	for (short i = 1; i <= props_count; ++i) {
		IRosePropertyPtr prop = source_props->GetAt (i);
		std::string prop_name = prop->GetName ();
		if (
			prop->GetToolName () == tool_name 
			&& (
				copy_for_relocate
				|| (
					prop_name != Base::ELEMENT_CREATION_ORDER
					&& !RoseHelper::is_user_code_property(prop_name)
				)
			)
			&& prop_name != Base::STORED_UID_KEY
		) {
			//копируем только наши свойства
			std::string prop_value = prop->GetValue ();
			GCL::str_replace (prop_name, src_guid.c_str (), dest_guid.c_str ());				
			GCL::str_replace (prop_value, src_guid.c_str (), dest_guid.c_str ());
			
			if (src_parent_guid.empty () == false) {
				GCL::str_replace (prop_name, src_parent_guid.c_str (), dest_parent_guid.c_str ());
				GCL::str_replace (prop_value, src_parent_guid.c_str (), dest_parent_guid.c_str ());
			}
			RoseHelper::override_property(dest, tool_name, prop_name.data(), prop_value.data ());
		} else if (prop->GetToolName () == tool_uc_name) {
			RoseHelper::override_property(dest, tool_uc_name, prop->GetName (), prop->GetValue ());
		}
	}
	
	RoseHelper::set_visibility_type (dest, RoseHelper::get_visibility_type (source));
	RoseHelper::set_link_type (dest, RoseHelper::get_link_type (source));
	RoseHelper::set_abstraction_type (dest, RoseHelper::get_abstraction_type (source));
	//#UC END# *46E66CC2009C*
}

} // namespace RoseCopyHelper

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

