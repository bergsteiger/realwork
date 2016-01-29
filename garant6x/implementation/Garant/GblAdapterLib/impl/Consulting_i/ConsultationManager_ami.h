#ifndef GBLADAPTER_CONSULTING_MANAGER_AMI_H__
#define GBLADAPTER_CONSULTING_MANAGER_AMI_H__

#include "garantServer/src/Business/GblConsultingClient/GblConsultingClient_amiS.h"

namespace GblAdapterLib {

class ConsultationManager_ami :
	virtual public POA_GblConsultingClient::AMI_ConsultationManagerHandler
	, virtual public TAO_RefCountServantBase {

public:
	ConsultationManager_ami (void) {}

	virtual ~ConsultationManager_ami () {}

	virtual void send_query () {
	}

	virtual void send_query_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void send_estimation () {
	}

	virtual void send_estimation_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void get_consultation_info_list (const GblConsultingClient::ConsultationInfoList&) {
	}

	virtual void get_consultation_info_list_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void get_consultation_data (GblConsultingClient::ConsultationData*) {
	}

	virtual void get_consultation_data_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void set_consultation_info ()	{
	}

	virtual void set_consultation_info_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void delete_consultation () {
	}

	virtual void delete_consultation_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void update_consultations_by_status (CORBA::ULong) {
	}

	virtual void update_consultations_by_status_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void check_internet_channel (CORBA::Boolean) {
	}

	virtual void check_internet_channel_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void check_consulting_available (CORBA::Boolean) {
	}

	virtual void check_consulting_available_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void load_from_xml (void) {
	}

	virtual void load_from_xml_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void init (void) {
	}

	virtual void init_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void payment_confirm (void) {
	}

	virtual void payment_confirm_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void get_consultation_info (::GblConsultingClient::ConsultationInfo* consultation_info) {
	}

	virtual void get_consultation_info_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder) {
	}

	virtual void cant_receive_answer (CORBA::Boolean) {
	}

	virtual void cant_receive_answer_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void create_query_with_notice_user () {
	}

	virtual void create_query_with_notice_user_excep (
		GblConsultingClient::AMI_ConsultationManagerExceptionHolder* excep_holder
	) {
	}

	virtual void get_evd_template (const GCD::SeqOctet&) {
	}

	virtual void get_evd_template_excep (GblConsultingClient::AMI_ConsultationManagerExceptionHolder*) {
	}
};

}; // namespace GblAdapterLib


#endif // GBLADAPTER_CONSULTING_MANAGER_AMI_H__
