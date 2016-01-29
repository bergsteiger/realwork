////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i
// Заголовок реализации класса серванта для интерфеса PharmFirmListEntry
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"

namespace GblAdapterLib {

class PharmFirmListEntry_i; // self forward Var
typedef ::Core::Var<PharmFirmListEntry_i> PharmFirmListEntry_i_var;
typedef ::Core::Var<const PharmFirmListEntry_i> PharmFirmListEntry_i_cvar;

class PharmFirmListEntry_i_factory;

class PharmFirmListEntry_i:
	virtual public PharmFirmListEntry
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PharmFirmListEntry_i)
	friend class PharmFirmListEntry_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PharmFirmListEntry_i (GCD::ObjectID id);

	virtual ~PharmFirmListEntry_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Идентификатор документа
	ObjectId m_document_id;

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

	// implemented method from PharmFirmListEntry
	virtual Document* get_document () const;
}; // class PharmFirmListEntry_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
