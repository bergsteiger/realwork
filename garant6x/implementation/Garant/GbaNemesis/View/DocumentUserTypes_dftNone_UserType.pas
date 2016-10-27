unit DocumentUserTypes_dftNone_UserType;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftNone_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftNone" MUID: (4B040A4A0373)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ dftNoneLocalConstants }
 str_dftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftNoneCaption'; rValue : '��������');
  {* ��������� ����������������� ���� "��������" }
 {* ��������� ��� ���� ����� dftNone }
 dftNoneName = 'dftNone';
  {* ��������� ������������� ����������������� ���� "��������" }
 dftNone = TvcmUserType(0);
  {* �������� }
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
 Tkw_FormUserType_dftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftNone.GetInteger: Integer;
begin
 Result := dftNone;
end;//Tkw_FormUserType_dftNone.GetInteger

class function Tkw_FormUserType_dftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftNone';
end;//Tkw_FormUserType_dftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftNoneCaption.Init;
 {* ������������� str_dftNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
