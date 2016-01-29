////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalObject_i/ExternalLink_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalObject_i::ExternalLink_i
// Заголовок реализации класса серванта для интерфеса ExternalLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALLINK_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALLINK_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"

namespace GblAdapterLib {

class ExternalLink_i; // self forward Var
typedef ::Core::Var<ExternalLink_i> ExternalLink_i_var;
typedef ::Core::Var<const ExternalLink_i> ExternalLink_i_cvar;

class ExternalLink_i_factory;

class ExternalLink_i:
	virtual public ExternalLink
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ExternalLink_i)
	friend class ExternalLink_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalLink_i (const char* url);

	virtual ~ExternalLink_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_url;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ExternalLink
	// Ссылка на внешние ресурсы в стандарте URL.
	virtual const GCI::IO::String* get_url () const;
}; // class ExternalLink_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOBJECT_I_EXTERNALLINK_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
