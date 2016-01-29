////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::JournalBookmark_i
// Заголовок реализации класса серванта для интерфеса JournalBookmark
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalDefC.h"

namespace GblAdapterLib {

class JournalBookmark_i; // self forward Var
typedef ::Core::Var<JournalBookmark_i> JournalBookmark_i_var;
typedef ::Core::Var<const JournalBookmark_i> JournalBookmark_i_cvar;

class JournalBookmark_i_factory;

class JournalBookmark_i:
	virtual public JournalBookmark
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (JournalBookmark_i)
	friend class JournalBookmark_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	JournalBookmark_i (ObjectId doc_id, ParaId para_id);

	JournalBookmark_i (GblUserJournal::JournalBookmark* journal_bookmark);

	virtual ~JournalBookmark_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GblUserJournalDef::JournalBookmark_var m_bookmark;

	mutable GCI::IO::String_var m_full_name;

	GblUserJournal::JournalBookmark_var m_journal_bookmark;

	mutable GCI::IO::String_var m_name;

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

	// implemented method from JournalBookmark
	virtual const Document* get_document () const;
	virtual Document* get_document ();

	// implemented method from JournalBookmark
	// Полное имя (хинт)
	virtual const GCI::IO::String* get_full_name () const;
	virtual GCI::IO::String* get_full_name ();

	// implemented method from JournalBookmark
	// Получить  серверную журнальную закладку
	virtual const GblUserJournalDef::JournalBookmark& get_journal_bookmark () const;

	// implemented method from JournalBookmark
	// Имя
	virtual const GCI::IO::String* get_name () const;
	virtual GCI::IO::String* get_name ();

	// implemented method from JournalBookmark
	virtual const unsigned long get_para_id () const;
}; // class JournalBookmark_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_JOURNALBOOKMARK_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
