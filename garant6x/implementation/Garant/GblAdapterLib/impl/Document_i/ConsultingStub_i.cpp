////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStub_i
//
// �������� ��� ���������-������������ �259180433
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

//#UC START# *4D95738C0216_CUSTOM_INCLUDES*
#include "shared/GCI/I18N/I18N.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
//#UC END# *4D95738C0216_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *4D95738C0216*
//#UC END# *4D95738C0216*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingStub_i::ConsultingStub_i ()
//#UC START# *4D9574780312_4D95731A00BD_4D95738C0216_BASE_INIT*
//#UC END# *4D9574780312_4D95731A00BD_4D95738C0216_BASE_INIT*
{
	//#UC START# *4D9574780312_4D95731A00BD_4D95738C0216_BODY*
	const std::string name = NOT_UNICODE_TR ("����� ������������");
	m_name = GCI::IO::StringFactory::make (name.c_str ());

	const static unsigned consulting_id = 112;
	m_pid.m_class_id = Defines::CI_TOPIC;
	m_pid.m_object_id = consulting_id;
	//#UC END# *4D9574780312_4D95731A00BD_4D95738C0216_BODY*
}

ConsultingStub_i::~ConsultingStub_i () {
	//#UC START# *4D95738C0216_DESTR_BODY*
	//#UC END# *4D95738C0216_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GCD::PID& ConsultingStub_i::get_pid () const {
	//#UC START# *4D9D955C0291_GET_ACCESSOR*
	return m_pid;
	//#UC END# *4D9D955C0291_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Controllable
// ���������� true, ���� ��������� ���������� �� ��������
const bool ConsultingStub_i::get_can_set_to_control () const {
	//#UC START# *48EF5B3402B5_4D95738C0216_GET*
	return false;
	//#UC END# *48EF5B3402B5_4D95738C0216_GET*
}

// implemented method from Controllable
// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
// �������� � ���������� �������� �� ��������, � false �������������� � ������.
bool ConsultingStub_i::get_controlled () const {
	//#UC START# *45EEC17501BB_4D95738C0216_GET*
	return false;
	//#UC END# *45EEC17501BB_4D95738C0216_GET*
}

void ConsultingStub_i::set_controlled (bool controlled) {
	//#UC START# *45EEC17501BB_4D95738C0216_SET*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EEC17501BB_4D95738C0216_SET*
}

// implemented method from Controllable
// ���������� ������� �������� ������� ���������.
unsigned long ConsultingStub_i::get_control_status () {
	//#UC START# *45EEC17501B6_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *45EEC17501B6_4D95738C0216*
}

// implemented method from Controllable
// ��������� �������� �� ��������.
bool ConsultingStub_i::is_same_controllable (const Controllable* other) {
	//#UC START# *45EEC17501B9_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return false;
	//#UC END# *45EEC17501B9_4D95738C0216*
}

// implemented method from Controllable
// �������� ������ �� ��������.
Core::IObject* ConsultingStub_i::open () {
	//#UC START# *45EEC17501B8_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *45EEC17501B8_4D95738C0216*
}

// implemented method from Controllable
// ���������� ������ ��������� � ����.
void ConsultingStub_i::reset_control_status () {
	//#UC START# *45EEC17501B7_4D95738C0216*
	//#UC END# *45EEC17501B7_4D95738C0216*
}

// implemented method from Controllable
ControlledItemType ConsultingStub_i::get_type () const {
	//#UC START# *45FA9A9C00F5_4D95738C0216_GET*
	return CIT_DOCUMENT;
	//#UC END# *45FA9A9C00F5_4D95738C0216_GET*
}

// implemented method from DocWithPid
const GCD::PID& ConsultingStub_i::get_document_pid () const {
	//#UC START# *460A63BD025C_4D95738C0216*
	return m_pid;
	//#UC END# *460A63BD025C_4D95738C0216*
}

// implemented method from Document
const Document* ConsultingStub_i::get_annotation () const {
	//#UC START# *460B8F8F0002_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *460B8F8F0002_4D95738C0216_GET*
}

Document* ConsultingStub_i::get_annotation () {
	return const_cast<Document*>(((const ConsultingStub_i*)this)->get_annotation ());
}

// implemented method from Document
const NodeBase* ConsultingStub_i::get_attributes_root () const {
	//#UC START# *45EEC00F006F_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *45EEC00F006F_4D95738C0216_GET*
}

NodeBase* ConsultingStub_i::get_attributes_root () {
	return const_cast<NodeBase*>(((const ConsultingStub_i*)this)->get_attributes_root ());
}

// implemented method from Document
const BookmarkList& ConsultingStub_i::get_bookmark_list () const {
	//#UC START# *4D147C7602A6_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4D147C7602A6_4D95738C0216_GET*
}

// implemented method from Document
// ������ ��������� ���������
const unsigned long ConsultingStub_i::get_change_status () const {
	//#UC START# *4D7E231702E4_4D95738C0216_GET*
	return 0;
	//#UC END# *4D7E231702E4_4D95738C0216_GET*
}

// implemented method from Document
const CommentsParaList& ConsultingStub_i::get_comments_para_list () const {
	//#UC START# *4D147CCA0051_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4D147CCA0051_4D95738C0216_GET*
}

// implemented method from Document
const NodeBase* ConsultingStub_i::get_contents_root () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *4C77A3370186_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4C77A3370186_4D95738C0216_GET*
}

NodeBase* ConsultingStub_i::get_contents_root ()
	/*throw (CanNotFindData)*/
{
	return const_cast<NodeBase*>(((const ConsultingStub_i*)this)->get_contents_root ());
}

// implemented method from Document
// ������� ��������� �������� �� �������� ������������� ���������. ����������� �� � ��������
// �������� �������� ��� ���������. � � �������� full_name ��� ��������� � ��� ���������� (������)
// ���� ��� ����� (��� � �������).
Bookmark* ConsultingStub_i::create_bookmark (ParaId para, bool is_para) const {
	//#UC START# *45EEB6520194_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *45EEB6520194_4D95738C0216*
}

// implemented method from Document
// ������� ���������� ��������
JournalBookmark* ConsultingStub_i::create_journal_bookmark (ParaId para) const {
	//#UC START# *4A8A9AD600BC_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4A8A9AD600BC_4D95738C0216*
}

// implemented method from Document
// ���������� �������� - ��������, ���������� �����  filters.
// ���� ������� �������� ����� ���������� - ���������� NULL
Document* ConsultingStub_i::create_view (DocumentState* filters) {
	//#UC START# *45EEB6520197_4D95738C0216*
	return 0;
	//#UC END# *45EEB6520197_4D95738C0216*
}

// implemented method from Document
const DocumentState* ConsultingStub_i::get_current_state () const {
	//#UC START# *45EED98D00E1_4D95738C0216_GET*
	return ConsultingStateStubFactory::make_stub ();
	//#UC END# *45EED98D00E1_4D95738C0216_GET*
}

DocumentState* ConsultingStub_i::get_current_state () {
	return const_cast<DocumentState*>(((const ConsultingStub_i*)this)->get_current_state ());
}

// implemented method from Document
DiffData* ConsultingStub_i::diff (const GCD::PID& pid) const {
	//#UC START# *4CC8134700E6_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4CC8134700E6_4D95738C0216*
}

// implemented method from Document
DocumentType ConsultingStub_i::get_doc_type () const {
	//#UC START# *460B80CF0201_4D95738C0216_GET*
	return DT_AUTO_REFERAT;
	//#UC END# *460B80CF0201_4D95738C0216_GET*
}

// implemented method from Document
// �� ���������� ������ ��������� ������� ��������� � ������� ������
void ConsultingStub_i::dont_show_document_status_changes_warning () const {
	//#UC START# *4F1E5DE102BE_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	//#UC END# *4F1E5DE102BE_4D95738C0216*
}

// implemented method from Document
const ExternalObjectDataList& ConsultingStub_i::get_external_object_data_list () const {
	//#UC START# *4D14816D015F_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4D14816D015F_4D95738C0216_GET*
}

// implemented method from Document
const GCI::IO::String* ConsultingStub_i::get_file_position () const
	/*throw (CanNotFindData)*/
{
	//#UC START# *496B249601F3_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *496B249601F3_4D95738C0216_GET*
}

GCI::IO::String* ConsultingStub_i::get_file_position ()
	/*throw (CanNotFindData)*/
{
	return const_cast<GCI::IO::String*>(((const ConsultingStub_i*)this)->get_file_position ());
}

// implemented method from Document
GCI::IO::Stream* ConsultingStub_i::get_annotation_header_evd (unsigned long handle) const /*throw (Unsupported)*/ {
	//#UC START# *4D023D3B02B4_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4D023D3B02B4_4D95738C0216*
}

// implemented method from Document
// ������� ����� ���������� ��� ������������
size_t ConsultingStub_i::get_auto_referat_doc_count () const /*throw (Unsupported)*/ {
	//#UC START# *4A9F9CF3006A_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4A9F9CF3006A_4D95738C0216*
}

// implemented method from Document
GCI::IO::Stream* ConsultingStub_i::get_autoreferat_header_evd () const /*throw (Unsupported)*/ {
	//#UC START# *4D023C95027A_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4D023C95027A_4D95738C0216*
}

// implemented method from Document
void ConsultingStub_i::get_correspondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201D7_4D95738C0216*
	out_list = 0;
	//#UC END# *45EEB65201D7_4D95738C0216*
}

// implemented method from Document
// ���������� ������ ��������������� � ��������� ��������� (������ ����������) ��� ���������
// ��������� (category).
// 
// ��� ��������, ������� �� "�������", ���������� NULL
void ConsultingStub_i::get_correspondents_to_part (
	const PositionList& pos_list
	, const NodeBase* category
	, CatalogBase*& out_list
) const {
	//#UC START# *45EEB6520199_4D95738C0216*
	out_list = 0;
	//#UC END# *45EEB6520199_4D95738C0216*
}

// implemented method from Document
// �������� ������ ����������� ������ ����������
CatalogBase* ConsultingStub_i::get_drug_list () const /*throw (CanNotFindData)*/ {
	//#UC START# *47EBB17D009B_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *47EBB17D009B_4D95738C0216*
}

// implemented method from Document
// ���������� evd ����� ��������� - ������ ��� ��� evd ����� �������� ��� �������������� � ����
// ��������� ��� ��������� ������������ � ���������
GCI::IO::Stream* ConsultingStub_i::get_evd_stream () const {
	//#UC START# *4CE3E9DF02B0_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4CE3E9DF02B0_4D95738C0216*
}

// implemented method from Document
// ��������� ����-������
ExternalObject* ConsultingStub_i::get_flash () const {
	//#UC START# *4857C59403C6_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4857C59403C6_4D95738C0216*
}

// implemented method from Document
// �������� url ��� ���������������� WWW-������ ���������.
ExternalLink* ConsultingStub_i::get_internet_image_url (long block_id) const {
	//#UC START# *45EEB652019D_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *45EEB652019D_4D95738C0216*
}

// implemented method from Document
Link* ConsultingStub_i::get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *53E9F3420066_4D95738C0216*
	GDS_ASSERT (!doc_id);
	GDS_ASSERT (!rid);
	return LinkFactory::make (doc_id, id, rid);
	//#UC END# *53E9F3420066_4D95738C0216*
}

// implemented method from Document
LinkInfo* ConsultingStub_i::get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const {
	//#UC START# *47AB2FC90361_4D95738C0216*
	GDS_ASSERT (!doc_id);
	GDS_ASSERT (!rid);
	Link_var link = LinkFactory::make (doc_id, id, rid);
	return link->get_link_info ();
	//#UC END# *47AB2FC90361_4D95738C0216*
}

// implemented method from Document
// �������� ��������� �������, �� ������� ��������� �������������� ������, �� �����������
// ��������������.
// ������������ ��������� �� ������ (obj) � ��� ������� (obj_type).
// ������������� ����� �������� ��������� (missing_info) � �����������, � ����� ������ (�����)
// ���������� ������������� ������ (����� get_missing_info)
// ����� �������������� ��� �������� �� �������������� ������.
void ConsultingStub_i::get_linked_object (
	unsigned long doc_id
	, const Topic& id
	, RedactionID rid
	, LinkedObjectType& obj_type
	, Core::IObject*& obj
) const /*throw (
	InvalidTopicId
	, FolderLinkNotFound
	, NotAllowedInTrialMode
)*/ {
	//#UC START# *45EEB65201A3_4D95738C0216*
	GDS_ASSERT (!doc_id);
	GDS_ASSERT (!rid);
	Link_var link = LinkFactory::make (doc_id, id, rid);
	obj = link->get_object ();
	obj_type = link->get_object_type ();
	//#UC END# *45EEB65201A3_4D95738C0216*
}

// implemented method from Document
// ���������� ����������� ���������� �� �������������� ������� (pid - ������������� � ����� �������
// �� ������)
void ConsultingStub_i::get_missing_info_for_object (const PId& pid, MissingInfo*& missing_info) const {
	//#UC START# *47C6AA260009_4D95738C0216*
	missing_info = 0;
	//#UC END# *47C6AA260009_4D95738C0216*
}

// implemented method from Document
// �������� ������ �� ����n������� � ���� ������ (DocId, SubId)
DocPointList* ConsultingStub_i::get_multi_link_info (
	unsigned long doc_id
	, const Topic& id
) const /*throw (
	CanNotFindData
	, InternalDatabaseError
)*/ {
	//#UC START# *4DCBB65D028F_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4DCBB65D028F_4D95738C0216*
}

// implemented method from Document
// ���������� ���������� �� ��������� ������������� ���������. ���� ��������� � ��������� date ����
// �� �������� � �������� ������� CanNotFindData
void ConsultingStub_i::get_not_sure_info (
	const Date& date
	, Date& start
	, Date& finish
	, Document*& info
	, GCI::IO::String*& warning
) const {
	//#UC START# *45EEB65201AA_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EEB65201AA_4D95738C0216*
}

// implemented method from Document
GCD::PID ConsultingStub_i::get_redaction_pid () const {
	//#UC START# *528376540040_4D95738C0216*
	return m_pid;
	//#UC END# *528376540040_4D95738C0216*
}

// implemented method from Document
void ConsultingStub_i::get_respondents (const NodeBase* category, CatalogBase*& out_list) const {
	//#UC START# *45EEB65201DA_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	out_list = 0;
	//#UC END# *45EEB65201DA_4D95738C0216*
}

// implemented method from Document
// ���������� ������ ������������ � ��������� ��������� (������ ����������) ��� ��������� ���������
// (category).
// 
// ��� ��������, ������� �� "�������", ���������� NULL
void ConsultingStub_i::get_respondents_to_part (
	const PositionList& pos_list
	, const NodeBase* category
	, CatalogBase*& out_list
) const {
	//#UC START# *45EEB65201B0_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	out_list = 0;
	//#UC END# *45EEB65201B0_4D95738C0216*
}

// implemented method from Document
// �������� ������ ������� ����������
void ConsultingStub_i::get_same_documents (CatalogBase*& out_list) const {
	//#UC START# *45EEB65201E1_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	out_list = 0;
	//#UC END# *45EEB65201E1_4D95738C0216*
}

// implemented method from Document
void ConsultingStub_i::get_same_to_point (ExternalID id, CatalogBase*& out_list) const {
	//#UC START# *5582DAA202AD_4D95738C0216*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *5582DAA202AD_4D95738C0216*
}

// implemented method from Document
// �������� ����������� ���������� �� �������� ��������� (� ������ ��� ���������� - � ����� ������
// ���� �������� ������������)
void ConsultingStub_i::get_self_missing_info (MissingInfo*& missing_info) const {
	//#UC START# *4D3D6F030110_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	missing_info = 0;
	//#UC END# *4D3D6F030110_4D95738C0216*
}

// implemented method from Document
GblPilot::Document* ConsultingStub_i::get_server_doc () const {
	//#UC START# *462774050102_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *462774050102_4D95738C0216*
}

// implemented method from Document
DocumentTextProvider* ConsultingStub_i::get_text_provider (
	bool all_at_once
) const /*throw (
	Unsupported
	, CanNotFindData
)*/ {
	//#UC START# *4CAF1A4B0096_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4CAF1A4B0096_4D95738C0216*
}

// implemented method from Document
DocumentTextProvider* ConsultingStub_i::get_text_provider_by_desc (unsigned long handle) /*throw (Unsupported)*/ {
	//#UC START# *4D6291D500E7_4D95738C0216*
	throw Unsupported ();
	//#UC END# *4D6291D500E7_4D95738C0216*
}

// implemented method from Document
const DocumentTextProviderDescriptorList& ConsultingStub_i::get_text_provider_desc_list () /*throw (Unsupported)*/ {
	//#UC START# *4D6289D601A0_4D95738C0216*
	throw Unsupported ();
	//#UC END# *4D6289D601A0_4D95738C0216*
}

// implemented method from Document
const DocumentTextProviderList& ConsultingStub_i::get_text_provider_list (bool all_at_once) /*throw (Unsupported)*/ {
	//#UC START# *4CED4A090217_4D95738C0216*
	throw Unsupported ();
	//#UC END# *4CED4A090217_4D95738C0216*
}

// implemented method from Document
TimeMachineWarning* ConsultingStub_i::get_time_machine_warning (const Date& date) {
	//#UC START# *45EEB65201BE_4D95738C0216*
	// ����� �������� ��� ���������� ������ ������� GDS_ASSERT (false && "not supported");
	Core::Aptr<TimeMachineWarning> time_machine_warning = new TimeMachineWarning;
	time_machine_warning->type = TMWT_RED;
	return time_machine_warning.forget ();
	//#UC END# *45EEB65201BE_4D95738C0216*
}

// implemented method from Document
bool ConsultingStub_i::has_annotation () const {
	//#UC START# *45EEB65201C8_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C8_4D95738C0216*
}

// implemented method from Document
// ��� ���������� ���� DT_BOOK ���������� false,
// ��� ��������� true
bool ConsultingStub_i::has_attributes () const {
	//#UC START# *45EEB65201C9_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C9_4D95738C0216*
}

// implemented method from Document
// ���� �� � ��������� ���������� ������������ ��������� ����
// K555095873
bool ConsultingStub_i::has_chronology () const {
	//#UC START# *53C3BD6F0050_4D95738C0216*
	return false;
	//#UC END# *53C3BD6F0050_4D95738C0216*
}

// implemented method from Document
// �������� ������� ��������������� (������ ���������) � �������� ���������.
// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
// 
// ��� ��������, �������� �� "�������", ���������� FALSE
bool ConsultingStub_i::has_correspondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C0_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C0_4D95738C0216*
}

// implemented method from Document
// �������� ������� WWW-������ � �������� ���������.
// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
bool ConsultingStub_i::has_internet_image () const {
	//#UC START# *45EEB65201C2_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C2_4D95738C0216*
}

// implemented method from Document
// ������� ���������� ������� ��������� �������� ��� �������.
// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
bool ConsultingStub_i::has_next_redaction () const {
	//#UC START# *45EEB65201C3_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C3_4D95738C0216*
}

// implemented method from Document
// ������� ���������� ������� ���������� �������� ��� �������.
// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
bool ConsultingStub_i::has_prev_redaction () const {
	//#UC START# *45EEB65201C4_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C4_4D95738C0216*
}

// implemented method from Document
// �������� ������� ������� � �������� ���������.
// ���������� true � ������, ���� � �������� ��������� ���� �������.
// 
// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
bool ConsultingStub_i::has_related_doc () const {
	//#UC START# *45EEB65201C5_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C5_4D95738C0216*
}

// implemented method from Document
// �������� ������� ������������ (������ ���������) � �������� ���������.
// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
// 
// ��� ��������, �������� �� "�������", ���������� FALSE
bool ConsultingStub_i::has_respondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C6_4D95738C0216*
	return false;
	//#UC END# *45EEB65201C6_4D95738C0216*
}

// implemented method from Document
// �������� ������� ������� ����������
bool ConsultingStub_i::has_same_documents () const {
	//#UC START# *45EEB65201E0_4D95738C0216*
	return false;
	//#UC END# *45EEB65201E0_4D95738C0216*
}

// implemented method from Document
// ���� �� � ��������� �������
bool ConsultingStub_i::has_translation () const {
	//#UC START# *45EEB65201DF_4D95738C0216*
	return false;
	//#UC END# *45EEB65201DF_4D95738C0216*
}

// implemented method from Document
// ����������� ��������������.
bool ConsultingStub_i::has_warning () const {
	//#UC START# *45EEB65201CA_4D95738C0216*
	return false;
	//#UC END# *45EEB65201CA_4D95738C0216*
}

// implemented method from Document
// ���������� ����� ��������� � ����
unsigned long ConsultingStub_i::get_internal_id () const {
	//#UC START# *45EEB65201E7_4D95738C0216_GET*
	return 0;
	//#UC END# *45EEB65201E7_4D95738C0216_GET*
}

// implemented method from Document
// ����������� �����, ����������� �������� "���" �� �������� �� ������� ����������. ���� ��������
// "���" - ������������ `true` (��� ������� ����� �������� �����, ����� �������� ����� ���� ������,
// �������� �� ����� ���������� ����). ���������� ������� ������ �� ���������� �� ��������, �.�.
// ����� ����� ������ ������ ���������� � ������� ����������.
bool ConsultingStub_i::is_alive () const {
	//#UC START# *45EEB65201CB_4D95738C0216*
	return false;
	//#UC END# *45EEB65201CB_4D95738C0216*
}

// implemented method from Document
// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
bool ConsultingStub_i::is_date_in_not_sure_interval (const Date& date) const {
	//#UC START# *45EEB65201CC_4D95738C0216*
	// ����� ��������, ���� �������� ������ ������� GDS_ASSERT (false && "not supported");
	return false;
	//#UC END# *45EEB65201CC_4D95738C0216*
}

// implemented method from Document
// ������������ �� �������� ��� �����������
bool ConsultingStub_i::is_morpho_search_supported () const {
	//#UC START# *46CD4B9D030D_4D95738C0216*
	return false;
	//#UC END# *46CD4B9D030D_4D95738C0216*
}

// implemented method from Document
bool ConsultingStub_i::is_my_bookmark (const Bookmark* bookmark) const {
	//#UC START# *45EEB65201CE_4D95738C0216*
	return false;
	//#UC END# *45EEB65201CE_4D95738C0216*
}

// implemented method from Document
bool ConsultingStub_i::is_same_document (const Document* doc) const {
	//#UC START# *45EEB65201D0_4D95738C0216*
	return false;
	//#UC END# *45EEB65201D0_4D95738C0216*
}

// implemented method from Document
bool ConsultingStub_i::is_same_redaction (const Document* view) const {
	//#UC START# *45EEB65201D2_4D95738C0216*
	return false;
	//#UC END# *45EEB65201D2_4D95738C0216*
}

// implemented method from Document
// ���������� ��������� ���������� � ������ �� ��������� (� ������� �� is_same_entity, �������
// ���������� ��������� ��� ����� ���������). ���������� ��������� �������� ������������ ������
// ��������, ����� � ������ ����������.
bool ConsultingStub_i::is_same_view (const Document* view) const {
	//#UC START# *45EEB65201D4_4D95738C0216*
	return false;
	//#UC END# *45EEB65201D4_4D95738C0216*
}

// implemented method from Document
// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
// ���������� true � ������, ���� ����� ��������� ��������.
// 
// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ �������� )
bool ConsultingStub_i::may_show_attributes () const {
	//#UC START# *45EEB65201D6_4D95738C0216*
	return false;
	//#UC END# *45EEB65201D6_4D95738C0216*
}

// implemented method from Document
// ��� ���������.
const GCI::IO::String& ConsultingStub_i::get_name () const {
	//#UC START# *45EEB65201E3_4D95738C0216_GET*
	return *m_name.in ();
	//#UC END# *45EEB65201E3_4D95738C0216_GET*
}

GCI::IO::String& ConsultingStub_i::get_name () {
	return const_cast<GCI::IO::String&>(((const ConsultingStub_i*)this)->get_name ());
}

// implemented method from Document
// �������� ����� ������� ��������� (��� �������������� ������)
const bool ConsultingStub_i::get_new_revision_available () const {
	//#UC START# *4BC323A60337_4D95738C0216_GET*
	return false;
	//#UC END# *4BC323A60337_4D95738C0216_GET*
}

// implemented method from Document
// True - ���� �������� �� ��������� � ������ �������
const bool ConsultingStub_i::get_not_tm () const {
	//#UC START# *48285D28025E_4D95738C0216_GET*
	return true;
	//#UC END# *48285D28025E_4D95738C0216_GET*
}

// implemented method from Document
const RedactionInfoList& ConsultingStub_i::get_redactions_list () const {
	//#UC START# *45EED8FA017F_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EED8FA017F_4D95738C0216_GET*
}

// implemented method from Document
const Document* ConsultingStub_i::get_related_doc () const {
	//#UC START# *460B8FD603AB_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *460B8FD603AB_4D95738C0216_GET*
}

Document* ConsultingStub_i::get_related_doc () {
	return const_cast<Document*>(((const ConsultingStub_i*)this)->get_related_doc ());
}

// implemented method from Document
// ������� ��� ���������.
const GCI::IO::String& ConsultingStub_i::get_short_name () const {
	//#UC START# *45EEB65201E4_4D95738C0216_GET*
	return *m_name.in ();
	//#UC END# *45EEB65201E4_4D95738C0216_GET*
}

GCI::IO::String& ConsultingStub_i::get_short_name () {
	return const_cast<GCI::IO::String&>(((const ConsultingStub_i*)this)->get_short_name ());
}

// implemented method from Document
// ������ ��������� � ������
unsigned long ConsultingStub_i::get_size () const {
	//#UC START# *45EEB65201E6_4D95738C0216_GET*
	return 0;
	//#UC END# *45EEB65201E6_4D95738C0216_GET*
}

// implemented method from Document
// ������ ���������
const ItemStatus ConsultingStub_i::get_status () const {
	//#UC START# *45EEBECB019A_4D95738C0216_GET*
	return IS_UNKNOWN;
	//#UC END# *45EEBECB019A_4D95738C0216_GET*
}

// implemented method from Document
const LanguagesList& ConsultingStub_i::get_text_languages () const {
	//#UC START# *45EEBF0F014B_4D95738C0216_GET*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEBF0F014B_4D95738C0216_GET*
}

// implemented method from Document
const Document* ConsultingStub_i::get_translation () const {
	//#UC START# *460B8F6A02B2_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *460B8F6A02B2_4D95738C0216_GET*
}

Document* ConsultingStub_i::get_translation () {
	return const_cast<Document*>(((const ConsultingStub_i*)this)->get_translation ());
}

// implemented method from Document
// �������������� � ���������.
const GCI::IO::String& ConsultingStub_i::get_warning () const {
	//#UC START# *45EEB65201E5_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *45EEB65201E5_4D95738C0216_GET*
}

GCI::IO::String& ConsultingStub_i::get_warning () {
	return const_cast<GCI::IO::String&>(((const ConsultingStub_i*)this)->get_warning ());
}

// implemented method from EntityBase
// ��������� � ����  ���������� ��������� �������.
// ��������� � � ����� ������������ �������
EntityStorage* ConsultingStub_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_4D95738C0216*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *456EB3E1017A_4D95738C0216*
}

// implemented method from EntityBase
// �������������
const unsigned long ConsultingStub_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_4D95738C0216_GET*
	GDS_ASSERT (false && "not supported");
	return std::numeric_limits<unsigned long>::max ();
	//#UC END# *456EE084033C_4D95738C0216_GET*
}

// implemented method from EntityBase
// �������� �����������
bool ConsultingStub_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_4D95738C0216_GET*
	return false;
	//#UC END# *456EB3E1017D_4D95738C0216_GET*
}

// implemented method from EntityBase
// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
// ������ ����������.
bool ConsultingStub_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4D95738C0216_GET*
	return false;
	//#UC END# *456EB3E1017C_4D95738C0216_GET*
}

// implemented method from EntityBase
// ������������ �������� ������� ���������.
EntityStorage* ConsultingStub_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4D95738C0216*
	throw Unsupported ();
	//#UC END# *456EB3E10178_4D95738C0216*
}

// implemented method from Likeable
// ����������� �������� ������
const bool ConsultingStub_i::get_can_like () const {
	//#UC START# *4FEAFD79015E_4D95738C0216_GET*
	return false;
	//#UC END# *4FEAFD79015E_4D95738C0216_GET*
}

// implemented method from Likeable
// ��������
void ConsultingStub_i::like () const {
	//#UC START# *4FEAFD48024F_4D95738C0216*
	GDS_ASSERT (false);
	//#UC END# *4FEAFD48024F_4D95738C0216*
}

// implemented method from Likeable
// �� ��������
void ConsultingStub_i::unlike () const {
	//#UC START# *4FEAFD5D03D1_4D95738C0216*
	GDS_ASSERT (false);
	//#UC END# *4FEAFD5D03D1_4D95738C0216*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

