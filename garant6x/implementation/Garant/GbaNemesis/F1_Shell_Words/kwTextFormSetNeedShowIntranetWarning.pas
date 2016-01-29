unit kwTextFormSetNeedShowIntranetWarning;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwTextFormSetNeedShowIntranetWarning.pas"
// Начат: 19.01.2012 19^58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwTextFormSetNeedShowIntranetWarning
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  kwExTextFormWord
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  ExText_Form
  {$IfEnd} //not Admin AND not Monitorings
  ,
  tfwScriptingInterfaces
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TkwTextFormSetNeedShowIntranetWarning = {scriptword} class(TkwExTextFormWord)
 protected
 // realized methods
   procedure DoTextForm(aForm: TExTextForm;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormSetNeedShowIntranetWarning
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TkwTextFormSetNeedShowIntranetWarning

procedure TkwTextFormSetNeedShowIntranetWarning.DoTextForm(aForm: TExTextForm;
  const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F183D860083_var*
//#UC END# *4DCA5B340360_4F183D860083_var*
begin
//#UC START# *4DCA5B340360_4F183D860083_impl*
 aForm.NeedShowIntranetWarningHack := aCtx.rEngine.PopBool;
//#UC END# *4DCA5B340360_4F183D860083_impl*
end;//TkwTextFormSetNeedShowIntranetWarning.DoTextForm

class function TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'textform:SetNeedShowIntranetWarning';
end;//TkwTextFormSetNeedShowIntranetWarning.GetWordNameForRegister

{$IfEnd} //nsTest AND not NoScripts

initialization
{$If defined(nsTest) AND not defined(NoScripts)}
// Регистрация TkwTextFormSetNeedShowIntranetWarning
 TkwTextFormSetNeedShowIntranetWarning.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts

end.