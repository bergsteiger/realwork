////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FullAttributeInfo_i
// �������� ���������� ������ ��������� FullAttributeInfo ��� �������� FullAttributeInfo_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/Search_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FullAttributeInfo_i
class FullAttributeInfo_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public FullAttributeInfoAbstractFactory
{
public:
	FullAttributeInfo_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FullAttributeInfo* make (const GblPilotQueryDef::FullAttributeInfo& full_info);

};

typedef ::Core::Var<FullAttributeInfo_i_factory> FullAttributeInfo_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

