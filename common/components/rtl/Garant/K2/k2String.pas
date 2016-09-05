unit k2String;

// Модуль: "w:\common\components\rtl\Garant\K2\k2String.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2String" MUID: (53073D3D00BE)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3_String
 , l3Variant
 , k2Base
 , k2BaseStruct
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
 _k2Tag_Parent_ = Tl3_String;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 Tk2String = class(_k2Tag_)
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure InitFields; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
  public
   constructor Create(aType: Tk2Type); reintroduce; overload;
   constructor Create; reintroduce; overload;
   class function Make(aType: Tk2Type): Il3TagRef; overload;
 end;//Tk2String

implementation

uses
 l3ImplUses
 , k2String_Const
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
 //#UC START# *53073D3D00BEimpl_uses*
 //#UC END# *53073D3D00BEimpl_uses*
;

type _Instance_R_ = Tk2String;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

constructor Tk2String.Create(aType: Tk2Type);
//#UC START# *5315D861004C_53073D3D00BE_var*
//#UC END# *5315D861004C_53073D3D00BE_var*
begin
//#UC START# *5315D861004C_53073D3D00BE_impl*
 Assert(aType = k2_typString);
 inherited Create;
//#UC END# *5315D861004C_53073D3D00BE_impl*
end;//Tk2String.Create

constructor Tk2String.Create;
//#UC START# *5315D8840067_53073D3D00BE_var*
//#UC END# *5315D8840067_53073D3D00BE_var*
begin
//#UC START# *5315D8840067_53073D3D00BE_impl*
 inherited Create;
//#UC END# *5315D8840067_53073D3D00BE_impl*
end;//Tk2String.Create

class function Tk2String.Make(aType: Tk2Type): Il3TagRef;
//#UC START# *5356A98502EE_53073D3D00BE_var*
var
 l_Inst : Tk2String;
//#UC END# *5356A98502EE_53073D3D00BE_var*
begin
//#UC START# *5356A98502EE_53073D3D00BE_impl*
 l_Inst := Create(aType);
 try
  Result := l_Inst.AsRef;
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *5356A98502EE_53073D3D00BE_impl*
end;//Tk2String.Make

{$If NOT Defined(k2TagIsAtomic)}
function Tk2String.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_53073D3D00BE_var*
//#UC END# *49A545580241_53073D3D00BE_var*
begin
//#UC START# *49A545580241_53073D3D00BE_impl*
 Assert(false);
 Result := false;
//#UC END# *49A545580241_53073D3D00BE_impl*
end;//Tk2String.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure Tk2String.InitFields;
//#UC START# *47A042E100E2_53073D3D00BE_var*
//#UC END# *47A042E100E2_53073D3D00BE_var*
begin
//#UC START# *47A042E100E2_53073D3D00BE_impl*
 inherited;
 //f_TagType := k2_typString;
//#UC END# *47A042E100E2_53073D3D00BE_impl*
end;//Tk2String.InitFields

function Tk2String.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53073D3D00BE_var*
//#UC END# *532AE8F2009A_53073D3D00BE_var*
begin
//#UC START# *532AE8F2009A_53073D3D00BE_impl*
 Result := false;
//#UC END# *532AE8F2009A_53073D3D00BE_impl*
end;//Tk2String.GetIsOrd

function Tk2String.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_53073D3D00BE_var*
//#UC END# *533121AF0203_53073D3D00BE_var*
begin
//#UC START# *533121AF0203_53073D3D00BE_impl*
 Result := k2_typString;
//#UC END# *533121AF0203_53073D3D00BE_impl*
end;//Tk2String.GetTagType

end.
