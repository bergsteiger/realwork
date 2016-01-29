////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDoneFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::BuildTestLib::OnBuildDone
//
// имлементация того что надо сделать по событию окончания сборки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/OnBuildDone.h"

namespace BuildTestLib {
namespace OnBuildDone {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for LocalPageLogin

class LocalPageLoginAbstractFactory;

/// factory manager for LocalPageLogin
class LocalPageLoginFactoryManager {
public:
	static void register_factory (LocalPageLoginAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LocalPageLoginFactoryManager ();
	
	~LocalPageLoginFactoryManager ();
	
	void register_factory_i (LocalPageLoginAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LocalPageLogin* make (
		const std::string& login
		, const std::string& passwd
		, ServerGate::Contents::PageId page_id
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class LocalPageLoginFactory;
	typedef ACE_Singleton <LocalPageLoginFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LocalPageLoginFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LocalPageLoginAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LocalPageLoginAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for LocalPageLogin
class LocalPageLoginAbstractFactory : virtual public Core::IObject {
	friend class LocalPageLoginFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LocalPageLogin* make (
		const std::string& login
		, const std::string& passwd
		, ServerGate::Contents::PageId page_id
	) = 0;
};

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

