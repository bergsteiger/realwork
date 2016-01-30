unit k2TransparentTag;
 {* Прозрачное значение тега }

// Модуль: "w:\common\components\rtl\Garant\K2\k2TransparentTag.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2SpecialTag
 , k2Base
 , l3Variant
 , l3Interfaces
;

type
 _k2Int64Holder_Parent_ = Tk2SpecialTag;
 {$Include k2Int64Holder.imp.pas}
 Tk2TransparentTag = class(_k2Int64Holder_)
  {* Прозрачное значение тега }
  private
   f_Type: Tk2Type;
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function GetAsPCharLen: Tl3WString; override;
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DoMarkModified: Boolean; override;
   function GetAsLong: Integer; override;
   function GetIsTransparent: Boolean; override;
   function GetAsString: AnsiString; override;
   function GetIsOrd: Boolean; override;
   function GetTagType: Tl3VariantDef; override;
   function GetAttr(anIndex: Integer;
    out theValue: Tl3Variant): Boolean; override;
   function pm_GetTagOwner: Tl3Variant; override;
   procedure pm_SetTagOwner(aValue: Tl3Variant); override;
   function pm_GetChildrenCount: Integer; override;
   function CheckAttr(const aPath: array of Integer;
    const aContext: Il3OpPack;
    DoCheck: Boolean;
    theIndex: PLongint): Tl3Variant; override;
  public
   constructor Create(aType: Tk2Type); reintroduce;
   function CloneTag: Il3TagRef; override;
   function rOwnAtom(anIndex: Integer): Tl3Variant; override;
 end;//Tk2TransparentTag

implementation

uses
 l3ImplUses
 , l3String
 , k2Strings
 , k2Const
 , l3Const
 , k2NullTagImpl
 , k2Tags
;

type _Instance_R_ = Tk2TransparentTag;

{$Include k2Int64Holder.imp.pas}

constructor Tk2TransparentTag.Create(aType: Tk2Type);
//#UC START# *49C907900344_49C906E203A1_var*
//#UC END# *49C907900344_49C906E203A1_var*
begin
//#UC START# *49C907900344_49C906E203A1_impl*
 inherited Create;
 f_Type := aType;
//#UC END# *49C907900344_49C906E203A1_impl*
end;//Tk2TransparentTag.Create

function Tk2TransparentTag.CloneTag: Il3TagRef;
//#UC START# *47612DF00301_49C906E203A1_var*
//#UC END# *47612DF00301_49C906E203A1_var*
begin
//#UC START# *47612DF00301_49C906E203A1_impl*
 Result := Self;
//#UC END# *47612DF00301_49C906E203A1_impl*
end;//Tk2TransparentTag.CloneTag

{$If NOT Defined(DesignTimeLibrary)}
class function Tk2TransparentTag.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_49C906E203A1_var*
//#UC END# *47A6FEE600FC_49C906E203A1_var*
begin
//#UC START# *47A6FEE600FC_49C906E203A1_impl*
 Result := true;
//#UC END# *47A6FEE600FC_49C906E203A1_impl*
end;//Tk2TransparentTag.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function Tk2TransparentTag.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_49C906E203A1_var*
//#UC END# *47A869BB02DE_49C906E203A1_var*
begin
//#UC START# *47A869BB02DE_49C906E203A1_impl*
 l3AssignNil(Result);
//#UC END# *47A869BB02DE_49C906E203A1_impl*
end;//Tk2TransparentTag.GetAsPCharLen

function Tk2TransparentTag.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_49C906E203A1_var*
//#UC END# *48CF96D80241_49C906E203A1_var*
begin
//#UC START# *48CF96D80241_49C906E203A1_impl*
 Result := -1;
 k2FreeTIA(Action);
//#UC END# *48CF96D80241_49C906E203A1_impl*
end;//Tk2TransparentTag.DoIterateChildrenF

procedure Tk2TransparentTag.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_49C906E203A1_var*
//#UC END# *49A545D501F6_49C906E203A1_var*
begin
//#UC START# *49A545D501F6_49C906E203A1_impl*
 Assert(false);
//#UC END# *49A545D501F6_49C906E203A1_impl*
end;//Tk2TransparentTag.DoIterateProperties

function Tk2TransparentTag.rOwnAtom(anIndex: Integer): Tl3Variant;
//#UC START# *4BC843C40240_49C906E203A1_var*
//#UC END# *4BC843C40240_49C906E203A1_var*
begin
//#UC START# *4BC843C40240_49C906E203A1_impl*
 Result := Tk2NullTagImpl.Instance;
//#UC END# *4BC843C40240_49C906E203A1_impl*
end;//Tk2TransparentTag.rOwnAtom

function Tk2TransparentTag.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_49C906E203A1_var*
//#UC END# *4C6D1C29031F_49C906E203A1_var*
begin
//#UC START# *4C6D1C29031F_49C906E203A1_impl*
 Result := false;
//#UC END# *4C6D1C29031F_49C906E203A1_impl*
end;//Tk2TransparentTag.DoMarkModified

function Tk2TransparentTag.GetAsLong: Integer;
//#UC START# *5326D7B603A3_49C906E203A1_var*
//#UC END# *5326D7B603A3_49C906E203A1_var*
begin
//#UC START# *5326D7B603A3_49C906E203A1_impl*
 Result := k2_TransparentValue;
//#UC END# *5326D7B603A3_49C906E203A1_impl*
end;//Tk2TransparentTag.GetAsLong

function Tk2TransparentTag.GetIsTransparent: Boolean;
//#UC START# *5327E7AA01F1_49C906E203A1_var*
//#UC END# *5327E7AA01F1_49C906E203A1_var*
begin
//#UC START# *5327E7AA01F1_49C906E203A1_impl*
 Result := true;
//#UC END# *5327E7AA01F1_49C906E203A1_impl*
end;//Tk2TransparentTag.GetIsTransparent

function Tk2TransparentTag.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_49C906E203A1_var*
//#UC END# *5329CD1A020E_49C906E203A1_var*
begin
//#UC START# *5329CD1A020E_49C906E203A1_impl*
 Result := '';
//#UC END# *5329CD1A020E_49C906E203A1_impl*
end;//Tk2TransparentTag.GetAsString

function Tk2TransparentTag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_49C906E203A1_var*
//#UC END# *532AE8F2009A_49C906E203A1_var*
begin
//#UC START# *532AE8F2009A_49C906E203A1_impl*
 Result := true;
//#UC END# *532AE8F2009A_49C906E203A1_impl*
end;//Tk2TransparentTag.GetIsOrd

function Tk2TransparentTag.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_49C906E203A1_var*
//#UC END# *533121AF0203_49C906E203A1_var*
begin
//#UC START# *533121AF0203_49C906E203A1_impl*
 Result := f_Type;
//#UC END# *533121AF0203_49C906E203A1_impl*
end;//Tk2TransparentTag.GetTagType

function Tk2TransparentTag.GetAttr(anIndex: Integer;
 out theValue: Tl3Variant): Boolean;
//#UC START# *53319C270138_49C906E203A1_var*
//#UC END# *53319C270138_49C906E203A1_var*
begin
//#UC START# *53319C270138_49C906E203A1_impl*
 Result := true;
 theValue := Tk2NullTagImpl.Instance;
//#UC END# *53319C270138_49C906E203A1_impl*
end;//Tk2TransparentTag.GetAttr

function Tk2TransparentTag.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_49C906E203A1get_var*
//#UC END# *53343980014A_49C906E203A1get_var*
begin
//#UC START# *53343980014A_49C906E203A1get_impl*
 Result := Tk2NullTagImpl.Instance;
//#UC END# *53343980014A_49C906E203A1get_impl*
end;//Tk2TransparentTag.pm_GetTagOwner

procedure Tk2TransparentTag.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_49C906E203A1set_var*
//#UC END# *53343980014A_49C906E203A1set_var*
begin
//#UC START# *53343980014A_49C906E203A1set_impl*
 // - ничего не делаем
//#UC END# *53343980014A_49C906E203A1set_impl*
end;//Tk2TransparentTag.pm_SetTagOwner

function Tk2TransparentTag.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_49C906E203A1get_var*
//#UC END# *5335815D03DC_49C906E203A1get_var*
begin
//#UC START# *5335815D03DC_49C906E203A1get_impl*
 Result := 0;
//#UC END# *5335815D03DC_49C906E203A1get_impl*
end;//Tk2TransparentTag.pm_GetChildrenCount

function Tk2TransparentTag.CheckAttr(const aPath: array of Integer;
 const aContext: Il3OpPack;
 DoCheck: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *533D6FD80051_49C906E203A1_var*
//#UC END# *533D6FD80051_49C906E203A1_var*
begin
//#UC START# *533D6FD80051_49C906E203A1_impl*
 Result := Tk2NullTagImpl.Instance;
//#UC END# *533D6FD80051_49C906E203A1_impl*
end;//Tk2TransparentTag.CheckAttr

end.
