unit RedactionsUserTypes_utRedaction_UserType;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\RedactionsUserTypes_utRedaction_UserType.pas"
// ���������: "UserType"
// ������� ������: "utRedaction" MUID: (4BD6BF000358)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ utRedactionLocalConstants }
 str_utRedactionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionCaption'; rValue : '��������');
  {* ��������� ����������������� ���� "��������" }
 str_utRedactionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRedactionSettingsCaption'; rValue : '��������: �������� (�������)');
  {* ��������� ����������������� ���� "��������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utRedaction }
 utRedactionName = 'utRedaction';
  {* ��������� ������������� ����������������� ���� "��������" }
 utRedaction = TvcmUserType(0);
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
 Tkw_FormUserType_utRedaction = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utRedaction }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utRedaction
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRedaction.GetInteger: Integer;
begin
 Result := utRedaction;
end;//Tkw_FormUserType_utRedaction.GetInteger

class function Tkw_FormUserType_utRedaction.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utRedaction';
end;//Tkw_FormUserType_utRedaction.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utRedactionCaption.Init;
 {* ������������� str_utRedactionCaption }
 str_utRedactionSettingsCaption.Init;
 {* ������������� str_utRedactionSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRedaction.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utRedaction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
