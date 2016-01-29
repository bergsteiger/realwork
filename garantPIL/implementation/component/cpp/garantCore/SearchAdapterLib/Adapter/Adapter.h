////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/Adapter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::SearchAdapterLib::Adapter
//
// Интерфейсы и типы поискового адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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
// Интерфейс IDocuments
class IDocuments
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const ContextSearch::Defs::RelevancyDocuments& data () const = 0;
};

class IFragments;
typedef ::Core::Var<IFragments> IFragments_var;
typedef ::Core::Var<const IFragments> IFragments_cvar;
// Интерфейс IFragments
class IFragments
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const ContextSearch::Defs::Fragments& data () const = 0;
};

class IPositions;
typedef ::Core::Var<IPositions> IPositions_var;
typedef ::Core::Var<const IPositions> IPositions_cvar;
// Интерфейс IPositions
class IPositions
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const ContextSearch::Defs::Positions& data () const = 0;
};

// Коллектор для результата поиска
typedef ContextSearch::Defs::IResCollector IResCollector;
typedef ContextSearch::Defs::IResCollector_var IResCollector_var;
typedef ContextSearch::Defs::IResCollector_cvar IResCollector_cvar;

class IStrings;
typedef ::Core::Var<IStrings> IStrings_var;
typedef ::Core::Var<const IStrings> IStrings_cvar;
// Интерфейс IWords
class IStrings
	: virtual public ::Core::IObject
{
public:
	// данные
	virtual const GCL::StrSet& data () const = 0;
};

class ISynRequest;
typedef ::Core::Var<ISynRequest> ISynRequest_var;
typedef ::Core::Var<const ISynRequest> ISynRequest_cvar;
// Синонимичные запросы
class ISynRequest
	: virtual public ::Core::IObject
{
public:
	// запрос
	virtual const GCL::StrVector& data (size_t i) const = 0;

	// размер
	virtual size_t size () const = 0;
};

// Вектор лонгов
typedef std::vector < long > LongVector;

class ISearcher;
typedef ::Core::Var<ISearcher> ISearcher_var;
typedef ::Core::Var<const ISearcher> ISearcher_cvar;
// Интерфейс поисковика
class ISearcher
	: virtual public ::Core::IObject
{
public:
	// получить список релевантных документов
	virtual IDocuments* get_documents (
		const ContextSearch::Defs::Requests& reqs
		, const ContextSearch::Defs::SearchInfo& info
	) = 0;

	// получить позиции всех релевантных фрагментов
	virtual IPositions* get_positions (const GCL::StrVector& reqs, DBCore::DocId id) = 0;

	// получить список релевантных фрагментов
	virtual IFragments* get_fragments (
		const std::string& in
		, DBCore::DocId id
		, unsigned long word
		, unsigned long first_word
	) = 0;

	// получить список релевантных фрагментов
	virtual IFragments* get_fragments (const std::string& in, DBCore::DocId id) = 0;

	// поиск
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
	// фабрика
	static ISearcher* make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Настроки кэша
typedef DBCore::MemCacheSettings MemCacheSettings;

// Список инициализации
typedef ContextSearch::Defs::IFilter IFilter;
typedef ContextSearch::Defs::IFilter_var IFilter_var;
typedef ContextSearch::Defs::IFilter_cvar IFilter_cvar;

class IHelper;
typedef ::Core::Var<IHelper> IHelper_var;
typedef ::Core::Var<const IHelper> IHelper_cvar;
// Вспомогательный интерфейс
class IHelper
	: virtual public ::Core::IObject
{
public:
	// трансформация строки запроса
	virtual IStrings* transform (const std::string& str) = 0;

	// синонимия
	virtual ISynRequest* synonymy (const char* req) = 0;
};

/// factory interface for IHelper
class IHelperFactory {
public:
	// фабрика
	static IHelper* make (Morpho::Def::ICache* cache)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// Прогресс-индикатор
typedef DBCore::IProgress IProgress;
typedef DBCore::IProgress_var IProgress_var;
typedef DBCore::IProgress_cvar IProgress_cvar;

// Интерфейс для сбора детальной информации о релевантности
typedef ContextSearch::Defs::IRelevancyInfo IRelevancyInfo;
typedef ContextSearch::Defs::IRelevancyInfo_var IRelevancyInfo_var;
typedef ContextSearch::Defs::IRelevancyInfo_cvar IRelevancyInfo_cvar;

// RelTuneData
typedef DBCore::RelTuneData RelTuneData;

// Тип
typedef ContextSearch::Defs::TuneDocType TuneDocType;

class IAdapter;
typedef ::Core::Var<IAdapter> IAdapter_var;
typedef ::Core::Var<const IAdapter> IAdapter_cvar;
// Интерфейс поискового адаптера
class IAdapter
	: virtual public ::Core::IObject
{
public:
	// интерфейс поисковика
	virtual ISearcher* get (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) = 0;

	// интерфейс хелпера
	virtual IHelper* get (DBCore::IBase* base, Morpho::Def::ICache* cache) = 0;

	// очитска кэшей и прочая финализация
	virtual void fini () = 0;

	// построить memcache поискового индекса
	virtual void load_memcache (const DBCore::MemCacheSettings& settings) = 0;

	// данные для алгоритма модификации значений релевантности
	virtual const DBCore::RelTuneData& get_tune_data () const = 0;

	// инициализация
	virtual void init (DBCore::IBase* base) = 0;
};

/// factory interface for IAdapter
class IAdapterFactory {
public:
	// кэшируемая фабрика
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
