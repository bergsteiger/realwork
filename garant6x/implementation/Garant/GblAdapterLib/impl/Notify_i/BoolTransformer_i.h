////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/BoolTransformer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::BoolTransformer_i
// Заголовок реализации класса серванта для интерфеса DataTransformer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"

namespace GblAdapterLib {

class BoolTransformer_i; // self forward Var
typedef ::Core::Var<BoolTransformer_i> BoolTransformer_i_var;
typedef ::Core::Var<const BoolTransformer_i> BoolTransformer_i_cvar;

class BoolTransformer_i_factory;

class BoolTransformer_i:
	virtual public DataTransformer
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (BoolTransformer_i)
	friend class BoolTransformer_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BoolTransformer_i ();

	virtual ~BoolTransformer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DataTransformer
	virtual Variant* get_variant (const CORBA::Any& data) const;
}; // class BoolTransformer_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_BOOLTRANSFORMER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
