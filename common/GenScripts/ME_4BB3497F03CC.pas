unit exprTokensList;

// Модуль: "w:\common\components\rtl\external\Expr\exprTokensList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\external\Expr\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TexprTokenInfo = object
  {* Информация о токене }
  public
   rChar: Integer;
    {* "Символ" }
   rPos: Integer;
    {* Эффективная позиция символа (в исходной строке) }
   rString: Il3CString;
    {* Дополнительная строка (если существует) }
  public
   function IsA(aChar: AnsiChar): Boolean; overload;
   function IsA(anInt: Integer): Boolean; overload;
 end;//TexprTokenInfo

 {$Define l3Items_NoSort}

 _ItemType_ = TexprTokenInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TexprTokensList = class(_l3RecordListPrim_)
 end;//TexprTokensList

function TexprTokenInfo_C(aChar: Integer;
 aPos: Integer;
 const aString: Il3CString = nil): TexprTokenInfo;
 {* Создаёт информацию о токене }

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TexprTokenInfo_C(aChar: Integer;
 aPos: Integer;
 const aString: Il3CString = nil): TexprTokenInfo;
 {* Создаёт информацию о токене }
//#UC START# *4BB34BE200EB_4BB34A130179_var*
//#UC END# *4BB34BE200EB_4BB34A130179_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4BB34BE200EB_4BB34A130179_impl*
 Result.rChar := aChar;
 Result.rPos := aPos;
 Result.rString := aString;
//#UC END# *4BB34BE200EB_4BB34A130179_impl*
end;//TexprTokenInfo_C

function TexprTokenInfo.IsA(aChar: AnsiChar): Boolean;
//#UC START# *4BB34F6602CC_4BB34A130179_var*
//#UC END# *4BB34F6602CC_4BB34A130179_var*
begin
//#UC START# *4BB34F6602CC_4BB34A130179_impl*
 Result := IsA(Integer(aChar));
//#UC END# *4BB34F6602CC_4BB34A130179_impl*
end;//TexprTokenInfo.IsA

function TexprTokenInfo.IsA(anInt: Integer): Boolean;
//#UC START# *4BB34F8B0303_4BB34A130179_var*
//#UC END# *4BB34F8B0303_4BB34A130179_var*
begin
//#UC START# *4BB34F8B0303_4BB34A130179_impl*
 Result := (rChar = anInt);
//#UC END# *4BB34F8B0303_4BB34A130179_impl*
end;//TexprTokenInfo.IsA

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4BB3497F03CC_var*
//#UC END# *47B07CF403D0_4BB3497F03CC_var*
begin
//#UC START# *47B07CF403D0_4BB3497F03CC_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4BB3497F03CC_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4BB3497F03CC_var*
//#UC END# *47B2C42A0163_4BB3497F03CC_var*
begin
//#UC START# *47B2C42A0163_4BB3497F03CC_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4BB3497F03CC_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4BB3497F03CC_var*
//#UC END# *47B99D4503A2_4BB3497F03CC_var*
begin
//#UC START# *47B99D4503A2_4BB3497F03CC_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4BB3497F03CC_impl*
end;//CompareExistingItems

type _Instance_R_ = TexprTokensList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

end.
