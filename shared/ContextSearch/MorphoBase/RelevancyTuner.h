////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/RelevancyTuner.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::RelevancyTuner
//
// ����� ��� ��������� �������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// ����� ��� ��������� �������� �������������
class RelevancyTuner {
	SET_OBJECT_COUNTER (RelevancyTuner)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ������� ����������� ����������
	static void execute (Search::RelevancyDocuments& result, const DBCore::RelTuneData& data);

}; // class RelevancyTuner

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_RELEVANCYTUNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

