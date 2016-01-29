////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/IObject_tie.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::IObject_tie
//
// TIE-врапер для экспорта С++ интерфейсов в Дельфи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_IOBJECT_TIE_H__
#define __SHARED_CORE_MNG_IOBJECT_TIE_H__

#include "ace/ACE.h"
#include "shared/Core/sys/IObject.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/GDS/ObjectCounter.h"

//#UC START# *450036090128_USER_INCLUDES*
#include "ace/Singleton.h"

#include <map>
//#UC END# *450036090128_USER_INCLUDES*

namespace Core {

// Системное для Дельфи исключение о выходи за границы массива
class IndexOutOfBounds_tie : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

//#UC START# *450036090128_USER_DEFINITION*
#pragma pack (push, 1)
struct ComIID {
	unsigned long  data1;
	unsigned short data2;
	unsigned short data3;
	unsigned char  data4 [8];
	//
	bool operator == (const ComIID& iid2) const {
		return (memcmp (this, &iid2, sizeof (ComIID)) == 0);
	}
	bool operator != (const ComIID& iid2) const {
		return (memcmp (this, &iid2, sizeof (ComIID)) != 0);
	}
	bool operator < (const ComIID& iid2) const {
		return (memcmp (this, &iid2, sizeof (ComIID)) < 0);
	}
};
#pragma pack (pop)

typedef void* (*CastFunc)(IObject* object);

class IidMapManager {
public:
	void add_guid (const ComIID& guid, CastFunc cast_f) {
		GDS_ASSERT (m_guid_to_func.find (guid) == m_guid_to_func.end ());
		m_guid_to_func[guid] = cast_f;
	}

	unsigned long tie_query_interface (
		const ComIID& iid
		, IObject* from_object
		, void*& to_object
	) {
		GuidToFunc::iterator it = m_guid_to_func.find (iid);
		to_object = it != m_guid_to_func.end () ? it->second (from_object) : 0;

		if (to_object) {
			return 0x00000000UL;
		} else {
			return 0x80004002UL;
		}
	}

private:
	typedef std::map<ComIID, CastFunc> GuidToFunc;
	GuidToFunc m_guid_to_func;
};

typedef ACE_Singleton <IidMapManager, ACE_SYNCH_RECURSIVE_MUTEX> IidMapManagerSgl;

template <class _MyTie>
class IidMapRegistrator {
public:
	IidMapRegistrator<_MyTie> () {
		IidMapManagerSgl::instance()->add_guid (_MyTie::s_com_iid, _MyTie::cast);
	}
};

class TIEBase {
protected:	
	virtual unsigned long __stdcall query_interface (
		const ComIID& iid
		, void*& object
	) = 0;

public:
	virtual unsigned long __stdcall addref () const = 0;

	virtual unsigned long __stdcall release () const = 0;

protected:
	class TIEBaseVar {
		const TIEBase* m_tie_owner;
	
	public:
		TIEBaseVar () : m_tie_owner (0) {
		}
		
		~TIEBaseVar () {
			this->release ();
		}
		
		void release () {
			if (m_tie_owner) {
				m_tie_owner->release();
			}
			m_tie_owner = 0;
		}

		void operator = (const TIEBase* tb) {
			m_tie_owner = tb;
		}
	};

	TIEBase () : m_counter (1) {
	}

	mutable ACE_Atomic_Op <ACE_Thread_Mutex, long> m_counter;

	TIEBaseVar m_tie_owner;
};

//базовый интерфейс для TIE-интерфейсов
class IIObject_tie: public TIEBase {
public:
	virtual IObject* get_impl () const = 0;
};

class IObject_tie : public IIObject_tie {
	SET_OBJECT_COUNTER (IObject_tie)
protected:	
	virtual unsigned long __stdcall query_interface (
		const ComIID& iid
		, void*& object
	) {
		if (iid == s_com_iid) {
			this->addref();
			object = this;
			return 0x00000000UL;
		} else {
			return IidMapManagerSgl::instance()->tie_query_interface (iid, m_impl, object);
		}
	}

	virtual unsigned long __stdcall addref () const {
		return ++m_counter;
	}

public:
	virtual unsigned long __stdcall release () const {
		long const counter = --m_counter;

		if (counter == 0) {			
			MyPool::instance()->release_obj(const_cast<IObject_tie* const>(this));
		}
		return counter;
	}
	
	virtual IObject* get_impl () const {
		return m_impl;
	}
	// For ObjectPool's objects initialisation and destruction 
public:
	void init () {
		m_counter = 1;
	}

	void done () {
		m_impl->release();
		m_impl = NULL;

		m_tie_owner.release ();
	}

private:
	IObject_tie () : m_impl(NULL) {
	}

	typedef PoolObjectManager<IObject_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<IObject_tie> Pool;
	friend class ::Core::PoolObjectManager<IObject_tie>;

	typedef ::Core::IidMapRegistrator<IObject_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;

public:
	static const ComIID s_com_iid;

	static void* cast (IObject* obj) {
		IObject* ret = dynamic_cast<IObject*>(obj);
		if (ret) {
			ret->addref();
		}
		IIObject_tie* _ret = NULL;
		IObject_tie::make_tie (ret, _ret);
		return _ret;
	}

	inline static void make_cpp (const IIObject_tie* obj, IObject*& _ret, bool interface_addref = false) {
		if (!obj) {
			_ret = 0;
		} else {
			_ret = obj->get_impl ();
			if (interface_addref) {
				_ret->addref();
			}
		}
	}

	static void make_tie (const IObject* obj, IIObject_tie*& _ret, bool interface_addref = false) {
		if (!obj) {
			_ret = NULL;
		} else {
			if (_ret) {
				_ret->release();
			}
			IObject_tie* ret = MyPool::instance()->new_obj();
			ret->m_impl = const_cast<IObject*>(obj);
			if (interface_addref) {
				ret->m_impl->addref();
			}
			_ret = ret;
		}
	}

	IObject* m_impl;
};

//#UC END# *450036090128_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_IOBJECT_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
