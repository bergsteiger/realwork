////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/MMapWin32/FileForMemImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::MMapWin32::FileForMemImpl
// ��������� ���������� ������ �������� ��� ��������� FileForMem
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_H__
#define __SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/MMap/MMap.h"
#include "shared/GCI/impl/MMapWin32/MMapWin32.h"

//#UC START# *4972185901BE_CUSTOM_INCLUDES*
//#UC END# *4972185901BE_CUSTOM_INCLUDES*

#if defined(WIN32) && defined(_WIN32_WINNT) && (_WIN32_WINNT >= 0x0500)
namespace GCI {
namespace MMapWin32 {

class FileForMemImpl; // self forward Var
typedef ::Core::Var<FileForMemImpl> FileForMemImpl_var;
typedef ::Core::Var<const FileForMemImpl> FileForMemImpl_cvar;

class FileForMemImpl_factory;

class FileForMemImpl:
	virtual public MMap::FileForMem
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FileForMemImpl)
	friend class FileForMemImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileForMemImpl (const char* file_name, unsigned long flags, size_t file_increase, bool ro_mode);

	FileForMemImpl (const char* file_name, MMap::LongSize size, unsigned long flags);

	virtual ~FileForMemImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������ map �� ��� ���������������� ������
	virtual const MMap::Memory* map_i (
		MMap::LongSize offset
		, size_t size
		, DWORD access_flags
		, size_t& inside_offset
	) const /*throw (
		MMap::SysError
	)*/;

private:
	// ����������� ������ ���� (���� ����� � �����) � ������ ���
	virtual void open_and_map ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	FileHandle m_file;

	// ��������, �� ������� ����� ������������� �������� ���� � ������ �������� �����.
	size_t m_file_increase;

	// ���������� ������� �������� ������ �� ����
	unsigned long m_flush_count;

	// ����� �������� ����� ��������� �������� ������ ������ �� ���� � ������������
	unsigned long m_flush_timeout;

	OpenFileInfo m_info;

	MapObjectID m_map_object_id;

	bool m_ro_mode;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual unsigned long get_flush_count () const;

	virtual void set_flush_count (unsigned long flush_count);

	virtual unsigned long get_flush_timeout () const;

	virtual void set_flush_timeout (unsigned long flush_timeout);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MMap::FileForMem
	// ���������� �����
	virtual const ACE_HANDLE get_file_handle () const;

	// implemented method from MMap::FileForMem
	// ���������� ��� �����
	virtual const std::string& get_file_name () const;

	// implemented method from MMap::FileForMem
	// ���������� ������ �����
	virtual MMap::LongSize get_file_size () const;

	// implemented method from MMap::FileForMem
	// ���������� ����� ������, ��������������� ��������� �������� � �������. ������ ��������� �����
	// ������ � ���������� � ������ ���-����� �� ���������� ��������. ����� ��������� �������� �
	// �������� base_addr �������� ���������� ����� ���������� �������.
	virtual const MMap::Memory* get_memory (MMap::LongSize offset, size_t size, size_t& inside_offset) const;
	virtual MMap::Memory* get_memory (MMap::LongSize offset, size_t size, size_t& inside_offset);

	// implemented method from MMap::FileForMem
	// ��������� �������� ������ - �������� �� ������ ����� ������� � �������� ����� �����������
	// ������� ���������� ������ (Memory), �.�. ������ � ��� ������� ����� ������������� �� ��������
	// ��������� ��� ��������.
	// ����� ���� ������� ���� � ������ ����� ���� �����-�� ��������� ���������� �� ���������������
	// ��� �������� ������� � ������ ��� ���� �� ������� ���������� "������" �� ����������� ����������
	// .
	virtual MMap::LongSize get_memory_offset () const;

	virtual void set_memory_offset (MMap::LongSize memory_offset);

	// implemented method from MMap::FileForMem
	// ����������� ������ �����
	virtual void resize_file (MMap::LongSize offset);

protected:
	virtual void upgrade_rw ();

//#UC START# *4972185901BE*
//#UC END# *4972185901BE*
}; // class FileForMemImpl

} // namespace MMapWin32
} // namespace GCI


#endif //WIN32 && _WIN32_WINNT>=0x0500
#endif //__SHARED_GCI_MMAPWIN32_FILEFORMEMIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
