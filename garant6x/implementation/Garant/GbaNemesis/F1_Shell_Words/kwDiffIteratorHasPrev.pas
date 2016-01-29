unit kwDiffIteratorHasPrev;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffIteratorHasPrev.pas"
// Начат: 03.11.2011 13:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwDiffIteratorHasPrev
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
  kwDiffIteratorWord,
  DocumentUnit,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwDiffIteratorHasPrev = {scriptword} class(TkwDiffIteratorWord)
 protected
 // realized methods
   procedure DoIterator(const anIterator: IDiffIterator;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasPrev
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

// start class TkwDiffIteratorHasPrev

procedure TkwDiffIteratorHasPrev.DoIterator(const anIterator: IDiffIterator;
  const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB263890066_var*
//#UC END# *4EB2634D0118_4EB263890066_var*
begin
//#UC START# *4EB2634D0118_4EB263890066_impl*
 aCtx.rEngine.PushBool(anIterator.HasPrev);
//#UC END# *4EB2634D0118_4EB263890066_impl*
end;//TkwDiffIteratorHasPrev.DoIterator

class function TkwDiffIteratorHasPrev.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DiffIterator:HasPrev';
end;//TkwDiffIteratorHasPrev.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwDiffIteratorHasPrev
 TkwDiffIteratorHasPrev.RegisterInEngine;
{$IfEnd} //not NoScripts

end.