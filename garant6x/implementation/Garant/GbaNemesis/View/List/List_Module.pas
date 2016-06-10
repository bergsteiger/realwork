unit List_Module;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/List_Module.pas"
// Начат: 31.08.2009 20:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormsPack::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::List$FP
//
// Работа со списком документов
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
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListAnalizer_Form,
  PrimListAnalizer_Form,
  bsOpenListInfo,
  DocumentUserTypes_dftDocSynchroView_UserType,
  DocumentUserTypes_dftRelatedSynchroView_UserType,
  DocumentUserTypes_dftAnnotationSynchroView_UserType,
  PrimPrimListInterfaces,
  DocumentInterfaces,
  l3StringIDEx,
  ListUserTypes_lftNone_UserType,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
  ListUserTypes_lftCorrespondentsSynchroForm_UserType,
  ListUserTypes_lftRespondentsSynchroForm_UserType,
  ListUserTypes_lftUserCRList1_SynchorForm_UserType,
  ListUserTypes_lftUserCRList2_SynchorForm_UserType,
  ListInfoUserTypes_liListInfo_UserType,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  SynchroViewUserTypes_svSynchroView_UserType,
  DocumentWithFlashUserTypes_dwftSynchro_UserType,
  FiltersUserTypes_utFilters_UserType,
  Common_FormDefinitions_Controls,
  PrimListOptions_Form,
  PrimListInfoOptions_Form,
  WorkWithListInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  PrimListAnalize_Form,
  ListAnalizeUserTypes_Analize_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  List_Form,
  ListInfo_Form,
  fsList,
  ListAnalize_Form,
  vcmExternalInterfaces {a},
  vcmModule {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TListModule = {formspack} class(TvcmModule)
  {* Работа со списком документов }
 protected
  class procedure GetEntityForms(aList : TvcmClassList); override;
 protected
 // protected methods
   class function TryOpenDocument(const aList: IdeList;
     const aContainer: IvcmContainer): Boolean;
 public
 // public methods
   class procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   class procedure OpenList(const aList: IdeList;
     const aContainer: IvcmContainer);
     {* Открывает список в указанном контейнере }
   class procedure OpenListWithReplace(const aList: IdeList;
     const aContainer: IvcmContainer);
     {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
 end;//TListModule
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PresentationInterfaces,
  resWarnImages,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  Search_Strange_Controls,
  WorkWithList_ListOperations_Controls,
  l3Base {a},
  DocumentUnit,
  l3MessageID,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  sdsList,
  ListInterfaces,
  DynamicDocListUnit,
  PrimListInterfaces,
  DocumentUserTypes_dftDrugSynchroView_UserType,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmMessagesSupport
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  nsListEvents,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TListModule

class function TListModule.TryOpenDocument(const aList: IdeList;
  const aContainer: IvcmContainer): Boolean;
//#UC START# *4AA4D7EA0094_4A9BF42601A9_var*
//#UC END# *4AA4D7EA0094_4A9BF42601A9_var*
var
 l_Info : TbsOpenListInfo;
 l_DocInfo : IdeDocInfo;
begin
//#UC START# *4AA4D7EA0094_4A9BF42601A9_impl*
 l_Info := TbsOpenListInfo.Create(aList);
 try
  case l_Info.LinkType of
   ltDocument:
   begin
    if (l_Info.Data = nil) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=296626118
    // - видимо список пустой и открывать ничего не получится
     Result := false
    else
    begin
     Result := True;
     l_DocInfo := l_Info.Data As IdeDocInfo;
     TnsOpenDocumentFromListEvent.Log(l_DocInfo);
     TdmStdRes.OpenDocument(l_DocInfo, aContainer);
     l_DocInfo := nil;
    end;//l_Info.Data = nil
   end;//ltDocument
   ltList:
    Result := False;
   else
   begin
    Assert(False);
    Result := False;
   end;//else
  end;//case l_Info.LinkType of
 finally
  FreeAndNil(l_Info);
 end;//try..finally
//#UC END# *4AA4D7EA0094_4A9BF42601A9_impl*
end;//TListModule.TryOpenDocument

class procedure TListModule.MakeListAnalizer(const aTree: Il3SimpleTree);
var
 __WasEnter : Boolean;
//#UC START# *4AA4DB140235_4A9BF42601A9_var*
//#UC END# *4AA4DB140235_4A9BF42601A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4DB140235_4A9BF42601A9_impl*
 if (aTree = nil) then
  vcmSay(str_MissingAnalisisTree, [DefDataAdapter.GetDealerInfo], mtInformation)
 else
  TListAnalizerForm.Make(aTree, vcmMakeParams(nil, DefaultContainer), vcm_ztModal);
//#UC END# *4AA4DB140235_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.MakeListAnalizer

class procedure TListModule.OpenList(const aList: IdeList;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4DB5100EF_4A9BF42601A9_var*
//#UC END# *4AA4DB5100EF_4A9BF42601A9_var*
var
 l_Form : IvcmEntityForm;
 l_Cont : IvcmContainer;
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4DB5100EF_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  case aList.List.GetContentType of
   DLC_LEGAL_DOCUMENTS:
    Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                  CheckContainer(aContainer));
   DLC_MEDICAL_DOCUMENTS:
   begin
    l_Cont := CheckContainer(aContainer);
    TdmStdRes.OpenDrugList(aList, l_Cont);
    // Синхронный просмотр открыт по умолчанию (CQ: OIT5-29213):
    // http://mdp.garant.ru/pages/viewpage.action?pageId=96484558
    if l_Cont.HasForm(fm_TextForm.rFormID,
                      vcm_ztAny,
                      True,
                      @l_Form,
                      dftDrugSynchroView) then
     l_Form.SetActiveInParent;
   end;
  end;//case aList.List.GetContentType of
//#UC END# *4AA4DB5100EF_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.OpenList

class procedure TListModule.OpenListWithReplace(const aList: IdeList;
  const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AA4EF7803A4_4A9BF42601A9_var*
//#UC END# *4AA4EF7803A4_4A9BF42601A9_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AA4EF7803A4_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                aContainer,
                false);
//#UC END# *4AA4EF7803A4_4A9BF42601A9_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TListModule.OpenListWithReplace

class procedure TListModule.GetEntityForms(aList : TvcmClassList);
begin
 inherited;
 aList.Add(TefList);
 aList.Add(TefListInfo);
 aList.Add(TListAnalizerForm);
 aList.Add(TListAnalizeForm);
end;

{$IfEnd} //not Admin AND not Monitorings

end.