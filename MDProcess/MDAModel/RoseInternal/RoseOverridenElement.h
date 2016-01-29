////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseOverridenElement.h"
// генератор заголовочных файлов C++ (.h)
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
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

//#UC START# *4C10F3D5007E_CUSTOM_INCLUDES*
//#UC END# *4C10F3D5007E_CUSTOM_INCLUDES*

namespace RoseInternal {

// Элемент, представляющий собой переопределение на вкладке DerivedImpl. Является оберткой над
// реальным элементов и все вызовы, кроме необходимых перенаправляет этому элементу. Позволяет
// переопределять видимость, абстрактность и значения UP. Сам элемент не перзистентный, поэтому
// ответственность за сохранение элемента лежит на клиенте
class RoseOverridenElement :
	virtual public RoseItem
{
	SET_OBJECT_COUNTER (RoseOverridenElement)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseOverridenElement ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// инициализация элемента
	void init (IRoseElementPtr delegate, const InheritedItem* state);

private:
	// добавляет в список свойств элемента свойства с делегата
	virtual void merge_properties (
		IRosePropertyCollectionPtr delegate_props
		, IRosePropertyCollectionPtr& self_props
	) const;

	// возвращает true, если работа со свойством должна быть передана делегату, если же элемент
	// перекрывает это свойство - возвращается false
	virtual bool need_forward_property (const std::string& tool_name, const std::string& prop_name) const;

	// возвращает true, если свойство нужно сохранить в связанном состоянии
	virtual bool property_need_to_save_in_state (const std::string& tool_name, const std::string& prop_name) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// делегат
	IRoseElementPtr m_delegate;

	// признак абстрактности
	bool m_is_abstract;

	// элемент, который переопределяет - на нем будет хранится информация о переопределении
	IRoseElementPtr m_overriden_owner;

	// хранимое состояние для переопределяемого элемента
	InheritedItem_var m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseElementPtr get_delegate () const;

	void set_delegate (IRoseElementPtr delegate);

	bool get_is_abstract () const;

	void set_is_abstract (bool is_abstract);

	IRoseElementPtr get_overriden_owner () const;

	void set_overriden_owner (IRoseElementPtr overriden_owner);

	virtual const InheritedItem* get_state () const;

	virtual void set_state (InheritedItem* state);


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseElement
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name);

	// overloaded method from RoseElement
	virtual IRosePropertyCollectionPtr get_rose_all_properties () const;

	// overloaded method from RoseElement
	virtual IRosePropertyCollectionPtr get_rose_tool_properties (const std::string& tool_name) const;

	// overloaded method from RoseElement
	virtual VARIANT_BOOL override_property (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	);

	// overloaded method from RoseItem
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context)
		/*throw (RoseItem::WrongContext)*/;

	// overloaded method from RoseItem
	virtual IRoseRichTypePtr get_export_control () const;

	virtual void set_export_control (IRoseRichTypePtr export_control);

	// overloaded method from RoseItem
	// изменилось имя
	virtual void rich_type_name_changed (IRoseRichType* obj, const std::string& old_value);

	// overloaded method from RoseItem
	// изменилось значение свойства
	virtual void rich_type_value_changed (IRoseRichType* obj, short old_value);

	// overloaded method from RoseItem
	virtual const std::string& get_stereotype () const;

	virtual void set_stereotype (const std::string& stereotype);

	// overloaded method from RoseObject
	virtual HRESULT dispatch (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);

	// overloaded method from RoseObject
	virtual const std::string identify_class ();

	// overloaded method from RoseObject
	// приведение
	virtual VARIANT_BOOL is_class (const std::string& class_name);
protected:

	// overloaded method from RoseElement
	// возвращает true, если у элемента есть свойство с заданным именем, иначе false
	virtual bool is_property_exist (const std::string& tool_name, const std::string& prop_name) const;

	// overloaded method from RoseItem
	// возврашаеьт реального родителя элемента
	virtual IRoseElementPtr get_real_context () const;


//#UC START# *4C10F3D5007E*
//#UC END# *4C10F3D5007E*
}; // class RoseOverridenElement

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOVERRIDENELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

