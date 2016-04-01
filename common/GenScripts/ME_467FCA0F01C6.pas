unit nsTagString;
 {* Строка, представляющая строковый атрибут тега }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsTagString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsTagString" MUID: (467FCA0F01C6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsString
 , k2BaseStruct
 , l3Variant
 , k2Base
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
 , l3Interfaces
;

 {$Define k2TagIsString}

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = TnsNewString;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 TnsTagString = class(_k2Tag_)
  {* Строка, представляющая строковый атрибут тега }
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure InitFields; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
  public
   function Clone: Pointer; override;
    {* Создайт копию строки. }
 end;//TnsTagString

implementation

uses
 l3ImplUses
 , l3_String
 , k2String_Const
 , k2String
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
 , k2NullTagImpl
 , k2Interfaces
 , k2DictionaryPrim
 , k2InterfaceFactory
 , k2List
;

type _Instance_R_ = TnsTagString;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

{$If NOT Defined(k2TagIsAtomic)}
function TnsTagString.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_467FCA0F01C6_var*
//#UC END# *49A545580241_467FCA0F01C6_var*
begin
//#UC START# *49A545580241_467FCA0F01C6_impl*
 Assert(false);
//#UC END# *49A545580241_467FCA0F01C6_impl*
end;//TnsTagString.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure TnsTagString.InitFields;
//#UC START# *47A042E100E2_467FCA0F01C6_var*
//#UC END# *47A042E100E2_467FCA0F01C6_var*
begin
//#UC START# *47A042E100E2_467FCA0F01C6_impl*
 inherited;
 //f_TagType := k2_typString;
//#UC END# *47A042E100E2_467FCA0F01C6_impl*
end;//TnsTagString.InitFields

function TnsTagString.Clone: Pointer;
 {* Создайт копию строки. }
//#UC START# *47BC3FC40111_467FCA0F01C6_var*
//#UC END# *47BC3FC40111_467FCA0F01C6_var*
begin
//#UC START# *47BC3FC40111_467FCA0F01C6_impl*
 Result := Tk2String.Create;
 Tk2String(Result).AssignString(Self);
//#UC END# *47BC3FC40111_467FCA0F01C6_impl*
end;//TnsTagString.Clone

function TnsTagString.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_467FCA0F01C6_var*
//#UC END# *532AE8F2009A_467FCA0F01C6_var*
begin
//#UC START# *532AE8F2009A_467FCA0F01C6_impl*
 Result := false;
//#UC END# *532AE8F2009A_467FCA0F01C6_impl*
end;//TnsTagString.GetIsOrd

function TnsTagString.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_467FCA0F01C6_var*
//#UC END# *533121AF0203_467FCA0F01C6_var*
begin
//#UC START# *533121AF0203_467FCA0F01C6_impl*
 Result := k2_typString;
//#UC END# *533121AF0203_467FCA0F01C6_impl*
end;//TnsTagString.GetTagType

end.
