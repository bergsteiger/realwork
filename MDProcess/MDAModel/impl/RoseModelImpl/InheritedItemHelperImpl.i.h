////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemHelperImpl.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemHelperImpl
// Файл inline реализации класса серванта для интерфеса InheritedItemHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
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
// nested implementation

// реализация функции сохранения
template <class T>
bool InheritedItemHelperImpl::save_impl (
	IRoseElementPtr elem
	, const std::string& prop_name
	, const T& inherted_items
) const {
	//#UC START# *4BF3BC120067_4BF38CD402D8*
	std::string value = stored_value_impl (inherted_items);

	return RoseHelper::override_property (elem, TOOL_NAME, prop_name.c_str (), value.c_str ());
	//#UC END# *4BF3BC120067_4BF38CD402D8**cpp*
}

// реализация метода stored_value
template <class T>
const std::string InheritedItemHelperImpl::stored_value_impl (const T& inherited_items) const {
	//#UC START# *4BF632F002C3_4BF38CD402D8*
	//static_cast<const InheritedItem* (Core::Var<InheritedItem>::*)() const> (&Core::Var<InheritedItem>::ptr);
	
	boost::property_tree::ptree pt;

	GCL::StrSet stored_values;
	for (
		typename T::const_iterator it = inherited_items.begin ()
		; it != inherited_items.end ()
		; ++it
	) {
		Core::Aptr<boost::property_tree::ptree> item_tree = serialize_item ((*it).in ());
		GDS_ASSERT((item_tree.ptr ()));

		pt.put_child ((*it)->get_uid (), *item_tree.ptr ());
	}

	std::stringstream s;
	boost::property_tree::write_json (s, pt, false);
	return s.str ();
	//#UC END# *4BF632F002C3_4BF38CD402D8**cpp*
}

// реализация функции сохранения
template <class T>
bool InheritedItemHelperImpl::save_impl (
	Base::Dumper* elem
	, const std::string& prop_name
	, const T& inherted_items
) const {
	//#UC START# *4D350F0F032C_4BF38CD402D8*
	RoseAbstractDumper* rad = dynamic_cast<RoseAbstractDumper*> (elem);
	GDS_ASSERT(rad);

	std::string value = stored_value_impl (inherted_items);

	bool result = RoseHelper::override_property (rad->rose_element (), TOOL_NAME, prop_name.c_str (), value.c_str ());
	result |= rad->set_temporary_property (std::string (_bstr_t(TOOL_NAME)), prop_name, value);

	return result;
	//#UC END# *4D350F0F032C_4BF38CD402D8**cpp*
}



// реализация метода получения списка переопределенных элементов заданного типа на основе
// сохраненных ранее данных
template <class InheritedTypeFactory, class Result>
Result* InheritedItemHelperImpl::get_stored_inherited_items_impl (
	IRoseElementPtr elem
	, const std::string& prop_name
) const {
	//#UC START# *4BF6265A00B0_4BF38CD402D8*
	return get_stored_inherited_items_impl<InheritedTypeFactory, Result> (
		std::string (static_cast<const char*> (elem->GetPropertyValue(TOOL_NAME, prop_name.c_str ())))
	);
	//#UC END# *4BF6265A00B0_4BF38CD402D8**cpp*
}

// реализация метода получения списка переопределенных элементов заданного типа на основе
// сохраненных ранее данных
template <class InheritedTypeFactory, class Result>
Result* InheritedItemHelperImpl::get_stored_inherited_items_impl (const std::string& prop_value) const {
	//#UC START# *4BF65B7A0137_4BF38CD402D8*
	Core::Aptr<Result> result (new Result ());
	
	if (!prop_value.empty ()) {
		try {
			boost::property_tree::ptree pt;
			std::stringstream s;
			s << prop_value;

			boost::property_tree::read_json (s, pt);
			
			boost::property_tree::ptree empty_tree;
			BOOST_FOREACH (boost::property_tree::ptree::value_type& v, pt) {
				std::string guid = v.first;
				boost::property_tree::ptree& item = v.second;
				
				bool need_collect_children = item.get_optional<bool> (NEED_COLLECT_CHILDREN_KEY).get_value_or (true);
				
				typename Result::value_type new_inherited_item = InheritedTypeFactory::make (
					guid
					, need_collect_children
				);
				
				boost::optional<std::string> visibility_type = item.get_optional<std::string> (Base::VISIBILITY_TYPE);
				if (visibility_type.is_initialized ()) {
					new_inherited_item->set_visibility_type (visibility_type.get ());
				}

				Base::ToolPropertyMap all_props;
				BOOST_FOREACH (boost::property_tree::ptree::value_type &all_p, item.get_child (PROPERTIES_LIST_KEY, empty_tree)) {
					Base::PropertyMap tool_props;
					BOOST_FOREACH (boost::property_tree::ptree::value_type &p, all_p.second.get_child ("", empty_tree)) {
						tool_props[p.first] = p.second.get_value<std::string> ();
						/*boost::optional<std::string> name = p.second.get_optional<std::string> (PROPERTY_NAME_KEY);
						boost::optional<std::string> value = p.second.get_optional<std::string> (PROPERTY_VALUE_KEY);
						if (name.is_initialized () && value.is_initialized ()) {
							tool_props[name.get ()] = value.get ();
						}*/
					}
					
					if (!tool_props.empty ()) {
						all_props[all_p.first] = tool_props;
					}
				}
				
				if (!all_props.empty ()) {
					new_inherited_item->set_properties (all_props);
				}

				result->insert (new_inherited_item);
			}
		} catch (boost::property_tree::ptree_error&) {
			GCL::StrSet stored_values;
			GCL::split_string_by (stored_values, prop_value.c_str (), ',');

			for (
				GCL::StrSet::const_iterator it = stored_values.begin ()
				; it != stored_values.end ()
				; ++it
			) {
				std::string guid;
				boolean need_collect_children = true;
				std::string::size_type pos = (*it).find ("|");
				if (pos != std::string::npos) {
					guid = (*it).substr (0, pos);
					std::string rest ((*it).substr (pos + 1));
					if (rest == "false") {
						need_collect_children = false;
					}
				} else {
					guid = (*it);
				}

				result->insert (InheritedTypeFactory::make (guid, need_collect_children));
			}
		}
	}

	return result.forget ();
	//#UC END# *4BF65B7A0137_4BF38CD402D8**cpp*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

} // namespace RoseModelImpl
		

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

