////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ConsultingStub_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ConsultingStub_i
// Заголовок реализации класса серванта для интерфеса ConsultingStub
//
// заглушка для документа-консультации К259180433
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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

// заглушка для документа-консультации К259180433
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
	// Возвращает true, если разрешена постановка на контроль
	virtual const bool get_can_set_to_control () const;

	// implemented method from Controllable
	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// implemented method from Controllable
	// Возврящает текущее значение статуса изменений.
	virtual unsigned long get_control_status ();

	// implemented method from Controllable
	// Сравнение объектов на контроле.
	virtual bool is_same_controllable (const Controllable* other);

	// implemented method from Controllable
	// Получить объект на контроле.
	virtual Core::IObject* open ();

	// implemented method from Controllable
	// Сбрасывает статус изменений в ноль.
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
	// Статус изменения документа
	virtual const unsigned long get_change_status () const;

	// implemented method from Document
	virtual const CommentsParaList& get_comments_para_list () const;

	// implemented method from Document
	virtual const NodeBase* get_contents_root () const
		/*throw (CanNotFindData)*/;
	virtual NodeBase* get_contents_root ()
		/*throw (CanNotFindData)*/;

	// implemented method from Document
	// Создает экземпляр Закладки на заданный идентификатор параграфа. Присваивает ей в качестве
	// названия короткое имя документа. А в качестве full_name имя документа и имя ближайшего (сверху)
	// саба или блока (как в списках).
	virtual Bookmark* create_bookmark (ParaId para, bool is_para) const;

	// implemented method from Document
	// Создать журнальную закладку
	virtual JournalBookmark* create_journal_bookmark (ParaId para) const;

	// implemented method from Document
	// Возвращает документ - редакцию, заказанную через  filters.
	// Если текущая редакция равна заказанной - возвращает NULL
	virtual Document* create_view (DocumentState* filters);

	// implemented method from Document
	virtual const DocumentState* get_current_state () const;
	virtual DocumentState* get_current_state ();

	// implemented method from Document
	virtual DiffData* diff (const GCD::PID& pid) const;

	// implemented method from Document
	virtual DocumentType get_doc_type () const;

	// implemented method from Document
	// Не показывать статус изменения данного документа в текущей сессии
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
	// вернуть число документов для автореферата
	virtual size_t get_auto_referat_doc_count () const /*throw (Unsupported)*/;

	// implemented method from Document
	virtual GCI::IO::Stream* get_autoreferat_header_evd () const /*throw (Unsupported)*/;

	// implemented method from Document
	virtual void get_correspondents (const NodeBase* category, CatalogBase*& out_list) const;

	// implemented method from Document
	// Возвращает список корреспондентов к фрагменту документа (список параграфов) для указанной
	// категории (category).
	// 
	// для редакций, отлчных от "главной", возвращает NULL
	virtual void get_correspondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const;

	// implemented method from Document
	// Получить список выпускаемых фирмой препаратов
	virtual CatalogBase* get_drug_list () const /*throw (CanNotFindData)*/;

	// implemented method from Document
	// возвращает evd поток документа - совета дня или evd поток заглушки для отсутствующего в базе
	// документа или документа запрещенного к просмотру
	virtual GCI::IO::Stream* get_evd_stream () const;

	// implemented method from Document
	// Получение флеш-ролика
	virtual ExternalObject* get_flash () const;

	// implemented method from Document
	// Получить url для отсканированного WWW-образа документа.
	virtual ExternalLink* get_internet_image_url (long block_id) const;

	// implemented method from Document
	virtual Link* get_link (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// implemented method from Document
	virtual LinkInfo* get_link_info (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// implemented method from Document
	// Получить интерфейс объекта, на который указывает гипертекстовая ссылка, по внутреннему
	// идентификатору.
	// Возвращается интерфейс на объект (obj) и тип объекта (obj_type).
	// Дополнительно можно получить интерфейс (missing_info) с информацией, в каких блоках (базах)
	// содержится отсутствующий объект (метод get_missing_info)
	// Будет использоваться для перехода по гипертекстовой ссылке.
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
	// Возвращает расширенную информацию по отсутствующему объекту (pid - идентификатор и класс
	// объекта по ссылке)
	virtual void get_missing_info_for_object (const PId& pid, MissingInfo*& missing_info) const;

	// implemented method from Document
	// Получить данные по мульnиссылке в виде списка (DocId, SubId)
	virtual DocPointList* get_multi_link_info (
		unsigned long doc_id
		, const Topic& id
	) const /*throw (
		CanNotFindData
		, InternalDatabaseError
	)*/;

	// implemented method from Document
	// Возвращает информацию об интервале неуверенности документа. Если указанная в параметра date
	// дата не попадает в интревал бросает CanNotFindData
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
	// Возвращает список респондентов к фрагменту документа (список параграфов) для указанной
	// категории (category).
	// 
	// для редакций, отлчных от "главной", возвращает NULL
	virtual void get_respondents_to_part (
		const PositionList& pos_list
		, const NodeBase* category
		, CatalogBase*& out_list
	) const;

	// implemented method from Document
	// Получить список похожих документов
	virtual void get_same_documents (CatalogBase*& out_list) const;

	// implemented method from Document
	virtual void get_same_to_point (ExternalID id, CatalogBase*& out_list) const;

	// implemented method from Document
	// Получить расширенную информацию по текущему документу (в случае его отсутствия - в каких блоках
	// этот документ присутствует)
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
	// для документов типа DT_BOOK возвращает false,
	// для остальных true
	virtual bool has_attributes () const;

	// implemented method from Document
	// есть ли у документа хронология рассмотрения судебного дела
	// K555095873
	virtual bool has_chronology () const;

	// implemented method from Document
	// Проверка наличия корреспондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список корреспондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	virtual bool has_correspondents (const NodeBase* category) const;

	// implemented method from Document
	// Проверка наличия WWW-образа у текущего документа.
	// Возвращает true в случае, если у текущего документа есть WWW-образ.
	virtual bool has_internet_image () const;

	// implemented method from Document
	// Функция показывает наличие следующей редакции для объекта.
	// Следующая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более поздней (чем текущая) редакции.
	virtual bool has_next_redaction () const;

	// implemented method from Document
	// Функция показывает наличие предыдущей редакции для объекта.
	// Предыдущая редакция считается относительно текущего состояния (current_redaction).
	// Возвращает True в случае наличия хотябы одной более ранней (чем текущая) редакции.
	virtual bool has_prev_redaction () const;

	// implemented method from Document
	// Проверка наличия справки у текущего документа.
	// Возвращает true в случае, если у текущего документа есть справка.
	// 
	// для редакций, отличных от "главной", поведение такое же как и для "главной"
	virtual bool has_related_doc () const;

	// implemented method from Document
	// Проверка наличия респондентов (любогй категории) у текущего документа.
	// Возвращает true в случае, если список респондентов для документа по категории CR_ALL не пуст.
	// 
	// для редакций, отличных от "главной", возвращает FALSE
	virtual bool has_respondents (const NodeBase* category) const;

	// implemented method from Document
	// Проверка наличия похожих документов
	virtual bool has_same_documents () const;

	// implemented method from Document
	// Есть ли у документа перевод
	virtual bool has_translation () const;

	// implemented method from Document
	// Присутствие предупреждения.
	virtual bool has_warning () const;

	// implemented method from Document
	// внутренний номер документа в базе
	virtual unsigned long get_internal_id () const;

	// implemented method from Document
	// Специальный метод, позволяющий выяснить "жив" ли документ на сервере приложений. Если документ
	// "жив" - возвращается `true` (как правило такая проверка нужна, когда документ может быть
	// удален, например во время обновления базы). Результаты данного метода не кешируются на
	// адаптере, т.е. вызов этого метода всегда обращается к серверу приложений.
	virtual bool is_alive () const;

	// implemented method from Document
	// Метод позволяет определить попадает ли date в интервал неуверенности документа.
	virtual bool is_date_in_not_sure_interval (const Date& date) const;

	// implemented method from Document
	// индексирован ли документ для морфопоиска
	virtual bool is_morpho_search_supported () const;

	// implemented method from Document
	virtual bool is_my_bookmark (const Bookmark* bookmark) const;

	// implemented method from Document
	virtual bool is_same_document (const Document* doc) const;

	// implemented method from Document
	virtual bool is_same_redaction (const Document* view) const;

	// implemented method from Document
	// Возвращает равенство документов с учетом их состояния (в отличии от is_same_entity, который
	// возвращает равенство без учета состояния). Состоянием документа является суперпозиция номера
	// редакции, языка и списка извлечений.
	virtual bool is_same_view (const Document* view) const;

	// implemented method from Document
	// Проверка возможности отображения атрибутов документа для текущего документа.
	// Возвращает true в случае, если показ атрибутов разрешен.
	// 
	// для редакций проверяются атрибуты, соответсвующие редакции (т.е. соответсвующие топику редакции
	// )
	virtual bool may_show_attributes () const;

	// implemented method from Document
	// Имя документа.
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	// implemented method from Document
	// Доступна новая ревизия документа (для супермобильной версии)
	virtual const bool get_new_revision_available () const;

	// implemented method from Document
	// True - если документ не подключен к машине времени
	virtual const bool get_not_tm () const;

	// implemented method from Document
	virtual const RedactionInfoList& get_redactions_list () const;

	// implemented method from Document
	virtual const Document* get_related_doc () const;
	virtual Document* get_related_doc ();

	// implemented method from Document
	// Краткое имя документа.
	virtual const GCI::IO::String& get_short_name () const;
	virtual GCI::IO::String& get_short_name ();

	// implemented method from Document
	// размер документа в байтах
	virtual unsigned long get_size () const;

	// implemented method from Document
	// Статус документа
	virtual const ItemStatus get_status () const;

	// implemented method from Document
	virtual const LanguagesList& get_text_languages () const;

	// implemented method from Document
	virtual const Document* get_translation () const;
	virtual Document* get_translation ();

	// implemented method from Document
	// Предупреждение к документу.
	virtual const GCI::IO::String& get_warning () const;
	virtual GCI::IO::String& get_warning ();

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

	// implemented method from Likeable
	// Доступность операции оценки
	virtual const bool get_can_like () const;

	// implemented method from Likeable
	// Нравится
	virtual void like () const;

	// implemented method from Likeable
	// Не нравится
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
