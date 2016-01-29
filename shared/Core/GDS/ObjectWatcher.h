////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/GDS/ObjectWatcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::GDS::ObjectWatcher
//
// класс для распечатки не удаленных объектов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_GDS_OBJECTWATCHER_H__
#define __SHARED_CORE_GDS_OBJECTWATCHER_H__

#include "ace/ACE.h"
#include "shared/Core/fix/PragmaWarningDisable.h"
#include "shared/Core/mng/Var.h"

//#UC START# *450E98B700AB_USER_INCLUDES*
#include <set>
#include <string>

/*
Класс является дополнительным инструментом для анализа утечки объектов.

Использование:

Предположем ObjectCounter показал Вам что имеются утечки объектов определенного типа. Если этой информации не достаточно, и нужно понять какие именно объекты провисли - нужно воспользоваться ObjectWatcher'ом. Для этого:

1) реализуем на интересующем нас классе (классах) метод void _dump (FILE* to_dump) const

    Например:

  #ifdef _DEBUG

  void NodeBase_i::_dump (FILE* to_dump) const {
       NodeBase_i* const_this = const_cast<NodeBase_i*> (this);
       const char* n = const_this->m_name ? const_this->m_name->get_buffer() : "NULL";
       GTree::NodePointer p = const_this->get_server_pointer();
       fprintf (to_dump, "NodeBase_i, caption = %s, pointer = %d", n, p);
  }

  #endif

 2) вставляем во все конструкторы данного класса (классов) макрос ADD_OBJECT_WATCHER

 3) вставляем в деструктор данного класса (классов) следующий макрос REMOVE_OBJECT_WATCHER (если для данного класса не объявлен деструктор - его необходимо объявить). Деструкторы должны быть виртуальными.

    Например:

#include "shared/Core/GDS/ObjectWatcher.h"

NodeBase_i::NodeBase_i (TreeBase* const owner_tree, const GTree::Node& snode) 
     : RealNodeBase (owner_tree, snode)
     , NodeBase (owner_tree)
     , m_has_break ((snode.flags & GTree::VNF_NODE_GAP) == GTree::VNF_NODE_GAP)
{
     ADD_OBJECT_WATCHER
}


NodeBase_i::~NodeBase_i () {
     REMOVE_OBJECT_WATCHER
}



Перед самым завершением программы ObjectWatcher, выведет все неосвобожденные объекты на поток stderr (консоль оболочки), т.е. туда же куда выводится статистика ObjectCountera.

ObjectWatcher нужно инициализировать в приложении, аналогично ObjectCounterу, но строго после PoolMemoryManager, т.к. память объектов может быть распределенна именно через Пул, и, есоли Пул удалится раньше, то доступ к данным прповисшего объекта будет не возможеен:

#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectCounter.h"
#include "shared/Core/mng/PoolMemoryManager.h"
#include "shared/Core/GDS/ObjectWatcher.h"

*/
//#UC END# *450E98B700AB_USER_INCLUDES*

namespace Core {
namespace GDS {

//#UC START# *450E98B700AB_USER_DEFINITION*
#ifdef _DEBUG

class ObjectHolderBase {
public:
	bool operator < (const ObjectHolderBase& cp) const {
		return this->get_data_ptr () < cp.get_data_ptr ();
	}

	virtual void dump_object (FILE* to_dump) const = 0;

	virtual ~ObjectHolderBase() {} 
protected:
	virtual const void* get_data_ptr () const = 0;
};

template <class _ObjType>
class ObjectHolder : public ObjectHolderBase {
public:
	ObjectHolder (const _ObjType* object) : m_object (object) {
	}

	void dump_object (FILE* to_dump) const {
		m_object->_dump (to_dump);
	}

	virtual const void* get_data_ptr () const {
		return m_object;
	}

private:
	const _ObjType* m_object;
};

struct SetItem {
	ObjectHolderBase* oh_item;
	
	SetItem (ObjectHolderBase* item) : oh_item (item) {
	}
	
	SetItem (const SetItem& cp) : oh_item (cp.oh_item) {
		const_cast<SetItem*>(&cp)->oh_item = 0;
	}
	
	bool operator < (const SetItem& cp) const {
		return *oh_item < *cp.oh_item;
	}
	
	~SetItem () {
		if (oh_item) {
			delete oh_item;
		}
	}

	void dump_object (FILE* to_dump) const {
		oh_item->dump_object (to_dump);
	}
};
	

class ObjectWatcher {
	typedef std::set<SetItem> ObjHolders;

public:
	void dump (FILE* to_dump) {
		Guard g (m_access_mutex);
		
		fprintf (to_dump, "ObjectWatcher DEBUG  : dump exist objects (count = %llu)\n", m_holders.size());
		unsigned i = 0;
		for (ObjHolders::iterator it = m_holders.begin(); it != m_holders.end(); it++, i++) {
			fprintf (to_dump, "ObjectWatcher DEBUG: object [%d] dump:", i);
			it->dump_object (to_dump);
			fprintf (to_dump, "\n");
		}

		assert (m_holders.size() == 0);
	}

	template <class _ObjType>
	void add_object (const _ObjType* obj) {
		Guard g (m_access_mutex);
		SetItem si (new ObjectHolder <_ObjType> (obj));
		m_holders.insert (si);
	}
	
	template <class _ObjType>
	void remove_object (const _ObjType* obj) {
		Guard g (m_access_mutex);
		SetItem si (new ObjectHolder <_ObjType> (obj));
		m_holders.erase (si);
	}

	~ObjectWatcher () {
		this->dump (stderr);
	}	

public:
	typedef ACE_Recursive_Thread_Mutex Mutex;
	typedef ACE_Guard<Mutex> Guard;
	
	Mutex m_access_mutex;
	
	ObjHolders m_holders;
};

typedef ACE_Singleton <ObjectWatcher, ACE_SYNCH_RECURSIVE_MUTEX> ObjectWatcherSingleton;

#else // ! define _DEBUG
#endif
//#UC END# *450E98B700AB_USER_DEFINITION*

} // namespace GDS
} // namespace Core


#endif //__SHARED_CORE_GDS_OBJECTWATCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
