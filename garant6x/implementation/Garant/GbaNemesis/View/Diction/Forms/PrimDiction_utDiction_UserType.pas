unit PrimDiction_utDiction_UserType;
 {* �������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimDiction_utDiction_UserType.pas"
// ���������: "UserType"
// ������� ������: "utDiction" MUID: (4BD71EBC00ED)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utDictionLocalConstants }
 str_utDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionCaption'; rValue : '�������� �������');
  {* ��������� ����������������� ���� "�������� �������" }
 str_utDictionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDictionSettingsCaption'; rValue : '�������� �������: ������ �������� (�������)');
  {* ��������� ����������������� ���� "�������� �������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utDiction }
 utDictionName = 'utDiction';
  {* ��������� ������������� ����������������� ���� "�������� �������" }
 utDiction = TvcmUserType(0);
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
 Tkw_FormUserType_utDiction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utDiction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utDiction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utDiction.GetInteger: Integer;
begin
 Result := utDiction;
end;//Tkw_FormUserType_utDiction.GetInteger

class function Tkw_FormUserType_utDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utDiction';
end;//Tkw_FormUserType_utDiction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utDictionCaption.Init;
 {* ������������� str_utDictionCaption }
 str_utDictionSettingsCaption.Init;
 {* ������������� str_utDictionSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utDiction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
