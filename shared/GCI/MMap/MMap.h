////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/MMap/MMap.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::MMap
//
// ���������� ��� ������ � ������, ��� � ������� (mmap)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAP_H__
#define __SHARED_GCI_MMAP_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace MMap {

// 64-������ ������
typedef unsigned long long LongSize;

// ��������� ������
class SysError : public ::Core::Exception {
public:
	SysError (unsigned long code, const std::string& file_name, const std::string& op_name);

	virtual ~SysError () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual unsigned long get_code () const;

	virtual const std::string& get_file_name () const;

	virtual void set_file_name (const std::string& file_name);

	virtual const std::string& get_op_name () const;

private:
	mutable char m_message[256];
	// ��� ��������� ������
	unsigned long m_code;
	// ��� ����-�����
	std::string m_file_name;
	// ��� API ������� ��������� ������
	std::string m_op_name;
};

class Memory;
typedef ::Core::Var<Memory> Memory_var;
typedef ::Core::Var<const Memory> Memory_cvar;
// ������� ����������� ������ ���������� �� ����
// (����������: ��-����� ������� ���������� � �����������)
class Memory
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ������ ������� ��������� ������ - ������ ���� ����� ������ ��������������
	// �������� ��� ������.
	virtual const void* get_base_addr () const = 0;
	virtual void* get_base_addr () = 0;

	// ����� ����� ���������
	virtual const ACE_HANDLE get_file_handle () const = 0;

	// ���������� ������ �����  mmap-������� �� ����
	virtual void flush () /*throw (SysError)*/ = 0;

	// ���������� ���� � �������� ���� �������� ������ Memory
	virtual const std::string get_file_name () const = 0;

	// ���������� �������� � ����� ��� ����������� �����.
	virtual LongSize get_file_offset () const = 0;

	// ���������� ������ ���������� �������
	virtual const size_t get_view_size () const = 0;
};

class FileForMem;
typedef ::Core::Var<FileForMem> FileForMem_var;
typedef ::Core::Var<const FileForMem> FileForMem_cvar;
// ������������� ������ ����������� ����� ��� ������� (��� ��������, �������������, ���������
// ������� � �.�.). ������������ ��� ��������� �������� ������ (Memory)
class FileForMem
	: virtual public ::Core::IObject
{

	// forward decls for friend interface's servant
	friend class FileForMemConstWrapper;
public:
	// ���������� �����
	virtual const ACE_HANDLE get_file_handle () const = 0;

	// ��������� �������� ������ - �������� �� ������ ����� ������� � �������� ����� �����������
	// ������� ���������� ������ (Memory), �.�. ������ � ��� ������� ����� ������������� �� ��������
	// ��������� ��� ��������.
	// ����� ���� ������� ���� � ������ ����� ���� �����-�� ��������� ���������� �� ���������������
	// ��� �������� ������� � ������ ��� ���� �� ������� ���������� "������" �� ����������� ����������
	// .
	virtual LongSize get_memory_offset () const = 0;

	virtual void set_memory_offset (LongSize memory_offset) = 0;

	// ���������� ����� ������, ��������������� ��������� �������� � �������. ������ ��������� �����
	// ������ � ���������� � ������ ���-����� �� ���������� ��������. ����� ��������� �������� �
	// �������� base_addr �������� ���������� ����� ���������� �������.
	virtual const Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset) const = 0;
	virtual Memory* get_memory (LongSize offset, size_t size, size_t& inside_offset) = 0;

	// ���������� ��� �����
	virtual const std::string& get_file_name () const = 0;

	// ���������� ������ �����
	virtual LongSize get_file_size () const = 0;

	// ����������� ������ �����
	virtual void resize_file (LongSize offset) = 0;

//upgrade rw method
	virtual void upgrade_rw () = 0;
};

/// factory interface for FileForMem
class FileForMemFactory {
public:
	// ��������� � ��������� ����� ��������� ����
	static FileForMem* open (const char* file_name, unsigned long flags, size_t file_increase)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;

	static const FileForMem* open_ro (const char* file_name, unsigned long flags, size_t file_increase)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;

	// ������� ����� (��� ��������� ������������) ���� ������������� ��� ����������� ������ � ��������
	// �������� � �������� ���
	static FileForMem* create (const char* file_name, LongSize size, unsigned long flags)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, SysError)*/;
};

class LargeMemory;
typedef ::Core::Var<LargeMemory> LargeMemory_var;
typedef ::Core::Var<const LargeMemory> LargeMemory_cvar;
// �������������������� (����������� � ������ ������� ����) ������ ��������������� ������ � �������
// ������ (Memory) � ����. ���������� ��������� ������ � ����� ����-������
class LargeMemory
	: virtual public ::Core::IObject
{
public:
	// �������������� ������ ���������� ������ ����-����
	virtual const FileForMem& get_map_file () const = 0;
	virtual FileForMem& get_map_file () = 0;

	// ���������� ����� ������, �������������� ���������� �������� (��������� �������� ��������������
	// ��������� ������ ����). � out ��������� ���������� �������� �� ������ ����������� �����
	// (Memeory::base_addr) �� ���������.
	virtual const Memory* get_memory (LongSize offset, size_t& inside_offset) const = 0;
	virtual Memory* get_memory (LongSize offset, size_t& inside_offset) = 0;

	// ������������� ������ �������� �������������� ���� ���������� ������
	virtual const size_t get_page_size () const = 0;

	// ��������� ������� �����, ����������� ����� ����� get_memory()
	virtual const Memory* get_system_memory () const = 0;
	virtual Memory* get_system_memory () = 0;
};

class MemoryPool;
typedef ::Core::Var<MemoryPool> MemoryPool_var;
typedef ::Core::Var<const MemoryPool> MemoryPool_cvar;
// ��� ������� ��������� ������, ��������� �� �������� �����, ����������� �������� ���� ���
// ��������� 32 �������� ������������ �� ����������. ����� ��� ����� ���������� ������ � 64-
// ��������� �������������.
class MemoryPool
	: virtual public ::Core::IObject
{
public:
	// ������������ ������ ���� - ������������ ������ ����������� ������,
	// ������� ����� ���� ����������� ��� �������� ���� ������.
	virtual const size_t get_pool_size () const = 0;

	virtual void set_pool_size (size_t pool_size) = 0;

	// ������������������� ������� ������, ��������� � ��������� ��������� ����-������. ���� ����
	// ����� �������� � ���, ������ � ���� ����� "������" �� �������� ���������� �������. ���� ������
	// = 0 (��� ������ ��������� ��������), �� ������� ������ �� ���������. ��� ������� �����������
	// ����� ����������� ���� - ����������.
	virtual const LargeMemory* get_large_memory (const FileForMem* file, size_t page_size, bool regulary_segmentation) const = 0;
	virtual LargeMemory* get_large_memory (FileForMem* file, size_t page_size, bool regulary_segmentation) = 0;
};

/// factory interface for MemoryPool
class MemoryPoolFactory {
public:
	// ���������� ��������� ����������� ����
	static MemoryPool& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������� ����
static const size_t DEFAULT_MAX_POOL_SIZE = 650117120; // ������������ ������ ���� �� ���������(����������, ���� �������� �� ��� ����� ����� �������)

// ������ ����������� �������� ���������� Memory
static const unsigned long DEFAULT_FLUSH_COUNT = 40; // ���������� ������� ������� FlushViewOfFile ��� ������ ����������� ������  �� ����
static const unsigned long DEFAULT_FLUSH_TIMEOUT = 500; // ����� �������� ����� ��������� �������� �������� ���������� ������  �� ���� � ������������

} // namespace MMap
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::MMap::FileForMem> {
	typedef GCI::MMap::FileForMemFactory Factory;
};
template <>
struct TypeTraits <GCI::MMap::MemoryPool> {
	typedef GCI::MMap::MemoryPoolFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_MMAP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
