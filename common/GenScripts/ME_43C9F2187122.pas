unit StyleEditorFont_ut_StyleEditorFont_UserType;
 {* ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_ut_StyleEditorFont_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_StyleEditorFont }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_StyleEditorFont
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_StyleEditorFont';
end;//Tkw_FormUserType_ut_StyleEditorFont.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_StyleEditorFont.GetInteger: Integer;
begin
 Result := ut_StyleEditorFont;
end;//Tkw_FormUserType_ut_StyleEditorFont.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_StyleEditorFont.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
