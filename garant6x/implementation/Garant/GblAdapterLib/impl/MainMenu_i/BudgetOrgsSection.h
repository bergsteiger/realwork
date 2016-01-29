////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/BudgetOrgsSection.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::MainMenu_i::BudgetOrgsSection
// ��������� ���������� ������ �������� ��� ��������� Section
//
// ������ ��� ��������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUDGETORGSSECTION_H__
#define __GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUDGETORGSSECTION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/MainMenu/MainMenu.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/MainMenu_i/SectionBase.h"

namespace GblAdapterLib {

class BudgetOrgsSection; // self forward Var
typedef ::Core::Var<BudgetOrgsSection> BudgetOrgsSection_var;
typedef ::Core::Var<const BudgetOrgsSection> BudgetOrgsSection_cvar;

class BudgetOrgsSection_factory;

// ������ ��� ��������� �����������
class BudgetOrgsSection:
	virtual public Section
	, virtual public SectionBase
{
	SET_OBJECT_COUNTER (BudgetOrgsSection)
	friend class BudgetOrgsSection_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BudgetOrgsSection ();

	virtual ~BudgetOrgsSection ();
}; // class BudgetOrgsSection

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_MAINMENU_I_BUDGETORGSSECTION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
