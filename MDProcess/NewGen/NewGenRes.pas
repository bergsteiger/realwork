unit NewGenRes;

// Модуль: "w:\MDProcess\NewGen\NewGenRes.pas"
// Стереотип: "VCMApplication"
// Элемент модели: "NewGen" MUID: (4F6AE4A6014D)
// Имя типа: "TNewGenRes"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , F1LikeRes
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_NewGenTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewGenTitle'; rValue : 'НЕ Роза');
  {* 'НЕ Роза' }

type
 TNewGenRes = {final} class(TF1LikeRes)
  protected
   {$If NOT Defined(NoVCM)}
   class procedure Runner(const aTitle: Tl3StringIDEx;
    const aHelpFile: AnsiString); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Loaded; override;
 end;//TNewGenRes

 TvcmApplicationRef = TNewGenRes;
  {* Ссылка на приложение для DesignTime редакторов }
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , NewGenMainPrim_Form
 , Main_Form
 {$If NOT Defined(NoScripts)}
 , MainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , evExtFormat
;

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

procedure TNewGenRes.Loaded;
begin
 inherited;
end;//TNewGenRes.Loaded

initialization
 str_NewGenTitle.Init;
 {* Инициализация str_NewGenTitle }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewGenRes);
 {* Регистрация NewGen }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
