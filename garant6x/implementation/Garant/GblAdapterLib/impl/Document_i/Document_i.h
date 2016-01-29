////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Document_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Document_i
// Заголовок реализации класса серванта для интерфеса Document
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include <map>
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeDelegate.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentState_i.h"
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocWithPid.h"

// forward decls for defined friends
namespace GblAdapterLib {
	class DocumentState_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DocumentMaster;
class Document_i; // self forward Var
typedef ::Core::Var<Document_i> Document_i_var;
typedef ::Core::Var<const Document_i> Document_i_cvar;

class Document_iServantFactory;

class Document_i:
	virtual public Document
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
	, virtual public GSI::NotifyService_i::Consumer_i
	, virtual public DocWithPid
{
	SET_OBJECT_COUNTER (Document_i)
	friend class Document_iServantFactory;
	friend class DocumentState_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	class AttributeTree;
	typedef Core::Var<AttributeTree> AttributeTree_var;
	typedef Core::Var<const AttributeTree> AttributeTree_cvar;

	class AttributeTree :
		virtual public Tree<NodeBase_i, NodeDelegate>
	{
		SET_OBJECT_COUNTER (AttributeTree)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit AttributeTree (GTree::Tree* tree);

	public:
		virtual ~AttributeTree ();

	}; // class AttributeTree

public:
	typedef std::map < GCD::ObjectID, Document* > AOM;

	static const unsigned long OID_NOT_SHURE_WARNING_DOC;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	struct AomSingletonDataType {
		AOM ptr;
	};
	
	typedef ACE_Singleton <
		AomSingletonDataType
		, ACE_SYNCH_RECURSIVE_MUTEX
	> AomSingleton;


//////////////////////////////////////////////////////////////////////////////////////////
// static data accessors
protected:
	static const AOM& get_aom ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Document_i ();

	explicit Document_i (GblPilot::Document* document);

	explicit Document_i (const char* name);

	virtual ~Document_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	const RedactionInfo& get_current_redaction_info () const;

	virtual void set_list_info (const ListEntryInfo* info);

protected:
	virtual void build_extruct_list (GblPilotDef::SubParaList& sp_list) const;

	virtual const DocumentMaster* get_master () const = 0;

	virtual bool has_same_redactions (const Document_i* comparable) const;

	virtual bool is_date_in_not_sure_interval_i (const Date& date, NotSureInfo& not_sure_info) const;

	virtual void load (GblPilotDef::ExtendedDocInfo* edi) const;

	virtual void load_and_update () const;

	virtual void load_contents_data_if_empty ();

	virtual void load_server_doc () const = 0;

	virtual DocumentTextProvider* make_text_provider (
		GblPilot::Document* server_doc
		, const GblPilot::HighlightHandle& handle
		, bool all_at_once
	) const;

	RedactionID redaction_id () const;

	virtual void set_inner_state (const DocumentState_i* state);

private:
	virtual ExternalLink* get_internet_image_url_i (long block_id) const;

	// получить тултип к ссылке
	virtual GCI::IO::String* get_linked_hint (unsigned long doc_id, const Topic& id, RedactionID rid) const;

	// // UC 72.5.2 пункт 3) [пункты 1) и 2) выполняются автоматически]
	bool is_yellow_medal_time_machine_warning (const Date& date, const Date& redaction_date) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable NodeBase_var m_attributes_root;

	BookmarkList m_bookmark_list;

	// Можно ли оценивать
	mutable boost::tribool m_can_like;

	CommentsParaList m_comments_para_list;

	bool m_contents_data_loaded;

	Core::Mutex m_contents_data_mutex;

	// Маска типизированных корреспондентов
	mutable GblPilotDef::KindMask m_correspondent_mask;

	DocumentState_i_var m_current_state;

	mutable GblPilotDef::DocumentPartsMask m_doc_part_mask;

	mutable GblPilotDef::DocumentSize m_doc_size;

	mutable GblPilot::Document_var m_document;

	ExternalObjectDataList m_external_object_data_list;

	mutable char m_has_next_redaction_;

	mutable char m_has_prev_redaction_;

	// Время последней проверки изменений документа
	mutable Date m_last_check;

	mutable bool m_loaded;

	mutable GCI::IO::String_var m_name_impl;

	// Маска типизированных респондентов
	mutable GblPilotDef::KindMask m_respondent_mask;

	mutable GCI::IO::String_var m_short_name_impl;

	// Статус изменения документа
	mutable unsigned long m_status_changes;

	// Статус изменения документа требует обновления
	mutable bool m_status_changes_updated;

	mutable ItemStatus m_status_impl;

	std::string m_time_machine_warning_string;

	mutable Document_var m_translation_impl;

	mutable GCI::IO::String_var m_warning_impl;

	mutable boost::tribool m_yellow_time_machine_warning;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual GblPilotDef::KindMask get_correspondent_mask () const;

	virtual GblPilotDef::DocumentPartsMask get_doc_part_mask () const;

	virtual GblPilotDef::DocumentSize get_doc_size () const;

	virtual GblPilot::Document* get_document () const;

	virtual void set_document (GblPilot::Document* document) const;

	virtual char get_has_next_redaction_ () const;

	virtual char get_has_prev_redaction_ () const;

	virtual bool get_loaded () const;

	virtual const GCI::IO::String* get_name_impl () const;

	virtual GblPilotDef::KindMask get_respondent_mask () const;

	virtual const GCI::IO::String* get_short_name_impl () const;

	virtual ItemStatus get_status_impl () const;

	virtual const std::string& get_time_machine_warning_string () const;

	virtual const Document* get_translation_impl () const;

	virtual const GCI::IO::String* get_warning_impl () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from Controllable
	// Получить объект на контроле.
	virtual Core::IObject* open ();

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
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from GSI::NotifyService::Consumer
	// Для получения сообщений реализация перекрывает этот метод.
	virtual void fire_event (const CORBA::Any& event);

}; // class Document_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
