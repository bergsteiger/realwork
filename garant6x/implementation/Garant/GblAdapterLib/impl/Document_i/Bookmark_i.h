////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/Bookmark_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::Bookmark_i
// Заголовок реализации класса серванта для интерфеса Bookmark
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"

namespace GblAdapterLib {

class Bookmark_i; // self forward Var
typedef ::Core::Var<Bookmark_i> Bookmark_i_var;
typedef ::Core::Var<const Bookmark_i> Bookmark_i_cvar;

class Bookmark_i_factory;

class Bookmark_i:
	virtual public Bookmark
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Bookmark_i)
	friend class Bookmark_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Bookmark_i (const GblPilotDef::Bookmark& bookmark, GblFolders::DocBookmark* doc_bookmark, FoldersNode* folders_node);

	virtual ~Bookmark_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void clear_doc_bookmark ();

	virtual GblFolders::DocBookmark* get_doc_bookmark ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GCI::IO::String_var m_comment;

	GblFolders::DocBookmark_var m_doc_bookmark;

	FoldersNode_var m_folders_node;

	mutable GCI::IO::String_var m_name;

	ParaId m_para_id;

	PId m_pid;

	GblPilotDef::Bookmark m_pilot_bookmark;

	mutable GCI::IO::String_var m_saved_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Bookmark
	// полное имя документа и блока/саба на который указывает закладка. Используется в качестве hint
	// в Папках.
	virtual const GCI::IO::String& get_comment () const;
	virtual GCI::IO::String& get_comment ();

	virtual void set_comment (GCI::IO::String* comment);

	// implemented method from Bookmark
	virtual const Document* get_document () const;
	virtual Document* get_document ();

	// implemented method from Bookmark
	// Названите закладки. Используется в качестве caption в Папках.
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);

	// implemented method from Bookmark
	virtual ParaId get_paragraph () const;

	// implemented method from Bookmark
	virtual const PId& get_pid () const;

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
}; // class Bookmark_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_BOOKMARK_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
