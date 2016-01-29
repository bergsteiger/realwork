////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/FoundContext_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::FoundContext_i
// Заголовок реализации класса серванта для интерфеса FoundContext
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

//#UC START# *4C8F301F031C_CUSTOM_INCLUDES*
//#UC END# *4C8F301F031C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class FoundContext_i; // self forward Var
typedef ::Core::Var<FoundContext_i> FoundContext_i_var;
typedef ::Core::Var<const FoundContext_i> FoundContext_i_cvar;

class FoundContext_i_factory;

class FoundContext_i:
	virtual public FoundContext
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FoundContext_i)
	friend class FoundContext_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FoundContext_i (const GblPilot::ContextList& list);

	virtual ~FoundContext_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FoundContext
	virtual const ContextList& get_list () const;

//#UC START# *4C8F301F031C*
private:
	ContextList m_list;
//#UC END# *4C8F301F031C*
}; // class FoundContext_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_FOUNDCONTEXT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
