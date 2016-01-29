////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::KViewElementImpl
// Заголовок реализации класса серванта для интерфеса KViewElement
//
// открывает описание элемента в К используя системную функцию ShellExecute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace HelpersImpl {

class KViewElementImpl; // self forward Var
typedef ::Core::Var<KViewElementImpl> KViewElementImpl_var;
typedef ::Core::Var<const KViewElementImpl> KViewElementImpl_cvar;

class KViewElementImpl_factory;

// открывает описание элемента в К используя системную функцию ShellExecute
class KViewElementImpl:
	virtual public Helpers::KViewElement
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (KViewElementImpl)
	friend class KViewElementImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	KViewElementImpl ();

	virtual ~KViewElementImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Helpers::KViewElement
	// формирует ссылку для открытия описания элемента в К
	virtual const std::string make_view_link (IRoseElementPtr elem) const;

	// implemented method from Helpers::KViewElement
	// показывает описание элемента в К
	virtual void view (IRoseElementPtr elem) const;
}; // class KViewElementImpl

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
