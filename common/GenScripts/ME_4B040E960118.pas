unit DocumentUserTypes_dftAnnotationSynchroView_UserType;
 {* ��������� (���������� ��������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotationSynchroView_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftTranslation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotationSynchroView = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAnnotationSynchroView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAnnotationSynchroView
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAnnotationSynchroView';
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftAnnotationSynchroView.GetInteger: Integer;
begin
 Result := dftAnnotationSynchroView;
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotationSynchroView.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAnnotationSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
