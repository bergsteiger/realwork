////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/IO/IOFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// пакет интерфейсов ввода-вывода
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_FCTR_H__
#define __SHARED_GCI_IO_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/GCI/IO/IO.h"

namespace GCI {
namespace IO {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for String

class StringAbstractFactory;

/// factory manager for String
class StringFactoryManager {
public:
	static void register_factory (StringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	StringFactoryManager ();
	
	~StringFactoryManager ();
	
	void register_factory_i (StringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	String* make (const char* str) /*throw (Core::Root::NoActiveFactory)*/;

	String* create (const char* str, short code_page) /*throw (Core::Root::NoActiveFactory)*/;

	String* take (char* str, short code_page) /*throw (Core::Root::NoActiveFactory)*/;

	String* alloc (unsigned long maximum) /*throw (Core::Root::NoActiveFactory)*/;

	friend class StringFactory;
	typedef ACE_Singleton <StringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <StringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<StringAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<StringAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for String
class StringAbstractFactory : virtual public Core::IObject {
	friend class StringFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual String* make (const char* str) = 0;

	virtual String* create (const char* str, short code_page) = 0;

	virtual String* take (char* str, short code_page) = 0;

	virtual String* alloc (unsigned long maximum) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Stream

class StreamAbstractFactory;

/// factory manager for Stream
class StreamFactoryManager {
public:
	static void register_factory (StreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	StreamFactoryManager ();
	
	~StreamFactoryManager ();
	
	void register_factory_i (StreamAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Stream* make () /*throw (Core::Root::NoActiveFactory)*/;

	Stream* make (const char* path) /*throw (Core::Root::NoActiveFactory)*/;

	friend class StreamFactory;
	typedef ACE_Singleton <StreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <StreamFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<StreamAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<StreamAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Stream
class StreamAbstractFactory : virtual public Core::IObject {
	friend class StreamFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Stream* make () = 0;

	virtual Stream* make (const char* path) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for BinaryString

class BinaryStringAbstractFactory;

/// factory manager for BinaryString
class BinaryStringFactoryManager {
public:
	static void register_factory (BinaryStringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	BinaryStringFactoryManager ();
	
	~BinaryStringFactoryManager ();
	
	void register_factory_i (BinaryStringAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	BinaryString* make (const void* buffer, size_t size) /*throw (Core::Root::NoActiveFactory)*/;

	friend class BinaryStringFactory;
	typedef ACE_Singleton <BinaryStringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <BinaryStringFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<BinaryStringAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<BinaryStringAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for BinaryString
class BinaryStringAbstractFactory : virtual public Core::IObject {
	friend class BinaryStringFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual BinaryString* make (const void* buffer, size_t size) = 0;
};

} // namespace IO
} // namespace GCI


#endif //__SHARED_GCI_IO_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

