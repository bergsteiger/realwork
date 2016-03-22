unit PrimF1Res;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimF1Res.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimF1
//
// Базовое приложение F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SearchUnit
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  F1_Application_Template_InternalOperations_Controls,
  PrimMain_Form,
  nsPrimCachedEvent,
  l3StringIDEx,
  l3MessageID,
  MainPrim_Form,
  F1LikeRes,
  PrimMainOptions_Form,
  Classes {a},
  vcmExternalInterfaces {a},
  SearchLite_FormDefinitions_Controls,
  l3Interfaces,
  SearchInterfaces,
  nsTypes
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  vtSizeablePanel,
  vtProportionalPanel,
  nscTreeViewWithAdapterDragDrop
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimCommon_Module
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtLabel,
  vtButton,
  vtFocusLabel,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
  vtCheckBox,
  ElPopBtn,
  vtGradientWaitbar,
  vcmMainForm {a}
  ;

var
 { Локализуемые строки NemesisTitle }
str_NemesisTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NemesisTitle'; rValue : 'ГАРАНТ аэро');
 { 'ГАРАНТ аэро' }

type
TPrimF1Res = {abstract} class(TF1LikeRes)
 {* Базовое приложение F1 }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
protected
// overridden protected methods
    {$If not defined(NoVCM)}
   class procedure Runner(const aTitle: Tl3StringIDEx;
     const aHelpFile: AnsiString); override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   class procedure MakeResources; override;
    {$IfEnd} //not NoVCM
protected
// protected methods
   class procedure InitDefaults;
   class function CanRun(aLogo: TCustomForm): Boolean;
   class function GlobalInit(aLogo: TCustomForm;
    var theSplash: IUnknown): Boolean;
   class function RunOtherProcesses: Boolean; virtual;
   class function DoGlobalInit(aLogo: TCustomForm;
   var theSplash: IUnknown): Boolean; virtual;
   class procedure DoRun(var theSplash: IUnknown); virtual;
   class procedure LogUserActivity(aKind: TvcmOperationCallType);
public
// public methods
  {$If not defined(Admin)}
   class procedure OpenQuery(aQueryType: TlgQueryType;
   const aQuery: IQuery;
   const aContainer: IvcmContainer); virtual;
  {$IfEnd} //not Admin
 public
 // modules operations
   class function MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeAttributeSelect(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeSelectedAttributes(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean): IvcmEntityForm;
   class function OpenTreeSelection(const aTag: Il3CString;
     anAdditionalFilter: TnsFilterType;
     const aFormData: IdsTreeAttributeSelect): Integer;
   class function MakeUpdateMessage: IvcmEntityForm;
     {* Создаёт окно с сообщением об обновлении базы }
   class function MakeShutdownWindow(aCloseInterval: LongWord;
     aKind: TShutdownWarningKind): IvcmEntityForm;
     {* Создаёт окно сообщающее о закрытии приложения }
 public
 // operations codes
   class function opcode_Result_Ok : TvcmOpID;
     { Результат диалога -> OK }
   class function opcode_Tree_ExpandAll : TvcmOpID;
     { Дерево -> Развернуть все }
   class function opcode_Tree_CollapseAll : TvcmOpID;
     { Дерево -> Свернуть все }
   class function opcode_Tree_Wrap : TvcmOpID;
     { Дерево -> Перенос по словам }
   class function opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_SetCurrent : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_Invalidate : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_DropLogicSelection : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_LoadQuery : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
     { AttributeTree ->  }
   class function opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_GetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_IsQuerySaved : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_SetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_ClearQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_AttributeTree_SaveToQuery : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_DefaultAction : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOr : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicAnd : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicNot : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOrShortcut : TvcmOpID;
     {  ->  }
   class function opcode_Context_SetContext : TvcmOpID;
     {  ->  }
   class function opcode_Context_SyncContextParams : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_SetRoot : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_ChangeRoot : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_SetParent : TvcmOpID;
     {  ->  }
   class function opcode_AttributeTree_ExtSetRoot : TvcmOpID;
     {  ->  }
   class function opcode_ContextParams_ContextChanged : TvcmOpID;
     {  ->  }
   class function opcode_Result_OkExt : TvcmOpID;
     { Результат диалога -> OK }
   class function opcode_Result_Cancel : TvcmOpID;
     { Результат диалога -> Отмена }
   class function opcode_SelectedList_RefreshValues : TvcmOpID;
     {  ->  }
   class function opcode_System_InitShutdown : TvcmOpID;
     { Система -> Начать процесс завершения работы }
end;//TPrimF1Res

implementation

uses
  DataAdapter,
  F1Like_FormDefinitions_Controls,
  nsCustomStyleProcessor
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  BaseTypesUnit,
  evDocumentsCache
  {$If not defined(NoVCM)}
  ,
  vcmHistory
  {$IfEnd} //not NoVCM
  ,
  Windows,
  afwConsts,
  afwFacade,
  l3Base,
  StartUnit,
  SPHTMLHelp,
  GblAdapter,
  SysUtils,
  LoggingUnit,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  {$If not defined(NoVCM)}
  ,
  vtNavigator
  {$IfEnd} //not NoVCM
  ,
  nsConst,
  moLiteSearch,
  moRealCommon,
  vtStdRes,
  nsStartupSupport
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  DebugStr,
  TypInfo
  {$If defined(Nemesis)}
  ,
  F1_Schema
  {$IfEnd} //Nemesis
  ,
  nsSettings,
  nsContextFilterEventListener,
  evdSchema,
  l3ConstStrings,
  l3SysUtils,
  Logo_Form,
  nsAppTitleData,
  f1StartupCompletedService,
  LiteSearch_Module
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  ;

var
  { Локализуемые строки Local }
 str_ApplicationLoading : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ApplicationLoading'; rValue : 'Идёт загрузка...');
  { 'Идёт загрузка...' }
 str_FullVersionMessage : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FullVersionMessage'; rValue : 'версия %s');
  { 'версия %s' }

type
 TnsActiviryArray = array [TvcmOperationCallType] of Cardinal;

 TnsUserOperationEvent = {final} class(TnsPrimCachedEvent)
 private
 // private fields
   f_Counters : TnsActiviryArray;
 private
 // private methods
   procedure Log(aKind: TvcmOperationCallType); virtual;
 protected
 // realized methods
   procedure DoFireLog; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUserOperationEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUserOperationEvent


// start class TnsUserOperationEvent

var g_TnsUserOperationEvent : TnsUserOperationEvent = nil;

procedure TnsUserOperationEventFree;
begin
 l3Free(g_TnsUserOperationEvent);
end;

class function TnsUserOperationEvent.Instance: TnsUserOperationEvent;
begin
 if (g_TnsUserOperationEvent = nil) then
 begin
  l3System.AddExitProc(TnsUserOperationEventFree);
  g_TnsUserOperationEvent := Create;
 end;
 Result := g_TnsUserOperationEvent;
end;


procedure TnsUserOperationEvent.Log(aKind: TvcmOperationCallType);
//#UC START# *4B14F21C029D_4B14F1AB03A0_var*
//#UC END# *4B14F21C029D_4B14F1AB03A0_var*
begin
//#UC START# *4B14F21C029D_4B14F1AB03A0_impl*
 Inc(f_Counters[aKind]);
 RequestWrite;
//#UC END# *4B14F21C029D_4B14F1AB03A0_impl*
end;//TnsUserOperationEvent.Log

class function TnsUserOperationEvent.Exists: Boolean;
 {-}
begin
 Result := g_TnsUserOperationEvent <> nil;
end;//TnsUserOperationEvent.Exists

procedure TnsUserOperationEvent.DoFireLog;
//#UC START# *4B13A1F202D9_4B14F1AB03A0_var*
var
 l_Data: InsLogEventData;
 l_NeedWrite: Boolean;
 l_IDX: TvcmOperationCallType;
//#UC END# *4B13A1F202D9_4B14F1AB03A0_var*
begin
//#UC START# *4B13A1F202D9_4B14F1AB03A0_impl*
 l_Data := MakeParamsList;
 l_NeedWrite := False;
 for l_IDX := Low(f_COunters) to High(f_Counters) do
 begin
  l_Data.AddULong(f_Counters[l_IDX]);
  if f_Counters[l_IDX] > 0 then
  begin
   f_Counters[l_IDX] := 0;
   l_NeedWrite := True;
  end;
 end;
 if l_NeedWrite then
  GetLogger.AddEvent(LE_USER_OPERATION, l_Data);
//#UC END# *4B13A1F202D9_4B14F1AB03A0_impl*
end;//TnsUserOperationEvent.DoFireLog

class procedure TPrimF1Res.InitDefaults;
//#UC START# *4AA7BAF10057_4A92BBDF0126_var*
//#UC END# *4AA7BAF10057_4A92BBDF0126_var*
begin
//#UC START# *4AA7BAF10057_4A92BBDF0126_impl*
 // Разделитель, для формирования пути сохранения в настройки
 g_afwPathSep := PROPERTY_PATH_DELIMITER;
 // make memory manager thread safe
 IsMultiThread := True;
 //
 g_vcmHistoryLimit := 10;
 g_evDocumentsCacheLimit := 15;
 //
 with Application do
  if (Handle <> HWND(0)) then
   SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or
     WS_EX_TOOLWINDOW);
     
  Application.HintHidePause := 15000; // Время показа хинтов в системе
//#UC END# *4AA7BAF10057_4A92BBDF0126_impl*
end;//TPrimF1Res.InitDefaults

class function TPrimF1Res.CanRun(aLogo: TCustomForm): Boolean;
//#UC START# *4AA7D40B02F4_4A92BBDF0126_var*
//#UC END# *4AA7D40B02F4_4A92BBDF0126_var*
begin
//#UC START# *4AA7D40B02F4_4A92BBDF0126_impl*
 Result := true;
 if nsIsOtherPrimeOrShellRunning(aLogo) then
  Result := false
 else
  nsCheckRequiredFonts(aLogo);
//#UC END# *4AA7D40B02F4_4A92BBDF0126_impl*
end;//TPrimF1Res.CanRun

class function TPrimF1Res.GlobalInit(aLogo: TCustomForm;
  var theSplash: IUnknown): Boolean;
//#UC START# *4AA7DDA90337_4A92BBDF0126_var*
//#UC END# *4AA7DDA90337_4A92BBDF0126_var*
begin
//#UC START# *4AA7DDA90337_4A92BBDF0126_impl*
  Result := DoGlobalInit(aLogo, theSplash);
  Application.Initialize;
  SPCorrectHelpFileName;
//#UC END# *4AA7DDA90337_4A92BBDF0126_impl*
end;//TPrimF1Res.GlobalInit

class function TPrimF1Res.RunOtherProcesses: Boolean;
//#UC START# *4AA7C28A0113_4A92BBDF0126_var*
//#UC END# *4AA7C28A0113_4A92BBDF0126_var*
begin
//#UC START# *4AA7C28A0113_4A92BBDF0126_impl*
 Result := true;
 with TnsStartupSupport do
 begin
  repeat
   StartupPendingNotify;
   if (TryUnlockLogin or TrySwitchToOtherRunningCopy) then
   begin
    StartupCompletedNotify;
    Result := false;
    Exit;
   end;//TryUnlockLogin or TrySwitchToOtherRunningCopy
   StartupCompletedNotify;
  until (CheckAndCreateRunningCopyMutex);
  StartupPendingNotify;
 end;//with TnsStartupSupport
//#UC END# *4AA7C28A0113_4A92BBDF0126_impl*
end;//TPrimF1Res.RunOtherProcesses

class function TPrimF1Res.DoGlobalInit(aLogo: TCustomForm;
  var theSplash: IUnknown): Boolean;
//#UC START# *4AA7D7CA00FE_4A92BBDF0126_var*
//#UC END# *4AA7D7CA00FE_4A92BBDF0126_var*
begin
//#UC START# *4AA7D7CA00FE_4A92BBDF0126_impl*
 Result := true;
 try
  DataAdapter.GlobalInit(aLogo, afw.Application.LocaleInfo.Name);
  {$IfDef Monitorings}
  if not defDataAdapter.Monitoring.IsExist then
  begin
   aLogo.Hide;
   defDataAdapter.ShowMessageWithDealerInfo(err_PrimeNotAvaliable);
   Result := false;
   Exit;
  end;//not defDataAdapter.Monitoring.IsExist
  {$EndIf Monitorings}
 except
  on EAbort do
  begin
   l3System.CheckClipboard;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=121145106
   Result := false;
   Exit;
   // здесь нужно именно так, чтобы выполнились все секции финализации (в частности те, которые удаляют временные файлы)
  end;//on EAbort
  on ECorbaException do
  begin
   aLogo.Hide;
   Application.HandleException(nil);
   TerminateProcess(GetCurrentProcess, 255);
  end;//on ECorbaException
  else
  begin
   aLogo.Hide;
   theSplash := nil;
   TerminateProcess(GetCurrentProcess, 255);
  end;
 end;//try..except
//#UC END# *4AA7D7CA00FE_4A92BBDF0126_impl*
end;//TPrimF1Res.DoGlobalInit

class procedure TPrimF1Res.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4A92BBDF0126_var*
//#UC END# *4AA7E4DC0047_4A92BBDF0126_var*
begin
//#UC START# *4AA7E4DC0047_4A92BBDF0126_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4AA7E4DC0047_4A92BBDF0126_impl*
end;//TPrimF1Res.DoRun

{$If not defined(Admin)}
class procedure TPrimF1Res.OpenQuery(aQueryType: TlgQueryType;
  const aQuery: IQuery;
  const aContainer: IvcmContainer);
//#UC START# *4AC4A69D03B7_4A92BBDF0126_var*
//#UC END# *4AC4A69D03B7_4A92BBDF0126_var*
begin
//#UC START# *4AC4A69D03B7_4A92BBDF0126_impl*
 Assert(false);
//#UC END# *4AC4A69D03B7_4A92BBDF0126_impl*
end;//TPrimF1Res.OpenQuery
{$IfEnd} //not Admin

class procedure TPrimF1Res.LogUserActivity(aKind: TvcmOperationCallType);
//#UC START# *4B14F1720053_4A92BBDF0126_var*
//#UC END# *4B14F1720053_4A92BBDF0126_var*
begin
//#UC START# *4B14F1720053_4A92BBDF0126_impl*
 {$if not defined(Monitorings)}
 TnsUserOperationEvent.Instance.Log(aKind);
 {$ifend}
//#UC END# *4B14F1720053_4A92BBDF0126_impl*
end;//TPrimF1Res.LogUserActivity

{$If not defined(NoVCM)}
class procedure TPrimF1Res.Runner(const aTitle: Tl3StringIDEx;
  const aHelpFile: AnsiString);
//#UC START# *4F6AF5860291_4A92BBDF0126_var*
var
 l_Splash : IUnknown;
 l_Logo : TLogoForm;
//#UC END# *4F6AF5860291_4A92BBDF0126_var*
begin
//#UC START# *4F6AF5860291_4A92BBDF0126_impl*
 //l3SysUtils.ImmDisableIME;
 InitDefaults;
 if not RunOtherProcesses then
  Exit;

 // Создаем форму с заставкой:
 l_Logo := TLogoForm.Create(nil);
 try
  l_Logo.UpdateLoadString(str_ApplicationLoading.AsCStr);
  {$IFDEF DEBUG}
  l_Logo.UpdateVerInfo(str_FullVersionMessage.AsCStr);
  {$ENDIF}
  l_Logo.Show;
  afw.ProcessMessages;

  // это надо здесь ! {
  MakeResources;
  // } это надо здесь !

  if not CanRun(l_Logo) then
   Exit;

  Application.HelpFile := aHelpFile;
  Application.Title := aTitle.AsStr;
  // это надо здесь! Иначе для форм логина/регистрации/.. хелп работать не будт
  TnsAppTitleData.Instance.Title := aTitle.AsStr;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=562594453
  if not GlobalInit(l_Logo, l_Splash) then
   Exit;
  try
   TnsContextFilterEventListener.Instance;
   DoRun(l_Splash);
   BeforeApplicationRun;
  except
   on E: ENoServer do
   begin
    if Assigned(l_Logo) then
      l_Logo.Hide;
    l_Splash := nil;
    TerminateProcess(GetCurrentProcess, 255);
   end;
   on E: Exception do
    defDataAdapter.GlobalExceptionRaised(nil, E);
  end;//try..except
 finally
  FreeAndNil(l_Logo);
 end;//try..finally

 TnsStartupSupport.StartupCompletedNotify;
 Tf1StartupCompletedService.Instance.StartupComplete;
 Application.Run;
//#UC END# *4F6AF5860291_4A92BBDF0126_impl*
end;//TPrimF1Res.Runner
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
class procedure TPrimF1Res.MakeResources;
//#UC START# *4F6AF5F00058_4A92BBDF0126_var*
//#UC END# *4F6AF5F00058_4A92BBDF0126_var*
begin
//#UC START# *4F6AF5F00058_4A92BBDF0126_impl*
 inherited;
//#UC END# *4F6AF5F00058_4A92BBDF0126_impl*
end;//TPrimF1Res.MakeResources
{$IfEnd} //not NoVCM

procedure TPrimF1Res.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TPrimF1Res.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_LiteSearch);
 aMain.RegisterModule(Tmo_RealCommon);
end;

var
 g_opcode_Result_Ok : TvcmOpID;
 g_opcode_Tree_ExpandAll : TvcmOpID;
 g_opcode_Tree_CollapseAll : TvcmOpID;
 g_opcode_Tree_Wrap : TvcmOpID;
 g_opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
 g_opcode_AttributeTree_SetCurrent : TvcmOpID;
 g_opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
 g_opcode_AttributeTree_Invalidate : TvcmOpID;
 g_opcode_AttributeTree_DropLogicSelection : TvcmOpID;
 g_opcode_AttributeTree_LoadQuery : TvcmOpID;
 g_opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
 g_opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
 g_opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
 g_opcode_SearchParameters_GetQuery : TvcmOpID;
 g_opcode_SearchParameters_IsQuerySaved : TvcmOpID;
 g_opcode_SearchParameters_SetQuery : TvcmOpID;
 g_opcode_SearchParameters_ClearQuery : TvcmOpID;
 g_opcode_AttributeTree_SaveToQuery : TvcmOpID;
 g_opcode_Attribute_DefaultAction : TvcmOpID;
 g_opcode_Attribute_LogicOr : TvcmOpID;
 g_opcode_Attribute_LogicAnd : TvcmOpID;
 g_opcode_Attribute_LogicNot : TvcmOpID;
 g_opcode_Attribute_LogicOrShortcut : TvcmOpID;
 g_opcode_Context_SetContext : TvcmOpID;
 g_opcode_Context_SyncContextParams : TvcmOpID;
 g_opcode_AttributeTree_SetRoot : TvcmOpID;
 g_opcode_AttributeTree_ChangeRoot : TvcmOpID;
 g_opcode_AttributeTree_SetParent : TvcmOpID;
 g_opcode_AttributeTree_ExtSetRoot : TvcmOpID;
 g_opcode_ContextParams_ContextChanged : TvcmOpID;
 g_opcode_Result_OkExt : TvcmOpID;
 g_opcode_Result_Cancel : TvcmOpID;
 g_opcode_SelectedList_RefreshValues : TvcmOpID;
 g_opcode_System_InitShutdown : TvcmOpID;

procedure TPrimF1Res.Loaded;
begin
 inherited;
 PublishModule(Tmo_LiteSearch, '');
 PublishModule(Tmo_RealCommon, '');
 PublishOperation(en_Help,
                    op_HelpTopics,
                    en_capHelp,
                    op_capHelpTopics);
 PublishOperation(en_Edit,
                    op_Delete,
                    en_capEdit,
                    op_capDelete);
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Controlled') do
  begin
   st_user_Edit_Delete_Controlled := StateIndex;
   Caption := 'Снять с контроля';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Controlled')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'User') do
  begin
   st_user_Edit_Delete_User := StateIndex;
   Caption := 'Удалить пользователя';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'User')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'MultiUsers') do
  begin
   st_user_Edit_Delete_MultiUsers := StateIndex;
   Caption := 'Удалить выделенных пользователей';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'MultiUsers')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Group') do
  begin
   st_user_Edit_Delete_Group := StateIndex;
   Caption := 'Удалить группу';
   ImageIndex := 193;
  end;//with PublishOperationState(en_Edit, op_Delete, 'Group')
 {$IfEnd} //Admin AND not NoVCM
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Contact') do
  begin
   st_user_Edit_Delete_Contact := StateIndex;
   Caption := 'Удалить пользователя';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Contact')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 PublishOperation(en_Edit,
                    op_Copy,
                    en_capEdit,
                    op_capCopy);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy') do
  begin
   st_user_Edit_Copy_AttributesCopy := StateIndex;
   Caption := 'Копировать все атрибуты документа в буфер обмена';
  end;//with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Edit,
                    op_Cut,
                    en_capEdit,
                    op_capCut);
 PublishOperation(en_Edit,
                    op_FindContext,
                    en_capEdit,
                    op_capFindContext);
 PublishOperation(en_Edit,
                    op_FindNext,
                    en_capEdit,
                    op_capFindNext);
 PublishOperation(en_Edit,
                    op_Paste,
                    en_capEdit,
                    op_capPaste);
 PublishOperation(en_Edit,
                    op_Undo,
                    en_capEdit,
                    op_capUndo);
 PublishOperation(en_Edit,
                    op_Redo,
                    en_capEdit,
                    op_capRedo);
 PublishOperation(en_Edit,
                    op_SelectAll,
                    en_capEdit,
                    op_capSelectAll);
 PublishOperation(en_Edit,
                    op_Deselect,
                    en_capEdit,
                    op_capDeselect);
 PublishOperation(en_Edit,
                    op_FindPrev,
                    en_capEdit,
                    op_capFindPrev);
 g_opcode_Result_Ok :=
  PublishOperation(en_Result,
                    op_Ok,
                    en_capResult,
                    op_capOk);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Search') do
  begin
   st_user_Result_Ok_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_Ok, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Print') do
  begin
   st_user_Result_Ok_Print := StateIndex;
   Caption := 'Печать';
   ImageIndex := 3;
  end;//with PublishOperationState(en_Result, op_Ok, 'Print')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'AttributesSelect') do
  begin
   st_user_Result_Ok_AttributesSelect := StateIndex;
   Caption := 'Подтвердить выбор элементов';
  end;//with PublishOperationState(en_Result, op_Ok, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'ConsultationMark') do
  begin
   st_user_Result_Ok_ConsultationMark := StateIndex;
   Caption := 'Оценить';
  end;//with PublishOperationState(en_Result, op_Ok, 'ConsultationMark')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Analize') do
  begin
   st_user_Result_Ok_Analize := StateIndex;
   Caption := 'Построить';
  end;//with PublishOperationState(en_Result, op_Ok, 'Analize')
 {$IfEnd} //not NoVCM
 g_opcode_Tree_ExpandAll :=
  PublishOperation(en_Tree,
                    op_ExpandAll,
                    en_capTree,
                    op_capExpandAll);
 g_opcode_Tree_CollapseAll :=
  PublishOperation(en_Tree,
                    op_CollapseAll,
                    en_capTree,
                    op_capCollapseAll);
 g_opcode_Tree_Wrap :=
  PublishOperation(en_Tree,
                    op_Wrap,
                    en_capTree,
                    op_capWrap);
 PublishOperation(en_Selection,
                    op_DropSelection,
                    en_capSelection,
                    op_capDropSelection);
 g_opcode_AttributeTree_ExternalCharPressed :=
  PublishInternalOperation(en_AttributeTree,
                    op_ExternalCharPressed,
                    en_capAttributeTree,
                    op_capExternalCharPressed);
 g_opcode_AttributeTree_SetCurrent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetCurrent,
                    en_capAttributeTree,
                    op_capSetCurrent);
 g_opcode_AttributeTree_DropAllLogicSelection :=
  PublishInternalOperation(en_AttributeTree,
                    op_DropAllLogicSelection,
                    en_capAttributeTree,
                    op_capDropAllLogicSelection);
 g_opcode_AttributeTree_Invalidate :=
  PublishInternalOperation(en_AttributeTree,
                    op_Invalidate,
                    en_capAttributeTree,
                    op_capInvalidate);
 g_opcode_AttributeTree_DropLogicSelection :=
  PublishInternalOperation(en_AttributeTree,
                    op_DropLogicSelection,
                    en_capAttributeTree,
                    op_capDropLogicSelection);
 g_opcode_AttributeTree_LoadQuery :=
  PublishInternalOperation(en_AttributeTree,
                    op_LoadQuery,
                    en_capAttributeTree,
                    op_capLoadQuery);
 g_opcode_AttributeTree_SetOneLevelCurrent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetOneLevelCurrent,
                    en_capAttributeTree,
                    op_capSetOneLevelCurrent);
 g_opcode_AttributeTree_AddNodeIfEmpty :=
  PublishInternalOperation(en_AttributeTree,
                    op_AddNodeIfEmpty,
                    en_capAttributeTree,
                    op_capAddNodeIfEmpty);
 g_opcode_SearchParameters_IsQueryEmpty :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQueryEmpty,
                    en_capSearchParameters,
                    op_capIsQueryEmpty);
 g_opcode_SearchParameters_GetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_GetQuery,
                    en_capSearchParameters,
                    op_capGetQuery);
 g_opcode_SearchParameters_IsQuerySaved :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQuerySaved,
                    en_capSearchParameters,
                    op_capIsQuerySaved);
 g_opcode_SearchParameters_SetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_SetQuery,
                    en_capSearchParameters,
                    op_capSetQuery);
 g_opcode_SearchParameters_ClearQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_ClearQuery,
                    en_capSearchParameters,
                    op_capClearQuery);
 g_opcode_AttributeTree_SaveToQuery :=
  PublishInternalOperation(en_AttributeTree,
                    op_SaveToQuery,
                    en_capAttributeTree,
                    op_capSaveToQuery);
 g_opcode_Attribute_DefaultAction :=
  PublishInternalOperation(en_Attribute,
                    op_DefaultAction,
                    en_capAttribute,
                    op_capDefaultAction);
 g_opcode_Attribute_LogicOr :=
  PublishOperation(en_Attribute,
                    op_LogicOr,
                    en_capAttribute,
                    op_capLogicOr);
 g_opcode_Attribute_LogicAnd :=
  PublishOperation(en_Attribute,
                    op_LogicAnd,
                    en_capAttribute,
                    op_capLogicAnd);
 g_opcode_Attribute_LogicNot :=
  PublishOperation(en_Attribute,
                    op_LogicNot,
                    en_capAttribute,
                    op_capLogicNot);
 g_opcode_Attribute_LogicOrShortcut :=
  PublishOperation(en_Attribute,
                    op_LogicOrShortcut,
                    en_capAttribute,
                    op_capLogicOrShortcut);
 g_opcode_Context_SetContext :=
  PublishInternalOperation(en_Context,
                    op_SetContext,
                    en_capContext,
                    op_capSetContext);
 g_opcode_Context_SyncContextParams :=
  PublishInternalOperation(en_Context,
                    op_SyncContextParams,
                    en_capContext,
                    op_capSyncContextParams);
 g_opcode_AttributeTree_SetRoot :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetRoot,
                    en_capAttributeTree,
                    op_capSetRoot);
 g_opcode_AttributeTree_ChangeRoot :=
  PublishInternalOperation(en_AttributeTree,
                    op_ChangeRoot,
                    en_capAttributeTree,
                    op_capChangeRoot);
 PublishOperation(en_Folder,
                    op_FindFirstSelected,
                    en_capFolder,
                    op_capFindFirstSelected);
 g_opcode_AttributeTree_SetParent :=
  PublishInternalOperation(en_AttributeTree,
                    op_SetParent,
                    en_capAttributeTree,
                    op_capSetParent);
 g_opcode_AttributeTree_ExtSetRoot :=
  PublishInternalOperation(en_AttributeTree,
                    op_ExtSetRoot,
                    en_capAttributeTree,
                    op_capExtSetRoot);
 g_opcode_ContextParams_ContextChanged :=
  PublishInternalOperation(en_ContextParams,
                    op_ContextChanged,
                    en_capContextParams,
                    op_capContextChanged);
 g_opcode_Result_OkExt :=
  PublishOperation(en_Result,
                    op_OkExt,
                    en_capResult,
                    op_capOkExt);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Search') do
  begin
   st_user_Result_OkExt_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Save') do
  begin
   st_user_Result_OkExt_Save := StateIndex;
   Caption := 'Сохранить';
   Hint := 'Сохранить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Save')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect') do
  begin
   st_user_Result_OkExt_AttributesSelect := StateIndex;
  end;//with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Consult') do
  begin
   st_user_Result_OkExt_Consult := StateIndex;
   Caption := 'Отправить запрос';
   ImageIndex := 154;
  end;//with PublishOperationState(en_Result, op_OkExt, 'Consult')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Chat') do
  begin
   st_user_Result_OkExt_Chat := StateIndex;
   Caption := 'Отправить (Ctrl+Enter)';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Chat')
 {$IfEnd} //not NoVCM
 {$If not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend') do
  begin
   st_user_Result_OkExt_SaveAndSend := StateIndex;
   Caption := 'Сохранить и отправить';
   Hint := 'Сохранить и отправить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend')
 {$IfEnd} //not Monitorings AND not NoVCM
 g_opcode_Result_Cancel :=
  PublishOperation(en_Result,
                    op_Cancel,
                    en_capResult,
                    op_capCancel);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Cancel, 'Close') do
  begin
   st_user_Result_Cancel_Close := StateIndex;
   Caption := 'Закрыть';
  end;//with PublishOperationState(en_Result, op_Cancel, 'Close')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Result,
                    op_ClearAll,
                    en_capResult,
                    op_capClearAll);
 g_opcode_SelectedList_RefreshValues :=
  PublishInternalOperation(en_SelectedList,
                    op_RefreshValues,
                    en_capSelectedList,
                    op_capRefreshValues);
 g_opcode_System_InitShutdown :=
  PublishInternalOperation(en_System,
                    op_InitShutdown,
                    en_capSystem,
                    op_capInitShutdown);
end;

// modules operations

class function TPrimF1Res.MakeTreeAttributeSelect(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TLiteSearchModule.MakeTreeAttributeSelect(aParams, aZoneType, aRecursive, aUserType);
end;

class function TPrimF1Res.MakeAttributeSelect(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TLiteSearchModule.MakeAttributeSelect(aParams, aZoneType, aRecursive, aUserType);
end;

class function TPrimF1Res.MakeSelectedAttributes(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean): IvcmEntityForm;
begin
 Result := TLiteSearchModule.MakeSelectedAttributes(aParams, aZoneType, aRecursive);
end;

class function TPrimF1Res.OpenTreeSelection(const aTag: Il3CString;
  anAdditionalFilter: TnsFilterType;
  const aFormData: IdsTreeAttributeSelect): Integer;
begin
 Result := TLiteSearchModule.OpenTreeSelection(aTag, anAdditionalFilter, aFormData);
end;

class function TPrimF1Res.MakeUpdateMessage: IvcmEntityForm;
begin
 Result := TPrimCommonModule.MakeUpdateMessage;
end;

class function TPrimF1Res.MakeShutdownWindow(aCloseInterval: LongWord;
  aKind: TShutdownWarningKind): IvcmEntityForm;
begin
 Result := TPrimCommonModule.MakeShutdownWindow(aCloseInterval, aKind);
end;

// operations codes

class function TPrimF1Res.opcode_Result_Ok : TvcmOpID;
begin
 Result := g_opcode_Result_Ok;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Tree_ExpandAll : TvcmOpID;
begin
 Result := g_opcode_Tree_ExpandAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Tree_CollapseAll : TvcmOpID;
begin
 Result := g_opcode_Tree_CollapseAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Tree_Wrap : TvcmOpID;
begin
 Result := g_opcode_Tree_Wrap;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_ExternalCharPressed : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_ExternalCharPressed;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_SetCurrent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_DropAllLogicSelection : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_DropAllLogicSelection;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_Invalidate : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_Invalidate;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_DropLogicSelection : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_DropLogicSelection;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_LoadQuery : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_LoadQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_SetOneLevelCurrent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetOneLevelCurrent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_AddNodeIfEmpty : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_AddNodeIfEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQueryEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SearchParameters_GetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_GetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SearchParameters_IsQuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SearchParameters_SetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_SetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SearchParameters_ClearQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_ClearQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_SaveToQuery : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SaveToQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Attribute_DefaultAction : TvcmOpID;
begin
 Result := g_opcode_Attribute_DefaultAction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Attribute_LogicOr : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOr;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Attribute_LogicAnd : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicAnd;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Attribute_LogicNot : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicNot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Attribute_LogicOrShortcut : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOrShortcut;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Context_SetContext : TvcmOpID;
begin
 Result := g_opcode_Context_SetContext;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Context_SyncContextParams : TvcmOpID;
begin
 Result := g_opcode_Context_SyncContextParams;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_SetRoot : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_ChangeRoot : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_ChangeRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_SetParent : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_SetParent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_AttributeTree_ExtSetRoot : TvcmOpID;
begin
 Result := g_opcode_AttributeTree_ExtSetRoot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_ContextParams_ContextChanged : TvcmOpID;
begin
 Result := g_opcode_ContextParams_ContextChanged;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Result_OkExt : TvcmOpID;
begin
 Result := g_opcode_Result_OkExt;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_Result_Cancel : TvcmOpID;
begin
 Result := g_opcode_Result_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_SelectedList_RefreshValues : TvcmOpID;
begin
 Result := g_opcode_SelectedList_RefreshValues;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TPrimF1Res.opcode_System_InitShutdown : TvcmOpID;
begin
 Result := g_opcode_System_InitShutdown;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

initialization
// Инициализация str_ApplicationLoading
 str_ApplicationLoading.Init;
// Инициализация str_FullVersionMessage
 str_FullVersionMessage.Init;
// Инициализация str_NemesisTitle
 str_NemesisTitle.Init;

end.