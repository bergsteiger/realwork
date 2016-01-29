////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/FoldersFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupportFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for FoldersNode

class FoldersNodeAbstractFactory;

/// factory manager for FoldersNode
class FoldersNodeFactoryManager {
public:
	static void register_factory (FoldersNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FoldersNodeFactoryManager ();
	
	~FoldersNodeFactoryManager ();
	
	void register_factory_i (FoldersNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FoldersNode* make (Containers::Content* content, Folders* folders) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FoldersNodeFactory;
	typedef ACE_Singleton <FoldersNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FoldersNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FoldersNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FoldersNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FoldersNode
class FoldersNodeAbstractFactory : virtual public Core::IObject {
	friend class FoldersNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FoldersNode* make (Containers::Content* content, Folders* folders) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Folders

class FoldersAbstractFactory;

/// factory manager for Folders
class FoldersFactoryManager {
public:
	static void register_factory (FoldersAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FoldersFactoryManager ();
	
	~FoldersFactoryManager ();
	
	void register_factory_i (FoldersAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Folders& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class FoldersFactory;
	typedef ACE_Singleton <FoldersFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FoldersFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FoldersAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FoldersAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	Folders_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for Folders
class FoldersAbstractFactory : virtual public Core::IObject {
	friend class FoldersFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Folders* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Folder

class FolderAbstractFactory;

/// factory manager for Folder
class FolderFactoryManager {
public:
	static void register_factory (FolderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FolderFactoryManager ();
	
	~FolderFactoryManager ();
	
	void register_factory_i (FolderAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Folder* make (GblFolders::Folder* folder_content, FoldersNode* folders_node) /*throw (Core::Root::NoActiveFactory)*/;

	friend class FolderFactory;
	typedef ACE_Singleton <FolderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FolderFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FolderAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FolderAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Folder
class FolderAbstractFactory : virtual public Core::IObject {
	friend class FolderFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Folder* make (GblFolders::Folder* folder_content, FoldersNode* folders_node) = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

