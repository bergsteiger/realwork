////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ReviewQueryCard.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ReviewQueryCard
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_REVIEWQUERYCARD_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_REVIEWQUERYCARD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"

namespace GblAdapterLib {

class ReviewQueryCard; // self forward Var
typedef ::Core::Var<ReviewQueryCard> ReviewQueryCard_var;
typedef ::Core::Var<const ReviewQueryCard> ReviewQueryCard_cvar;

class ReviewQueryCard_factory;

class ReviewQueryCard:
	virtual public QueryCardHelper
{
	SET_OBJECT_COUNTER (ReviewQueryCard)
	friend class ReviewQueryCard_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ReviewQueryCard ();

	virtual ~ReviewQueryCard ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCardInfo
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/;

	// implemented method from QueryCardInfo
	// получить список существующих атрибутов для КЗ
	virtual AttributeList* get_exist_attrs () const;
}; // class ReviewQueryCard

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_REVIEWQUERYCARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
