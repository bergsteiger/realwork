////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/Logger.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Logger
//
// �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

namespace ContextSearch {

// �����
class Logger {
	SET_OBJECT_COUNTER (Logger)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// out
	static void out (const Search::RequestEx& req, Relevancy::IRelevancyInfo* info_collector);

	// out
	static void out (const Search::SplitRequest& req);

private:
	// �������� ��������
	static void add (const Search::StringSet& in, std::string& out);

}; // class Logger

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_LOGGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

