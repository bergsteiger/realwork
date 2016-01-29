////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Cache/Cache.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::Cache::Cache
//
// Кэш
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Cache/Cache.h"
// by <<uses>> dependencies
#include "garantCore/SearchAdapterLib/impl/DBComm_i/DBCommunicator_i.h"

//#UC START# *52BAD68202DF_CUSTOM_INCLUDES*
#include "shared/Adapters/mlmaru/MLMARUAdapter.h"
//#UC END# *52BAD68202DF_CUSTOM_INCLUDES*

namespace SearchAdapterLib {

//#UC START# *52BAD68202DF*
//#UC END# *52BAD68202DF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Cache::Cache ()
//#UC START# *52BAD6B30088_BASE_INIT*
//#UC END# *52BAD6B30088_BASE_INIT*
{
	//#UC START# *52BAD6B30088_BODY*
	//#UC END# *52BAD6B30088_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// финализация
void Cache::fini () {
	//#UC START# *52BAD6F500CF*
	GUARD (m_mutex);

	if (m_communicator.is_nil () == false) {
		m_communicator.release ();
	}
	//#UC END# *52BAD6F500CF*
}

// коммуникатор
ContextSearch::DBComm::IDBCommunicator* Cache::get () {
	//#UC START# *52BAD70D03B0*
	GDS_ASSERT (m_communicator.is_nil () == false);
	return m_communicator.in ();
	//#UC END# *52BAD70D03B0*
}

// инициализация
bool Cache::init (DBCore::IBase* base) {
	//#UC START# *52BAD6C90168*
	GDS_ASSERT (base);

	if (m_communicator.is_nil ()) {
		GUARD (m_mutex);

		if (m_communicator.is_nil ()) {
			try { 
				m_communicator = new DBComm_i::DBCommunicator_i (base);
			} catch (...) {
				LOG_UEX ((GDS_CURRENT_FUNCTION));
				return false;
			}
		}
	}

	return Adapters::MLMA32RUAdapterSingleton::instance ()->is_loaded ();
	//#UC END# *52BAD6C90168*
}

} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

