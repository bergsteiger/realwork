unit ShutDown_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/ShutDown_Form.pas"
// �����: 21.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimCommon::ShutDown
//
// ��������������
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
  ,
  PrimShutDown_Form
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vtLabel,
  vtButton,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;

const
    { ShutDownIDs }
   fm_ShutDownForm : TvcmFormDescriptor = (rFormID : (rName : 'ShutDownForm'; rID : 0); rFactory : nil);
    { ������������� ����� TShutDownForm }

type
 ShutDownFormDef = interface(IUnknown)
  {* ������������� ����� ShutDown }
   ['{30C1FF00-6CA8-4565-BDC9-191E8237EFAD}']
 end;//ShutDownFormDef

  TShutDownForm = {final form} class(TPrimShutDownForm, ShutDownFormDef)
   {* �������������� }
  Entities : TvcmEntities;
  end;//TShutDownForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ShutDownKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// ����������� ShutDown
 TtfwClassRef.Register(TShutDownForm);
{$IfEnd} //not NoScripts
// ����������� ������� ����� ShutDown
 fm_ShutDownForm.SetFactory(TShutDownForm.Make);

end.