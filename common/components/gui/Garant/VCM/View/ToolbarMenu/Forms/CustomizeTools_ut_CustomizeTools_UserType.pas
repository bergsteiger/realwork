unit CustomizeTools_ut_CustomizeTools_UserType;
 {* CustomizeTools }

// ������: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\Forms\CustomizeTools_ut_CustomizeTools_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_CustomizeTools" MUID: (5787C08EFD86)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ ut_CustomizeToolsLocalConstants }
 str_ut_CustomizeToolsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeToolsCaption'; rValue : 'CustomizeTools');
  {* ��������� ����������������� ���� "CustomizeTools" }
 {* ��������� ��� ���� ����� ut_CustomizeTools }
 ut_CustomizeToolsName = 'ut_CustomizeTools';
  {* ��������� ������������� ����������������� ���� "CustomizeTools" }
 ut_CustomizeTools = TvcmUserType(0);
  {* CustomizeTools }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_CustomizeTools = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_CustomizeTools }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_CustomizeTools
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CustomizeTools.GetInteger: Integer;
begin
 Result := ut_CustomizeTools;
end;//Tkw_FormUserType_ut_CustomizeTools.GetInteger

class function Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_CustomizeTools';
end;//Tkw_FormUserType_ut_CustomizeTools.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_CustomizeToolsCaption.Init;
 {* ������������� str_ut_CustomizeToolsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CustomizeTools.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_CustomizeTools }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
