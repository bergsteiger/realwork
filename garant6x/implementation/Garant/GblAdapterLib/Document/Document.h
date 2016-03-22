////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Document
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalDefC.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ��� �������, �� ������� ��������� �������������� ������.
enum LinkedObjectType {
	LO_DOCUMENT // ��������.
	, LO_RELATED_DOCUMENT // ������� � ���������.
	, LO_EXTERNAL_OBJECT // ������� ������.
	, LO_MULTILINK // ������������ (������ ����������).
	, LO_EXTERNAL_LINK // ������� ������.
	, LO_QUERY // ������.
	, LO_BOOKMARK // ��������
	, LO_EXTERNAL_OPERATION
	, LO_ENO // ������ �� ENO
	, LO_AUTOREFERAT // �����������
	, LO_SCRIPT // ������ ��� �271754146
	, LO_DELETED_FOLDERS_CONTENT
};

class MissingInfo;
typedef ::Core::Var<MissingInfo> MissingInfo_var;
typedef ::Core::Var<const MissingInfo> MissingInfo_cvar;
// ���������� �� ������������� ���������.
class MissingInfo
	: virtual public ::Core::IObject
{
public:
	// ��� �������������� �������.
	virtual const GCI::IO::String& get_obj_name () const = 0;
	virtual GCI::IO::String& get_obj_name () = 0;

	// ����� ������ (���), � ������� ���������� ������������� ������.
	virtual const GCI::IO::String& get_blocks_info () const = 0;
	virtual GCI::IO::String& get_blocks_info () = 0;

	// ������������� ������ ���������� ������ � ����� ����� (����) - ���������� ��� �����������
	// ��������� ��������� � ���, � �����(��) �����(��) ���������� ������������� ������.  ���� �
	// blocks_info ���������� ������ ���� ����, �� ������������ true, � ��������� ������ false.
	virtual bool is_one_block () const = 0;
};

/// factory interface for MissingInfo
class MissingInfoFactory {
public:
	static MissingInfo* make (const GCD::PID& pid)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������� ������������� ���������
class InvalidParaId : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

enum TimeMachineWarningType {
	TMWT_RED
	, TMWT_YELLOW
};

static const unsigned long POSITION_TYPE_MASK = 2147483648;
static const unsigned long POSITION_TYPE_SUB_ID = 0;
static const unsigned long POSITION_TYPE_PARA_ID = 2147483648;

#pragma pack (push, 1)

struct TimeMachineWarning {
	GCI::IO::String_var warning;
	TimeMachineWarningType type;
};

#pragma pack (pop)

// ������������ ��� ������� ��������� �������� � ���������� ��������������� ���������,
// �������������� � ����.
class InvalidTopicId : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

enum PositionType {
	PT_SUB
	, PT_PARA
	, PT_BOOKMARK
};

#pragma pack (push, 1)

// ����� ����� � ��������.
struct Position {
	// ���� ������������ �������� ���� point. ���� true �� point ��������� �� ��������, � ���������
	// ������ �� ��� ��� ����.
	PositionType type;
	// ����� �����.
	unsigned long point;
};

#pragma pack (pop)

// ������ ����� ��� ������ � ���������.
typedef std::vector < Position > PositionList;

#pragma pack (push, 1)

// ���������� �������������� �������� ������ ����������.
struct Topic {
	PId pid;
	Position position;
};

#pragma pack (pop)

// ������������� ��������� (��� ���� ���������, ������� ������ ���������� ����)
typedef unsigned long ParaId;

// ��� ���������
enum DocumentType {
	DT_DOCUMENT
	, DT_EXPLANATORY
	, DT_AUTO_REFERAT
	, DT_BOOK
	, DT_TIP // ����� ���
	, DT_MEDICAL_EXPLANATORY // ������� ������� ���. ��������
	, DT_MEDICAL_FIRM // �������� � ��������� ����� �� ������
	, DT_MEDICAL_DOCUMENT
	, DT_FLASH // ��������-����
	, DT_ACTUAL_ANALYTICS // ���
	, DT_ACTUAL_ANALYTICS_CONTENTS // ���-����������
	, DT_REF // ����� � www ��������
};

// �� ������� ������ �� �������� ������� (�������� �� ��� ������)
class FolderLinkNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������� �������� ������� (������ ����� ��������� � ObjectId).
typedef long RedactionID;

typedef std::vector < DateInterval > ActiveIntervalList;

#pragma pack (push, 1)

struct NotSureInfo {
	GCI::IO::String_var warning;
	DateInterval interval;
};

#pragma pack (pop)

typedef std::vector < NotSureInfo > NotSureIntervalList;

// ��� �������� �������.
enum RedactionType {
	RT_ACTUAL // ��������
	, RT_ACTUAL_ABOLISHED // �������� �� �������� DS_ABOLISHED (������� ����)
	, RT_ACTUAL_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
	, RT_OLD // �������� � ������� �������� �� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
	, RT_NEW // �������� � ������� �������� ����� ����������, � ������� ��� �� DS_ABOLISHED, �� DS_PREACTIVE
	, RT_NEW_ABOLISHED
	, RT_NEW_PREACTIVE // �������� �� �������� DS_PREACTIVE (�� ������� � ����)
};

#pragma pack (push, 1)

struct RedactionSourceDocumentInfo {
	// ���������� �������� (�� ��� ������������)
	GCI::IO::String_var display_name;
	// ����� ��� �������� � ���������� ��������
	Topic doc_topic;
};

#pragma pack (pop)

typedef std::vector < RedactionSourceDocumentInfo > RedactionSourceDocumentInfoList;

// ������������ � ������ ������� ��������� �������������� �������� �������.
class RedactionNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� �����
enum LinkKind {
	LK_INTERNAL_INVALID
	, LK_REGULAR
	, LK_EXTERNAL
	, LK_ABOLISHED // ������ �� ���������� ���� ��������
	, LK_PREACTIVE // ������ �� �� ���������� � ���� ��������
	, LK_ENO // ������ �� ��
	, LK_EDITION // �������� ���������
	, LK_SCRIPT // ������ �� ������
};

#pragma pack (push, 1)

struct LinkInfo {
	// ��� �����
	LinkKind kind;
	GCI::IO::String_var hint;
};

#pragma pack (pop)

class InvalidDate : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �������� ������� �� ���������� � �������.
// ������������ � ������ ������ �������� "����� ����������" � ���������� � ������� ���������
// �������.
class ExplanationDictionaryNotInstalled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

enum FactoryKey {
	FK_DOCUMENT_MASTER
	, FK_DOCUMENT_DELEGATE
	, FK_DICT_DOCUMENT
	, FK_PHARM_DICT_DOCUMENT
	, FK_PHARM_DOCUMENT
	, FK_PHARM_FIRM_DOCUMENT
	, FK_TIP_DOCUMENT
	, FK_TRANSLATED_DOCUMENT
	, FK_SIMPLE_DOCUMENT
	, FK_FLASH_DOCUMENT
	, FK_AUTOREFERAT_DOCUMENT
	, FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT
	, FK_ACTUAL_ANALYTICS_DOCUMENT
	, FK_REF
	, FK_BOOK
};

// ������ ���������� ���������� � ������� ������ ������� ���������
typedef long ParaNum;

class DiffIterator;
typedef ::Core::Var<DiffIterator> DiffIterator_var;
typedef ::Core::Var<const DiffIterator> DiffIterator_cvar;
// [$175966492]
// *  �������� "��������� ���������" � "���������� ���������" ������ �������� ������������ �������
// ������� (���� �� �� ������) ��� ������������ �������� ���� ��������� � ������.
// * �������� "��������� ���������" ������ �������� ������ �� ����� ��������� (�� �������� � ������
// �� �����)
// * �������� "���������� ���������" ������ �������� ������ �� ������ ��������� (�� �������� �
// ����� �� �����)
class DiffIterator
	: virtual public ::Core::IObject
{
public:
	virtual bool has_next () const = 0;

	virtual bool has_prev () const = 0;

	virtual ParaNum next () /*throw (CanNotFindData)*/ = 0;

	virtual ParaNum acquire_next () const = 0;

	virtual ParaNum prev () /*throw (CanNotFindData)*/ = 0;

	virtual ParaNum acquire_prev () const = 0;

	virtual void move_to (ParaNum para) /*throw (CanNotFindData)*/ = 0;
};

/// factory interface for DiffIterator
class DiffIteratorFactory {
public:
	static DiffIterator* make (const GblPilot::DiffData& diff_data)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef unsigned long LayerID;

class InvalidObjectClass : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class NoPrevRedaction : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

typedef unsigned long ChildID;

#pragma pack (push, 1)

struct EntryPoint {
	LayerID layer;
	ChildID child;
	//#UC START# *4C5AA60F039B*
	EntryPoint () : layer (0), child (0) {
	}

	EntryPoint (LayerID l, ChildID c) : layer (l), child (c) {
	}

	bool operator < (const EntryPoint& other) const {
		return layer == other.layer ? child < other.child : layer < other.layer;
	}
	//#UC END# *4C5AA60F039B*
};

#pragma pack (pop)

#pragma pack (push, 1)

struct Context {
	NodeIndexPath path;
	long start;
	long finish;
};

#pragma pack (pop)

typedef unsigned char EVDType;

typedef long ExternalID;

typedef GCI::IO::Stream EVDStream;
typedef GCI::IO::Stream_var EVDStream_var;
typedef GCI::IO::Stream_cvar EVDStream_cvar;

class InvalidEntryPoint : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class InvalidLayerID : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

#pragma pack (push, 1)

struct Bookmark2 {
	ExternalID para_id;
	unsigned long eid;
	GCI::IO::String_var name;
};

#pragma pack (pop)

typedef std::vector < Bookmark2 > BookmarkList;

typedef std::vector < Context > FragmentList;

typedef std::vector < unsigned long > SubList;

typedef std::vector < FragmentList > ContextList;

class FoundContext;
typedef ::Core::Var<FoundContext> FoundContext_var;
typedef ::Core::Var<const FoundContext> FoundContext_cvar;
class FoundContext
	: virtual public ::Core::IObject
{
public:
	virtual const ContextList& get_list () const = 0;
};

/// factory interface for FoundContext
class FoundContextFactory {
public:
	static FoundContext* make (const GblPilot::ContextList& list)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DocumentTextProvider;
typedef ::Core::Var<DocumentTextProvider> DocumentTextProvider_var;
typedef ::Core::Var<const DocumentTextProvider> DocumentTextProvider_cvar;
class DocumentTextProvider
	: virtual public ::Core::IObject
{
public:
	virtual EVDType get_child_type (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual LayerID get_child_layer_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual ExternalID get_child_external_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual const EVDStream* get_child_evd_style (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual const EVDStream* get_child_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual void set_child_comment (const EntryPoint& id, const EVDStream* comment) /*throw (InvalidEntryPoint)*/ = 0;

	virtual void remove_child_comment (const EntryPoint& id) = 0;

	virtual const BookmarkList& get_child_bookmarks (
		const EntryPoint& id
	) /*throw (
		EmptyResult
		, InvalidEntryPoint
	)*/ = 0;

	virtual const GCI::IO::String* get_child_text (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual GCI::IO::String* get_child_tech_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/ = 0;

	virtual unsigned long all_leaf_para_count (LayerID layer_id) /*throw (InvalidLayerID)*/ = 0;

	virtual unsigned long children_count (LayerID layer_id) /*throw (InvalidLayerID)*/ = 0;

	virtual const NodeIndexPath& find_block_or_sub (ExternalID id) /*throw (CanNotFindData)*/ = 0;

	virtual NodeIndexPath* find_para (ExternalID id) /*throw (CanNotFindData)*/ = 0;

	virtual FoundContext* find_context (
		const GCI::IO::String* context
		, ExternalID from_id
	) /*throw (
		CanNotFindData
	)*/ = 0;

	virtual const SubList& get_sub_list (const EntryPoint& id) = 0;

	virtual NodeBase* get_prefix_tree (ExternalID id) = 0;

	// ����� �� ���������� ������ ��� ����� �� ���������
	virtual bool show_sub_panel_icon (ExternalID id) = 0;

	// ���� ���� ������� � sub ������ true, ����� false.
	virtual bool has_same (ExternalID id) = 0;
};

/// factory interface for DocumentTextProvider
class DocumentTextProviderFactory {
public:
	static DocumentTextProvider* make (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static DocumentTextProvider* make (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < DocumentTextProvider_var > DocumentTextProviderList;

static const ChildID ROOT_CHILD = 0;
static const LayerID ROOT_LAYER = 4294967295; // 0xFFFFFFFF

typedef std::vector < ParaId > CommentsParaList;

#pragma pack (push, 1)

struct ExternalObjectData {
	ExternalObjectType type;
	ParaId para_id;
	GCI::IO::String_var name;
};

#pragma pack (pop)

typedef std::vector < ExternalObjectData > ExternalObjectDataList;

#pragma pack (push, 1)

struct DiffData {
	DiffIterator_var diff_iterator;
	DocumentTextProvider_var cur;
	DocumentTextProvider_var prev;
};

#pragma pack (pop)

#pragma pack (push, 1)

struct DocumentTextProviderDescriptor {
	unsigned long handle;
	unsigned long header_leaf_count;
	unsigned long anno_leaf_count;
};

#pragma pack (pop)

typedef std::vector < DocumentTextProviderDescriptor > DocumentTextProviderDescriptorList;

typedef unsigned long SubId;

#pragma pack (push, 1)

// ����� ����� � �������� (���� DocId SubId)
struct DocPoint {
	// ������������� ���������
	BaseTypesObjectId doc_id;
	// ����� ����/�����
	SubId sub_id;
};

#pragma pack (pop)

// ������ ����� ����� � ��������
typedef std::vector < DocPoint > DocPointList;

class Likeable;
typedef ::Core::Var<Likeable> Likeable_var;
typedef ::Core::Var<const Likeable> Likeable_cvar;
class Likeable
	: virtual public ::Core::IObject
{
public:
	// ����������� �������� ������
	virtual const bool get_can_like () const = 0;

	// ��������
	virtual void like () const = 0;

	// �� ��������
	virtual void unlike () const = 0;
};

#pragma pack (push, 1)

// ���������� � �������� �������.
struct RedactionInfo {
	// ��� ��������.
	GCI::IO::String_var name;
	Date time_machine_date;
	Date doc_date;
	bool is_comparable;
	RedactionType actual_type;
	NotSureIntervalList not_sure_intervals;
	ActiveIntervalList active_intervals;
	RedactionID id;
	RedactionSourceDocumentInfoList changing_documents;
};

#pragma pack (pop)

#pragma pack (push, 1)

struct DiffDocPara {
	GCI::IO::String_var text;
	EVDStream_var style;
	GCI::IO::Stream_var data;
	EVDType type;
	long id;
};

#pragma pack (pop)

typedef std::vector < DiffDocPara > DiffDocParaList;

#pragma pack (push, 1)

struct ChangedBlock {
	unsigned long id;
	// �������� ����������� ������� � ��������� �� ������������ �����, ��������� � ����������,
	// �������  ������������ ���������� �������� (����)
	DiffDocParaList header;
	// ���������� �������� ������ ��������
	DiffDocParaList right_text_para_list;
	// ���������� �������� ����� ��������
	DiffDocParaList left_text_para_list;
};

#pragma pack (pop)

// ������ ��������.
typedef std::vector < RedactionInfo > RedactionInfoList;

class Document;
typedef ::Core::Var<Document> Document_var;
typedef ::Core::Var<const Document> Document_cvar;

class Bookmark;
class DocumentState;
class JournalBookmark;
class Link;

// ��������� �������������� ������ � ����������.
class Document
	: virtual public EntityBase
	, virtual public Controllable
	, virtual public Likeable
{
public:
	// ��� ���������.
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	// ������� ��� ���������.
	virtual const GCI::IO::String& get_short_name () const = 0;
	virtual GCI::IO::String& get_short_name () = 0;

	// �������������� � ���������.
	virtual const GCI::IO::String& get_warning () const = 0;
	virtual GCI::IO::String& get_warning () = 0;

	// ������ ��������� � ������
	virtual unsigned long get_size () const = 0;

	// ���������� ����� ��������� � ����
	virtual unsigned long get_internal_id () const = 0;

	// True - ���� �������� �� ��������� � ������ �������
	virtual const bool get_not_tm () const = 0;

	virtual const GCI::IO::String* get_file_position () const
		/*throw (CanNotFindData)*/ = 0;
	virtual GCI::IO::String* get_file_position ()
		/*throw (CanNotFindData)*/ = 0;

	// �������� ����� ������� ��������� (��� �������������� ������)
	virtual const bool get_new_revision_available () const = 0;

	// ������ ��������� ���������
	virtual const unsigned long get_change_status () const = 0;

	// ������ ���������
	virtual const ItemStatus get_status () const = 0;

	virtual const LanguagesList& get_text_languages () const = 0;

	virtual const NodeBase* get_attributes_root () const = 0;
	virtual NodeBase* get_attributes_root () = 0;

	virtual const RedactionInfoList& get_redactions_list () const = 0;

	virtual const DocumentState* get_current_state () const = 0;
	virtual DocumentState* get_current_state () = 0;

	virtual DocumentType get_doc_type () const = 0;

	virtual const Document* get_translation () const = 0;
	virtual Document* get_translation () = 0;

	virtual const Document* get_annotation () const = 0;
	virtual Document* get_annotation () = 0;

	virtual const Document* get_related_doc () const = 0;
	virtual Document* get_related_doc () = 0;

	virtual const NodeBase* get_contents_root () const
		/*throw (CanNotFindData)*/ = 0;
	virtual NodeBase* get_contents_root ()
		/*throw (CanNotFindData)*/ = 0;

	virtual const BookmarkList& get_bookmark_list () const = 0;

	virtual const CommentsParaList& get_comments_para_list () const = 0;

	virtual const ExternalObjectDataList& get_external_object_data_list () const = 0;

	// ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � ��������
	// �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������)
	// ���� ��� ����� (��� � �������).
	virtual Bookmark* create_bookmark (ParaId para, bool is_para) const = 0;

	// ���������� �������� - ��������, ���������� �����  filters.
	// ���� ������� �������� ����� ���������� - ���������� NULL
	virtual Document* create_view (DocumentState* filters) = 0;

	// ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	virtual void get_correspondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const = 0;

	// �������� url ��� ���������������� WWW-������ ���������.
	virtual ExternalLink* get_internet_image_url (long block_id) const = 0;

	// �������� ��������� �������, �� ������� ��������� �������������� ������, �� �����������
	// ��������������.
	// ������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
	// ������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����)
	// ���������� ������������� ������ (����� get_missing_info)
	// ����� �������������� ��� �������� �� �������������� ������.
	virtual void get_linked_object (
		unsigned long doc_id
		, const Topic& id
		, RedactionID rid
		, LinkedObjectType& obj_type
		, Core::IObject*& obj
	) const /*throw (
		InvalidTopicId
		, FolderLinkNotFound
	)*/ = 0;

	// ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date
	// ���� �� �������� � �������� ������� CanNotFindData
	virtual void get_not_sure_info (
		const Date& date
		, Date& start
		, Date& finish
		, Document*& info
		, GCI::IO::String*& warning
	) const = 0;

	// ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	virtual void get_respondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const = 0;

	virtual TimeMachineWarning* get_time_machine_warning (const Date& date) = 0;

	// �������� ������� ��������������� (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_correspondents (const NodeBase* category) const = 0;

	// �������� ������� WWW-������ � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
	virtual bool has_internet_image () const = 0;

	// ������� ���������� ������� ��������� �������� ��� �������.
	// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
	virtual bool has_next_redaction () const = 0;

	// ������� ���������� ������� ���������� �������� ��� �������.
	// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
	virtual bool has_prev_redaction () const = 0;

	// �������� ������� ������� � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� �������.
	// 
	// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
	virtual bool has_related_doc () const = 0;

	// �������� ������� ������������ (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_respondents (const NodeBase* category) const = 0;

	virtual bool has_annotation () const = 0;

	// ��� ���������� ���� DT_BOOK ���������� false,
	// ��� ��������� true
	virtual bool has_attributes () const = 0;

	// ����������� ��������������.
	virtual bool has_warning () const = 0;

	// ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� ��������
	// "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ����
	// ������, �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� ��
	// ��������, �.�. ����� ����� ������ ������ ���������� � ������� ����������.
	virtual bool is_alive () const = 0;

	// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
	virtual bool is_date_in_not_sure_interval (const Date& date) const = 0;

	virtual bool is_my_bookmark (const Bookmark* bookmark) const = 0;

	virtual bool is_same_document (const Document* doc) const = 0;

	virtual bool is_same_redaction (const Document* view) const = 0;

	// ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, �������
	// ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������
	// ��������, ����� � ������ ����������.
	virtual bool is_same_view (const Document* view) const = 0;

	// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
	// ���������� true � ������, ���� ����� ��������� ��������.
	// 
	// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ ��������
	// )
	virtual bool may_show_attributes () const = 0;

	virtual void get_correspondents (const NodeBase* category, CatalogBase*& out_list) const = 0;

	virtual void get_respondents (const NodeBase* category, CatalogBase*& out_list) const = 0;

	// ���� �� � ��������� �������
	virtual bool has_translation () const = 0;

	// �������� ������� ������� ����������
	virtual bool has_same_documents () const = 0;

	// �������� ������ ������� ����������
	virtual void get_same_documents (CatalogBase*& out_list) const = 0;

	virtual GblPilot::Document* get_server_doc () const = 0;

	// ������������ �� �������� ��� �����������
	virtual bool is_morpho_search_supported () const = 0;

	virtual LinkInfo* get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const = 0;

	// ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � �����
	// ������� �� ������)
	virtual void get_missing_info_for_object (const PId& pid, MissingInfo*& missing_info) const = 0;

	// �������� ������ ����������� ������ ����������
	virtual CatalogBase* get_drug_list () const /*throw (CanNotFindData)*/ = 0;

	// ��������� ����-������
	virtual ExternalObject* get_flash () const = 0;

	// ������� ���������� ��������
	virtual JournalBookmark* create_journal_bookmark (ParaId para) const = 0;

	// ������� ����� ���������� ��� ������������
	virtual size_t get_auto_referat_doc_count () const /*throw (Unsupported)*/ = 0;

	virtual DocumentTextProvider* get_text_provider (bool all_at_once) const /*throw (Unsupported, CanNotFindData)*/ = 0;

	virtual const DocumentTextProviderDescriptorList& get_text_provider_desc_list () /*throw (Unsupported)*/ = 0;

	virtual DocumentTextProvider* get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/ = 0;

	virtual const DocumentTextProviderList& get_text_provider_list (bool all_at_once) /*throw (Unsupported)*/ = 0;

	virtual GCI::IO::Stream* get_autoreferat_header_evd () const /*throw (Unsupported)*/ = 0;

	virtual GCI::IO::Stream* get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/ = 0;

	virtual DiffData* diff (const GCD::PID& pid) const = 0;

	// ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ����
	// ��������� ��� ��������� ������������ � ���������
	virtual GCI::IO::Stream* get_evd_stream () const = 0;

	// �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������
	// ���� �������� ������������)
	virtual void get_self_missing_info (MissingInfo*& missing_info) const = 0;

	// �������� ������ �� ����n������� � ���� ������ (DocId, SubId)
	virtual DocPointList* get_multi_link_info (
		unsigned long doc_id
		, const Topic& id
	) const /*throw (
		CanNotFindData
		, InternalDatabaseError
	)*/ = 0;

	// �� ���������� ������ ��������� ������� ��������� � ������� ������
	virtual void dont_show_document_status_changes_warning () const = 0;

	virtual GCD::PID get_redaction_pid () const = 0;

	// ���� �� � ��������� ���������� ������������ ��������� ����
	// K555095873
	virtual bool has_chronology () const = 0;

	virtual Link* get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const = 0;

	virtual void get_same_to_point (ExternalID id, CatalogBase*& out_list) const = 0;
};

/// factory interface for Document
class DocumentFactory {
public:
	typedef std::vector<FactoryKey> KeySet;
	
	static KeySet* keys ();
public:
	static Document* make (GblPilot::Document* document, FactoryKey key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static Document* make (const GCD::PID& pid, bool is_edition, const char* name, FactoryKey key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Bookmark;
typedef ::Core::Var<Bookmark> Bookmark_var;
typedef ::Core::Var<const Bookmark> Bookmark_cvar;
// �������� �� ��������. ������������ ��� ���������� ��������� (� �������) � ������.
class Bookmark
	: virtual public EntityBase
{
public:
	// ��������� ��������. ������������ � �������� caption � ������.
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// ������ ��� ��������� � �����/���� �� ������� ��������� ��������. ������������ � �������� hint
	// � ������.
	virtual const GCI::IO::String& get_comment () const = 0;
	virtual GCI::IO::String& get_comment () = 0;

	virtual void set_comment (GCI::IO::String* comment) = 0;

	virtual ParaId get_paragraph () const = 0;

	virtual const PId& get_pid () const = 0;

	virtual const Document* get_document () const = 0;
	virtual Document* get_document () = 0;
};

/// factory interface for Bookmark
class BookmarkFactory {
public:
	static Bookmark* make (
		const GblPilotDef::Bookmark& bookmark
		, GblFolders::DocBookmark* doc_bookmark
		, FoldersNode* folders_node
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DocumentState;
typedef ::Core::Var<DocumentState> DocumentState_var;
typedef ::Core::Var<const DocumentState> DocumentState_cvar;
// ��������� ��� ������ � ���������� �������.
class DocumentState
	: virtual public ::Core::IObject
{
public:
	virtual Languages get_language () const = 0;

	virtual void set_language (Languages language) = 0;

	virtual const RedactionInfoList& get_prev_redactions_list () const = 0;

	// [$178324034]
	virtual const RedactionInfoList& get_cur_and_next_redactions_list () const = 0;

	// �������� ������������� � �������� ������� ���������� �������� �������.
	// ���� ���������� �������� ���, �� ������������ RedactionNotFound.
	virtual void set_prev_redaction () const /*throw (RedactionNotFound)*/ = 0;

	// �������� ������������� � �������� ������� ��������� �������� �������.
	// ���� ��������� �������� ���, �� ������������ RedactionNotFound.
	virtual void set_next_redaction () const /*throw (RedactionNotFound)*/ = 0;

	virtual void set_redaction_on_date (const Date& date) const /*throw (RedactionNotFound)*/ = 0;

	// �������� ������������� � �������� ������� �������� � �������� ���������������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	// ���� ����� �������� ������������� ��������, �� ������������ InvalidRedactionId.
	virtual void set_redaction_on_id (RedactionID id) const /*throw (RedactionNotFound)*/ = 0;

	// �������� ������������� � �������� ������� ��������, ���������� �������� ��� ������� ���������.
	// ���������� True � ������ ���� ������� ��������� ���������� � False, ���� �������� ��� �� �����,
	// ��� � �� ������ ������.
	virtual void set_actual_redaction () const /*throw (RedactionNotFound)*/ = 0;

	virtual RedactionID redaction () const = 0;

	virtual RedactionInfo* get_current_redaction () const = 0;

	virtual bool is_same_redactions (const DocumentState* other) const = 0;

	virtual DiffData* diff_with_redaction_by_id (RedactionID id) const = 0;

	virtual DocumentState* clone () const = 0;

	// Get��������������������������������. [$178325284]
	virtual void set_prev_active_redaction () const /*throw (RedactionNotFound)*/ = 0;

	// [$178325284]
	virtual bool can_compare_with_any_other_redaction () const = 0;

	// ���������� true, ���� ��� �������� ����������, �. �. ����� ���:
	// - RT_ACTUAL
	// - RT_ACTUAL_ABOLISHED
	// - RT_ACTUAL_PREACTIVE
	virtual bool is_actual () const = 0;
};

/// factory interface for DocumentState
class DocumentStateFactory {
public:
	static DocumentState* make (Document* source_doc)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static DocumentState* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AllChangesInTables : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class JournalBookmark;
typedef ::Core::Var<JournalBookmark> JournalBookmark_var;
typedef ::Core::Var<const JournalBookmark> JournalBookmark_cvar;
// ���������� ��������
class JournalBookmark
	: virtual public EntityBase
{
public:
	// ���
	virtual const GCI::IO::String* get_name () const = 0;
	virtual GCI::IO::String* get_name () = 0;

	// ������ ��� (����)
	virtual const GCI::IO::String* get_full_name () const = 0;
	virtual GCI::IO::String* get_full_name () = 0;

	virtual const unsigned long get_para_id () const = 0;

	virtual const Document* get_document () const = 0;
	virtual Document* get_document () = 0;

	// ��������  ��������� ���������� ��������
	virtual const GblUserJournalDef::JournalBookmark& get_journal_bookmark () const = 0;
};

/// factory interface for JournalBookmark
class JournalBookmarkFactory {
public:
	static JournalBookmark* make (ObjectId doc_id, ParaId para_id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static JournalBookmark* make (GblUserJournal::JournalBookmark* journal_bookmark)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef LayerID DocumentLayerID;

class Link;
typedef ::Core::Var<Link> Link_var;
typedef ::Core::Var<const Link> Link_cvar;
class Link
	: virtual public ::Core::IObject
{
public:
	virtual LinkedObjectType get_object_type () const = 0;

	virtual Core::IObject* get_object () const /*throw (InvalidTopicId, FolderLinkNotFound)*/ = 0;

	virtual LinkInfo* get_link_info () const = 0;

	virtual GCI::IO::String* get_linked_hint () const = 0;

	virtual LinkKind get_kind () const = 0;
};

/// factory interface for Link
class LinkFactory {
public:
	static Link* make (unsigned long doc_id, const Topic& topic, RedactionID redaction_id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static Link* make (const Document* document, unsigned long doc_id, const Topic& topic, RedactionID redaction_id)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ConsultingStateStub;
typedef ::Core::Var<ConsultingStateStub> ConsultingStateStub_var;
typedef ::Core::Var<const ConsultingStateStub> ConsultingStateStub_cvar;
// �������� ��� ������������
class ConsultingStateStub
	: virtual public DocumentState
{
};

/// factory interface for ConsultingStateStub
class ConsultingStateStubFactory {
public:
	static ConsultingStateStub* make_stub ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < JournalBookmark_var > JournalBookmarkList;

class ConsultingStub;
typedef ::Core::Var<ConsultingStub> ConsultingStub_var;
typedef ::Core::Var<const ConsultingStub> ConsultingStub_cvar;
class ConsultingStub
	: virtual public Document
{
};

/// factory interface for ConsultingStub
class ConsultingStubFactory {
public:
	// �������� �������� ��� ������������
	static ConsultingStub* make_consulting_stub ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DiffDocDataProvider;
typedef ::Core::Var<DiffDocDataProvider> DiffDocDataProvider_var;
typedef ::Core::Var<const DiffDocDataProvider> DiffDocDataProvider_cvar;
class DiffDocDataProvider
	: virtual public ::Core::IObject
{
public:
	virtual unsigned long get_all_leaf_para_count () const = 0;

	// ��������� ��������� ������� ��:
	// 
	// ����� "����� ��������� ���������"
	// ������� ��� ��������� (!Name)
	// ����� "������������ ���������� �������� "������"
	// ����� "����� ��������� ������������ ��������� ��������:"
	virtual DiffDocParaList* get_header_para_list () const = 0;

	// �������� � ������ ��������� ��������� ��� ������� ���������
	virtual bool get_date_para_right (DiffDocPara*& para) const = 0;

	// �������� � ������ ��������� ��������� ��� ������ ���������
	virtual bool get_date_para_left (DiffDocPara*& para) const = 0;

	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� �������
	// ���������)
	virtual DiffDocPara* get_redaction_name_right () const = 0;

	// ������ ������� ����� ��������� ���������� ����� �������� (��� ��� �������� ��� ������ ���������)
	virtual DiffDocPara* get_redaction_name_left () const = 0;

	virtual unsigned long get_changed_block_count () const = 0;

	virtual ChangedBlock* get_changed_block (unsigned long i) const = 0;
};

/// factory interface for DiffDocDataProvider
class DiffDocDataProviderFactory {
public:
	static DiffDocDataProvider* make (const Document* left, const Document* right)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, AllChangesInTables)*/;
};

class ObjectFromLink;
typedef ::Core::Var<ObjectFromLink> ObjectFromLink_var;
typedef ::Core::Var<const ObjectFromLink> ObjectFromLink_cvar;
class ObjectFromLink
	: virtual public ::Core::IObject
{
public:
	virtual Core::IObject* get_object () const = 0;

	virtual LinkedObjectType get_object_type () const = 0;
};

/// factory interface for ObjectFromLink
class ObjectFromLinkFactory {
public:
	typedef std::vector<LinkedObjectType> KeySet;
	
	static KeySet* keys ();
public:
	static ObjectFromLink* make (GblPilot::Link* server_link, LinkedObjectType key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::MissingInfo> {
	typedef GblAdapterLib::MissingInfoFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DiffIterator> {
	typedef GblAdapterLib::DiffIteratorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FoundContext> {
	typedef GblAdapterLib::FoundContextFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DocumentTextProvider> {
	typedef GblAdapterLib::DocumentTextProviderFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Document> {
	typedef GblAdapterLib::DocumentFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Bookmark> {
	typedef GblAdapterLib::BookmarkFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DocumentState> {
	typedef GblAdapterLib::DocumentStateFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::JournalBookmark> {
	typedef GblAdapterLib::JournalBookmarkFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Link> {
	typedef GblAdapterLib::LinkFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConsultingStateStub> {
	typedef GblAdapterLib::ConsultingStateStubFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConsultingStub> {
	typedef GblAdapterLib::ConsultingStubFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DiffDocDataProvider> {
	typedef GblAdapterLib::DiffDocDataProviderFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ObjectFromLink> {
	typedef GblAdapterLib::ObjectFromLinkFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
