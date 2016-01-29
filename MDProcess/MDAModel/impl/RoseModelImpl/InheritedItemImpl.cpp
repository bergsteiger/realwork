////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

namespace RoseModelImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

InheritedItemImpl::InheritedItemImpl (const std::string& uid, bool need_collect_child)
//#UC START# *4BF386990096_4BF3884E02C8_4BF38D5800F3_BASE_INIT*
	: m_uid (uid), m_need_collect_children (need_collect_child)
//#UC END# *4BF386990096_4BF3884E02C8_4BF38D5800F3_BASE_INIT*
{
	//#UC START# *4BF386990096_4BF3884E02C8_4BF38D5800F3_BODY*
	//#UC END# *4BF386990096_4BF3884E02C8_4BF38D5800F3_BODY*
}

InheritedItemImpl::~InheritedItemImpl () {
	//#UC START# *4BF38D5800F3_DESTR_BODY*
	//#UC END# *4BF38D5800F3_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool InheritedItemImpl::get_need_collect_children () const {
	//#UC START# *4BF38D660161_GET_ACCESSOR*
	return m_need_collect_children;
	//#UC END# *4BF38D660161_GET_ACCESSOR*
}

void InheritedItemImpl::set_need_collect_children (bool need_collect_children) {
	//#UC START# *4BF38D660161_SET_ACCESSOR*
	m_need_collect_children = need_collect_children;
	//#UC END# *4BF38D660161_SET_ACCESSOR*
}

const std::string& InheritedItemImpl::get_uid () const {
	//#UC START# *4BF38D680316_GET_ACCESSOR*
	return m_uid;
	//#UC END# *4BF38D680316_GET_ACCESSOR*
}

void InheritedItemImpl::set_uid (const std::string& uid) {
	//#UC START# *4BF38D680316_SET_ACCESSOR*
	m_uid = uid;
	//#UC END# *4BF38D680316_SET_ACCESSOR*
}

const std::string& InheritedItemImpl::get_visibility_type () const {
	//#UC START# *4C19CEA803C7_GET_ACCESSOR*
	return m_visibility_type;
	//#UC END# *4C19CEA803C7_GET_ACCESSOR*
}

void InheritedItemImpl::set_visibility_type (const std::string& visibility_type) {
	//#UC START# *4C19CEA803C7_SET_ACCESSOR*
	m_visibility_type = visibility_type;
	//#UC END# *4C19CEA803C7_SET_ACCESSOR*
}

const Base::ToolPropertyMap& InheritedItemImpl::get_properties () const {
	//#UC START# *4C19CE8100E9_GET_ACCESSOR*
	return m_properties;
	//#UC END# *4C19CE8100E9_GET_ACCESSOR*
}

void InheritedItemImpl::set_properties (const Base::ToolPropertyMap& properties) {
	//#UC START# *4C19CE8100E9_SET_ACCESSOR*
	m_properties = properties;
	//#UC END# *4C19CE8100E9_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from InheritedItem
// возвращает значение свойства, если свойство отсутсвует - возвращает 0 (возвращаемый указатель
// захватывать не надо!!!)
std::string* InheritedItemImpl::get_property_value (const std::string& tool_name, const std::string& prop_name) const {
	//#UC START# *4C1B522F002D_4BF38D5800F3*
	Base::ToolPropertyMap::const_iterator it = get_properties ().find (tool_name);
	if (it != get_properties ().end ()) {
		Base::PropertyMap::const_iterator p_it = it->second.find (prop_name);

		if (p_it != it->second.end ()) {
			return const_cast<std::string*> (&p_it->second);
		}
	}

	return 0;
	//#UC END# *4C1B522F002D_4BF38D5800F3*
}

// implemented method from InheritedItem
// удаляет свойство
void InheritedItemImpl::remove_property (const std::string& tool_name, const std::string& prop_name) {
	//#UC START# *4C1EF08203D7_4BF38D5800F3*
	Base::ToolPropertyMap::iterator it = m_properties.find (tool_name);
	if (it != m_properties.end ()) {
		Base::PropertyMap::iterator p_it = it->second.find (prop_name);
		it->second.erase (p_it);

		if (it->second.empty ()) {
			m_properties.erase (it);
		}
	}
	//#UC END# *4C1EF08203D7_4BF38D5800F3*
}

// implemented method from InheritedItem
// устанавливает юзер-свойство
void InheritedItemImpl::set_property (
	const std::string& tool_name
	, const std::string& name
	, const std::string& value
) {
	//#UC START# *4C19C57000BA_4BF38D5800F3*
	m_properties[tool_name][name] = value;
	//#UC END# *4C19C57000BA_4BF38D5800F3*
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

