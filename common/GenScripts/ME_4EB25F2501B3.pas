unit kwDiffIteratorHasNext;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDiffIteratorHasNext.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwDiffIteratorWord
 , DocumentUnit
 , tfwScriptingInterfaces
;

type
 TkwDiffIteratorHasNext = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorHasNext
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwDiffIteratorHasNext.DoIterator(const anIterator: IDiffIterator;
 const aCtx: TtfwContext);
//#UC START# *4EB2634D0118_4EB25F2501B3_var*
//#UC END# *4EB2634D0118_4EB25F2501B3_var*
begin
//#UC START# *4EB2634D0118_4EB25F2501B3_impl*
 aCtx.rEngine.PushBool(anIterator.HasNext);
//#UC END# *4EB2634D0118_4EB25F2501B3_impl*
end;//TkwDiffIteratorHasNext.DoIterator

class function TkwDiffIteratorHasNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'DiffIterator:HasNext';
end;//TkwDiffIteratorHasNext.GetWordNameForRegister

initialization
 TkwDiffIteratorHasNext.RegisterInEngine;
 {* Регистрация TkwDiffIteratorHasNext }
{$IfEnd} // NOT Defined(NoScripts)

end.
