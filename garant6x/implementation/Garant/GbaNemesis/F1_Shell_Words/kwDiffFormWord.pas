unit kwDiffFormWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffFormWord.pas"
// Начат: 03.11.2011 13:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwDiffFormWord
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  Diff_Form
  {$IfEnd} //not Admin AND not Monitorings
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwFormFromControlWord
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDiffFormWord = {abstract} class(TkwFormFromControlWord)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoForm(aForm: TForm;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoDiffForm(aForm: TDiffForm;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwDiffFormWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwDiffFormWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwDiffFormWord.DoForm(aForm: TForm;
  const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4EB25E1501E1_var*
//#UC END# *4EB25DE00396_4EB25E1501E1_var*
begin
//#UC START# *4EB25DE00396_4EB25E1501E1_impl*
 Assert(aForm Is TDiffForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TDiffForm.ClassName]));
 DoDiffForm(aForm As TDiffForm, aCtx);
//#UC END# *4EB25DE00396_4EB25E1501E1_impl*
end;//TkwDiffFormWord.DoForm
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwDiffFormWord
 TkwDiffFormWord.RegisterClass;
{$IfEnd} //not NoScripts

end.