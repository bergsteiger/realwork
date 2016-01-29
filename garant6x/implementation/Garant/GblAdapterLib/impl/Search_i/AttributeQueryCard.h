////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeQueryCard.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributeQueryCard
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEQUERYCARD_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEQUERYCARD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"

namespace GblAdapterLib {

class AttributeQueryCard; // self forward Var
typedef ::Core::Var<AttributeQueryCard> AttributeQueryCard_var;
typedef ::Core::Var<const AttributeQueryCard> AttributeQueryCard_cvar;

class AttributeQueryCard_factory;

class AttributeQueryCard:
	virtual public QueryCardHelper
{
	SET_OBJECT_COUNTER (AttributeQueryCard)
	friend class AttributeQueryCard_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <AttributeQueryCard, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttributeQueryCard, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AttributeQueryCard ();

	virtual ~AttributeQueryCard ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryCardInfo
	virtual const GCI::IO::Stream* get_evd_card () const
		/*throw (CanNotFindData)*/;

	// implemented method from QueryCardInfo
	// �������� ������ ������������ ��������� ��� ��
	virtual AttributeList* get_exist_attrs () const;
}; // class AttributeQueryCard

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEQUERYCARD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
