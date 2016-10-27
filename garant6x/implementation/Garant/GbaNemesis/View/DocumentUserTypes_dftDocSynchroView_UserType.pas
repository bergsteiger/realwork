unit DocumentUserTypes_dftDocSynchroView_UserType;
 {* ����� ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDocSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftDocSynchroView" MUID: (4B040E1D00EA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftRelatedDoc_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ dftDocSynchroViewLocalConstants }
 str_dftDocSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewCaption'; rValue : '����� ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "����� ��������� (���������� ��������)" }
 str_dftDocSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewSettingsCaption'; rValue : '���������� ��������: ����� ���������');
  {* ��������� ����������������� ���� "����� ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� dftDocSynchroView }
 dftDocSynchroViewName = 'dftDocSynchroView';
  {* ��������� ������������� ����������������� ���� "����� ��������� (���������� ��������)" }
 dftDocSynchroView = TvcmUserType(dftRelatedDoc + 1);
  {* ����� ��������� (���������� ��������) }
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
 Tkw_FormUserType_dftDocSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftDocSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDocSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDocSynchroView.GetInteger: Integer;
begin
 Result := dftDocSynchroView;
end;//Tkw_FormUserType_dftDocSynchroView.GetInteger

class function Tkw_FormUserType_dftDocSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftDocSynchroView';
end;//Tkw_FormUserType_dftDocSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftDocSynchroViewCaption.Init;
 {* ������������� str_dftDocSynchroViewCaption }
 str_dftDocSynchroViewSettingsCaption.Init;
 {* ������������� str_dftDocSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDocSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftDocSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
