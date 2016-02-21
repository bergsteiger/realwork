unit tfwArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwArrayView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , tfwScriptingInterfaces
 , l3PureMixIns
;

type
 TtfwArrayView = class(Tl3ProtoObject, ItfwValueList)
  protected
   f_Other: ItfwValueList;
  protected
   function GetItemsCountInSlice: Integer; virtual;
   function pm_GetFirst: TtfwStackValue;
   function pm_GetLast: TtfwStackValue;
   function pm_GetItems(anIndex: Integer): TtfwStackValue;
   function pm_GetEmpty: Boolean;
   function pm_GetCount: Integer;
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(const anOther: ItfwValueList); reintroduce;
   class function Make(const anOther: ItfwValueList): ItfwValueList; reintroduce;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); virtual;
   procedure DoForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); virtual;
   function IndexOf(const anItem: TtfwStackValue): Integer;
   function Add(const anItem: TtfwStackValue): Integer;
   procedure Clear;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

constructor TtfwArrayView.Create(const anOther: ItfwValueList);
//#UC START# *52E2710E03D9_52E270AE02EA_var*
//#UC END# *52E2710E03D9_52E270AE02EA_var*
begin
//#UC START# *52E2710E03D9_52E270AE02EA_impl*
 inherited Create;
 f_Other := anOther;
//#UC END# *52E2710E03D9_52E270AE02EA_impl*
end;//TtfwArrayView.Create

class function TtfwArrayView.Make(const anOther: ItfwValueList): ItfwValueList;
var
 l_Inst : TtfwArrayView;
begin
 l_Inst := Create(anOther);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwArrayView.Make

procedure TtfwArrayView.DoForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666F6036E_52E270AE02EA_var*
//#UC END# *52E666F6036E_52E270AE02EA_var*
begin
//#UC START# *52E666F6036E_52E270AE02EA_impl*
 f_Other.ForEachBack(aLambda, aCtx);
//#UC END# *52E666F6036E_52E270AE02EA_impl*
end;//TtfwArrayView.DoForEachBack

procedure TtfwArrayView.DoForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666E80335_52E270AE02EA_var*
//#UC END# *52E666E80335_52E270AE02EA_var*
begin
//#UC START# *52E666E80335_52E270AE02EA_impl*
 f_Other.ForEach(aLambda, aCtx);
//#UC END# *52E666E80335_52E270AE02EA_impl*
end;//TtfwArrayView.DoForEach

function TtfwArrayView.GetItemsCountInSlice: Integer;
//#UC START# *55E84F5F00ED_52E270AE02EA_var*
//#UC END# *55E84F5F00ED_52E270AE02EA_var*
begin
//#UC START# *55E84F5F00ED_52E270AE02EA_impl*
 Result := 1;
//#UC END# *55E84F5F00ED_52E270AE02EA_impl*
end;//TtfwArrayView.GetItemsCountInSlice

function TtfwArrayView.pm_GetFirst: TtfwStackValue;
//#UC START# *47D8233603DD_52E270AE02EAget_var*
//#UC END# *47D8233603DD_52E270AE02EAget_var*
begin
//#UC START# *47D8233603DD_52E270AE02EAget_impl*
 Result := f_Other.First;
//#UC END# *47D8233603DD_52E270AE02EAget_impl*
end;//TtfwArrayView.pm_GetFirst

function TtfwArrayView.pm_GetLast: TtfwStackValue;
//#UC START# *47D823570315_52E270AE02EAget_var*
//#UC END# *47D823570315_52E270AE02EAget_var*
begin
//#UC START# *47D823570315_52E270AE02EAget_impl*
 Result := f_Other.Last;
//#UC END# *47D823570315_52E270AE02EAget_impl*
end;//TtfwArrayView.pm_GetLast

function TtfwArrayView.pm_GetItems(anIndex: Integer): TtfwStackValue;
//#UC START# *47D8248802AD_52E270AE02EAget_var*
//#UC END# *47D8248802AD_52E270AE02EAget_var*
begin
//#UC START# *47D8248802AD_52E270AE02EAget_impl*
 Result := f_Other.Items[anIndex];
//#UC END# *47D8248802AD_52E270AE02EAget_impl*
end;//TtfwArrayView.pm_GetItems

function TtfwArrayView.pm_GetEmpty: Boolean;
//#UC START# *47E381E203D2_52E270AE02EAget_var*
//#UC END# *47E381E203D2_52E270AE02EAget_var*
begin
//#UC START# *47E381E203D2_52E270AE02EAget_impl*
 Result := f_Other.Empty;
//#UC END# *47E381E203D2_52E270AE02EAget_impl*
end;//TtfwArrayView.pm_GetEmpty

function TtfwArrayView.IndexOf(const anItem: TtfwStackValue): Integer;
//#UC START# *482955910076_52E270AE02EA_var*
//#UC END# *482955910076_52E270AE02EA_var*
begin
//#UC START# *482955910076_52E270AE02EA_impl*
 Result := f_Other.IndexOf(anItem);
//#UC END# *482955910076_52E270AE02EA_impl*
end;//TtfwArrayView.IndexOf

function TtfwArrayView.Add(const anItem: TtfwStackValue): Integer;
//#UC START# *482958A203D0_52E270AE02EA_var*
//#UC END# *482958A203D0_52E270AE02EA_var*
begin
//#UC START# *482958A203D0_52E270AE02EA_impl*
 Result := f_Other.Add(anItem);
//#UC END# *482958A203D0_52E270AE02EA_impl*
end;//TtfwArrayView.Add

function TtfwArrayView.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_52E270AE02EAget_var*
//#UC END# *4BB08B8902F2_52E270AE02EAget_var*
begin
//#UC START# *4BB08B8902F2_52E270AE02EAget_impl*
 Result := f_Other.Count;
//#UC END# *4BB08B8902F2_52E270AE02EAget_impl*
end;//TtfwArrayView.pm_GetCount

procedure TtfwArrayView.Clear;
//#UC START# *4F62FF5D0327_52E270AE02EA_var*
//#UC END# *4F62FF5D0327_52E270AE02EA_var*
begin
//#UC START# *4F62FF5D0327_52E270AE02EA_impl*
 f_Other.Clear;
//#UC END# *4F62FF5D0327_52E270AE02EA_impl*
end;//TtfwArrayView.Clear

procedure TtfwArrayView.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_52E270AE02EA_var*
//#UC END# *52E23B7A00EC_52E270AE02EA_var*
begin
//#UC START# *52E23B7A00EC_52E270AE02EA_impl*
 DoForEach(aLambda, aCtx);
//#UC END# *52E23B7A00EC_52E270AE02EA_impl*
end;//TtfwArrayView.ForEach

procedure TtfwArrayView.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_52E270AE02EA_var*
//#UC END# *52E23BB102FA_52E270AE02EA_var*
begin
//#UC START# *52E23BB102FA_52E270AE02EA_impl*
 DoForEachBack(aLambda, aCtx);
//#UC END# *52E23BB102FA_52E270AE02EA_impl*
end;//TtfwArrayView.ForEachBack

procedure TtfwArrayView.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_52E270AE02EA_var*
//#UC END# *55CDF40C03D4_52E270AE02EA_var*
begin
//#UC START# *55CDF40C03D4_52E270AE02EA_impl*
 f_Other.SetItem(anIndex, aValue);
//#UC END# *55CDF40C03D4_52E270AE02EA_impl*
end;//TtfwArrayView.SetItem

function TtfwArrayView.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_52E270AE02EA_var*
//#UC END# *55E849210175_52E270AE02EA_var*
begin
//#UC START# *55E849210175_52E270AE02EA_impl*
 Result := GetItemsCountInSlice;
//#UC END# *55E849210175_52E270AE02EA_impl*
end;//TtfwArrayView.ItemsCountInSlice

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwArrayView.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_52E270AE02EA_var*
//#UC END# *47A6FEE600FC_52E270AE02EA_var*
begin
//#UC START# *47A6FEE600FC_52E270AE02EA_impl*
 Result := true;
//#UC END# *47A6FEE600FC_52E270AE02EA_impl*
end;//TtfwArrayView.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TtfwArrayView.ClearFields;
begin
 f_Other := nil;
 inherited;
end;//TtfwArrayView.ClearFields
{$IfEnd} // NOT Defined(NoScripts)

end.
