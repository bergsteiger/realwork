unit Main_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/NewGen/Main_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> MDProcess$NewGen$Interface::NewGen::NewGen::Main
//
// НЕ Роза
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\NewGen\ngDefine.inc}

interface

{$If defined(NewGen)}
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
  NewGenMainPrim_Form,
  Main_ut_Main_UserType
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  vtProportionalPanel,
  vtSizeablePanel
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //NewGen

{$If defined(NewGen)}
const
   { MainIDs }
  fm_MainForm : TvcmFormDescriptor = (rFormID : (rName : 'MainForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TMainForm }

type
 MainFormDef = interface(IUnknown)
  {* Идентификатор формы Main }
   ['{45D03D24-01B1-4C43-89B5-AF75285241AE}']
 end;//MainFormDef

 TMainForm = {final form} class(TNewGenMainPrimForm, MainFormDef)
  {* НЕ Роза }
  Entities : TvcmEntities;
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   procedure InitFields; override;
 end;//TMainForm
{$IfEnd} //NewGen

implementation

{$R *.DFM}

{$If defined(NewGen)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(NewGen) AND not defined(NoScripts)}
  ,
  MainKeywordsPack
  {$IfEnd} //NewGen AND not NoScripts
  
  ;
{$IfEnd} //NewGen

{$If defined(NewGen)}

var
   { Локализуемые строки ut_MainLocalConstants }
  str_ut_MainCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MainCaption'; rValue : 'НЕ Роза');
   { Заголовок пользовательского типа "НЕ Роза" }

// start class TMainForm

procedure TMainForm.InitFields;
//#UC START# *47A042E100E2_4F6AEAE5007B_var*
//#UC END# *47A042E100E2_4F6AEAE5007B_var*
begin
//#UC START# *47A042E100E2_4F6AEAE5007B_impl*
 inherited;
//#UC END# *47A042E100E2_4F6AEAE5007B_impl*
end;//TMainForm.InitFields

procedure TMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_MainName,
  str_ut_MainCaption,
  str_ut_MainCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_MainName
end;

{$IfEnd} //NewGen

initialization
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация Main
 TtfwClassRef.Register(TMainForm);
{$IfEnd} //NewGen AND not NoScripts
{$If defined(NewGen)}
// Регистрация фабрики формы Main
 fm_MainForm.SetFactory(TMainForm.Make);
{$IfEnd} //NewGen
{$If defined(NewGen)}
// Инициализация str_ut_MainCaption
 str_ut_MainCaption.Init;
{$IfEnd} //NewGen

end.