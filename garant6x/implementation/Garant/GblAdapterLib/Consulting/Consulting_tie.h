////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting_tie.h"
// С++ TIE-обвязка для DLL (_tie.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_TIE_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_TIE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/mng/IObject_tie.h"
#include "shared/Core/mng/PoolObjectManager.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "shared/GCI/IO/IO_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders_tie.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document_tie.h"

namespace GblAdapterLib {

class IEstimation_tie: public ::Core::IIObject_tie {
public:

	virtual void __stdcall get_text (GCI::IO::IString_tie*& ret_) = 0;
	virtual void __stdcall set_text (GCI::IO::IString_tie* text) = 0;


	virtual EstimationValue __stdcall get_value () const = 0;
	virtual void __stdcall set_value (EstimationValue value) = 0;
};

class __declspec (dllexport) Estimation_tie: public IEstimation_tie {
	SET_OBJECT_COUNTER (Estimation_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Estimation_tie ();

	typedef ::Core::PoolObjectManager<Estimation_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Estimation_tie> Pool;
	friend class ::Core::PoolObjectManager<Estimation_tie>;
	typedef ::Core::IidMapRegistrator<Estimation_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IEstimation_tie* obj, Estimation*& ret_, bool interface_addref = false);

	static void make_tie (const Estimation* obj, IEstimation_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Estimation& obj, IEstimation_tie*& ret_, const Core::TIEBase* owner);

	Estimation* m_impl;

protected:

	virtual void __stdcall get_text (GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_text (GCI::IO::IString_tie* text);


	virtual EstimationValue __stdcall get_value () const;
	virtual void __stdcall set_value (EstimationValue value);
};

class ParasList_tie: public Core::TIEBase {
	SET_OBJECT_COUNTER (ParasList_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ParasList_tie ();

	typedef ::Core::PoolObjectManager<ParasList_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ParasList_tie> Pool;
	friend class ::Core::PoolObjectManager<ParasList_tie>;

public:
	static const ::Core::ComIID s_com_iid;
	
	static void make_cpp (const ParasList_tie* obj, ParasList*& ret_);

	static void make_tie (ParasList* obj, ParasList_tie*& ret_);
	
	static void make_tie (const ParasList& obj, ParasList_tie*& ret_);

	static void make_tie (const ParasList& obj, ParasList_tie*& ret_, const Core::TIEBase* owner);
	
	static void new_tie (ParasList* obj, ParasList_tie*& ret_);

	ParasList* m_impl;
	bool m_orphan;

protected:
	virtual size_t __stdcall get_count () const;
	virtual void __stdcall set_count (size_t count);
	virtual void __stdcall clear ();
	virtual void __stdcall delete_item (size_t index);
	virtual void __stdcall get_item (size_t index, GCI::IO::IString_tie*& ret_);
	virtual void __stdcall set_item (size_t index, const GCI::IO::IString_tie* item);
	virtual size_t __stdcall add (const GCI::IO::IString_tie* item);
	virtual size_t __stdcall insert (size_t index, const GCI::IO::IString_tie* item);
};

class IConsultation_tie: public IEntityBase_tie {
public:
	virtual void __stdcall create_estimation_45700805015D (
		IEstimation_tie*& ret_
	) const = 0;


	virtual void __stdcall get_creation_date (DateTime& ret_) const /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_expert_info (ParasList_tie*& ret_) const /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_expert_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ = 0;

	virtual void __stdcall get_answer_457008050159 (
		IDocument_tie*& ret_
	) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/ = 0;

	virtual void __stdcall get_answer_data_4DA581950113 (
		bool& is_evd
		, ParasList_tie*& ret_
	) const = 0;

	virtual void __stdcall get_document_list_45700805015A (
		IDynList_tie*& ret_
	) const /*throw (NoDocumentList_tie, Deleted_tie, OldFormatConsultation_tie)*/ = 0;

	virtual void __stdcall get_query_46BAFEDB004E (
		IDocument_tie*& ret_
	) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/ = 0;

	virtual void __stdcall get_query_by_paras_4D07592B0032 (
		ParasList_tie*& ret_
	) const = 0;

	virtual bool __stdcall has_estimation_4CEBD99E01F5 () const /*throw (Deleted_tie)*/ = 0;

	virtual bool __stdcall has_list_4CEBD9790091 () const /*throw (Deleted_tie)*/ = 0;

	virtual bool __stdcall has_payment_information_4CEBD9BE03E4 () const /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_id (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_modification_date (DateTime& ret_) const /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ = 0;

	virtual void __stdcall payment_confirm_45700805015E (
		bool answer
	) /*throw (NoConnection_tie, PaymentForbidden_tie)*/ = 0;


	virtual void __stdcall get_query_data (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ = 0;

	virtual void __stdcall read_486B5273020E () /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_reply_date (Date& ret_) const /*throw (Deleted_tie)*/ = 0;

	virtual void __stdcall send_estimation_45700805015B (
		const IEstimation_tie* value
	) /*throw (NoConnection_tie, NoSubscription_tie, Deleted_tie)*/ = 0;


	virtual ConsultationStatus __stdcall get_status () const /*throw (Deleted_tie)*/ = 0;


	virtual void __stdcall get_user_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/ = 0;
};

class __declspec (dllexport) Consultation_tie: public IConsultation_tie {
	SET_OBJECT_COUNTER (Consultation_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	Consultation_tie ();

	typedef ::Core::PoolObjectManager<Consultation_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<Consultation_tie> Pool;
	friend class ::Core::PoolObjectManager<Consultation_tie>;
	typedef ::Core::IidMapRegistrator<Consultation_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConsultation_tie* obj, Consultation*& ret_, bool interface_addref = false);

	static void make_tie (const Consultation* obj, IConsultation_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const Consultation& obj, IConsultation_tie*& ret_, const Core::TIEBase* owner);

	Consultation* m_impl;

protected:

	virtual bool __stdcall get_is_saved () const;


	virtual bool __stdcall get_is_changed () const;


	virtual const unsigned long __stdcall get_eid () const /*throw (Unsupported_tie)*/;

	virtual void __stdcall save_to_456EB3E10178 (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (AccessDenied_tie, Unsupported_tie, NotSaved_tie, DuplicateNode_tie, CanNotSave_tie)*/;

	virtual void __stdcall append_to_456EB3E1017A (
		IEntityStorage_tie* storage
		, IEntityStorage_tie*& ret_
	) /*throw (ConstantModify_tie, AccessDenied_tie, Unsupported_tie, CanNotSave_tie)*/;
	virtual void __stdcall create_estimation_45700805015D (
		IEstimation_tie*& ret_
	) const;


	virtual void __stdcall get_creation_date (DateTime& ret_) const /*throw (Deleted_tie)*/;


	virtual void __stdcall get_expert_info (ParasList_tie*& ret_) const /*throw (Deleted_tie)*/;


	virtual void __stdcall get_expert_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/;

	virtual void __stdcall get_answer_457008050159 (
		IDocument_tie*& ret_
	) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/;

	virtual void __stdcall get_answer_data_4DA581950113 (
		bool& is_evd
		, ParasList_tie*& ret_
	) const;

	virtual void __stdcall get_document_list_45700805015A (
		IDynList_tie*& ret_
	) const /*throw (NoDocumentList_tie, Deleted_tie, OldFormatConsultation_tie)*/;

	virtual void __stdcall get_query_46BAFEDB004E (
		IDocument_tie*& ret_
	) const /*throw (Deleted_tie, OldFormatConsultation_tie)*/;

	virtual void __stdcall get_query_by_paras_4D07592B0032 (
		ParasList_tie*& ret_
	) const;

	virtual bool __stdcall has_estimation_4CEBD99E01F5 () const /*throw (Deleted_tie)*/;

	virtual bool __stdcall has_list_4CEBD9790091 () const /*throw (Deleted_tie)*/;

	virtual bool __stdcall has_payment_information_4CEBD9BE03E4 () const /*throw (Deleted_tie)*/;


	virtual void __stdcall get_id (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/;


	virtual void __stdcall get_modification_date (DateTime& ret_) const /*throw (Deleted_tie)*/;


	virtual void __stdcall get_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/;

	virtual void __stdcall payment_confirm_45700805015E (
		bool answer
	) /*throw (NoConnection_tie, PaymentForbidden_tie)*/;


	virtual void __stdcall get_query_data (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/;

	virtual void __stdcall read_486B5273020E () /*throw (Deleted_tie)*/;


	virtual void __stdcall get_reply_date (Date& ret_) const /*throw (Deleted_tie)*/;

	virtual void __stdcall send_estimation_45700805015B (
		const IEstimation_tie* value
	) /*throw (NoConnection_tie, NoSubscription_tie, Deleted_tie)*/;


	virtual ConsultationStatus __stdcall get_status () const /*throw (Deleted_tie)*/;


	virtual void __stdcall get_user_name (GCI::IO::IString_tie*& ret_) /*throw (Deleted_tie)*/;
};

class IConsultationManager_tie: public ::Core::IIObject_tie {
public:
	virtual bool __stdcall cant_receive_answer_4829A56201B6 () const = 0;

	virtual bool __stdcall check_consulting_available_457009CC035D () const = 0;

	virtual bool __stdcall check_internet_channel_457009CC035C () const = 0;

	virtual void __stdcall create_query_with_notice_user_4867614C01B0 () const = 0;

	virtual void __stdcall delete_consultation_457009CC035E (
		IConsultation_tie* for_delete
	) const /*throw (NotDeleted_tie, Deleted_tie)*/ = 0;

	virtual void __stdcall load_from_xml_457009CC0361 (
		const char* file_name
	) const /*throw (AccessDenied_tie, InvalidXMLType_tie)*/ = 0;

	virtual unsigned long __stdcall update_not_readed_consultations_457009CC0360 () const = 0;
};

class __declspec (dllexport) ConsultationManager_tie: public IConsultationManager_tie {
	SET_OBJECT_COUNTER (ConsultationManager_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ConsultationManager_tie ();

	typedef ::Core::PoolObjectManager<ConsultationManager_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ConsultationManager_tie> Pool;
	friend class ::Core::PoolObjectManager<ConsultationManager_tie>;
	typedef ::Core::IidMapRegistrator<ConsultationManager_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConsultationManager_tie* obj, ConsultationManager*& ret_, bool interface_addref = false);

	static void make_tie (const ConsultationManager* obj, IConsultationManager_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ConsultationManager& obj, IConsultationManager_tie*& ret_, const Core::TIEBase* owner);

	ConsultationManager* m_impl;

protected:
	virtual bool __stdcall cant_receive_answer_4829A56201B6 () const;

	virtual bool __stdcall check_consulting_available_457009CC035D () const;

	virtual bool __stdcall check_internet_channel_457009CC035C () const;

	virtual void __stdcall create_query_with_notice_user_4867614C01B0 () const;

	virtual void __stdcall delete_consultation_457009CC035E (
		IConsultation_tie* for_delete
	) const /*throw (NotDeleted_tie, Deleted_tie)*/;

	virtual void __stdcall load_from_xml_457009CC0361 (
		const char* file_name
	) const /*throw (AccessDenied_tie, InvalidXMLType_tie)*/;

	virtual unsigned long __stdcall update_not_readed_consultations_457009CC0360 () const;
};

class IConsultingTemplateInfo_tie: public ::Core::IIObject_tie {
public:
	virtual void __stdcall get_answer_template_4CEBC82300CD (
		GCI::IO::IStream_tie*& ret_
	) const = 0;

	virtual void __stdcall get_dealer_info_4CEBC83F016B (
		GCI::IO::IString_tie*& ret_
	) const = 0;

	virtual void __stdcall get_preanswer_template_4CEBC80B00FD (
		GCI::IO::IStream_tie*& ret_
	) const = 0;

	virtual void __stdcall get_query_template_4D075AF20237 (
		GCI::IO::IStream_tie*& ret_
	) const = 0;

	virtual TemplateType __stdcall get_template_type_4CEE5713008E (
		const IConsultation_tie* consultation
	) const /*throw (Deleted_tie)*/ = 0;
};

class __declspec (dllexport) ConsultingTemplateInfo_tie: public IConsultingTemplateInfo_tie {
	SET_OBJECT_COUNTER (ConsultingTemplateInfo_tie)
protected:
	virtual unsigned long __stdcall query_interface (
		const ::Core::ComIID& iid
		, void*& object
	);

	virtual unsigned long __stdcall addref () const;

public:
	virtual unsigned long __stdcall release () const;

	virtual ::Core::IObject* get_impl () const;

// For ObjectPool's objects initialization and destruction
public:
	void init ();

	void done ();

private:
	ConsultingTemplateInfo_tie ();

	typedef ::Core::PoolObjectManager<ConsultingTemplateInfo_tie>::PoolObjectManagerSingleton MyPool;
	typedef ::Core::PoolObjectManager<ConsultingTemplateInfo_tie> Pool;
	friend class ::Core::PoolObjectManager<ConsultingTemplateInfo_tie>;
	typedef ::Core::IidMapRegistrator<ConsultingTemplateInfo_tie> IidRegistrator;
	static IidRegistrator s_iid_registrator;
	
public:
	static const ::Core::ComIID s_com_iid;
	
	static void* cast (::Core::IObject* obj);

	static void make_cpp (const IConsultingTemplateInfo_tie* obj, ConsultingTemplateInfo*& ret_, bool interface_addref = false);

	static void make_tie (const ConsultingTemplateInfo* obj, IConsultingTemplateInfo_tie*& ret_, bool interface_addref = false);
	
	static void make_tie (const ConsultingTemplateInfo& obj, IConsultingTemplateInfo_tie*& ret_, const Core::TIEBase* owner);

	ConsultingTemplateInfo* m_impl;

protected:
	virtual void __stdcall get_answer_template_4CEBC82300CD (
		GCI::IO::IStream_tie*& ret_
	) const;

	virtual void __stdcall get_dealer_info_4CEBC83F016B (
		GCI::IO::IString_tie*& ret_
	) const;

	virtual void __stdcall get_preanswer_template_4CEBC80B00FD (
		GCI::IO::IStream_tie*& ret_
	) const;

	virtual void __stdcall get_query_template_4D075AF20237 (
		GCI::IO::IStream_tie*& ret_
	) const;

	virtual TemplateType __stdcall get_template_type_4CEE5713008E (
		const IConsultation_tie* consultation
	) const /*throw (Deleted_tie)*/;
};

} // namespace GblAdapterLib
	

#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_TIE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

