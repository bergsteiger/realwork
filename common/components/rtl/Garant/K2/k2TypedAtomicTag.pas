unit k2TypedAtomicTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2TypedAtomicTag.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedAtomicTag
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
  k2AtomicTag,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Variant,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

 {$Define k2TagIsAtomic}

 {$Define k2Tag_No_f_TagType}

type
 Rk2TypedAtomicTag = class of Tk2TypedAtomicTag;

 _k2Tag_Parent_ = Tk2AtomicTag;
 {$Include ..\K2\k2Tag.imp.pas}
 Tk2TypedAtomicTag = class(_k2Tag_)
 protected
 // realized methods
   {$If not defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} //not k2TagIsAtomic
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   constructor Create(aValue: Integer;
     aType: Tk2Type); reintroduce;
 end;//Tk2TypedAtomicTag

implementation

uses
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  SysUtils,
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
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2TypedAtomicTag;

{$Include ..\K2\k2Tag.imp.pas}

// start class Tk2TypedAtomicTag

constructor Tk2TypedAtomicTag.Create(aValue: Integer;
  aType: Tk2Type);
//#UC START# *5273CF7E0177_5273CF4602B7_var*
//#UC END# *5273CF7E0177_5273CF4602B7_var*
begin
//#UC START# *5273CF7E0177_5273CF4602B7_impl*
 f_Value := aValue;
 inherited Create;
 Assert(TagType = aType);
//#UC END# *5273CF7E0177_5273CF4602B7_impl*
end;//Tk2TypedAtomicTag.Create

{$If not defined(k2TagIsAtomic)}
function Tk2TypedAtomicTag.SetAtomPrim(const aProp: _PropIn_;
  var V: Tk2Values): Boolean;
//#UC START# *49A545580241_5273CF4602B7_var*
//#UC END# *49A545580241_5273CF4602B7_var*
begin
//#UC START# *49A545580241_5273CF4602B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *49A545580241_5273CF4602B7_impl*
end;//Tk2TypedAtomicTag.SetAtomPrim
{$IfEnd} //not k2TagIsAtomic

{$If not defined(DesignTimeLibrary)}
class function Tk2TypedAtomicTag.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_5273CF4602B7_var*
//#UC END# *47A6FEE600FC_5273CF4602B7_var*
begin
//#UC START# *47A6FEE600FC_5273CF4602B7_impl*
 Result := true;
 //Result := false;
//#UC END# *47A6FEE600FC_5273CF4602B7_impl*
end;//Tk2TypedAtomicTag.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.