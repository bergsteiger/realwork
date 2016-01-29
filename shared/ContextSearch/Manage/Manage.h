////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Manage/Manage.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Manage
//
// ���������� � ���� ��� ���������� ��������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MANAGE_H__
#define __SHARED_CONTEXTSEARCH_MANAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Manage {

class IRequestTransformer;
typedef ::Core::Var<IRequestTransformer> IRequestTransformer_var;
typedef ::Core::Var<const IRequestTransformer> IRequestTransformer_cvar;
// ��������� ��� ��������� ����������� ����������� ��������
class IRequestTransformer
	: virtual public ::Core::IObject
{
public:
	// ���������� ����-����
	virtual size_t exclude (
		std::string& req
		, const GCL::StrVector& data
		, const DBComm::PSDTemplates& templates
		, bool is_fake
	) = 0;

	// �������������
	virtual void correct (const std::string& in, std::string& out) = 0;

	// ���������� ����-����
	virtual void unchecked_exclude (std::string& req, const GCL::StrVector& data) = 0;

	// ���������
	virtual GCL::StrVector* execute (
		const std::string& in
		, const GCL::StrVector& data
		, const GCL::StrVector& hard
		, Defs::StrStrMap& pseudo
	) = 0;
};

/// factory interface for IRequestTransformer
class IRequestTransformerFactory {
public:
	// �������
	static IRequestTransformer* make (Morpho::Def::INormalizer* normalizer)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ISynManager;
typedef ::Core::Var<ISynManager> ISynManager_var;
typedef ::Core::Var<const ISynManager> ISynManager_cvar;
// ��������� ��� ��������������
class ISynManager
	: virtual public ::Core::IObject
{
public:
	// �������������
	virtual Search::IRequestView* execute (const std::string& in, bool is_default) = 0;
};

/// factory interface for ISynManager
class ISynManagerFactory {
public:
	// �������
	static ISynManager* make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ��������� ���������
struct Env {
	// ��������-���������
	DBComm::IProgress_var progress;
	// ������� �������
	DBComm::IStreamsFactory_var factory;
	// ������������
	Morpho::Def::INormalizer_var normalizer;
	// ��������� ��� wildcard
	DBComm::IWildCard_var wild_mng;
};

#pragma pack (pop)

class IQuery;
typedef ::Core::Var<IQuery> IQuery_var;
typedef ::Core::Var<const IQuery> IQuery_cvar;
// ��������� ��������� ��������� ��������
class IQuery
	: virtual public ::Core::IObject
{
public:
	// �������� ���
	virtual void clear () = 0;

	// ������ ������������ ��������
	virtual Search::SplitRequests* get_data () = 0;

	// ��������� �����
	virtual Defs::RelevancyDocuments* execute (const Defs::SearchInfo& info) = 0;

	// ��������� ����� � ���������
	virtual Defs::Fragments* get_fragments (DBComm::DocId id) = 0;

	// ������� ����������� ����������
	virtual Defs::Positions* get_positions (DBComm::DocId id) = 0;

	// �������� ������
	virtual void add (const Defs::Request& req, bool uwc) = 0;

	// ��� ������� �������
	virtual GCL::StrVector* get_lexemes (bool add_special) = 0;

	// ��������� �����
	virtual void execute (const Defs::SearchInfo& info, Defs::IResCollector* collector) = 0;
};

/// factory interface for IQuery
class IQueryFactory {
public:
	// �������
	static IQuery* make (const Env& in, DBComm::IDBCommunicator* comm)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ���������� ������
class InvalidQuery : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Manage
} // namespace ContextSearch

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContextSearch::Manage::IRequestTransformer> {
	typedef ContextSearch::Manage::IRequestTransformerFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Manage::ISynManager> {
	typedef ContextSearch::Manage::ISynManagerFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Manage::IQuery> {
	typedef ContextSearch::Manage::IQueryFactory Factory;
};
} // namespace Core


#endif //__SHARED_CONTEXTSEARCH_MANAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
