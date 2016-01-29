unit kwDiffIteratorWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffIteratorWord.pas"
// Начат: 03.11.2011 13:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwDiffIteratorWord
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
  DocumentUnit
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  Diff_Form
  {$IfEnd} //not Admin AND not Monitorings
  ,
  tfwScriptingInterfaces,
  kwDiffFormWord
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDiffIteratorWord = {abstract} class(TkwDiffFormWord)
 protected
 // realized methods
   procedure DoDiffForm(aForm: TDiffForm;
     const aCtx: TtfwContext); override;
 protected
 // protected methods
   procedure DoIterator(const anIterator: IDiffIterator;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwDiffIteratorWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
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
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

type
  TDiffFormHack = {abstract} class(TDiffForm)
  end;//TDiffFormHack

// start class TkwDiffIteratorWord

procedure TkwDiffIteratorWord.DoDiffForm(aForm: TDiffForm;
  const aCtx: TtfwContext);
//#UC START# *4EB25F0701B5_4EB2632A02DD_var*
//#UC END# *4EB25F0701B5_4EB2632A02DD_var*
begin
//#UC START# *4EB25F0701B5_4EB2632A02DD_impl*
 DoIterator(TDiffFormHack(aForm).CompareEditions.ChangedParas, aCtx);
//#UC END# *4EB25F0701B5_4EB2632A02DD_impl*
end;//TkwDiffIteratorWord.DoDiffForm

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwDiffIteratorWord
 TkwDiffIteratorWord.RegisterClass;
{$IfEnd} //not NoScripts

end.