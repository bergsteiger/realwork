////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddClass
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_add_class(<GUID нового элемента>,<стереотип>,<имя класса>,<имя переменной>) - создает новый
// элемент - класс с заданным именем и стереотипом, сохраняет его в переменной и добавляет как
// ребенка к текущему элементу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCLASS_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCLASS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddClass; // self forward Var
typedef ::Core::Var<AddClass> AddClass_var;
typedef ::Core::Var<const AddClass> AddClass_cvar;

class AddClass_factory;

// %S%f_add_class(<GUID нового элемента>,<стереотип>,<имя класса>,<имя переменной>) - создает новый
// элемент - класс с заданным именем и стереотипом, сохраняет его в переменной и добавляет как
// ребенка к текущему элементу
class AddClass:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddClass)
	friend class AddClass_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddClass ();

	virtual ~AddClass ();

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
}; // class AddClass

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCLASS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
