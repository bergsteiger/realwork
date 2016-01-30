unit k2TypedAtomicTag;

// Модуль: "w:\common\components\rtl\Garant\K2\k2TypedAtomicTag.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2AtomicTag
 , k2Base
 , k2BaseStruct
 , l3Variant
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2TagIsAtomic}

 {$Define k2Tag_No_f_TagType}

type
 Rk2TypedAtomicTag = class of Tk2TypedAtomicTag;

 _k2Tag_Parent_ = Tk2AtomicTag;
 {$Include k2Tag.imp.pas}
 Tk2TypedAtomicTag = class(_k2Tag_)
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aValue: Integer;
    aType: Tk2Type); reintroduce;
 end;//Tk2TypedAtomicTag

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
;

type _Instance_R_ = Tk2TypedAtomicTag;

{$Include k2Tag.imp.pas}

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

{$If NOT Defined(k2TagIsAtomic)}
function Tk2TypedAtomicTag.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_5273CF4602B7_var*
//#UC END# *49A545580241_5273CF4602B7_var*
begin
//#UC START# *49A545580241_5273CF4602B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *49A545580241_5273CF4602B7_impl*
end;//Tk2TypedAtomicTag.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

{$If NOT Defined(DesignTimeLibrary)}
class function Tk2TypedAtomicTag.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_5273CF4602B7_var*
//#UC END# *47A6FEE600FC_5273CF4602B7_var*
begin
//#UC START# *47A6FEE600FC_5273CF4602B7_impl*
 Result := true;
 //Result := false;
//#UC END# *47A6FEE600FC_5273CF4602B7_impl*
end;//Tk2TypedAtomicTag.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
