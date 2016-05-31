unit PrimTreeAttributeSelect_astNone_UserType;
 {* �����: ����� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas"
// ���������: "UserType"
// ������� ������: "astNone" MUID: (4BD6F94500AC)

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
 {* ������������ ������ astNoneLocalConstants }
 str_astNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astNoneCaption'; rValue : '�����: ����� ���������');
  {* ��������� ����������������� ���� "�����: ����� ���������" }
 {* ��������� ��� ���� ����� astNone }
 astNoneName = 'astNone';
  {* ��������� ������������� ����������������� ���� "�����: ����� ���������" }
 astNone = TvcmUserType(0);
  {* �����: ����� ��������� }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astNone = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� astNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astNone.GetInteger: Integer;
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger

class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_astNoneCaption.Init;
 {* ������������� str_astNoneCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone.RegisterInEngine;
 {* ����������� Tkw_FormUserType_astNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
