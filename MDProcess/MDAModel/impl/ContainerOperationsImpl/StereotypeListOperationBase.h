////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/StereotypeListOperationBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::StereotypeListOperationBase
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_STEREOTYPELISTOPERATIONBASE_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_STEREOTYPELISTOPERATIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace ContainerOperationsImpl {

class StereotypeListOperationBase; // self forward Var
typedef ::Core::Var<StereotypeListOperationBase> StereotypeListOperationBase_var;
typedef ::Core::Var<const StereotypeListOperationBase> StereotypeListOperationBase_cvar;

class StereotypeListOperationBase:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
{
	SET_OBJECT_COUNTER (StereotypeListOperationBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StereotypeListOperationBase ();

	virtual ~StereotypeListOperationBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual const std::string execute_impl2 (
		TemplatePainter::ContainerDumper* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/ = 0;


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
}; // class StereotypeListOperationBase

} // namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_STEREOTYPELISTOPERATIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
