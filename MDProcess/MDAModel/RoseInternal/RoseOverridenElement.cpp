////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseOverridenElement.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseOverridenElement
//
// Элемент, представляющий собой переопределение на вкладке DerivedImpl. Является оберткой над
// реальным элементов и все вызовы, кроме необходимых перенаправляет этому элементу. Позволяет
// переопределять видимость, абстрактность и значения UP. Сам элемент не перзистентный, поэтому
// ответственность за сохранение элемента лежит на клиенте
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOverridenElement.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/Base/Base.h"
#include "boost/property_tree/json_parser.hpp"
#include "boost/property_tree/ptree.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "boost/foreach.hpp"
#include "MDProcess/MDAModel/RoseInternal/RosePropertyImpl.h"

//#UC START# *4C10F3D5007E_CUSTOM_INCLUDES*
//#UC END# *4C10F3D5007E_CUSTOM_INCLUDES*

namespace RoseInternal {

//#UC START# *4C10F3D5007E*
//#UC END# *4C10F3D5007E*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseOverridenElement::~RoseOverridenElement () {
	//#UC START# *4C10F3D5007E_DESTR_BODY*
	//#UC END# *4C10F3D5007E_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// инициализация элемента
void RoseOverridenElement::init (IRoseElementPtr delegate, const InheritedItem* state) {
	//#UC START# *4C10F46F00CC*
	GDS_ASSERT((state));

	this->set_state (const_cast<InheritedItem*> (state));
	this->set_delegate (delegate);

	if (!state->get_visibility_type ().empty ()) {
		this->get_export_control ()->PutName (state->get_visibility_type ().c_str ());
	} else {
		this->get_export_control ()->PutName (RoseHelper::get_visibility_type (delegate).c_str ());
	}

	GDS_ASSERT_MSG (
		delegate->IsClass (CLASS_TYPE) 
			|| delegate->IsClass (OPERATION_TYPE) 
			|| delegate->IsClass (ATTRIBUTE_TYPE)
			|| delegate->IsClass (ROLE_TYPE)
		, ("Unsupported element: %s", static_cast<const char*> (m_delegate->IdentifyClass ()))
	);
	/*if (!this->deserialize (overriden_tree)) {
		RoseItem::get_export_control ()->PutName (RoseHelper::get_visibility_type (m_delegate).c_str ());

		IRosePropertyCollectionPtr up_properties = m_delegate->GetToolProperties (Base::USER_PROPERTY_TOOL);
		short count = up_properties->Count;
		
		for (short i = 1; i <= count; ++i) {
			IRosePropertyPtr prop = up_properties->GetAt (i);
			RoseElement::override_property (
				Base::USER_PROPERTY_TOOL
				, static_cast<const char*> (prop->Name)
				, static_cast<const char*> (prop->Value)
			);
		}

		this->serialize ();
	}*/
	//#UC END# *4C10F46F00CC*
}

// добавляет в список свойств элемента свойства с делегата
void RoseOverridenElement::merge_properties (
	IRosePropertyCollectionPtr delegate_props
	, IRosePropertyCollectionPtr& self_props
) const {
	//#UC START# *4C1761EE02F9*
	const Base::ToolPropertyMap& self_all_props = RoseElement::get_overriden_property ();	
	
	short count = delegate_props->Count;
	for (short i = 1; i <= count; ++i) {
		IRosePropertyPtr delegate_prop = delegate_props->GetAt (i);

		Base::ToolPropertyMap::const_iterator tool_it = self_all_props.find (static_cast<const char*> (delegate_prop->ToolName));
		bool already_have_prop = tool_it != self_all_props.end () 
			&& tool_it->second.find (static_cast<const char*> (delegate_prop->Name)) != tool_it->second.end ();

		if (!already_have_prop) {
			ATL::CComObject<RoseInternal::RosePropertyImpl>* obj;
			ATL::CComObject<RoseInternal::RosePropertyImpl>::CreateInstance (&obj);

			IRosePropertyPtr prop = obj;

			prop->Name = delegate_prop->Name;
			prop->Value = delegate_prop->Value;
			prop->ToolName = delegate_prop->ToolName;
			prop->Type = "String";			

			self_props->Add (prop);
		}
	}
	//#UC END# *4C1761EE02F9*
}

// возвращает true, если работа со свойством должна быть передана делегату, если же элемент
// перекрывает это свойство - возвращается false
bool RoseOverridenElement::need_forward_property (const std::string& tool_name, const std::string& prop_name) const {
	//#UC START# *4C12035D0253*
	return (
		!property_need_to_save_in_state (tool_name, prop_name)
		&& !(tool_name == std::string (_bstr_t (TOOL_NAME)) && prop_name == Base::IS_OVERRIDEN_WRAPPER)
	);
	//#UC END# *4C12035D0253*
}

// возвращает true, если свойство нужно сохранить в связанном состоянии
bool RoseOverridenElement::property_need_to_save_in_state (
	const std::string& tool_name
	, const std::string& prop_name
) const {
	//#UC START# *4C1B1D020117*
	return (
		tool_name == Base::USER_PROPERTY_TOOL 
		|| tool_name == std::string (_bstr_t (TOOL_NAME))
			&& (
				prop_name == Base::VISIBILITY_TYPE
				|| prop_name == Base::ABSTRACTION_TYPE
			)
	);
	//#UC END# *4C1B1D020117*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

IRoseElementPtr RoseOverridenElement::get_delegate () const {
	//#UC START# *4C10F4B0007E_GET_ACCESSOR*
	return m_delegate;
	//#UC END# *4C10F4B0007E_GET_ACCESSOR*
}

void RoseOverridenElement::set_delegate (IRoseElementPtr delegate) {
	//#UC START# *4C10F4B0007E_SET_ACCESSOR*
	m_delegate = delegate;
	//#UC END# *4C10F4B0007E_SET_ACCESSOR*
}

bool RoseOverridenElement::get_is_abstract () const {
	//#UC START# *4C11DF2403BA_GET_ACCESSOR*
	return m_is_abstract;
	//#UC END# *4C11DF2403BA_GET_ACCESSOR*
}

void RoseOverridenElement::set_is_abstract (bool is_abstract) {
	//#UC START# *4C11DF2403BA_SET_ACCESSOR*
	m_is_abstract = is_abstract;
	//#UC END# *4C11DF2403BA_SET_ACCESSOR*
}

IRoseElementPtr RoseOverridenElement::get_overriden_owner () const {
	//#UC START# *4C11D9FD031E_GET_ACCESSOR*
	return m_overriden_owner;
	//#UC END# *4C11D9FD031E_GET_ACCESSOR*
}

void RoseOverridenElement::set_overriden_owner (IRoseElementPtr overriden_owner) {
	//#UC START# *4C11D9FD031E_SET_ACCESSOR*
	m_overriden_owner = overriden_owner;
	//#UC END# *4C11D9FD031E_SET_ACCESSOR*
}

const InheritedItem* RoseOverridenElement::get_state () const {
	//#UC START# *4C19C285029E_GET_ACCESSOR*
	return m_state.in ();
	//#UC END# *4C19C285029E_GET_ACCESSOR*
}

void RoseOverridenElement::set_state (InheritedItem* state) {
	//#UC START# *4C19C285029E_SET_ACCESSOR*
	m_state = InheritedItem::_duplicate (state);
	//#UC END# *4C19C285029E_SET_ACCESSOR*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseElement
const std::string RoseOverridenElement::get_property_value (
	const std::string& tool_name
	, const std::string& prop_name
) {
	//#UC START# *4A2F9A710095_4C10F3D5007E*
	std::string* state_value = m_state->get_property_value (tool_name, prop_name);
	if (state_value != 0) {
		return *state_value;
	} else if (this->need_forward_property (tool_name, prop_name) || !RoseElement::is_property_exist (tool_name, prop_name)) {
		return static_cast<const char*> (m_delegate->GetPropertyValue (tool_name.c_str (), prop_name.c_str ()));
	}

	return RoseElement::get_property_value (tool_name, prop_name);
	//#UC END# *4A2F9A710095_4C10F3D5007E*
}

// overloaded method from RoseElement
IRosePropertyCollectionPtr RoseOverridenElement::get_rose_all_properties () const {
	//#UC START# *4A9BAE98034D_4C10F3D5007E*
	IRosePropertyCollectionPtr self_all_props_as_rose = RoseElement::get_rose_all_properties ();
	IRosePropertyCollectionPtr delegate_all_props = m_delegate->GetAllProperties ();

	merge_properties (delegate_all_props, self_all_props_as_rose);

	return self_all_props_as_rose;
	//#UC END# *4A9BAE98034D_4C10F3D5007E*
}

// overloaded method from RoseElement
IRosePropertyCollectionPtr RoseOverridenElement::get_rose_tool_properties (const std::string& tool_name) const {
	//#UC START# *4A9BAEF7038F_4C10F3D5007E*
	IRosePropertyCollectionPtr self_tool_props_as_rose = RoseElement::get_rose_tool_properties (tool_name);
	IRosePropertyCollectionPtr delegate_tool_props = m_delegate->GetToolProperties (tool_name.c_str ());

	merge_properties (delegate_tool_props, self_tool_props_as_rose);

	return self_tool_props_as_rose;
	//#UC END# *4A9BAEF7038F_4C10F3D5007E*
}

// overloaded method from RoseElement
// возвращает true, если у элемента есть свойство с заданным именем, иначе false
bool RoseOverridenElement::is_property_exist (const std::string& tool_name, const std::string& prop_name) const {
	//#UC START# *4AA0FAA101E6_4C10F3D5007E*
	return RoseElement::is_property_exist (tool_name, prop_name) 
		|| m_delegate->FindProperty (tool_name.c_str (), prop_name.c_str ()) != 0
		|| m_state->get_property_value (tool_name, prop_name) != 0;	
	//#UC END# *4AA0FAA101E6_4C10F3D5007E*
}

// overloaded method from RoseElement
VARIANT_BOOL RoseOverridenElement::override_property (
	const std::string& tool_name
	, const std::string& prop_name
	, const std::string& value
) {
	//#UC START# *4A2F987B0257_4C10F3D5007E*
	bool res = false;
	if (this->need_forward_property (tool_name, prop_name)) {
		res = RoseHelper::override_property (m_delegate, tool_name.c_str (), prop_name.c_str (), value.c_str ());
	} else {
		res = RoseElement::override_property (tool_name, prop_name, value);
		
		std::string* state_value = m_state->get_property_value (tool_name, prop_name);
		std::string delegate_value = get_delegate ()->GetPropertyValue (tool_name.c_str (), prop_name.c_str ());

		//хак - нужен для случая, когда ЮП реального элемента не менялись, соответсвенно
		//в настройках для них записей нет, поэтому нужно получить значение по-умолчанию для ЮП,
		//чтобы не записать лишнего в переопределенный элемент

		if (delegate_value.empty () && tool_name == Base::USER_PROPERTY_TOOL) {
			AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype (get_delegate ());		
			const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);
			AbstractDumperBase::UserPropertyMap props;
			tpl.user_properties_group->for_each (
				AbstractDumperBase::CollectUserProperty ()
				, props
			);

			AbstractDumperBase::UserPropertyMap::iterator f = props.find (prop_name);
			if (f != props.end ()) {			
				delegate_value = f->second.def_value;
			}
		}
		if (this->property_need_to_save_in_state (tool_name, prop_name)) {
			if (
				delegate_value != value
				&& (state_value == 0 || *state_value != value)
			) {
				m_state->set_property (tool_name, prop_name, value);
			} else if (state_value) {
				//если больше не перекрываем значение свойства реального элемента -
				//нужно удалить свойство из хранимого состояния
				m_state->remove_property (tool_name, prop_name);
			}
		}
	}

	return res;
	//#UC END# *4A2F987B0257_4C10F3D5007E*
}

// overloaded method from RoseItem
IRoseItemPtr RoseOverridenElement::get_context () const {
	//#UC START# *4A30A6480352_4C10F3D5007E_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A30A6480352_4C10F3D5007E_GET*
}

void RoseOverridenElement::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4C10F3D5007E_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A30A6480352_4C10F3D5007E_SET*
}

// overloaded method from RoseItem
IRoseRichTypePtr RoseOverridenElement::get_export_control () const {
	//#UC START# *4A35E3B60097_4C10F3D5007E_GET*
	return RoseItem::get_export_control ();
	//#UC END# *4A35E3B60097_4C10F3D5007E_GET*
}

void RoseOverridenElement::set_export_control (IRoseRichTypePtr export_control) {
	//#UC START# *4A35E3B60097_4C10F3D5007E_SET*
	RoseItem::set_export_control (export_control);

	if (
		m_state->get_visibility_type () != static_cast<const char*> (export_control->GetName ())
		&& m_state->get_visibility_type () != RoseHelper::get_visibility_type (get_delegate ())
	) {
		m_state->set_visibility_type (static_cast<const char*> (export_control->GetName ()));
	} else {
		m_state->set_visibility_type (std::string ());
	}
	//#UC END# *4A35E3B60097_4C10F3D5007E_SET*
}

// overloaded method from RoseItem
// возврашаеьт реального родителя элемента
IRoseElementPtr RoseOverridenElement::get_real_context () const {
	//#UC START# *4AA746D10248_4C10F3D5007E*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4AA746D10248_4C10F3D5007E*
}

// overloaded method from RoseItem
// изменилось имя
void RoseOverridenElement::rich_type_name_changed (IRoseRichType* obj, const std::string& old_value) {
	//#UC START# *4C1B537000E9_4C10F3D5007E*
	IRoseRichType* export_control = RoseItem::get_export_control ().GetInterfacePtr ();
	std::string new_visibility_type (static_cast<const char*> (obj->GetName ()));
	std::string delegate_visibility_type (RoseHelper::get_visibility_type (get_delegate ()));
	if (
		export_control == obj 
		&& delegate_visibility_type != new_visibility_type
		&& m_state->get_visibility_type () != new_visibility_type
	) {
		m_state->set_visibility_type (new_visibility_type);
	}
	//#UC END# *4C1B537000E9_4C10F3D5007E*
}

// overloaded method from RoseItem
// изменилось значение свойства
void RoseOverridenElement::rich_type_value_changed (IRoseRichType* obj, short old_value) {
	//#UC START# *4C1B53B102FC_4C10F3D5007E*
	//#UC END# *4C1B53B102FC_4C10F3D5007E*
}

// overloaded method from RoseItem
const std::string& RoseOverridenElement::get_stereotype () const {
	//#UC START# *4A2FB5E600F1_4C10F3D5007E_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2FB5E600F1_4C10F3D5007E_GET*
}

void RoseOverridenElement::set_stereotype (const std::string& stereotype) {
	//#UC START# *4A2FB5E600F1_4C10F3D5007E_SET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A2FB5E600F1_4C10F3D5007E_SET*
}

// overloaded method from RoseObject
HRESULT RoseOverridenElement::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4C10F3D5007E*
	if (m_delegate->IsClass (CLASS_TYPE)) {
		switch (id) {			
			case 418:
				return this->dispatch_export_control (flags, params, result);
				break;
		}
	} else if (m_delegate->IsClass (OPERATION_TYPE)) {
		switch (id) {			
			case 414:
				return this->dispatch_export_control (flags, params, result);
				break;
		}
	} else if (m_delegate->IsClass (ATTRIBUTE_TYPE)) {
		switch (id) {			
			case 415:
				return this->dispatch_export_control (flags, params, result);
				break;
		}
	} else if (m_delegate->IsClass (ROLE_TYPE)) {
		switch (id) {			
			case 618:
				return this->dispatch_export_control (flags, params, result);
				break;
		}
	}

	switch (id) {
		case 110:
		case 119:
		case 122:
		case 123:
			return RoseItem::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
			break;
	}

	return m_delegate->Invoke (id, riid, lcid, flags, params, result, exp_info, arg_err);
	//#UC END# *4A2FA53702AA_4C10F3D5007E*
}

// overloaded method from RoseObject
const std::string RoseOverridenElement::identify_class () {
	//#UC START# *4A2F96770397_4C10F3D5007E*
	return std::string (static_cast<const char*> (this->get_delegate ()->IdentifyClass ()));
	//#UC END# *4A2F96770397_4C10F3D5007E*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseOverridenElement::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4C10F3D5007E*
	return this->get_delegate ()->IsClass (class_name.c_str ());
	//#UC END# *4A2F954B0069_4C10F3D5007E*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

