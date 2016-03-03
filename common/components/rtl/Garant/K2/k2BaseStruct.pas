unit k2BaseStruct;
 {* Базовые структуры }

// Модуль: "w:\common\components\rtl\Garant\K2\k2BaseStruct.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Prim
 , k2Interfaces
 , l3Variant
;

type
 _PropInPrim_ = object
  public
   rProp: Tk2CustomPropertyPrim;
   rDeleteMapped: Boolean;
 end;//_PropInPrim_

 _PropIn_ = object(_PropInPrim_)
  public
   rOp: Ik2Op;
 end;//_PropIn_

 _PropLoc_ = object(_PropInPrim_)
  public
   rOp: Pointer;
 end;//_PropLoc_

 Tk2Values = packed object
  {* Структура, содержащая информацию для изменения значения атрибута тега }
  private
   f_New: Tl3Variant;
   f_Tag: Tl3Variant;
   f_Type: Tk2TypePrim;
   f_Prop: Tk2CustomPropertyPrim;
  public
   rOld: Tl3Variant;
  public
   procedure Init(const aProp: _PropIn_;
    aValue: Tl3Variant;
    aTag: Tl3Variant);
    {* Инициализирует структуру }
   procedure Free;
    {* Освобождает структуру }
   function rTag: Tl3Variant;
    {* Тег, у которого меняется значение }
   procedure SetRef(var aRef: Tl3Variant);
   procedure CheckSort;
    {* Проверяет сортировку значения }
   function rNew: Tl3Variant;
   function IsNull: Boolean;
   procedure SetOwner;
    {* Устанавливает новому значению владельца }
   function IsChanged: Boolean;
    {* Значение изменилось }
 end;//Tk2Values

implementation

uses
 l3ImplUses
 , k2Base
 , l3Types
 , l3_String
 , SysUtils
;

procedure Tk2Values.Init(const aProp: _PropIn_;
 aValue: Tl3Variant;
 aTag: Tl3Variant);
 {* Инициализирует структуру }
//#UC START# *4A66CDFD01D5_4761470401C1_var*
//#UC END# *4A66CDFD01D5_4761470401C1_var*
begin
//#UC START# *4A66CDFD01D5_4761470401C1_impl*
 FillChar(Self, SizeOf(Self), 0);
 //rVT := aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT;
 f_Prop := aProp{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp;
 f_Type := Tk2TypePrim(f_Prop.AtomType);
 f_New := aValue;
 f_Tag := aTag;
 rOld := nil;
//#UC END# *4A66CDFD01D5_4761470401C1_impl*
end;//Tk2Values.Init

procedure Tk2Values.Free;
 {* Освобождает структуру }
//#UC START# *4A66CE450382_4761470401C1_var*
//#UC END# *4A66CE450382_4761470401C1_var*
begin
//#UC START# *4A66CE450382_4761470401C1_impl*
 f_Tag := nil;
 f_New := nil;
 FreeAndNil(rOld);
//#UC END# *4A66CE450382_4761470401C1_impl*
end;//Tk2Values.Free

function Tk2Values.rTag: Tl3Variant;
 {* Тег, у которого меняется значение }
//#UC START# *4A66CE690051_4761470401C1_var*
//#UC END# *4A66CE690051_4761470401C1_var*
begin
//#UC START# *4A66CE690051_4761470401C1_impl*
 Result := f_Tag;
//#UC END# *4A66CE690051_4761470401C1_impl*
end;//Tk2Values.rTag

procedure Tk2Values.SetRef(var aRef: Tl3Variant);
//#UC START# *4A66D08A002D_4761470401C1_var*
//#UC END# *4A66D08A002D_4761470401C1_var*
begin
//#UC START# *4A66D08A002D_4761470401C1_impl*
 f_New.SetRef(aRef);
//#UC END# *4A66D08A002D_4761470401C1_impl*
end;//Tk2Values.SetRef

procedure Tk2Values.CheckSort;
 {* Проверяет сортировку значения }
//#UC START# *4A66D64202A4_4761470401C1_var*
var
 l_CProp : Tl3VariantDef;
 l_New   : Tl3Variant;
//#UC END# *4A66D64202A4_4761470401C1_var*
begin
//#UC START# *4A66D64202A4_4761470401C1_impl*
 if not f_Type.IsOrd then
 begin
  if f_Prop.IsThisArray(l_CProp) then
  begin
   l_New := rNew;
   if (l_New <> nil) then
    try
     l_New.Box.CheckSort(l_CProp);
    finally
     l_CProp := nil;
    end;//try..finally
  end;//f_Prop.IsThisArray(l_CProp)
 end;//not f_Type.IsOrd
//#UC END# *4A66D64202A4_4761470401C1_impl*
end;//Tk2Values.CheckSort

function Tk2Values.rNew: Tl3Variant;
//#UC START# *4A66E6890392_4761470401C1_var*
//#UC END# *4A66E6890392_4761470401C1_var*
begin
//#UC START# *4A66E6890392_4761470401C1_impl*
 Result := f_New;
//#UC END# *4A66E6890392_4761470401C1_impl*
end;//Tk2Values.rNew

function Tk2Values.IsNull: Boolean;
//#UC START# *4A66EE0B0274_4761470401C1_var*
//#UC END# *4A66EE0B0274_4761470401C1_var*
begin
//#UC START# *4A66EE0B0274_4761470401C1_impl*
 Result := (f_New = nil) OR f_New.IsNull;
//#UC END# *4A66EE0B0274_4761470401C1_impl*
end;//Tk2Values.IsNull

procedure Tk2Values.SetOwner;
 {* Устанавливает новому значению владельца }
//#UC START# *4A66F06E0292_4761470401C1_var*
//#UC END# *4A66F06E0292_4761470401C1_var*
begin
//#UC START# *4A66F06E0292_4761470401C1_impl*
 if not f_Prop.Shared then
  if not f_Type.IsOrd then
  begin
   if (rNew <> nil) then
    rNew.Owner := f_Tag;
  end;//not f_Type.IsOrd
//#UC END# *4A66F06E0292_4761470401C1_impl*
end;//Tk2Values.SetOwner

function Tk2Values.IsChanged: Boolean;
 {* Значение изменилось }
//#UC START# *4A66F68F03AC_4761470401C1_var*
//#UC END# *4A66F68F03AC_4761470401C1_var*
begin
//#UC START# *4A66F68F03AC_4761470401C1_impl*
 Result := true;
(* if (V.rOld <> V.rNew^) AND
    ((V.rOld = nil) OR not V.rOld.IsSame(V.rNew^)) then*)
//#UC END# *4A66F68F03AC_4761470401C1_impl*
end;//Tk2Values.IsChanged

end.
