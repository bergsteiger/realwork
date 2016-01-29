////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/InternetSupport_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::InternetSupport_i
// Заголовок реализации класса серванта для интерфеса InternetSupport
//
// поддержка работы пользователей через internet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"

namespace GblAdapterLib {

class InternetSupport_i; // self forward Var
typedef ::Core::Var<InternetSupport_i> InternetSupport_i_var;
typedef ::Core::Var<const InternetSupport_i> InternetSupport_i_cvar;

class InternetSupport_i_factory;

// поддержка работы пользователей через internet
class InternetSupport_i:
	virtual public InternetSupport
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (InternetSupport_i)
	friend class InternetSupport_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <InternetSupport_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <InternetSupport_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	InternetSupport_i ();

	virtual ~InternetSupport_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// Разрешена ли проверка ревизий
	mutable boost::tribool m_revision_check_enabled;

	// Нужно ли показывать блямбу об отключении онлайн проверки
	mutable boost::tribool m_show_warning;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from InternetSupport
	// получить URL для заданного документа
	virtual GCI::IO::String* get_url_for_document (unsigned long doc_id, unsigned long para_id) const;

	// implemented method from InternetSupport
	// получить URL для интранет версии
	virtual GCI::IO::String* get_url_for_internet_version () const;

	// implemented method from InternetSupport
	// Разрешен ли Интернет-Агент.
	virtual bool is_internet_agent_enabled () const;

	// implemented method from InternetSupport
	// Разрешена ли онлайн проверка ревизий документов (для супермобильной версии)
	virtual bool revision_check_enabled () const;

	// implemented method from InternetSupport
	// Нужно ли показывать блямбу об отключении онлайн проверки
	virtual bool show_warning () const;
}; // class InternetSupport_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_INTERNETSUPPORT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
