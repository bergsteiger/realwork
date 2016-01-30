unit NewGenRes;

// Модуль: "w:\MDProcess\NewGen\NewGenRes.pas"
// Стереотип: "VCMApplication"

{$Include ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , F1LikeRes
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MainForm: TvcmFormDescriptor = (rFormID : (rName : 'MainForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TMainForm }

const
 {* Локализуемые строки Local }
 str_NewGenTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewGenTitle'; rValue : 'НЕ Роза');
  {* 'НЕ Роза' }

type
 TNewGenMainPrimForm = class(TMainPrimForm)
 end;//TNewGenMainPrimForm

 MainFormDef = interface
  {* Идентификатор формы Main }
  ['{45D03D24-01B1-4C43-89B5-AF75285241AE}']
 end;//MainFormDef

 TMainForm = {final} class(TNewGenMainPrimForm, MainFormDef)
  {* НЕ Роза }
  protected
   procedure InitFields; override;
 end;//TMainForm

 TvcmApplicationRef = TNewGenRes;
  {* Ссылка на приложение для DesignTime редакторов }

 TNewGenRes = {final} class(TF1LikeRes)
  protected
   {$If NOT Defined(NoVCM)}
   class procedure Runner(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TNewGenRes
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , l3MessageID
 , evExtFormat
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_MainLocalConstants }
 str_ut_MainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MainCaption'; rValue : 'НЕ Роза');
  {* Заголовок пользовательского типа "НЕ Роза" }

procedure TMainForm.InitFields;
//#UC START# *47A042E100E2_4F6AEAE5007B_var*
//#UC END# *47A042E100E2_4F6AEAE5007B_var*
begin
//#UC START# *47A042E100E2_4F6AEAE5007B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4F6AEAE5007B_impl*
end;//TMainForm.InitFields

{$If NOT Defined(NoVCM)}
class procedure TNewGenRes.Runner(const aTitle: Tl3StringIDEx;
 const aHelpFile: AnsiString);
//#UC START# *4F6AF5860291_4F6AE4A6014D_var*
var
 l_Main : TForm;
//#UC END# *4F6AF5860291_4F6AE4A6014D_var*
begin
//#UC START# *4F6AF5860291_4F6AE4A6014D_impl*
 Application.HelpFile := aHelpFile;
 Application.Title := aTitle.AsStr;

 MakeResources;

 l_Main := nil;
 try
  Application.CreateForm(TMainForm, l_Main);
 finally
  if (l_Main <> nil) then
   SetForeGroundWindow(l_Main.Handle);
 end;//try..finally

 Application.Run;
//#UC END# *4F6AF5860291_4F6AE4A6014D_impl*
end;//TNewGenRes.Runner
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewGenMainPrimForm);
 {* Регистрация NewGenMainPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainForm);
 {* Регистрация Main }
{$IfEnd} // NOT Defined(NoScripts)
 fm_MainForm.SetFactory(TMainForm.Make);
 {* Регистрация фабрики формы Main }
 str_ut_MainCaption.Init;
 {* Инициализация str_ut_MainCaption }
 str_NewGenTitle.Init;
 {* Инициализация str_NewGenTitle }
{$IfEnd} // Defined(NewGen)

end.
