////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::Folder_i
// ��������� ���������� ������ �������� ��� ��������� Folder
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"

namespace GblAdapterLib {

class Folder_i; // self forward Var
typedef ::Core::Var<Folder_i> Folder_i_var;
typedef ::Core::Var<const Folder_i> Folder_i_cvar;

class Folder_i_factory;

class Folder_i:
	virtual public Folder
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Folder_i)
	friend class Folder_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Folder_i (GblFolders::Folder* folder_content, FoldersNode* folders_node);

	virtual ~Folder_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void clear_content_folder () const;

	virtual GblFolders::Folder* get_content_folder () const;

private:
	// ��������� ��� ��� ����� �����
	virtual bool is_my () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GCI::IO::String_var m_comment;

	mutable GblFolders::Folder_var m_folder;

	FoldersNode_var m_folders_node;

	Containers::ContentID m_id;

	// ����� �� ��� �����
	mutable char m_is_external;

	// ��������� �� �����
	mutable char m_is_shared;

	mutable GCI::IO::String_var m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityBase
	// ��������� � ����  ���������� ��������� �������.
	// ��������� � � ����� ������������ �������
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// �������������
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// �������� �����������
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
	// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
	// ������ ����������.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// ������������ �������� ������� ���������.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from Folder
	// ����� �� ��������� �����
	virtual bool can_share () const;

	// implemented method from Folder
	// ��� ������� ������.
	// ������� ���� ��� ����� �������� ������� (�.�. �� ����������� � ������������� �������
	// ������������).
	virtual bool get_external () const;

	// implemented method from Folder
	// ��� ������� ������. ������� ���� ��� ����� �������� �������������, �.� ������� ������
	// �������������.
	// ����. ������� ����� ����� �������� ��������������.
	// ��� ������� �������� ������ ������� � ������� ����� ������������ ���������� ConstantModify.
	virtual bool get_shared () const;

	virtual void set_shared (bool shared);

	// implemented method from NamedElement
	// �����������
	virtual const GCI::IO::String& get_comment () const;
	virtual GCI::IO::String& get_comment ();

	virtual void set_comment (GCI::IO::String* comment);

	// implemented method from NamedElement
	// ���
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);
}; // class Folder_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
