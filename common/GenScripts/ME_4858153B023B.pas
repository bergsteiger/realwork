unit evBitmapParaBitmapContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\evBitmapParaBitmapContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3IEBitmapContainer
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

 {$Define k2TagNoAssign}

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = Tl3IEBitmapContainer;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 TevBitmapParaBitmapContainer = class(_k2Tag_)
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
  public
   constructor Create(aType: Tk2Type); reintroduce;
 end;//TevBitmapParaBitmapContainer

implementation

uses
 l3ImplUses
 , BitmapPara_Const
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
 , k2List
;

type _Instance_R_ = TevBitmapParaBitmapContainer;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

constructor TevBitmapParaBitmapContainer.Create(aType: Tk2Type);
//#UC START# *53075BB9030D_4858153B023B_var*
//#UC END# *53075BB9030D_4858153B023B_var*
begin
//#UC START# *53075BB9030D_4858153B023B_impl*
 inherited Create;
 //f_TagType := aType;
//#UC END# *53075BB9030D_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.Create

{$If NOT Defined(k2TagIsAtomic)}
function TevBitmapParaBitmapContainer.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_4858153B023B_var*
//#UC END# *49A545580241_4858153B023B_var*
begin
//#UC START# *49A545580241_4858153B023B_impl*
 Assert(false);
 Result := false;
//#UC END# *49A545580241_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function TevBitmapParaBitmapContainer.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_4858153B023B_var*
//#UC END# *532AE8F2009A_4858153B023B_var*
begin
//#UC START# *532AE8F2009A_4858153B023B_impl*
 Result := false;
//#UC END# *532AE8F2009A_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.GetIsOrd

function TevBitmapParaBitmapContainer.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_4858153B023B_var*
//#UC END# *533121AF0203_4858153B023B_var*
begin
//#UC START# *533121AF0203_4858153B023B_impl*
 Result := k2_typBitmapPara_Object;
//#UC END# *533121AF0203_4858153B023B_impl*
end;//TevBitmapParaBitmapContainer.GetTagType

end.
