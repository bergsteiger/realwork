////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/UnicodeHelper_i/TatarHelper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::UnicodeHelper_i::TatarHelper
// ��������� ���������� ������ �������� ��� ��������� ConverterHelper
//
// �������������� �������������� ��� ���������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_UNICODEHELPER_I_TATARHELPER_H__
#define __SHARED_GCI_UNICODEHELPER_I_TATARHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/UnicodeHelper/UnicodeHelper.h"

namespace GCI {
namespace UnicodeHelper_i {

class TatarHelper; // self forward Var
typedef ::Core::Var<TatarHelper> TatarHelper_var;
typedef ::Core::Var<const TatarHelper> TatarHelper_cvar;

class TatarHelper_factory;

// �������������� �������������� ��� ���������� �����
class TatarHelper:
	virtual public UnicodeHelper::ConverterHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TatarHelper)
	friend class TatarHelper_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������� ������������ ��� ���������� Unicode
	typedef std::map < wchar_t, wchar_t > WCharMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TatarHelper ();

	virtual ~TatarHelper ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	WCharMap m_ru_to_ta;

	WCharMap m_ta_to_ru;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UnicodeHelper::ConverterHelper
	// �������������� (������������� ��� ������) ��������������
	virtual void add_specific (wchar_t* buffer) const;

	// implemented method from UnicodeHelper::ConverterHelper
	// ������� �� Unicode-������ �������������, ������������� ��� ������ ��������������
	virtual const std::wstring remove_specific (const std::wstring& in) const;
}; // class TatarHelper

} // namespace UnicodeHelper_i
} // namespace GCI


#endif //__SHARED_GCI_UNICODEHELPER_I_TATARHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
