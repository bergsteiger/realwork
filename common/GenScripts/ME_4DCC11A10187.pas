unit tfwValueList;
 {* Список адаптированный для хранения переменных. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwValueList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = TtfwStackValue;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TtfwValueList = class(_l3RecordListPrim_)
  {* Список адаптированный для хранения переменных. }
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//TtfwValueList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

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
//#UC START# *47B07CF403D0_4DCC11A10187_var*
//#UC END# *47B07CF403D0_4DCC11A10187_var*
begin
//#UC START# *47B07CF403D0_4DCC11A10187_impl*
 Result := (A.rType = B.rType) AND
           (A.rInteger = B.rInteger) AND
           (A.rString = B.rString);
 //Assert(false);
//#UC END# *47B07CF403D0_4DCC11A10187_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4DCC11A10187_var*
//#UC END# *47B2C42A0163_4DCC11A10187_var*
begin
//#UC START# *47B2C42A0163_4DCC11A10187_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4DCC11A10187_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4DCC11A10187_var*
//#UC END# *47B99D4503A2_4DCC11A10187_var*
begin
//#UC START# *47B99D4503A2_4DCC11A10187_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4DCC11A10187_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwValueList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwValueList.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4DCC11A10187_var*
//#UC END# *47A6FEE600FC_4DCC11A10187_var*
begin
//#UC START# *47A6FEE600FC_4DCC11A10187_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4DCC11A10187_impl*
end;//TtfwValueList.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // NOT Defined(NoScripts)
end.
