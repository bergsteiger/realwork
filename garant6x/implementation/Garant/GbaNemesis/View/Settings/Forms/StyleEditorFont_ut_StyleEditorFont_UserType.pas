unit StyleEditorFont_ut_StyleEditorFont_UserType;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_StyleEditorFont" MUID: (43C9F2187122)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� ut_StyleEditorFont }
 ut_StyleEditorFontName = 'ut_StyleEditorFont';
  {* ��������� ������������� ����������������� ���� "��������� ������" }
 ut_StyleEditorFont = TvcmUserType(0);
  {* ��������� ������ }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_StyleEditorFont = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_StyleEditorFont }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_StyleEditorFont
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_StyleEditorFont.GetInteger: Integer;
begin
 Result := ut_StyleEditorFont;
end;//Tkw_FormUserType_ut_StyleEditorFont.GetInteger

class function Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_StyleEditorFont';
end;//Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
