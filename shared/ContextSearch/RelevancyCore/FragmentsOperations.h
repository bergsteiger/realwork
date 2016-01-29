////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/RelevancyCore/FragmentsOperations.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> shared::ContextSearch::RelevancyCore::FragmentsOperations
//
// �������� � �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {

// �������� � �����������
class FragmentsOperations {
	SET_OBJECT_COUNTER (FragmentsOperations)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// �������� ���������
	struct RangeValues {
		// ������ �������
		unsigned long _min;
		// ������� �������
		unsigned long _max;
	};

public:
	// ��������� ����������
	struct SortProperties {
		// ������� ����� � ���������
		unsigned long word;
		// ������� ������� ����� � ���������
		unsigned long first_word;

		SortProperties (unsigned long word_, unsigned long first_word_);
	};

private:
	// ������� ������� ��� ������ ��������� �� �������
	struct PositionFinder : public std::unary_function<Defs::Fragment, bool> {
		bool operator () (const Defs::Fragment& param_) const;

		PositionFinder (unsigned long value_);

private:
		unsigned long value;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������� �������������� ���������
	static void filtration (Relevancy::Fragments& vect);

	// ���������� ����������
	static void sort (Relevancy::Fragments& vect, const SortProperties& prop);

private:
	// ��������� ����������
	static bool compare_less (const Defs::Fragment& x, const Defs::Fragment& y);

	// ���������� ��������� �������� ���������
	static void get_range_values (const Defs::Fragment& in, RangeValues& out);

	// ������
	static void print (const Relevancy::Fragments& vect);

}; // class FragmentsOperations

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_FRAGMENTSOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

