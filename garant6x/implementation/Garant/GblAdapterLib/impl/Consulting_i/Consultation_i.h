////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Consultation_i
// Заголовок реализации класса серванта для интерфеса Consultation
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garantServer/src/Business/GblConsultingClient/GblConsultingClientC.h"

//#UC START# *45704FB40290_CUSTOM_INCLUDES*
//#UC END# *45704FB40290_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Consultation_i; // self forward Var
typedef ::Core::Var<Consultation_i> Consultation_i_var;
typedef ::Core::Var<const Consultation_i> Consultation_i_cvar;

class Consultation_i_factory;

// реализация
class Consultation_i:
	virtual public Consultation
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Consultation_i)
	friend class Consultation_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// список удалённых консультаций
	class ListOfDeletedConsultations {
		SET_OBJECT_COUNTER (ListOfDeletedConsultations)

		// singleton declaration
		typedef ACE_Singleton <ListOfDeletedConsultations, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
		friend class ACE_Singleton <ListOfDeletedConsultations, ACE_SYNCH_RECURSIVE_MUTEX>;
	public:
		static ListOfDeletedConsultations* instance () {
			return Singleton::instance();
		}

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declarations
public:
		typedef FolderId NodeId;

		typedef std::vector < NodeId > Nodes;

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	protected:
		virtual ~ListOfDeletedConsultations ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		void add_node (NodeId data);

		bool is_deleted (NodeId data) const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		Nodes m_nodes;
	}; // class ListOfDeletedConsultations

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Consultation_i (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node);

	virtual ~Consultation_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void check_deleted () const /*throw (Deleted)*/;

	virtual GblConsultingClient::Consultation* get_cached_server_consultation () const;

	// пометить консультацию как удалённую
	void mark_deleted ();

protected:
	virtual void refresh_node_flags ();

private:
	bool is_evd_paras (const GblConsultingDef::ParaList& server_list) const;

	void translate_evd_paras (const GblConsultingDef::ParaList& server_list, ParasList& adapter_list) const;

	// возвращает true, если в ответе лежит evd
	bool translate_paras (const GblConsultingDef::ParaList& server_list, ParasList& adapter_list) const;

	void translate_txt_paras (const GblConsultingDef::ParaList& server_list, ParasList& adapter_list) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable ParasList m_answer;

	mutable Core::Box<DateTime> m_creation_date;

	mutable GCI::IO::String_var m_expert_name;

	FoldersNode_var m_folders_node;

	mutable GCI::IO::String_var m_id;

	mutable Core::Box<DateTime> m_modification_date;

	mutable GCI::IO::String_var m_name;

	mutable GCI::IO::String_var m_query;

	mutable ParasList m_query_paras;

	GblConsultingClient::Consultation_var m_server_consultation;

	mutable GCI::IO::String_var m_user_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Consultation
	// создать оценку
	virtual Estimation* create_estimation () const;

	// implemented method from Consultation
	// Дата создания
	virtual const DateTime& get_creation_date () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	virtual const ParasList get_expert_info () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	virtual const GCI::IO::String& get_expert_name () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Получить уведомление или ответ на запрос
	virtual Document* get_answer () const /*throw (Deleted, OldFormatConsultation)*/;

	// implemented method from Consultation
	virtual const ParasList& get_answer_data (bool& is_evd) const;

	// implemented method from Consultation
	// Получить список документов ответа
	virtual DynList* get_document_list () const /*throw (NoDocumentList, Deleted, OldFormatConsultation)*/;

	// implemented method from Consultation
	// Получить запрос
	virtual Document* get_query () const /*throw (Deleted, OldFormatConsultation)*/;

	// implemented method from Consultation
	// получить запрос в виде списка параграфов
	virtual const ParasList& get_query_by_paras () const;

	// implemented method from Consultation
	virtual bool has_estimation () const /*throw (Deleted)*/;

	// implemented method from Consultation
	virtual bool has_list () const /*throw (Deleted)*/;

	// implemented method from Consultation
	virtual bool has_payment_information () const /*throw (Deleted)*/;

	// implemented method from Consultation
	// Идентификатор консультации
	virtual const GCI::IO::String& get_id () const
		/*throw (Deleted)*/;
	virtual GCI::IO::String& get_id ()
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Дата последнего изменения статуса
	virtual const DateTime& get_modification_date () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Имя консультации (текст запроса)
	virtual const GCI::IO::String& get_name () const
		/*throw (Deleted)*/;
	virtual GCI::IO::String& get_name ()
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Подвердить (answer = true)/отказаться (false) от оплаты
	virtual void payment_confirm (bool answer) /*throw (NoConnection, PaymentForbidden)*/;

	// implemented method from Consultation
	virtual const GCI::IO::String& get_query_data () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Помечают консультацию как прочитанную
	virtual void read () /*throw (Deleted)*/;

	// implemented method from Consultation
	virtual const Date get_reply_date () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	// Отправить оценку
	virtual void send_estimation (const Estimation* value) /*throw (NoConnection, NoSubscription, Deleted)*/;

	// implemented method from Consultation
	// Статус консультации
	virtual ConsultationStatus get_status () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	virtual const GblConsultingDef::HCConsultationDataType get_type () const
		/*throw (Deleted)*/;

	// implemented method from Consultation
	virtual const GCI::IO::String& get_user_name () const
		/*throw (Deleted)*/;

	// implemented method from EntityBase
	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// идентификатор
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// свойство изменённости
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// Перезаписать сущность текущей сущностью.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

//#UC START# *45704FB40290*
private:
	mutable bool m_is_evd;
//#UC END# *45704FB40290*
}; // class Consultation_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
