////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/common/components/rtl/Garant/EVD/DOM/DOM.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::DOM
//
// ��������� ������ ��������� EVD
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DELPHI_EVD_DOM_H__
#define __SHARED_DELPHI_EVD_DOM_H__

#include "shared/Core/sys/std_inc.h"
#include "common/components/rtl/Garant/EVD/Types/Types.h"

namespace EVD {
namespace DOM {

// ������ ������
enum PaperSize {
	ps_Custom
	, ps_A0 // 84   x 118.8
	, ps_A1 // 59.4 x 84
	, ps_A2 // 42   x 59.4
	, ps_A3 // 29.7 x 42
	, ps_A4 // 21   x 29.7
	, ps_A5 // 14.8 x 21
};

class Section;
typedef ::Core::Var<Section> Section_var;
typedef ::Core::Var<const Section> Section_cvar;
// �������� ������� ���������
class Section
	: virtual public ::Core::IObject
{
public:
	// ���������� ��������
	virtual const PageOrientation get_Orientation () const = 0;

	virtual void set_Orientation (PageOrientation Orientation) = 0;

	// ������ ������
	virtual const PaperSize get_PaperSize () const = 0;

	virtual void set_PaperSize (PaperSize PaperSize) = 0;
};

// ����
enum Language {
	lg_Russian // �������
	, lg_English // ����������
	, lg_German // ��������
	, lg_French // �����������
	, lg_Italian // �����������
	, lg_Spanish // ���������
};

class DictEntry;
typedef ::Core::Var<DictEntry> DictEntry_var;
typedef ::Core::Var<const DictEntry> DictEntry_cvar;
// ��������� ��������� �������
class DictEntry
	: virtual public ::Core::IObject
{
public:
	// �������� �����
	virtual  get_ShortName (Language aLang) const = 0;

	virtual void set_ShortName ( ShortName, Language aLang) = 0;
};

} // namespace DOM
} // namespace EVD


#endif //__SHARED_DELPHI_EVD_DOM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
