////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PharmQueryCard.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PharmQueryCard
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_PHARMQUERYCARD_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_PHARMQUERYCARD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"

namespace GblAdapterLib {

class PharmQueryCard; // self forward Var
typedef ::Core::Var<PharmQueryCard> PharmQueryCard_var;
typedef ::Core::Var<const PharmQueryCard> PharmQueryCard_cvar;

class PharmQueryCard_factory;

class PharmQueryCard:
	virtual public QueryCardHelper
{
	SET_OBJECT_COUNTER (PharmQueryCard)
	friend class PharmQueryCard_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PharmQueryCard ();

	virtual ~PharmQueryCard ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCardInfo
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/;

	// implemented method from QueryCardInfo
	// получить список существующих атрибутов для КЗ
	virtual AttributeList* get_exist_attrs () const;
}; // class PharmQueryCard

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_PHARMQUERYCARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
