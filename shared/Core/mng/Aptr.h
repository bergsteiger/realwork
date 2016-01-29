////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/Aptr.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::Aptr
//
// менеджер указателей - автопоинтер (автоматическое удаление)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_APTR_H__
#define __SHARED_CORE_MNG_APTR_H__

#include "ace/ACE.h"
#include "shared/Core/mng/TypeDestructors.h"
#include "shared/Core/mng/PtrGuard.h"
#include "shared/Core/sys/IObject.h"
#include "shared/Core/sys/assert.h"


//#UC START# *450029C102BF_USER_INCLUDES*
#include "shared/GCL/meta/static_check.h"
#include "shared/GCL/meta/is_base_of.h"
/* //////////////////// EXAMPLE ////////////////////////////

  /EX1: Use as simple auto-destructor

  func_destructor (MyData* d) {
	// use Aptr if MyData not inherited from IObject and dont pass throu function or dont managed by any containers
	MyData* d = new MyData (...);
	Core::Aptr<MyData> data (d); // take control, free after use
	
	// or use Box if MyData not inherited from IObject and pass throu functions or managed by any containers
	// or use Var if MyData is a interface or servant
	
	...
  }

*/ 

//#UC END# *450029C102BF_USER_INCLUDES*

namespace Core {

//#UC START# *450029C102BF_USER_DEFINITION*
template <class _Type, class _Destructor = DeleteDestructor<_Type> >
class Aptr {
private:
	Aptr (const PtrGuard<_Type>& copy) {
		assert (0);
	}

	Aptr<_Type>& operator = (const PtrGuard<_Type>& copy) {
		assert (0);
	}

public:
	typedef _Type value_type;

	///////////////////////////
	// construction	
	///////////////////////////

	Aptr () : m_ptr(0) {
	}

	// take control
	Aptr (_Type* data) : m_ptr (data) {
	}

	// copy (capture)
	Aptr (const _Type& data) : m_ptr (new _Type (data)) {		
	} 

	// take control (capture)
	Aptr<_Type,_Destructor>& operator = (_Type* data) {
		if (m_ptr == data) {
			return *this;
		}
		this->release ();
		m_ptr = data;
	
 		return *this;
	}

	// copy (capture)
	Aptr<_Type,_Destructor>& operator = (const _Type& data) {
		this->release();
		m_ptr = new _Type (data);
 		return *this;
	}

public:
	// take control
	Aptr (const Aptr<_Type,_Destructor>& copy); // GARANT_PRIVATE is obsolete in this context

	// take control (capture)
	Aptr<_Type,_Destructor>& operator = (const Aptr<_Type,_Destructor>& copy); // GARANT_PRIVATE is obsolete in this context

public:
	virtual ~Aptr () {
		this->release ();
#ifdef _DEBUG
		STATIC_CHECK ((IS_BASE_OF (IObject, _Type) != true), APTR_CANNOT_BE_INSTANTITED_BY_REFCOUNTED_OBJECT);
#endif
	}

	///////////////////////////
	// access by pointer	
	///////////////////////////

	inline _Type* const operator -> () {
		GDS_ASSERT (m_ptr);
		return m_ptr;
	}

	inline _Type const* const operator -> () const {
		GDS_ASSERT (m_ptr);
		return m_ptr;
	}

	inline _Type* const ptr () {
		return m_ptr;
	}

	inline _Type const* const ptr () const {
		return m_ptr;
	}
	
	///////////////////////////
	// acess by reference
	///////////////////////////

	inline _Type& operator * () {
		if (!m_ptr) {
			m_ptr = new _Type;
		}
		return *m_ptr;
	}

	inline const _Type& operator * () const {
		GDS_ASSERT (m_ptr);
		return *m_ptr;
	}
	
	/////////////////////////
	// transfering opertaor
	/////////////////////////

	inline _Type* _retn () {
		_Type* val = m_ptr;
		m_ptr = 0;
		return val;
	}

	inline const _Type* _retn () const {
		_Type* val = m_ptr;
		m_ptr = 0;
		return val;
	}

	inline _Type* in () { //????
		return m_ptr;
	}

	inline const _Type* in () const {
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

	_Type* forget () {
		_Type* ret = m_ptr;
		m_ptr = 0;		
		return ret;	
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

	inline bool operator < (const Aptr<_Type,_Destructor>& c) const { // GCC_MAYBE_COMPILE_ERROR (builtin GCC operator)
		return /*m_ptr && c.m_ptr ? *m_ptr < *c.m_ptr : */m_ptr < c.m_ptr;
	}

	inline bool operator > (const Aptr<_Type,_Destructor>& c) const {
		return m_ptr && c.m_ptr ? *m_ptr > *c.m_ptr : m_ptr > c.m_ptr;
	}

	inline bool operator == (const Aptr<_Type,_Destructor>& c) const {
		return m_ptr && c.m_ptr ? *m_ptr == *c.m_ptr : m_ptr == c.m_ptr;
	}

	inline bool operator != (const Aptr<_Type,_Destructor>& c) const {
		return m_ptr && c.m_ptr ? *m_ptr != *c.m_ptr : m_ptr != c.m_ptr;
	}

	inline unsigned long release () {
		if (m_ptr) {
			_Destructor::destroy (m_ptr);			
			m_ptr = 0;			
		}
		return 0;
	}

private:
	_Type* m_ptr;
};

//#UC END# *450029C102BF_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_APTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
