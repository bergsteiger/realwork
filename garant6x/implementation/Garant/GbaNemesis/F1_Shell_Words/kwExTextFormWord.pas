unit kwExTextFormWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwExTextFormWord.pas"
// Начат: 11.05.2011 13:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwExTextFormWord
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
  ExText_Form
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
 TkwExTextFormWord = {abstract} class(TkwFormFromControlWord)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoForm(aForm: TForm;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoTextForm(aForm: TExTextForm;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwExTextFormWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  afwFacade,
  SysUtils,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwExTextFormWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwExTextFormWord.DoForm(aForm: TForm;
  const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4DCA5A94013D_var*
//#UC END# *4EB25DE00396_4DCA5A94013D_var*
begin
//#UC START# *4EB25DE00396_4DCA5A94013D_impl*
 Assert(aForm Is TExTextForm, Format('Форма %s не совместима с %s',
                                   [aForm.ClassName, TExTextForm.ClassName]));
 DoTextForm(aForm As TExTextForm, aCtx);
//#UC END# *4EB25DE00396_4DCA5A94013D_impl*
end;//TkwExTextFormWord.DoForm
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwExTextFormWord
 TkwExTextFormWord.RegisterClass;
{$IfEnd} //not NoScripts

end.