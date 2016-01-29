////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/Adapter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::SearchAdapterLib::Adapter
//
// ���������� � ���� ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_H__
#define __GARANTCORE_SEARCHADAPTERLIB_ADAPTER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"
//#UC START# *4EC2A3870166_CUSTOM_INCLUDE*
namespace SearchAdapterLib {
class CanceledByUser : public ::Core::Exception {
private:
	const char* uid () const /*throw ()*/ {
		return 0;
	}
};
}
//#UC END# *4EC2A3870166_CUSTOM_INCLUDE*

namespace SearchAdapterLib {
namespace Adapter {

class IDocuments;
typedef ::Core::Var<IDocuments> IDocuments_var;
typedef ::Core::Var<const IDocuments> IDocuments_cvar;
// ��������� IDocuments
class IDocuments
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const ContextSearch::Defs::RelevancyDocuments& data () const = 0;
};

class IFragments;
typedef ::Core::Var<IFragments> IFragments_var;
typedef ::Core::Var<const IFragments> IFragments_cvar;
// ��������� IFragments
class IFragments
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const ContextSearch::Defs::Fragments& data () const = 0;
};

class IPositions;
typedef ::Core::Var<IPositions> IPositions_var;
typedef ::Core::Var<const IPositions> IPositions_cvar;
// ��������� IPositions
class IPositions
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const ContextSearch::Defs::Positions& data () const = 0;
};

// ��������� ��� ���������� ������
typedef ContextSearch::Defs::IResCollector IResCollector;
typedef ContextSearch::Defs::IResCollector_var IResCollector_var;
typedef ContextSearch::Defs::IResCollector_cvar IResCollector_cvar;

class IStrings;
typedef ::Core::Var<IStrings> IStrings_var;
typedef ::Core::Var<const IStrings> IStrings_cvar;
// ��������� IWords
class IStrings
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const GCL::StrSet& data () const = 0;
};

class ISynRequest;
typedef ::Core::Var<ISynRequest> ISynRequest_var;
typedef ::Core::Var<const ISynRequest> ISynRequest_cvar;
// ������������ �������
class ISynRequest
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const GCL::StrVector& data (size_t i) const = 0;

	// ������
	virtual size_t size () const = 0;
};

// ������ ������
typedef std::vector < long > LongVector;

class ISearcher;
typedef ::Core::Var<ISearcher> ISearcher_var;
typedef ::Core::Var<const ISearcher> ISearcher_cvar;
// ��������� ����������
class ISearcher
	: virtual public ::Core::IObject
{
public:
	// �������� ������ ����������� ����������
	virtual IDocuments* get_documents (
		const ContextSearch::Defs::Requests& reqs
		, const ContextSearch::Defs::SearchInfo& info
	) = 0;

	// �������� ������� ���� ����������� ����������
	virtual IPositions* get_positions (const GCL::StrVector& reqs, DBCore::DocId id) = 0;

	// �������� ������ ����������� ����������
	virtual IFragments* get_fragments (
		const std::string& in
		, DBCore::DocId id
		, unsigned long word
		, unsigned long first_word
	) = 0;

	// �������� ������ ����������� ����������
	virtual IFragments* get_fragments (const std::string& in, DBCore::DocId id) = 0;

	// �����
	virtual void search (
		const ContextSearch::Defs::Requests& in
		, const ContextSearch::Defs::SearchInfo& info
		, DBCore::IProgress* progress
		, IResCollector* collector
	) = 0;
};

/// factory interface for ISearcher
class ISearcherFactory {
public:
	// �������
	static ISearcher* make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������� ����
typedef DBCore::MemCacheSettings MemCacheSettings;

// ������ �������������
typedef ContextSearch::Defs::IFilter IFilter;
typedef ContextSearch::Defs::IFilter_var IFilter_var;
typedef ContextSearch::Defs::IFilter_cvar IFilter_cvar;

class IHelper;
typedef ::Core::Var<IHelper> IHelper_var;
typedef ::Core::Var<const IHelper> IHelper_cvar;
// ��������������� ���������
class IHelper
	: virtual public ::Core::IObject
{
public:
	// ������������� ������ �������
	virtual IStrings* transform (const std::string& str) = 0;

	// ���������
	virtual ISynRequest* synonymy (const char* req) = 0;
};

/// factory interface for IHelper
class IHelperFactory {
public:
	// �������
	static IHelper* make (Morpho::Def::ICache* cache)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������-���������
typedef DBCore::IProgress IProgress;
typedef DBCore::IProgress_var IProgress_var;
typedef DBCore::IProgress_cvar IProgress_cvar;

// ��������� ��� ����� ��������� ���������� � �������������
typedef ContextSearch::Defs::IRelevancyInfo IRelevancyInfo;
typedef ContextSearch::Defs::IRelevancyInfo_var IRelevancyInfo_var;
typedef ContextSearch::Defs::IRelevancyInfo_cvar IRelevancyInfo_cvar;

// RelTuneData
typedef DBCore::RelTuneData RelTuneData;

// ���
typedef ContextSearch::Defs::TuneDocType TuneDocType;

class IAdapter;
typedef ::Core::Var<IAdapter> IAdapter_var;
typedef ::Core::Var<const IAdapter> IAdapter_cvar;
// ��������� ���������� ��������
class IAdapter
	: virtual public ::Core::IObject
{
public:
	// ��������� ����������
	virtual ISearcher* get (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) = 0;

	// ��������� �������
	virtual IHelper* get (DBCore::IBase* base, Morpho::Def::ICache* cache) = 0;

	// ������� ����� � ������ �����������
	virtual void fini () = 0;

	// ��������� memcache ���������� �������
	virtual void load_memcache (const DBCore::MemCacheSettings& settings) = 0;

	// ������ ��� ��������� ����������� �������� �������������
	virtual const DBCore::RelTuneData& get_tune_data () const = 0;

	// �������������
	virtual void init (DBCore::IBase* base) = 0;
};

/// factory interface for IAdapter
class IAdapterFactory {
public:
	// ���������� �������
	static IAdapter& instance ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Adapter
} // namespace SearchAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <SearchAdapterLib::Adapter::ISearcher> {
	typedef SearchAdapterLib::Adapter::ISearcherFactory Factory;
};
template <>
struct TypeTraits <SearchAdapterLib::Adapter::IHelper> {
	typedef SearchAdapterLib::Adapter::IHelperFactory Factory;
};
template <>
struct TypeTraits <SearchAdapterLib::Adapter::IAdapter> {
	typedef SearchAdapterLib::Adapter::IAdapterFactory Factory;
};
} // namespace Core


#endif //__GARANTCORE_SEARCHADAPTERLIB_ADAPTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
