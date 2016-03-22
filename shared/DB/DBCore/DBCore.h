////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/DB/DBCore/DBCore.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::DB::DBCore
//
// ������� �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DB_DBCORE_H__
#define __SHARED_DB_DBCORE_H__

#include "shared/Core/sys/std_inc.h"
#include <deque>
#include <vector>

namespace DBCore {

class Store;
// Store
class Store
{
public:
	// length
	virtual int Length () const = 0;

	// read
	virtual int Read (void* buf, int count) = 0;

	// seek
	virtual int Seek (int pos) = 0;

	// tell
	virtual int Tell () const = 0;

	// trunk
	virtual int Trunc () = 0;

	// write
	virtual int Write (const void* buf, int count) = 0;
};

class Storable;
// Storable
class Storable
{
public:
	// reload contents of existing object from Store
	virtual int Get (Store* in) = 0;

	// save object to Store
	virtual int Put (Store* in) = 0;

	// tag for restoring object
	virtual short Tag () const = 0;
};

class IBTreeIterator;
typedef ::Core::Var<IBTreeIterator> IBTreeIterator_var;
typedef ::Core::Var<const IBTreeIterator> IBTreeIterator_cvar;
// BTreeIterator
class IBTreeIterator
	: virtual public ::Core::IObject
{
public:
	// sets to first item >= key
	virtual int Set (const void* key) = 0;

	// returns current item
	virtual const void* Key () const = 0;

	// whether iterator reached end of tree in either direction
	virtual int End () const = 0;

	// next
	virtual void next () = 0;

	// prev
	virtual void prev () = 0;
};

class IProgress;
typedef ::Core::Var<IProgress> IProgress_var;
typedef ::Core::Var<const IProgress> IProgress_cvar;
// ��������-���������
class IProgress
	: virtual public ::Core::IObject
{
public:
	// ��������, ���������� �� ������� �������������
	virtual bool canceled_by_user () = 0;

	// �������������
	virtual void init (size_t div, size_t pos) = 0;

	// �����
	virtual void pause (bool pause) = 0;

	// set
	virtual void plus () = 0;

	// ����������������
	virtual void set (size_t value) = 0;

	// ���������� ������������ ��������
	virtual void set_border (size_t value) = 0;
};

class IBuffer;
typedef ::Core::Var<IBuffer> IBuffer_var;
typedef ::Core::Var<const IBuffer> IBuffer_cvar;
// ������
class IBuffer
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const char* get () const = 0;
};

class IIndex;
typedef ::Core::Var<IIndex> IIndex_var;
typedef ::Core::Var<const IIndex> IIndex_cvar;
// ������
class IIndex
	: virtual public ::Core::IObject
{
public:
	// ������� �����
	virtual Store* open_stream (const void* key, unsigned short stream_no) = 0;

	// ������� �����
	virtual void close_stream (Store* store) = 0;

	// �������� �� ����������
	virtual bool is_valid () const = 0;

	// ������ ������
	virtual IBuffer* read (const void* key, unsigned short stream_no, size_t& len) = 0;

	// �������� ����� �� ����������
	virtual bool is_valid_key (const void* key) = 0;

	// ������� �����
	virtual Store* key_open (const void* key, int stream_no) = 0;

	// �������� �� btree
	virtual IBTreeIterator* make_iterator () = 0;

	// ���������� ������
	virtual size_t key_count () const = 0;
};

class IBase;
typedef ::Core::Var<IBase> IBase_var;
typedef ::Core::Var<const IBase> IBase_cvar;
// ����������� ����
class IBase
	: virtual public ::Core::IObject
{
public:
	// �������
	virtual IIndex* make (const char* name) = 0;
};

// ��� ��� �������������� ���������
typedef unsigned long DocId;

// ������ ����������������� ������� ����������
typedef std::vector < DocId > DocVector;

#pragma pack (push, 1)

// ������ �� ������� ���������
struct Ref_ {
	// ������������� ���������
	unsigned long doc_id;
	// ������� � ������ � �������
	unsigned long pos;
	// ����� ������ ������
	size_t length;
};

#pragma pack (pop)

// ��� ����������������� ������� ����������
typedef std::deque < DocId > DocDeque;

#pragma pack (push, 1)

// ������ ��� ��������� ����������� �������� ������������� � ������ ��������� ����������
struct DocListRelevancy {
	// �������� �������������
	int relevancy;
	// ������ ����������, ��� ������� ����� �������������� �������� �������������
	DocDeque docs;
	//#UC START# *4DD3BB00024E*
	inline bool operator > (const DocListRelevancy& val) const {
		return relevancy > val.relevancy;
	}
	//#UC END# *4DD3BB00024E*
};

#pragma pack (pop)

#pragma pack (push, 1)

// ���� ������� ��������
struct ExtrPair {
	// �������
	long min;
	// ��������
	long max;
	ExtrPair () : min(0), max(0) {
		//#UC START# *505744D1004E_DEF_INIT_CTOR*
		//#UC END# *505744D1004E_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// ��� ������ ��� ��������� ����������� �������� �������������
typedef std::vector < DocListRelevancy > RelevancyTuneData;

class IRefStream;
typedef ::Core::Var<IRefStream> IRefStream_var;
typedef ::Core::Var<const IRefStream> IRefStream_cvar;
// �����
class IRefStream
	: virtual public ::Core::IObject
{
public:
	// �����
	virtual unsigned long get_length () const = 0;

	// ��������� ��������� ������ ������
	virtual bool get_next (Ref_& ref, long border) = 0;

	// ������� �������
	virtual unsigned long get_tell () const = 0;

	// ����� ��������� ���������
	virtual bool search (Ref_& ref) = 0;
};

// ������ ���������� �����
typedef std::vector < unsigned long > ULongVector;

class IDataStream;
typedef ::Core::Var<IDataStream> IDataStream_var;
typedef ::Core::Var<const IDataStream> IDataStream_cvar;
// ����� �������
class IDataStream
	: virtual public ::Core::IObject
{
public:
	// �������� ������
	virtual void get (ULongVector& data, const Ref_& ref, const ExtrPair& extr) = 0;

	// ������� ������� �������
	virtual bool has_block () const = 0;
};

#pragma pack (push, 1)

// ������
struct StreamsPair {
	// �����
	IRefStream_var ref_stream;
	// �����
	IDataStream_var data_stream;
};

#pragma pack (pop)

class IStreamsFactory;
typedef ::Core::Var<IStreamsFactory> IStreamsFactory_var;
typedef ::Core::Var<const IStreamsFactory> IStreamsFactory_cvar;
// ������� �������
class IStreamsFactory
	: virtual public ::Core::IObject
{
public:
	// �������� �� ����������
	virtual bool is_valid () const = 0;

	// �������
	virtual StreamsPair* make (const std::string& key, unsigned long flags) = 0;
};

#pragma pack (push, 1)

// ������
struct Streams {
	// ���� ������� �����
	bool has_form;
	// ������ �����
	Store* first;
	// ������ �����
	Store* second;
	//#UC START# *4EBA9B800366*
	Streams () : first (0), second (0), has_form (false) {
	}
	//#UC END# *4EBA9B800366*
};

#pragma pack (pop)

// ��� ��������
enum LoadType {
	lt_All // ��
	, lt_Refs // ������
	, lt_Data // ������
};

class IBasePool;
typedef ::Core::Var<IBasePool> IBasePool_var;
typedef ::Core::Var<const IBasePool> IBasePool_cvar;
// ��� ���
class IBasePool
	: virtual public ::Core::IObject
{
public:
	// �������
	virtual IBase* get (size_t i) = 0;

	// ������
	virtual size_t size () const = 0;
};

#pragma pack (push, 1)

// �������� ����
struct MemCacheSettings {
	// ��� ������ ������
	bool for_list;
	// ����������� ������
	size_t max_size;
	// ���
	LoadType type;
	// ��� ���
	IBasePool_var pool;
	MemCacheSettings () : for_list(false), max_size(0), type(lt_All) {
		//#UC START# *52D526D70243_DEF_INIT_CTOR*
		//#UC END# *52D526D70243_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

// ������� ���������
typedef std::vector < ULongVector > ContextPositions;

class IPosContainer;
typedef ::Core::Var<IPosContainer> IPosContainer_var;
typedef ::Core::Var<const IPosContainer> IPosContainer_cvar;
// ��������� �������
class IPosContainer
	: virtual public ::Core::IObject
{
public:
	// ��������
	virtual bool add (unsigned long val) = 0;

	// ��������
	virtual bool add (unsigned long pos, unsigned long flags) = 0;

	// ������
	virtual const ContextPositions& get () const = 0;

	// ����� ������� �������
	virtual bool has_block () const = 0;

	// ������ �� ������� �������
	virtual const ULongVector& ref () const = 0;

	// ��������
	virtual void reset () = 0;

	// ���������� �� �������
	virtual void set (size_t pos) = 0;

	// ��������� �� ������ � ����������� ������� ���������
	virtual void set_min (const ULongVector& in) = 0;
};

// ������ ����
typedef std::vector < unsigned char > Bytes;

// ������� ������ ����� ������� ����
typedef std::vector < Bytes > PSDTemplates;

#pragma pack (push, 1)

// RelPair
struct RelPair {
	// �������������
	DocId id;
	// �������������
	short rel;
	//#UC START# *53834B850211*
	bool operator < (const RelPair& val) const {
		return id < val.id;
	}

	bool operator >= (long val) const {
		return id >= (DBCore::DocId) val;
	}

	bool operator == (const RelPair& val) const {
		return id == val.id;
	}
	//#UC END# *53834B850211*
};

#pragma pack (pop)

// RelTuneData
typedef std::vector < RelPair > RelTuneData;

// ���������
static const size_t MAX_WORDS_OF_REQUEST = 15; // ������������ ���������� ���� � ����������� �������

} // namespace DBCore


#endif //__SHARED_DB_DBCORE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
