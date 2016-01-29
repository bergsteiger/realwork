////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/RelevancyCore/RelevancyUtility.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::ContextSearch::RelevancyCore::RelevancyUtility
//
// ��������� ����� ��������������� (��� ��������� ���������� �������������) �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace RelevancyUtility {

// �������� ��������� ������������� ���������
struct RelevancyCompare : public std::unary_function<Defs::Fragment, bool> {
	bool operator () (const Defs::Fragment& param_) const;

	RelevancyCompare (Defs::RelevancyType value_);

private:
	Defs::RelevancyType value;
};

// ������� ��������� ������� �������
struct ReceivePosition : public std::unary_function<Defs::Position, void> {
	void operator () (Defs::Position& param_) const;

	ReceivePosition (bool value_);

private:
	bool value;
};

// �������� ��������� �������������
struct RelevancyProperties {
	// �������� ��������������� ���� � �������
	bool is_direct;
	// ����������� ������� � �������
	Defs::Position min;
	// ������������ ������� � �������
	Defs::Position max;
	// ����� �� ��������� �����
	Defs::RelevancyType inv_factor;
	// ������� ������ �������
	unsigned short marked;
	RelevancyProperties () : is_direct(true), inv_factor(0), marked(0) {
		//#UC START# *4A6593FD02B2_DEF_INIT_CTOR*
		//#UC END# *4A6593FD02B2_DEF_INIT_CTOR**cpp*
	}
};

// ���������� ��� ��������� �������
struct CompareChains : public std::binary_function<Relevancy::Positions, Relevancy::Positions, bool> {
	bool operator () (const Relevancy::Positions& first_param_, const Relevancy::Positions& second_param_) const;

	CompareChains (size_t value_);

private:
	size_t value;
};

// ������� ��� ������ ������� ��������� �������
struct HasInvisibleBlock : public std::unary_function<Defs::Position, bool> {
	bool operator () (Defs::Position param_) const;
};

// ������� ��� ������ ���������� �������
struct HasBadChain : public std::unary_function<Relevancy::Positions, bool> {
	bool operator () (const Relevancy::Positions& param_) const;
};

// ��������� �����
bool compare_mask_less (unsigned long x, unsigned long y);

// ��������� ������ ������� � �������
Defs::Position get_position (const Relevancy::Positions& vect);

// ��������� �������� � ���������
bool compare_chain_less (const Relevancy::Positions& x, const Relevancy::Positions& y);


} // namespace RelevancyUtility
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCYCORE_RELEVANCYUTILITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
