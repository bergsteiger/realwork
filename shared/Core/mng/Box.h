////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mng/Box.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::mng::Box
//
// менеджер с собственным счетчиком ссылок, для типов не обладающих оным
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_MNG_BOX_H__
#define __SHARED_CORE_MNG_BOX_H__

#include "ace/ACE.h"
#include "shared/Core/mng/TypeDestructors.h"
#include "shared/Core/mng/PtrGuard.h"
#include "shared/Core/sys/Exception.h"
#include "shared/Core/sys/IObject.h"

//#UC START# *45001507004E_USER_INCLUDES*
#include "shared/GCL/meta/static_check.h"
#include "shared/GCL/meta/is_base_of.h"

/* //////////////////// EXAMPLE ////////////////////////////

  /EX1: Use as simple auto-destructor

  func_destructor (MyData* d) {
	// use Box if MyData not inherited from IObject and pass throu functions or managed by any containers
	MyData* d = new MyData (...);
	Core::Box<MyData> data (d); // take control, free after use
	
	// or use Aptr if MyData dont pass throu function or dont managed by any containers
	// or use Var if MyData is a interface or servant
	
	...
  }

*/

//#UC END# *45001507004E_USER_INCLUDES*

namespace Core {

//#UC START# *45001507004E_USER_DEFINITION*
class IBoxBase {
public:
	virtual IObject* get_raw_node() const = 0;
};

template <class _Type, class _Destructor = DeleteDestructor<_Type>, bool allow_use_on_refcounted = false >
class Box: public IBoxBase {
public:
	class DataInUse : public Exception {
		virtual const char* uid () const /*throw ()*/ {
			return "Core::Box::DataInUse";
		}
	};

public:
	typedef _Type value_type;

	static inline Box<_Type,_Destructor,allow_use_on_refcounted> narrow (const IBoxBase& box) {
		return Box<_Type,_Destructor,allow_use_on_refcounted> (dynamic_cast<Node*> (box.get_raw_node()));
	}

	static inline _Type* _duplicate (const Box& box) {
		box->addref();
		return box.m_node->ptr;
	}

private:
	Box (const PtrGuard<_Type>& copy) {
		assert (0);
	}

	Box<_Type>& operator = (const PtrGuard<_Type>& copy) {
		assert (0);
	}

public:	
	///////////////////////////
	// construction	
	///////////////////////////

	Box () : m_node(new Node(0)) {
	}

	// take control
	Box (_Type* data) : m_node (new Node(data)) {
	}

	// copy
	Box (const _Type& data) : m_node (new Node(new _Type(data))) {
	} 

	// take control
	Box (const Box<_Type,_Destructor,allow_use_on_refcounted>& copy) {
		m_node = copy.m_node;
		this->addref();
	}

	// take control (capture)
	Box<_Type,_Destructor,allow_use_on_refcounted>& operator = (const Box<_Type,_Destructor,allow_use_on_refcounted>& copy) {
		if (m_node == copy.m_node) {
			return *this;
		}
		this->release ();		
		m_node = copy.m_node;
		this->addref();
		return *this;
	}

	// take control (capture)
	Box<_Type,_Destructor,allow_use_on_refcounted>& operator = (_Type* data) {
		if (m_node && (m_node->ptr == data)) {
			return *this;
		}
		this->release ();
		m_node = new Node (data);
 		return *this;
	}

	 // copy (capture)	
	Box<_Type,_Destructor,allow_use_on_refcounted>& operator = (const _Type& data) {
		this->release ();
		m_node = new Node(new _Type (data));
		//this->addref();
 		return *this;
	}

	// take control (override)
	void replace (_Type* data) { 
		if (m_node) {
			if (m_node->ptr == data) {
				return;
			}
			m_node->delete_data();		
			m_node->ptr = data;
		} else {
			m_node = new Node (data);
		}
	}

	// copy (override)
	void replace (const _Type& data) {
		if (m_node) {
			if (m_node->ptr == &data) {
				return;
			}
			
			m_node->delete_data();
			m_node->ptr = new _Type(data);
		} else {
			m_node = new Node (new _Type(data));
		}
	}

	// lost control if ref_count = 1
	_Type* forget () {
		_Type* ret = 0;
		if (m_node) {
			if (m_node->ref_count() == 1) {
				ret = m_node->ptr;
				m_node->ptr = 0;
				delete m_node;				
				m_node = 0;
			} else {
				throw DataInUse();
			}
		} 
		
		return ret;	
	}
	
	void reset () {
		this->release ();
		m_node = new Node(0);
	}

	virtual ~Box () {
		this->release ();
#ifdef _DEBUG
		STATIC_CHECK ((IS_BASE_OF (IObject, _Type) != true || allow_use_on_refcounted), BOX_CANNOT_BE_INSTANTITED_BY_REFCOUNTED_OBJECT);
#endif
	}

	///////////////////////////
	// access by pointer	
	///////////////////////////

	inline _Type* operator -> () {
		assert (m_node && m_node->ptr);
		return m_node->ptr;
	}

	inline _Type const* operator -> () const {
		assert (m_node && m_node->ptr);
		return m_node->ptr;
	}

	inline _Type* ptr () {
		return m_node ? m_node->ptr : 0;
	}

	inline _Type const* ptr () const {
		return m_node ? m_node->ptr : 0;
	}
	
	///////////////////////////
	// acess by reference
	///////////////////////////

	inline _Type& operator * () {
		if (m_node == 0) {
			m_node = new Node (0);
		}
		if (!m_node->ptr) {
			m_node->ptr = new _Type;
		}
		return *m_node->ptr;
	}

	inline _Type const& operator * () const {
		assert (m_node && m_node->ptr);
		return *m_node->ptr;
	}

	/////////////////////////
	// transfering opertaor
	/////////////////////////

	inline _Type* in () {
		return m_node ? m_node->ptr : 0;
	}

	inline _Type const* in () const {
		return m_node ? m_node->ptr : 0;
	}

	inline _Type*& out () {
		this->reset ();
		return m_node->ptr;
	}

	inline _Type*& inout () {
		if (m_node == 0) {
			m_node = new Node (0);
		}
		return m_node->ptr;
	}

	/////////////////////////
	// logic opertaor
	/////////////////////////

	inline bool is_nil () const {
		return m_node ? (m_node->ptr == 0) : true;
	}

	inline const bool operator ! () const {
		return m_node->ptr == 0;
	}

	inline bool operator == (const Box<_Type,_Destructor,allow_use_on_refcounted>& c) const {
		if (m_node == 0) {
			m_node = new Node (0);
		}
		return m_node->ptr && c.m_node->ptr ? *m_node->ptr == *c.m_node->ptr : m_node->ptr == c.m_node->ptr;
	}

	///////////////////////////
	// ref counting
	///////////////////////////
	
	inline unsigned long ref_count () const {
		if (m_node) {
			return m_node->ref_count();
		} else {
			return 0;
		}
	}

	inline unsigned long addref () { 
		if (m_node) {
			return m_node->addref();
		} else {
			return 0;
		}
	}

	inline unsigned long release () {
		unsigned long ret = 0;
		if (m_node) {
			ret = m_node->release();
			if (!ret) {
				m_node = 0;
			}
		}
		return ret;
	}


protected:
	struct Node : public RefCountObjectBase {
		_Type* ptr;

	public:
		Node (_Type* p) {
			ptr = p;
		} 
		
		~Node () {
			this->delete_data();
		}

		inline void delete_data () {
			if (ptr) {
				_Destructor::destroy (ptr);
				ptr = 0;
			}
		}
	};

protected:
	Box (Node* copy) {
		m_node = copy;
		this->addref();
	}

	virtual IObject* get_raw_node() const {
		return m_node;
	}

private:
	mutable Node* m_node;
};

//#UC END# *45001507004E_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_MNG_BOX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
