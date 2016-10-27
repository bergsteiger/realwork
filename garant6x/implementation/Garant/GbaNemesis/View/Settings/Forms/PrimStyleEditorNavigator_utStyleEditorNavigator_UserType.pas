unit PrimStyleEditorNavigator_utStyleEditorNavigator_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorNavigator_utStyleEditorNavigator_UserType.pas"
// ���������: "UserType"
// ������� ������: "utStyleEditorNavigator" MUID: (50F562DF02DB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utStyleEditorNavigatorLocalConstants }
 str_utStyleEditorNavigatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorCaption'; rValue : '������ ������');
  {* ��������� ����������������� ���� "������ ������" }
 str_utStyleEditorNavigatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utStyleEditorNavigatorSettingsCaption'; rValue : '������ ������');
  {* ��������� ����������������� ���� "������ ������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utStyleEditorNavigator }
 utStyleEditorNavigatorName = 'utStyleEditorNavigator';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 utStyleEditorNavigator = TvcmUserType(0);
  {* ������ ������ }
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
 Tkw_FormUserType_utStyleEditorNavigator = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utStyleEditorNavigator }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utStyleEditorNavigator
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utStyleEditorNavigator.GetInteger: Integer;
begin
 Result := utStyleEditorNavigator;
end;//Tkw_FormUserType_utStyleEditorNavigator.GetInteger

class function Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utStyleEditorNavigator';
end;//Tkw_FormUserType_utStyleEditorNavigator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utStyleEditorNavigatorCaption.Init;
 {* ������������� str_utStyleEditorNavigatorCaption }
 str_utStyleEditorNavigatorSettingsCaption.Init;
 {* ������������� str_utStyleEditorNavigatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utStyleEditorNavigator.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utStyleEditorNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
