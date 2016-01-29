////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/Analyzer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::Analyzer
//
// ���������� ������������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {

// ���������� ������������ �������
class Analyzer {
	SET_OBJECT_COUNTER (Analyzer)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� �� ������������ ���� � �������
	static bool is_identical (const Search::PhraseEx& request);

private:
	// �������� �����
	static void get_value (const std::string& in, std::string& out);

}; // class Analyzer

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_ANALYZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

