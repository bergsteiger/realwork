unit deListSet;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\deListSet.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , deDocumentList
 , WorkWithListInterfaces
 , DynamicDocListUnit
 , bsTypes
 , l3TreeInterfaces
 , PrimPrimListInterfaces
;

type
 TdeListSet = class(TdeDocumentList, IdeDocumentListSet)
  private
   f_List_SynchroView_Form: TList_SynchroView_Areas;
    {* Поле для свойства List_SynchroView_Form }
  protected
   function pm_GetList_SynchroView_Form: TList_SynchroView_Areas;
   procedure AssignClonned(aClone: TdeDocumentList); override;
  public
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

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
                  aNeedApplyPermanentFilters);
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
end;//TdeListSet.Make

function TdeListSet.pm_GetList_SynchroView_Form: TList_SynchroView_Areas;
//#UC START# *715D27A37B98_4926AE3900B9get_var*
//#UC END# *715D27A37B98_4926AE3900B9get_var*
begin
//#UC START# *715D27A37B98_4926AE3900B9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *715D27A37B98_4926AE3900B9get_impl*
end;//TdeListSet.pm_GetList_SynchroView_Form

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
