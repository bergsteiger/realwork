{$IfNDef tfwDictionaryListIteratorPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "tfwDictionaryListIteratorPrim" MUID: (55E9A6C303B7)
// Имя типа: "_tfwDictionaryListIteratorPrim_"

{$Define tfwDictionaryListIteratorPrim_imp}

{$If NOT Defined(NoScripts)}
 // _ListType_

 _tfwDictionaryListIteratorPrim_ = {abstract} class(_tfwDictionaryListIteratorPrim_Parent_, ItfwValueList)
  protected
   function ListToIterate: _ListType_; virtual; abstract;
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
  public
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//_tfwDictionaryListIteratorPrim_

{$Else NOT Defined(NoScripts)}

_tfwDictionaryListIteratorPrim_ = _tfwDictionaryListIteratorPrim_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwDictionaryListIteratorPrim_imp}

{$IfNDef tfwDictionaryListIteratorPrim_imp_impl}

{$Define tfwDictionaryListIteratorPrim_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _tfwDictionaryListIteratorPrim_.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_55E9A6C303B7_var*
var
 l_I : Integer;
 l_L : _ListType_;
//#UC END# *52E23B7A00EC_55E9A6C303B7_var*
begin
//#UC START# *52E23B7A00EC_55E9A6C303B7_impl*
 l_L := ListToIterate;
 if (l_L <> nil) then
 begin
  for l_I := 0 to Pred(l_L.Count) do
  begin
    aCtx.rEngine.PushObj(l_L.ItemSlot(l_I)^);
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
 end;//l_L <> nil
//#UC END# *52E23B7A00EC_55E9A6C303B7_impl*
end;//_tfwDictionaryListIteratorPrim_.ForEach

procedure _tfwDictionaryListIteratorPrim_.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_55E9A6C303B7_var*
var
 l_I : Integer;
 l_L : _ListType_;
//#UC END# *52E23BB102FA_55E9A6C303B7_var*
begin
//#UC START# *52E23BB102FA_55E9A6C303B7_impl*
 l_L := ListToIterate;
 if (l_L <> nil) then
 begin
  for l_I := Pred(l_L.Count) downto 0 do
  begin
    aCtx.rEngine.PushObj(l_L.ItemSlot(l_I)^);
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
 end;//l_L <> nil
//#UC END# *52E23BB102FA_55E9A6C303B7_impl*
end;//_tfwDictionaryListIteratorPrim_.ForEachBack

procedure _tfwDictionaryListIteratorPrim_.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_55E9A6C303B7_var*
//#UC END# *55CDF40C03D4_55E9A6C303B7_var*
begin
//#UC START# *55CDF40C03D4_55E9A6C303B7_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_55E9A6C303B7_impl*
end;//_tfwDictionaryListIteratorPrim_.SetItem

function _tfwDictionaryListIteratorPrim_.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_55E9A6C303B7_var*
//#UC END# *55E849210175_55E9A6C303B7_var*
begin
//#UC START# *55E849210175_55E9A6C303B7_impl*
 Result := 1;
//#UC END# *55E849210175_55E9A6C303B7_impl*
end;//_tfwDictionaryListIteratorPrim_.ItemsCountInSlice
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwDictionaryListIteratorPrim_imp_impl}

{$EndIf tfwDictionaryListIteratorPrim_imp}

