////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/ContextSearch/RelevancyTuner.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::ContextSearch::RelevancyTuner
//
// ����� ��� ��������� �������� ������������� � ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__
#define __GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/refcol.h"

namespace Search {

// ����� ��� ��������� �������� ������������� � ������ ���������
class RelevancyTuner {
	SET_OBJECT_COUNTER (RelevancyTuner)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// ������ ����������
	typedef std::vector < unsigned long > DocVector;

	// ���������
	static const short CODE_FACTOR; // �� CODE
	static const short TYPE_FACTOR; // �� TYPE

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������� ��� ����
	static short get_value (SearchAdapterLib::Adapter::TuneDocType type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit RelevancyTuner (SearchAdapterLib::Adapter::IRelevancyInfo* collector);

public:
	virtual ~RelevancyTuner ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������
	virtual void execute (
		RefwReleCollection* result
		, const SearchAdapterLib::Adapter::RelTuneData& data
		, SearchAdapterLib::Adapter::TuneDocType type
	) const;

	// ���������
	void execute (RefwReleCollection* result, const DocVector& data, SearchAdapterLib::Adapter::TuneDocType type) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	SearchAdapterLib::Adapter::IRelevancyInfo* m_info_collector;
}; // class RelevancyTuner

} // namespace Search


#endif //__GARANTCORE_SEARCH_CONTEXTSEARCH_RELEVANCYTUNER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

