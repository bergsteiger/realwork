////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/str/str_op.h"
#include "boost/bind.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "boost/property_tree/ptree.hpp"
#include "boost/property_tree/json_parser.hpp"
#include <sstream>
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImpl.h"
#include "boost/foreach.hpp"
#include "MDProcess/MDAModel/RoseInternal/RoseClassImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperationImpl.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InheritedItemHelperImpl::InheritedItemHelperImpl ()
//#UC START# *4BF385490364_4BF387BA03D2_4BF38CD402D8_BASE_INIT*
//#UC END# *4BF385490364_4BF387BA03D2_4BF38CD402D8_BASE_INIT*
{
	//#UC START# *4BF385490364_4BF387BA03D2_4BF38CD402D8_BODY*
	//#UC END# *4BF385490364_4BF387BA03D2_4BF38CD402D8_BODY*
}

InheritedItemHelperImpl::~InheritedItemHelperImpl () {
	//#UC START# *4BF38CD402D8_DESTR_BODY*
	//#UC END# *4BF38CD402D8_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// сериализует элемент в дерево свойств
boost::property_tree::ptree* InheritedItemHelperImpl::serialize_item (const InheritedItem* item) const {
	//#UC START# *4C19D52C01A4*
	Core::Aptr<boost::property_tree::ptree> pt (new boost::property_tree::ptree ());

	boost::property_tree::ptree all_props;
	for (
		Base::ToolPropertyMap::const_iterator it = item->get_properties ().begin ()
		; it != item->get_properties ().end ()
		; ++it
	) {
		if (!it->second.empty ()) {
			boost::property_tree::ptree tool_props;
			for (
				Base::PropertyMap::const_iterator prop_it = it->second.begin ()
				; prop_it != it->second.end ()
				; ++prop_it
			) {
				tool_props.put (prop_it->first, prop_it->second);
				/*boost::property_tree::ptree property;
				property.put (PROPERTY_NAME_KEY, prop_it->first);
				property.put (PROPERTY_VALUE_KEY, prop_it->second);

				tool_props.push_back (std::make_pair ("", property));*/
			}

			all_props.put_child (it->first, tool_props);
		}
	}

	pt->put (NEED_COLLECT_CHILDREN_KEY, item->get_need_collect_children ());

	if (!all_props.empty ()) {
		pt->put_child (PROPERTIES_LIST_KEY, all_props);
	}

	if (!item->get_visibility_type ().empty ()) {
		pt->put (Base::VISIBILITY_TYPE, item->get_visibility_type ());		
	}

	return pt.forget ();
	//#UC END# *4C19D52C01A4*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from InheritedItemHelper
// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее информации
ImplementedItemSet* InheritedItemHelperImpl::get_stored_implemented (IRoseElementPtr elem) const {
	//#UC START# *4BF382CB019F_4BF38CD402D8*
	return get_stored_inherited_items_impl<ImplementedItemFactory, ImplementedItemSet> (
		elem
		, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))
	);
	//#UC END# *4BF382CB019F_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает список реализуемых элементов, для элемента elem на основе сохраненной ранее информации
// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
// от пакета RoseDumpers)
ImplementedItemSet* InheritedItemHelperImpl::get_stored_implemented (const Base::Dumper* elem) const {
	//#UC START# *4BF383970307_4BF38CD402D8*
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (elem);
	GDS_ASSERT(rad);

	std::string prop_value = rad->get_property_value (
		std::string (static_cast<const char*> (_bstr_t (TOOL_NAME)))
		, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))
	);

	return this->get_stored_inherited_items_impl<ImplementedItemFactory, ImplementedItemSet> (prop_value);
	//#UC END# *4BF383970307_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
InheritedItemSet* InheritedItemHelperImpl::get_stored_inherited_items (
	IRoseElementPtr elem
	, const std::string& prop_name
) const {
	//#UC START# *4BF62F270256_4BF38CD402D8*
	if (prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))) {
		return get_stored_inherited_items_impl<ImplementedItemFactory, InheritedItemSet> (
			elem
			, prop_name
		);
	} else if (prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))) {
		return get_stored_inherited_items_impl<OverloadedItemFactory, InheritedItemSet> (
			elem
			, prop_name
		);
	}
	
	GDS_ASSERT_MSG(0, ("%s: Unknown inhertied item type for property:", GDS_CURRENT_FUNCTION, prop_name.c_str ()));

	return 0;
	//#UC END# *4BF62F270256_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает список переопределяемых элементов сохраненных в свойствах по ключу prop_name
// 
// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
// от пакета RoseDumpers)
InheritedItemSet* InheritedItemHelperImpl::get_stored_inherited_items (
	const Base::Dumper* elem
	, const std::string& prop_name
) const {
	//#UC START# *4BF62F820014_4BF38CD402D8*
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (elem);
	GDS_ASSERT(rad);

	std::string prop_value = rad->get_property_value (
		std::string (static_cast<const char*> (_bstr_t (TOOL_NAME)))
		, prop_name
	);

	if (prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))) {
		return get_stored_inherited_items_impl<ImplementedItemFactory, InheritedItemSet> (prop_value);
	} else if (prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))) {
		return get_stored_inherited_items_impl<OverloadedItemFactory, InheritedItemSet> (prop_value);
	}

	GDS_ASSERT_MSG(0, ("%s: Unknown inhertied item type for property:", GDS_CURRENT_FUNCTION, prop_name.c_str ()));

	return 0;
	//#UC END# *4BF62F820014_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
// информации
OverloadedItemSet* InheritedItemHelperImpl::get_stored_overloaded (IRoseElementPtr elem) const {
	//#UC START# *4BF384140307_4BF38CD402D8*
	return get_stored_inherited_items_impl<OverloadedItemFactory, OverloadedItemSet> (
		elem
		, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))
	);
	//#UC END# *4BF384140307_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает список переопределяемых элементов, для элемента elem на основе сохраненной ранее
// информации
// elem должен быть экземпляром RoseAbstractDumper (тут используется тип Dumper, чтобы не зависеть
// от пакета RoseDumpers)
OverloadedItemSet* InheritedItemHelperImpl::get_stored_overloaded (const Base::Dumper* elem) const {
	//#UC START# *4BF384170122_4BF38CD402D8*
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (elem);
	GDS_ASSERT(rad);

	std::string prop_value = rad->get_property_value (
		std::string (static_cast<const char*> (_bstr_t (TOOL_NAME)))
		, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))
	);

	return this->get_stored_inherited_items_impl<OverloadedItemFactory, OverloadedItemSet> (prop_value);
	//#UC END# *4BF384170122_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// создает элемент обертку для переопределяемого элемента
IRoseElementPtr InheritedItemHelperImpl::make_wrapper (IRoseElementPtr elem, const InheritedItem* state) const {
	//#UC START# *4C1F0377006C_4BF38CD402D8*
	IRoseElementPtr res;
	if (elem->IsClass (CLASS_TYPE)) {
		ATL::CComObject<RoseInternal::RoseOverridenClassImpl>* obj;
		ATL::CComObject<RoseInternal::RoseOverridenClassImpl>::CreateInstance (&obj);
		obj->init (elem, state);
		res = obj;
	} else if (elem->IsClass (OPERATION_TYPE)) {
		ATL::CComObject<RoseInternal::RoseOverridenOperationImpl>* obj;
		ATL::CComObject<RoseInternal::RoseOverridenOperationImpl>::CreateInstance (&obj);
		obj->init (elem, state);
		res = obj;
	} else if (elem->IsClass (ATTRIBUTE_TYPE)) {
		ATL::CComObject<RoseInternal::RoseOverridenAttributeImpl>* obj;
		ATL::CComObject<RoseInternal::RoseOverridenAttributeImpl>::CreateInstance (&obj);
		obj->init (elem, state);
		res = obj;
	} else if (elem->IsClass (ROLE_TYPE)) {
		ATL::CComObject<RoseInternal::RoseOverridenRoleImpl>* obj;
		ATL::CComObject<RoseInternal::RoseOverridenRoleImpl>::CreateInstance (&obj);
		obj->init (elem, state);
		res = obj;
	} else {
		GDS_ASSERT_MSG(0, ("%s: Unsupported type \"%s\"", GDS_CURRENT_FUNCTION, static_cast<const char*> (elem->IdentifyClass ())));
		return 0;
	}

	RoseHelper::override_property (res, TOOL_NAME, Base::IS_OVERRIDEN_WRAPPER, "true");

	return res;
	//#UC END# *4C1F0377006C_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// сохранить список реализуемых элементов
bool InheritedItemHelperImpl::save (IRoseElementPtr elem, const ImplementedItemSet& items) const {
	//#UC START# *4BF387700113_4BF38CD402D8*
	return save_impl (elem, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT))), items);
	//#UC END# *4BF387700113_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// сохранить список переопределямых элементов
bool InheritedItemHelperImpl::save (IRoseElementPtr elem, const OverloadedItemSet& items) const {
	//#UC START# *4BF3879D01CE_4BF38CD402D8*
	return save_impl (elem, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD))), items);
	//#UC END# *4BF3879D01CE_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// сохранить список реализуемых элементов
bool InheritedItemHelperImpl::save (Base::Dumper* elem, const ImplementedItemSet& items) const {
	//#UC START# *4D350E23006D_4BF38CD402D8*
	return save_impl (elem, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT))), items);
	//#UC END# *4D350E23006D_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// сохранить список переопределяемых элементов
bool InheritedItemHelperImpl::save (Base::Dumper* elem, const OverloadedItemSet& items) const {
	//#UC START# *4D350E43004E_4BF38CD402D8*
	return save_impl (elem, std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD))), items);
	//#UC END# *4D350E43004E_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает сериализованное значение для множества переопределяемых элементов
const std::string InheritedItemHelperImpl::stored_value (const InheritedItemSet& inherited_items) const {
	//#UC START# *4BF6327D01C9_4BF38CD402D8*
	return stored_value_impl (inherited_items);
	//#UC END# *4BF6327D01C9_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает сериализованное значение для множества переопределяемых элементов
const std::string InheritedItemHelperImpl::stored_value (const OverloadedItemSet& inherited_items) const {
	//#UC START# *4C1EF906006C_4BF38CD402D8*
	return stored_value_impl (inherited_items);
	//#UC END# *4C1EF906006C_4BF38CD402D8*
}

// implemented method from InheritedItemHelper
// возвращает сериализованное значение для множества переопределяемых элементов
const std::string InheritedItemHelperImpl::stored_value (const ImplementedItemSet& inherited_items) const {
	//#UC START# *4C1EF9080211_4BF38CD402D8*
	return stored_value_impl (inherited_items);
	//#UC END# *4C1EF9080211_4BF38CD402D8*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

