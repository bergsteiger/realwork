////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionItem_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::SectionItem_i
// �������� ���������� ������ ��������� SectionItem ��� �������� SectionItem_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenuFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for SectionItem_i
class SectionItem_i_factory: virtual public ::Core::RefCountObjectBase, virtual public SectionItemAbstractFactory {
public:
	SectionItem_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	SectionItem* make (const GblPilot::SectionItem& section_item);

};

typedef ::Core::Var<SectionItem_i_factory> SectionItem_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_SECTIONITEM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

