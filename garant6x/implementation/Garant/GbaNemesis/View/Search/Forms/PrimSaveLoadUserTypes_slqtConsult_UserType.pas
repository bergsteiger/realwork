unit PrimSaveLoadUserTypes_slqtConsult_UserType;
 {* �������� ��������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtConsult_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtConsult" MUID: (4BD5BC700046)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtPostingOrder_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ slqtConsultLocalConstants }
 str_slqtConsultCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtConsultCaption'; rValue : '�������� ��������� ������');
  {* ��������� ����������������� ���� "�������� ��������� ������" }
 {* ��������� ��� ���� ����� slqtConsult }
 slqtConsultName = 'slqtConsult';
  {* ��������� ������������� ����������������� ���� "�������� ��������� ������" }
 slqtConsult = TvcmUserType(slqtPostingOrder + 1);
  {* �������� ��������� ������ }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_slqtConsult = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtConsult }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtConsult
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtConsult.GetInteger: Integer;
begin
 Result := slqtConsult;
end;//Tkw_FormUserType_slqtConsult.GetInteger

class function Tkw_FormUserType_slqtConsult.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtConsult';
end;//Tkw_FormUserType_slqtConsult.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtConsultCaption.Init;
 {* ������������� str_slqtConsultCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtConsult.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtConsult }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
