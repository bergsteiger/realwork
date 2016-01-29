////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/InternetSupport_i/DecisionsArchiveSupport_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::InternetSupport_i::DecisionsArchiveSupport_i
// Заголовок реализации класса серванта для интерфеса DecisionsArchiveSupport
//
// поддержка доступа к архивам судебных решений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/logic/tribool.hpp"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"

namespace GblAdapterLib {

class DecisionsArchiveSupport_i; // self forward Var
typedef ::Core::Var<DecisionsArchiveSupport_i> DecisionsArchiveSupport_i_var;
typedef ::Core::Var<const DecisionsArchiveSupport_i> DecisionsArchiveSupport_i_cvar;

class DecisionsArchiveSupport_i_factory;

// поддержка доступа к архивам судебных решений
class DecisionsArchiveSupport_i:
	virtual public DecisionsArchiveSupport
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (DecisionsArchiveSupport_i)
	friend class DecisionsArchiveSupport_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <DecisionsArchiveSupport_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DecisionsArchiveSupport_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DecisionsArchiveSupport_i ();

	virtual ~DecisionsArchiveSupport_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable boost::tribool m_archive_available;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();

	// implemented method from DecisionsArchiveSupport
	// архив судебных решений доступен
	virtual bool archive_available () const;

	// implemented method from DecisionsArchiveSupport
	// получить ссылку для перехода на архив судебных решений
	virtual GCI::IO::String* get_archive_url () const;
}; // class DecisionsArchiveSupport_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_I_DECISIONSARCHIVESUPPORT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
