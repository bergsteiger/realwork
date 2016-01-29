////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingRequests_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingRequests_i
// Заголовок реализации класса серванта для интерфеса ConsultingRequests
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/SortedTypeConverter.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingC.h"
#include "xercesc/dom/DOMDocument.hpp"
#include "xercesc/dom/DOMElement.hpp"
#include "garantPIL/implementation/component/cpp/External/GblValidatorC.h"
#include "shared/XercesHelpers/wrappers/DocumentManager.h"
#include "garantServer/src/Business/GblConsulting/GCDC.h"

//#UC START# *442CE26D0280_CUSTOM_INCLUDES*
#include "xercesc/util/XercesVersion.hpp"

namespace XERCES_CPP_NAMESPACE {
	class DOMElement;
}
//#UC END# *442CE26D0280_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

class ConsultingRequests_i; // self forward Var
typedef ::Core::Var<ConsultingRequests_i> ConsultingRequests_i_var;
typedef ::Core::Var<const ConsultingRequests_i> ConsultingRequests_i_cvar;

class ConsultingRequests_i_factory;

class ConsultingRequests_i:
	virtual public HCInterfaces::ConsultingRequests
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ConsultingRequests_i)
	friend class ConsultingRequests_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:

	class ConsultationStatusToString : 
		public Core::SortedTypeConverter<const char*, unsigned long> {
		protected:
			void fill_array () {
				//#UC START# *4644781B0119_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblConsultingDef::SCS_CREATED, "SCS_CREATED");
				this->add (GblConsultingDef::SCS_IN_PROGRESS, "SCS_IN_PROGRESS");
				this->add (GblConsultingDef::SCS_PAYMENT_REQUIRED, "SCS_PAYMENT_REQUIRED");
				this->add (GblConsultingDef::SCS_PAYMENT_REQUEST_SENT, "SCS_PAYMENT_REQUEST_SENT");
				this->add (GblConsultingDef::SCS_PAYMENT_ACCEPTED, "SCS_PAYMENT_ACCEPTED");
				this->add (GblConsultingDef::SCS_PAYMENT_REJECTED, "SCS_PAYMENT_REJECTED");
				this->add (GblConsultingDef::SCS_IN_PROGRESS_PAID, "SCS_IN_PROGRESS_PAID");
				this->add (GblConsultingDef::SCS_PAYMENT_REJECTED_SENT, "SCS_PAYMENT_REJECTED_SENT");
				this->add (GblConsultingDef::SCS_PROGRESS_DONE, "SCS_PROGRESS_DONE");
				this->add (GblConsultingDef::SCS_ANSWER_SENT, "SCS_ANSWER_SENT");
				this->add (GblConsultingDef::SCS_ESTIMATION_RECEIVED, "SCS_ESTIMATION_RECEIVED");
				this->add (GblConsultingDef::SCS_ESTIMATION_SENT, "SCS_ESTIMATION_SENT");
				//#UC END# *4644781B0119_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ConsultationStatusToString

	typedef ACE_Singleton<ConsultationStatusToString, ACE_SYNCH_NULL_MUTEX> ConsultationStatusToStringSingleton;


	class ComplectTrialTypeToString : 
		public Core::SortedTypeConverter<const char*, GblValidator::ComplectTrialType> {
		protected:
			void fill_array () {
				//#UC START# *469B18FA0177_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblValidator::CTT_COMMERCIAL, "COMMERCIAL");
				this->add (GblValidator::CTT_NON_COMMERCIAL, "NON_COMMERCIAL");
				this->add (GblValidator::CTT_TRIAL, "TRIAL");
				this->add (GblValidator::CTT_DEMO, "DEMO");
				this->add (GblValidator::CTT_PRESENT, "PRESENT");
				this->add (GblValidator::CTT_INTERNAL, "INTERNAL");
				//#UC END# *469B18FA0177_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ComplectTrialTypeToString

	typedef ACE_Singleton<ComplectTrialTypeToString, ACE_SYNCH_NULL_MUTEX> ComplectTrialTypeToStringSingleton;


	class ComplectNetworkTypeToString : 
		public Core::UnsortedTypeConverter<const char*, GblValidator::ComplectType> {
		protected:
			void fill_array () {
				//#UC START# *469B601C01E4_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblValidator::LOCAL_USER, "LOCAL");
				this->add (GblValidator::NET_ONE_USER, "SINGLEUSER");
				this->add (GblValidator::NET_MULTIUSER, "MULTIUSER");
				this->add (GblValidator::INTRANET, "INTRANET");
				this->add (GblValidator::SKP, "SKP");
				this->add (GblValidator::MOBILE, "MOBILE");
				this->add (GblValidator::SUPERMOBILE, "SUPERMOBILE");
				this->add (GblValidator::WWW, "WWW");				    
				this->add (GblValidator::INTERNET, "INTERNET");
				//#UC END# *469B601C01E4_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ComplectNetworkTypeToString

	typedef ACE_Singleton<ComplectNetworkTypeToString, ACE_SYNCH_NULL_MUTEX> ComplectNetworkTypeToStringSingleton;


	class HCConsultationPaymentStatusToString : 
		public Core::UnsortedTypeConverter<const char*, GblConsulting::HCConsultationPaymentStatus> {
		protected:
			void fill_array () {
				//#UC START# *469CA16F000F_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblConsulting::HCPS_FREE, "SENT");
				this->add (GblConsulting::HCPS_OK, "APPLIED");
				this->add (GblConsulting::HCPS_FAIL,"REFUSED");
				//#UC END# *469CA16F000F_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class HCConsultationPaymentStatusToString

	typedef ACE_Singleton<HCConsultationPaymentStatusToString, ACE_SYNCH_NULL_MUTEX> HCConsultationPaymentStatusToStringSingleton;


	class EstimationValueToString : 
		public Core::UnsortedTypeConverter<const char*, GblConsultingDef::EstimationValue> {
		protected:
			void fill_array () {
				//#UC START# *469CA43802AF_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblConsultingDef::EV_UNDEFINED, "UNDEFINED");
				this->add (GblConsultingDef::EV_VERY_GOOD, "VERY_GOOD");
				this->add (GblConsultingDef::EV_GOOD, "GOOD");
				this->add (GblConsultingDef::EV_NORMAL, "NORMAL");
				this->add (GblConsultingDef::EV_BAD, "BAD");
				//#UC END# *469CA43802AF_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class EstimationValueToString

	typedef ACE_Singleton<EstimationValueToString, ACE_SYNCH_NULL_MUTEX> EstimationValueToStringSingleton;

private:
	// общий код для вычитывания id-шников из потока
	class IDListCreator {
		SET_OBJECT_COUNTER (IDListCreator)

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declarations
public:
		// не смогли вычитать xml
		class BadXML : public ::Core::Exception {
		public:
			const char* what () const throw ();

		private:
			const char* uid () const /*throw ()*/;

		};

		// в xml нет идентификаторов консультаций
		class EmptyXML : public ::Core::Exception {
		public:
			const char* what () const throw ();

		private:
			const char* uid () const /*throw ()*/;

		};

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit IDListCreator (GCI::IO::Stream* data);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// вычитать из xml флаг операции
		bool get_force_flag ();

		// получить списки идентификаторов консультаций
		void get_unique_id_lists (GblConsultingDef::UniqueConsultationIDList& id70) /*throw (EmptyXML)*/;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		XercesHelpers::DocumentManager m_manager;

		// корневой элемент xml.
		XERCES_CPP_NAMESPACE::DOMElement* m_root;

	//#UC START# *47B156000062*
	//#UC END# *47B156000062*
	}; // class IDListCreator

public:

	class ErrorResultToString : 
		public Core::UnsortedTypeConverter<GblConsulting::DeleteError, char*> {
		protected:
			void fill_array () {
				//#UC START# *47B17C170213_FILL_ARRAY_IMPLEMENTATION*
				this->add (GblConsulting::INVALID_STATUS, "INVALID_STATUS");
				this->add (GblConsulting::NOT_FOUND, "NOT_FOUND");
				this->add (GblConsulting::UNKNOWN, "UNKNOWN");
				//#UC END# *47B17C170213_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ErrorResultToString

	typedef ACE_Singleton<ErrorResultToString, ACE_SYNCH_NULL_MUTEX> ErrorResultToStringSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingRequests_i ();

	virtual ~ConsultingRequests_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// Конвертер результата записи в базу
	HCInterfaces::ResultValue commit_result_to_set_answer_result (GblConsulting::CommitResult value) const;

	// создать поток с результатами удаления консультаций
	virtual GCI::IO::Stream* create_erase_result_stream (const GblConsulting::DeleteErrorInfoList& list70) const;

	// создание стрима со статистикой о заданных запросах
	virtual GCI::IO::Stream* create_status_stream (const GblConsulting::StatInfoList& list70) const;

	// Кладёт полученный xml документ в поток
	GCI::IO::Stream* create_stream_by_xml (XercesHelpers::DocumentManager& xml_manager) const;

	// Генерит xml для полученной оценки
	virtual GCI::IO::Stream* create_xml_estimation (GblConsulting::ConsultationEstimation& estimation) const;

	// создать xml запрос для консультации с сервера f1
	virtual GCI::IO::Stream* create_xml_request (
		const GblConsulting::ExtendedClientInfo70& extended_info
		, const GblConsultingDef::ConsultationID& id
		, const char* query
		, const GCD::Date& creation_date
		, const GCD::Time& creation_time
		, const GCD::Date& date
		, const GCD::Time& time
		, GblConsulting::HCConsultationPaymentStatus status
		, const GblConsultingDef::UserInfo70& user_info
	) const;

	// Генерит дату в формате xml
	void set_xml_date (
		XERCES_CPP_NAMESPACE::DOMDocument* document
		, XERCES_CPP_NAMESPACE::DOMElement* parent
		, const char* tag_name
		, const GCD::Date& date
	) const;

	// Установка рутового тега для генерируемого xml
	XERCES_CPP_NAMESPACE::DOMElement* set_xml_root_params (
		XERCES_CPP_NAMESPACE::DOMDocument* document
		, const GblConsultingDef::ConsultationID& consultation_id
	) const;

	virtual void set_xml_time (
		XERCES_CPP_NAMESPACE::DOMDocument* document
		, XERCES_CPP_NAMESPACE::DOMElement* parent
		, const char* tag_name
		, const GCD::Time& time
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::ConsultingRequests
	// удалить запросы из базы СК
	virtual HCInterfaces::ResultValue erase_queries_by_id (GCI::IO::Stream* query, GCI::IO::Stream*& result) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// получить список идентификаторов консультаций, которые нужно забрать на обработку в ППО
	virtual HCInterfaces::ResultValue get_list_of_new_queries (GCI::IO::Stream*& result) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// Получение очередной оценки на запрос.
	// При вызове этой операции происходит передача объекта "Оценка" для получения данных. До тех пор
	// пока не будет проведен вызов DataRecieved, эта операция будет возвращать этот запрос.
	// Если нет ни одного нового запроса, получившего оценку пользователя, возвращается нулевой объект.
	virtual HCInterfaces::ResultValue get_next_mark (HCInterfaces::ConsultingData*& data) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// получить следующий запрос для обработки
	virtual HCInterfaces::ResultValue get_query_by_id (
		HCInterfaces::QueryID_const query_id
		, HCInterfaces::ConsultingData*& data
	) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// функция выдаёт статусы консультаций и даты их последней модификации по их идентификаторам.
	virtual HCInterfaces::ResultValue get_status_statistic (GCI::IO::Stream* query, GCI::IO::Stream*& result) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// Ответ на запрос или предварительное уведомление о сроках обработки запроса.
	// Ответ оформлен в XML формате (описание cм. в реквизите).
	// Варианты возвращаемых значений:
	// [0] - если ответ успешно помещен в базу.
	// [1] - если запрос в базе уже помечен, как отвеченный.
	// [-1] - если серверу не удалось прочесть ответ, или положить его в базу, или произошел еще какой-
	// то внутренний сбой. В этом случае необходимо повторить попытку отдачи ответа.
	// [-2] - если формат ответа не соответствует "ожиданиям" сервера.
	virtual HCInterfaces::ResultValue set_answer (GCI::IO::Stream* answer) const;

	// implemented method from HCInterfaces::ConsultingRequests
	// добавить в xml контрольную сумму
	virtual HCInterfaces::ResultValue sign_query (GCI::IO::Stream* query, GCI::IO::Stream*& signed_query) const;

//#UC START# *442CE26D0280*
	// переводит представление ip-адреса из ACE_UINT32 в строку
	struct Addr2String {
	public:
		Addr2String (ACE_UINT32 addr);
		const char* data () const;

	private:
		static const size_t MAX_ADDR_SIZE = 
			3*4 /* числовое представление частей адреса */
			+ 3 /* точки между адресами */
			+ 1 /* завершающий ноль */;
		char m_addr[MAX_ADDR_SIZE];
	};

private:
	GblConsultingDef::UniqueConsultationIDList* get_list_of_new_ids () const;
	GCI::IO::Stream* create_xml_with_new_ids (const GblConsultingDef::UniqueConsultationIDList&) const;
//#UC END# *442CE26D0280*
}; // class ConsultingRequests_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGREQUESTS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
