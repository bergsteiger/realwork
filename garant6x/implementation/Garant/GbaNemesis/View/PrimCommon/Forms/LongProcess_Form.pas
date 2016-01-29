unit LongProcess_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/LongProcess_Form.pas"
// �����: 21.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimCommon::LongProcess
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
  PrimLongProcess_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  LongProcess_ut_LongProcess_UserType,
  vtPanel,
  vtLabel,
  vtGradientWaitbar
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtButton,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;

const
    { LongProcessIDs }
   fm_LongProcessForm : TvcmFormDescriptor = (rFormID : (rName : 'LongProcessForm'; rID : 0); rFactory : nil);
    { ������������� ����� TLongProcessForm }

type
 LongProcessFormDef = interface(IUnknown)
  {* ������������� ����� LongProcess }
   ['{D21B6517-D901-4E98-8A54-287D092EED98}']
 end;//LongProcessFormDef

  TLongProcessForm = {final form} class(TPrimLongProcessForm, LongProcessFormDef)
   {* ���������� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TLongProcessForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  LongProcessKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;

var
    { ������������ ������ ut_LongProcessLocalConstants }
   str_ut_LongProcessCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LongProcessCaption'; rValue : '����������');
    { ��������� ����������������� ���� "����������" }

// start class TLongProcessForm

procedure TLongProcessForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_LongProcessName,
  str_ut_LongProcessCaption,
  str_ut_LongProcessCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_LongProcessName
end;

initialization
{$If not defined(NoScripts)}
// ����������� LongProcess
 TtfwClassRef.Register(TLongProcessForm);
{$IfEnd} //not NoScripts
// ������������� str_ut_LongProcessCaption
 str_ut_LongProcessCaption.Init;

end.