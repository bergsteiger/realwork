////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::SimpleDocument
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/SimpleDocument.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SimpleDocument::SimpleDocument (GblPilot::Document* document)
//#UC START# *475D5CF30266_BASE_INIT*
: DocumentMaster (document)
, Document_i (document)
//#UC END# *475D5CF30266_BASE_INIT*
{
	//#UC START# *475D5CF30266_BODY*
	//#UC END# *475D5CF30266_BODY*
}

SimpleDocument::~SimpleDocument () {
	//#UC START# *4610CF5501E6_DESTR_BODY*
	//#UC END# *4610CF5501E6_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from Controllable
// ���������� true, ���� ��������� ���������� �� ��������
const bool SimpleDocument::get_can_set_to_control () const {
	//#UC START# *48EF5B3402B5_4610CF5501E6_GET*
	return false;
	//#UC END# *48EF5B3402B5_4610CF5501E6_GET*
}

// overloaded method from Controllable
// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
// �������� � ���������� �������� �� ��������, � false �������������� � ������.
bool SimpleDocument::get_controlled () const {
	//#UC START# *45EEC17501BB_4610CF5501E6_GET*
	return false;
	//#UC END# *45EEC17501BB_4610CF5501E6_GET*
}

void SimpleDocument::set_controlled (bool controlled) {
	//#UC START# *45EEC17501BB_4610CF5501E6_SET*
	throw NotUnderControl ();
	//#UC END# *45EEC17501BB_4610CF5501E6_SET*
}

// overloaded method from Controllable
// ���������� ������� �������� ������� ���������.
unsigned long SimpleDocument::get_control_status () {
	//#UC START# *45EEC17501B6_4610CF5501E6*
	throw NotUnderControl ();
	//#UC END# *45EEC17501B6_4610CF5501E6*
}

// overloaded method from Controllable
// ��������� �������� �� ��������.
bool SimpleDocument::is_same_controllable (const Controllable* other) {
	//#UC START# *45EEC17501B9_4610CF5501E6*
	return false;
	//#UC END# *45EEC17501B9_4610CF5501E6*
}

// overloaded method from Controllable
// ���������� ������ ��������� � ����.
void SimpleDocument::reset_control_status () {
	//#UC START# *45EEC17501B7_4610CF5501E6*
	//#UC END# *45EEC17501B7_4610CF5501E6*
}

// overloaded method from Controllable
ControlledItemType SimpleDocument::get_type () const {
	//#UC START# *45FA9A9C00F5_4610CF5501E6_GET*
	return CIT_DOCUMENT; // ???
	//#UC END# *45FA9A9C00F5_4610CF5501E6_GET*
}

// overloaded method from Document
const NodeBase* SimpleDocument::get_attributes_root () const {
	//#UC START# *45EEC00F006F_4610CF5501E6_GET*
	throw CanNotFindData();
	//#UC END# *45EEC00F006F_4610CF5501E6_GET*
}

NodeBase* SimpleDocument::get_attributes_root () {
	return const_cast<NodeBase*>(((const SimpleDocument*)this)->get_attributes_root ());
}

// overloaded method from Document
// �������� url ��� ���������������� WWW-������ ���������.
ExternalLink* SimpleDocument::get_internet_image_url (long block_id) const {
	//#UC START# *45EEB652019D_4610CF5501E6*
	throw CanNotFindData();
	//#UC END# *45EEB652019D_4610CF5501E6*
}

// overloaded method from Document
TimeMachineWarning* SimpleDocument::get_time_machine_warning (const Date& date) {
	//#UC START# *45EEB65201BE_4610CF5501E6*
	Core::Aptr<TimeMachineWarning> time_machine_warning = new TimeMachineWarning;
	time_machine_warning->type = TMWT_RED;
	return time_machine_warning.forget ();
	//#UC END# *45EEB65201BE_4610CF5501E6*
}

// overloaded method from Document
// �������� ������� ��������������� (������ ���������) � �������� ���������.
// ���������� true � ������, ���� ������ ��������������� ��� ��������� �� ��������� CR_ALL �� ����.
// 
// ��� ��������, �������� �� "�������", ���������� FALSE
bool SimpleDocument::has_correspondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C0_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C0_4610CF5501E6*
}

// overloaded method from Document
// �������� ������� WWW-������ � �������� ���������.
// ���������� true � ������, ���� � �������� ��������� ���� WWW-�����.
bool SimpleDocument::has_internet_image () const {
	//#UC START# *45EEB65201C2_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C2_4610CF5501E6*
}

// overloaded method from Document
// ������� ���������� ������� ��������� �������� ��� �������.
// ��������� �������� ��������� ������������ �������� ��������� (current_redaction).
// ���������� True � ������ ������� ������ ����� ����� ������� (��� �������) ��������.
bool SimpleDocument::has_next_redaction () const {
	//#UC START# *45EEB65201C3_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C3_4610CF5501E6*
}

// overloaded method from Document
// ������� ���������� ������� ���������� �������� ��� �������.
// ���������� �������� ��������� ������������ �������� ��������� (current_redaction).
// ���������� True � ������ ������� ������ ����� ����� ������ (��� �������) ��������.
bool SimpleDocument::has_prev_redaction () const {
	//#UC START# *45EEB65201C4_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C4_4610CF5501E6*
}

// overloaded method from Document
// �������� ������� ������� � �������� ���������.
// ���������� true � ������, ���� � �������� ��������� ���� �������.
// 
// ��� ��������, �������� �� "�������", ��������� ����� �� ��� � ��� "�������"
bool SimpleDocument::has_related_doc () const {
	//#UC START# *45EEB65201C5_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C5_4610CF5501E6*
}

// overloaded method from Document
// �������� ������� ������������ (������ ���������) � �������� ���������.
// ���������� true � ������, ���� ������ ������������ ��� ��������� �� ��������� CR_ALL �� ����.
// 
// ��� ��������, �������� �� "�������", ���������� FALSE
bool SimpleDocument::has_respondents (const NodeBase* category) const {
	//#UC START# *45EEB65201C6_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201C6_4610CF5501E6*
}

// overloaded method from Document
// ����������� ��������������.
bool SimpleDocument::has_warning () const {
	//#UC START# *45EEB65201CA_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201CA_4610CF5501E6*
}

// overloaded method from Document
// ����� ��������� ���������� �������� �� date � �������� ������������� ���������.
bool SimpleDocument::is_date_in_not_sure_interval (const Date& date) const {
	//#UC START# *45EEB65201CC_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201CC_4610CF5501E6*
}

// overloaded method from Document
// �������� ����������� ����������� ��������� ��������� ��� �������� ���������.
// ���������� true � ������, ���� ����� ��������� ��������.
// 
// ��� �������� ����������� ��������, �������������� �������� (�.�. �������������� ������ �������� )
bool SimpleDocument::may_show_attributes () const {
	//#UC START# *45EEB65201D6_4610CF5501E6*
	return false;
	//#UC END# *45EEB65201D6_4610CF5501E6*
}

// overloaded method from Document
const RedactionInfoList& SimpleDocument::get_redactions_list () const {
	//#UC START# *45EED8FA017F_4610CF5501E6_GET*
	if (!this->is_redaction_info_list_init ()) {
		this->set_redaction_info_list (RedactionInfoList ());
	}

	return DocumentMaster::get_redactions_list ();
	//#UC END# *45EED8FA017F_4610CF5501E6_GET*
}

// overloaded method from Document
const Document* SimpleDocument::get_related_doc () const {
	//#UC START# *460B8FD603AB_4610CF5501E6_GET*
	throw CanNotFindData ();
	//#UC END# *460B8FD603AB_4610CF5501E6_GET*
}

Document* SimpleDocument::get_related_doc () {
	return const_cast<Document*>(((const SimpleDocument*)this)->get_related_doc ());
}

// overloaded method from Document
// ������ ���������
const ItemStatus SimpleDocument::get_status () const {
	//#UC START# *45EEBECB019A_4610CF5501E6_GET*
	return IS_UNKNOWN;
	//#UC END# *45EEBECB019A_4610CF5501E6_GET*
}

// overloaded method from Document
// �������������� � ���������.
const GCI::IO::String& SimpleDocument::get_warning () const {
	//#UC START# *45EEB65201E5_4610CF5501E6_GET*
	throw CanNotFindData();
	//#UC END# *45EEB65201E5_4610CF5501E6_GET*
}

GCI::IO::String& SimpleDocument::get_warning () {
	return const_cast<GCI::IO::String&>(((const SimpleDocument*)this)->get_warning ());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

