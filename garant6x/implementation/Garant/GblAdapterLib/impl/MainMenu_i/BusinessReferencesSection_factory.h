////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BusinessReferencesSection_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::BusinessReferencesSection
// �������� ���������� ������ ��������� Section ��� �������� BusinessReferencesSection
//
// ������ ������-�������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for BusinessReferencesSection
class BusinessReferencesSection_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public SectionAbstractFactory
{
public:
	BusinessReferencesSection_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const SectionType key () const;

	Section* make ();

};

typedef ::Core::Var<BusinessReferencesSection_factory> BusinessReferencesSection_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUSINESSREFERENCESSECTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

