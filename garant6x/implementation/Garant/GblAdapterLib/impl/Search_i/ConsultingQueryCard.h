////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/ConsultingQueryCard.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::ConsultingQueryCard
// Заголовок реализации класса серванта для интерфеса 
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_CONSULTINGQUERYCARD_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_CONSULTINGQUERYCARD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"

namespace GblAdapterLib {

class ConsultingQueryCard; // self forward Var
typedef ::Core::Var<ConsultingQueryCard> ConsultingQueryCard_var;
typedef ::Core::Var<const ConsultingQueryCard> ConsultingQueryCard_cvar;

class ConsultingQueryCard_factory;

class ConsultingQueryCard:
	virtual public QueryCardHelper
{
	SET_OBJECT_COUNTER (ConsultingQueryCard)
	friend class ConsultingQueryCard_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingQueryCard ();

	virtual ~ConsultingQueryCard ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCardInfo
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/;

	// implemented method from QueryCardInfo
	// получить список существующих атрибутов для КЗ
	virtual AttributeList* get_exist_attrs () const;
}; // class ConsultingQueryCard

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_CONSULTINGQUERYCARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
