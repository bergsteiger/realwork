////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::ReportBuilderImpl
//
// реализация построяителя отчета
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl.h"

namespace HelpersImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ReportBuilderImpl::ReportBuilderImpl ()
//#UC START# *4BE12D3A036B_4BE12F2B035B_4BE1318400CB_BASE_INIT*
//#UC END# *4BE12D3A036B_4BE12F2B035B_4BE1318400CB_BASE_INIT*
{
	//#UC START# *4BE12D3A036B_4BE12F2B035B_4BE1318400CB_BODY*
	//#UC END# *4BE12D3A036B_4BE12F2B035B_4BE1318400CB_BODY*
}

ReportBuilderImpl::~ReportBuilderImpl () {
	//#UC START# *4BE1318400CB_DESTR_BODY*
	//#UC END# *4BE1318400CB_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Helpers::ReportBuilder
// выполняет шаблон отчета к элементу и всем его детям
Helpers::ReportResult* ReportBuilderImpl::build (
	const RoseAbstractDumper* from
	, const AbstractDumperBase::ReportsTreeItem* report
) const {
	//#UC START# *4BE12F380251_4BE1318400CB*
	GDS_ASSERT(from);

	Core::Aptr<Helpers::ReportResult> result (new Helpers::ReportResult ());

	AbstractDumperBase::s_gen_root_element = from;
	try {
		bool b = false;
		for (
			ObjectTreeResolver::ObjectTree::iterator it = RoseAbstractDumper::s_tree->begin()
			; it != RoseAbstractDumper::s_tree->end()
			; it++
		) {
			const ObjectTreeResolver* otr_it = **it;
			const RoseAbstractDumper* rad_it = dynamic_cast<const RoseAbstractDumper*>(otr_it);

			if (!rad_it->is_native (b) && rad_it->is_child_of (from)) {
				if (rad_it->resolve_expression (report->query()) == "true") {
					Helpers::ReportResultItem item;
					item.element = rad_it;
					
					for (
						AbstractDumperBase::ReportsTreeItem::Views::const_iterator it = report->get_views().begin()
						; it != report->get_views().end()
						; ++it
					) {
						item.messages.push_back (rad_it->resolve_expression (it->expression));
					}

					result->push_back (item);
				}
			}
		}		
	} catch (...) {
		AbstractDumperBase::s_gen_root_element = 0;
		throw;
	}

	AbstractDumperBase::s_gen_root_element = 0;

	return result.forget ();
	//#UC END# *4BE12F380251_4BE1318400CB*
}
} // namespace HelpersImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

