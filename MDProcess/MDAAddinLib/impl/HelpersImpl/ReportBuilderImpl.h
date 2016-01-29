////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::ReportBuilderImpl
// Заголовок реализации класса серванта для интерфеса ReportBuilder
//
// реализация построяителя отчета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace HelpersImpl {

class ReportBuilderImpl; // self forward Var
typedef ::Core::Var<ReportBuilderImpl> ReportBuilderImpl_var;
typedef ::Core::Var<const ReportBuilderImpl> ReportBuilderImpl_cvar;

class ReportBuilderImpl_factory;

// реализация построяителя отчета
class ReportBuilderImpl:
	virtual public Helpers::ReportBuilder
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ReportBuilderImpl)
	friend class ReportBuilderImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ReportBuilderImpl ();

	virtual ~ReportBuilderImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Helpers::ReportBuilder
	// выполняет шаблон отчета к элементу и всем его детям
	virtual Helpers::ReportResult* build (
		const RoseAbstractDumper* from
		, const AbstractDumperBase::ReportsTreeItem* report
	) const;
}; // class ReportBuilderImpl

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_REPORTBUILDERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
