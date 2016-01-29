////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseItem.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseElement.h"

namespace RoseInternal {

class RoseItem :
	virtual public RoseElement
{
	SET_OBJECT_COUNTER (RoseItem)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// исключение о том, что неверно указан родитель элемента
	class WrongContext : public ::Core::Exception {
	public:
		const char* what () const throw ();

	private:
		const char* uid () const /*throw ()*/;

	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseItem ();

public:
	virtual ~RoseItem ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// изменилось имя
	virtual void rich_type_name_changed (IRoseRichType* obj, const std::string& old_value);

	// изменилось значение свойства
	virtual void rich_type_value_changed (IRoseRichType* obj, short old_value);

protected:
	virtual HRESULT dispatch_export_control (WORD flags, DISPPARAMS* params, VARIANT* result);

	// возврашаеьт реального родителя элемента
	virtual IRoseElementPtr get_real_context () const;

private:
	// формирует имя свойства для записи в родительский элемент - просто приклеивает UID к имени
	// свойства
	virtual const std::string make_property_name (const std::string& prop_name) const;

	// возвращает true, сли свойство должно быть просто записано в родителя без изменения значения
	virtual bool need_write_to_parent (const std::string& prop_name) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// хак, для того, чтобы хранить не Ptr а просто указатель на интерфейс
	IRoseItem* m_context_ptr;

	std::string m_documentation;

	IRoseRichTypePtr m_export_control;

	std::string m_stereotype;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context) /*throw WrongContext*/;

	const std::string& get_documentation () const;

	void set_documentation (const std::string& documentation);

	virtual IRoseRichTypePtr get_export_control () const;

	virtual void set_export_control (IRoseRichTypePtr export_control);

	virtual const std::string& get_stereotype () const;

	virtual void set_stereotype (const std::string& stereotype);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
private:

	// implemented method from RoseElement
	// при необходимости обновляет информацию о свойствах у родителя - например необходимо записать в
	// родителя список артефактов, сгенерённых с элемента
	virtual void update_parent_properties (
		const std::string& tool_name
		, const std::string& prop_name
		, const std::string& value
	);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseElement
	virtual const std::string get_property_value (const std::string& tool_name, const std::string& prop_name);

	// overloaded method from RoseElement
	virtual const std::string get_qualified_name ();

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

}; // class RoseItem

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

