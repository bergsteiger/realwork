unit tfwMembersIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMembersIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwMembersIterator" MUID: (52E29F1A037E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwMembersIteratorPrim
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
;

type
 TtfwMembersIterator = class(TtfwMembersIteratorPrim, ItfwValueList)
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(aDictionary: TtfwDictionaryPrim): ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwMembersIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

class function TtfwMembersIterator.Make(aDictionary: TtfwDictionaryPrim): ItfwValueList;
var
 l_Inst : TtfwMembersIterator;
begin
 l_Inst := Create(aDictionary);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwMembersIterator.Make

procedure TtfwMembersIterator.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_52E29F1A037E_var*
var
 l_I : Integer;
 l_K : TtfwKeyWord;
//#UC END# *52E23B7A00EC_52E29F1A037E_var*
begin
//#UC START# *52E23B7A00EC_52E29F1A037E_impl*
 if (Dictionary <> nil) then
 begin
  for l_I := 0 to Pred(Dictionary.Count) do
  begin
   l_K := TtfwKeyWord(Dictionary.Items[l_I]);
   if (l_K <> nil) AND (l_K.Word <> nil) then
   begin
    aCtx.rEngine.PushObj(l_K.Word);
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
   end;//l_K <> nil..
  end;//for l_I
 end;//Dictionary <> nil
//#UC END# *52E23B7A00EC_52E29F1A037E_impl*
end;//TtfwMembersIterator.ForEach

procedure TtfwMembersIterator.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_52E29F1A037E_var*
var
 l_I : Integer;
 l_K : TtfwKeyWord;
//#UC END# *52E23BB102FA_52E29F1A037E_var*
begin
//#UC START# *52E23BB102FA_52E29F1A037E_impl*
 if (Dictionary <> nil) then
 begin
  for l_I := Pred(Dictionary.Count) downto 0 do
  begin
   l_K := TtfwKeyWord(Dictionary.Items[l_I]);
   if (l_K <> nil) AND (l_K.Word <> nil) then
   begin
    aCtx.rEngine.PushObj(l_K.Word);
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
   end;//l_K <> nil..
  end;//for l_I
 end;//Dictionary <> nil
//#UC END# *52E23BB102FA_52E29F1A037E_impl*
end;//TtfwMembersIterator.ForEachBack

procedure TtfwMembersIterator.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_52E29F1A037E_var*
//#UC END# *55CDF40C03D4_52E29F1A037E_var*
begin
//#UC START# *55CDF40C03D4_52E29F1A037E_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_52E29F1A037E_impl*
end;//TtfwMembersIterator.SetItem

function TtfwMembersIterator.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_52E29F1A037E_var*
//#UC END# *55E849210175_52E29F1A037E_var*
begin
//#UC START# *55E849210175_52E29F1A037E_impl*
 Result := 1;
//#UC END# *55E849210175_52E29F1A037E_impl*
end;//TtfwMembersIterator.ItemsCountInSlice

procedure TtfwMembersIterator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52E29F1A037E_var*
//#UC END# *479731C50290_52E29F1A037E_var*
begin
//#UC START# *479731C50290_52E29F1A037E_impl*
 inherited;
//#UC END# *479731C50290_52E29F1A037E_impl*
end;//TtfwMembersIterator.Cleanup
{$IfEnd} // NOT Defined(NoScripts)

end.
