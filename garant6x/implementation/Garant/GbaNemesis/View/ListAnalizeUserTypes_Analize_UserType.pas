unit ListAnalizeUserTypes_Analize_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListAnalizeUserTypes_Analize_UserType.pas"
// ���������: "UserType"
// ������� ������: "Analize" MUID: (4E3695CA0106)

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
 {* ������������ ������ AnalizeLocalConstants }
 str_AnalizeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AnalizeCaption'; rValue : '������ ������');
  {* ��������� ����������������� ���� "������ ������" }
 {* ��������� ��� ���� ����� Analize }
 AnalizeName = 'Analize';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 Analize = TvcmUserType(0);
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
 Tkw_FormUserType_Analize = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� Analize }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_Analize
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_Analize.GetInteger: Integer;
begin
 Result := Analize;
end;//Tkw_FormUserType_Analize.GetInteger

class function Tkw_FormUserType_Analize.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::Analize';
end;//Tkw_FormUserType_Analize.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_AnalizeCaption.Init;
 {* ������������� str_AnalizeCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_Analize.RegisterInEngine;
 {* ����������� Tkw_FormUserType_Analize }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
