////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStub_i
// ��������� ���������� ������ �������� ��� ��������� ConsultingStub
//
// �������� ��� ���������-������������ �259180433
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocWithPid.h"

//#UC START# *4D95738C0216_CUSTOM_INCLUDES*
//#UC END# *4D95738C0216_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ConsultingStub_i; // self forward Var
typedef ::Core::Var<ConsultingStub_i> ConsultingStub_i_var;
typedef ::Core::Var<const ConsultingStub_i> ConsultingStub_i_cvar;

class ConsultingStub_i_factory;

// �������� ��� ���������-������������ �259180433
class ConsultingStub_i:
	virtual public ConsultingStub
	, virtual public ::Core::RefCountObjectBase
	, virtual public DocWithPid
{
	SET_OBJECT_COUNTER (ConsultingStub_i)
	friend class ConsultingStub_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <ConsultingStub_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConsultingStub_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingStub_i ();

	virtual ~ConsultingStub_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_name;

	GCD::PID m_pid;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const GCD::PID& get_pid () const;

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
	// �������� ������ �� ��������.
	virtual Core::IObject* open ();

	// implemented method from Controllable
	// ���������� ������ ��������� � ����.
	virtual void reset_control_status ();

	// implemented method from Controllable
	virtual ControlledItemType get_type () const;

	// implemented method from DocWithPid
	virtual const GCD::PID& get_document_pid () const;

	// implemented method from Document
	virtual const Document* get_annotation () const;
	virtual Document* get_annotation ();

	// implemented method from Document
	virtual const NodeBase* get_attributes_root () const;
	virtual NodeBase* get_attributes_root ();

	// implemented method from Document
	virtual const BookmarkList& get_bookmark_list () const;

	// implemented method from Document
	// ������ ��������� ���������
	virtual const unsigned long get_change_status () const;

	// implemented method from Document
	virtual const CommentsParaList& get_comments_para_list () const;

	// implemented method from Document
	virtual const NodeBase* get_contents_root () const
		/*throw (CanNotFindData)*/;
	virtual NodeBase* get_contents_root ()
		/*throw (CanNotFindData)*/;

	// implemented method from Document
	// ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � ��������
	// �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������)
	// ���� ��� ����� (��� � �������).
	virtual Bookmark* create_bookmark (ParaId para, bool is_para) const;

	// implemented method from Document
	// ������� ���������� ��������
	virtual JournalBookmark* create_journal_bookmark (ParaId para) const;

	// implemented method from Document
	// ���������� �������� - ��������, ���������� �����  filters.
	// ���� ������� �������� ����� ���������� - ���������� NULL
	virtual Document* create_view (DocumentState* filters);

	// implemented method from Document
	virtual const DocumentState* get_current_state () const;
	virtual DocumentState* get_current_state ();

	// implemented method from Document
	virtual DiffData* diff (const GCD::PID& pid) const;

	// implemented method from Document
	virtual DocumentType get_doc_type () const;

	// implemented method from Document
	// �� ���������� ������ ��������� ������� ��������� � ������� ������
	virtual void dont_show_document_status_changes_warning () const;

	// implemented method from Document
	virtual const ExternalObjectDataList& get_external_object_data_list () const;

	// implemented method from Document
	virtual const GCI::IO::String* get_file_position () const
		/*throw (CanNotFindData)*/;
	virtual GCI::IO::String* get_file_position ()
		/*throw (CanNotFindData)*/;

	// implemented method from Document
	virtual GCI::IO::Stream* get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/;

	// implemented method from Document
	// ������� ����� ���������� ��� ������������
	virtual size_t get_auto_referat_doc_count () const /*throw (Unsupported)*/;

	// implemented method from Document
	virtual GCI::IO::Stream* get_autoreferat_header_evd () const /*throw (Unsupported)*/;

	// implemented method from Document
	virtual void get_correspondents (const NodeBase* category, CatalogBase*& out_list) const;

	// implemented method from Document
	// ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	virtual void get_correspondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const;

	// implemented method from Document
	// �������� ������ ����������� ������ ����������
	virtual CatalogBase* get_drug_list () const /*throw (CanNotFindData)*/;

	// implemented method from Document
	// ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ����
	// ��������� ��� ��������� ������������ � ���������
	virtual GCI::IO::Stream* get_evd_stream () const;

	// implemented method from Document
	// ��������� ����-������
	virtual ExternalObject* get_flash () const;

	// implemented method from Document
	// �������� url ��� ���������������� WWW-������ ���������.
	virtual ExternalLink* get_internet_image_url (long block_id) const;

	// implemented method from Document
	virtual Link* get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// implemented method from Document
	virtual LinkInfo* get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// implemented method from Document
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
		, NotAllowedInTrialMode
	)*/;

	// implemented method from Document
	// ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � �����
	// ������� �� ������)
	virtual void get_missing_info_for_object (const PId& pid, MissingInfo*& missing_info) const;

	// implemented method from Document
	// �������� ������ �� ����n������� � ���� ������ (DocId, SubId)
	virtual DocPointList* get_multi_link_info (
		unsigned long doc_id
		, const Topic& id
	) const /*throw (
		CanNotFindData
		, InternalDatabaseError
	)*/;

	// implemented method from Document
	// ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date
	// ���� �� �������� � �������� ������� CanNotFindData
	virtual void get_not_sure_info (
		const Date& date
		, Date& start
		, Date& finish
		, Document*& info
		, GCI::IO::String*& warning
	) const;

	// implemented method from Document
	virtual GCD::PID get_redaction_pid () const;

	// implemented method from Document
	virtual void get_respondents (const NodeBase* category, CatalogBase*& out_list) const;

	// implemented method from Document
	// ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ���������
	// ��������� (category).
	// 
	// ��� ��������, ������� �� "�������", ���������� NULL
	virtual void get_respondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const;

	// implemented method from Document
	// �������� ������ ������� ����������
	virtual void get_same_documents (CatalogBase*& out_list) const;

	// implemented method from Document
	virtual void get_same_to_point (ExternalID id, CatalogBase*& out_list) const;

	// implemented method from Document
	// �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������
	// ���� �������� ������������)
	virtual void get_self_missing_info (MissingInfo*& missing_info) const;

	// implemented method from Document
	virtual GblPilot::Document* get_server_doc () const;

	// implemented method from Document
	virtual DocumentTextProvider* get_text_provider (bool all_at_once) const /*throw (Unsupported, CanNotFindData)*/;

	// implemented method from Document
	virtual DocumentTextProvider* get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/;

	// implemented method from Document
	virtual const DocumentTextProviderDescriptorList& get_text_provider_desc_list () /*throw (Unsupported)*/;

	// implemented method from Document
	virtual const DocumentTextProviderList& get_text_provider_list (bool all_at_once) /*throw (Unsupported)*/;

	// implemented method from Document
	virtual TimeMachineWarning* get_time_machine_warning (const Date& date);

	// implemented method from Document
	virtual bool has_annotation () const;

	// implemented method from Document
	// ��� ���������� ���� DT_BOOK ���������� false,
	// ��� ��������� true
	virtual bool has_attributes () const;

	// implemented method from Document
	// ���� �� � ��������� ���������� ������������ ��������� ����
	// K555095873
	virtual bool has_chronology () const;

	// implemented method from Document
	// �������� ������� ��������������� (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_correspondents (const NodeBase* category) const;

	// implemented method from Document
	// �������� ������� WWW-������ � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
	virtual bool has_internet_image () const;

	// implemented method from Document
	// ������� ���������� ������� ��������� �������� ��� �������.
	// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
	virtual bool has_next_redaction () const;

	// implemented method from Document
	// ������� ���������� ������� ���������� �������� ��� �������.
	// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
	// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
	virtual bool has_prev_redaction () const;

	// implemented method from Document
	// �������� ������� ������� � �������� ���������.
	// ���������� true � ������, ���� � �������� ��������� ���� �������.
	// 
	// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
	virtual bool has_related_doc () const;

	// implemented method from Document
	// �������� ������� ������������ (������ ���������) � �������� ���������.
	// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
	// 
	// ��� ��������, �������� �� "�������", ���������� FALSE
	virtual bool has_respondents (const NodeBase* category) const;

	// implemented method from Document
	// �������� ������� ������� ����������
	virtual bool has_same_documents () const;

	// implemented method from Document
	// ���� �� � ��������� �������
	virtual bool has_translation () const;

	// implemented method from Document
	// ����������� ��������������.
	virtual bool has_warning () const;

	// implemented method from Document
	// ���������� ����� ��������� � ����
	virtual unsigned long get_internal_id () const;

	// implemented method from Document
	// ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� ��������
	// "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ����
	// ������, �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� ��
	// ��������, �.�. ����� ����� ������ ������ ���������� � ������� ����������.
	virtual bool is_alive () const;

	// implemented method from Document
	// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
	virtual bool is_date_in_not_sure_interval (const Date& date) const;

	// implemented method from Document
	// ������������ �� �������� ��� �����������
	virtual bool is_morpho_search_supported () const;

	// implemented method from Document
	virtual bool is_my_bookmark (const Bookmark* bookmark) const;

	// implemented method from Document
	virtual bool is_same_document (const Document* doc) const;

	// implemented method from Document
	virtual bool is_same_redaction (const Document* view) const;

	// implemented method from Document
	// ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, �������
	// ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������
	// ��������, ����� � ������ ����������.
	virtual bool is_same_view (const Document* view) const;

	// implemented method from Document
	// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
	// ���������� true � ������, ���� ����� ��������� ��������.
	// 
	// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ ��������
	// )
	virtual bool may_show_attributes () const;

	// implemented method from Document
	// ��� ���������.
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	// implemented method from Document
	// �������� ����� ������� ��������� (��� �������������� ������)
	virtual const bool get_new_revision_available () const;

	// implemented method from Document
	// True - ���� �������� �� ��������� � ������ �������
	virtual const bool get_not_tm () const;

	// implemented method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// implemented method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// implemented method from Document
	// ������� ��� ���������.
	virtual const GCI::IO::String& get_short_name () const;
	virtual GCI::IO::String& get_short_name ();

	// implemented method from Document
	// ������ ��������� � ������
	virtual unsigned long get_size () const;

	// implemented method from Document
	// ������ ���������
	virtual const ItemStatus get_status () const;

	// implemented method from Document
	virtual const LanguagesList& get_text_languages () const;

	// implemented method from Document
	virtual const Document* get_translation () const;
	virtual Document* get_translation ();

	// implemented method from Document
	// �������������� � ���������.
	virtual const GCI::IO::String& get_warning () const;
	virtual GCI::IO::String& get_warning ();

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

	// implemented method from Likeable
	// ����������� �������� ������
	virtual const bool get_can_like () const;

	// implemented method from Likeable
	// ��������
	virtual void like () const;

	// implemented method from Likeable
	// �� ��������
	virtual void unlike () const;

//#UC START# *4D95738C0216*
private:
	LinkInfo* get_external_link_info (ObjectId id) const;
	LinkInfo* get_topic_link_info (const Topic& id) const;
	void get_linked_external_object (LinkedObjectType& obj_type, Core::IObject*& obj, ObjectId id) const;
	void get_linked_doc (LinkedObjectType& obj_type, Core::IObject*& obj, const Topic& id) const;
//#UC END# *4D95738C0216*
}; // class ConsultingStub_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_CONSULTINGSTUB_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
