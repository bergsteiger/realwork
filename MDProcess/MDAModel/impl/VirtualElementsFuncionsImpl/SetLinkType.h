////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetLinkType
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_link_type(agr|lnk|ref) - устанавливает тип связи для атрибута. Применима ТОЛЬКО для
// вирутальных элементов. Если устанавливаемый тип связи не казан как разрешенный в шаблоне -
// бросает исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetLinkType; // self forward Var
typedef ::Core::Var<SetLinkType> SetLinkType_var;
typedef ::Core::Var<const SetLinkType> SetLinkType_cvar;

class SetLinkType_factory;

// %S%f_set_link_type(agr|lnk|ref) - устанавливает тип связи для атрибута. Применима ТОЛЬКО для
// вирутальных элементов. Если устанавливаемый тип связи не казан как разрешенный в шаблоне -
// бросает исключение
class SetLinkType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetLinkType)
	friend class SetLinkType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetLinkType ();

	virtual ~SetLinkType ();

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
}; // class SetLinkType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETLINKTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
