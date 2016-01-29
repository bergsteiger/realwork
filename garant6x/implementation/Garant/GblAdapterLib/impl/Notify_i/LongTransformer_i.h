////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Notify_i/LongTransformer_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Notify_i::LongTransformer_i
// Заголовок реализации класса серванта для интерфеса DataTransformer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_H__
#define __GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/NotifyLocal/NotifyLocal.h"

namespace GblAdapterLib {

class LongTransformer_i; // self forward Var
typedef ::Core::Var<LongTransformer_i> LongTransformer_i_var;
typedef ::Core::Var<const LongTransformer_i> LongTransformer_i_cvar;

class LongTransformer_i_factory;

class LongTransformer_i:
	virtual public DataTransformer
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (LongTransformer_i)
	friend class LongTransformer_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LongTransformer_i ();

	virtual ~LongTransformer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DataTransformer
	virtual Variant* get_variant (const CORBA::Any& data) const;
}; // class LongTransformer_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_NOTIFY_I_LONGTRANSFORMER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
