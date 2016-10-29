unit DictionContainerUserTypes_slqtDiction_UserType;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DictionContainerUserTypes_slqtDiction_UserType.pas"
// ���������: "UserType"
// ������� ������: "slqtDiction" MUID: (4D77A52C0374)

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
 {* ������������ ������ slqtDictionLocalConstants }
 str_slqtDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtDictionCaption'; rValue : '�������� �������');
  {* ��������� ����������������� ���� "�������� �������" }
 {* ��������� ��� ���� ����� slqtDiction }
 slqtDictionName = 'slqtDiction';
  {* ��������� ������������� ����������������� ���� "�������� �������" }
 slqtDiction = TvcmUserType(0);
  {* �������� ������� }
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
 Tkw_FormUserType_slqtDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_slqtDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtDiction.GetInteger: Integer;
begin
 Result := slqtDiction;
end;//Tkw_FormUserType_slqtDiction.GetInteger

class function Tkw_FormUserType_slqtDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtDiction';
end;//Tkw_FormUserType_slqtDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_slqtDictionCaption.Init;
 {* ������������� str_slqtDictionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
