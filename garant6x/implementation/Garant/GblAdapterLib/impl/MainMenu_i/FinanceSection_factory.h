////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/FinanceSection_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::FinanceSection
// �������� ���������� ������ ��������� Section ��� �������� FinanceSection
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for FinanceSection
class FinanceSection_factory: virtual public ::Core::RefCountObjectBase, virtual public SectionAbstractFactory {
public:
	FinanceSection_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const SectionType key () const;

	Section* make ();

};

typedef ::Core::Var<FinanceSection_factory> FinanceSection_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_FINANCESECTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

