////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// ���������� ��� ������ �� ������� ��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Business/GblConsultingClient/GblConsultingClientC.h"
#include "shared/GCI/IO/IO.h"
//#UC START# *457007DB002E_CUSTOM_INCLUDE*
namespace GblAdapter_new {
class Document;
class DynList;
}
//#UC END# *457007DB002E_CUSTOM_INCLUDE*

namespace GblAdapterLib {

// ��������� ������
enum EstimationValue {
	EV_UNDEFINED // ������ �� ����������
	, EV_VERY_GOOD // �����!!!
	, EV_GOOD // ������
	, EV_NORMAL // �����
	, EV_BAD // ������ �����...
};

// ��� ������ ���������� � ������
class NoDocumentList : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� ����� � �������� ������������
class NoConnection : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� ������� � ������� - �� �� ��������� �� ������
class NoSubscription : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// � ������������ ��� ���� ���������� ������������
class PaymentForbidden : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ������� ������������
class NotDeleted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ������� - ��� �������� ���������
class Deleted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Estimation;
typedef ::Core::Var<Estimation> Estimation_var;
typedef ::Core::Var<const Estimation> Estimation_cvar;
// ������
class Estimation
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual EstimationValue get_value () const = 0;

	virtual void set_value (EstimationValue value) = 0;

	// ����������� � ������
	virtual const GCI::IO::String& get_text () const = 0;
	virtual GCI::IO::String& get_text () = 0;

	virtual void set_text (GCI::IO::String* text) = 0;
};

/// factory interface for Estimation
class EstimationFactory {
public:
	// �������
	static Estimation* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������������ ������� �������
class OldFormatConsultation : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

typedef unsigned long ConsultationStatus;

typedef std::vector < GCI::IO::String_var > ParasList;

// ������� ������������
static const ConsultationStatus CS_SENT = 1024; // ����������
static const ConsultationStatus CS_PAYMENT_REQUEST = 1; // ������ �� ������
static const ConsultationStatus CS_ANSWER_RECEIVED = 2; // ������� �����
static const ConsultationStatus CS_READ = 4;
static const ConsultationStatus CS_ESTIMATION_SENT = 8; // ���������� ������
static const ConsultationStatus CS_DRAFTS = 16; // �������, �� �� ����������
static const ConsultationStatus CS_PAYMENT_REFUSAL = 32; // ������ ���������
static const ConsultationStatus CS_PAYMENT_CONFIRM = 64;
static const ConsultationStatus CS_VALIDATION_FAILED = 128;
static const ConsultationStatus CS_ANSWER_NOT_CONFIRM = 256;
static const ConsultationStatus CS_READ_NOT_CONFIRM = 512;

class Consultation;
typedef ::Core::Var<Consultation> Consultation_var;
typedef ::Core::Var<const Consultation> Consultation_cvar;
// ������������
class Consultation
	: virtual public EntityBase
{
public:
	// ������ ������������
	virtual ConsultationStatus get_status () const
		/*throw (Deleted)*/ = 0;

	// ������������� ������������
	virtual const GCI::IO::String& get_id () const
		/*throw (Deleted)*/ = 0;
	virtual GCI::IO::String& get_id ()
		/*throw (Deleted)*/ = 0;

	// ���� ��������
	virtual const DateTime& get_creation_date () const
		/*throw (Deleted)*/ = 0;

	// ���� ���������� ��������� �������
	virtual const DateTime& get_modification_date () const
		/*throw (Deleted)*/ = 0;

	// ��� ������������ (����� �������)
	virtual const GCI::IO::String& get_name () const
		/*throw (Deleted)*/ = 0;
	virtual GCI::IO::String& get_name ()
		/*throw (Deleted)*/ = 0;

	virtual const GCI::IO::String& get_query_data () const
		/*throw (Deleted)*/ = 0;

	virtual const GCI::IO::String& get_user_name () const
		/*throw (Deleted)*/ = 0;

	virtual const ParasList get_expert_info () const
		/*throw (Deleted)*/ = 0;

	virtual const GCI::IO::String& get_expert_name () const
		/*throw (Deleted)*/ = 0;

	virtual const Date get_reply_date () const
		/*throw (Deleted)*/ = 0;

	virtual const GblConsultingDef::HCConsultationDataType get_type () const
		/*throw (Deleted)*/ = 0;

	// �������� ����������� ��� ����� �� ������
	virtual Document* get_answer () const /*throw (Deleted, OldFormatConsultation)*/ = 0;

	// �������� ������
	virtual Document* get_query () const /*throw (Deleted, OldFormatConsultation)*/ = 0;

	// �������� ������ ���������� ������
	virtual DynList* get_document_list () const /*throw (NoDocumentList, Deleted, OldFormatConsultation)*/ = 0;

	// ��������� ������
	virtual void send_estimation (const Estimation* value) /*throw (NoConnection, NoSubscription, Deleted)*/ = 0;

	// ������� ������
	virtual Estimation* create_estimation () const = 0;

	// ���������� (answer = true)/���������� (false) �� ������
	virtual void payment_confirm (bool answer) /*throw (NoConnection, PaymentForbidden)*/ = 0;

	// �������� ������������ ��� �����������
	virtual void read () /*throw (Deleted)*/ = 0;

	virtual bool has_list () const /*throw (Deleted)*/ = 0;

	virtual bool has_estimation () const /*throw (Deleted)*/ = 0;

	virtual bool has_payment_information () const /*throw (Deleted)*/ = 0;

	// �������� ������ � ���� ������ ����������
	virtual const ParasList& get_query_by_paras () const = 0;

	virtual const ParasList& get_answer_data (bool& is_evd) const = 0;
};

/// factory interface for Consultation
class ConsultationFactory {
public:
	// �������
	static Consultation* make (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��� �������
enum TemplateType {
	PREANSWER_TEMPLATE // ������ ������� �� ������
	, ANSWER_TEMPLATE // ������ ������
	, QUERY_TEMPLATE // ������ �������
};

class ConsultationManager;
typedef ::Core::Var<ConsultationManager> ConsultationManager_var;
typedef ::Core::Var<const ConsultationManager> ConsultationManager_cvar;
// �������� ������������
class ConsultationManager
	: virtual public StartLocal::BaseUpdateChecker
{
public:
	// �������� �������� ������
	virtual bool check_internet_channel () const = 0;

	// �������� ����������� ���������������� �����
	virtual bool check_consulting_available () const = 0;

	// ������� ������������
	virtual void delete_consultation (Consultation* for_delete) const /*throw (NotDeleted, Deleted)*/ = 0;

	// ���������� ���������� ������������� ������������
	virtual unsigned long update_not_readed_consultations () const = 0;

	// ��������� ������������ �� �����
	virtual void load_from_xml (const char* file_name) const /*throw (AccessDenied, InvalidXMLType)*/ = 0;

	// �������� � ������������� �������� ������ (true - ����� �������� ���� ��������)
	virtual bool cant_receive_answer () const = 0;

	// �������� ����������� ������������ � �����������
	virtual void create_query_with_notice_user () const = 0;
};

/// factory interface for ConsultationManager
class ConsultationManagerFactory {
public:
	// �������
	static ConsultationManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ConsultingTemplateInfo;
typedef ::Core::Var<ConsultingTemplateInfo> ConsultingTemplateInfo_var;
typedef ::Core::Var<const ConsultingTemplateInfo> ConsultingTemplateInfo_cvar;
// ���������� ��� �������� �����������. ������ � ���� ���� 2 ������� (preanswer � answer). �����
// ������ ����� ��� ������������ ���������� � get_template_type
class ConsultingTemplateInfo
	: virtual public StartLocal::BaseUpdateChecker
{
public:
	virtual GCI::IO::Stream* get_preanswer_template () const = 0;

	virtual GCI::IO::Stream* get_answer_template () const = 0;

	// ���������� � ���������, ������� ����� ���� ����� ��� �������. ��. [$100008775]
	virtual GCI::IO::String* get_dealer_info () const = 0;

	// ���������� ����� ������ ����� ��� ����������� ������������
	virtual TemplateType get_template_type (const Consultation* consultation) const /*throw (Deleted)*/ = 0;

	// �������� ������ ��� �������
	virtual GCI::IO::Stream* get_query_template () const = 0;
};

/// factory interface for ConsultingTemplateInfo
class ConsultingTemplateInfoFactory {
public:
	static ConsultingTemplateInfo* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Estimation> {
	typedef GblAdapterLib::EstimationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Consultation> {
	typedef GblAdapterLib::ConsultationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConsultationManager> {
	typedef GblAdapterLib::ConsultationManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConsultingTemplateInfo> {
	typedef GblAdapterLib::ConsultingTemplateInfoFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
