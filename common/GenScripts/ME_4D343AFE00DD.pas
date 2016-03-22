unit nscTasksPanelGroupDescList;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelGroupDescList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTasksPanelGroupDescList" MUID: (4D343AFE00DD)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnscTasksPanelGroupDesc = object
  public
   rCaption: Pl3StringIDEx;
   rControl: TWinControl;
  public
   function EQ(const anOther: TnscTasksPanelGroupDesc): Boolean;
 end;//TnscTasksPanelGroupDesc

 _ItemType_ = TnscTasksPanelGroupDesc;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TnscTasksPanelGroupDescList = class(_l3RecordWithEQList_)
 end;//TnscTasksPanelGroupDescList

function TnscTasksPanelGroupDesc_C(aCaption: Pl3StringIDEx;
 aControl: TWinControl): TnscTasksPanelGroupDesc;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3String
;

function TnscTasksPanelGroupDesc_C(aCaption: Pl3StringIDEx;
 aControl: TWinControl): TnscTasksPanelGroupDesc;
//#UC START# *4D34323402E0_4D34320903B4_var*
//#UC END# *4D34323402E0_4D34320903B4_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4D34323402E0_4D34320903B4_impl*
 Result.rCaption := aCaption;
 Result.rControl := aControl;
//#UC END# *4D34323402E0_4D34320903B4_impl*
end;//TnscTasksPanelGroupDesc_C

function TnscTasksPanelGroupDesc.EQ(const anOther: TnscTasksPanelGroupDesc): Boolean;
//#UC START# *4D343FED023A_4D34320903B4_var*
//#UC END# *4D343FED023A_4D34320903B4_var*
begin
//#UC START# *4D343FED023A_4D34320903B4_impl*
 Result := (rControl = anOther.rControl);
//#UC END# *4D343FED023A_4D34320903B4_impl*
end;//TnscTasksPanelGroupDesc.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D343AFE00DD_var*
//#UC END# *47B2C42A0163_4D343AFE00DD_var*
begin
//#UC START# *47B2C42A0163_4D343AFE00DD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D343AFE00DD_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4D343AFE00DD_var*
//#UC END# *47B99D4503A2_4D343AFE00DD_var*
begin
//#UC START# *47B99D4503A2_4D343AFE00DD_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4D343AFE00DD_impl*
end;//CompareExistingItems

type _Instance_R_ = TnscTasksPanelGroupDescList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
{$IfEnd} // Defined(Nemesis)

end.
