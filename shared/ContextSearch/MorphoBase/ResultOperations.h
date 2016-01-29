////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/ResultOperations.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::MorphoBase::ResultOperations
//
// �������� � ��������� ����������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"

namespace ContextSearch {

// �������� � ��������� ����������� ����������
class ResultOperations {
	SET_OBJECT_COUNTER (ResultOperations)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ���� ����������� � ������������ �������
	static Search::RelevancyDocuments* intersection (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

	// ����� ���� ����������� � ������������ �������
	static Search::RelevancyDocuments* merge (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

	// ����������� ���� ����������� � ������������ �������
	static Search::RelevancyDocuments* union_ (const Search::RelevancyDocuments& x, const Search::RelevancyDocuments& y);

}; // class ResultOperations

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_RESULTOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

