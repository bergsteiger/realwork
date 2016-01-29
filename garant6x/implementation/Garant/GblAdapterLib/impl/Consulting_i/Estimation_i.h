////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Estimation_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Estimation_i
// Заголовок реализации класса серванта для интерфеса Estimation
//
// реализация интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/Consulting.h"

namespace GblAdapterLib {

class Estimation_i; // self forward Var
typedef ::Core::Var<Estimation_i> Estimation_i_var;
typedef ::Core::Var<const Estimation_i> Estimation_i_cvar;

class Estimation_i_factory;

// реализация интерфейса
class Estimation_i:
	virtual public Estimation
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Estimation_i)
	friend class Estimation_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Estimation_i ();

	virtual ~Estimation_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_text;

	EstimationValue m_value;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Estimation
	// комментарий к оценке
	virtual const GCI::IO::String& get_text () const;
	virtual GCI::IO::String& get_text ();

	virtual void set_text (GCI::IO::String* text);

	// implemented method from Estimation
	// оценка
	virtual EstimationValue get_value () const;

	virtual void set_value (EstimationValue value);
}; // class Estimation_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_ESTIMATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
