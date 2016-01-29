////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Convertors/TreeNameTranslator.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::Convertors::TreeNameTranslator
// Файл реализации утилитного набора TreeNameTranslator
//
// Конвертертер имен деревьев
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/TreeNameTranslator.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

AttributeTag_const shell_to_adapter (const char* shell_name) {
	//#UC START# *475012FB000C*
	if (!strcmp (shell_name, "MainMenu")) return "AT_CLASS6";
	if (!strcmp (shell_name, "AT_CLASS6")) return "AT_CLASS6";
	if (!strcmp (shell_name, "ExplanatoryDiction")) return "AT_DICTIONARY";
	if (!strcmp (shell_name, "AT_DICTIONARY")) return "AT_DICTIONARY";
	if (!strcmp (shell_name, "CRTree")) return "AT_PREFIX_CR_COMBO";
	if (!strcmp (shell_name, "AT_PREFIX_CR_COMBO")) return "AT_PREFIX_CR_COMBO";
	// ----------------------------------------------------------------------------
	if (!strcmp (shell_name, "AT_KW")) return "AT_KW";
	if (!strcmp (shell_name, "AT_TYPE")) return "AT_TYPE";
	if (!strcmp (shell_name, "AT_SOURCE")) return "AT_SOURCE";
	if (!strcmp (shell_name, "AT_CLASS")) return "AT_CLASS";
	if (!strcmp (shell_name, "AT_SOURCE_REVIEW")) return "AT_SOURCE_REVIEW";
	if (!strcmp (shell_name, "AT_CLASS_REVIEW")) return "AT_CLASS_REVIEW";
	if (!strcmp (shell_name, "AT_REG_NUM")) return "AT_REG_NUM";
	if (!strcmp (shell_name, "AT_REG_IN_MU_NUM")) return "AT_REG_IN_MU_NUM";
	if (!strcmp (shell_name, "AT_STATUS")) return "AT_STATUS";
	if (!strcmp (shell_name, "AT_NORM")) return "AT_NORM";
	if (!strcmp (shell_name, "AT_REG_IN_MU")) return "AT_REG_IN_MU";
	if (!strcmp (shell_name, "AT_BASES")) return "AT_BASES";
	if (!strcmp (shell_name, "AT_PREFIX")) return "AT_PREFIX";
	if (!strcmp (shell_name, "AT_PREFIX_REVIEW")) return "AT_PREFIX_REVIEW";
	if (!strcmp (shell_name, "AT_TERRITORY")) return "AT_TERRITORY";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE")) return "AT_PUBLISH_SOURCE";
	if (!strcmp (shell_name, "AT_EDITION")) return "AT_EDITION";
	if (!strcmp (shell_name, "AT_UC")) return "AT_UC";		
	if (!strcmp (shell_name, "AT_ANNO_KIND")) return "AT_ANNO_KIND";
	if (!strcmp (shell_name, "AT_ANNO_USER")) return "AT_ANNO_USER";
	if (!strcmp (shell_name, "AT_ANNO_ORG")) return "AT_ANNO_ORG";
	if (!strcmp (shell_name, "AT_ANNO_INTEREST")) return "AT_ANNO_INTEREST";
	if (!strcmp (shell_name, "AT_ANNO_TAX")) return "AT_ANNO_TAX";
	// ----------------------------------------------------------------------------
	if (!strcmp (shell_name, AT_TEXT_BODY)) return "AT_TEXT_BODY";
	if (!strcmp (shell_name, AT_TEXT_NAME)) return "AT_TEXT_NAME";
	if (!strcmp (shell_name, "AT_NEWS_LINE")) return "AT_NEWS_LINE";
	if (!strcmp (shell_name, "AT_COMPLECT_INFO")) return "AT_COMPLECT_INFO";

	// Типы в КЗ ПП
	if (!strcmp (shell_name, AT_LAW_SUPPORT_TEXT)) return "AT_LAW_SUPPORT_TEXT";
	if (!strcmp (shell_name, AT_USER_NAME)) return "AT_USER_NAME";
	if (!strcmp (shell_name, AT_USER_PHONE)) return "AT_USER_PHONE";
	if (!strcmp (shell_name, AT_EMAIL)) return "AT_EMAIL";

	// Даты в КЗ ППР
	if (!strcmp (shell_name, "AT_PUBLISHING_DATE")) return "AT_PUBLISHING_DATE";
	if (!strcmp (shell_name, "AT_REG_DATE")) return "AT_REG_DATE";
	if (!strcmp (shell_name, "AT_EFFECTIVE_DATE")) return "AT_EFFECTIVE_DATE";

	// КЗ мониторинги
	if (!strcmp (shell_name, "AT_CLIENT_NAME")) return "AT_CLIENT_NAME";
	if (!strcmp (shell_name, "AT_CLIENT_REG_NUM")) return "AT_CLIENT_REG_NUM";
	if (!strcmp (shell_name, "AT_DEALER_NAME")) return "AT_DEALER_NAME";
	if (!strcmp (shell_name, "AT_COMPLECT_NAME")) return "AT_COMPLECT_NAME";
	if (!strcmp (shell_name, "AT_COMPLECT_VER")) return "AT_COMPLECT_VER";
	if (!strcmp (shell_name, AT_THEMES_NAME)) return "AT_THEMES_NAME";
	if (!strcmp (shell_name, "AT_NEWS_LINE")) return "AT_NEWS_LINE";

	if (!strcmp (shell_name, "MedExplanatoryDiction")) return "AT_MEDICAL_DICTIONARY";
	// Инфарм
	if (!strcmp (shell_name, AT_PHARM_NAME)) return "AT_PHARM_NAME";
	if (!strcmp (shell_name, AT_PHARM_TEXT)) return "AT_PHARM_TEXT";
	if (!strcmp (shell_name, "AT_PHARM_INTERNATIONAL_NAME")) return "AT_PHARM_INTERNATIONAL_NAME";
	if (!strcmp (shell_name, "AT_PHARM_TRADE_NAME")) return "AT_PHARM_TRADE_NAME";
	if (!strcmp (shell_name, "AT_PHARM_CHAPTER")) return "AT_PHARM_CHAPTER";
	if (!strcmp (shell_name, "AT_PHARM_COUNTRY")) return "AT_PHARM_COUNTRY";
	if (!strcmp (shell_name, "AT_PHARM_FIRM")) return "AT_PHARM_FIRM";
	if (!strcmp (shell_name, "AT_PHARM_REG_STATUS")) return "AT_PHARM_REG_STATUS";
	if (!strcmp (shell_name, "AT_PHARM_MEDICINAL_FORM")) return "AT_PHARM_MEDICINAL_FORM";

	if (!strcmp (shell_name, "AT_PHARM_ATC")) return "AT_PHARM_ATC";
	if (!strcmp (shell_name, "AT_PHARM_MKB")) return "AT_PHARM_MKB";
	if (!strcmp (shell_name, "AT_PHARM_GROUP")) return "AT_PHARM_GROUP";
	if (!strcmp (shell_name, "AT_PHARM_EFFECT")) return "AT_PHARM_EFFECT";

	if (!strcmp (shell_name, "AT_PHARM_REG_DATE")) return "AT_PHARM_REG_DATE";
	if (!strcmp (shell_name, "AT_PHARM_ANNULMENT_DATE")) return "AT_PHARM_ANNULMENT_DATE";

	if (!strcmp (shell_name, "AT_PHARM_UNRECIPE")) return "AT_PHARM_UNRECIPE";
	if (!strcmp (shell_name, "AT_PHARM_NARCOTIC")) return "AT_PHARM_NARCOTIC";
	if (!strcmp (shell_name, "AT_PHARM_IMPORTANT")) return "AT_PHARM_IMPORTANT";

	if (!strcmp (shell_name, "AT_PHARM_COUNTRY_FOR_FILTER")) return "AT_PHARM_COUNTRY_FOR_FILTER";

	if (!strcmp (shell_name, "AT_VARIANTS")) return "AT_VARIANTS";

	if (!strcmp (shell_name, AT_SHORT_LIST)) return "AT_SHORT_LIST";

	if (!strcmp (shell_name, "AT_LC_ALL_DATE")) return "AT_LC_ALL_DATE";
	if (!strcmp (shell_name, "AT_LC_IN_DATE")) return "AT_LC_IN_DATE";
	if (!strcmp (shell_name, "AT_LC_ABOLISHED_DATE")) return "AT_LC_ABOLISHED_DATE";
	if (!strcmp (shell_name, "AT_LC_CHANGED_DATE")) return "AT_LC_CHANGED_DATE";
	if (!strcmp (shell_name, "AT_LC_DESCRIPTION")) return "AT_LC_DESCRIPTION";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE_FINANCE")) return "AT_PUBLISH_SOURCE_FINANCE";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE_LEGAL")) return "AT_PUBLISH_SOURCE_LEGAL";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE_HR")) return "AT_PUBLISH_SOURCE_HR";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE_BUDGET_ORGS")) return "AT_PUBLISH_SOURCE_BUDGET_ORGS";
	if (!strcmp (shell_name, "AT_PUBLISH_SOURCE_PHARM")) return "AT_PUBLISH_SOURCE_PHARM";
	if (!strcmp (shell_name, AT_BASE_SEARCH_PANES)) return "AT_BASE_SEARCH_PANES";
	if (!strcmp (shell_name, AT_IMPORTANT_DOCUMENTS)) return "AT_IMPORTANT_DOCUMENTS";

	GDS_ASSERT (false);
	return ""; // not reachable
	//#UC END# *475012FB000C*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

