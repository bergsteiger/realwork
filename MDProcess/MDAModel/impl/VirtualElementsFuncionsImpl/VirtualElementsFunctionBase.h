////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualElementsFunctionBase
// Заголовок реализации класса серванта для интерфеса 
//
// Базовый класс для всех функций работы с виртуальными элементами. Все реализации функций
// суммонинга должны наследоваться от него!
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class VirtualElementsFunctionBase; // self forward Var
typedef ::Core::Var<VirtualElementsFunctionBase> VirtualElementsFunctionBase_var;
typedef ::Core::Var<const VirtualElementsFunctionBase> VirtualElementsFunctionBase_cvar;

// Базовый класс для всех функций работы с виртуальными элементами. Все реализации функций
// суммонинга должны наследоваться от него!
class VirtualElementsFunctionBase:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
{
	SET_OBJECT_COUNTER (VirtualElementsFunctionBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	VirtualElementsFunctionBase ();

	virtual ~VirtualElementsFunctionBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// формирует новый UID на основании текущего элемента.
	virtual const std::string make_uid (
		const AbstractDumperBase* self
		, const std::string& prefix
		, const std::string& suffix
	) const;



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

private:

	// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// метод вызываемый после вызовы реализации функции
	virtual void post_execute () const;

	// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// метод вызываемый перед вызовом реализации функции
	virtual void pre_execute () const;

}; // class VirtualElementsFunctionBase

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
