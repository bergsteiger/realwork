////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/PoolObjectManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::PoolObjectManager
//
// Менеджер пула объектов (для сокращения дефрагментации памяти и кол-во циклов new/delete и
// конструктор/деструктор). Данная реализация эффективна только для небольшого количества объектов
// в пуле.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_POOLOBJECTMANAGER_H__
#define __SHARED_CORE_MNG_POOLOBJECTMANAGER_H__

#include "ace/ACE.h"
#include "shared/Core/sys/IObject.h"
#include "shared/Core/mng/Var.h"

//#UC START# *45001560033C_USER_INCLUDES*
#include "ace/Singleton.h"

#include "shared/Core/sys/assert.h"

#include <vector>
//#UC END# *45001560033C_USER_INCLUDES*

namespace Core {

//#UC START# *45001560033C_USER_DEFINITION*
struct DestroyableObjectPool {
	virtual void destroy () = 0;
};

class PoolObjectOwner {	
	typedef std::vector<DestroyableObjectPool*> PoolObjects;

public:
	void add_object (DestroyableObjectPool* object) {
		this->objects.push_back (object);
	}

	~PoolObjectOwner () {
		for (PoolObjects::iterator it = objects.begin (); it != objects.end (); ++it) {
			(*it)->destroy ();
		}
	}

private:
	PoolObjects objects;
};
typedef ACE_Singleton <PoolObjectOwner, ACE_SYNCH_RECURSIVE_MUTEX> PoolObjectOwnerSingleton;

// по-хорошему в политику надо занести и метод create для парности,
// однако сейчас для обоих политик вызывается просто new.
// А втаскивать new TYPE_ () в политику не так просто, так как политика не является другом TYPE_,
// а для многих TYPE_ конструктор закрытый. Приходится в политике дёргать метод специально заведённый для
// этого на пуле, выглядит, мягко говоря, похабненько.

template <typename TYPE_>
struct NewDeletePolicy {
	static void init (TYPE_* obj) {
		GDS_ASSERT (obj);
		new (obj) TYPE_ ();
	}

	static void done (TYPE_* obj) {
		GDS_ASSERT (obj);
		obj->~TYPE_ ();
	}

	static void destroy (TYPE_* obj) {
		GDS_ASSERT (obj);
		operator delete (obj);
	}
};

template <typename TYPE_>
struct InitDonePolicy {
	static void init (TYPE_* obj) {
		GDS_ASSERT (obj);
		obj->init ();
	}

	static void done (TYPE_* obj) {
		GDS_ASSERT (obj);
		obj->done ();
	}

	static void destroy (TYPE_* obj) {
		GDS_ASSERT (obj);
		delete obj;
	}
};

template<typename T>
struct PoolObjectTraits {
	typedef Core::InitDonePolicy<T> CreationDestructionPolicy;
};

template <typename TYPE_>
class PoolObjectManager : public DestroyableObjectPool {
public:
	typedef ACE_Unmanaged_Singleton <
				PoolObjectManager<TYPE_>
				, ACE_SYNCH_RECURSIVE_MUTEX
			> PoolObjectManagerSingleton;

	virtual void destroy () {
		PoolObjectManagerSingleton::close ();
	}

public:
	PoolObjectManager () {
		PoolObjectOwnerSingleton::instance ()->add_object (this);
	}

	virtual ~PoolObjectManager () {
		ObjectSet tmp = m_all_obj;
		m_all_obj.clear();

		for (typename ObjectSet::iterator it = tmp.begin(); it != tmp.end(); it++) {
			if (it->free) {
				PoolObjectTraits<TYPE_>::CreationDestructionPolicy::destroy (it->data);
			}
		}
	}

	inline TYPE_* new_obj () {
		register TYPE_* ret;
			for (typename ObjectSet::iterator it = m_all_obj.begin(); it != m_all_obj.end(); it++) {
				if (it->free) {
					it->free = false;
					PoolObjectTraits<TYPE_>::CreationDestructionPolicy::init (it->data);
					return it->data;
				}
			}
			ret = new TYPE_ ();
			m_all_obj.push_back(Data (ret));
		
		return ret;
	}

	void release_obj (TYPE_* obj) const { // without "obj" validate
		for (typename ObjectSet::iterator it = m_all_obj.begin(); it != m_all_obj.end(); it++) {
			if (it->data == obj) {
				PoolObjectTraits<TYPE_>::CreationDestructionPolicy::done (it->data);
				it->free = true;
				return;
			}
		}
		GDS_ASSERT (false && "object created by hands");
		delete obj;
	}
	
private:
	struct Data {
		TYPE_* data;
		bool free;

		explicit Data (TYPE_* d) : data (d), free (false) {
		}
	};

	typedef std::vector<Data> ObjectSet;
	mutable ObjectSet m_all_obj;
};
//#UC END# *45001560033C_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_POOLOBJECTMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
