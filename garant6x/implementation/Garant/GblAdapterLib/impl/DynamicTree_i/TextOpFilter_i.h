////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TextOpFilter_i
// Заголовок реализации класса серванта для интерфеса TextOptFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TEXTOPFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TEXTOPFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class TextOpFilter_i; // self forward Var
typedef ::Core::Var<TextOpFilter_i> TextOpFilter_i_var;
typedef ::Core::Var<const TextOpFilter_i> TextOpFilter_i_cvar;

class TextOpFilter_i_factory;

class TextOpFilter_i:
	virtual public TextOptFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TextOpFilter_i)
	friend class TextOpFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TextOpFilter_i ();

	virtual ~TextOpFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_without_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TextOptFilter
	virtual bool get_without_name () const;
	virtual void set_without_name (bool without_name);
}; // class TextOpFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_TEXTOPFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
