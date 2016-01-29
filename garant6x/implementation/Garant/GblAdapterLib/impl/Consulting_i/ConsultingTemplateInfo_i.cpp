////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::ConsultingTemplateInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/ConsultingTemplateInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ConsultingTemplateInfo_i::ConsultingTemplateInfo_i ()
//#UC START# *4CEBC75B00B0_4CEBDE5D01AA_4CEBDA4001E8_BASE_INIT*
//#UC END# *4CEBC75B00B0_4CEBDE5D01AA_4CEBDA4001E8_BASE_INIT*
{
	//#UC START# *4CEBC75B00B0_4CEBDE5D01AA_4CEBDA4001E8_BODY*
	//#UC END# *4CEBC75B00B0_4CEBDE5D01AA_4CEBDA4001E8_BODY*
}

ConsultingTemplateInfo_i::~ConsultingTemplateInfo_i () {
	//#UC START# *4CEBDA4001E8_DESTR_BODY*
	//#UC END# *4CEBDA4001E8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseUpdateChecker_i
void ConsultingTemplateInfo_i::clear_cache () {
	//#UC START# *45702DA9037A_4CEBDA4001E8*
	m_answer = 0;
	m_preanswer = 0;
	m_query = 0;
	//#UC END# *45702DA9037A_4CEBDA4001E8*
}

// implemented method from ConsultingTemplateInfo
GCI::IO::Stream* ConsultingTemplateInfo_i::get_answer_template () const {
	//#UC START# *4CEBC82300CD_4CEBDA4001E8*
	if (m_answer.is_nil ()) {
		GCD::SeqOctet_var evd_template (
			ApplicationHelper::instance ()->
				get_cached_consultation_manager ()->get_evd_template (GblConsultingClient::ANSWER_EVD_TEMPLATE)
		);
		m_answer = MemoryStreamFactory::make (evd_template.in (), true);
	}

	return Core::IObject::_duplicate (m_answer.in ());
	//#UC END# *4CEBC82300CD_4CEBDA4001E8*
}

// implemented method from ConsultingTemplateInfo
// информация о комплекте, которая может быть нужна для шаблона. См. [$100008775]
GCI::IO::String* ConsultingTemplateInfo_i::get_dealer_info () const {
	//#UC START# *4CEBC83F016B_4CEBDA4001E8*
	ComplectInfo_var complect_info (ComplectInfoFactory::make ());
	return complect_info->get_dealer_info ();
	//#UC END# *4CEBC83F016B_4CEBDA4001E8*
}

// implemented method from ConsultingTemplateInfo
GCI::IO::Stream* ConsultingTemplateInfo_i::get_preanswer_template () const {
	//#UC START# *4CEBC80B00FD_4CEBDA4001E8*
	if (m_preanswer.is_nil ()) {
		GCD::SeqOctet_var evd_template (
			ApplicationHelper::instance ()->
				get_cached_consultation_manager ()->get_evd_template (GblConsultingClient::PREANSWER_EVD_TEMPLATE)
		);
		m_preanswer = MemoryStreamFactory::make (evd_template.in (), true);
	}

	return Core::IObject::_duplicate (m_preanswer.in ());
	//#UC END# *4CEBC80B00FD_4CEBDA4001E8*
}

// implemented method from ConsultingTemplateInfo
// получить шаблон для запроса
GCI::IO::Stream* ConsultingTemplateInfo_i::get_query_template () const {
	//#UC START# *4D075AF20237_4CEBDA4001E8*
	if (m_query.is_nil ()) {
		GCD::SeqOctet_var evd_template (
			ApplicationHelper::instance ()->
				get_cached_consultation_manager ()->get_evd_template (GblConsultingClient::QUERY_EVD_TEMPLATE)
		);
		m_query = MemoryStreamFactory::make (evd_template.in (), true);
	}

	return Core::IObject::_duplicate (m_query.in ());
	//#UC END# *4D075AF20237_4CEBDA4001E8*
}

// implemented method from ConsultingTemplateInfo
// определяет какой шаблон нужен для отображения консультации
TemplateType ConsultingTemplateInfo_i::get_template_type (const Consultation* consultation) const /*throw (Deleted)*/ {
	//#UC START# *4CEE5713008E_4CEBDA4001E8*
	if (consultation->get_status () & (CS_DRAFTS | CS_SENT | CS_PAYMENT_REFUSAL | CS_VALIDATION_FAILED)) {
		return QUERY_TEMPLATE;
	}
	return (consultation->get_type () == GblConsultingDef::HCDT_REPLY) ? ANSWER_TEMPLATE : PREANSWER_TEMPLATE;
	//#UC END# *4CEE5713008E_4CEBDA4001E8*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

