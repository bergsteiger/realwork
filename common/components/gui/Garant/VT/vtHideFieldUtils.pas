unit vtHideFieldUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/vtHideFieldUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::HideFields::vtHideFieldUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

var g_HideFieldCount : Integer;
 {* ��� ���������� ���������� ���� �����������, ��� ���������� ������������ ������� �� �����}
function MakeName(const aName: AnsiString): AnsiString;

implementation

uses
  SysUtils
  ;

// unit methods

function MakeName(const aName: AnsiString): AnsiString;
//#UC START# *5110EDE70381_5110ED94010E_var*
//#UC END# *5110EDE70381_5110ED94010E_var*
begin
//#UC START# *5110EDE70381_5110ED94010E_impl*
 Result := aName + IntToStr(g_HideFieldCount);
//#UC END# *5110EDE70381_5110ED94010E_impl*
end;//MakeName

end.