////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ListEntryInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::ListEntryInfo_i
// Заголовок реализации класса серванта для интерфеса ListEntryInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"

namespace GblAdapterLib {

class ListEntryInfo_i; // self forward Var
typedef ::Core::Var<ListEntryInfo_i> ListEntryInfo_i_var;
typedef ::Core::Var<const ListEntryInfo_i> ListEntryInfo_i_cvar;

class ListEntryInfo_i_factory;

class ListEntryInfo_i:
	virtual public ListEntryInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ListEntryInfo_i)
	friend class ListEntryInfo_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ListEntryInfo_i (const GblPilot::ListEntryInfo& info, const NodeBase* root);

	ListEntryInfo_i (const GblPilot::ListEntryInfo& info);

	virtual ~ListEntryInfo_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	bool operator== (const ListEntryInfo_i* lei) const;

private:
	virtual void build_entry_list (const NodeBase* root);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned long m_data_for_compare;

	GblPilotDef::SubParaList_var m_entry_list;

	GblPilot::ListEntryInfo m_lei;

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

	// implemented method from ListEntryInfo
	virtual const Document* get_doc () const;
	virtual Document* get_doc ();

	// implemented method from ListEntryInfo
	virtual const GblPilotDef::SubParaList& get_entry_list () const;

	// implemented method from ListEntryInfo
	virtual const GblPilotDef::WordList& get_relevance_words_list () const;

	// implemented method from ListEntryInfo
	virtual const PId get_pid () const;

	// implemented method from ListEntryInfo
	virtual unsigned long get_position () const;

	// implemented method from ListEntryInfo
	// Релевантность. Для списков без релевантности всегда 0.
	virtual const short get_relevance () const;

	// implemented method from ListEntryInfo
	virtual PositionType get_type () const;
}; // class ListEntryInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_LISTENTRYINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
