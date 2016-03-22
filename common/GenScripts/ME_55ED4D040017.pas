unit tfwWordsIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordsIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwWordsIterator" MUID: (55ED4D040017)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
 , tfwWordRefList
;

type
 TtfwWordsIterator = class(TtfwIteratableParent, ItfwValueList)
  private
   f_Words: TtfwWordRefList;
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aWords: TtfwWordRefList); reintroduce;
   class function Make(aWords: TtfwWordRefList): ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwWordsIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwWordsIterator.Create(aWords: TtfwWordRefList);
//#UC START# *55ED4DC20358_55ED4D040017_var*
//#UC END# *55ED4DC20358_55ED4D040017_var*
begin
//#UC START# *55ED4DC20358_55ED4D040017_impl*
 inherited Create;
 //f_Words := aWords;
 aWords.SetRefTo(f_Words);
//#UC END# *55ED4DC20358_55ED4D040017_impl*
end;//TtfwWordsIterator.Create

class function TtfwWordsIterator.Make(aWords: TtfwWordRefList): ItfwValueList;
var
 l_Inst : TtfwWordsIterator;
begin
 l_Inst := Create(aWords);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwWordsIterator.Make

procedure TtfwWordsIterator.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_55ED4D040017_var*
var
 l_I : Integer;
//#UC END# *52E23B7A00EC_55ED4D040017_var*
begin
//#UC START# *52E23B7A00EC_55ED4D040017_impl*
 if (f_Words <> nil) then
 begin
  for l_I := 0 to Pred(f_Words.Count) do
  begin
   aCtx.rEngine.PushObj(f_Words.ItemSlot(l_I)^);
   try
    aLambda.DoIt(aCtx);
   except
    on EtfwBreakIterator do
     break;
    on EtfwBreak do
     break;
    on EtfwContinue do
     continue;
   end;//try..except
  end;//for l_I
 end;//f_Words <> nil
//#UC END# *52E23B7A00EC_55ED4D040017_impl*
end;//TtfwWordsIterator.ForEach

procedure TtfwWordsIterator.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_55ED4D040017_var*
var
 l_I : Integer;
//#UC END# *52E23BB102FA_55ED4D040017_var*
begin
//#UC START# *52E23BB102FA_55ED4D040017_impl*
 if (f_Words <> nil) then
 begin
  for l_I := Pred(f_Words.Count) downto 0 do
  begin
   aCtx.rEngine.PushObj(f_Words.ItemSlot(l_I)^);
   try
    aLambda.DoIt(aCtx);
   except
    on EtfwBreakIterator do
     break;
    on EtfwBreak do
     break;
    on EtfwContinue do
     continue;
   end;//try..except
  end;//for l_I
 end;//f_Words <> nil
//#UC END# *52E23BB102FA_55ED4D040017_impl*
end;//TtfwWordsIterator.ForEachBack

procedure TtfwWordsIterator.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_55ED4D040017_var*
//#UC END# *55CDF40C03D4_55ED4D040017_var*
begin
//#UC START# *55CDF40C03D4_55ED4D040017_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_55ED4D040017_impl*
end;//TtfwWordsIterator.SetItem

function TtfwWordsIterator.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_55ED4D040017_var*
//#UC END# *55E849210175_55ED4D040017_var*
begin
//#UC START# *55E849210175_55ED4D040017_impl*
 Result := 1;
//#UC END# *55E849210175_55ED4D040017_impl*
end;//TtfwWordsIterator.ItemsCountInSlice

procedure TtfwWordsIterator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55ED4D040017_var*
//#UC END# *479731C50290_55ED4D040017_var*
begin
//#UC START# *479731C50290_55ED4D040017_impl*
 FreeAndNil(f_Words);
 //f_Words := nil;
 inherited;
//#UC END# *479731C50290_55ED4D040017_impl*
end;//TtfwWordsIterator.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

end.
