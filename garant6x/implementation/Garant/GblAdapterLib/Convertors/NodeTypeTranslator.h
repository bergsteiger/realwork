////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/NodeTypeTranslator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<TypeConvertor::Class>> garant6x::GblAdapterLib::Convertors::NodeTypeTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONVERTORS_NODETYPETRANSLATOR_H__
#define __GARANT6X_GBLADAPTERLIB_CONVERTORS_NODETYPETRANSLATOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "shared/Core/data/UnsortedTypeConverter.h"

namespace GblAdapterLib {

class NodeTypeTranslator : 
	public Core::UnsortedTypeConverter<GblPilotDef::MenuItemType, NodeType> {
	protected:
		void fill_array () {
			//#UC START# *460BBE6D036B_FILL_ARRAY_IMPLEMENTATION*
			this->add (GblPilotDef::mi_law_navigator_folder,	NM_LAW_NAVIGATOR_FOLDER);
			this->add (GblPilotDef::mi_business_info_folder,	NM_BUSINESS_INFO_FOLDER);
			this->add (GblPilotDef::mi_search_folder,	NM_SEARCH_FOLDER);
			this->add (GblPilotDef::mi_update_folder, NM_UPDATE_FOLDER);
			this->add (GblPilotDef::mi_prop_search, NM_ATTRIBUTE_SEARCH);
			this->add (GblPilotDef::mi_sit_search, NM_SITUATION_SEARCH);
			this->add (GblPilotDef::mi_src_search, NM_PUBLISH_SOURCE_SEARCH);
			this->add (GblPilotDef::mi_class, NM_FOLDER);
			this->add (GblPilotDef::mi_list, NM_LIST);
			this->add (GblPilotDef::mi_doc, NM_DOCUMENT);
			this->add (GblPilotDef::mi_dict, NM_EXPLANATORY_DICTIONARY);
			this->add (GblPilotDef::mi_settings, NM_CONFIGURATION_LIST);
			this->add (GblPilotDef::mi_info, NM_COMPLECT_INFO);
			this->add (GblPilotDef::mi_new_doc, NM_NEW_DOCS);
			this->add (GblPilotDef::mi_prime_folder, NM_PRIME_FOLDER);
			this->add (GblPilotDef::mi_review_search, NM_REVIEW);
			this->add (GblPilotDef::mi_news_line, NM_NEWS_LINE);
			this->add (GblPilotDef::mi_search_with_law_support, NM_SEARCH_WITH_LAW_SUPPORT);
			this->add (GblPilotDef::mi_law_support, NM_LAW_SUPPORT);
			this->add (GblPilotDef::mi_calendar, NM_CALENDAR);
			this->add (GblPilotDef::mi_business_references, NM_BUSINESS_REFERENCES);
			this->add (GblPilotDef::mi_hot_information, NM_HOT_INFORMATION);
			this->add (GblPilotDef::mi_codex, NM_CODEX);
			this->add (GblPilotDef::mi_forms, NM_FORMS);
			this->add (GblPilotDef::mi_monitorings, NM_MONITORINGS);
			this->add (GblPilotDef::mi_pharm_search, NM_PHARM_SEARCH);
			this->add (GblPilotDef::mi_inpharm, NM_INPHARM);
			this->add (GblPilotDef::mi_pharm_lek, NM_PHARM_LEK);
			this->add (GblPilotDef::mi_pharm_firms, NM_PHARM_FIRMS);
			this->add (GblPilotDef::mi_pharm_dict, NM_PHARM_DICT);
			this->add (GblPilotDef::mi_pharm_basic_section, NM_PHARM_BASIC_SECTION);
			this->add (GblPilotDef::mi_basic_section_child, NM_LIST);
			this->add (GblPilotDef::mi_taxes_and_finance, NM_TAXES_AND_FINANCE);
			this->add (GblPilotDef::mi_business_references_folder, NM_BUSINESS_REFERENCES_FOLDER);

			this->add (GblPilotDef::mi_legal_issues, NM_LEGAL_ISSUES);
			this->add (GblPilotDef::mi_hr, NM_HR);
			this->add (GblPilotDef::mi_budget_orgs, NM_BUDGET_ORGS);
			this->add (GblPilotDef::mi_law_for_all, NM_LAW_FOR_ALL);
			//#UC END# *460BBE6D036B_FILL_ARRAY_IMPLEMENTATION*
		}
}; // class NodeTypeTranslator

typedef ACE_Singleton<NodeTypeTranslator, ACE_SYNCH_NULL_MUTEX> NodeTypeTranslatorSingleton;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONVERTORS_NODETYPETRANSLATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

