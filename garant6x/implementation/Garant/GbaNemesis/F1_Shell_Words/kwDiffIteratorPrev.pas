unit kwDiffIteratorPrev;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwDiffIteratorPrev.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwDiffIteratorPrev" MUID: (4EB263BB0204)

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
 TkwDiffIteratorPrev = class(TkwDiffIteratorWord)
  protected
   procedure DoIterator(const anIterator: IDiffIterator;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDiffIteratorPrev
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
begin
 Result := 'DiffIterator:Prev';
end;//TkwDiffIteratorPrev.GetWordNameForRegister

initialization
 TkwDiffIteratorPrev.RegisterInEngine;
 {* Регистрация TkwDiffIteratorPrev }
{$IfEnd} // NOT Defined(NoScripts)

end.
