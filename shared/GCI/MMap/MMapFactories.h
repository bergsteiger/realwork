////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/MMap/MMapFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::MMap
//
// Интерфейсы для работы с диском, как с памятью (mmap)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAP_FCTR_H__
#define __SHARED_GCI_MMAP_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/MMap/MMap.h"

namespace GCI {
namespace MMap {

////////////////////////////////////////////////////////////////////////////////////
// const wrapper for FileForMem
class FileForMemConstWrapper: 
	virtual public FileForMem
	, virtual public ::Core::RefCountObjectBase
{
public:
	FileForMemConstWrapper (FileForMem* impl);

private:

	virtual const std::string& get_file_name () const;

	virtual LongSize get_file_size () const;

	virtual void resize_file (LongSize offset);

	virtual const ACE_HANDLE get_file_handle () const;

	virtual LongSize get_memory_offset () const;

	virtual void set_memory_offset (LongSize memory_offset);

	virtual const Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset) const;
	virtual Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset);

	virtual void upgrade_rw ();

private:
	friend class FileForMemFactoryManager;
	FileForMem_var m_impl;
	bool is_rw;
};

typedef ::Core::Var<FileForMemConstWrapper> FileForMemConstWrapper_var;

////////////////////////////////////////////////////////////////////////////////////
// factories definition for FileForMem

class FileForMemAbstractFactory;

/// factory manager for FileForMem
class FileForMemFactoryManager {
public:
	static void register_factory (FileForMemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	FileForMemFactoryManager ();
	
	~FileForMemFactoryManager ();
	
	void register_factory_i (FileForMemAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FileForMem* open (
		const char* file_name
		, unsigned long flags
		, size_t file_increase
	) /*throw (Core::Root::NoActiveFactory, SysError)*/;

	const FileForMem* open_ro (
		const char* file_name
		, unsigned long flags
		, size_t file_increase
	) /*throw (Core::Root::NoActiveFactory, SysError)*/;

	FileForMem* create (
		const char* file_name
		, LongSize size
		, unsigned long flags
	) /*throw (Core::Root::NoActiveFactory, SysError)*/;

	friend class FileForMemFactory;
	typedef ACE_Singleton <FileForMemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FileForMemFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:

	struct ComboDataVar {
		ComboDataVar ();
		ComboDataVar (FileForMem* rw_data_);
		FileForMem_var rw_data;
		Core::Var<FileForMemConstWrapper> ro_data;
		bool is_ro_first;
	};

	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FileForMemAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FileForMemAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FileForMem
class FileForMemAbstractFactory : virtual public Core::IObject {
	friend class FileForMemFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FileForMem* open (
		const char* file_name
		, unsigned long flags
		, size_t file_increase
		, bool ro_mode
	) /*throw (SysError)*/ = 0;

	virtual FileForMem* create (const char* file_name, LongSize size, unsigned long flags) /*throw (SysError)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for MemoryPool

class MemoryPoolAbstractFactory;

/// factory manager for MemoryPool
class MemoryPoolFactoryManager {
public:
	static void register_factory (MemoryPoolAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	MemoryPoolFactoryManager ();
	
	~MemoryPoolFactoryManager ();
	
	void register_factory_i (MemoryPoolAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	MemoryPool& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class MemoryPoolFactory;
	typedef ACE_Singleton <MemoryPoolFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <MemoryPoolFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<MemoryPoolAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<MemoryPoolAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	MemoryPool_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for MemoryPool
class MemoryPoolAbstractFactory : virtual public Core::IObject {
	friend class MemoryPoolFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual MemoryPool* get () = 0;
};

} // namespace MMap
} // namespace GCI


#endif //__SHARED_GCI_MMAP_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

