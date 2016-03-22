unit tfwAxiomaticsResNameGetterList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetterList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwAxiomaticsResNameGetterList" MUID: (55B7A37F010E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwAxiomaticsResNameGetter
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = RtfwAxiomaticsResNameGetter;
 _l3UnrefcountedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
 TtfwAxiomaticsResNameGetterList = class(_l3UnrefcountedList_)
 end;//TtfwAxiomaticsResNameGetterList
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

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55B7A37F010E_var*
//#UC END# *47B99D4503A2_55B7A37F010E_var*
begin
//#UC START# *47B99D4503A2_55B7A37F010E_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_55B7A37F010E_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwAxiomaticsResNameGetterList;

{$Include w:\common\components\rtl\Garant\L3\l3UnrefcountedList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
