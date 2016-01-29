////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Query_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::Query_i
// Заголовок реализации класса серванта для интерфеса FoldersQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryHelper.h"

//#UC START# *45FEB86E0267_CUSTOM_INCLUDES*
//#UC END# *45FEB86E0267_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Query_i; // self forward Var
typedef ::Core::Var<Query_i> Query_i_var;
typedef ::Core::Var<const Query_i> Query_i_cvar;

class Query_i_factory;

class Query_i:
	virtual public FoldersQuery
	, virtual public FoldersQueryFactories
	, virtual public QueryHelper
{
	SET_OBJECT_COUNTER (Query_i)
	friend class Query_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Query_i (GblUserJournal::JournalQuery* journal_query);

	Query_i (GblFolders::SavedQuery* saved_query, bool load_on_demand, FoldersNode* folders_node);

	Query_i (const GblPilotQueryDef::Query& query);

	Query_i (QueryType type);

	virtual ~Query_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

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

	// implemented method from FoldersQuery
	virtual GblFolders::SavedQuery* get_saved_query ();

	// implemented method from FoldersQuery
	virtual void reset_saved_query ();

	// implemented method from Query
	virtual const QueryAttributeList& get_attributes () const;

	// implemented method from Query
	virtual Query* clone ();

	// implemented method from Query
	// Количество найденных документов при последнем поиске.
	virtual unsigned long get_count () const;

	// implemented method from Query
	virtual const Date& get_date () const;

	// implemented method from Query
	virtual void execute (
		DynList* filtrate_list
		, SearchProgressIndicator::ProgressIndicatorForSearch* progress
		, SearchProgressIndicator::CancelSearch*& cancel_process
	);

	// implemented method from Query
	virtual GCI::IO::String* get_comment () const;

	// implemented method from Query
	virtual const GCI::IO::String* get_name () const;

	// implemented method from Query
	// получен ли запрос с фильтра
	virtual bool is_filter_query () const;

	// implemented method from Query
	// Отправить запрос на консультацию
	virtual void send_query ();

	// implemented method from Query
	virtual void set_comment (GCI::IO::String* comment);

	// implemented method from Query
	virtual void set_name (GCI::IO::String* name);

	// implemented method from Query
	virtual QueryType get_type () const;

//#UC START# *45FEB86E0267*
public:
	virtual void complete_search (unsigned long count);
	virtual void check_saved_query ();

private:
	void parse_server_query (const GblPilotQueryDef::Query& server_query);

	void save_data (bool need_save_name_and_comment);
	FoldersNode* m_folders_node;

	mutable GCI::IO::String_var m_name;
	mutable GCI::IO::String_var m_comment;

	GblFolders::SavedQuery_var m_saved_query;
	bool m_parse_now;
	bool m_saved_query_was_load; // нужно для отложенной загрузки сохраненного запроса
	                             // TODO: refactor m_saved_query usage

	bool m_new_content;          // нужно для затычки, которая разруливает сохранение в папки пустых, только что сделанных 
	                             // контентов с работой с загруженным из папок запросами, которые "выдернули" из под ног,
	                             // т.е. удалили из папок
	                             // TODO: see previous TODO
//#UC END# *45FEB86E0267*
}; // class Query_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
