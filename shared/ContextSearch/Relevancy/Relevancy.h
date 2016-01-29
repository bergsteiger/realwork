////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Relevancy/Relevancy.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Relevancy
//
// ���������� � ���� ��� ��������� ���������� �������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_RELEVANCY_H__
#define __SHARED_CONTEXTSEARCH_RELEVANCY_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Defs/Defs.h"

namespace ContextSearch {
namespace Relevancy {

// ������ ������� ���� � ���������
typedef Defs::Positions Positions;

// ������ ����������
typedef Defs::Fragments Fragments;

#pragma pack (push, 1)

// ��������� ��� ���������
struct AlgorithmProperties {
	// ������������ ������ ��������� ��� ���������� ���������
	size_t max_fragment;
	// ���������� ����
	size_t count;
	// �������� ���-�� ����
	size_t rcount;
	// ������� ��������� ���������� � �������������
	Defs::IRelevancyInfo* info;
	// ������� ����������
	Positions identical;
	//#UC START# *49DF39F400C1*
	AlgorithmProperties () : count (0), rcount (0), max_fragment (0), info (0) {
	}

	AlgorithmProperties (const AlgorithmProperties& copy) {
		max_fragment = copy.max_fragment;
		identical = copy.identical;
		rcount = copy.rcount;
		count = copy.count;
		info = copy.info;
	}
	//#UC END# *49DF39F400C1*
};

#pragma pack (pop)

// �����
static const unsigned long SHOW_INFO = 0x00000010; // ���������� ���������� ����������

// �������� ��� �������
enum AlgorithmSelector {
	as_Default // �������� �� ���������
	, as_Identical // �������� ��� �������� �� ���������� ����
	, as_Single // �������� ��� �������� �� ������ �����
	, as_Strong // �������� ��� ��������� ������� ��������
	, as_Simple // �������� ��� ������� ��������
};

#pragma pack (push, 1)

// ������ � �������� ��������������
struct Frame {
	// ������� ������� �����
	size_t pos;
	// ���������� ���� � �������� ��������������
	size_t count;
	//#UC START# *4C9B4F9D036B*
	bool operator == (const Frame& val) const {
		return (pos == val.pos && count == val.count);
	}
	//#UC END# *4C9B4F9D036B*
};

#pragma pack (pop)

// �������� ��������� �� �����
typedef std::vector < Frame > Frames;

#pragma pack (push, 1)

// ������� ������ ��� ���������
struct Data {
	// ���������� �������
	Positions strongs;
	// ������ ��������� �������� ���������� �����
	Frames frames;
	//#UC START# *4C9B4EBB004C*
	Data& operator = (const Data& copy) {
		strongs = copy.strongs;
		frames = copy.frames;
		return *this;
	}
	bool operator == (const Data& val) const {
		return (strongs == val.strongs && frames == val.frames);
	}
	//#UC END# *4C9B4EBB004C*
};

#pragma pack (pop)

// ������ ���� ������� ���� �������
typedef std::vector < Positions > DataVector;

class IAlgorithm;
typedef ::Core::Var<IAlgorithm> IAlgorithm_var;
typedef ::Core::Var<const IAlgorithm> IAlgorithm_cvar;
// ��������� ��������� ������� ������������� ���������
class IAlgorithm
	: virtual public ::Core::IObject
{
public:
	// ������ �������������
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
		, bool has_block
	) = 0;

	// �������� ������ ����������� ����������
	virtual Fragments* get_fragments (const DataVector& positions) = 0;

	// ���������� ��������
	virtual void set_property (unsigned long value) = 0;

	// �������� ��������
	virtual void clear_property (unsigned long value) = 0;

	// �������� ������ ����������� ���������� ����������� � �������� ���������� ������
	virtual Fragments* get_block_fragments (const DataVector& positions, const Defs::InvisibleData& inv_data) = 0;

	// ������ ������������� ��� ���������� ��������
	virtual void get_inv_block_relevancy (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	) = 0;
};

/// factory interface for IAlgorithm
class IAlgorithmFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// �������
	static IAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties, AlgorithmSelector key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������� ��� ����� ��������� ���������� � �������������
typedef Defs::IRelevancyInfo IRelevancyInfo;
typedef Defs::IRelevancyInfo_var IRelevancyInfo_var;
typedef Defs::IRelevancyInfo_cvar IRelevancyInfo_cvar;

// ���������
static const unsigned short BASE_FACTOR = 10; // �������� �����������
static const unsigned short Z_FACTOR = 12; // ��������� ��� ���������� ��������� Z
static const unsigned short EXT_LEN = 20; // ���������� ��� ������� ����

// IndexChain
typedef std::vector < Defs::Positions::const_iterator > IndexChain;

class IBlockAlgorithm;
typedef ::Core::Var<IBlockAlgorithm> IBlockAlgorithm_var;
typedef ::Core::Var<const IBlockAlgorithm> IBlockAlgorithm_cvar;
// ��������� ��������� ������� ������������� ��������� (��� ������� ���������)
class IBlockAlgorithm
	: virtual public ::Core::IObject
{
public:
	// ������ �������������
	virtual void get_relevancy_info (
		Defs::RelevancyInfo& info
		, const DataVector& positions
		, const Defs::InvisibleData& inv_data
		, const Defs::PositionsRel& rel_data
	) = 0;

	// ������ ����������� ����������
	virtual Defs::Fragments* get_fragments (const DataVector& positions, const Defs::InvisibleData& inv_data) = 0;
};

/// factory interface for IBlockAlgorithm
class IBlockAlgorithmFactory {
public:
	// �������
	static IBlockAlgorithm* make (const Data& req_data, const AlgorithmProperties& properties)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ��������� ��� �������� ����������� ������� �������
struct IntersectProp {
	// ������� � ������� �� ���������
	bool is_identical;
	// ������� � ������� ������ �����������
	bool is_first;
	// ������� ��������� � ���������� �������� ������
	bool is_block_chain;
	// ����������/�������� �������
	bool is_strong;
	IntersectProp () : is_block_chain(false) {
		//#UC START# *4A1FCD6900C3_DEF_INIT_CTOR*
			//#UC END# *4A1FCD6900C3_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// ��������  � ��� �������������
typedef Defs::RelevancyDocInfo RelevancyDocInfo;

} // namespace Relevancy
} // namespace ContextSearch

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContextSearch::Relevancy::IAlgorithm> {
	typedef ContextSearch::Relevancy::IAlgorithmFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Relevancy::IBlockAlgorithm> {
	typedef ContextSearch::Relevancy::IBlockAlgorithmFactory Factory;
};
} // namespace Core


#endif //__SHARED_CONTEXTSEARCH_RELEVANCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
