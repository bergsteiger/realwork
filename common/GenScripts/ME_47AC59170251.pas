unit k2List;

// Модуль: "w:\common\components\rtl\Garant\K2\k2List.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2TagList
 , k2Base
 , l3Variant
 , k2BaseStruct
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2TagIsList}

 {$Define k2TagComplexAssign}

type
 _k2Tag_Parent_ = Tk2TagList;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 Tk2List = class(_k2Tag_)
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function ExpandSize(aTargetSize: Integer): Integer; override;
  public
   constructor Create(aTagType: Tk2Type); reintroduce;
   class function Make(aTagType: Tk2Type): Il3TagRef;
 end;//Tk2List

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
 , SysUtils
 , l3String
 , k2Except
 , k2Strings
 , TypInfo
 , l3Stream
 , l3Base
 , k2Facade
 , Classes
 , k2OList_Const
 , k2Dictionary
 , k2NonOptimizeContext
 , k2VariantImpl
 , k2Bool_Const
 , k2String
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
 , l3Memory
;

type _Instance_R_ = Tk2List;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

constructor Tk2List.Create(aTagType: Tk2Type);
//#UC START# *5281F01E011D_47AC59170251_var*
var
 l_Prop : Tk2ArrayProperty;
//#UC END# *5281F01E011D_47AC59170251_var*
begin
//#UC START# *5281F01E011D_47AC59170251_impl*
 f_TagType := aTagType;
 inherited Create;
 l_Prop := Tk2Type(TagType).ArrayProp[k2_tiChildren];
 if (l_Prop.SortIndex = k2_tiSelfID) then
  Sorted := false
 else
 begin
  SortIndex := l_Prop.SortIndex;
  Duplicates := l_Prop.Duplicates;
 end;//l_Prop.SortIndex = k2_tiSelfID
//#UC END# *5281F01E011D_47AC59170251_impl*
end;//Tk2List.Create

class function Tk2List.Make(aTagType: Tk2Type): Il3TagRef;
//#UC START# *5356A87B0080_47AC59170251_var*
var
 l_Inst : Tk2List;
//#UC END# *5356A87B0080_47AC59170251_var*
begin
//#UC START# *5356A87B0080_47AC59170251_impl*
 l_Inst := Create(aTagType);
 try
  Result := l_Inst.AsRef;
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *5356A87B0080_47AC59170251_impl*
end;//Tk2List.Make

{$If NOT Defined(k2TagIsAtomic)}
function Tk2List.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_47AC59170251_var*
//#UC END# *49A545580241_47AC59170251_var*
begin
//#UC START# *49A545580241_47AC59170251_impl*
 Assert(false);
 Result := false;
//#UC END# *49A545580241_47AC59170251_impl*
end;//Tk2List.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function Tk2List.ExpandSize(aTargetSize: Integer): Integer;
//#UC START# *47B975AF02ED_47AC59170251_var*
//#UC END# *47B975AF02ED_47AC59170251_var*
begin
//#UC START# *47B975AF02ED_47AC59170251_impl*
 if aTargetSize = 0 then
  Result := Succ(Capacity)
 else
  Result := aTargetSize;
//#UC END# *47B975AF02ED_47AC59170251_impl*
end;//Tk2List.ExpandSize

end.
