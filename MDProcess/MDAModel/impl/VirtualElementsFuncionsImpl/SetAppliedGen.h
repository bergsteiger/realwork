////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAppliedGen.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAppliedGen
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_set_applied_gen(<имя генератора>,<true/false>) - устанавливает или снимает галку Applied
// Generators на элементе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETAPPLIEDGEN_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETAPPLIEDGEN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetAppliedGen; // self forward Var
typedef ::Core::Var<SetAppliedGen> SetAppliedGen_var;
typedef ::Core::Var<const SetAppliedGen> SetAppliedGen_cvar;

class SetAppliedGen_factory;

// %S%f_set_applied_gen(<имя генератора>,<true/false>) - устанавливает или снимает галку Applied
// Generators на элементе
class SetAppliedGen:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetAppliedGen)
	friend class SetAppliedGen_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetAppliedGen ();

	virtual ~SetAppliedGen ();

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
}; // class SetAppliedGen

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETAPPLIEDGEN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
