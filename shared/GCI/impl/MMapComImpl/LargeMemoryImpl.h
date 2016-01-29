////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MMapComImpl/LargeMemoryImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCI::MMapComImpl::LargeMemoryImpl
//
// ���������� ������ "������� ������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"
#include "shared/GCI/impl/MMapComImpl/MMapComImpl.h"

#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

// ���������� ������ "������� ������"
class LargeMemoryImpl;
typedef Core::Var<LargeMemoryImpl> LargeMemoryImpl_var;
typedef Core::Var<const LargeMemoryImpl> LargeMemoryImpl_cvar;

class LargeMemoryImpl :
	virtual public MMap::LargeMemory
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LargeMemoryImpl)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ����������� � ���������� PoolListHandler
	LargeMemoryImpl (
		const MMap::FileForMem* file
		, PoolListHandler* pool_list_handler
		, size_t page_size
		, size_t granularity
		, bool regulary_segmentation
	);

public:
	virtual ~LargeMemoryImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������� ����� ��� ������� LargeMemory ����, ��������� ��� ���������
	// ������ Memory
	MMap::FileForMem_cvar m_file;

	// ������������� ������
	size_t m_granularity;

	// ������ ������ ��� ��������
	size_t m_page_size;

	// ��������� ��������������� ������ ������ �� ������� MemoryPool
	mutable PoolListHandler_var m_pool_list_handler;

	// ���� ��������� ����� �� ������ ����������� ��������� ��� ������� �����.
	bool m_regulary_segmentation;

	// �������������� ��������� ������� �����.
	mutable MMap::Memory_cvar m_system_memory;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::LargeMemory
	// �������������� ������ ���������� ������ ����-����
	virtual const MMap::FileForMem& get_map_file () const;
	virtual MMap::FileForMem& get_map_file ();

	// implemented method from MMap::LargeMemory
	// ���������� ����� ������, �������������� ���������� �������� (��������� �������� ��������������
	// ��������� ������ ����). � out ��������� ���������� �������� �� ������ ����������� �����
	// (Memeory::base_addr) �� ���������.
	virtual const MMap::Memory* get_memory (MMap::LongSize offset, size_t& inside_offset) const;
	virtual MMap::Memory* get_memory (MMap::LongSize offset, size_t& inside_offset);

	// implemented method from MMap::LargeMemory
	// ������������� ������ �������� �������������� ���� ���������� ������
	virtual const size_t get_page_size () const;

	// implemented method from MMap::LargeMemory
	// ��������� ������� �����, ����������� ����� ����� get_memory()
	virtual const MMap::Memory* get_system_memory () const;
	virtual MMap::Memory* get_system_memory ();
}; // class LargeMemoryImpl

} // namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_LARGEMEMORYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

