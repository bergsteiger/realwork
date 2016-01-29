////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Relevancy_i::AlgorithmIdentical_i
// ��������� ���������� ������ �������� ��� ��������� IAlgorithm
//
// ���������� �������� ������� ������������� ��� ������� ���������� �� ���������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/RelevancyCore/RelevancyCore.h"

namespace ContextSearch {
namespace Relevancy_i {

class AlgorithmIdentical_i; // self forward Var
typedef ::Core::Var<AlgorithmIdentical_i> AlgorithmIdentical_i_var;
typedef ::Core::Var<const AlgorithmIdentical_i> AlgorithmIdentical_i_cvar;

class AlgorithmIdentical_i_factory;

// ���������� �������� ������� ������������� ��� ������� ���������� �� ���������� ����
class AlgorithmIdentical_i:
	virtual public Relevancy::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
	, virtual public RelevancyCore
{
	SET_OBJECT_COUNTER (AlgorithmIdentical_i)
	friend class AlgorithmIdentical_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AlgorithmIdentical_i (const Relevancy::Data& req_data, const Relevancy::AlgorithmProperties& properties);

	virtual ~AlgorithmIdentical_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������� ���������� �������
	virtual void get (
		Defs::RelevancyInfo& out
		, const Relevancy::Positions& data
		, const Defs::InvisibleData& inv
		, const Defs::PositionsRel& rel
	);


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Relevancy::IAlgorithm
	// �������� ��������
	virtual void clear_property (unsigned long value);

	// implemented method from Relevancy::IAlgorithm
	// �������� ������ ����������� ���������� ����������� � �������� ���������� ������
	virtual Relevancy::Fragments* get_block_fragments (
		const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
	);

	// implemented method from Relevancy::IAlgorithm
	// �������� ������ ����������� ����������
	virtual Relevancy::Fragments* get_fragments (const Relevancy::DataVector& positions);

	// implemented method from Relevancy::IAlgorithm
	// ������ ������������� ��� ���������� ��������
	virtual void get_inv_block_relevancy (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	);

	// implemented method from Relevancy::IAlgorithm
	// ������ �������������
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const Relevancy::DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	);

	// implemented method from Relevancy::IAlgorithm
	// ���������� ��������
	virtual void set_property (unsigned long value);
}; // class AlgorithmIdentical_i

} // namespace Relevancy_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_I_ALGORITHMIDENTICAL_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
