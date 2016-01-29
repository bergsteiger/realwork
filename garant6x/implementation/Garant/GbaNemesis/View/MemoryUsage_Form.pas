unit MemoryUsage_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsage_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 �������� ��� �����������::F1 Without Usecases::View::Main::MemoryUsage
//
// ������������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  MemoryUsagePrim_Form,
  MemoryUsage_ut_MemoryUsage_UserType,
  vtPanel,
  eeTreeView,
  vtSizeablePanel,
  evMemo,
  vtLabel,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
   { MemoryUsageIDs }
  fm_MemoryUsageForm : TvcmFormDescriptor = (rFormID : (rName : 'MemoryUsageForm'; rID : 0); rFactory : nil);
   { ������������� ����� TMemoryUsageForm }

type
 MemoryUsageFormDef = interface(IUnknown)
  {* ������������� ����� MemoryUsage }
   ['{239C1E38-C6A8-4737-8D22-0F6E2D5E4762}']
 end;//MemoryUsageFormDef

 TMemoryUsageForm = {final form} class(TMemoryUsagePrimForm, MemoryUsageFormDef)
  {* ������������ ������� }
  Entities : TvcmEntities;
 protected
  procedure MakeControls; override;
 end;//TMemoryUsageForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  MemoryUsageKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ ut_MemoryUsageLocalConstants }
  str_ut_MemoryUsageCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MemoryUsageCaption'; rValue : '������������ �������');
   { ��������� ����������������� ���� "������������ �������" }

// start class TMemoryUsageForm

procedure TMemoryUsageForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_MemoryUsageName,
  str_ut_MemoryUsageCaption,
  str_ut_MemoryUsageCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_MemoryUsageName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsage
 TtfwClassRef.Register(TMemoryUsageForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� MemoryUsage
 fm_MemoryUsageForm.SetFactory(TMemoryUsageForm.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_MemoryUsageCaption
 str_ut_MemoryUsageCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.