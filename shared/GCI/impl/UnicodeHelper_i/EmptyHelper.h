////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/UnicodeHelper_i/EmptyHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::EmptyHelper
// ��������� ���������� ������ �������� ��� ��������� ConverterHelper
//
// ��������, �� ����������� �������������� ��������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__
#define __SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

class EmptyHelper; // self forward Var
typedef ::Core::Var<EmptyHelper> EmptyHelper_var;
typedef ::Core::Var<const EmptyHelper> EmptyHelper_cvar;

class EmptyHelper_factory;

// ��������, �� ����������� �������������� ��������������
class EmptyHelper:
	virtual public UnicodeHelper::ConverterHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EmptyHelper)
	friend class EmptyHelper_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	EmptyHelper ();

	virtual ~EmptyHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UnicodeHelper::ConverterHelper
	// �������������� (������������� ��� ������) ��������������
	virtual void add_specific (wchar_t* buffer) const;

	// implemented method from UnicodeHelper::ConverterHelper
	// ������� �� Unicode-������ �������������, ������������� ��� ������ ��������������
	virtual const std::wstring remove_specific (const std::wstring& in) const;
}; // class EmptyHelper

} // namespace UnicodeHelper_i
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_I_EMPTYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
