unit FromWithPanel_ut_FromWithPanel_UserType;
 {* FromWithPanel }

// ������: "w:\common\components\gui\Garant\Daily\Forms\FromWithPanel_ut_FromWithPanel_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_FromWithPanel" MUID: (C8D510D2786B)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
 , l3StringIDEx
;

const
 {* ������������ ������ ut_FromWithPanelLocalConstants }
 str_ut_FromWithPanelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_FromWithPanelCaption'; rValue : 'FromWithPanel');
  {* ��������� ����������������� ���� "FromWithPanel" }
 {* ��������� ��� ���� ����� ut_FromWithPanel }
 ut_FromWithPanelName = 'ut_FromWithPanel';
  {* ��������� ������������� ����������������� ���� "FromWithPanel" }
 ut_FromWithPanel = TvcmUserType(0);
  {* FromWithPanel }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_FromWithPanel = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_FromWithPanel }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_FromWithPanel
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_FromWithPanel.GetInteger: Integer;
begin
 Result := ut_FromWithPanel;
end;//Tkw_FormUserType_ut_FromWithPanel.GetInteger

class function Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_FromWithPanel';
end;//Tkw_FormUserType_ut_FromWithPanel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_FromWithPanelCaption.Init;
 {* ������������� str_ut_FromWithPanelCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_FromWithPanel.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_FromWithPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
