unit kwDiffIteratorPrev;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffIteratorPrev.pas"
// Начат: 03.11.2011 13:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwDiffIteratorPrev
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
 TkwDiffIteratorPrev = {scriptword} class(TkwDiffIteratorWord)
 protected
 // realized methods
   procedure DoIterator(const anIterator: IDiffIterator;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorPrev
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

// start class TkwDiffIteratorPrev

procedure TkwDiffIteratorPrev.DoIterator(const anIterator: IDiffIterator;
  const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB263BB0204_var*
//#UC END# *4EB2634D0118_4EB263BB0204_var*
begin
//#UC START# *4EB2634D0118_4EB263BB0204_impl*
 aCtx.rEngine.PushInt(anIterator.Prev);
//#UC END# *4EB2634D0118_4EB263BB0204_impl*
end;//TkwDiffIteratorPrev.DoIterator

class function TkwDiffIteratorPrev.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DiffIterator:Prev';
end;//TkwDiffIteratorPrev.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwDiffIteratorPrev
 TkwDiffIteratorPrev.RegisterInEngine;
{$IfEnd} //not NoScripts

end.