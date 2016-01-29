////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DumpDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DumpDiagram
// Заголовок реализации класса серванта для интерфеса 
//
// реализация встроенной функции генератора "_dump_diagram".
// _dump_diagram(«параметр») - пытается сдампить параметр как диаграмму - добавляя её в качестве
// атача к текущей странице
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class DumpDiagram; // self forward Var
typedef ::Core::Var<DumpDiagram> DumpDiagram_var;
typedef ::Core::Var<const DumpDiagram> DumpDiagram_cvar;

class DumpDiagram_factory;

// реализация встроенной функции генератора "_dump_diagram".
// _dump_diagram(«параметр») - пытается сдампить параметр как диаграмму - добавляя её в качестве
// атача к текущей странице
class DumpDiagram:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DumpDiagram)
	friend class DumpDiagram_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DumpDiagram ();

	virtual ~DumpDiagram ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class DumpDiagram

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_DUMPDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
