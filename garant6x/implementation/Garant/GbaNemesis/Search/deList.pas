unit deList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/deList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::Search::Search::TdeList
//
// Данные списка.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  DynamicDocListUnit,
  l3TreeInterfaces,
  bsTypes,
  l3ProtoObject,
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TdeList = class(Tl3ProtoObject, IdeList)
  {* Данные списка. }
 private
 // private fields
   f_List : IDynList;
   f_NodeForPositioning : Il3SimpleNode;
   f_AllDocumentsFiltered : Boolean;
   f_NeedApplyPermanentFilters : Boolean;
   f_IsChanged : Boolean;
   f_TimeMachineOff : Boolean;
    {* Поле для свойства TimeMachineOff}
   f_WhatDoingIfOneDoc : TbsWhatDoingIfOneDoc;
    {* Поле для свойства WhatDoingIfOneDoc}
   f_SearchInfo : IdeSearchInfo;
    {* Поле для свойства SearchInfo}
 protected
 // realized methods
   function pm_GetList: IDynList;
   function pm_GetTimeMachineOff: Boolean;
   function pm_GetWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
   function pm_GetNodeForPositioning: Il3SimpleNode;
   function pm_GetSearchInfo: IdeSearchInfo;
   function pm_GetAllDocumentsFiltered: Boolean;
   function pm_GetNeedApplyPermanentFilters: Boolean;
   function pm_GetIsChanged: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IDynList;
     aTimeMachineOff: Boolean;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
     const aNodeForPositioning: Il3SimpleNode;
     const aSearchInfo: IdeSearchInfo;
     aAllDocumentsFiltered: Boolean;
     aNeedApplyPermanentFilters: Boolean;
     aIsChanged: Boolean); reintroduce;
   class function Make(const aList: IDynList;
     aTimeMachineOff: Boolean = true;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
     const aNodeForPositioning: Il3SimpleNode = nil;
     const aSearchInfo: IdeSearchInfo = nil;
     aAllDocumentsFiltered: Boolean = False;
     aNeedApplyPermanentFilters: Boolean = True;
     aIsChanged: Boolean = False): IdeList; reintroduce;
 protected
 // protected properties
   property TimeMachineOff: Boolean
     read f_TimeMachineOff;
   property WhatDoingIfOneDoc: TbsWhatDoingIfOneDoc
     read f_WhatDoingIfOneDoc;
   property SearchInfo: IdeSearchInfo
     read f_SearchInfo;
 end;//TdeList
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}

// start class TdeList

constructor TdeList.Create(const aList: IDynList;
  aTimeMachineOff: Boolean;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
  const aNodeForPositioning: Il3SimpleNode;
  const aSearchInfo: IdeSearchInfo;
  aAllDocumentsFiltered: Boolean;
  aNeedApplyPermanentFilters: Boolean;
  aIsChanged: Boolean);
//#UC START# *4B1F76940201_47F33E9E03C8_var*
//#UC END# *4B1F76940201_47F33E9E03C8_var*
begin
//#UC START# *4B1F76940201_47F33E9E03C8_impl*
 inherited Create;
 f_List := aList;
 f_TimeMachineOff := aTimeMachineOff;
 f_WhatDoingIfOneDoc := aWhatDoingIfOneDoc;
 f_NodeForPositioning := aNodeForPositioning;
 f_SearchInfo := aSearchInfo;
 f_AllDocumentsFiltered := aAllDocumentsFiltered;
 f_NeedApplyPermanentFilters := aNeedApplyPermanentFilters;
 f_IsChanged := aIsChanged;
//#UC END# *4B1F76940201_47F33E9E03C8_impl*
end;//TdeList.Create

class function TdeList.Make(const aList: IDynList;
  aTimeMachineOff: Boolean = true;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
  const aNodeForPositioning: Il3SimpleNode = nil;
  const aSearchInfo: IdeSearchInfo = nil;
  aAllDocumentsFiltered: Boolean = False;
  aNeedApplyPermanentFilters: Boolean = True;
  aIsChanged: Boolean = False): IdeList;
var
 l_Inst : TdeList;
begin
 l_Inst := Create(aList, aTimeMachineOff, aWhatDoingIfOneDoc, aNodeForPositioning, aSearchInfo, aAllDocumentsFiltered, aNeedApplyPermanentFilters, aIsChanged);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeList.pm_GetList: IDynList;
//#UC START# *4B1D0FB101BA_47F33E9E03C8get_var*
//#UC END# *4B1D0FB101BA_47F33E9E03C8get_var*
begin
//#UC START# *4B1D0FB101BA_47F33E9E03C8get_impl*
 Result := f_List;
//#UC END# *4B1D0FB101BA_47F33E9E03C8get_impl*
end;//TdeList.pm_GetList

function TdeList.pm_GetTimeMachineOff: Boolean;
//#UC START# *4B1D0FCD01D2_47F33E9E03C8get_var*
//#UC END# *4B1D0FCD01D2_47F33E9E03C8get_var*
begin
//#UC START# *4B1D0FCD01D2_47F33E9E03C8get_impl*
 Result := f_TimeMachineOff;
//#UC END# *4B1D0FCD01D2_47F33E9E03C8get_impl*
end;//TdeList.pm_GetTimeMachineOff

function TdeList.pm_GetWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
//#UC START# *4B1D100202D0_47F33E9E03C8get_var*
//#UC END# *4B1D100202D0_47F33E9E03C8get_var*
begin
//#UC START# *4B1D100202D0_47F33E9E03C8get_impl*
 Result := f_WhatDoingIfOneDoc;
//#UC END# *4B1D100202D0_47F33E9E03C8get_impl*
end;//TdeList.pm_GetWhatDoingIfOneDoc

function TdeList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *4B1D102C004A_47F33E9E03C8get_var*
//#UC END# *4B1D102C004A_47F33E9E03C8get_var*
begin
//#UC START# *4B1D102C004A_47F33E9E03C8get_impl*
 Result := f_NodeForPositioning;
//#UC END# *4B1D102C004A_47F33E9E03C8get_impl*
end;//TdeList.pm_GetNodeForPositioning

function TdeList.pm_GetSearchInfo: IdeSearchInfo;
//#UC START# *4B1D104E02FA_47F33E9E03C8get_var*
//#UC END# *4B1D104E02FA_47F33E9E03C8get_var*
begin
//#UC START# *4B1D104E02FA_47F33E9E03C8get_impl*
 Result := f_SearchInfo;
//#UC END# *4B1D104E02FA_47F33E9E03C8get_impl*
end;//TdeList.pm_GetSearchInfo

function TdeList.pm_GetAllDocumentsFiltered: Boolean;
//#UC START# *560BC82C0143_47F33E9E03C8get_var*
//#UC END# *560BC82C0143_47F33E9E03C8get_var*
begin
//#UC START# *560BC82C0143_47F33E9E03C8get_impl*
 Result := f_AllDocumentsFiltered;
//#UC END# *560BC82C0143_47F33E9E03C8get_impl*
end;//TdeList.pm_GetAllDocumentsFiltered

function TdeList.pm_GetNeedApplyPermanentFilters: Boolean;
//#UC START# *562485D00025_47F33E9E03C8get_var*
//#UC END# *562485D00025_47F33E9E03C8get_var*
begin
//#UC START# *562485D00025_47F33E9E03C8get_impl*
 Result := f_NeedApplyPermanentFilters; 
//#UC END# *562485D00025_47F33E9E03C8get_impl*
end;//TdeList.pm_GetNeedApplyPermanentFilters

function TdeList.pm_GetIsChanged: Boolean;
//#UC START# *569DDAE500DD_47F33E9E03C8get_var*
//#UC END# *569DDAE500DD_47F33E9E03C8get_var*
begin
//#UC START# *569DDAE500DD_47F33E9E03C8get_impl*
 Result := f_IsChanged;
//#UC END# *569DDAE500DD_47F33E9E03C8get_impl*
end;//TdeList.pm_GetIsChanged

procedure TdeList.Cleanup;
//#UC START# *479731C50290_47F33E9E03C8_var*
//#UC END# *479731C50290_47F33E9E03C8_var*
begin
//#UC START# *479731C50290_47F33E9E03C8_impl*
 f_SearchInfo := nil;
 inherited;
//#UC END# *479731C50290_47F33E9E03C8_impl*
end;//TdeList.Cleanup

procedure TdeList.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_List := nil;
 {$IfEnd} //not Admin
 {$If not defined(Admin)}
 f_NodeForPositioning := nil;
 {$IfEnd} //not Admin
 {$If not defined(Admin)}
 f_SearchInfo := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TdeList.ClearFields

{$IfEnd} //not Admin

end.