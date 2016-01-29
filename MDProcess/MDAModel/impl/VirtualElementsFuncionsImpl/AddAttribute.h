////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddAttribute
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_add_attribute(<GUID нового элемента>, <стереотип>,<сигнатура атрибута>,<имя переменной>) -
// аналогично _add_operation, но создается новый атрибут, значение по-умолчанию может быть задано
// ГУИДом реального элемента либо просто строкой (аналогично типу).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddAttribute; // self forward Var
typedef ::Core::Var<AddAttribute> AddAttribute_var;
typedef ::Core::Var<const AddAttribute> AddAttribute_cvar;

class AddAttribute_factory;

// %S%f_add_attribute(<GUID нового элемента>, <стереотип>,<сигнатура атрибута>,<имя переменной>) -
// аналогично _add_operation, но создается новый атрибут, значение по-умолчанию может быть задано
// ГУИДом реального элемента либо просто строкой (аналогично типу).
class AddAttribute:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddAttribute)
	friend class AddAttribute_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddAttribute ();

	virtual ~AddAttribute ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddAttribute

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDATTRIBUTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
