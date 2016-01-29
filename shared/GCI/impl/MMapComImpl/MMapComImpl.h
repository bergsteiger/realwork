////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MMapComImpl/MMapComImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::GCI::MMapComImpl
//
// �������������������� ����� ���������� MMAP
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPCOMIMPL_H__
#define __SHARED_GCI_MMAPCOMIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCI/MMap/MMap.h"


#if defined(WIN32)
namespace GCI {
namespace MMapComImpl {

class PoolListHandler;
typedef ::Core::Var<PoolListHandler> PoolListHandler_var;
typedef ::Core::Var<const PoolListHandler> PoolListHandler_cvar;
// ��������� ������� � ������ ������������� �������� ������,
// ������������ � ���������� ���������� LargeMemory.
class PoolListHandler
	: virtual public MMap::MemoryPool
{
public:
	// ��������� �������� ����� ������ � ������
	virtual void set_memory (MMap::Memory* memory) = 0;

	// ���������� ���������� ����� ������ �� ������ �� ���������
	// �������� � ����� - offset.
	virtual MMap::Memory* get_memory (MMap::LongSize offset, HANDLE file_handle) const = 0;
};

/// factory interface for PoolListHandler
class PoolListHandlerFactory {
public:
	// ���������� ��������� ����������� ����
	static PoolListHandler& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����� ��� ���� ������ ������ ������ ���������� ������ ������,
// ������� ����������� ��� �������� ������ � MemoryPool
typedef std::vector < MMap::Memory_var > MemoryList;

} //namespace MMapComImpl
} // namespace GCI


#endif //WIN32
#endif //__SHARED_GCI_MMAPCOMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

