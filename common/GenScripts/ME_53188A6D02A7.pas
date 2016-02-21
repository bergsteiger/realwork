unit k2FontName;

// Модуль: "w:\common\components\rtl\Garant\K2\k2FontName.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , l3LogFont
 , k2BaseStruct
 , l3Interfaces
 , k2Base
 , k2TagList
 , k2Prim
 , l3IID
 , k2BaseTypes
 , l3Types
;

 {$Define k2TagIsString}

 {$Define k2Tag_No_f_TagType}

type
 _k2Tag_Parent_ = Tl3PrimString;
 {$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}
 Tk2FontName = class(_k2Tag_, Il3TagRef)
  private
   f_LogFont: Tl3LogFont;
    {* Поле для свойства LogFont }
  protected
   {$If NOT Defined(k2TagIsAtomic)}
   function SetAtomPrim(const aProp: _PropIn_;
    var V: Tk2Values): Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function GetAsPCharLen: Tl3WString; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
   function GetAsRef: Il3TagRef; override;
  public
   constructor Create(aLogFont: Tl3LogFont); reintroduce;
  public
   property LogFont: Tl3LogFont
    read f_LogFont;
 end;//Tk2FontName

implementation

uses
 l3ImplUses
 , k2FontName_Const
 , SysUtils
 , k2Tags
 , l3Dict
 , k2Const
 , l3Const
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

type _Instance_R_ = Tk2FontName;

{$Include w:\common\components\rtl\Garant\K2\k2Tag.imp.pas}

constructor Tk2FontName.Create(aLogFont: Tl3LogFont);
//#UC START# *53189606008A_53188A6D02A7_var*
//#UC END# *53189606008A_53188A6D02A7_var*
begin
//#UC START# *53189606008A_53188A6D02A7_impl*
 inherited Create;
 aLogFont.SetRefTo(f_LogFont);
//#UC END# *53189606008A_53188A6D02A7_impl*
end;//Tk2FontName.Create

{$If NOT Defined(k2TagIsAtomic)}
function Tk2FontName.SetAtomPrim(const aProp: _PropIn_;
 var V: Tk2Values): Boolean;
//#UC START# *49A545580241_53188A6D02A7_var*
//#UC END# *49A545580241_53188A6D02A7_var*
begin
//#UC START# *49A545580241_53188A6D02A7_impl*
 Result := false;
 Assert(false);
//#UC END# *49A545580241_53188A6D02A7_impl*
end;//Tk2FontName.SetAtomPrim
{$IfEnd} // NOT Defined(k2TagIsAtomic)

procedure Tk2FontName.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53188A6D02A7_var*
//#UC END# *479731C50290_53188A6D02A7_var*
begin
//#UC START# *479731C50290_53188A6D02A7_impl*
 FreeAndNil(f_LogFont);
 inherited;
//#UC END# *479731C50290_53188A6D02A7_impl*
end;//Tk2FontName.Cleanup

procedure Tk2FontName.InitFields;
//#UC START# *47A042E100E2_53188A6D02A7_var*
//#UC END# *47A042E100E2_53188A6D02A7_var*
begin
//#UC START# *47A042E100E2_53188A6D02A7_impl*
 inherited;
 //f_TagType := k2_typFontName;
//#UC END# *47A042E100E2_53188A6D02A7_impl*
end;//Tk2FontName.InitFields

function Tk2FontName.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_53188A6D02A7_var*
//#UC END# *47A869BB02DE_53188A6D02A7_var*
begin
//#UC START# *47A869BB02DE_53188A6D02A7_impl*
 Result := f_LogFont.AsWStr;
//#UC END# *47A869BB02DE_53188A6D02A7_impl*
end;//Tk2FontName.GetAsPCharLen

function Tk2FontName.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53188A6D02A7_var*
//#UC END# *532AE8F2009A_53188A6D02A7_var*
begin
//#UC START# *532AE8F2009A_53188A6D02A7_impl*
 Result := false;
//#UC END# *532AE8F2009A_53188A6D02A7_impl*
end;//Tk2FontName.GetIsOrd

function Tk2FontName.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_53188A6D02A7_var*
//#UC END# *533121AF0203_53188A6D02A7_var*
begin
//#UC START# *533121AF0203_53188A6D02A7_impl*
 Result := k2_typFontName;
//#UC END# *533121AF0203_53188A6D02A7_impl*
end;//Tk2FontName.GetTagType

function Tk2FontName.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_53188A6D02A7_var*
//#UC END# *53568FCA01E8_53188A6D02A7_var*
begin
//#UC START# *53568FCA01E8_53188A6D02A7_impl*
 Result := Self;
//#UC END# *53568FCA01E8_53188A6D02A7_impl*
end;//Tk2FontName.GetAsRef

end.
