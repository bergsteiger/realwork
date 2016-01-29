////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/RedactionInfoListHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::RedactionInfoListHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_REDACTIONINFOLISTHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_REDACTIONINFOLISTHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

namespace GblAdapterLib {
namespace RedactionInfoListHelper {

struct NoActivityInterval : public std::unary_function<RedactionInfo, bool> {
	bool operator () (const RedactionInfo& param_) const;
};

int find_redaction (const RedactionInfoList& redaction_info_list, RedactionID to_find);

int find_redaction (const RedactionInfoList& redaction_info_list, const RedactionInfo& to_find);

int find_actual_redaction (const RedactionInfoList& redaction_info_list);

void prev_redactions (const RedactionInfoList& redaction_info_list, RedactionID id, RedactionInfoList& prev_list);

void cur_and_next_redactions (
		const RedactionInfoList& redaction_info_list
		, RedactionID id
		, RedactionInfoList& next_list
	);


} // namespace RedactionInfoListHelper
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENTHELPER_REDACTIONINFOLISTHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
