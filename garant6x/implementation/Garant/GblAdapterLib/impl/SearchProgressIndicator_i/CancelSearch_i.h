////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/SearchProgressIndicator_i/CancelSearch_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::SearchProgressIndicator_i::CancelSearch_i
// Заголовок реализации класса серванта для интерфеса CancelSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Business/GblPilot/GblPilotC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"

namespace GblAdapterLib {
namespace SearchProgressIndicator_i {

class CancelSearch_i; // self forward Var
typedef ::Core::Var<CancelSearch_i> CancelSearch_i_var;
typedef ::Core::Var<const CancelSearch_i> CancelSearch_i_cvar;

class CancelSearch_i_factory;

class CancelSearch_i:
	virtual public SearchProgressIndicator::CancelSearch
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CancelSearch_i)
	friend class CancelSearch_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CancelSearch_i (GblPilot::SearchManager* search_manager);

	virtual ~CancelSearch_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblPilot::SearchManager_var m_search_manager;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CancelLongProcess
	// Вызывается для прерывания длительного процесса.
	virtual void cancel_process () const;
}; // class CancelSearch_i

} // namespace SearchProgressIndicator_i
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCHPROGRESSINDICATOR_I_CANCELSEARCH_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
