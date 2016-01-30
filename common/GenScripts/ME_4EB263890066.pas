unit kwDiffIteratorHasPrev;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDiffIteratorHasPrev.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwDiffIteratorWord
 , DocumentUnit
 , tfwScriptingInterfaces
;

type
 TkwDiffIteratorHasPrev = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasPrev
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

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
begin
 Result := 'DiffIterator:HasPrev';
end;//TkwDiffIteratorHasPrev.GetWordNameForRegister

initialization
 TkwDiffIteratorHasPrev.RegisterInEngine;
 {* Регистрация TkwDiffIteratorHasPrev }
{$IfEnd} // NOT Defined(NoScripts)

end.
