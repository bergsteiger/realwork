unit nscTasksPanelGroupDescList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelGroupDescList.pas"
// Начат: 17.01.2011 15:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelGroupDescList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3ProtoDataContainer,
  l3StringIDEx,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanelGroupDesc = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rCaption : Pl3StringIDEx;
   rControl : TWinControl;
 public
    function EQ(const anOther: TnscTasksPanelGroupDesc): Boolean;
 end;//TnscTasksPanelGroupDesc

 _ItemType_ = TnscTasksPanelGroupDesc;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TnscTasksPanelGroupDescList = class(_l3RecordWithEQList_)
 end;//TnscTasksPanelGroupDescList
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
function TnscTasksPanelGroupDesc_C(aCaption: Pl3StringIDEx;
     aControl: TWinControl): TnscTasksPanelGroupDesc;
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanelGroupDescList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D343AFE00DD_var*
//#UC END# *47B2C42A0163_4D343AFE00DD_var*
begin
//#UC START# *47B2C42A0163_4D343AFE00DD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D343AFE00DD_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
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
end;//TnscTasksPanelGroupDesc.C

// start class TnscTasksPanelGroupDesc

function TnscTasksPanelGroupDesc.EQ(const anOther: TnscTasksPanelGroupDesc): Boolean;
//#UC START# *4D343FED023A_4D34320903B4_var*
//#UC END# *4D343FED023A_4D34320903B4_var*
begin
//#UC START# *4D343FED023A_4D34320903B4_impl*
 Result := (rControl = anOther.rControl);
//#UC END# *4D343FED023A_4D34320903B4_impl*
end;//TnscTasksPanelGroupDesc.EQ

{$IfEnd} //Nemesis

end.