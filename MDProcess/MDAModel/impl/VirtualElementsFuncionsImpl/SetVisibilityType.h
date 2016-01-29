////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetVisibilityType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetVisibilityType
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// станавливает тип видиости элемента. Применима ТОЛЬКО для виртуальных элементов. Если тип
// видимости не указан в списке разрешённых шаблоном - выбрасывается исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetVisibilityType; // self forward Var
typedef ::Core::Var<SetVisibilityType> SetVisibilityType_var;
typedef ::Core::Var<const SetVisibilityType> SetVisibilityType_cvar;

class SetVisibilityType_factory;

// %S%f_set_visability_type(PublicAccess|ProtectedAccess|PrivateAccess|ImplementationAccess) -
// станавливает тип видиости элемента. Применима ТОЛЬКО для виртуальных элементов. Если тип
// видимости не указан в списке разрешённых шаблоном - выбрасывается исключение
class SetVisibilityType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetVisibilityType)
	friend class SetVisibilityType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetVisibilityType ();

	virtual ~SetVisibilityType ();

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
}; // class SetVisibilityType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETVISIBILITYTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
