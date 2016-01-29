////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/WinLocaleOperations.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::WinLocaleOperations
// ��������� ���������� ������ �������� ��� ��������� 
//
// ��������� ������ � win32 ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_WINLOCALEOPERATIONS_H__
#define __SHARED_GCI_I18N_I_WINLOCALEOPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/impl/I18N_i/LocaleOperationsHelper.h"

//#UC START# *48F6F14900DE_CUSTOM_INCLUDES*
//#UC END# *48F6F14900DE_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

class WinLocaleOperations; // self forward Var
typedef ::Core::Var<WinLocaleOperations> WinLocaleOperations_var;
typedef ::Core::Var<const WinLocaleOperations> WinLocaleOperations_cvar;

class WinLocaleOperations_factory;

// ��������� ������ � win32 ��������
class WinLocaleOperations:
	virtual public LocaleOperationsHelper
{
	SET_OBJECT_COUNTER (WinLocaleOperations)
	friend class WinLocaleOperations_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	WinLocaleOperations ();

	virtual ~WinLocaleOperations ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::LocaleOperations
	// ���������� ������� ������
	virtual I18N::SupportedLocales get_locale () const;

	// implemented method from I18N::LocaleOperations
	// ������������� ������� ������.
	virtual void set_locale (I18N::SupportedLocales locale);

//#UC START# *48F6F14900DE*
//#UC END# *48F6F14900DE*
}; // class WinLocaleOperations

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_WINLOCALEOPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
