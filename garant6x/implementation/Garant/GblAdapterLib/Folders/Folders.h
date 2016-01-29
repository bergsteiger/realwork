////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Folders
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ��� �������� ����
typedef unsigned long FolderId;

// �������� flags ���  �������� FoldersNode.
static const unsigned long NF_CONTROLLED = 1; // ����������� ������� ����� �� ��������.
static const unsigned long NF_SHARED = 2; // �������� �� ���� ���� (���� �����).
static const unsigned long NF_EXTERNAL = 4; // ������� ����.
static const unsigned long NF_IN_SHARED = 8; // ���������� �� ���� ���� � ������� �����.
static const unsigned long NF_HAS_SHARED = 16; // ���� �� � ���� ���� (���� �����) �������� �����.
static const unsigned long NF_COMMENTS = 32; // ����� ��� �����������
static const unsigned long NF_IN_COMMENTS = 64; // ������� ������ ����� ��� �����������
static const unsigned long NF_COMMON = 128; // ����� �����
static const unsigned long NF_USER = 256; // ����� ������ ����� ����� (�� ������ �������������)
static const unsigned long NF_MY_DOCUMENTS = 512; // ����� ��� ���������
static const unsigned long NF_MY_CONSULTATIONS = 1024; // ����� ��� ������������
static const unsigned long NF_FOLDER_SENT = 2048; // ����� ��� ������������/������� � ���������
static const unsigned long NF_FOLDER_RECEIVED = 4096; // ����� ��� ������������/������
static const unsigned long NF_CONSULTATION_SENT = 8192; // ������������ �� �������� CS_SENT
static const unsigned long NF_PAYMENT_REQUEST = 16384; // ������������ �� �������� CS_PAYMAND_REQUEST (��������� ������)
static const unsigned long NF_ANSWER_RECEIVED = 32768; // ������������ �� �������� CS_ANSWER_RECEIVED (������� �����)
static const unsigned long NF_ANSWER_READ = 65536; // ������������ �� �������� CS_ANSWER_READ (����� ��������)
static const unsigned long NF_ESTIMATION_SENT = 131072; // ������������ �� �������� CS_ESTIMATION_SENT (���������� ������)
static const unsigned long NF_FOLDER_DRAFTS = 262144; // ����� ��� ������������/��������� �������
static const unsigned long NF_FOLDER_PAYMENT_REFUSAL = 524288; // ����� ��� ������������/����������������
static const unsigned long NF_DRAFTS = 1048576; // ������������ �� �������� CS_DRAFTS (���������, �� ��� �� ������������ ������������)
static const unsigned long NF_PAYMENT_REFUSAL = 2097152; // ������������ �� �������� CS_PAYMENT_REFUSAL (������������ � ���������������� �������)
static const unsigned long NF_PAYMENT_CONFIRM = 4194304; // ������������ �� �������� CS_PAYMENT_CONFIRM (������������ � �������������� �������)
static const unsigned long NF_VALIDATION_FAILED = 8388608; // ������������ �� �������� CS_VALIDATION_FAILED (������������ �� ����������, ��� ��� ���� ��������������)

class FoldersNode;
typedef ::Core::Var<FoldersNode> FoldersNode_var;
typedef ::Core::Var<const FoldersNode> FoldersNode_cvar;

class Folders;

// ������������������ ���� ��� �����. ������ �������������� ������� "���� ��������".
// �������� Caption � Hint �������������� �� Node ����������� ����� ��� �������� � ����������������
// ����������� ��������������.
// � �������� BaseEntity ���� ����� ��������� �������� �� ��������, ������, ������ ��� ����������
// ���� (Folder). ����� � ����� ���� ��������� (����� ����) ���������� ��� �������� � ����, ������
// ����� ����� ��������� ���������� (�.�. ��������� ����� ���� �� ������ �� ����� ��������� �����
// �������� ������������ � ���).
class FoldersNode
	: virtual public Node
	, virtual public Controllable
{
public:
	// ������� ����
	virtual const FolderId get_id () const = 0;

	// ���� ��������
	virtual const Date get_creation_date () const = 0;

	// ��������� ���������� � ��������, �������������� �������� ����� ������������ � xml.
	virtual void save_consultation_to_xml (const char* xml_file_path) const = 0;

	virtual void save_to_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ = 0;

	// ��������� ���������� �� xml � ����� (������, �������������).
	virtual void load_from_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/ = 0;

	// ��������� ���� ��� ���������� ����������
	virtual GCI::IO::String* save_to_integration_xml () const /*throw (InvalidEntityType)*/ = 0;

	// ��������� ����� �� ������������ ���� ��������� � xml.
	virtual bool can_save_consultation_to_xml () const = 0;

	// ��������� ����� �� ���� ���� ��������� � xml.
	virtual bool can_save_to_xml () const = 0;

	// ��������� ����� �� � ���� ��������� ������ �� xml.
	virtual bool can_load_from_xml () const = 0;

	// ����� �� ���� ���� ��������� ��� ���������� ����������
	virtual bool can_save_to_integration_xml () const = 0;

	virtual GCD::PID get_pid () const = 0;
};

/// factory interface for FoldersNode
class FoldersNodeFactory {
public:
	static FoldersNode* make (Containers::Content* content, Folders* folders)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Folders;
typedef ::Core::Var<Folders> Folders_var;
typedef ::Core::Var<const Folders> Folders_cvar;

class Folder;

// ��������� (��������) �������������� ������ � ������� �����. ������ �������� ��� ����� (Folder).
class Folders
	: virtual public BaseCatalog
{
public:
	// ������� �����, ���������� ����� ��������� ��������� BaseEntity ���� Folder.
	virtual Folder* create_folder () const = 0;

	// ����� ���� ����� �� ��� ��������������. ���� �� ������ �� CanNotFindData.
	virtual FoldersNode* find_folder_node (FolderId id) const = 0;
};

/// factory interface for Folders
class FoldersFactory {
public:
	static Folders& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������ ��������� �����.
enum NotifyStatus {
	NS_NODE // �������� ��������� �����. �������� ��� ��������/��������� ���� �� �������� �����.
	, NS_CONTENT // �������� ���������� �����, �������� ��� �����, �����������, ����, � �.�.
};

class DoneNotifier;
typedef ::Core::Var<DoneNotifier> DoneNotifier_var;
typedef ::Core::Var<const DoneNotifier> DoneNotifier_cvar;
class DoneNotifier
	: virtual public ::Core::IObject
{
public:
	virtual bool done () = 0;
};

class Folder;
typedef ::Core::Var<Folder> Folder_var;
typedef ::Core::Var<const Folder> Folder_cvar;
// ���������� BaseEntity ����������� ������� ������� ����� �����.
class Folder
	: virtual public EntityBase
	, virtual public NamedElement
{
public:
	// ��� ������� ������. ������� ���� ��� ����� �������� �������������, �.� ������� ������
	// �������������.
	// ����. ������� ����� ����� �������� ��������������.
	// ��� ������� �������� ������ ������� � ������� ����� ������������ ���������� ConstantModify.
	virtual bool get_shared () const = 0;

	virtual void set_shared (bool shared) = 0;

	// ��� ������� ������.
	// ������� ���� ��� ����� �������� ������� (�.�. �� ����������� � ������������� �������
	// ������������).
	virtual bool get_external () const = 0;

	// ����� �� ��������� �����
	virtual bool can_share () const = 0;
};

/// factory interface for Folder
class FolderFactory {
public:
	static Folder* make (GblFolders::Folder* folder_content, FoldersNode* folders_node)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������� object_type ���  �������� FolderNode.
enum FoldersItemType {
	FIT_BOOKMARK // ��������� Bookamark
	, FIT_LIST // ��������� List
	, FIT_QUERY // ��������� Query
	, FIT_FOLDER // ������������ ������� (�����)
	, FIT_CONSULTATION // ������������
	, FIT_PHARM_LIST // ������ ���. ����������
	, FIT_PHARM_BOOKMARK // �������� �� ���. ��������
	, FIT_OLD_HISTORY // ������ �� ������ ������ ������
};

#pragma pack (push, 1)

// ������ ����������� �� ��������� �����.
struct NotifyData {
	// ������ ���������.
	NotifyStatus status;
	DoneNotifier_var done_notifier;
	FoldersNode_var folder;
};

#pragma pack (pop)

class ExternalFoldersChangeNotifier;
typedef ::Core::Var<ExternalFoldersChangeNotifier> ExternalFoldersChangeNotifier_var;
typedef ::Core::Var<const ExternalFoldersChangeNotifier> ExternalFoldersChangeNotifier_cvar;
// ��������� ����������� ��������� ��������� �����.
class ExternalFoldersChangeNotifier
	: virtual public ::Core::IObject
{
public:
	// ��������� ��������� �����. ��� ���� ���������� ���������� ������ ���������������� ����������
	// �����, �������� ����������� ��������� �������� �����.
	virtual void fire (const NotifyData& data) const = 0;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FoldersNode> {
	typedef GblAdapterLib::FoldersNodeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Folders> {
	typedef GblAdapterLib::FoldersFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Folder> {
	typedef GblAdapterLib::FolderFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
