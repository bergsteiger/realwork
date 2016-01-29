////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/LawForAllSection.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::LawForAllSection
// ��������� ���������� ������ �������� ��� ��������� Section
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class LawForAllSection; // self forward Var
typedef ::Core::Var<LawForAllSection> LawForAllSection_var;
typedef ::Core::Var<const LawForAllSection> LawForAllSection_cvar;

class LawForAllSection_factory;

class LawForAllSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (LawForAllSection)
	friend class LawForAllSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	LawForAllSection ();

	virtual ~LawForAllSection ();
}; // class LawForAllSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_LAWFORALLSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
