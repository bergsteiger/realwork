////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/Var.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::Var
//
// менеджер интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_VAR_H__
#define __SHARED_CORE_MNG_VAR_H__

#include "ace/ACE.h"
#include "shared/Core/mng/PtrGuard.h"
#include "shared/Core/sys/IObject.h"
#include "shared/Core/sys/Exception.h"

//#UC START# *4500152300FA_USER_INCLUDES*
/*! EXAMPLE

  EX1: Use as simple auto-destructor

  func_destructor (MyData* d) {
	// or use Var if MyData is a interface or servant
	MyData* d = new MyData (...);
	Core::Var<MyData> data (d); // take control, free after use
	
	// or use Box if MyData not inherited from IObject and pass throu functions or managed by any containers
	// or use Aptr if MyData dont pass throu function or dont managed by any containers
	
	...
  }

*/ 
//#UC END# *4500152300FA_USER_INCLUDES*

namespace Core {

//#UC START# *4500152300FA_USER_DEFINITION*
template <class _Type>
class Var {
public:
	class DataInUse : public Exception {
		virtual const char* uid () const /*throw ()*/ {
			return "Core::Var::DataInUse";
		}
	};

	typedef _Type value_type;
	typedef _Type element_type; //for boost smart_ptr compatible
private:
	Var (const PtrGuard<_Type>& copy) {
		assert (0);
	}

	Var<_Type>& operator = (const PtrGuard<_Type>& copy) {
		assert (0);
	}

public:	
	///////////////////////////
	// construction	
	///////////////////////////

	Var () : m_ptr(0) {
	}

	Var (_Type* data) : m_ptr (data) {
	}

	Var (const Var<_Type>& copy) {
		m_ptr = copy.m_ptr;
		this->addref();
	}
		
	Var<_Type>& operator = (const Var<_Type>& copy) {
		if (m_ptr == copy.m_ptr) {
			return *this;
		}
		this->release ();
		m_ptr = copy.m_ptr;
		this->addref();
		return *this;
	}

	Var<_Type>& operator = (_Type* data) {
		this->release ();
		m_ptr = data;
 		return *this;
	}
	
	virtual ~Var () {
		this->release ();
	}

	///////////////////////////
	// access by pointer	
	///////////////////////////

	inline _Type* operator -> () {
		assert (m_ptr);
		return m_ptr;
	}

	inline _Type const* operator -> () const {
		assert (m_ptr);
		return m_ptr;
	}

	inline _Type* ptr () {
		return m_ptr;
	}

	inline _Type const* ptr () const {
		return m_ptr;
	}
	
	///////////////////////////
	// acess by reference
	///////////////////////////

	inline _Type& operator * () {
		assert (m_ptr);
		return *m_ptr;
	}

	inline _Type const& operator * () const {
		assert (m_ptr);
		return *m_ptr;
	}

	/////////////////////////
	// transfering opertaor
	/////////////////////////

	inline _Type* _retn () {
		// TAO semantic, reduce refcounting
		_Type* val = m_ptr;
		m_ptr = 0;
		return val;
	}

	inline _Type const* _retn () const {
		this->addref();
		return m_ptr;
	}

	// safe _retn
	inline _Type* _sretn () {
		this->addref();
		return m_ptr;
	}

	inline _Type const* _sretn () const {
		this->addref();
		return m_ptr;
	}
	
	inline _Type* in () {
		return m_ptr;
	}

	inline _Type const* in () const {
		return m_ptr;
	}

	inline _Type*& out () {
		this->release ();		
		m_ptr = 0;
		return m_ptr;
	}

	inline _Type*& inout () {
		return m_ptr;
	}

	/////////////////////////
	// logic opertaor
	/////////////////////////

	inline bool is_nil () const {
		return m_ptr == 0;
	}

	inline const bool operator ! () const {
		return m_ptr == 0;
	}

	///////////////////////////
	// ref counting
	///////////////////////////
	
	inline unsigned long ref_count () const {
		if (m_ptr) {
			return m_ptr->ref_count();
		} else {
			return 0;
		}
	}

	inline unsigned long addref () const { 
		if (m_ptr) {
			return m_ptr->addref();
		} else {
			return 0;
		}
	}

	inline unsigned long release () {
		unsigned long ret = 0;
		if (m_ptr) {
			ret = m_ptr->release();
			if (!ret) {
				m_ptr = 0;
			}
		}
		return ret;
	}

	_Type* forget () {
		_Type* ret = 0;
		if (m_ptr) {
			if (m_ptr->ref_count() == 1) {
				ret = m_ptr;
				m_ptr = 0;
			} else {
				throw DataInUse();
			}
		} 
		
		return ret;	
	}

private:
	_Type* m_ptr;

private:
	inline bool operator < (const Var<_Type>& c) const;
	inline bool operator > (const Var<_Type>& c) const;
	inline bool operator == (const Var<_Type>& c) const;
	//needed by ArbitaryLess
	//inline bool operator != (const Var<_Type>& c) const;
};

typedef Var<IObject> IObject_var;
typedef Var<const IObject> IObject_cvar;

//#UC END# *4500152300FA_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_VAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
