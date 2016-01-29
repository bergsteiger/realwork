////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::LawForAllSection
// �������� ���������� ������ ��������� Section ��� �������� LawForAllSection
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for LawForAllSection
class LawForAllSection_factory: virtual public ::Core::RefCountObjectBase, virtual public SectionAbstractFactory {
public:
	LawForAllSection_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const SectionType key () const;

	Section* make ();

};

typedef ::Core::Var<LawForAllSection_factory> LawForAllSection_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

