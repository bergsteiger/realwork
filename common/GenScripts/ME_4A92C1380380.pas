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
 , SearchInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , ConfigInterfaces
 , l3PrinterInterfaces
 , DynamicTreeUnit
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 , UnderControlUnit
 , DocumentUnit
 , AdapterFacade
 , PresentationInterfaces
;

type
 TPrimF1CommonModule = {abstract} class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* "Общий" только для F1 }
  protected
   procedure ComplectInfo;
    {* Информация о комплекте }
   procedure PageSetup;
    {* Настройка страницы... }
   procedure ShowEULA;
    {* Условия использования }
   function GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
   procedure SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
    aType: TNavigatorMenuItemType);
   procedure OpenMainMenuByButton;
    {* Основное меню системы ГАРАНТ }
   procedure OpenMainMenuNew;
    {* Основное меню }
   procedure TasksPanel;
    {* Панель задач }
   procedure LetterToDevelopers;
    {* Письмо разработчикам }
   procedure OpenRubricator;
    {* Правовой навигатор }
   procedure OpenInformation;
    {* Справочная информация }
   procedure get_navigator;
    {* Меню (вкладка) }
   procedure OpenIntranet;
  public
   procedure MakeProgressIndicator(const aProgress: InsProgressIndicator;
    const aCaption: Il3CString;
    aMaxCount: Integer);
   procedure CloseNavigator(const aContainer: IvcmContainer);
   procedure CloseTasksPanel(const aContainer: IvcmContainer);
   procedure FromPrinterSettings(const aPrinter: Il3Printer);
    {* Считать настройки из принтера }
   procedure ToPrinterSettings(const aPrinter: Il3Printer);
    {* Записать настройки в принтер }
   procedure About;
    {* Выводит диалог "О программе" }
   procedure ApplicationActivate;
   procedure OpenRubricatorOnStart(const aContainer: IvcmContainer);
   procedure OpenNewDocs(const aContainer: IvcmContainer);
   procedure GetNavigator(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
    {* Меню (вкладка) }
   procedure OpenTasksPanel(const aContainer: IvcmContainer);
   procedure AddDocumentToControl(const aDocument: IDocument);
    {* Поставить документ на контроль }
   procedure AddToControl(const aControllable: IControllable);
    {* Поставить объект на контроль }
   procedure DeleteDocumentFromControl(const aDocument: IDocument);
    {* Снять документ с контроля }
   procedure DeleteFromControl(const aControllable: IControllable);
    {* Снять объект с контроля }
   function IsUnderControl(const aDoc: IDocument): Boolean;
    {* Находится ли документ на контроле }
   function IsCurEditionActual(const aState: IDocumentState): Boolean; overload;
   function IsCurEditionActual(const aDocument: IDocument): Boolean; overload;
   function GetCurEditionDate(const aDocument: IDocument): AdapterDate;
   procedure OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine);
 end;//TPrimF1CommonModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Search_Strange_Controls
 , Common_Rubricator_Controls
 , PrimTasksPanel_tpMain_UserType
 , Common_FormDefinitions_Controls
 , NavigatorUtils
 , GblAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 , nsPageSetup
 , DataAdapter
 , nsTypes
 , nsNewCachableNode
 , nsNodes
 , SysUtils
 , nsExternalObjectPrim
 , nsUtils
 , bsUtils
 , l3Base
 , nsConst
;

{$If NOT Defined(NoVCM)}
procedure TPrimF1CommonModule.MakeProgressIndicator(const aProgress: InsProgressIndicator;
 const aCaption: Il3CString;
 aMaxCount: Integer);
//#UC START# *4A93F1F200B0_4A92C1380380_var*
//#UC END# *4A93F1F200B0_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.MakeProgressIndicator

procedure TPrimF1CommonModule.CloseNavigator(const aContainer: IvcmContainer);
var l_Form: IvcmEntityForm;
//#UC START# *4AAFCA2D03D0_4A92C1380380_var*
//#UC END# *4AAFCA2D03D0_4A92C1380380_var*
begin
//#UC START# *4AAFCA2D03D0_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_Navigator.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCA2D03D0_4A92C1380380_impl*
end;//TPrimF1CommonModule.CloseNavigator

procedure TPrimF1CommonModule.CloseTasksPanel(const aContainer: IvcmContainer);
var l_Form: IvcmEntityForm;
//#UC START# *4AAFCCD00301_4A92C1380380_var*
//#UC END# *4AAFCCD00301_4A92C1380380_var*
begin
//#UC START# *4AAFCCD00301_4A92C1380380_impl*
 Assert(aContainer <> nil);
 aContainer.HasForm(fm_en_TasksPanel.rFormID, vcm_ztNavigator, true, @l_Form);
 if (l_Form <> nil) then
  l_Form.SafeClose;
//#UC END# *4AAFCCD00301_4A92C1380380_impl*
end;//TPrimF1CommonModule.CloseTasksPanel

procedure TPrimF1CommonModule.FromPrinterSettings(const aPrinter: Il3Printer);
 {* Считать настройки из принтера }
var l_PageSetup: InsPageSettingsInfo;
//#UC START# *4ABB68C603CE_4A92C1380380_var*
//#UC END# *4ABB68C603CE_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.FromPrinterSettings

procedure TPrimF1CommonModule.ToPrinterSettings(const aPrinter: Il3Printer);
 {* Записать настройки в принтер }
var l_PageSetup: InsPageSettingsInfo;
//#UC START# *4ABB691803C2_4A92C1380380_var*
//#UC END# *4ABB691803C2_4A92C1380380_var*
begin
//#UC START# *4ABB691803C2_4A92C1380380_impl*
 l_PageSetup := TnsPageSetup.Make(nil, aPrinter);
 try
  l_PageSetup.SaveToPrinter;
 finally
  l_PageSetup := nil;
 end;//try..finally
//#UC END# *4ABB691803C2_4A92C1380380_impl*
end;//TPrimF1CommonModule.ToPrinterSettings

procedure TPrimF1CommonModule.About;
 {* Выводит диалог "О программе" }
//#UC START# *4ABB6F5D0397_4A92C1380380_var*
//#UC END# *4ABB6F5D0397_4A92C1380380_var*
begin
//#UC START# *4ABB6F5D0397_4A92C1380380_impl*
 TefAbout.Make(vcmMakeParams);
//#UC END# *4ABB6F5D0397_4A92C1380380_impl*
end;//TPrimF1CommonModule.About

procedure TPrimF1CommonModule.ApplicationActivate;
//#UC START# *4ABB74D80287_4A92C1380380_var*
//#UC END# *4ABB74D80287_4A92C1380380_var*
begin
//#UC START# *4ABB74D80287_4A92C1380380_impl*
 op_PrintParams_UpdatePrinter.Broadcast;
//#UC END# *4ABB74D80287_4A92C1380380_impl*
end;//TPrimF1CommonModule.ApplicationActivate

procedure TPrimF1CommonModule.ComplectInfo;
 {* Информация о комплекте }
//#UC START# *4ABB7615007A_4A92C1380380_var*
//#UC END# *4ABB7615007A_4A92C1380380_var*
begin
//#UC START# *4ABB7615007A_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB7615007A_4A92C1380380_impl*
end;//TPrimF1CommonModule.ComplectInfo

procedure TPrimF1CommonModule.PageSetup;
 {* Настройка страницы... }
//#UC START# *4ABB76520183_4A92C1380380_var*
//#UC END# *4ABB76520183_4A92C1380380_var*
begin
//#UC START# *4ABB76520183_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB76520183_4A92C1380380_impl*
end;//TPrimF1CommonModule.PageSetup

procedure TPrimF1CommonModule.ShowEULA;
 {* Условия использования }
//#UC START# *4ABB792C0164_4A92C1380380_var*
//#UC END# *4ABB792C0164_4A92C1380380_var*
begin
//#UC START# *4ABB792C0164_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB792C0164_4A92C1380380_impl*
end;//TPrimF1CommonModule.ShowEULA

function TPrimF1CommonModule.GetMenuTypedItem(aType: TNavigatorMenuItemType): INodeBase;
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

procedure TPrimF1CommonModule.SetParamsForNavigatorElements(const aParams: IvcmTestParamsPrim;
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

procedure TPrimF1CommonModule.OpenRubricatorOnStart(const aContainer: IvcmContainer);
var l_Node: INodeBase;
var l_Child: INodeBase;
//#UC START# *4ABB8D6B0041_4A92C1380380_var*
//#UC END# *4ABB8D6B0041_4A92C1380380_var*
begin
//#UC START# *4ABB8D6B0041_4A92C1380380_impl*
 l_Node := GetMenuTypedItem(NM_LAW_NAVIGATOR_FOLDER);
 if (l_Node <> nil) then
 begin
  l_Node.GetFirstChild(l_Child);
  if l_Child <> nil then
   TdmStdRes.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABB8D6B0041_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenRubricatorOnStart

procedure TPrimF1CommonModule.OpenNewDocs(const aContainer: IvcmContainer);
var l_Node: INodeBase;
var l_Child: INodeBase;
//#UC START# *4ABBA74F03DA_4A92C1380380_var*
//#UC END# *4ABBA74F03DA_4A92C1380380_var*
begin
//#UC START# *4ABBA74F03DA_4A92C1380380_impl*
 l_Node := GetMenuTypedItem(NM_BUSINESS_INFO_FOLDER);
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
   TdmStdRes.OpenRubricator(TnsNewCachableNode.Make(l_Child),
                            l_Node,
                            nil,
                            true,
                            nil,
                            CheckContainer(aContainer));
 end;//l_Node <> nil
//#UC END# *4ABBA74F03DA_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenNewDocs

procedure TPrimF1CommonModule.OpenMainMenuByButton;
 {* Основное меню системы ГАРАНТ }
//#UC START# *4ABBAAE40176_4A92C1380380_var*
//#UC END# *4ABBAAE40176_4A92C1380380_var*
begin
//#UC START# *4ABBAAE40176_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAAE40176_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenMainMenuByButton

procedure TPrimF1CommonModule.OpenMainMenuNew;
 {* Основное меню }
//#UC START# *4ABBAB14034B_4A92C1380380_var*
//#UC END# *4ABBAB14034B_4A92C1380380_var*
begin
//#UC START# *4ABBAB14034B_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAB14034B_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenMainMenuNew

procedure TPrimF1CommonModule.TasksPanel;
 {* Панель задач }
//#UC START# *4ABBAC7D003B_4A92C1380380_var*
//#UC END# *4ABBAC7D003B_4A92C1380380_var*
begin
//#UC START# *4ABBAC7D003B_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBAC7D003B_4A92C1380380_impl*
end;//TPrimF1CommonModule.TasksPanel

procedure TPrimF1CommonModule.LetterToDevelopers;
 {* Письмо разработчикам }
//#UC START# *4ABBB19B030A_4A92C1380380_var*
//#UC END# *4ABBB19B030A_4A92C1380380_var*
begin
//#UC START# *4ABBB19B030A_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABBB19B030A_4A92C1380380_impl*
end;//TPrimF1CommonModule.LetterToDevelopers

procedure TPrimF1CommonModule.OpenRubricator;
 {* Правовой навигатор }
//#UC START# *4ABC827B010F_4A92C1380380_var*
//#UC END# *4ABC827B010F_4A92C1380380_var*
begin
//#UC START# *4ABC827B010F_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABC827B010F_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenRubricator

procedure TPrimF1CommonModule.OpenInformation;
 {* Справочная информация }
//#UC START# *4ABC82A70238_4A92C1380380_var*
//#UC END# *4ABC82A70238_4A92C1380380_var*
begin
//#UC START# *4ABC82A70238_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABC82A70238_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenInformation

procedure TPrimF1CommonModule.GetNavigator(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
 {* Меню (вкладка) }
var l_Navigator: IvcmEntityForm;
var l_RubList: IvcmEntityForm;
var l_Aggregate: IvcmAggregate;
var l_Params: IvcmMakeParams;
//#UC START# *4ABCA68B0155_4A92C1380380_var*
//#UC END# *4ABCA68B0155_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.GetNavigator

procedure TPrimF1CommonModule.get_navigator;
 {* Меню (вкладка) }
//#UC START# *4AC0FBFE0095_4A92C1380380_var*
//#UC END# *4AC0FBFE0095_4A92C1380380_var*
begin
//#UC START# *4AC0FBFE0095_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC0FBFE0095_4A92C1380380_impl*
end;//TPrimF1CommonModule.get_navigator

procedure TPrimF1CommonModule.OpenTasksPanel(const aContainer: IvcmContainer);
//#UC START# *4AC1000A0176_4A92C1380380_var*
//#UC END# *4AC1000A0176_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.OpenTasksPanel

procedure TPrimF1CommonModule.AddDocumentToControl(const aDocument: IDocument);
 {* Поставить документ на контроль }
var l_Controllable: IControllable;
//#UC START# *4AC1F3770062_4A92C1380380_var*
//#UC END# *4AC1F3770062_4A92C1380380_var*
begin
//#UC START# *4AC1F3770062_4A92C1380380_impl*
 Assert(IsCurEditionActual(aDocument),'Can''t flag unactual redation');
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  AddToControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3770062_4A92C1380380_impl*
end;//TPrimF1CommonModule.AddDocumentToControl

procedure TPrimF1CommonModule.AddToControl(const aControllable: IControllable);
 {* Поставить объект на контроль }
//#UC START# *4AC1F3A700BE_4A92C1380380_var*
//#UC END# *4AC1F3A700BE_4A92C1380380_var*
begin
//#UC START# *4AC1F3A700BE_4A92C1380380_impl*
 if Assigned(aControllable) and aControllable.GetCanSetToControl then
 begin
  aControllable.SetControlled(True);
  TdmStdRes.AddControlledObject(aControllable);
 end;//Assigned(aControllable) and aControllable.GetCanSetToControl
//#UC END# *4AC1F3A700BE_4A92C1380380_impl*
end;//TPrimF1CommonModule.AddToControl

procedure TPrimF1CommonModule.DeleteDocumentFromControl(const aDocument: IDocument);
 {* Снять документ с контроля }
var l_Controllable: IControllable;
//#UC START# *4AC1F3D702D2_4A92C1380380_var*
//#UC END# *4AC1F3D702D2_4A92C1380380_var*
begin
//#UC START# *4AC1F3D702D2_4A92C1380380_impl*
 if Supports(aDocument, IControllable, l_Controllable) then
 try
  DeleteFromControl(l_Controllable);
 finally
  l_Controllable := nil;
 end;//Supports(aDoc, IControllable, l_Controllable)
//#UC END# *4AC1F3D702D2_4A92C1380380_impl*
end;//TPrimF1CommonModule.DeleteDocumentFromControl

procedure TPrimF1CommonModule.DeleteFromControl(const aControllable: IControllable);
 {* Снять объект с контроля }
//#UC START# *4AC1F40900DE_4A92C1380380_var*
//#UC END# *4AC1F40900DE_4A92C1380380_var*
begin
//#UC START# *4AC1F40900DE_4A92C1380380_impl*
 if Assigned(aControllable) then
 begin
  aControllable.SetControlled(False);
  TdmStdRes.DeleteControlledObject(aControllable);
 end;//Assigned(aControllable)
//#UC END# *4AC1F40900DE_4A92C1380380_impl*
end;//TPrimF1CommonModule.DeleteFromControl

function TPrimF1CommonModule.IsUnderControl(const aDoc: IDocument): Boolean;
 {* Находится ли документ на контроле }
var l_Controllable: IControllable;
//#UC START# *4AC1F483035F_4A92C1380380_var*
//#UC END# *4AC1F483035F_4A92C1380380_var*
begin
//#UC START# *4AC1F483035F_4A92C1380380_impl*
 Result := False;
 if Supports(aDoc, IControllable, l_Controllable) then
 try
  Result := l_Controllable.GetControlled;
 finally
  l_Controllable := nil;
 end;
//#UC END# *4AC1F483035F_4A92C1380380_impl*
end;//TPrimF1CommonModule.IsUnderControl

function TPrimF1CommonModule.IsCurEditionActual(const aState: IDocumentState): Boolean;
var l_Info: TRedactionInfo;
//#UC START# *4AC1F6E802E5_4A92C1380380_var*
//#UC END# *4AC1F6E802E5_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.IsCurEditionActual

function TPrimF1CommonModule.IsCurEditionActual(const aDocument: IDocument): Boolean;
var l_State: IDocumentState;
//#UC START# *4AC1F71B0366_4A92C1380380_var*
//#UC END# *4AC1F71B0366_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.IsCurEditionActual

function TPrimF1CommonModule.GetCurEditionDate(const aDocument: IDocument): AdapterDate;
var l_State: IDocumentState;
var l_Info: TRedactionInfo;
//#UC START# *4AC203EB01AE_4A92C1380380_var*
//#UC END# *4AC203EB01AE_4A92C1380380_var*
begin
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
end;//TPrimF1CommonModule.GetCurEditionDate

procedure TPrimF1CommonModule.OpenIntranet;
//#UC START# *4BD162890088_4A92C1380380_var*
//#UC END# *4BD162890088_4A92C1380380_var*
begin
//#UC START# *4BD162890088_4A92C1380380_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BD162890088_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenIntranet

procedure TPrimF1CommonModule.OpenTurnOffTimeMachine(const anIntf: InsTurnOffTimeMachine);
//#UC START# *4B2624ED010D_4A92C1380380_var*
//#UC END# *4B2624ED010D_4A92C1380380_var*
begin
//#UC START# *4B2624ED010D_4A92C1380380_impl*
 Result := Ten_TurnOffTimeMachine.Make(anIntf);
//#UC END# *4B2624ED010D_4A92C1380380_impl*
end;//TPrimF1CommonModule.OpenTurnOffTimeMachine
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
