unit deDocumentList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/deDocumentList.pas"
// Начат: 09.12.2009 14:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TdeDocumentList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  l3TreeInterfaces,
  bsTypes,
  deList,
  PrimListInterfaces,
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeDocumentList = class(TdeList, IdeDocumentList)
 private
 // private fields
   f_OpenFrom : TbsListOpenFrom;
 protected
 // realized methods
   function CloneWithReplace(const aNewList: IDynList;
    const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   function pm_GetOpenFrom: TbsListOpenFrom;
 protected
 // protected methods
   procedure AssignClonned(aClone: TdeDocumentList); virtual;
 public
 // public methods
   constructor CreateClonned(const aList: IDynList;
     aOpenFrom: TbsListOpenFrom;
     aTimeMachineOff: Boolean;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
     const aNodeForPositioning: Il3SimpleNode;
     const aSearchInfo: IdeSearchInfo);
   constructor Create(const aList: IDynList;
     aOpenFrom: TbsListOpenFrom;
     aTimeMachineOff: Boolean;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
     const aNodeForPositioning: Il3SimpleNode;
     const aSearchInfo: IdeSearchInfo;
     aAllDocumentsFiltered: Boolean;
     aNeedApplyPermanentFilters: Boolean); reintroduce;
   class function Make(const aList: IDynList;
     aOpenFrom: TbsListOpenFrom = lofNone;
     aTimeMachineOff: Boolean = True;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
     const aNodeForPositioning: Il3SimpleNode = nil;
     const aSearchInfo: IdeSearchInfo = nil;
     aAllDocumentsFiltered: Boolean = False;
     aNeedApplyPermanentFilters: Boolean = True): IdeDocumentList; reintroduce;
 end;//TdeDocumentList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeDocumentList

constructor TdeDocumentList.CreateClonned(const aList: IDynList;
  aOpenFrom: TbsListOpenFrom;
  aTimeMachineOff: Boolean;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
  const aNodeForPositioning: Il3SimpleNode;
  const aSearchInfo: IdeSearchInfo);
//#UC START# *4B1F7A850082_492FF76202CA_var*
//#UC END# *4B1F7A850082_492FF76202CA_var*
begin
//#UC START# *4B1F7A850082_492FF76202CA_impl*
 Create(aList, aOpenFrom, aTimeMachineOff,
   aWhatDoingIfOneDoc, aNodeForPositioning, aSearchInfo, pm_GetAllDocumentsFiltered, True);
//#UC END# *4B1F7A850082_492FF76202CA_impl*
end;//TdeDocumentList.CreateClonned

constructor TdeDocumentList.Create(const aList: IDynList;
  aOpenFrom: TbsListOpenFrom;
  aTimeMachineOff: Boolean;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
  const aNodeForPositioning: Il3SimpleNode;
  const aSearchInfo: IdeSearchInfo;
  aAllDocumentsFiltered: Boolean;
  aNeedApplyPermanentFilters: Boolean);
//#UC START# *4B1F7AFB00BF_492FF76202CA_var*
//#UC END# *4B1F7AFB00BF_492FF76202CA_var*
begin
//#UC START# *4B1F7AFB00BF_492FF76202CA_impl*
 inherited Create(aList,
                  aTimeMachineOff,
                  aWhatDoingIfOneDoc,
                  aNodeForPositioning,
                  aSearchInfo,
                  aAllDocumentsFiltered,
                  aNeedApplyPermanentFilters);
 f_OpenFrom := aOpenFrom;
//#UC END# *4B1F7AFB00BF_492FF76202CA_impl*
end;//TdeDocumentList.Create

class function TdeDocumentList.Make(const aList: IDynList;
  aOpenFrom: TbsListOpenFrom = lofNone;
  aTimeMachineOff: Boolean = True;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
  const aNodeForPositioning: Il3SimpleNode = nil;
  const aSearchInfo: IdeSearchInfo = nil;
  aAllDocumentsFiltered: Boolean = False;
  aNeedApplyPermanentFilters: Boolean = True): IdeDocumentList;
var
 l_Inst : TdeDocumentList;
begin
 l_Inst := Create(aList, aOpenFrom, aTimeMachineOff, aWhatDoingIfOneDoc, aNodeForPositioning, aSearchInfo, aAllDocumentsFiltered, aNeedApplyPermanentFilters);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TdeDocumentList.AssignClonned(aClone: TdeDocumentList);
//#UC START# *4B1F7AE80158_492FF76202CA_var*
//#UC END# *4B1F7AE80158_492FF76202CA_var*
begin
//#UC START# *4B1F7AE80158_492FF76202CA_impl*
 // - ничего не делаем
//#UC END# *4B1F7AE80158_492FF76202CA_impl*
end;//TdeDocumentList.AssignClonned

function TdeDocumentList.CloneWithReplace(const aNewList: IDynList;
  const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
//#UC START# *4B1D107F02EB_492FF76202CA_var*
var
 l_Class : TdeDocumentList;

type
 TSetClass = class of TdeDocumentList;
//#UC END# *4B1D107F02EB_492FF76202CA_var*
begin
//#UC START# *4B1D107F02EB_492FF76202CA_impl*
 l_Class := TSetClass(ClassType).CreateClonned(aNewList, f_OpenFrom,
   TimeMachineOff, WhatDoingIfOneDoc, aNodeForPositioning, SearchInfo);
 try
  l_Class.AssignClonned(Self);
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
//#UC END# *4B1D107F02EB_492FF76202CA_impl*
end;//TdeDocumentList.CloneWithReplace

function TdeDocumentList.pm_GetOpenFrom: TbsListOpenFrom;
//#UC START# *4B1D10CB029F_492FF76202CAget_var*
//#UC END# *4B1D10CB029F_492FF76202CAget_var*
begin
//#UC START# *4B1D10CB029F_492FF76202CAget_impl*
 Result := f_OpenFrom;
//#UC END# *4B1D10CB029F_492FF76202CAget_impl*
end;//TdeDocumentList.pm_GetOpenFrom

{$IfEnd} //not Admin AND not Monitorings

end.