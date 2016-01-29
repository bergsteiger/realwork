unit BaseSearchCard_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/BaseSearchCard_Form.pas"
// �����: 21.09.2009 20:01
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������� ����������::BaseSearch::View::BaseSearch$Module::BaseSearch::BaseSearchCard
//
// ������� �����
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
  PrimBaseSearchCard_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaseSearchCard_ut_BaseSearchCard_UserType,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscHideField
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscLister
  {$IfEnd} //Nemesis
  ,
  nscSimpleEditor,
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
    { BaseSearchCardIDs }
   fm_en_BaseSearchCard : TvcmFormDescriptor = (rFormID : (rName : 'en_BaseSearchCard'; rID : 0); rFactory : nil);
    { ������������� ����� Ten_BaseSearchCard }

type
 BaseSearchCardFormDef = interface(IUnknown)
  {* ������������� ����� BaseSearchCard }
   ['{8B9F39A3-2E36-4686-82DA-8C441DE365A3}']
 end;//BaseSearchCardFormDef

  Ten_BaseSearchCard = {final form} class(TPrimBaseSearchCardForm, BaseSearchCardFormDef)
   {* ������� ����� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//Ten_BaseSearchCard

  TBaseSearchCardForm = Ten_BaseSearchCard;
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
  BaseSearchCardKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_BaseSearchCardLocalConstants }
   str_ut_BaseSearchCardCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_BaseSearchCardCaption'; rValue : '������� �����');
    { ��������� ����������������� ���� "������� �����" }

// start class Ten_BaseSearchCard

procedure Ten_BaseSearchCard.MakeControls;
begin
 inherited;
 with AddUsertype(ut_BaseSearchCardName,
  str_ut_BaseSearchCardCaption,
  str_ut_BaseSearchCardCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_BaseSearchCardName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� BaseSearchCard
 TtfwClassRef.Register(Ten_BaseSearchCard);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ����������� ������� ����� BaseSearchCard
 fm_en_BaseSearchCard.SetFactory(Ten_BaseSearchCard.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_BaseSearchCardCaption
 str_ut_BaseSearchCardCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.