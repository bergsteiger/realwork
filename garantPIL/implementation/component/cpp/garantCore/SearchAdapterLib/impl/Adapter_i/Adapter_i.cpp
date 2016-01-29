////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garantCore::SearchAdapterLib::Adapter_i::Adapter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/LibHome.h"
#include "garantCore/SearchAdapterLib/impl/Adapter_i/Adapter_i.h"
// by <<uses>> dependencies
#include "garantCore/SearchAdapterLib/Cache/Cache.h"
#include "garantCore/DBExt/Readers/MemoryIndex.h"

namespace SearchAdapterLib {
namespace Adapter_i {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Adapter_i::Adapter_i ()
//#UC START# *4ED6538B00F4_4ED653F202B5_4ED709070278_BASE_INIT*
//#UC END# *4ED6538B00F4_4ED653F202B5_4ED709070278_BASE_INIT*
{
	//#UC START# *4ED6538B00F4_4ED653F202B5_4ED709070278_BODY*
	//#UC END# *4ED6538B00F4_4ED653F202B5_4ED709070278_BODY*
}

Adapter_i::~Adapter_i () {
	//#UC START# *4ED709070278_DESTR_BODY*
	//#UC END# *4ED709070278_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Adapter::IAdapter
// очитска кэшей и прочая финализация
void Adapter_i::fini () {
	//#UC START# *4ED655AE0293_4ED709070278*
	Cache::instance ()->fini ();
	DBExt::MemoryIndex::instance ()->clear ();
	//#UC END# *4ED655AE0293_4ED709070278*
}

// implemented method from Adapter::IAdapter
// интерфейс поисковика
Adapter::ISearcher* Adapter_i::get (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) {
	//#UC START# *4ED6547702A3_4ED709070278*
	return (Cache::instance ()->init (base))? Adapter::ISearcherFactory::make (base, cache, src) : 0;
	//#UC END# *4ED6547702A3_4ED709070278*
}

// implemented method from Adapter::IAdapter
// интерфейс хелпера
Adapter::IHelper* Adapter_i::get (DBCore::IBase* base, Morpho::Def::ICache* cache) {
	//#UC START# *4ED6557202BD_4ED709070278*
	return (Cache::instance ()->init (base))? Adapter::IHelperFactory::make (cache) : 0;
	//#UC END# *4ED6557202BD_4ED709070278*
}

// implemented method from Adapter::IAdapter
// данные для алгоритма модификации значений релевантности
const DBCore::RelTuneData& Adapter_i::get_tune_data () const {
	//#UC START# *538371CE0233_4ED709070278*
	return Cache::instance ()->get ()->get_tune_data ();
	//#UC END# *538371CE0233_4ED709070278*
}

// implemented method from Adapter::IAdapter
// инициализация
void Adapter_i::init (DBCore::IBase* base) {
	//#UC START# *5624DEAD0353_4ED709070278*
	GDS_ASSERT (Cache::instance ()->init (base));
	//#UC END# *5624DEAD0353_4ED709070278*
}

// implemented method from Adapter::IAdapter
// построить memcache поискового индекса
void Adapter_i::load_memcache (const DBCore::MemCacheSettings& settings) {
	//#UC START# *52BAEC330109_4ED709070278*
	try {
		DBExt::MemoryIndex::instance ()->load (settings);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	//#UC END# *52BAEC330109_4ED709070278*
}
} // namespace Adapter_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

