////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersNode_i
// ��������� ���������� ������ �������� ��� ��������� FoldersNode
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.h"

//#UC START# *457050AC03A9_CUSTOM_INCLUDES*
//#UC END# *457050AC03A9_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class FoldersManager_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FoldersNode_i; // self forward Var
typedef ::Core::Var<FoldersNode_i> FoldersNode_i_var;
typedef ::Core::Var<const FoldersNode_i> FoldersNode_i_cvar;

class FoldersNode_i_factory;

class FoldersNode_i:
	virtual public FoldersNode
	, virtual public StaticNode_i
{
	SET_OBJECT_COUNTER (FoldersNode_i)
	friend class FoldersNode_i_factory; // self factory
	friend class FoldersManager_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	static const unsigned long MAX_TREE_DEPTH;


	class ContentTypeConvertor : 
		public Core::UnsortedTypeConverter<Containers::ContentType, FoldersItemType> {
		protected:
			void fill_array () {
				//#UC START# *461B7E39003E_FILL_ARRAY_IMPLEMENTATION*
				this->add (Defines::CT_DOC_BOOKMARK, FIT_BOOKMARK);
				this->add (Defines::CT_FOLDER, FIT_FOLDER);
				this->add (Defines::CT_SAVED_LIST, FIT_LIST);
				this->add (Defines::CT_CONSULTATION, FIT_CONSULTATION);
				this->add (Defines::CT_SAVED_QUERY, FIT_QUERY);
				this->add (Defines::CT_SAVED_PHARM_LIST, FIT_PHARM_LIST);
				this->add (Defines::CT_PHARM_BOOKMARK, FIT_PHARM_BOOKMARK);
				this->add (Defines::CT_HISTORY, FIT_OLD_HISTORY);
				//#UC END# *461B7E39003E_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ContentTypeConvertor

	typedef ACE_Singleton<ContentTypeConvertor, ACE_SYNCH_NULL_MUTEX> ContentTypeConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FoldersNode_i (Containers::Content* content, Folders* folders);

	virtual ~FoldersNode_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ����� ������� �� ��������������
	virtual FoldersNode* find_node_by_id (FolderId id) const;

	virtual GCD::PID get_document_pid () const;

	virtual GblFolders::Folder* get_folder ();

	// �������� ��� ����� "��� ���������"
	virtual bool is_my_documents () const;

	// ����� "��� ���������" ��� �� ����������
	virtual bool is_my_documents_or_lower () const;

	// ���������� �����, ����������
	virtual void load_children ();

	virtual void recalc_consultations_flag ();

	virtual void recalc_external_flag ();

	// �������� ���� flag2
	// ���������� ���������� �� �������� ��������� ������������� ����� from_node
	// ���������� true ���� ���� �� ���� �� ��������� ����� ���� flag1
	virtual bool recalc_node_flags (bool from_node, unsigned long flag1, unsigned long flag2);

	// �������� ����� NF_HAS_SHARED, NF_IN_SHARED
	// ���������� ���������� �� �������� ��������� ������������� ����� from_shared
	// ���������� true ���� ���� �� ���� �� ��������� ����� ���� NS_SHARED
	virtual bool recalc_shared_flags (bool from_shared);

	virtual void recursive_recalc_consultations_flag ();

	virtual void set_shared_flag (bool is_shared);

	// �������� ��� ���� �����
	virtual void update_children ();

	// �������� ���������� ����� ����
	virtual void update_content ();

private:
	// �������� �� ������� ���� ���������
	virtual bool is_bookmark () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_caption;

	mutable Containers::Content_var m_content;

	Containers::ContentType m_content_type;

	Date m_creation_date;

	mutable unsigned long m_flags;

	GblFolders::FolderElement_var m_folder_element;

	FoldersManager_i* m_folders_manager;

	GCI::IO::String_var m_hint;

	mutable Containers::ContentID m_id;

	mutable Query_var m_iquery;

	mutable GCI::IO::String_var m_m_short_doc_name;

	mutable Core::Box<GCD::PID> m_pid;

	mutable GCI::IO::String_var m_short_doc_name;

	mutable FoldersItemType m_type;

	mutable unsigned long m_under_control_status;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Controllable
	// ���������� true, ���� ��������� ���������� �� ��������
	virtual const bool get_can_set_to_control () const;

	// implemented method from Controllable
	// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
	// �������� � ���������� �������� �� ��������, � false �������������� � ������.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// implemented method from Controllable
	// ���������� ������� �������� ������� ���������.
	virtual unsigned long get_control_status ();

	// implemented method from Controllable
	// ��������� �������� �� ��������.
	virtual bool is_same_controllable (const Controllable* other);

	// implemented method from Controllable
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	// implemented method from Controllable
	// ���������� ������ ��������� � ����.
	virtual void reset_control_status ();

	// implemented method from Controllable
	// �������� ������� �� ��������.
	virtual const GCI::IO::String& get_short_name () const;
	virtual GCI::IO::String& get_short_name ();

	// implemented method from Controllable
	virtual ControlledItemType get_type () const;

	// implemented method from EntityStorage
	// �������� ���������
	virtual Containers::Content* get_cached_content () const;

	// implemented method from EntityStorage
	// �������� ��� �����������
	virtual Containers::ContentType get_content_type () const;

	// implemented method from FoldersNode
	// ��������� ����� �� � ���� ��������� ������ �� xml.
	virtual bool can_load_from_xml () const;

	// implemented method from FoldersNode
	// ��������� ����� �� ������������ ���� ��������� � xml.
	virtual bool can_save_consultation_to_xml () const;

	// implemented method from FoldersNode
	// ����� �� ���� ���� ��������� ��� ���������� ����������
	virtual bool can_save_to_integration_xml () const;

	// implemented method from FoldersNode
	// ��������� ����� �� ���� ���� ��������� � xml.
	virtual bool can_save_to_xml () const;

	// implemented method from FoldersNode
	// ���� ��������
	virtual const Date get_creation_date () const;

	// implemented method from FoldersNode
	virtual GCD::PID get_pid () const;

	// implemented method from FoldersNode
	// ������� ����
	virtual const FolderId get_id () const;

	// implemented method from FoldersNode
	// ��������� ���������� �� xml � ����� (������, �������������).
	virtual void load_from_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/;

	// implemented method from FoldersNode
	// ��������� ���������� � ��������, �������������� �������� ����� ������������ � xml.
	virtual void save_consultation_to_xml (const char* xml_file_path) const;

	// implemented method from FoldersNode
	// ��������� ���� ��� ���������� ����������
	virtual GCI::IO::String* save_to_integration_xml () const /*throw (InvalidEntityType)*/;

	// implemented method from FoldersNode
	virtual void save_to_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/;

	// implemented method from Node
	// ��������� �������� ��� ������� � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify.
	// ���� ���� �� ����� ��������� ����� ������������ ���������� InvalidContainer
	virtual Node* add_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/;

	// implemented method from Node
	// ��������� �������� ��� "������" ������ � ��������� ����, ���������� ����� ��������� ����. ����
	// ������/������ �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual Node* add_sibling_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, Unsupported
		, DuplicateNode
	)*/;

	// implemented method from Node
	// ��������
	virtual const GCI::IO::String& get_caption () const;
	virtual GCI::IO::String& get_caption ();

	virtual void set_caption (GCI::IO::String* caption)
		/*throw (ConstantModify, AccessDenied)*/;

	// implemented method from Node
	// ���� ��� �������� �������������� �������� ���������� � ������� ��������.
	virtual long get_flags () const;

	// implemented method from Node
	// ���������� � ����
	virtual const GCI::IO::String& get_hint () const;
	virtual GCI::IO::String& get_hint ();

	virtual void set_hint (GCI::IO::String* hint)
		/*throw (ConstantModify, AccessDenied)*/;

	// implemented method from Node
	// ���������� ��������� ��� ������ � ���������� ��������� (���������) �������.
	virtual Core::IObject* open () /*throw (CanNotFindData, NotEntityElement)*/;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Node
	// ����� �� ����������� ����
	virtual bool can_copy () const;

	// overloaded method from Node
	// ����� �� �������� ����
	virtual bool can_insert (Node* source) const;

	// overloaded method from Node
	// ����� �� �������������� ����
	virtual bool can_modify () const;

	// overloaded method from Node
	// ����� �� ����������� ����
	virtual bool can_move () const;

	// overloaded method from Node
	// �������� ������� ���� � ���������� ��� �� ����������, � ��������� ����, ����� �� ��� ��������.
	// ���� ���� �� ����� �������� ���� (�.�. �������� �� � ����), �� ������������ ����������
	// InvalidContainer. ���� �������� ����������� ����� �� ��������, ������������ ����������
	// CopyDisabled
	virtual void copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/;

	// overloaded method from Node
	// ������� ��������� ���� �� ������/������.
	// ���� ������ �������, ������� ��������� ��������, �� ��� ���� ���������. ���� ������/������
	// �������� ��� ����������� (������������) �� ��������� ���������� ConstantModify
	virtual void delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/;

	// overloaded method from Node
	// ���������� ������� ������� � ���������, �������� � ��������� node.
	// ���������� true � ������ ����������.
	virtual bool is_same_node (const Node* node) const;

	// overloaded method from Node
	// ��������� ������� ���� � ��������� ����, ����� �� ��� ��������. ���� ���� �� ����� ��������
	// ���� (�.�. �������� �� � ����), �� ������������ ���������� InvalidContainer. ���� ��������
	// ����������� ����� �� ��������, ������������ ���������� MoveDisabled
	virtual void move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/;

	// overloaded method from Node
	// ��� ��������, �������������� �����
	virtual EntityType get_object_type () const
		/*throw (Unsupported)*/;

	// overloaded method from Node
	// ������������ �������� ����
	virtual Node* override_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/;


//#UC START# *457050AC03A9*
//#UC END# *457050AC03A9*
}; // class FoldersNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
