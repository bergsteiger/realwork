unit EULA_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/EULA_Form.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Core::Common::View::Common::PrimF1Common::EULA
//
// ������� �������������
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
  PrimEULA_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  EULA_ut_EULA_UserType,
  vtLabel,
  vtButton,
  eeMemoWithEditOperations,
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
    { EULAIDs }
   fm_efEULA : TvcmFormDescriptor = (rFormID : (rName : 'efEULA'; rID : 0); rFactory : nil);
    { ������������� ����� TefEULA }

type
 EULAFormDef = interface(IUnknown)
  {* ������������� ����� EULA }
   ['{DF5FBE77-74EC-44AD-8636-CBFDE4947FC7}']
 end;//EULAFormDef

  TefEULA = {final form} class(TPrimEULAForm, EULAFormDef)
   {* ������� ������������� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TefEULA

  TEULAForm = TefEULA;
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
  EULAKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_EULALocalConstants }
   str_ut_EULACaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : '������� �������������');
    { ��������� ����������������� ���� "������� �������������" }

// start class TefEULA

procedure TefEULA.MakeControls;
begin
 inherited;
 with AddUsertype(ut_EULAName,
  str_ut_EULACaption,
  str_ut_EULACaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_EULAName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� EULA
 TtfwClassRef.Register(TefEULA);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� EULA
 fm_efEULA.SetFactory(TefEULA.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_EULACaption
 str_ut_EULACaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.