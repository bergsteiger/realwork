unit k2NullTagImplPrim;
 {* Реализация пустого тега }

// Модуль: "w:\common\components\rtl\Garant\K2\k2NullTagImplPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2SpecialTag
 , l3Variant
 , l3Interfaces
;

type
 _k2Int64Holder_Parent_ = Tk2SpecialTag;
 {$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}
 Tk2NullTagImplPrim = class(_k2Int64Holder_)
  {* Реализация пустого тега }
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
   function GetIsNull: Boolean; override;
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
   function CloneTag: Il3TagRef; override;
   function rOwnAtom(anIndex: Integer): Tl3Variant; override;
 end;//Tk2NullTagImplPrim

implementation

uses
 l3ImplUses
 , k2Base
 , l3Const
 , l3String
 , k2Strings
 , k2Empty_Const
 , k2Tags
;

type _Instance_R_ = Tk2NullTagImplPrim;

{$Include w:\common\components\rtl\Garant\K2\k2Int64Holder.imp.pas}

function Tk2NullTagImplPrim.CloneTag: Il3TagRef;
//#UC START# *47612DF00301_49A69B87036C_var*
//#UC END# *47612DF00301_49A69B87036C_var*
begin
//#UC START# *47612DF00301_49A69B87036C_impl*
 Result := Self;
//#UC END# *47612DF00301_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.CloneTag

{$If NOT Defined(DesignTimeLibrary)}
class function Tk2NullTagImplPrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_49A69B87036C_var*
//#UC END# *47A6FEE600FC_49A69B87036C_var*
begin
//#UC START# *47A6FEE600FC_49A69B87036C_impl*
 Result := true;
//#UC END# *47A6FEE600FC_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function Tk2NullTagImplPrim.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_49A69B87036C_var*
//#UC END# *47A869BB02DE_49A69B87036C_var*
begin
//#UC START# *47A869BB02DE_49A69B87036C_impl*
 l3AssignNil(Result);
//#UC END# *47A869BB02DE_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetAsPCharLen

function Tk2NullTagImplPrim.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_49A69B87036C_var*
//#UC END# *48CF96D80241_49A69B87036C_var*
begin
//#UC START# *48CF96D80241_49A69B87036C_impl*
 Result := -1;
 k2FreeTIA(Action);
//#UC END# *48CF96D80241_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.DoIterateChildrenF

procedure Tk2NullTagImplPrim.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_49A69B87036C_var*
//#UC END# *49A545D501F6_49A69B87036C_var*
begin
//#UC START# *49A545D501F6_49A69B87036C_impl*
 Assert(false);
//#UC END# *49A545D501F6_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.DoIterateProperties

function Tk2NullTagImplPrim.rOwnAtom(anIndex: Integer): Tl3Variant;
//#UC START# *4BC843C40240_49A69B87036C_var*
//#UC END# *4BC843C40240_49A69B87036C_var*
begin
//#UC START# *4BC843C40240_49A69B87036C_impl*
 Result := Self;
//#UC END# *4BC843C40240_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.rOwnAtom

function Tk2NullTagImplPrim.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_49A69B87036C_var*
//#UC END# *4C6D1C29031F_49A69B87036C_var*
begin
//#UC START# *4C6D1C29031F_49A69B87036C_impl*
 Result := false;
//#UC END# *4C6D1C29031F_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.DoMarkModified

function Tk2NullTagImplPrim.GetIsNull: Boolean;
//#UC START# *5327E77D0084_49A69B87036C_var*
//#UC END# *5327E77D0084_49A69B87036C_var*
begin
//#UC START# *5327E77D0084_49A69B87036C_impl*
 Result := true;
//#UC END# *5327E77D0084_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetIsNull

function Tk2NullTagImplPrim.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_49A69B87036C_var*
//#UC END# *5329CD1A020E_49A69B87036C_var*
begin
//#UC START# *5329CD1A020E_49A69B87036C_impl*
 Result := '';
//#UC END# *5329CD1A020E_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetAsString

function Tk2NullTagImplPrim.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_49A69B87036C_var*
//#UC END# *532AE8F2009A_49A69B87036C_var*
begin
//#UC START# *532AE8F2009A_49A69B87036C_impl*
 Result := true;
//#UC END# *532AE8F2009A_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetIsOrd

function Tk2NullTagImplPrim.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_49A69B87036C_var*
//#UC END# *533121AF0203_49A69B87036C_var*
begin
//#UC START# *533121AF0203_49A69B87036C_impl*
 Result := k2_typEmpty;
//#UC END# *533121AF0203_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetTagType

function Tk2NullTagImplPrim.GetAttr(anIndex: Integer;
 out theValue: Tl3Variant): Boolean;
//#UC START# *53319C270138_49A69B87036C_var*
//#UC END# *53319C270138_49A69B87036C_var*
begin
//#UC START# *53319C270138_49A69B87036C_impl*
 Result := true;
 theValue := Self;
//#UC END# *53319C270138_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.GetAttr

function Tk2NullTagImplPrim.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_49A69B87036Cget_var*
//#UC END# *53343980014A_49A69B87036Cget_var*
begin
//#UC START# *53343980014A_49A69B87036Cget_impl*
 Result := Self;
//#UC END# *53343980014A_49A69B87036Cget_impl*
end;//Tk2NullTagImplPrim.pm_GetTagOwner

procedure Tk2NullTagImplPrim.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_49A69B87036Cset_var*
//#UC END# *53343980014A_49A69B87036Cset_var*
begin
//#UC START# *53343980014A_49A69B87036Cset_impl*
 Assert(false);
//#UC END# *53343980014A_49A69B87036Cset_impl*
end;//Tk2NullTagImplPrim.pm_SetTagOwner

function Tk2NullTagImplPrim.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_49A69B87036Cget_var*
//#UC END# *5335815D03DC_49A69B87036Cget_var*
begin
//#UC START# *5335815D03DC_49A69B87036Cget_impl*
 Result := 0;
//#UC END# *5335815D03DC_49A69B87036Cget_impl*
end;//Tk2NullTagImplPrim.pm_GetChildrenCount

function Tk2NullTagImplPrim.CheckAttr(const aPath: array of Integer;
 const aContext: Il3OpPack;
 DoCheck: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *533D6FD80051_49A69B87036C_var*
//#UC END# *533D6FD80051_49A69B87036C_var*
begin
//#UC START# *533D6FD80051_49A69B87036C_impl*
 Result := Self;
//#UC END# *533D6FD80051_49A69B87036C_impl*
end;//Tk2NullTagImplPrim.CheckAttr

end.
