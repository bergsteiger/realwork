unit PrimChangesBetweenEditons_DocumentChanges_UserType;
 {* ��������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas"
// ���������: "UserType"
// ������� ������: "DocumentChanges" MUID: (4DDCDE8F01B8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ DocumentChangesLocalConstants }
 str_DocumentChangesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentChangesCaption'; rValue : '��������� � ���������');
  {* ��������� ����������������� ���� "��������� � ���������" }
 {* ��������� ��� ���� ����� DocumentChanges }
 DocumentChangesName = 'DocumentChanges';
  {* ��������� ������������� ����������������� ���� "��������� � ���������" }
 DocumentChanges = TvcmUserType(0);
  {* ��������� � ��������� }
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
 Tkw_FormUserType_DocumentChanges = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� DocumentChanges }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_DocumentChanges
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_DocumentChanges.GetInteger: Integer;
begin
 Result := DocumentChanges;
end;//Tkw_FormUserType_DocumentChanges.GetInteger

class function Tkw_FormUserType_DocumentChanges.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::DocumentChanges';
end;//Tkw_FormUserType_DocumentChanges.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_DocumentChangesCaption.Init;
 {* ������������� str_DocumentChangesCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_DocumentChanges.RegisterInEngine;
 {* ����������� Tkw_FormUserType_DocumentChanges }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
