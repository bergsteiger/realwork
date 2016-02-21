unit tfwStoredValuesStack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStoredValuesStack.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , tfwDictionaryPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ItfwStoredValues;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TtfwStoredValuesStack = class(_l3InterfaceRefListPrim_, ItfwStoredValuesStack)
  protected
   function pm_GetCount: Integer;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create; reintroduce;
   class function Make: ItfwStoredValuesStack; reintroduce;
   procedure Restore(const aCtx: TtfwContext);
   procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
    const aCtx: TtfwContext);
 end;//TtfwStoredValuesStack
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwStoredValues
 , tfwArray
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = ItfwStoredValues;{$IfEnd}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: ItfwStoredValues;
 const aFrom: ItfwStoredValues); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: ItfwStoredValues;
 const B: ItfwStoredValues): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4F49416600CB_var*
//#UC END# *47B07CF403D0_4F49416600CB_var*
begin
//#UC START# *47B07CF403D0_4F49416600CB_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4F49416600CB_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: ItfwStoredValues;
 const aFrom: ItfwStoredValues);
//#UC START# *47B2C42A0163_4F49416600CB_var*
//#UC END# *47B2C42A0163_4F49416600CB_var*
begin
//#UC START# *47B2C42A0163_4F49416600CB_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F49416600CB_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4F49416600CB_var*
//#UC END# *47B99D4503A2_4F49416600CB_var*
begin
//#UC START# *47B99D4503A2_4F49416600CB_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F49416600CB_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwStoredValuesStack;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

constructor TtfwStoredValuesStack.Create;
//#UC START# *4F49438E0354_4F49416600CB_var*
//#UC END# *4F49438E0354_4F49416600CB_var*
begin
//#UC START# *4F49438E0354_4F49416600CB_impl*
 inherited Create;
//#UC END# *4F49438E0354_4F49416600CB_impl*
end;//TtfwStoredValuesStack.Create

class function TtfwStoredValuesStack.Make: ItfwStoredValuesStack;
var
 l_Inst : TtfwStoredValuesStack;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwStoredValuesStack.Make

function TtfwStoredValuesStack.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_4F49416600CBget_var*
//#UC END# *4BB08B8902F2_4F49416600CBget_var*
begin
//#UC START# *4BB08B8902F2_4F49416600CBget_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_4F49416600CBget_impl*
end;//TtfwStoredValuesStack.pm_GetCount

procedure TtfwStoredValuesStack.Restore(const aCtx: TtfwContext);
//#UC START# *4F494C2C0049_4F49416600CB_var*
var
 l_I : Integer;
 l_Last : PItemType;
//#UC END# *4F494C2C0049_4F49416600CB_var*
begin
//#UC START# *4F494C2C0049_4F49416600CB_impl*
 l_I := Count - 1;
 l_Last := ItemSlot(l_I);
 if (l_Last^ <> nil) then
  l_Last.Restore(aCtx);
(* if (Last <> nil) then
  Last.Restore(aCtx);*)
 DeleteLast; 
 //Delete(l_I);
//#UC END# *4F494C2C0049_4F49416600CB_impl*
end;//TtfwStoredValuesStack.Restore

procedure TtfwStoredValuesStack.StoreDictionary(aDictionary: TtfwDictionaryPrim;
 const aCtx: TtfwContext);
//#UC START# *55A52ACE0238_4F49416600CB_var*
var
 l_SV : ItfwStoredValues;
 l_Index : Integer;
 l_W : TtfwWord;
 l_SVE : PtfwStoredValue;
//#UC END# *55A52ACE0238_4F49416600CB_var*
begin
//#UC START# *55A52ACE0238_4F49416600CB_impl*
 l_SV := nil;
 if (aDictionary <> nil) then
 begin
  for l_Index := 0 to Pred(aDictionary.Count) do
  begin
   l_W := TtfwKeyWord(aDictionary.Items[l_Index]).Word;
   if l_W.IsVarLike then
   begin
    if (l_SV = nil) then
     l_SV := TtfwStoredValues.Make;
    l_SVE := l_SV.Grow;
    l_SVE.rWord := l_W;
    l_SVE.rValue := l_W.GetValue(aCtx)^;
    if (l_SVE.rValue.rType = tfw_vtList) then
     l_W.SetValuePrim(TtfwStackValue_E, aCtx);
     //l_W.InitValue(aCtx);
     //l_W.SetValue(TtfwStackValue_C(TtfwArray.Make), aCtx);
     // - чтобы последующий вызов не испортил наш массив
   end;//l_W.IsVarLike
  end;//for l_Index
 end;//aDictionary <> nil
 Self.Add(l_SV);
//#UC END# *55A52ACE0238_4F49416600CB_impl*
end;//TtfwStoredValuesStack.StoreDictionary

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwStoredValuesStack.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4F49416600CB_var*
//#UC END# *47A6FEE600FC_4F49416600CB_var*
begin
//#UC START# *47A6FEE600FC_4F49416600CB_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4F49416600CB_impl*
end;//TtfwStoredValuesStack.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(NoScripts)
end.
