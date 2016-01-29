unit vcmCommandIDsListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmCommandIDsListPrim.pas"
// Начат: 20.08.2009 19:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Containers::TvcmCommandIDsListPrim
//
// Список информации о командах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmCommandInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Информация о команде }
 public
   rIsModule : Boolean; // Модуль?
   rItemID : Integer; // Идентификатор элемента (модуля/сущности)
   rOperationID : Integer; // Идентификатор операции
 public
    function EQ(const aB: TvcmCommandInfo): Boolean;
 end;//TvcmCommandInfo

 _ItemType_ = TvcmCommandInfo;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmCommandIDsListPrim = class(_l3RecordWithEQList_)
  {* Список информации о командах }
 end;//TvcmCommandIDsListPrim
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvcmCommandInfo_C(aItemID: Integer;
    aIsModule: Boolean;
    aOperationID: Integer): TvcmCommandInfo;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmCommandIDsListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A8D6F31034F_var*
//#UC END# *47B2C42A0163_4A8D6F31034F_var*
begin
//#UC START# *47B2C42A0163_4A8D6F31034F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4A8D6F31034F_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4A8D6F31034F_var*
//#UC END# *47B99D4503A2_4A8D6F31034F_var*
begin
//#UC START# *47B99D4503A2_4A8D6F31034F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4A8D6F31034F_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmCommandIDsListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}


function TvcmCommandInfo_C(aItemID: Integer;
       aIsModule: Boolean;
       aOperationID: Integer): TvcmCommandInfo;
//#UC START# *4A8D71180299_4A8D70780075_var*
//#UC END# *4A8D71180299_4A8D70780075_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A8D71180299_4A8D70780075_impl*
 Result.rItemID := aItemID;
 Result.rIsModule := aIsModule;
 Result.rOperationID := aOperationID;
//#UC END# *4A8D71180299_4A8D70780075_impl*
end;//TvcmCommandInfo.C

// start class TvcmCommandInfo

function TvcmCommandInfo.EQ(const aB: TvcmCommandInfo): Boolean;
//#UC START# *4A8D7588039F_4A8D70780075_var*
//#UC END# *4A8D7588039F_4A8D70780075_var*
begin
//#UC START# *4A8D7588039F_4A8D70780075_impl*
 Result := (rIsModule = aB.rIsModule) AND
           (rItemID = aB.rItemID) AND
           (rOperationID = aB.rOperationID);
//#UC END# *4A8D7588039F_4A8D70780075_impl*
end;//TvcmCommandInfo.EQ

{$IfEnd} //not NoVCM

end.