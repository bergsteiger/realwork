unit k2List;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2List.pas"
// Начат: 22.02.99 19:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2List
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base,
  k2TagList,
  l3Variant,
  k2Prim,
  k2BaseStruct,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2TagIsList}

 {$Define k2TagComplexAssign}
 { - !!! http://mdp.garant.ru/pages/viewpage.action?pageId=228688745&focusedCommentId=273590280#comment-273590280 !!! }

type
 _k2Tag_Parent_ = Tk2TagList;
 {$Include ..\K2\k2Tag.imp.pas}
 Tk2List = class(_k2Tag_)
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 protected
 // overridden protected methods
   function ExpandSize(aTargetSize: Integer): Integer; override;
 public
 // public methods
   constructor Create(aTagType: Tk2Type); reintroduce;
   class function Make(aTagType: Tk2Type): Il3TagRef;
 end;//Tk2List

implementation

uses
  SysUtils,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Stream,
  l3Base,
  k2Facade,
  Classes,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2String,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2List;

{$Include ..\K2\k2Tag.imp.pas}

// start class Tk2List

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

{$If not defined(k2TagIsAtomic)}
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
{$IfEnd} //not k2TagIsAtomic

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