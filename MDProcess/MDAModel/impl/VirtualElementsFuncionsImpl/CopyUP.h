////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyUP.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyUP
// Заголовок реализации класса серванта для интерфеса 
//
// %S%f_copy_up(<УИД или имя элемента>) - копирует значения UP из элемента-источника в элемент-
// цель, при этом в элементе-цели новых свойств не создается.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class CopyUP; // self forward Var
typedef ::Core::Var<CopyUP> CopyUP_var;
typedef ::Core::Var<const CopyUP> CopyUP_cvar;

class CopyUP_factory;

// %S%f_copy_up(<УИД или имя элемента>) - копирует значения UP из элемента-источника в элемент-
// цель, при этом в элементе-цели новых свойств не создается.
class CopyUP:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (CopyUP)
	friend class CopyUP_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CopyUP ();

	virtual ~CopyUP ();

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
}; // class CopyUP

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYUP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
