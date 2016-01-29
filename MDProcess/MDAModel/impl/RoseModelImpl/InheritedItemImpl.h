////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/InheritedItemImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::InheritedItemImpl
// Заголовок реализации класса серванта для интерфеса InheritedItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/Base/Base.h"

namespace RoseModelImpl {

class InheritedItemImpl; // self forward Var
typedef ::Core::Var<InheritedItemImpl> InheritedItemImpl_var;
typedef ::Core::Var<const InheritedItemImpl> InheritedItemImpl_cvar;

class InheritedItemImpl:
	virtual public InheritedItem
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (InheritedItemImpl)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InheritedItemImpl (const std::string& uid, bool need_collect_child);

	virtual ~InheritedItemImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// признак, что нужно собирать детей элемента
	bool m_need_collect_children;

	Base::ToolPropertyMap m_properties;

	// уникальный идентификатор элемента
	std::string m_uid;

	std::string m_visibility_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual bool get_need_collect_children () const;

	virtual void set_need_collect_children (bool need_collect_children);

	virtual const std::string& get_uid () const;

	virtual void set_uid (const std::string& uid);

	const std::string& get_visibility_type () const;

	void set_visibility_type (const std::string& visibility_type);
private:
	virtual const Base::ToolPropertyMap& get_properties () const;

	virtual void set_properties (const Base::ToolPropertyMap& properties);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from InheritedItem
	// возвращает значение свойства, если свойство отсутсвует - возвращает 0 (возвращаемый указатель
	// захватывать не надо!!!)
	virtual std::string* get_property_value (const std::string& tool_name, const std::string& prop_name) const;

	// implemented method from InheritedItem
	// удаляет свойство
	virtual void remove_property (const std::string& tool_name, const std::string& prop_name);

	// implemented method from InheritedItem
	// устанавливает юзер-свойство
	virtual void set_property (const std::string& tool_name, const std::string& name, const std::string& value);
}; // class InheritedItemImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_INHERITEDITEMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
