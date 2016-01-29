////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Complect_i/ComplectInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Complect_i::ComplectInfo_i
// Заголовок реализации класса серванта для интерфеса ComplectInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/Notify.h"

//#UC START# *457452900109_CUSTOM_INCLUDES*
//#UC END# *457452900109_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class ComplectInfo_i; // self forward Var
typedef ::Core::Var<ComplectInfo_i> ComplectInfo_i_var;
typedef ::Core::Var<const ComplectInfo_i> ComplectInfo_i_cvar;

class ComplectInfo_i_factory;

class ComplectInfo_i:
	virtual public ComplectInfo
	, virtual public Listener
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ComplectInfo_i)
	friend class ComplectInfo_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ComplectInfo_i ();

	virtual ~ComplectInfo_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Core::Box<ComplectType> m_complect_type;

	mutable GCI::IO::String_var m_dealer_info;

	mutable GCI::IO::String_var m_old_base_warning;

	mutable GCI::IO::String_var m_owner;

	mutable GCI::IO::String_var m_unexist_doc_message;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ComplectInfo
	virtual const GCI::IO::String* get_dealer_info () const;
	virtual GCI::IO::String* get_dealer_info ();

	// implemented method from ComplectInfo
	virtual VisualRepresentationList* get_visual_representation_data () const;

	// implemented method from ComplectInfo
	virtual const NodeBase* get_info  () const
		/*throw (CanNotFindData)*/;
	virtual NodeBase* get_info  ()
		/*throw (CanNotFindData)*/;

	// implemented method from ComplectInfo
	virtual const GCI::IO::String* get_old_base_warning () const;
	virtual GCI::IO::String* get_old_base_warning ();

	// implemented method from ComplectInfo
	virtual const GCI::IO::String* get_owner  () const;
	virtual GCI::IO::String* get_owner  ();

	// implemented method from ComplectInfo
	virtual ComplectType get_type () const;

	// implemented method from ComplectInfo
	virtual const GCI::IO::String* get_unexist_doc_message () const;
	virtual GCI::IO::String* get_unexist_doc_message ();

	// implemented method from Listener
	virtual void fire (const Notification* notify) const;

//#UC START# *457452900109*
//#UC END# *457452900109*
}; // class ComplectInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_I_COMPLECTINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
