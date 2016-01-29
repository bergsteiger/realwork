unit DefineSearchDate_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/DefineSearchDate_Form.pas"
// �����: 22.09.2009 16:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 �������� ����������::Search::View::Search::Search::DefineSearchDate
//
// ����
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
  PrimDefineSearchDate_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  DefineSearchDate_ut_DefineSearchDate_UserType,
  vtPanel,
  vtLabel,
  vtDblClickDateEdit,
  vtRadioButton,
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
    { DefineSearchDateIDs }
   fm_en_DefineSearchDate : TvcmFormDescriptor = (rFormID : (rName : 'en_DefineSearchDate'; rID : 0); rFactory : nil);
    { ������������� ����� Ten_DefineSearchDate }

type
 DefineSearchDateFormDef = interface(IUnknown)
  {* ������������� ����� DefineSearchDate }
   ['{95B053C2-B5BB-4EE7-9D05-E6333C48DF52}']
 end;//DefineSearchDateFormDef

  Ten_DefineSearchDate = {final form} class(TPrimDefineSearchDateForm, DefineSearchDateFormDef)
   {* ���� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//Ten_DefineSearchDate

  TDefineSearchDateForm = Ten_DefineSearchDate;
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
  DefineSearchDateKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_DefineSearchDateLocalConstants }
   str_ut_DefineSearchDateCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DefineSearchDateCaption'; rValue : '����');
    { ��������� ����������������� ���� "����" }

// start class Ten_DefineSearchDate

procedure Ten_DefineSearchDate.MakeControls;
begin
 inherited;
 with AddUsertype(ut_DefineSearchDateName,
  str_ut_DefineSearchDateCaption,
  str_ut_DefineSearchDateCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_DefineSearchDateName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� DefineSearchDate
 TtfwClassRef.Register(Ten_DefineSearchDate);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_DefineSearchDateCaption
 str_ut_DefineSearchDateCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.