unit PrimFolders_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\PrimFolders_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimFolders" MUID: (4A96B68A03B1)
// Имя типа: "TPrimFoldersModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTreeSupportUnit
 , FoldersUnit
 , eeInterfaces
 , nsFormCoordinates
 , FoldersDomainInterfaces
 , l3Interfaces
 , nsTypes
 , BaseTypesUnit
 , nsLogEvent
;

type
 TnsOpenConsultationEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenConsultationEvent

 TPrimFoldersModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_InfoTypeList: IvcmItems;
  private
   function OpenFoldersForSelect(const aContainer: IvcmContainer;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aUserData: IUnknown;
    anOpenType: TFoldersInfoType;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Integer;
  protected
   procedure OpenFoldersPrim(const aContainer: IvcmContainer);
   function FindFoldersForm(const aContainer: IvcmContainer): IvcmEntityForm;
   function Open(const aContainer: IvcmContainer;
    aCanCreate: Boolean): IvcmEntityForm;
   procedure MyInformation;
    {* Моя информация }
   procedure MyConsultations;
    {* Мои консультации }
   procedure UnderControlOpenFrmAct;
    {* Документы на контроле }
   procedure OpenFrmAct;
    {* Мои документы }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure OpenFolders(const aContainer: IvcmContainer;
    aCanCreate: Boolean);
   procedure CloseFolders(const aContainer: IvcmContainer);
   procedure TryOpenConsultationAnswer(const aContainer: IvcmContainer);
   procedure RefreshStructure(const aNode: INode;
    aStatus: TNotifyStatus);
   function EditInfoOpen(aIsNewFolder: Boolean;
    const aNode: IeeNode;
    const aCoords: InsFormCoordinates): Integer;
   procedure LoadOpen(const aForm: IvcmEntityForm;
    const aData: InsFolderFilterInfo);
   procedure SelectOpen(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID);
   procedure SelectOpenWithOperation(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID;
    anOp: TListLogicOperation);
   procedure SelectOpenWithUserData(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID;
    const aUserData: IUnknown);
   function SaveOpen(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Integer;
 end;//TPrimFoldersModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Search_Strange_Controls
 , PrimFoldersTree_utSaveOpen_UserType
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , kw_Folders_opMyInformation
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kw_Folders_opMyConsultations
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kw_Folders_opUnderControlOpenFrmAct
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kw_Folders_opOpenFrmAct
 {$IfEnd} // NOT Defined(NoScripts)
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , nsFolders
 , vtCtrls
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Folders_Strange_Controls
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , LoggingUnit
 , Folders_Form
 , fsFolders
 , FoldersInfo_Form
 , FoldersTree_Form
 , FoldersElementInfo_Form
 {$If NOT Defined(NoScripts)}
 , FoldersKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FoldersInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FoldersTreeKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , FoldersElementInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
class procedure TnsOpenConsultationEvent.Log;
//#UC START# *4B14D5A203B1_4B14D5890031_var*
//#UC END# *4B14D5A203B1_4B14D5890031_var*
begin
//#UC START# *4B14D5A203B1_4B14D5890031_impl*
 GetLogger.AddEvent(LE_OPEN_CONSULTATION, MakeParamsList);
//#UC END# *4B14D5A203B1_4B14D5890031_impl*
end;//TnsOpenConsultationEvent.Log

procedure TPrimFoldersModule.OpenFoldersPrim(const aContainer: IvcmContainer);
//#UC START# *4AA532E202C1_4A96B68A03B1_var*
//#UC END# *4AA532E202C1_4A96B68A03B1_var*
begin
//#UC START# *4AA532E202C1_4A96B68A03B1_impl*
 Tfs_Folders.Make(TsdsFolders.Make, aContainer);
//#UC END# *4AA532E202C1_4A96B68A03B1_impl*
end;//TPrimFoldersModule.OpenFoldersPrim

function TPrimFoldersModule.FindFoldersForm(const aContainer: IvcmContainer): IvcmEntityForm;
//#UC START# *4AA534760215_4A96B68A03B1_var*
//#UC END# *4AA534760215_4A96B68A03B1_var*
begin
//#UC START# *4AA534760215_4A96B68A03B1_impl*
 Result := nil;
 if (aContainer <> nil) then
    aContainer.HasForm(fm_cfFolders.rFormID, vcm_ztNavigator, true, @Result);
//#UC END# *4AA534760215_4A96B68A03B1_impl*
end;//TPrimFoldersModule.FindFoldersForm

function TPrimFoldersModule.Open(const aContainer: IvcmContainer;
 aCanCreate: Boolean): IvcmEntityForm;
//#UC START# *4ABCDB5D034C_4A96B68A03B1_var*
//#UC END# *4ABCDB5D034C_4A96B68A03B1_var*
begin
//#UC START# *4ABCDB5D034C_4A96B68A03B1_impl*
 Result := FindFoldersForm(CheckContainer(aContainer));
 if not Assigned(Result) and aCanCreate then
 begin
  OpenFoldersPrim(CheckContainer(aContainer));
  Result := FindFoldersForm(CheckContainer(aContainer));
 end;//if not Assigned(Result) then
 if Assigned(Result) and aCanCreate then
  Result.SetActiveAndShowInParent;
//#UC END# *4ABCDB5D034C_4A96B68A03B1_impl*
end;//TPrimFoldersModule.Open

procedure TPrimFoldersModule.OpenFolders(const aContainer: IvcmContainer;
 aCanCreate: Boolean);
//#UC START# *4ABCDBC0002F_4A96B68A03B1_var*
//#UC END# *4ABCDBC0002F_4A96B68A03B1_var*
begin
//#UC START# *4ABCDBC0002F_4A96B68A03B1_impl*
 if not defDataAdapter.AdministratorLogin then
  Result := Open(aContainer, aCanCreate)
 else
  Result := nil; 
//#UC END# *4ABCDBC0002F_4A96B68A03B1_impl*
end;//TPrimFoldersModule.OpenFolders

procedure TPrimFoldersModule.CloseFolders(const aContainer: IvcmContainer);
//#UC START# *4ABCE27102AD_4A96B68A03B1_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *4ABCE27102AD_4A96B68A03B1_var*
begin
//#UC START# *4ABCE27102AD_4A96B68A03B1_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_cfFolders.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4ABCE27102AD_4A96B68A03B1_impl*
end;//TPrimFoldersModule.CloseFolders

procedure TPrimFoldersModule.TryOpenConsultationAnswer(const aContainer: IvcmContainer);
//#UC START# *4ABCE3C2032A_4A96B68A03B1_var*
var
 l_Container: IvcmEntityForm;
//#UC END# *4ABCE3C2032A_4A96B68A03B1_var*
begin
//#UC START# *4ABCE3C2032A_4A96B68A03B1_impl*
 if not defDataAdapter.AdministratorLogin then
 begin
  l_Container := Open(CheckContainer(aContainer), true);
  op_Folders_TryOpenConsultationAnswer.Call(l_Container.Aggregate);
 end;//not defDataAdapter.AdministratorLogin
//#UC END# *4ABCE3C2032A_4A96B68A03B1_impl*
end;//TPrimFoldersModule.TryOpenConsultationAnswer

procedure TPrimFoldersModule.MyInformation;
 {* Моя информация }
//#UC START# *4ABCE463038F_4A96B68A03B1_var*
//#UC END# *4ABCE463038F_4A96B68A03B1_var*
begin
//#UC START# *4ABCE463038F_4A96B68A03B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABCE463038F_4A96B68A03B1_impl*
end;//TPrimFoldersModule.MyInformation

procedure TPrimFoldersModule.MyConsultations;
 {* Мои консультации }
//#UC START# *4ABCE5070362_4A96B68A03B1_var*
//#UC END# *4ABCE5070362_4A96B68A03B1_var*
begin
//#UC START# *4ABCE5070362_4A96B68A03B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABCE5070362_4A96B68A03B1_impl*
end;//TPrimFoldersModule.MyConsultations

procedure TPrimFoldersModule.UnderControlOpenFrmAct;
 {* Документы на контроле }
//#UC START# *4AC093B801EE_4A96B68A03B1_var*
//#UC END# *4AC093B801EE_4A96B68A03B1_var*
begin
//#UC START# *4AC093B801EE_4A96B68A03B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC093B801EE_4A96B68A03B1_impl*
end;//TPrimFoldersModule.UnderControlOpenFrmAct

procedure TPrimFoldersModule.RefreshStructure(const aNode: INode;
 aStatus: TNotifyStatus);
//#UC START# *4AC09777035C_4A96B68A03B1_var*
//#UC END# *4AC09777035C_4A96B68A03B1_var*
begin
//#UC START# *4AC09777035C_4A96B68A03B1_impl*
 if FoldersReaded then
 begin
  case aStatus of
   NS_NODE    : (UserFoldersTree.Tree as InsReloadedTree).ReloadChildren(aNode);
   NS_CONTENT : UserFoldersTree.Refresh(aNode);
  end;//case aStatus
 end;//FoldersReaded
//#UC END# *4AC09777035C_4A96B68A03B1_impl*
end;//TPrimFoldersModule.RefreshStructure

procedure TPrimFoldersModule.OpenFrmAct;
 {* Мои документы }
//#UC START# *4AC0A2D30078_4A96B68A03B1_var*
//#UC END# *4AC0A2D30078_4A96B68A03B1_var*
begin
//#UC START# *4AC0A2D30078_4A96B68A03B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC0A2D30078_4A96B68A03B1_impl*
end;//TPrimFoldersModule.OpenFrmAct

function TPrimFoldersModule.EditInfoOpen(aIsNewFolder: Boolean;
 const aNode: IeeNode;
 const aCoords: InsFormCoordinates): Integer;
var l_Form: IvcmEntityForm;
var l_Container: IvcmEntityForm;
//#UC START# *4AC0AB11030C_4A96B68A03B1_var*
//#UC END# *4AC0AB11030C_4A96B68A03B1_var*
begin
//#UC START# *4AC0AB11030C_4A96B68A03B1_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  l_Container := TcfFoldersInfo.Make(vcmCheckAggregate(vcmMakeParams(nil, nil, Application)));
//  TenFoldersElementInfo.Make(vcmParams(l_Container.Aggregate, l_Container.AsContainer));
  l_Form := TenFoldersElementInfo.Make(vcmMakeParams(l_Container.Aggregate, l_Container.AsContainer));

  if aIsNewFolder then
   Op_FolderElement_SetState.Call(l_Container.Aggregate, fiNewFolder)
  else
   Op_FolderElement_SetState.Call(l_Container.Aggregate, fiEdit);
  Op_FolderElement_SetContent.Call(l_Form, aNode, aIsNewFolder);
  AdjustCtrl(l_Container.VCLWinControl, aCoords.Rect);
 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally
 Result := l_Container.ShowModal;
//#UC END# *4AC0AB11030C_4A96B68A03B1_impl*
end;//TPrimFoldersModule.EditInfoOpen

procedure TPrimFoldersModule.LoadOpen(const aForm: IvcmEntityForm;
 const aData: InsFolderFilterInfo);
//#UC START# *4AC0B7BA003B_4A96B68A03B1_var*
//#UC END# *4AC0B7BA003B_4A96B68A03B1_var*
begin
//#UC START# *4AC0B7BA003B_4A96B68A03B1_impl*
 OpenFoldersForSelect(CheckContainer(nil),
                      aForm,
                      aData,
                      nil,
                      nil,
                      fiLoad);
//#UC END# *4AC0B7BA003B_4A96B68A03B1_impl*
end;//TPrimFoldersModule.LoadOpen

function TPrimFoldersModule.OpenFoldersForSelect(const aContainer: IvcmContainer;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aUserData: IUnknown;
 anOpenType: TFoldersInfoType;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Integer;
var l_Params: IvcmMakeParams;
var l_Container: IvcmEntityForm;
var l_Folders: ;
//#UC START# *4AC0B80702DE_4A96B68A03B1_var*
//#UC END# *4AC0B80702DE_4A96B68A03B1_var*
begin
//#UC START# *4AC0B80702DE_4A96B68A03B1_impl*
 if not defDataAdapter.AdministratorLogin then
 begin
  vcmDispatcher.FormDispatcher.Lock;
  try
   l_Params := vcmCheckAggregate(vcmMakeParams(nil, aContainer));
   l_Folders := TsdsFolders.Make;
   try
    l_Container := TcfFolders.Make(l_Params,
                                   vcm_ztManualModal,
                                   0,
                                   nil,
                                   l_Folders.dsFolders);
    TenFoldersTree.Make(vcmMakeParams(l_Params.Aggregate,
                                  l_Container.AsContainer,
                                  l_Params.Owner),
                        vcm_ztAny,
                        0,
                        nil,
                        l_Folders.dsFoldersTree);
    TenFoldersElementInfo.Make(vcmMakeParams(l_Params.Aggregate,
                                         l_Container.AsContainer,
                                         l_Params.Owner),
                               vcm_ztAny,
                               0,
                               nil,
                               l_Folders.dsFolderElement);
   finally
    l_Folders := nil;
   end;//try..finally
   op_FolderElement_DisableSecurityPage.Call(l_Params.Aggregate);
   Op_FolderElement_SetLoadInfo.Call(l_Params.Aggregate,
                                     aForm,
                                     aFilterInfo,
                                     aCaption,
                                     aUserData,
                                     anOp);
   Op_FolderElement_SetState.Call(l_Params.Aggregate, anOpenType);
   Op_AdditionInfo_Show.Call(l_Params.Aggregate);
  finally
   vcmDispatcher.FormDispatcher.UnLock;
  end;//try..finally
  Result := l_Container.ShowModal;
 end//not defDataAdapter.AdministratorLogin
 else
 begin
  vcmSay(war_SystemLogin);
  Result := mrCancel;
 end;//not defDataAdapter.AdministratorLogin
//#UC END# *4AC0B80702DE_4A96B68A03B1_impl*
end;//TPrimFoldersModule.OpenFoldersForSelect

procedure TPrimFoldersModule.SelectOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID);
//#UC START# *4AC0B94902C7_4A96B68A03B1_var*
//#UC END# *4AC0B94902C7_4A96B68A03B1_var*
begin
//#UC START# *4AC0B94902C7_4A96B68A03B1_impl*
 OpenFoldersForSelect(CheckContainer(nil),
                      aForm,
                      aFilterInfo,
                      vcmCStr(aCaption),
                      nsCStr('Чтобы гиперссылка не ставилась'),
                      fiSelect);
//#UC END# *4AC0B94902C7_4A96B68A03B1_impl*
end;//TPrimFoldersModule.SelectOpen

procedure TPrimFoldersModule.SelectOpenWithOperation(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 anOp: TListLogicOperation);
//#UC START# *4AC0BA2301AC_4A96B68A03B1_var*
//#UC END# *4AC0BA2301AC_4A96B68A03B1_var*
begin
//#UC START# *4AC0BA2301AC_4A96B68A03B1_impl*
 OpenFoldersForSelect(CheckContainer(nil),
                      aForm,
                      aFilterInfo,
                      vcmCStr(aCaption),
                      nsCStr('Чтобы гиперссылка не ставилась'),
                      fiSelect,
                      anOp);
//#UC END# *4AC0BA2301AC_4A96B68A03B1_impl*
end;//TPrimFoldersModule.SelectOpenWithOperation

procedure TPrimFoldersModule.SelectOpenWithUserData(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 const aUserData: IUnknown);
//#UC START# *4AC0BAEB012F_4A96B68A03B1_var*
//#UC END# *4AC0BAEB012F_4A96B68A03B1_var*
begin
//#UC START# *4AC0BAEB012F_4A96B68A03B1_impl*
 OpenFoldersForSelect(CheckContainer(nil),
                      aForm,
                      aFilterInfo,
                      vcmCStr(aCaption),
                      aUserData,
                      fiSelect);
//#UC END# *4AC0BAEB012F_4A96B68A03B1_impl*
end;//TPrimFoldersModule.SelectOpenWithUserData

function TPrimFoldersModule.SaveOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Integer;
var l_Folders: ;
var l_Container: IvcmEntityForm;
var l_Params: IvcmMakeParams;
var l_Form: IvcmEntityForm;
//#UC START# *4AC0CBE300FC_4A96B68A03B1_var*
//#UC END# *4AC0CBE300FC_4A96B68A03B1_var*
begin
//#UC START# *4AC0CBE300FC_4A96B68A03B1_impl*
 if not defDataAdapter.AdministratorLogin then
 begin
  vcmDispatcher.FormDispatcher.Lock;
  try
   l_Params := vcmCheckAggregate(vcmMakeParams(nil, CheckContainer(nil)));
   l_Folders := TsdsFolders.Make;
   aFilterInfo.ShowFolders := sfMyDocuments;
   Assert(l_Folders <> nil);
   l_Container := TcfFolders.Make(l_Params,
                                  vcm_ztManualModal,
                                  0,
                                  nil,
                                  l_Folders.dsFolders);
   l_Form := TenFoldersTree.Make(vcmMakeParams(l_Params.Aggregate,
                                           l_Container.AsContainer),
                                 vcm_ztAny,
                                 Ord(utSaveOpen),
                                 nil,
                                 l_Folders.dsFoldersTree);
   TenFoldersElementInfo.Make(vcmMakeParams(l_Params.Aggregate,
                                        l_Container.AsContainer),
                              vcm_ztAny,
                              0,
                              nil,
                              l_Folders.dsFolderElement);
  finally
   vcmDispatcher.FormDispatcher.UnLock;
  end;//try..finally
  op_Folders_SetInfoContent.Call(l_Form);
  op_FolderElement_DisableSecurityPage.Call(l_Container.Aggregate);
  Op_FolderElement_SetSaveInfo.Call(l_Container.Aggregate, aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
  Op_FolderElement_SetState.Call(l_Container.Aggregate, fiSave);
  Op_AdditionInfo_Show.Call(l_Container.Aggregate);
  Op_AdditionInfo_SetCaption.Call(l_Container.Aggregate,vcmCStr(str_SaveAsCaption));
  Result := l_Container.ShowModal;
  l_Container := nil;
 end//not defDataAdapter.AdministratorLogin
 else
 begin
  vcmSay(war_SystemLogin);
  Result := mrCancel; 
 end;//not defDataAdapter.AdministratorLogin
//#UC END# *4AC0CBE300FC_4A96B68A03B1_impl*
end;//TPrimFoldersModule.SaveOpen

procedure TPrimFoldersModule.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A96B68A03B1_var*
//#UC END# *479731C50290_4A96B68A03B1_var*
begin
//#UC START# *479731C50290_4A96B68A03B1_impl*
 f_InfoTypeList := nil;
 inherited;
//#UC END# *479731C50290_4A96B68A03B1_impl*
end;//TPrimFoldersModule.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
