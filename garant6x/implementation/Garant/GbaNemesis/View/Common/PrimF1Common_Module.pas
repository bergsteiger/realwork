unit PrimF1Common_Module;
 {* "Общий" только для F1 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\PrimF1Common_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimF1Common" MUID: (4A92C1380380)
// Имя типа: "TPrimF1CommonModule"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicTreeUnit
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimF1CommonModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* "Общий" только для F1 }
  protected
   class function GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
   class procedure SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
    aType: TNavigatorMenuItemType);
   procedure opComplectInfoTest(const aParams: IvcmTestParamsPrim);
    {* Информация о комплекте }
   procedure opComplectInfoExecute(const aParams: IvcmExecuteParamsPrim);
    {* Информация о комплекте }
   procedure opLetterToDevelopersExecute(const aParams: IvcmExecuteParamsPrim);
    {* Письмо разработчикам }
   procedure opOpenInformationTest(const aParams: IvcmTestParamsPrim);
    {* Справочная информация }
   procedure opOpenInformationExecute(const aParams: IvcmExecuteParamsPrim);
    {* Справочная информация }
   procedure opOpenIntranetTest(const aParams: IvcmTestParamsPrim);
   procedure opOpenIntranetExecute(const aParams: IvcmExecuteParamsPrim);
   procedure opOpenMainMenuByButtonExecute(const aParams: IvcmExecuteParamsPrim);
    {* Основное меню системы ГАРАНТ }
   procedure opOpenMainMenuNewTest(const aParams: IvcmTestParamsPrim);
    {* Основное меню }
   procedure opOpenMainMenuNewExecute(const aParams: IvcmExecuteParamsPrim);
    {* Основное меню }
   procedure opOpenRubricatorTest(const aParams: IvcmTestParamsPrim);
    {* Правовой навигатор }
   procedure opOpenRubricatorExecute(const aParams: IvcmExecuteParamsPrim);
    {* Правовой навигатор }
   procedure opPageSetupExecute(const aParams: IvcmExecuteParamsPrim);
    {* Настройка страницы... }
   procedure opShowEULAExecute(const aParams: IvcmExecuteParamsPrim);
    {* Условия использования }
   procedure opTasksPanelExecute(const aParams: IvcmExecuteParamsPrim);
    {* Панель задач }
   procedure opget_navigatorExecute(const aParams: IvcmExecuteParamsPrim);
    {* Меню (вкладка) }
   procedure Loaded; override;
   {$If NOT Defined(NoVCM)}
   class procedure GetEntityForms(aList: TvcmClassList); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimF1CommonModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModuleContractImplementation
 {$IfEnd} // NOT Defined(NoVCM)
 , Common_F1CommonServices_Contracts
 , AdapterFacade
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , UnderControlUnit
 , l3PrinterInterfaces
 , SearchInterfaces
 , l3Interfaces
 , PresentationInterfaces
 , Search_Strange_Controls
 , Common_Rubricator_Controls
 , PrimTasksPanel_tpMain_UserType
 , Common_FormDefinitions_Controls
 , NavigatorUtils
 , GblAdapter
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUtils
 , nsUtils
 , nsExternalObjectPrim
 , SysUtils
 , afwFacade
 , nsPageSetup
 , ConfigInterfaces
 , nsConst
 , l3Base
 , nsNewCachableNode
 , DataAdapter
 , nsTypes
 , nsNodes
 , RememberPassword_Form
 , ProgressIndicator_Form
 , EULA_Form
 , About_Form
 , CompInfo_Form
 , Registration_Form
 , TasksPanel_Form
 , Navigator_Form
 , TurnOffTimeMachine_Form
 //#UC START# *4A92C1380380impl_uses*
 , StdRes
 , StartUnit
 , Search_Services
 //#UC END# *4A92C1380380impl_uses*
;

{$If NOT Defined(NoVCM)}
type
 TCommonServiceImpl = {final} class(TvcmModuleContractImplementation, ICommonService)
  public
   procedure About;
    {* Выводит диалог "О программе" }
   procedure AddDocumentToControl(const aDocument: IDocument);
    {* Поставить документ на контроль }
   procedure AddToControl(const aControllable: IControllable);
    {* Поставить объект на контроль }
   procedure ApplicationActivate;
   procedure CloseNavigator(const aContainer: IvcmContainer);
   procedure CloseTasksPanel(const aContainer: IvcmContainer);
   procedure DeleteDocumentFromControl(const aDocument: IDocument);
    {* Снять документ с контроля }
   procedure DeleteFromControl(const aControllable: IControllable);
    {* Снять объект с контроля }
   procedure FromPrinterSettings(const aPrinter: Il3Printer);
    {* Считать настройки из принтера }
   function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   procedure GetNavigator(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
    {* Меню (вкладка) }
   function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   function IsUnderControl(const aDoc: IDocument): Boolean;
    {* Находится ли документ на контроле }
   procedure OpenNewDocs(const aContainer: IvcmContainer);
   procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   procedure OpenTasksPanel(const aContainer: IvcmContainer);
   procedure ToPrinterSettings(const aPrinter: Il3Printer);
    {* Записать настройки в принтер }
   function MakeProgressIndicator(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer): IvcmEntityForm;
   function OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
   class function Instance: TCommonServiceImpl;
    {* Метод получения экземпляра синглетона TCommonServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TCommonServiceImpl

var g_TCommonServiceImpl: TCommonServiceImpl = nil;
 {* Экземпляр синглетона TCommonServiceImpl }

procedure TCommonServiceImplFree;
 {* Метод освобождения экземпляра синглетона TCommonServiceImpl }
begin
 l3Free(g_TCommonServiceImpl);
end;//TCommonServiceImplFree

procedure TCommonServiceImpl.About;
 {* Выводит диалог "О программе" }
var
 __WasEnter : Boolean;
//#UC START# *4ABB6F5D0397_4A92C1380380_var*
//#UC END# *4ABB6F5D0397_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB6F5D0397_4A92C1380380_impl*
 TefAbout.Make(vcmMakeParams);
//#UC END# *4ABB6F5D0397_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.About

procedure TCommonServiceImpl.AddDocumentToControl(const aDocument: IDocument);
 {* Поставить документ на контроль }
var
 __WasEnter : Boolean;
//#UC START# *4AC1F3770062_4A92C1380380_var*
var
 l_Controllable : IControllable;
//#UC END# *4AC1F3770062_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F3770062_4A92C1380380_impl*
 Assert(IsCurEditionActual(aDocument),'Can''t flag unactual redation');
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  AddToControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3770062_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.AddDocumentToControl

procedure TCommonServiceImpl.AddToControl(const aControllable: IControllable);
 {* Поставить объект на контроль }
var
 __WasEnter : Boolean;
//#UC START# *4AC1F3A700BE_4A92C1380380_var*
//#UC END# *4AC1F3A700BE_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F3A700BE_4A92C1380380_impl*
 if Assigned(aControllable) and aControllable.GetCanSetToControl then
 begin
  aControllable.SetControlled(True);
  TControlledObjectService.Instance.AddControlledObject(aControllable);
 end;//Assigned(aControllable) and aControllable.GetCanSetToControl
//#UC END# *4AC1F3A700BE_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.AddToControl

procedure TCommonServiceImpl.ApplicationActivate;
var
 __WasEnter : Boolean;
//#UC START# *4ABB74D80287_4A92C1380380_var*
//#UC END# *4ABB74D80287_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB74D80287_4A92C1380380_impl*
 op_PrintParams_UpdatePrinter.Broadcast;
//#UC END# *4ABB74D80287_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.ApplicationActivate

procedure TCommonServiceImpl.CloseNavigator(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AAFCA2D03D0_4A92C1380380_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4AAFCA2D03D0_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFCA2D03D0_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_Navigator.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCA2D03D0_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.CloseNavigator

procedure TCommonServiceImpl.CloseTasksPanel(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AAFCCD00301_4A92C1380380_var*
var
 l_Form : IvcmEntityForm;
//#UC END# *4AAFCCD00301_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AAFCCD00301_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_TasksPanel.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCCD00301_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.CloseTasksPanel

procedure TCommonServiceImpl.DeleteDocumentFromControl(const aDocument: IDocument);
 {* Снять документ с контроля }
var
 __WasEnter : Boolean;
//#UC START# *4AC1F3D702D2_4A92C1380380_var*
var
 l_Controllable : IControllable;
//#UC END# *4AC1F3D702D2_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F3D702D2_4A92C1380380_impl*
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  DeleteFromControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3D702D2_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.DeleteDocumentFromControl

procedure TCommonServiceImpl.DeleteFromControl(const aControllable: IControllable);
 {* Снять объект с контроля }
var
 __WasEnter : Boolean;
//#UC START# *4AC1F40900DE_4A92C1380380_var*
//#UC END# *4AC1F40900DE_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F40900DE_4A92C1380380_impl*
 if Assigned(aControllable) then
 begin
  aControllable.SetControlled(False);
  TControlledObjectService.Instance.DeleteControlledObject(aControllable);
 end;//Assigned(aControllable)
//#UC END# *4AC1F40900DE_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.DeleteFromControl

procedure TCommonServiceImpl.FromPrinterSettings(const aPrinter: Il3Printer);
 {* Считать настройки из принтера }
var
 __WasEnter : Boolean;
//#UC START# *4ABB68C603CE_4A92C1380380_var*
var
 l_PageSetup : InsPageSettingsInfo;
//#UC END# *4ABB68C603CE_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB68C603CE_4A92C1380380_impl*
 l_PageSetup := TnsPageSetup.Make(nil, aPrinter);
 try
  if l_PageSetup.LoadPageFormatFromPrinter then
   if l_PageSetup.Modified then
    l_PageSetup.SavePageFormatToSettings;
 finally
  l_PageSetup := nil;
 end;//try..finally
//#UC END# *4ABB68C603CE_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.FromPrinterSettings

function TCommonServiceImpl.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
var
 __WasEnter : Boolean;
//#UC START# *4AC203EB01AE_4A92C1380380_var*
var
 l_State : IDocumentState;
 l_Info : TRedactionInfo;
//#UC END# *4AC203EB01AE_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC203EB01AE_4A92C1380380_impl*
 Result := cNullDate;
 if (aDocument <> nil) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   if (l_State <> nil) then
   begin
    l3FillChar(l_Info, SizeOf(l_Info));
    l_State.GetCurrentRedaction(l_Info);
    Result := l_Info.rTimeMachineDate;
   end;//l_State <> nil
  finally
   l_State := nil;
  end;//try..finally
 end;//aDocument <> nil
//#UC END# *4AC203EB01AE_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.GetCurEditionDate

procedure TCommonServiceImpl.GetNavigator(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
 {* Меню (вкладка) }
var
 __WasEnter : Boolean;
//#UC START# *4ABCA68B0155_4A92C1380380_var*
var
 l_Aggregate : IvcmAggregate;
 l_RubList : IvcmEntityForm;
 l_Params : IvcmMakeParams;
 l_Navigator : IvcmEntityForm;
//#UC END# *4ABCA68B0155_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABCA68B0155_4A92C1380380_impl*
 vcmDispatcher.FormDispatcher.Lock;
 try
  if CheckContainer(aContainer).NativeMainForm.HasForm(fm_efRubricator.rFormID,
                                                       vcm_ztParent,
                                                       True,
                                                       @l_RubList) then
  begin
   l_Aggregate := l_RubList.Aggregate;
   if (l_Aggregate = nil) then
   begin
    l_RubList.MakeAggregate;
    l_Aggregate := l_RubList.Aggregate;
   end;//l_Aggregate = nil
   l_Params := vcmSetAggregate(l_Aggregate,
                               vcmMakeParams(l_Aggregate,
                                         CheckContainer(aContainer)));   
  end//CheckContainer(aContainer).NativeMainForm.HasForm..
  else
   l_Params := vcmCheckAggregate(vcmMakeParams(anAggregate,
                                           CheckContainer(aContainer)));
  l_Navigator := Ten_Navigator.MakeSingleChild(l_Params.Container.NativeMainForm,
                                               l_Params,
                                               vcm_ztNavigator);
  afw.ProcessMessages;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=566789558
  l_Navigator.SetActiveInParent;
 finally
  vcmDispatcher.FormDispatcher.UnLock;
 end;//try..finally
 op_Rubricator_Synchronize.Call(l_RubList);
//#UC END# *4ABCA68B0155_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.GetNavigator

function TCommonServiceImpl.IsCurEditionActual(const aState: IDocumentState): Boolean;
var
 __WasEnter : Boolean;
//#UC START# *4AC1F6E802E5_4A92C1380380_var*
//#UC END# *4AC1F6E802E5_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F6E802E5_4A92C1380380_impl*
  Result := True;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=296096137&focusedCommentId=326777595#comment-326777595 
  if (aState <> nil) and (not DefDataAdapter.InTerminateProcess) then
   try
    Result := aState.IsActual;
   except
    on ECorbaException do
    ;
   end;//try..except
//#UC END# *4AC1F6E802E5_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.IsCurEditionActual

function TCommonServiceImpl.IsCurEditionActual(const aDocument: IDocument): Boolean;
var
 __WasEnter : Boolean;
//#UC START# *4AC1F71B0366_4A92C1380380_var*
var
 l_State : IDocumentState;
//#UC END# *4AC1F71B0366_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F71B0366_4A92C1380380_impl*
 Result := True;
 if (aDocument <> nil) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   Result := IsCurEditionActual(l_State);
  finally
   l_State := nil;
  end;//try..finally
 end;//aDocument <> nil
//#UC END# *4AC1F71B0366_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.IsCurEditionActual

function TCommonServiceImpl.IsUnderControl(const aDoc: IDocument): Boolean;
 {* Находится ли документ на контроле }
var
 __WasEnter : Boolean;
//#UC START# *4AC1F483035F_4A92C1380380_var*
var
 l_Controllable : IControllable;
//#UC END# *4AC1F483035F_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1F483035F_4A92C1380380_impl*
 Result := False;
 if Supports(aDoc, IControllable, l_Controllable) then
 try
  Result := l_Controllable.GetControlled;
 finally
  l_Controllable := nil;
 end;
//#UC END# *4AC1F483035F_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.IsUnderControl

procedure TCommonServiceImpl.OpenNewDocs(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4ABBA74F03DA_4A92C1380380_var*
var
 l_Node : INodeBase;
 l_Child : INodeBase;
//#UC END# *4ABBA74F03DA_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABBA74F03DA_4A92C1380380_impl*
 l_Node := TPrimF1CommonModule.GetMenuTypedItem(NM_BUSINESS_INFO_FOLDER);
 if (l_Node <> nil) then
 begin
  l_Node.GetFirstChild(l_Child);
  while (l_Child <> nil) do
  begin
   if (TNavigatorMenuItemType(l_Child.GetType) = NM_NEW_DOCS) then
    break;
   l_Child.GetNext(l_Node);
   l_Child := l_Node;
  end;//l_Child <> nil
  if (l_Child <> nil) then
   TRubricatorOpenService.Instance.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABBA74F03DA_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.OpenNewDocs

procedure TCommonServiceImpl.OpenRubricatorOnStart(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4ABB8D6B0041_4A92C1380380_var*
var
 l_Node : INodeBase;
 l_Child : INodeBase;
//#UC END# *4ABB8D6B0041_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB8D6B0041_4A92C1380380_impl*
 l_Node := TPrimF1CommonModule.GetMenuTypedItem(NM_LAW_NAVIGATOR_FOLDER);
 if (l_Node <> nil) then
 begin
  l_Node.GetFirstChild(l_Child);
  if l_Child <> nil then
   TRubricatorOpenService.Instance.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABB8D6B0041_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.OpenRubricatorOnStart

procedure TCommonServiceImpl.OpenTasksPanel(const aContainer: IvcmContainer);
var
 __WasEnter : Boolean;
//#UC START# *4AC1000A0176_4A92C1380380_var*
//#UC END# *4AC1000A0176_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4AC1000A0176_4A92C1380380_impl*
 {$If not (defined(Monitorings) or defined(Admin))}
 // заменяем Make --> MakeSingleChild
 // http://mdp.garant.ru/pages/viewpage.action?pageId=342864296&focusedCommentId=342868675#comment-342868675
 Ten_TasksPanel.MakeSingleChild(CheckContainer(aContainer), vcmMakeParams(nil,
                               CheckContainer(aContainer)),
                     vcm_ztNavigator,
                     Ord(tpMain));
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
//#UC END# *4AC1000A0176_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.OpenTasksPanel

procedure TCommonServiceImpl.ToPrinterSettings(const aPrinter: Il3Printer);
 {* Записать настройки в принтер }
var
 __WasEnter : Boolean;
//#UC START# *4ABB691803C2_4A92C1380380_var*
var
 l_PageSetup : InsPageSettingsInfo;
//#UC END# *4ABB691803C2_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4ABB691803C2_4A92C1380380_impl*
 l_PageSetup := TnsPageSetup.Make(nil, aPrinter);
 try
  l_PageSetup.SaveToPrinter;
 finally
  l_PageSetup := nil;
 end;//try..finally
//#UC END# *4ABB691803C2_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.ToPrinterSettings

function TCommonServiceImpl.MakeProgressIndicator(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4A93F1F200B0_4A92C1380380_var*
//#UC END# *4A93F1F200B0_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4A93F1F200B0_4A92C1380380_impl*
 Result := TefProgressIndicator.Make(aProgress, aCaption, aMaxCount);
 try
  Assert((Result <> nil) AND (Result.VCLWinControl <> nil));
  Result.VCLWinControl.Repaint;
  // иначе не отрисовывается кнопка на форме прогресс бара
  {$IfDef InsiderTest}
  Inc((Result.VCLWinControl As TvcmEntityForm).g_AllowModal);
  try
  {$EndIf InsiderTest}
   Result.ShowModal;
   afw.ProcessMessages; //http://mdp.garant.ru/pages/viewpage.action?pageId=564992569
  {$IfDef InsiderTest}
  finally
   Dec((Result.VCLWinControl As TvcmEntityForm).g_AllowModal);
  end;//try..finally
  {$EndIf InsiderTest}
 except
  Result := nil;
 end;//try..except
//#UC END# *4A93F1F200B0_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.MakeProgressIndicator

function TCommonServiceImpl.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine): IvcmEntityForm;
var
 __WasEnter : Boolean;
//#UC START# *4B2624ED010D_4A92C1380380_var*
//#UC END# *4B2624ED010D_4A92C1380380_var*
begin
 __WasEnter := vcmEnterFactory;
 try
//#UC START# *4B2624ED010D_4A92C1380380_impl*
 Result := Ten_TurnOffTimeMachine.Make(anIntf);
//#UC END# *4B2624ED010D_4A92C1380380_impl*
 finally
  if __WasEnter then
   vcmLeaveFactory;
 end;//try..finally
end;//TCommonServiceImpl.OpenTurnOffTimeMachine

class function TCommonServiceImpl.Instance: TCommonServiceImpl;
 {* Метод получения экземпляра синглетона TCommonServiceImpl }
begin
 if (g_TCommonServiceImpl = nil) then
 begin
  l3System.AddExitProc(TCommonServiceImplFree);
  g_TCommonServiceImpl := Create;
 end;
 Result := g_TCommonServiceImpl;
end;//TCommonServiceImpl.Instance

class function TCommonServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TCommonServiceImpl <> nil;
end;//TCommonServiceImpl.Exists

class function TPrimF1CommonModule.GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
var l_Root: INodeBase;
var l_Child: INodeBase;
var l_Node: INodeBase;
//#UC START# *4ABB884103D3_4A92C1380380_var*
//#UC END# *4ABB884103D3_4A92C1380380_var*
begin
//#UC START# *4ABB884103D3_4A92C1380380_impl*
 Result := nil;
 l_Root := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(c_MainMenu_NodeClass));
 try
  l_Root.GetFirstChild(l_Child);
  while l_Child <> nil do
  begin
   if TNavigatorMenuItemType(l_Child.GetType) = aType then
   begin
    Result := l_Child;
    break;
   end;

   l_Child.GetNext(l_Node);
   l_Child := l_Node;
  end;

 finally
  l_Root := nil;
 end;
//#UC END# *4ABB884103D3_4A92C1380380_impl*
end;//TPrimF1CommonModule.GetMenuTypedItem

class procedure TPrimF1CommonModule.SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
 aType: TNavigatorMenuItemType);
var l_List: IvcmNodes;
var l_Node: Il3Node;
var l_AdapterNode: INodeBase;
//#UC START# *4ABB8A470126_4A92C1380380_var*
//#UC END# *4ABB8A470126_4A92C1380380_var*
begin
//#UC START# *4ABB8A470126_4A92C1380380_impl*
 if not (aType in defDataAdapter.MenuTypeCache) then
  with aParams do
  begin
   Op.Flag[vcm_ofEnabled] := true;
   defDataAdapter.MenuTypeCache := defDataAdapter.MenuTypeCache + [aType];
   l_List := Op.SubNodes;
   if (l_List <> nil) then
    with l_List do
    begin
     ShowRoot := False;
     l_List.Clear;
     l_AdapterNode := GetMenuTypedItem(aType);
     if (l_AdapterNode = nil) then
      Op.Flag[vcm_ofEnabled] := False
     else
     begin
      l_Node := TnsNewCachableNode.Make(l_AdapterNode);
      if l_Node <> nil then
       try
        nsMakeTreeLevel(l_Node, l_AdapterNode);
        Add(l_Node);
       finally
        l_Node := nil;
       end;//try..finally
     end;//l_AdapterNode = nil
    end;//with l_List
  end;//with aParams
//#UC END# *4ABB8A470126_4A92C1380380_impl*
end;//TPrimF1CommonModule.SetParamsForNavigatorElements

procedure TPrimF1CommonModule.opComplectInfoTest(const aParams: IvcmTestParamsPrim);
 {* Информация о комплекте }
//#UC START# *4ABB7615007A_4A92C1380380test_var*
//#UC END# *4ABB7615007A_4A92C1380380test_var*
begin
//#UC START# *4ABB7615007A_4A92C1380380test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not CheckContainer(nil).
  NativeMainForm.HasForm(fm_enCompInfo.rFormID, vcm_ztParent, True, nil);
//#UC END# *4ABB7615007A_4A92C1380380test_impl*
end;//TPrimF1CommonModule.opComplectInfoTest

procedure TPrimF1CommonModule.opComplectInfoExecute(const aParams: IvcmExecuteParamsPrim);
 {* Информация о комплекте }
//#UC START# *4ABB7615007A_4A92C1380380exec_var*
//#UC END# *4ABB7615007A_4A92C1380380exec_var*
begin
//#UC START# *4ABB7615007A_4A92C1380380exec_impl*
 TenCompInfo.Make(vcmCheckAggregate(vcmMakeParams(nil,
                                           CheckContainer(nil))));
//#UC END# *4ABB7615007A_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opComplectInfoExecute

procedure TPrimF1CommonModule.opLetterToDevelopersExecute(const aParams: IvcmExecuteParamsPrim);
 {* Письмо разработчикам }
//#UC START# *4ABBB19B030A_4A92C1380380exec_var*
//#UC END# *4ABBB19B030A_4A92C1380380exec_var*
begin
//#UC START# *4ABBB19B030A_4A92C1380380exec_impl*
 nsDoShellExecute(nsPrepareTextForMailto(vcmFmt(str_illMailTemlate,
  [bsComplectOwner, bsComplectName, FormatDateTime('dd/mm/yyyy',
   bsBaseDate)])));
//#UC END# *4ABBB19B030A_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opLetterToDevelopersExecute

procedure TPrimF1CommonModule.opOpenInformationTest(const aParams: IvcmTestParamsPrim);
 {* Справочная информация }
//#UC START# *4ABC82A70238_4A92C1380380test_var*
//#UC END# *4ABC82A70238_4A92C1380380test_var*
begin
//#UC START# *4ABC82A70238_4A92C1380380test_impl*
 SetParamsForNavigatorElements(aParams, NM_BUSINESS_INFO_FOLDER);
//#UC END# *4ABC82A70238_4A92C1380380test_impl*
end;//TPrimF1CommonModule.opOpenInformationTest

procedure TPrimF1CommonModule.opOpenInformationExecute(const aParams: IvcmExecuteParamsPrim);
 {* Справочная информация }
//#UC START# *4ABC82A70238_4A92C1380380exec_var*
//#UC END# *4ABC82A70238_4A92C1380380exec_var*
begin
//#UC START# *4ABC82A70238_4A92C1380380exec_impl*
{$If not (defined(Monitorings) or defined(Admin))}
 ExecuteNavigatorItem(aParams.CurrentNode, nil, CheckContainer(nil));
{$IfEnd not (defined(Monitorings) or defined(Admin))}
//#UC END# *4ABC82A70238_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opOpenInformationExecute

procedure TPrimF1CommonModule.opOpenIntranetTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4BD162890088_4A92C1380380test_var*
//#UC END# *4BD162890088_4A92C1380380test_var*
begin
//#UC START# *4BD162890088_4A92C1380380test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (defDataAdapter.RevisionCheckEnabled and
                                   (DefDataAdapter.CommonInterfaces.GetProductType = PT_SUPERMOBILE))
                                   or DefDataAdapter.CommonInterfaces.IsEarlyInstalled;
 aParams.Op.Flag[vcm_ofVisible] := aParams.Op.Flag[vcm_ofEnabled];
//#UC END# *4BD162890088_4A92C1380380test_impl*
end;//TPrimF1CommonModule.opOpenIntranetTest

procedure TPrimF1CommonModule.opOpenIntranetExecute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4BD162890088_4A92C1380380exec_var*
//#UC END# *4BD162890088_4A92C1380380exec_var*
begin
//#UC START# *4BD162890088_4A92C1380380exec_impl*
 defDataAdapter.OpenIntranet;
//#UC END# *4BD162890088_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opOpenIntranetExecute

procedure TPrimF1CommonModule.opOpenMainMenuByButtonExecute(const aParams: IvcmExecuteParamsPrim);
 {* Основное меню системы ГАРАНТ }
//#UC START# *4ABBAAE40176_4A92C1380380exec_var*
//#UC END# *4ABBAAE40176_4A92C1380380exec_var*
begin
//#UC START# *4ABBAAE40176_4A92C1380380exec_impl*
 TMainMenuOpenService.Instance.OpenMainMenuIfNeeded(nil);
//#UC END# *4ABBAAE40176_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opOpenMainMenuByButtonExecute

procedure TPrimF1CommonModule.opOpenMainMenuNewTest(const aParams: IvcmTestParamsPrim);
 {* Основное меню }
//#UC START# *4ABBAB14034B_4A92C1380380test_var*
//#UC END# *4ABBAB14034B_4A92C1380380test_var*
begin
//#UC START# *4ABBAB14034B_4A92C1380380test_impl*
 with aParams.Op.SubItems do
 begin
  Clear;
  if defDataAdapter.IsInpharmExists then
  begin
   AddOp(mod_opcode_CommonService_OpenMainMenuByButton, vcmCStr(str_MainMenuButtonItem));
   AddOp(mod_opcode_InpharmOperations_MedicMainMenu, vcmCStr(str_InPharmMenuButtonItem));
  end;//defDataAdapter.IsInpharmExists
 end;//with aParams.Op.SubItems
//#UC END# *4ABBAB14034B_4A92C1380380test_impl*
end;//TPrimF1CommonModule.opOpenMainMenuNewTest

procedure TPrimF1CommonModule.opOpenMainMenuNewExecute(const aParams: IvcmExecuteParamsPrim);
 {* Основное меню }
//#UC START# *4ABBAB14034B_4A92C1380380exec_var*
//#UC END# *4ABBAB14034B_4A92C1380380exec_var*
begin
//#UC START# *4ABBAB14034B_4A92C1380380exec_impl*
 TMainMenuOpenService.Instance.OpenMainMenuIfNeeded(nil);
//#UC END# *4ABBAB14034B_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opOpenMainMenuNewExecute

procedure TPrimF1CommonModule.opOpenRubricatorTest(const aParams: IvcmTestParamsPrim);
 {* Правовой навигатор }
//#UC START# *4ABC827B010F_4A92C1380380test_var*
//#UC END# *4ABC827B010F_4A92C1380380test_var*
begin
//#UC START# *4ABC827B010F_4A92C1380380test_impl*
 SetParamsForNavigatorElements(aParams, NM_LAW_NAVIGATOR_FOLDER);
//#UC END# *4ABC827B010F_4A92C1380380test_impl*
end;//TPrimF1CommonModule.opOpenRubricatorTest

procedure TPrimF1CommonModule.opOpenRubricatorExecute(const aParams: IvcmExecuteParamsPrim);
 {* Правовой навигатор }
//#UC START# *4ABC827B010F_4A92C1380380exec_var*
//#UC END# *4ABC827B010F_4A92C1380380exec_var*
begin
//#UC START# *4ABC827B010F_4A92C1380380exec_impl*
{$If not (defined(Monitorings) or defined(Admin))}
 ExecuteNavigatorItem(aParams.CurrentNode, nil, CheckContainer(nil));
{$IfEnd not (defined(Monitorings) or defined(Admin))}
//#UC END# *4ABC827B010F_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opOpenRubricatorExecute

procedure TPrimF1CommonModule.opPageSetupExecute(const aParams: IvcmExecuteParamsPrim);
 {* Настройка страницы... }
//#UC START# *4ABB76520183_4A92C1380380exec_var*
//#UC END# *4ABB76520183_4A92C1380380exec_var*
begin
//#UC START# *4ABB76520183_4A92C1380380exec_impl*
 TPrintingService.Instance.MakePageSetup(nil);
//#UC END# *4ABB76520183_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opPageSetupExecute

procedure TPrimF1CommonModule.opShowEULAExecute(const aParams: IvcmExecuteParamsPrim);
 {* Условия использования }
//#UC START# *4ABB792C0164_4A92C1380380exec_var*
//#UC END# *4ABB792C0164_4A92C1380380exec_var*
begin
//#UC START# *4ABB792C0164_4A92C1380380exec_impl*
 TefEULA.Make(vcmMakeParams);
//#UC END# *4ABB792C0164_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opShowEULAExecute

procedure TPrimF1CommonModule.opTasksPanelExecute(const aParams: IvcmExecuteParamsPrim);
 {* Панель задач }
//#UC START# *4ABBAC7D003B_4A92C1380380exec_var*
//#UC END# *4ABBAC7D003B_4A92C1380380exec_var*
begin
//#UC START# *4ABBAC7D003B_4A92C1380380exec_impl*
 TCommonService.Instance.OpenTasksPanel(nil);
//#UC END# *4ABBAC7D003B_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opTasksPanelExecute

procedure TPrimF1CommonModule.opget_navigatorExecute(const aParams: IvcmExecuteParamsPrim);
 {* Меню (вкладка) }
//#UC START# *4AC0FBFE0095_4A92C1380380exec_var*
//#UC END# *4AC0FBFE0095_4A92C1380380exec_var*
begin
//#UC START# *4AC0FBFE0095_4A92C1380380exec_impl*
 TCommonService.Instance.GetNavigator(nil, nil);
//#UC END# *4AC0FBFE0095_4A92C1380380exec_impl*
end;//TPrimF1CommonModule.opget_navigatorExecute

procedure TPrimF1CommonModule.Loaded;
begin
 inherited;
 PublishOp('opComplectInfo', opComplectInfoExecute, opComplectInfoTest);
 PublishOp('LetterToDevelopers', opLetterToDevelopersExecute, nil);
 PublishOp('opOpenInformation', opOpenInformationExecute, opOpenInformationTest);
 PublishOp('opOpenIntranet', opOpenIntranetExecute, opOpenIntranetTest);
 PublishOp('opOpenMainMenuByButton', opOpenMainMenuByButtonExecute, nil);
 PublishOp('OpenMainMenuNew', opOpenMainMenuNewExecute, opOpenMainMenuNewTest);
 PublishOp('opOpenRubricator', opOpenRubricatorExecute, opOpenRubricatorTest);
 PublishOp('opPageSetup', opPageSetupExecute, nil);
 PublishOp('opShowEULA', opShowEULAExecute, nil);
 PublishOp('opTasksPanel', opTasksPanelExecute, nil);
 PublishOp('get_navigator', opget_navigatorExecute, nil);
end;//TPrimF1CommonModule.Loaded

class procedure TPrimF1CommonModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TRememberPasswordForm);
 aList.Add(TefProgressIndicator);
 aList.Add(TefEULA);
 aList.Add(TefAbout);
 aList.Add(TenCompInfo);
 aList.Add(TnsRegistrationForm);
 aList.Add(Ten_TasksPanel);
 aList.Add(Ten_Navigator);
 aList.Add(Ten_TurnOffTimeMachine);
end;//TPrimF1CommonModule.GetEntityForms

initialization
 TCommonService.Instance.Alien := TCommonServiceImpl.Instance;
 {* Регистрация TCommonServiceImpl }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
