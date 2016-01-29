////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Defs/Defs.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Defs
//
// ����� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_DEFS_H__
#define __SHARED_CONTEXTSEARCH_DEFS_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <vector>
#include "shared/GCL/data/std_defs.h"

namespace ContextSearch {
namespace Defs {

// ���
enum TuneDocType {
	dt_CODE // ��������� c ��������� CODE
	, dt_TYPE // ��������� c ������������ �����
	, dt_INFORM // ���������
	, dt_RCH // rel_change
};

#pragma pack (push, 1)

// ������ ������� �� ���������� ��������� ������������ � �����
struct InvisibleBlockPosition {
	// ����� �����
	size_t length;
	// ���� �������������
	unsigned long relevancy;
};

#pragma pack (pop)

// ������ ������� �� ���������� ��������� ������������ � �����
typedef std::map < unsigned long, InvisibleBlockPosition > InvisibleData;

// ����� ������ ����������� � �������� �� ���������� ������
typedef std::map < unsigned long, InvisibleData > InvisibleBlocks;

#pragma pack (push, 1)

// ����������� �������
struct RelPos {
	// �������
	unsigned long pos;
	// �������������
	unsigned char rel;
	//#UC START# *53D6435E011F*
	bool operator < (const RelPos& val) const {
		return pos < val.pos;
	}
	//#UC END# *53D6435E011F*
};

#pragma pack (pop)

// ������������� ������� �� �������� ���������� ������
typedef std::vector < RelPos > PositionsRel;

// ��� ��� ������� (�����: ���� ������ + �������) ����� � ���������
typedef unsigned long Position;

// ������ ������� ���� � ���������
typedef std::vector < Position > Positions;

// ��� ��� ������������� ���������
typedef unsigned long RelevancyType;

#pragma pack (push, 1)

// ��������� ��� ������ ������������� ���������
struct RelevancyInfo {
	// �������� �������������
	RelevancyType relevancy_value;
	// ������� ������� ����� � ��������� ����������� �������
	Position position;
	RelevancyInfo () : relevancy_value(0), position(0) {
		//#UC START# *451BC43E0167_DEF_INIT_CTOR*
		//#UC END# *451BC43E0167_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *451BC43E0167*
	inline RelevancyInfo& operator = (const RelevancyInfo& copy) {
		relevancy_value = copy.relevancy_value;
		position = copy.position;
		return *this;
	}
	inline bool operator != (RelevancyType val) const {
		return relevancy_value != val;
	}
	inline bool operator == (RelevancyType val) const {
		return relevancy_value == val;
	}
	//#UC END# *451BC43E0167*
};

#pragma pack (pop)

// ��� ��� �������������� ���������
typedef unsigned long DocId;

#pragma pack (push, 1)

// ��������  � ��� �������������
struct RelevancyDocInfo {
	// ������������� ���������
	DocId doc_id;
	// ���� � ������������� ���������
	RelevancyInfo info;
	RelevancyDocInfo () : doc_id(0) {
		//#UC START# *4516957E037A_DEF_INIT_CTOR*
		//#UC END# *4516957E037A_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4516957E037A*
	inline bool operator < (const RelevancyDocInfo& val) const {
		return doc_id < val.doc_id;
	}

	inline bool operator == (const RelevancyDocInfo& val) const {
		return doc_id == val.doc_id;
	}
	//#UC END# *4516957E037A*
};

#pragma pack (pop)

// ��������� ��� ��������� (��������������� �������) ����������
typedef std::vector < RelevancyDocInfo > RelevancyDocuments;

#pragma pack (push, 1)

// �������� (����������� ����� ������� ���� � �������� ������)
struct Fragment {
	// ���� � ������������� ���������
	RelevancyInfo info;
	// ������� ���� ��������� ����� (� ������� ��������� �������)
	Positions data;
	//#UC START# *451683A0032C*
	Fragment (RelevancyType relevancy = 0, Position pos = 0) {
		info.position = pos;
		info.relevancy_value = relevancy;
	}
	inline bool operator < (RelevancyType val) const {
		return info.relevancy_value < val;
	}
	inline bool operator > (const Fragment& val) const {
		return info.relevancy_value > val.info.relevancy_value;
	}
	inline bool operator >= (const Fragment& val) const {
		return info.relevancy_value >= val.info.relevancy_value;
	}
	//#UC END# *451683A0032C*
};

#pragma pack (pop)

// ������ ����������
typedef std::vector < Fragment > Fragments;

#pragma pack (push, 1)

// ��������� �������� �� �������� ������������� ���������
struct RelevancyParam {
	// �����������, ���� � ��������� ������� ���������� ������� ����
	RelevancyType X;
	// �����������, ���� ��������� ������� ����������� ���������
	RelevancyType Y;
	// ����������� ���� ����� �� ������� ����������� � ��������� �� ������
	RelevancyType Z;
	// ����� �� ��������� �����
	RelevancyType I;
	RelevancyParam () : X(0), Y(0), Z(0), I(0) {
		//#UC START# *474ECA0D00EA_DEF_INIT_CTOR*
		//#UC END# *474ECA0D00EA_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *474ECA0D00EA*
	RelevancyParam& operator = (const RelevancyParam& copy) {
		X = copy.X;
		Y = copy.Y;
		Z = copy.Z;
		I = copy.I;
		return *this;
	}
	//#UC END# *474ECA0D00EA*
};

#pragma pack (pop)

// ���������� � ������������� ����������
typedef std::vector < RelevancyInfo > RelDetail;

// ��������� ���������� � ������� ���������� ��� ���� ����������
typedef std::vector < RelevancyParam > ParamDetail;

#pragma pack (push, 1)

// ��������� ���������� � �������������
struct Detail {
	// �������� �� CODE
	short code_factor;
	// ������������� ���������
	unsigned long doc_id;
	// ��������� ������
	std::string req;
	// �������� �� TYPE
	short type_factor;
	// �������� �� ���������
	short inform_factor;
	// rel_change
	short rch_factor;
	// ���� � �������������
	RelevancyInfo info;
	// ������ ������������ �������� ��� ���� ����������
	GCL::StrVector reqs;
	// ������� ���������
	RelevancyParam param;
	// ���� � ������� ���������� ��� ���� ����������
	ParamDetail params;
	// ���� � ������������� ����������
	RelDetail rel_detail;
	Detail () : code_factor(0), doc_id(0), type_factor(0), inform_factor(0), rch_factor(0) {
		//#UC START# *4C18E86F0371_DEF_INIT_CTOR*
		//#UC END# *4C18E86F0371_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4C18E86F0371*
	inline bool operator < (const Detail& val) const {
		return doc_id < val.doc_id;
	}
	inline bool operator == (const Detail& val) const {
		return doc_id == val.doc_id;
	}
	//#UC END# *4C18E86F0371*
};

#pragma pack (pop)

// ��������� ���������� � �������������
typedef std::vector < Detail > DetailInfo;

class IRelevancyInfo;
typedef ::Core::Var<IRelevancyInfo> IRelevancyInfo_var;
typedef ::Core::Var<const IRelevancyInfo> IRelevancyInfo_cvar;
// ��������� ��� ����� ��������� ���������� � �������������
class IRelevancyInfo
	: virtual public ::Core::IObject
{
public:
	// �������� ������
	virtual void add (const std::string& req) = 0;

	// �������� �������� � ��� �������������
	virtual void add (unsigned long doc_id, const RelevancyInfo& info) = 0;

	// �������� ������� ��������� � ������� �������������
	virtual void add (const RelevancyParam& param, unsigned long pos) = 0;

	// �������� �������� ������������� ��� ������������� ����
	virtual void add (unsigned long doc_id, TuneDocType type, short value) = 0;

	// �������� ���
	virtual void clear () = 0;

	// �������� ���������� � �������������
	virtual const DetailInfo& get_info () = 0;
};

class IFilter;
typedef ::Core::Var<IFilter> IFilter_var;
typedef ::Core::Var<const IFilter> IFilter_cvar;
// ������
class IFilter
	: virtual public ::Core::IObject
{
public:
	// check
	virtual bool check (DocId val) = 0;

	// check
	virtual bool check () const = 0;

	// ������� ��������
	virtual IFilter* duplicate () = 0;

	// logic op
	virtual char get_op () const = 0;

	// size
	virtual size_t get_size () const = 0;

	// reset
	virtual void reset () = 0;

	// type
	virtual const char* type () const = 0;
};

#pragma pack (push, 1)

// ��������� �������
struct Request {
	// ��������
	std::string context;
	// ����� � ������
	bool btext;
	// ���������� ��������
	char op;
	Request () : btext(true), op('&') {
		//#UC START# *4ECFAF56035C_DEF_INIT_CTOR*
		//#UC END# *4ECFAF56035C_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *4ECFAF56035C*
	Request (const std::string& _context, bool _btext = true) 
		: context (_context)
		, btext (_btext) 
		, op ('&') {
	}
	//#UC END# *4ECFAF56035C*
};

#pragma pack (pop)

// ������ ����������� ��������
typedef std::vector < Request > Requests;

#pragma pack (push, 1)

// ��������� ��������� ������
struct SearchInfo {
	// ������� ���������� � �������������
	IRelevancyInfo* info_collector;
	// ������
	IFilter* filter;
	//#UC START# *4ECF74B2002B*
	SearchInfo ()
		: info_collector (0) 
		, filter (0) {
	}

	SearchInfo (IRelevancyInfo* _collector, IFilter* _filter)
		: info_collector (_collector) 
		, filter (_filter) {
	}
	//#UC END# *4ECF74B2002B*
};

#pragma pack (pop)

class IResCollector;
typedef ::Core::Var<IResCollector> IResCollector_var;
typedef ::Core::Var<const IResCollector> IResCollector_cvar;
// ��������� ��� ���������� ������
class IResCollector
	: virtual public ::Core::IObject
{
public:
	// add
	virtual void add (DocId id, const RelevancyInfo& info) = 0;

	// empty
	virtual bool empty () const = 0;

	// finish
	virtual void finish (const std::string& req) = 0;

	// filter
	virtual IFilter* get_filter (char op) = 0;

	// start
	virtual void start (const std::string& req) = 0;
};

// ������������� ������� �� �������� ���������� ������ ���������
typedef std::map < unsigned long, PositionsRel > InvisibleRel;

// StrStrMap
typedef std::map < std::string, std::string > StrStrMap;

// ���������� ��������
static const char so_AND = '&'; // AND
static const char so_OR = '|'; // OR
static const char so_NOT = '~'; // NOT

} // namespace Defs
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_DEFS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
