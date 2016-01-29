////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::MemStream_i
// Заголовок реализации класса серванта для интерфеса MemoryStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocal.h"

//#UC START# *4627347F01F4_CUSTOM_INCLUDES*
#include "shared/Core/mng/PoolMemoryManager.h"
//#UC END# *4627347F01F4_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class MemStream_i; // self forward Var
typedef ::Core::Var<MemStream_i> MemStream_i_var;
typedef ::Core::Var<const MemStream_i> MemStream_i_cvar;

class MemStream_i_factory;

class MemStream_i:
	virtual public MemoryStream
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemStream_i)
	friend class MemStream_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MemStream_i (const OctetSeq& data, bool with_copy);

	virtual ~MemStream_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void copy (const OctetSeq& data);


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GCI::IO::Stream
	// Если возвращается true, дальнейшая работа с потоком невозможна
	virtual bool bad () const;

	// implemented method from GCI::IO::Stream
	// Чистит флаги потока
	virtual void clear ();

	// implemented method from GCI::IO::Stream
	// Копирует данные из одного потока в другой.
	virtual void copy_to (
		GCI::IO::Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		GCI::IO::OperationError
	)*/;

	// implemented method from GCI::IO::Stream
	// Функция возвращает true если достигнут конец потока.
	virtual bool eof () const;

	// implemented method from GCI::IO::Stream
	// Прочесть данные из потока, возвращает количество прочитанных байтов.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (GCI::IO::OperationError)*/;

	// implemented method from GCI::IO::Stream
	// Переместить маркер потока. Возвращает число байт от начала потока.
	virtual unsigned long seek (
		long offset
		, unsigned long whence
	) /*throw (
		GCI::IO::OperationError
		, GCI::IO::NotImplemented
	)*/;

	// implemented method from GCI::IO::Stream
	// Записать данные в поток. Возвращает количество записанных байтов.
	virtual unsigned long write (const void* buffer, unsigned long size);

//#UC START# *4627347F01F4*
public:
	void* operator new (size_t cs);
	void operator delete (void* p);

private:
	typedef unsigned char BufferType;

	static const unsigned POOL_PAGE_SIZE = 32;

	template <size_t n_> inline BufferType* malloc_in_pool () {
		return reinterpret_cast <BufferType*> (
			Core::PoolMemoryManager<char [n_], POOL_PAGE_SIZE>::PoolMemoryManagerSingleton::instance()->malloc(n_)
		);
	}
	template <size_t n_> inline void free_in_pool (BufferType* __p) {
		Core::PoolMemoryManager<char [n_], POOL_PAGE_SIZE>::PoolMemoryManagerSingleton::instance()->free (__p);
	}

	inline BufferType* alloc_buffer (unsigned n_) {
		if (n_ == 0) {
			return 0;
		} else if (n_ == 4) {
			return this->malloc_in_pool<4>();
		} else if (n_ <= 13) {
			return this->malloc_in_pool<13>();
		} else if (n_ <= 17) {
			return this->malloc_in_pool<17>();
		} else if (n_ <= 23) {
			return this->malloc_in_pool<23>();
		} else if (n_ <= 41) {
			return this->malloc_in_pool<41>();
		} else if (n_ <= 50) {
			return this->malloc_in_pool<50>();
		} else if (n_ <= 57) {
			return this->malloc_in_pool<57>();
		} else if (n_ <= 66) {
			return this->malloc_in_pool<66>();
		} else if (n_ <= 81) {
			return this->malloc_in_pool<81>();
		} else if (n_ <= 99) {
			return this->malloc_in_pool<99>();
		} else if (n_ <= 125) {
			return this->malloc_in_pool<125>();
		} else if (n_ <= 142) {
			return this->malloc_in_pool<142>();
		} else if (n_ <= 240) {
			return this->malloc_in_pool<240>();
		} else if (n_ <= 512) {
			return this->malloc_in_pool<512>();
		} else if (n_ <= 1000) {
			return this->malloc_in_pool<1000>();
		} else if (n_ <= 4000) {
			return this->malloc_in_pool<4000>();
		} else {
			return new BufferType [n_];
		}
	}

	inline void free_buffer (BufferType* __p, unsigned n_) {
		if (n_ == 0) {
			return;
		} else if (n_ == 4) {
			this->free_in_pool<4>(__p);
		} else if (n_ <= 13) {
			this->free_in_pool<13>(__p);
		} else if (n_ <= 17) {
			this->free_in_pool<17>(__p);
		} else if (n_ <= 23) {
			this->free_in_pool<23>(__p);
		} else if (n_ <= 41) {
			this->free_in_pool<41>(__p);
		} else if (n_ <= 50) {
			this->free_in_pool<50>(__p);
		} else if (n_ <= 57) {
			this->free_in_pool<57>(__p);
		} else if (n_ <= 66) {
			this->free_in_pool<66>(__p);
		} else if (n_ <= 81) {
			this->free_in_pool<81>(__p);
		} else if (n_ <= 99) {
			this->free_in_pool<99>(__p);
		} else if (n_ <= 125) {
			this->free_in_pool<125>(__p);
		} else if (n_ <= 142) {
			this->free_in_pool<142>(__p);
		} else if (n_ <= 240) {
			this->free_in_pool<240>(__p);
		} else if (n_ <= 512) {
			this->free_in_pool<512>(__p);
		} else if (n_ <= 1000) {
			this->free_in_pool<1000>(__p);
		} else if (n_ <= 4000) {
			this->free_in_pool<4000>(__p);
		} else {
			return delete[] __p;
		}
	}

	//Core::Aptr<BufferType> m_buf;
	BufferType* m_buf;
	bool m_without_copy;
	unsigned long m_len;
	unsigned long m_pos;

public:	
	std::string dump_hex () const;
	std::string dump_ascii () const;
	
//#UC END# *4627347F01F4*
}; // class MemStream_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
