unit PrimFoldersElementInfo_utFoldersProperty_UserType;
 {* ������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfo_utFoldersProperty_UserType.pas"
// ���������: "UserType"
// ������� ������: "utFoldersProperty" MUID: (4C77DA410141)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utFoldersPropertyLocalConstants }
 str_utFoldersPropertyCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersPropertyCaption'; rValue : '������ �������');
  {* ��������� ����������������� ���� "������ �������" }
 {* ��������� ��� ���� ����� utFoldersProperty }
 utFoldersPropertyName = 'utFoldersProperty';
  {* ��������� ������������� ����������������� ���� "������ �������" }
 utFoldersProperty = TvcmUserType(0);
  {* ������ ������� }
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
 Tkw_FormUserType_utFoldersProperty = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utFoldersProperty }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utFoldersProperty
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utFoldersProperty.GetInteger: Integer;
begin
 Result := utFoldersProperty;
end;//Tkw_FormUserType_utFoldersProperty.GetInteger

class function Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utFoldersProperty';
end;//Tkw_FormUserType_utFoldersProperty.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utFoldersPropertyCaption.Init;
 {* ������������� str_utFoldersPropertyCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utFoldersProperty.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utFoldersProperty }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
