////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/MainMenu_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::MainMenu_i
// ��������� ���������� ������ �������� ��� ��������� MainMenu
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"

namespace GblAdapterLib {

class MainMenu_i; // self forward Var
typedef ::Core::Var<MainMenu_i> MainMenu_i_var;
typedef ::Core::Var<const MainMenu_i> MainMenu_i_cvar;

class MainMenu_i_factory;

class MainMenu_i:
	virtual public MainMenu
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MainMenu_i)
	friend class MainMenu_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MainMenu_i ();

	virtual ~MainMenu_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MainMenu
	// �������� ������ ������� ������� ������
	virtual NodeBase* get_base_search_panes () const;

	// implemented method from MainMenu
	// �������� ������ ������ �� �� ����
	virtual const Section& get_section (SectionType type) const;
}; // class MainMenu_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_MAINMENU_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
