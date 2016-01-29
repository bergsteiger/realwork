////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/PrimeQueryCard.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::PrimeQueryCard
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"

namespace GblAdapterLib {

class PrimeQueryCard; // self forward Var
typedef ::Core::Var<PrimeQueryCard> PrimeQueryCard_var;
typedef ::Core::Var<const PrimeQueryCard> PrimeQueryCard_cvar;

class PrimeQueryCard_factory;

class PrimeQueryCard:
	virtual public QueryCardHelper
{
	SET_OBJECT_COUNTER (PrimeQueryCard)
	friend class PrimeQueryCard_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <PrimeQueryCard, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PrimeQueryCard, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrimeQueryCard ();

	virtual ~PrimeQueryCard ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCardInfo
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/;

	// implemented method from QueryCardInfo
	// получить список существующих атрибутов для КЗ
	virtual AttributeList* get_exist_attrs () const;
}; // class PrimeQueryCard

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_PRIMEQUERYCARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
