unit PrimOldSituationSearch_cutOldKeyWord_UserType;
 {* ����� �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimOldSituationSearch_cutOldKeyWord_UserType.pas"
// ���������: "UserType"
// ������� ������: "cutOldKeyWord" MUID: (4BD7284F0127)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� cutOldKeyWord }
 cutOldKeyWordName = 'cutOldKeyWord';
  {* ��������� ������������� ����������������� ���� "����� �� ��������" }
 cutOldKeyWord = TvcmUserType(0);
  {* ����� �� �������� }
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
 Tkw_FormUserType_cutOldKeyWord = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� cutOldKeyWord }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cutOldKeyWord
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cutOldKeyWord.GetInteger: Integer;
begin
 Result := cutOldKeyWord;
end;//Tkw_FormUserType_cutOldKeyWord.GetInteger

class function Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::cutOldKeyWord';
end;//Tkw_FormUserType_cutOldKeyWord.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cutOldKeyWord.RegisterInEngine;
 {* ����������� Tkw_FormUserType_cutOldKeyWord }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
