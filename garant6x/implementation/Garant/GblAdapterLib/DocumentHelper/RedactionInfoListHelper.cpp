////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/RedactionInfoListHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x::GblAdapterLib::DocumentHelper::RedactionInfoListHelper
// Файл реализации утилитного набора RedactionInfoListHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/RedactionInfoListHelper.h"

namespace GblAdapterLib {
namespace RedactionInfoListHelper {

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

bool NoActivityInterval::operator () (const RedactionInfo& param_) const {
	//#UC START# *4B557A4302EB_IMPL*
	return 
		param_.active_intervals.empty ()
		|| param_.active_intervals [0].start == Date () && param_.active_intervals [0].finish == Date ()
 		? true 
		: false
	;
	//#UC END# *4B557A4302EB_IMPL*
}

void cur_and_next_redactions (
	const RedactionInfoList& redaction_info_list
	, RedactionID id
	, RedactionInfoList& next_list
) {
	//#UC START# *4B556E69014E*
	GDS_ASSERT (next_list.empty ());

	int index = find_redaction (redaction_info_list, id);
	if (index == -1) {
		return;
	}

	RedactionInfoList::const_iterator begin = redaction_info_list.begin ();
	RedactionInfoList::const_iterator end   = redaction_info_list.begin () + index + 1;
	next_list.resize (std::distance(begin, end));
	std::copy (begin, end, next_list.begin ());
	//#UC END# *4B556E69014E*
}

int find_actual_redaction (const RedactionInfoList& redaction_info_list) {
	//#UC START# *4628969F03E4*
	for (long i = 0, size = redaction_info_list.size (); i < size; ++i) {
		RedactionType actual_type = redaction_info_list[i].actual_type;
		if (actual_type == RT_ACTUAL || actual_type == RT_ACTUAL_ABOLISHED	|| actual_type == RT_ACTUAL_PREACTIVE) {
			return i;
		}
	}
	return -1;
	//#UC END# *4628969F03E4*
}

int find_redaction (const RedactionInfoList& redaction_info_list, RedactionID to_find) {
	//#UC START# *462896090184*
	for (long i = 0, size = redaction_info_list.size (); i < size; ++i) {
		if (redaction_info_list[i].id == to_find) {
			return i;
		}
	}

	return -1;
	//#UC END# *462896090184*
}

int find_redaction (const RedactionInfoList& redaction_info_list, const RedactionInfo& to_find) {
	//#UC START# *46289660023F*
	return find_redaction (redaction_info_list, to_find.id);
	//#UC END# *46289660023F*
}

void prev_redactions (const RedactionInfoList& redaction_info_list, RedactionID id, RedactionInfoList& prev_list) {
	//#UC START# *4A8145520247*
	GDS_ASSERT (prev_list.empty ());

	int index = find_redaction (redaction_info_list, id);
	if (index == -1) {
		return;
	}

	RedactionInfoList::const_iterator begin = redaction_info_list.begin () + index + 1;
	RedactionInfoList::const_iterator end   = redaction_info_list.end ();
	prev_list.resize (std::distance(begin, end));
	std::copy (begin, end, prev_list.begin ());
	//#UC END# *4A8145520247*
}

} // namespace RedactionInfoListHelper
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

