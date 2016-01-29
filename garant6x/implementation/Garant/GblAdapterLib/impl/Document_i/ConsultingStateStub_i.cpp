////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStateStub_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStateStub_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingStateStub_i::ConsultingStateStub_i ()
//#UC START# *4D9591B300B6_4D9591D30125_4D9592120001_BASE_INIT*
//#UC END# *4D9591B300B6_4D9591D30125_4D9592120001_BASE_INIT*
{
	//#UC START# *4D9591B300B6_4D9591D30125_4D9592120001_BODY*
	//#UC END# *4D9591B300B6_4D9591D30125_4D9592120001_BODY*
}

ConsultingStateStub_i::~ConsultingStateStub_i () {
	//#UC START# *4D9592120001_DESTR_BODY*
	//#UC END# *4D9592120001_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocumentState
// [$178325284]
bool ConsultingStateStub_i::can_compare_with_any_other_redaction () const {
	//#UC START# *4B54571C028B_4D9592120001*
	return false;
	//#UC END# *4B54571C028B_4D9592120001*
}

// implemented method from DocumentState
DocumentState* ConsultingStateStub_i::clone () const {
	//#UC START# *4A8130CE0320_4D9592120001*
	return ConsultingStateStubFactory::make_stub ();
	//#UC END# *4A8130CE0320_4D9592120001*
}

// implemented method from DocumentState
// [$178324034]
const RedactionInfoList& ConsultingStateStub_i::get_cur_and_next_redactions_list () const {
	//#UC START# *4B556B8F02C1_4D9592120001_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4B556B8F02C1_4D9592120001_GET*
}

// implemented method from DocumentState
DiffData* ConsultingStateStub_i::diff_with_redaction_by_id (RedactionID id) const {
	//#UC START# *4CC972C00194_4D9592120001*
	GDS_ASSERT (false && "not supported");
	return 0;
	//#UC END# *4CC972C00194_4D9592120001*
}

// implemented method from DocumentState
RedactionInfo* ConsultingStateStub_i::get_current_redaction () const {
	//#UC START# *46320AD6033A_4D9592120001*
	Core::Aptr<RedactionInfo> current_redaction (new RedactionInfo);
	current_redaction->name = GCI::IO::StringFactory::make ("no name");
	current_redaction->actual_type = RT_ACTUAL;
	current_redaction->id = 0;

	return current_redaction.forget ();
	//#UC END# *46320AD6033A_4D9592120001*
}

// implemented method from DocumentState
// возвращает true, если эта редакция актуальная, т. е. имеет тип:
// - RT_ACTUAL
// - RT_ACTUAL_ABOLISHED
// - RT_ACTUAL_PREACTIVE
bool ConsultingStateStub_i::is_actual () const {
	//#UC START# *4EE7512C0058_4D9592120001*
	return true;
	//#UC END# *4EE7512C0058_4D9592120001*
}

// implemented method from DocumentState
bool ConsultingStateStub_i::is_same_redactions (const DocumentState* other) const {
	//#UC START# *4628CAEB0169_4D9592120001*
	return false;
	//#UC END# *4628CAEB0169_4D9592120001*
}

// implemented method from DocumentState
Languages ConsultingStateStub_i::get_language () const {
	//#UC START# *460A40CB01F0_4D9592120001_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *460A40CB01F0_4D9592120001_GET*
}

void ConsultingStateStub_i::set_language (Languages language) {
	//#UC START# *460A40CB01F0_4D9592120001_SET*
	//#UC END# *460A40CB01F0_4D9592120001_SET*
}

// implemented method from DocumentState
const RedactionInfoList& ConsultingStateStub_i::get_prev_redactions_list () const {
	//#UC START# *4A81280E02DE_4D9592120001_GET*
	GDS_ASSERT (false && "not supported");
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *4A81280E02DE_4D9592120001_GET*
}

// implemented method from DocumentState
RedactionID ConsultingStateStub_i::redaction () const {
	//#UC START# *46289947018D_4D9592120001*
	return std::numeric_limits<RedactionID>::max ();
	//#UC END# *46289947018D_4D9592120001*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей редакцию, актуальную редакцию для данного документа.
// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
// что и до вызова метода.
void ConsultingStateStub_i::set_actual_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E008D_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EED80E008D_4D9592120001*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей следующую редакцию объекта.
// Если следующей редакции нет, то возвращается RedactionNotFound.
void ConsultingStateStub_i::set_next_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0088_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EED80E0088_4D9592120001*
}

// implemented method from DocumentState
// GetБлижайшаяДействующаяРедакцияВниз. [$178325284]
void ConsultingStateStub_i::set_prev_active_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *4B545717011B_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *4B545717011B_4D9592120001*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей предыдущую редакцию объекта.
// Если предыдущей редакции нет, то возвращается RedactionNotFound.
void ConsultingStateStub_i::set_prev_redaction () const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0087_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EED80E0087_4D9592120001*
}

// implemented method from DocumentState
void ConsultingStateStub_i::set_redaction_on_date (const Date& date) const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E0089_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EED80E0089_4D9592120001*
}

// implemented method from DocumentState
// Операция устанавливает в качестве текущей редакцию с заданным идентификатором.
// Возвращает True в случае если текущая редакиция изменилась и False, если осталась той же самой,
// что и до вызова метода.
// Если задан неверный идентификатор редакции, то возвращается InvalidRedactionId.
void ConsultingStateStub_i::set_redaction_on_id (RedactionID id) const /*throw (RedactionNotFound)*/ {
	//#UC START# *45EED80E008B_4D9592120001*
	GDS_ASSERT (false && "not supported");
	//#UC END# *45EED80E008B_4D9592120001*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

