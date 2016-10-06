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
 , NewGenMainPrim_Form
 , Main_Form
 , evExtFormat
 //#UC START# *4F6AE4A6014Dimpl_uses*
 //#UC END# *4F6AE4A6014Dimpl_uses*
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
 Application.CreateForm(StdRes.TdmStdRes, StdRes.dmStdRes);
 RegisterOperations;

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
 str_NewGenTitle.Init;
 {* Инициализация str_NewGenTitle }
{$IfEnd} // Defined(NewGen)

end.
