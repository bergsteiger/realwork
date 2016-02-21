unit deDocumentList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deDocumentList.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deList
 , PrimListInterfaces
 , bsTypes
 , DynamicDocListUnit
 , l3TreeInterfaces
 , PrimPrimListInterfaces
;

type
 TdeDocumentList = class(TdeList, IdeDocumentList)
  private
   f_OpenFrom: TbsListOpenFrom;
  protected
   procedure AssignClonned(aClone: TdeDocumentList); virtual;
   function CloneWithReplace(const aNewList: IDynList;
    const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   function pm_GetOpenFrom: TbsListOpenFrom;
   function pm_GetIsChanged: Boolean;
  public
   constructor CreateClonned(const aList: IDynList;
    aOpenFrom: TbsListOpenFrom;
    aTimeMachineOff: Boolean;
    aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
    const aNodeForPositioning: Il3SimpleNode;
    const aSearchInfo: IdeSearchInfo); reintroduce;
   constructor Create(const aList: IDynList;
    aOpenFrom: TbsListOpenFrom;
    aTimeMachineOff: Boolean;
    aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
    const aNodeForPositioning: Il3SimpleNode;
    const aSearchInfo: IdeSearchInfo;
    aAllDocumentsFiltered: Boolean;
    aNeedApplyPermanentFilters: Boolean;
    aIsChanged: Boolean); reintroduce;
   class function Make(const aList: IDynList;
    aOpenFrom: TbsListOpenFrom = lofNone;
    aTimeMachineOff: Boolean = True;
    aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
    const aNodeForPositioning: Il3SimpleNode = nil;
    const aSearchInfo: IdeSearchInfo = nil;
    aAllDocumentsFiltered: Boolean = False;
    aNeedApplyPermanentFilters: Boolean = True;
    aIsChanged: Boolean = False): IdeDocumentList; reintroduce;
 end;//TdeDocumentList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
;

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
 aNeedApplyPermanentFilters: Boolean;
 aIsChanged: Boolean);
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
 aNeedApplyPermanentFilters: Boolean = True;
 aIsChanged: Boolean = False): IdeDocumentList;
var
 l_Inst : TdeDocumentList;
begin
 l_Inst := Create(aList, aOpenFrom, aTimeMachineOff, aWhatDoingIfOneDoc, aNodeForPositioning, aSearchInfo, aAllDocumentsFiltered, aNeedApplyPermanentFilters, aIsChanged);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeDocumentList.Make

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

function TdeDocumentList.pm_GetIsChanged: Boolean;
//#UC START# *56A5C84E02B0_492FF76202CAget_var*
//#UC END# *56A5C84E02B0_492FF76202CAget_var*
begin
//#UC START# *56A5C84E02B0_492FF76202CAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *56A5C84E02B0_492FF76202CAget_impl*
end;//TdeDocumentList.pm_GetIsChanged
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
