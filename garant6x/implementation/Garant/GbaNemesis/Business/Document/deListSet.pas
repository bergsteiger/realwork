unit deListSet;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/deListSet.pas"
// Начат: 09.12.2009 14:04
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TdeListSet
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
  deDocumentList,
  PrimPrimListInterfaces,
  WorkWithListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdeListSet = class(TdeDocumentList, IdeDocumentListSet)
 private
 // private fields
   f_List_SynchroView_Form : TList_SynchroView_Areas;
    {* Поле для свойства List_SynchroView_Form}
 protected
 // realized methods
   function pm_GetListSynchroViewForm: TList_SynchroView_Areas;
 protected
 // overridden protected methods
   procedure AssignClonned(aClone: TdeDocumentList); override;
 public
 // public methods
   constructor Create(const aList: IDynList;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
     aOpenFrom: TbsListOpenFrom;
     aTimeMachineOff: Boolean;
     const aNodeForPositioning: Il3SimpleNode;
     const aSearchInfo: IdeSearchInfo;
     aAllDocumentsFiltered: Boolean;
     aNeedApplyPermanentFilters: Boolean;
     aIsChanged: Boolean); reintroduce;
   class function Make(const aList: IDynList;
     aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
     aOpenFrom: TbsListOpenFrom = lofNone;
     aTimeMachineOff: Boolean = True;
     const aNodeForPositioning: Il3SimpleNode = nil;
     const aSearchInfo: IdeSearchInfo = nil;
     aAllDocumentsFiltered: Boolean = False;
     aNeedApplyPermanentFilters: Boolean = True;
     aIsChanged: Boolean = False): IdeDocumentListSet; reintroduce;
 end;//TdeListSet
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdeListSet

constructor TdeListSet.Create(const aList: IDynList;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc;
  aOpenFrom: TbsListOpenFrom;
  aTimeMachineOff: Boolean;
  const aNodeForPositioning: Il3SimpleNode;
  const aSearchInfo: IdeSearchInfo;
  aAllDocumentsFiltered: Boolean;
  aNeedApplyPermanentFilters: Boolean;
  aIsChanged: Boolean);
//#UC START# *4B1F7C63023F_4926AE3900B9_var*
//#UC END# *4B1F7C63023F_4926AE3900B9_var*
begin
//#UC START# *4B1F7C63023F_4926AE3900B9_impl*
 inherited Create(aList,
                  aOpenFrom,
                  aTimeMachineOff,
                  aWhatDoingIfOneDoc,
                  aNodeForPositioning,
                  aSearchInfo,
                  aAllDocumentsFiltered,
                  aNeedApplyPermanentFilters,
                  aIsChanged);
 f_List_SynchroView_Form := sva_List_SynchroView_Document;
//#UC END# *4B1F7C63023F_4926AE3900B9_impl*
end;//TdeListSet.Create

class function TdeListSet.Make(const aList: IDynList;
  aWhatDoingIfOneDoc: TbsWhatDoingIfOneDoc = wdAlwaysOpen;
  aOpenFrom: TbsListOpenFrom = lofNone;
  aTimeMachineOff: Boolean = True;
  const aNodeForPositioning: Il3SimpleNode = nil;
  const aSearchInfo: IdeSearchInfo = nil;
  aAllDocumentsFiltered: Boolean = False;
  aNeedApplyPermanentFilters: Boolean = True;
  aIsChanged: Boolean = False): IdeDocumentListSet;
var
 l_Inst : TdeListSet;
begin
 l_Inst := Create(aList, aWhatDoingIfOneDoc, aOpenFrom, aTimeMachineOff, aNodeForPositioning, aSearchInfo, aAllDocumentsFiltered, aNeedApplyPermanentFilters, aIsChanged);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeListSet.pm_GetListSynchroViewForm: TList_SynchroView_Areas;
 {-}
begin
 Result := f_List_SynchroView_Form;
end;//TdeListSet.pm_GetListSynchroViewForm

procedure TdeListSet.AssignClonned(aClone: TdeDocumentList);
//#UC START# *4B1F7AE80158_4926AE3900B9_var*
//#UC END# *4B1F7AE80158_4926AE3900B9_var*
begin
//#UC START# *4B1F7AE80158_4926AE3900B9_impl*
 inherited;
 if aClone is TdeListSet then
 begin
  f_List_SynchroView_Form := TdeListSet(aClone).f_List_SynchroView_Form;
 end;//aClone is TdeListSet
//#UC END# *4B1F7AE80158_4926AE3900B9_impl*
end;//TdeListSet.AssignClonned

{$IfEnd} //not Admin AND not Monitorings

end.