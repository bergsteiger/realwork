unit tfwKeywordsIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwKeywordsIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwMembersIteratorPrim
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
;

type
 TtfwKeywordsIterator = class(TtfwMembersIteratorPrim, ItfwValueList)
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
  public
   class function Make(aDictionary: TtfwDictionaryPrim): ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwKeywordsIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TtfwKeywordsIterator.Make(aDictionary: TtfwDictionaryPrim): ItfwValueList;
var
 l_Inst : TtfwKeywordsIterator;
begin
 l_Inst := Create(aDictionary);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwKeywordsIterator.Make

procedure TtfwKeywordsIterator.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_55ED4BC100BB_var*
var
 l_I : Integer;
//#UC END# *52E23B7A00EC_55ED4BC100BB_var*
begin
//#UC START# *52E23B7A00EC_55ED4BC100BB_impl*
 if (Dictionary <> nil) then
 begin
  for l_I := 0 to Pred(Dictionary.Count) do
  begin
   aCtx.rEngine.PushObj(Dictionary.ItemSlot(l_I)^);
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
 end;//Dictionary <> nil
//#UC END# *52E23B7A00EC_55ED4BC100BB_impl*
end;//TtfwKeywordsIterator.ForEach

procedure TtfwKeywordsIterator.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_55ED4BC100BB_var*
var
 l_I : Integer;
//#UC END# *52E23BB102FA_55ED4BC100BB_var*
begin
//#UC START# *52E23BB102FA_55ED4BC100BB_impl*
 if (Dictionary <> nil) then
 begin
  for l_I := Pred(Dictionary.Count) downto 0 do
  begin
   aCtx.rEngine.PushObj(Dictionary.ItemSlot(l_I)^);
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
 end;//Dictionary <> nil
//#UC END# *52E23BB102FA_55ED4BC100BB_impl*
end;//TtfwKeywordsIterator.ForEachBack

procedure TtfwKeywordsIterator.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_55ED4BC100BB_var*
//#UC END# *55CDF40C03D4_55ED4BC100BB_var*
begin
//#UC START# *55CDF40C03D4_55ED4BC100BB_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_55ED4BC100BB_impl*
end;//TtfwKeywordsIterator.SetItem

function TtfwKeywordsIterator.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_55ED4BC100BB_var*
//#UC END# *55E849210175_55ED4BC100BB_var*
begin
//#UC START# *55E849210175_55ED4BC100BB_impl*
 Result := 1;
//#UC END# *55E849210175_55ED4BC100BB_impl*
end;//TtfwKeywordsIterator.ItemsCountInSlice
{$IfEnd} // NOT Defined(NoScripts)

end.
