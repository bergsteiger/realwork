unit kwDiffIteratorNext;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwDiffIteratorNext.pas"
// Начат: 03.11.2011 13:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::TkwDiffIteratorNext
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
 TkwDiffIteratorNext = {scriptword} class(TkwDiffIteratorWord)
 protected
 // realized methods
   procedure DoIterator(const anIterator: IDiffIterator;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorNext
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

// start class TkwDiffIteratorNext

procedure TkwDiffIteratorNext.DoIterator(const anIterator: IDiffIterator;
  const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB25F5F0340_var*
//#UC END# *4EB2634D0118_4EB25F5F0340_var*
begin
//#UC START# *4EB2634D0118_4EB25F5F0340_impl*
 aCtx.rEngine.PushInt(anIterator.Next);
//#UC END# *4EB2634D0118_4EB25F5F0340_impl*
end;//TkwDiffIteratorNext.DoIterator

class function TkwDiffIteratorNext.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DiffIterator:Next';
end;//TkwDiffIteratorNext.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwDiffIteratorNext
 TkwDiffIteratorNext.RegisterInEngine;
{$IfEnd} //not NoScripts

end.