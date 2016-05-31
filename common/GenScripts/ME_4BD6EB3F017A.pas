unit PrimFoldersTree_utSaveOpen_UserType;
 {* ��� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_utSaveOpen_UserType.pas"
// ���������: "UserType"
// ������� ������: "utSaveOpen" MUID: (4BD6EB3F017A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_utFoldersTree_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ utSaveOpenLocalConstants }
 str_utSaveOpenCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSaveOpenCaption'; rValue : '��� ���������');
  {* ��������� ����������������� ���� "��� ���������" }
 {* ��������� ��� ���� ����� utSaveOpen }
 utSaveOpenName = 'utSaveOpen';
  {* ��������� ������������� ����������������� ���� "��� ���������" }
 utSaveOpen = TvcmUserType(utFoldersTree + 1);
  {* ��� ��������� }
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
 Tkw_FormUserType_utSaveOpen = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utSaveOpen }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utSaveOpen
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utSaveOpen.GetInteger: Integer;
begin
 Result := utSaveOpen;
end;//Tkw_FormUserType_utSaveOpen.GetInteger

class function Tkw_FormUserType_utSaveOpen.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utSaveOpen';
end;//Tkw_FormUserType_utSaveOpen.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utSaveOpenCaption.Init;
 {* ������������� str_utSaveOpenCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSaveOpen.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utSaveOpen }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
