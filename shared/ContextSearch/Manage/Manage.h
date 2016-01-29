////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/Manage/Manage.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Manage
//
// Интерфейсы и типы для менеджеров поисковых алгоритмов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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
// Интерфейс для алгоритма модификации контекстных запросов
class IRequestTransformer
	: virtual public ::Core::IObject
{
public:
	// исключение стоп-слов
	virtual size_t exclude (
		std::string& req
		, const GCL::StrVector& data
		, const DBComm::PSDTemplates& templates
		, bool is_fake
	) = 0;

	// корректировка
	virtual void correct (const std::string& in, std::string& out) = 0;

	// исключение стоп-слов
	virtual void unchecked_exclude (std::string& req, const GCL::StrVector& data) = 0;

	// выполнить
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
	// фабрика
	static IRequestTransformer* make (Morpho::Def::INormalizer* normalizer)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ISynManager;
typedef ::Core::Var<ISynManager> ISynManager_var;
typedef ::Core::Var<const ISynManager> ISynManager_cvar;
// Интерфейс для синонимизатора
class ISynManager
	: virtual public ::Core::IObject
{
public:
	// синонимизация
	virtual Search::IRequestView* execute (const std::string& in, bool is_default) = 0;
};

/// factory interface for ISynManager
class ISynManagerFactory {
public:
	// фабрика
	static ISynManager* make (Morpho::Def::INormalizer* normalizer, DBComm::IDBCommunicator* comm)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// Поисковое окружение
struct Env {
	// прогресс-индикатор
	DBComm::IProgress_var progress;
	// фабрика стримов
	DBComm::IStreamsFactory_var factory;
	// нормализатор
	Morpho::Def::INormalizer_var normalizer;
	// генератор для wildcard
	DBComm::IWildCard_var wild_mng;
};

#pragma pack (pop)

class IQuery;
typedef ::Core::Var<IQuery> IQuery_var;
typedef ::Core::Var<const IQuery> IQuery_cvar;
// Интерфейс менеджера поисковых запросов
class IQuery
	: virtual public ::Core::IObject
{
public:
	// очистить кэш
	virtual void clear () = 0;

	// список синонимичных запросов
	virtual Search::SplitRequests* get_data () = 0;

	// выполнить поиск
	virtual Defs::RelevancyDocuments* execute (const Defs::SearchInfo& info) = 0;

	// выполнить поиск в документе
	virtual Defs::Fragments* get_fragments (DBComm::DocId id) = 0;

	// позиции релевантных фрагментов
	virtual Defs::Positions* get_positions (DBComm::DocId id) = 0;

	// добавить запрос
	virtual void add (const Defs::Request& req, bool uwc) = 0;

	// все лексемы запроса
	virtual GCL::StrVector* get_lexemes (bool add_special) = 0;

	// выполнить поиск
	virtual void execute (const Defs::SearchInfo& info, Defs::IResCollector* collector) = 0;
};

/// factory interface for IQuery
class IQueryFactory {
public:
	// фабрика
	static IQuery* make (const Env& in, DBComm::IDBCommunicator* comm)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Невалидный запрос
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
