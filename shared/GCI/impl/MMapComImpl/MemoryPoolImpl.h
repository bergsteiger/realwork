////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MMapComImpl/MemoryPoolImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapComImpl::MemoryPoolImpl
// ��������� ���������� ������ �������� ��� ��������� PoolListHandler
//
// ���������� ����.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

class MemoryPoolImpl; // self forward Var
typedef ::Core::Var<MemoryPoolImpl> MemoryPoolImpl_var;
typedef ::Core::Var<const MemoryPoolImpl> MemoryPoolImpl_cvar;

class MemoryPoolImpl_factory;

// ���������� ����.
class MemoryPoolImpl:
	virtual public PoolListHandler
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MemoryPoolImpl)
	friend class MemoryPoolImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MemoryPoolImpl ();

	virtual ~MemoryPoolImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ������ ���� ���������� ����������� ������ � ����.
	size_t m_current_pool_size;

	// ������������� ������
	size_t m_granularity;

	// ������������ ������ ���� - ������������ ������ ����������� ������,
	// ������� ����� ���� ����������� ��� �������� ���� ������.
	size_t m_max_pool_size;

	// ����� ��� ���� ������ ������ ������ ���������� ������ ������,
	// ������� ����������� ��� �������� ������ � MemoryPool
	mutable MemoryList m_memory_list;

	// ������� ��� ������������� ������� � ������ ����
	mutable Core::Mutex m_pool_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const MemoryList& get_memory_list () const;

	virtual void set_memory_list (const MemoryList& memory_list) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::MemoryPool
	// ������������������� ������� ������, ��������� � ��������� ��������� ����-������. ���� ����
	// ����� �������� � ���, ������ � ���� ����� "������" �� �������� ���������� �������. ���� ������
	// = 0 (��� ������ ��������� ��������), �� ������� ������ �� ���������. ��� ������� �����������
	// ����� ����������� ���� - ����������.
	virtual const MMap::LargeMemory* get_large_memory (const MMap::FileForMem* file, size_t page_size, bool regulary_segmentation) const;
	virtual MMap::LargeMemory* get_large_memory (MMap::FileForMem* file, size_t page_size, bool regulary_segmentation);

	// implemented method from MMap::MemoryPool
	// ������������ ������ ���� - ������������ ������ ����������� ������,
	// ������� ����� ���� ����������� ��� �������� ���� ������.
	virtual const size_t get_pool_size () const;

	virtual void set_pool_size (size_t pool_size);

	// implemented method from PoolListHandler
	// ���������� ���������� ����� ������ �� ������ �� ���������
	// �������� � ����� - offset.
	virtual MMap::Memory* get_memory (MMap::LongSize offset, HANDLE file_handle) const;

	// implemented method from PoolListHandler
	// ��������� �������� ����� ������ � ������
	virtual void set_memory (MMap::Memory* memory);
}; // class MemoryPoolImpl

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_MEMORYPOOLIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
