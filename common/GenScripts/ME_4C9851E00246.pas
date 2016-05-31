unit PrimShutDown_sftNone_UserType;
 {* �������������� � �������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimShutDown_sftNone_UserType.pas"
// ���������: "UserType"
// ������� ������: "sftNone" MUID: (4C9851E00246)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ sftNoneLocalConstants }
 str_sftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sftNoneCaption'; rValue : '�������������� � �������� ����������');
  {* ��������� ����������������� ���� "�������������� � �������� ����������" }
 {* ��������� ��� ���� ����� sftNone }
 sftNoneName = 'sftNone';
  {* ��������� ������������� ����������������� ���� "�������������� � �������� ����������" }
 sftNone = TvcmUserType(0);
  {* �������������� � �������� ���������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_sftNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� sftNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_sftNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_sftNone.GetInteger: Integer;
begin
 Result := sftNone;
end;//Tkw_FormUserType_sftNone.GetInteger

class function Tkw_FormUserType_sftNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::sftNone';
end;//Tkw_FormUserType_sftNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_sftNoneCaption.Init;
 {* ������������� str_sftNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_sftNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_sftNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
