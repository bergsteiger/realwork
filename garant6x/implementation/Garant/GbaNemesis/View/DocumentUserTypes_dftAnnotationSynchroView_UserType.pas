unit DocumentUserTypes_dftAnnotationSynchroView_UserType;
 {* ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotationSynchroView_UserType.pas"
// ���������: "UserType"
// ������� ������: "dftAnnotationSynchroView" MUID: (4B040E960118)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTranslation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftAnnotationSynchroView }
 dftAnnotationSynchroViewName = 'dftAnnotationSynchroView';
  {* ��������� ������������� ����������������� ���� "��������� (���������� ��������)" }
 dftAnnotationSynchroView = TvcmUserType(dftTranslation + 1);
  {* ��������� (���������� ��������) }
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
 Tkw_FormUserType_dftAnnotationSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAnnotationSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftAnnotationSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAnnotationSynchroView.GetInteger: Integer;
begin
 Result := dftAnnotationSynchroView;
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetInteger

class function Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAnnotationSynchroView';
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotationSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAnnotationSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
