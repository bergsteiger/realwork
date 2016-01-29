////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CountryFilter_i
// Заголовок реализации класса серванта для интерфеса CountryFilter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class CountryFilter_i; // self forward Var
typedef ::Core::Var<CountryFilter_i> CountryFilter_i_var;
typedef ::Core::Var<const CountryFilter_i> CountryFilter_i_cvar;

class CountryFilter_i_factory;

class CountryFilter_i:
	virtual public CountryFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CountryFilter_i)
	friend class CountryFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CountryFilter_i (const NodeBase* country);

	CountryFilter_i ();

	virtual ~CountryFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	NodeBase_var m_country;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CountryFilter
	virtual const NodeBase* get_country () const;
	virtual NodeBase* get_country ();

	virtual void set_country (NodeBase* country);
}; // class CountryFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_COUNTRYFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
