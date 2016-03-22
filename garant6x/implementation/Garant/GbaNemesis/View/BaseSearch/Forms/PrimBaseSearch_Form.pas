unit PrimBaseSearch_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/PrimBaseSearch_Form.pas"
// Начат: 21.09.2009 18:43
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::PrimBaseSearch
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  ,
  BaseSearchInterfaces,
  nsCounterEvent,
  l3StringIDEx,
  BaseSearch_Controls
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistoryAndOperations
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nsNotificationManager,
  ContextHistoryInterfaces,
  l3TabbedContainersDispatcher,
  Graphics,
  l3Region,
  LoggingUnit,
  PrimBaseSearch_BaseSearch_UserType,
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsBaseSearchFormState = interface(IUnknown{, IvcmBase, Данный выбор не запоминается, когда мы сами инициируем вызов "Основного Меню", При хождении по истории выбор должен восстанавливаться})
  {* Состояние формы "Базоывый поиск" }
   ['{239F47AA-B37E-447C-BE52-E487DE8A8397}']
   function Get_ActiveClass: InsBaseSearchClass;
   function Get_Data: InsBaseSearcherWindowData;
   property ActiveClass: InsBaseSearchClass
     read Get_ActiveClass;
   property Data: InsBaseSearcherWindowData
     read Get_Data;
  // Методы преобразования к реализуемым интерфейсам
   function As_IvcmBase: IvcmBase;
 end;//InsBaseSearchFormState

 TnsUseBaseSearchExampleEvent = class(TnsCounterEvent)
 protected
 // realized methods
   function EventID: TLogEvent; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUseBaseSearchExampleEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUseBaseSearchExampleEvent

 TnsUseBaseSearchHintEvent = class(TnsCounterEvent)
 protected
 // realized methods
   function EventID: TLogEvent; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUseBaseSearchHintEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUseBaseSearchHintEvent

 TnsUseBackSearchButtonEvent = class(TnsCounterEvent)
 protected
 // realized methods
   function EventID: TLogEvent; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsUseBackSearchButtonEvent;
    {- возвращает экземпляр синглетона. }
 end;//TnsUseBackSearchButtonEvent

 _BaseSearch2010_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\BaseSearch2010.imp.pas}
 TPrimBaseSearchForm = {form} class(_BaseSearch2010_, InsSearchWindow, InsContextSearchHistoryNotifier {$If not defined(NoVCM)}, IvcmLockListener{$IfEnd} //not NoVCM
 , InsNotificationListener, Il3TabbedContainersListener)
 private
 // private fields
   f_InCreate : Boolean;
   f_ContextHistory : InsContextSearchHistory;
   f_NeedParamsChanged : Boolean;
   f_NeedPresentationChanged : Boolean;
   f_FlashCounter : Integer;
   f_IsTabActive : Boolean;
    {* активна ли вкладка, на которой лежит форма}
   f_ControlToActivate : TWinControl;
    {* контрол, в который надо установить фокус при переходе на вкладку}
   f_IsActive : Boolean;
   f_ContextEdit : TnscTreeComboWithHistoryAndOperations;
    {* Поле для свойства ContextEdit}
   f_FlashTimer : TTimer;
    {* Поле для свойства FlashTimer}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure AfterSearcherSet;
     {* Сигнатура метода AfterSearcherSet }
   function MainMenuLikeBaseSearch: Boolean;
   procedure CMVisibleChanged(var Msg: TMessage); message CM_VISIBLECHANGED;
 protected
 // property methods
   function pm_GetContextEdit: TnscTreeComboWithHistoryAndOperations;
   procedure pm_SetFindBtnEnabled(aValue: Boolean); virtual; abstract;
   procedure pm_SetFindBackBtnEnabled(aValue: Boolean); virtual; abstract;
   function pm_GetContextLabelVisible: Boolean; virtual; abstract;
   procedure pm_SetContextLabelVisible(aValue: Boolean); virtual; abstract;
   function pm_GetCloseBtnEnabled: Boolean; virtual; abstract;
   procedure pm_SetCloseBtnEnabled(aValue: Boolean); virtual; abstract;
 protected
 // realized methods
   procedure ParamsChanged;
   procedure PresentationChanged;
   procedure ExampleChanged;
   procedure CheckFindEnabled;
   procedure ClassNamesChanged;
   procedure CloseWindow;
   procedure ActivateWindow(aNeedFlash: Boolean = True);
   procedure HistoryChanged(const aNewHistory: IvcmStrings);
   procedure ContextSearched;
     {$If not defined(NoVCM)}
   procedure Lock;
     {* отрисовка запрещена }
     {$IfEnd} //not NoVCM
     {$If not defined(NoVCM)}
   procedure BeforeUnlock;
     {* переходные процессы уже завершились, но отрисовка ещё запрещена }
     {$IfEnd} //not NoVCM
     {$If not defined(NoVCM)}
   procedure Unlock;
     {* отрисовка разрешена }
     {$IfEnd} //not NoVCM
   procedure CheckFragmentsCount;
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   function Get_Container: IvcmContainer;
   procedure EnclosedForms_CloseChild_Test(const aParams: IvcmTestParamsPrim);
   procedure EnclosedForms_CloseChild_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure NsNotification(aType: TnsNotificationType);
   procedure ForceUpdateClassForHistory;
   procedure NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
   function pm_GetIsActive: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure BecomeActive; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure BecomeInactive; override;
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure CreateFormGUID(var theGUID: TGUID); override;
     {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
    {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
    {$If not defined(NoVCM)}
   function DoGetNeedSaveToTabHistory: Boolean; override;
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function NeedDrawCaption: Boolean; override;
     {* Нужно ли рисовать заголовок зоны }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   f_BaseSearcher : InsBaseSearcher{WindowData};
   f_LockParamsChange : Integer;
   f_ActiveClassForSaveInHistory : InsBaseSearchClass;
 protected
 // protected methods
   procedure ApplyCurrentExample; virtual;
     {* Сигнатура метода ApplyCurrentExample }
   procedure UnregisterFromSearcher;
     {* Сигнатура метода UnregisterFromSearcher }
   procedure DoFindBtnClick;
     {* Сигнатура метода DoFindBtnClick }
   procedure SearchByContext(const aClassToSaveInHistory: InsBaseSearchClass;
     aNeedUpdateAndStoreActiveClass: Boolean;
     aUpdateClassBeforeSearch: Boolean);
   procedure ContextEditPastingString(Sender: TObject;
     var aText: Il3CString);
   procedure StopFlash;
   procedure UpdateSearcherContext;
   procedure ContextEditChange(Sender: TObject);
   procedure CheckParamsPagesCount(aCount: Integer); virtual; abstract;
   procedure SetCurrentContextKind(aKind: TnsBaseSearchKind); virtual; abstract;
   procedure FlashTimerTimer(Sender: TObject);
   procedure ChangeFlash;
   procedure StartFlash;
   procedure ContextEditSelect(Sender: TObject);
   procedure DoCloseBtnClick;
     {* Сигнатура метода DoCloseBtnClick }
   procedure SetCurrentSearchArea(anArea: TnsSearchArea); virtual; abstract;
   procedure SetupThemePages; virtual; abstract;
   procedure DoCheckFragmentsCount(const aFragmentsCountSuffix: Il3CString); virtual; abstract;
   procedure DoExampleChanged(const anExampleText: Il3CString); virtual; abstract;
   procedure UpdateSearcherArea(anArea: TnsSearchArea;
     anKind: TnsBaseSearchKind);
   procedure DoFindBackBtnClick;
     {* Сигнатура метода DoFindBackBtnClick }
   procedure AdjustParamsPagesHeight; virtual; abstract;
   procedure SetUpFindButtons; virtual; abstract;
   procedure SetupClasses(aFromUpdate: Boolean); virtual; abstract;
   procedure UpdateExamplePanelWidthAndPosition; virtual; abstract;
 public
 // public methods
   class function MakeSingleChild(const aData: InsBaseSearcherWindowData;
    const aCont   : IvcmContainer;
    const anAgg   : IvcmAggregate;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 protected
 // protected properties
   property FindBtnEnabled: Boolean
     write pm_SetFindBtnEnabled;
   property FindBackBtnEnabled: Boolean
     write pm_SetFindBackBtnEnabled;
   property ContextLabelVisible: Boolean
     read pm_GetContextLabelVisible
     write pm_SetContextLabelVisible;
   property CloseBtnEnabled: Boolean
     read pm_GetCloseBtnEnabled
     write pm_SetCloseBtnEnabled;
 public
 // public properties
   property ContextEdit: TnscTreeComboWithHistoryAndOperations
     read pm_GetContextEdit;
   property FlashTimer: TTimer
     read f_FlashTimer;
 end;//TPrimBaseSearchForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  afwFacade,
  l3Base {a},
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces,
  l3Chars,
  SysUtils,
  nsContextHistory,
  l3String,
  nsTypes,
  nsQuery
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  l3Const
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Common_FormDefinitions_Controls,
  nsBaseSearchFormGUIDFactory
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerForm
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  nsSearchWindowManager,
  nsBaseSearchService,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Units,
  nsConst
  {$If not defined(NoVCL)}
  ,
  Themes
  {$IfEnd} //not NoVCL
  ,
  Windows,
  afwInterfaces,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TPrimBaseSearchForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\BaseSearch2010.imp.pas}

const
   { Const }
  cMaxLen = 300;
  c_FlashTimes = 2;

var
   { Локализуемые строки BaseSearchLocalConstants }
  str_BaseSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'BaseSearchCaption'; rValue : 'Базовый поиск');
   { Заголовок пользовательского типа "Базовый поиск" }

type
  _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
  TnsBaseSearchFormState = class(_afwApplicationDataUpdate_, InsBaseSearchFormState, IvcmBase {from InsBaseSearchFormState})
  private
  // private fields
   f_ActiveClass : InsBaseSearchClass;
   f_Data : InsBaseSearcherWindowData;
  protected
  // realized methods
   function Get_Data: InsBaseSearcherWindowData;
   function Get_ActiveClass: InsBaseSearchClass;
  protected
  // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
  public
  // public methods
   constructor Create(const aData: InsBaseSearcherWindowData;
      const anActiveClass: InsBaseSearchClass); reintroduce;
   class function Make(const aData: InsBaseSearcherWindowData;
      const anActiveClass: InsBaseSearchClass): InsBaseSearchFormState; reintroduce;
     {* Сигнатура фабрики TnsBaseSearchFormState.Make }
  protected
  // Методы преобразования к реализуемым интерфейсам
   function As_IvcmBase: IvcmBase;
  end;//TnsBaseSearchFormState

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TnsBaseSearchFormState

constructor TnsBaseSearchFormState.Create(const aData: InsBaseSearcherWindowData;
  const anActiveClass: InsBaseSearchClass);
//#UC START# *4CF4F8470359_4ACB57C4023E_var*
//#UC END# *4CF4F8470359_4ACB57C4023E_var*
begin
//#UC START# *4CF4F8470359_4ACB57C4023E_impl*
 inherited Create;
 Assert(aData <> nil);
 f_Data := aData;
 Assert(anActiveClass <> nil);
 f_ActiveClass := anActiveClass;
 //f_ActiveClass := f_Data.ActiveClassForSaveState{ActiveClass};
//#UC END# *4CF4F8470359_4ACB57C4023E_impl*
end;//TnsBaseSearchFormState.Create

class function TnsBaseSearchFormState.Make(const aData: InsBaseSearcherWindowData;
  const anActiveClass: InsBaseSearchClass): InsBaseSearchFormState;
var
 l_Inst : TnsBaseSearchFormState;
begin
 l_Inst := Create(aData, anActiveClass);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsBaseSearchFormState.Get_Data: InsBaseSearcherWindowData;
//#UC START# *4ACB5763027B_4ACB57C4023Eget_var*
//#UC END# *4ACB5763027B_4ACB57C4023Eget_var*
begin
//#UC START# *4ACB5763027B_4ACB57C4023Eget_impl*
 Result := f_Data;
//#UC END# *4ACB5763027B_4ACB57C4023Eget_impl*
end;//TnsBaseSearchFormState.Get_Data

function TnsBaseSearchFormState.Get_ActiveClass: InsBaseSearchClass;
//#UC START# *4EB7CC550343_4ACB57C4023Eget_var*
//#UC END# *4EB7CC550343_4ACB57C4023Eget_var*
begin
//#UC START# *4EB7CC550343_4ACB57C4023Eget_impl*
 Result := f_ActiveClass;
//#UC END# *4EB7CC550343_4ACB57C4023Eget_impl*
end;//TnsBaseSearchFormState.Get_ActiveClass

procedure TnsBaseSearchFormState.Cleanup;
//#UC START# *479731C50290_4ACB57C4023E_var*
//#UC END# *479731C50290_4ACB57C4023E_var*
begin
//#UC START# *479731C50290_4ACB57C4023E_impl*
 f_Data := nil;
 inherited;
//#UC END# *479731C50290_4ACB57C4023E_impl*
end;//TnsBaseSearchFormState.Cleanup

procedure TnsBaseSearchFormState.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4ACB57C4023E_var*
//#UC END# *47EA4E9002C6_4ACB57C4023E_var*
begin
//#UC START# *47EA4E9002C6_4ACB57C4023E_impl*
 inherited;
 f_ActiveClass := nil;
 // - отпускаем, иначе адаптер/сервер расстроятся
//#UC END# *47EA4E9002C6_4ACB57C4023E_impl*
end;//TnsBaseSearchFormState.FinishDataUpdate

procedure TnsBaseSearchFormState.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ActiveClass := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsBaseSearchFormState.ClearFields

// Методы преобразования к реализуемым интерфейсам

function TnsBaseSearchFormState.As_IvcmBase: IvcmBase;
begin
 Result := Self;
end;

procedure TPrimBaseSearchForm.AfterSearcherSet;
//#UC START# *4ACB59F7011B_4AB791130260_var*
//#UC END# *4ACB59F7011B_4AB791130260_var*
begin
//#UC START# *4ACB59F7011B_4AB791130260_impl*
 //Assert(Assigned(f_BaseSearcher));
 //Assert(Assigned(f_BaseSearcher.Presentation));
 // - закомментировал, чтобы починить http://mdp.garant.ru/pages/viewpage.action?pageId=297714750

 // http://mdp.garant.ru/pages/viewpage.action?pageId=297714750 
 if (f_BaseSearcher = nil) OR (f_BaseSearcher.Presentation = nil) then
 begin
  SafeClose;
  Exit;
 end;

 CheckParamsPagesCount((Ord(High(TnsBaseSearchKind)) - Ord(Low(TnsBaseSearchKind)) + 1));
 f_BaseSearcher.ValidateBaseSearchForm(Self.As_IvcmEntityForm);
 f_BaseSearcher.SearchWindow := Self;
 f_InCreate := True;
 try
  ClassNamesChanged;
  PresentationChanged;
 finally
  f_InCreate := False;
 end;//try..finally
//#UC END# *4ACB59F7011B_4AB791130260_impl*
end;//TPrimBaseSearchForm.AfterSearcherSet

function TPrimBaseSearchForm.MainMenuLikeBaseSearch: Boolean;
//#UC START# *4F2021110102_4AB791130260_var*
var
 l_O : InsMainMenuLikeBaseSearchOwner;
//#UC END# *4F2021110102_4AB791130260_var*
begin
//#UC START# *4F2021110102_4AB791130260_impl*
 Assert(Owner Is TvcmEntityForm);
(* if TvcmEntityForm(Owner).As_IvcmEntityForm.SameName(fm_en_MainMenuNew)
 // - разделяем случай когда БП встроен в ОМ и все остальные, а иначе при хождении
 //   по истории пропадает БП из ОМ
   OR TvcmEntityForm(Owner).As_IvcmEntityForm.SameName(fm_BaseSearchContainerForm)
   // http://mdp.garant.ru/pages/viewpage.action?pageId=300515366*)
 if Supports(Owner, InsMainMenuLikeBaseSearchOwner, l_O) AND
    l_O.IsIt 
 // - разделяем случай когда БП встроен в ОМ и все остальные, а иначе при хождении
 //   по истории пропадает БП из ОМ
 then
  Result := true
 else
  Result := false;
//#UC END# *4F2021110102_4AB791130260_impl*
end;//TPrimBaseSearchForm.MainMenuLikeBaseSearch

procedure TPrimBaseSearchForm.ApplyCurrentExample;
//#UC START# *4B13B419036C_4AB791130260_var*
//#UC END# *4B13B419036C_4AB791130260_var*
begin
//#UC START# *4B13B419036C_4AB791130260_impl*
 if Assigned(f_BaseSearcher) then
 begin
  TnsUseBaseSearchExampleEvent.Instance.Log;
  f_BaseSearcher.{WindowData.}ApplyCurrentExample;
 end;//if Assigned(f_BaseSearcher) then
//#UC END# *4B13B419036C_4AB791130260_impl*
end;//TPrimBaseSearchForm.ApplyCurrentExample

function TPrimBaseSearchForm.pm_GetContextEdit: TnscTreeComboWithHistoryAndOperations;
begin
 if (f_ContextEdit = nil) then
  f_ContextEdit := FindComponent('ContextEdit') As TnscTreeComboWithHistoryAndOperations;
 Result := f_ContextEdit;
end;

procedure TPrimBaseSearchForm.UnregisterFromSearcher;
//#UC START# *4CF4D7110264_4AB791130260_var*
//#UC END# *4CF4D7110264_4AB791130260_var*
begin
//#UC START# *4CF4D7110264_4AB791130260_impl*
 if Assigned(f_BaseSearcher) then
 begin
  Inc(f_LockParamsChange);
  f_BaseSearcher.{WindowData.}SearchWindow := nil;
 end;//Assigned(f_BaseSearcher)
 f_BaseSearcher := nil;
 f_ActiveClassForSaveInHistory := nil;
 // - иначе можем схватить клинч на выходе из приложения
 if (Dispatcher <> nil) then
  if (Dispatcher.History <> nil) then
   Dispatcher.History.RemoveForm(Self.As_IvcmEntityForm);
  // - раз мы вычистили f_BaseSearcher, то мы не можем писать себя в историю
  // http://mdp.garant.ru/pages/viewpage.action?pageId=297708319
  // http://mdp.garant.ru/pages/viewpage.action?pageId=257393788
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296636403#comment-296636403
//#UC END# *4CF4D7110264_4AB791130260_impl*
end;//TPrimBaseSearchForm.UnregisterFromSearcher

procedure TPrimBaseSearchForm.DoFindBtnClick;
//#UC START# *4CFCCEAC01C9_4AB791130260_var*
//#UC END# *4CFCCEAC01C9_4AB791130260_var*
begin
//#UC START# *4CFCCEAC01C9_4AB791130260_impl*
 try
  SearchByContext(f_BaseSearcher.WindowData.ActiveClass, False, False);
 except
  on ETryToFindEmptyContext do
   Ask(inf_SimpleMainMenuSearchCondition);
 end;//try..except
//#UC END# *4CFCCEAC01C9_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoFindBtnClick

procedure TPrimBaseSearchForm.SearchByContext(const aClassToSaveInHistory: InsBaseSearchClass;
  aNeedUpdateAndStoreActiveClass: Boolean;
  aUpdateClassBeforeSearch: Boolean);
//#UC START# *4CFCCFCE0297_4AB791130260_var*

(*var
 l_Class : InsBaseSearchClass;*)

 procedure UpdateSearcherClass;
 begin//UpdateSearcherClass
  Inc(f_LockParamsChange);
  try
(*   if not Focused and ThemePages.ChangingActivePageByMouse then
    ActivateWindow(False);*)

   if Assigned(f_BaseSearcher) and
      (not f_BaseSearcher.WindowData.ActiveClass.IsSame(aClassToSaveInHistory))
   // проверка отсекает повторную установку уже выбранного Вида информации,
   // без данной проверки, в vgscene возникает артифакт отрисовки при клике
   // по тому же Виду информации - http://mdp.garant.ru/pages/viewpage.action?pageId=327353074
    then
   begin
    f_BaseSearcher.WindowData.ActiveClass := aClassToSaveInHistory;

    // в перерисовки нет необходимости, на vgscene могут возникать артефакты в эффектах
    //if (f_BaseSearcher <> nil) then
    //begin
    // if (ActiveClassTab <> nil) then
    //  ActiveClassTab.Repaint;
    // Application.ProcessMessages;
    //end;//f_BaseSearcher <> nil
   end;//Assigned(f_BaseSearcher)
   if FlashTimer.Enabled then
    StopFlash;
  finally
   Dec(f_LockParamsChange);
  end;//try..finally
 end;//UpdateSearcherClass

var
 l_ErrMessage : Il3CString;
//#UC END# *4CFCCFCE0297_4AB791130260_var*
begin
//#UC START# *4CFCCFCE0297_4AB791130260_impl*
 Assert(f_BaseSearcher <> nil);
 Assert(f_BaseSearcher.Presentation <> nil);

 if False{aUpdateClassBeforeSearch} then   // не подходит такой вариант пока что: http://mdp.garant.ru/pages/viewpage.action?pageId=356071766&focusedCommentId=485426432#comment-485426432
 // http://mdp.garant.ru/pages/viewpage.action?pageId=483414801
 begin
  f_BaseSearcher.WindowData.StoreActiveClass;
  UpdateSearcherClass;
 end;//aNeedUpdateAndStoreActiveClass

 if f_BaseSearcher.Presentation.NeedSaveActiveClassBeforeSearch then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=327826220
  f_ActiveClassForSaveInHistory := f_BaseSearcher.WindowData.ActiveClass
 else
  f_ActiveClassForSaveInHistory := aClassToSaveInHistory;

 if aNeedUpdateAndStoreActiveClass then
 begin
  f_BaseSearcher.WindowData.StoreActiveClass;

  // чтобы избежать http://mdp.garant.ru/pages/viewpage.action?pageId=326775251
  // UpdateSearcherClass вызываем, если l_NeedSearch
  UpdateSearcherClass;
 end;//aNeedUpdateAndStoreActiveClass

 if not l3IsNil(ContextEdit.Text) and
    (CheckContext6x(ContextEdit.Text, l_ErrMessage) <> l3NotFound) then
 begin
  Self.MessageDlg(l_ErrMessage, 'TPrimBaseSearchForm.SearchByContext', mtError);
  exit;
 end;//not l3IsNil(ContextEdit.Text)..
 if ContextEdit.PropmtTreeUsed then
  TnsUseBaseSearchHintEvent.Instance.Log;
 ContextEdit.ResetPropmtTreeUsage;
 if Assigned(f_BaseSearcher) then
   f_BaseSearcher.{WindowData.}Find;
//#UC END# *4CFCCFCE0297_4AB791130260_impl*
end;//TPrimBaseSearchForm.SearchByContext

procedure TPrimBaseSearchForm.ContextEditPastingString(Sender: TObject;
  var aText: Il3CString);
//#UC START# *4CFCD7CF000D_4AB791130260_var*
//#UC END# *4CFCD7CF000D_4AB791130260_var*
begin
//#UC START# *4CFCD7CF000D_4AB791130260_impl*
 if (l3Len(aText) > cMaxLen) then
  l3SetLen(aText, cMaxLen);
 aText := l3StringReplace(aText, cc_TabStr, cc_EmptyTabSymbol, [rfReplaceAll]);
 aText := l3StringReplace(aText, cc_EOLStr, cc_EmptyTabSymbol, [rfReplaceAll]);
 aText := l3StringReplace(aText, cc_HardEnterNativeStr, cc_EmptyTabSymbol, [rfReplaceAll]);
 aText := l3StringReplace(aText, cc_SoftEnterNativeStr, cc_EmptyTabSymbol, [rfReplaceAll]);
 aText := RepairContext6x(aText);
//#UC END# *4CFCD7CF000D_4AB791130260_impl*
end;//TPrimBaseSearchForm.ContextEditPastingString

procedure TPrimBaseSearchForm.StopFlash;
//#UC START# *4CFCDAD5031E_4AB791130260_var*
//#UC END# *4CFCDAD5031E_4AB791130260_var*
begin
//#UC START# *4CFCDAD5031E_4AB791130260_impl*
 f_FlashCounter := 0;
 FlashTimer.Enabled := False;
 ContextLabelVisible := false{not ContextLabelVisible};
//#UC END# *4CFCDAD5031E_4AB791130260_impl*
end;//TPrimBaseSearchForm.StopFlash

procedure TPrimBaseSearchForm.UpdateSearcherContext;
//#UC START# *4CFCDAF50114_4AB791130260_var*
//#UC END# *4CFCDAF50114_4AB791130260_var*
begin
//#UC START# *4CFCDAF50114_4AB791130260_impl*
 Inc(f_LockParamsChange);
 try
  if (f_BaseSearcher <> nil) then
   f_BaseSearcher.WindowData.Context := ContextEdit.Text;
  StopFlash;
 finally
  Dec(f_LockParamsChange);
 end;//try..finally
//#UC END# *4CFCDAF50114_4AB791130260_impl*
end;//TPrimBaseSearchForm.UpdateSearcherContext

procedure TPrimBaseSearchForm.ContextEditChange(Sender: TObject);
//#UC START# *4CFCDB2B01F6_4AB791130260_var*
//#UC END# *4CFCDB2B01F6_4AB791130260_var*
begin
//#UC START# *4CFCDB2B01F6_4AB791130260_impl*
 UpdateSearcherContext;
//#UC END# *4CFCDB2B01F6_4AB791130260_impl*
end;//TPrimBaseSearchForm.ContextEditChange

procedure TPrimBaseSearchForm.FlashTimerTimer(Sender: TObject);
//#UC START# *4CFCE2CC0186_4AB791130260_var*
//#UC END# *4CFCE2CC0186_4AB791130260_var*
begin
//#UC START# *4CFCE2CC0186_4AB791130260_impl*
 if FlashTimer.Enabled then
  ChangeFlash
 else
  StopFlash;
//#UC END# *4CFCE2CC0186_4AB791130260_impl*
end;//TPrimBaseSearchForm.FlashTimerTimer

procedure TPrimBaseSearchForm.ChangeFlash;
//#UC START# *4CFCE338038E_4AB791130260_var*
//#UC END# *4CFCE338038E_4AB791130260_var*
begin
//#UC START# *4CFCE338038E_4AB791130260_impl*
 Inc(f_FlashCounter);
 if f_FlashCounter > (2*c_FlashTimes) then
  StopFlash
 else
  ContextLabelVisible := not ContextLabelVisible;
//#UC END# *4CFCE338038E_4AB791130260_impl*
end;//TPrimBaseSearchForm.ChangeFlash

procedure TPrimBaseSearchForm.StartFlash;
//#UC START# *4CFCE36D00DF_4AB791130260_var*
//#UC END# *4CFCE36D00DF_4AB791130260_var*
begin
//#UC START# *4CFCE36D00DF_4AB791130260_impl*
 f_FlashCounter := 0;
 FlashTimer.Enabled := True;
 ContextLabelVisible := true{not ContextLabelVisible};
//#UC END# *4CFCE36D00DF_4AB791130260_impl*
end;//TPrimBaseSearchForm.StartFlash

procedure TPrimBaseSearchForm.ContextEditSelect(Sender: TObject);
//#UC START# *4CFCE40A036B_4AB791130260_var*
//#UC END# *4CFCE40A036B_4AB791130260_var*
begin
//#UC START# *4CFCE40A036B_4AB791130260_impl*
 try
  SearchByContext(f_BaseSearcher.WindowData.ActiveClass, False, False);
 except
  on ETryToFindEmptyContext do
   Ask(inf_SimpleMainMenuSearchCondition);
 end;//try..except
//#UC END# *4CFCE40A036B_4AB791130260_impl*
end;//TPrimBaseSearchForm.ContextEditSelect

procedure TPrimBaseSearchForm.DoCloseBtnClick;
//#UC START# *4CFCEC8B030B_4AB791130260_var*
var
 l_Container: IvcmContainer;
//#UC END# *4CFCEC8B030B_4AB791130260_var*
begin
//#UC START# *4CFCEC8B030B_4AB791130260_impl*
 if (f_BaseSearcher = nil) OR
    // http://mdp.garant.ru/pages/viewpage.action?pageId=321989072
    (f_BaseSearcher.Presentation = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=297714750
  SafeClose
 else
 if f_BaseSearcher.Presentation.CanCloseWindow then
 begin
  UnregisterFromSearcher;

  l_Container := Get_Container;
  try
   SafeClose;
   if Assigned(l_Container) then
    l_Container.SetFocusToMainObjectForm;
  finally
   l_Container := nil;
  end;
 end;//f_BaseSearcher.Presentation.CanCloseWindow
//#UC END# *4CFCEC8B030B_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoCloseBtnClick

procedure TPrimBaseSearchForm.UpdateSearcherArea(anArea: TnsSearchArea;
  anKind: TnsBaseSearchKind);
//#UC START# *4CFE398A0128_4AB791130260_var*
//#UC END# *4CFE398A0128_4AB791130260_var*
begin
//#UC START# *4CFE398A0128_4AB791130260_impl*
 Inc(f_LockParamsChange);
 try
  if Assigned(f_BaseSearcher) and (f_BaseSearcher.WindowData.ContextKind = anKind) then
   f_BaseSearcher.WindowData.Area := anArea;
  StopFlash;
  SetUpFindButtons;
 finally
  Dec(f_LockParamsChange);
 end;//try..finally
//#UC END# *4CFE398A0128_4AB791130260_impl*
end;//TPrimBaseSearchForm.UpdateSearcherArea

procedure TPrimBaseSearchForm.DoFindBackBtnClick;
//#UC START# *4CFE48BF01E2_4AB791130260_var*
//#UC END# *4CFE48BF01E2_4AB791130260_var*
begin
//#UC START# *4CFE48BF01E2_4AB791130260_impl*
 f_BaseSearcher.{WindowData.}FindBack;
 TnsUseBackSearchButtonEvent.Instance.Log;
//#UC END# *4CFE48BF01E2_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoFindBackBtnClick

// start class TnsUseBaseSearchExampleEvent

var g_TnsUseBaseSearchExampleEvent : TnsUseBaseSearchExampleEvent = nil;

procedure TnsUseBaseSearchExampleEventFree;
begin
 l3Free(g_TnsUseBaseSearchExampleEvent);
end;

class function TnsUseBaseSearchExampleEvent.Instance: TnsUseBaseSearchExampleEvent;
begin
 if (g_TnsUseBaseSearchExampleEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseBaseSearchExampleEventFree);
  g_TnsUseBaseSearchExampleEvent := Create;
 end;
 Result := g_TnsUseBaseSearchExampleEvent;
end;


class function TnsUseBaseSearchExampleEvent.Exists: Boolean;
 {-}
begin
 Result := g_TnsUseBaseSearchExampleEvent <> nil;
end;//TnsUseBaseSearchExampleEvent.Exists

function TnsUseBaseSearchExampleEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13B3BD01CD_var*
//#UC END# *4B13A26203DB_4B13B3BD01CD_var*
begin
//#UC START# *4B13A26203DB_4B13B3BD01CD_impl*
 Result := LE_USE_BASE_SEARCH_EXAMPLE;
//#UC END# *4B13A26203DB_4B13B3BD01CD_impl*
end;//TnsUseBaseSearchExampleEvent.EventID

// start class TnsUseBaseSearchHintEvent

var g_TnsUseBaseSearchHintEvent : TnsUseBaseSearchHintEvent = nil;

procedure TnsUseBaseSearchHintEventFree;
begin
 l3Free(g_TnsUseBaseSearchHintEvent);
end;

class function TnsUseBaseSearchHintEvent.Instance: TnsUseBaseSearchHintEvent;
begin
 if (g_TnsUseBaseSearchHintEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseBaseSearchHintEventFree);
  g_TnsUseBaseSearchHintEvent := Create;
 end;
 Result := g_TnsUseBaseSearchHintEvent;
end;


class function TnsUseBaseSearchHintEvent.Exists: Boolean;
 {-}
begin
 Result := g_TnsUseBaseSearchHintEvent <> nil;
end;//TnsUseBaseSearchHintEvent.Exists

function TnsUseBaseSearchHintEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13B90D007E_var*
//#UC END# *4B13A26203DB_4B13B90D007E_var*
begin
//#UC START# *4B13A26203DB_4B13B90D007E_impl*
 Result := LE_USE_BASE_SEARCH_HINT;
//#UC END# *4B13A26203DB_4B13B90D007E_impl*
end;//TnsUseBaseSearchHintEvent.EventID

// start class TnsUseBackSearchButtonEvent

var g_TnsUseBackSearchButtonEvent : TnsUseBackSearchButtonEvent = nil;

procedure TnsUseBackSearchButtonEventFree;
begin
 l3Free(g_TnsUseBackSearchButtonEvent);
end;

class function TnsUseBackSearchButtonEvent.Instance: TnsUseBackSearchButtonEvent;
begin
 if (g_TnsUseBackSearchButtonEvent = nil) then
 begin
  l3System.AddExitProc(TnsUseBackSearchButtonEventFree);
  g_TnsUseBackSearchButtonEvent := Create;
 end;
 Result := g_TnsUseBackSearchButtonEvent;
end;


class function TnsUseBackSearchButtonEvent.Exists: Boolean;
 {-}
begin
 Result := g_TnsUseBackSearchButtonEvent <> nil;
end;//TnsUseBackSearchButtonEvent.Exists

function TnsUseBackSearchButtonEvent.EventID: TLogEvent;
//#UC START# *4B13A26203DB_4B13B9AA029F_var*
//#UC END# *4B13A26203DB_4B13B9AA029F_var*
begin
//#UC START# *4B13A26203DB_4B13B9AA029F_impl*
 Result := LE_USE_BACK_SEARCH_BUTTON;
//#UC END# *4B13A26203DB_4B13B9AA029F_impl*
end;//TnsUseBackSearchButtonEvent.EventID

procedure TPrimBaseSearchForm.CMVisibleChanged(var Msg: TMessage);
//#UC START# *506AB26A0032_4AB791130260_var*
//#UC END# *506AB26A0032_4AB791130260_var*
begin
//#UC START# *506AB26A0032_4AB791130260_impl*
 inherited;

 if not Assigned(ContextEdit) then
  Exit;

 if not MainMenuLikeBaseSearch then
  Exit;

 if not Visible then
  Exit;

 if not Assigned(Dispatcher) or
    not Assigned(Dispatcher.History) or
    not Dispatcher.History.InBF then
  if ContextEdit.CanFocus and (Windows.GetFocus <> ContextEdit.Handle) then
   ContextEdit.SetFocus;
//#UC END# *506AB26A0032_4AB791130260_impl*
end;//TPrimBaseSearchForm.CMVisibleChanged

class function TPrimBaseSearchForm.MakeSingleChild(const aData: InsBaseSearcherWindowData;
  const aCont   : IvcmContainer;
  const anAgg   : IvcmAggregate;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimBaseSearchForm);
 begin
  with aForm do
  begin
//#UC START# *565445DF038D_4AB791130260_impl*
   Assert(aData <> nil);
   f_BaseSearcher := aData as InsBaseSearcher;
   f_BaseSearcher.ValidateBaseSearchForm(aForm.As_IvcmEntityForm);
   AfterSearcherSet;
//#UC END# *565445DF038D_4AB791130260_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited MakeSingleChild(aCont, vcmSetAggregate(anAgg, vcmMakeParams), aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

procedure TPrimBaseSearchForm.ParamsChanged;
//#UC START# *496B51AA02C3_4AB791130260_var*
var
 l_Area : TnsSearchArea;
//#UC END# *496B51AA02C3_4AB791130260_var*
begin
//#UC START# *496B51AA02C3_4AB791130260_impl*
 if VCMClosing or l3SystemDown then
  Exit;
 Assert(Assigned(f_BaseSearcher));
 if Dispatcher.FormDispatcher.Locked and not f_InCreate then
 begin
  f_NeedParamsChanged := true;
  Dispatcher.FormDispatcher.AddLockListener(IvcmLockListener(Self));
 end//Dispatcher.FormDispatcher.Locked and not f_InCreate then
 else
 begin
  if (f_LockParamsChange = 0) then
  begin
   ContextEdit.Text := f_BaseSearcher.WindowData.Context;

   ContextEdit.PaintMistakes(f_BaseSearcher.WindowData.ErrorWords);

   l_Area := f_BaseSearcher.WindowData.Area;
   SetCurrentContextKind(f_BaseSearcher.WindowData.ContextKind);
   AdjustParamsPagesHeight;

   SetCurrentSearchArea(l_Area);

   SetUpFindButtons;
  end;//f_LockParamsChange = 0

  ContextEdit.PromptTree := f_BaseSearcher.WindowData.PromptTree;

  SetupThemePages;
  f_NeedParamsChanged := false;
  CheckFindEnabled;
  CheckFragmentsCount;
 end;//Dispatcher.FormDispatcher.Locked and not f_InCreate
//#UC END# *496B51AA02C3_4AB791130260_impl*
end;//TPrimBaseSearchForm.ParamsChanged

procedure TPrimBaseSearchForm.PresentationChanged;
//#UC START# *496B51B500C8_4AB791130260_var*
//#UC END# *496B51B500C8_4AB791130260_var*
begin
//#UC START# *496B51B500C8_4AB791130260_impl*
 if VCMClosing then
  exit;
 if Dispatcher.FormDispatcher.Locked and not f_InCreate then
 begin
  f_NeedPresentationChanged := True;
  Dispatcher.FormDispatcher.AddLockListener(IvcmLockListener(Self));
 end//Dispatcher.FormDispatcher.Locked..
 else
 begin
  CloseBtnEnabled := f_BaseSearcher.Presentation.WindowCloseable;
  f_NeedPresentationChanged := False;
  ParamsChanged;
  ExampleChanged;
  ContextEdit.SelectAll;
 end;//Dispatcher.FormDispatcher.Locked..
//#UC END# *496B51B500C8_4AB791130260_impl*
end;//TPrimBaseSearchForm.PresentationChanged

procedure TPrimBaseSearchForm.ExampleChanged;
//#UC START# *496B51BF02D2_4AB791130260_var*
//#UC END# *496B51BF02D2_4AB791130260_var*
begin
//#UC START# *496B51BF02D2_4AB791130260_impl*
 if Assigned(f_BaseSearcher) then
  DoExampleChanged(f_BaseSearcher.WindowData.ExampleText);
//#UC END# *496B51BF02D2_4AB791130260_impl*
end;//TPrimBaseSearchForm.ExampleChanged

procedure TPrimBaseSearchForm.CheckFindEnabled;
//#UC START# *496B51C90345_4AB791130260_var*
//#UC END# *496B51C90345_4AB791130260_var*
begin
//#UC START# *496B51C90345_4AB791130260_impl*
 Self.FindBtnEnabled := Assigned(f_BaseSearcher) and f_BaseSearcher.WindowData.FindEnabled;
 Self.FindBackBtnEnabled := Assigned(f_BaseSearcher) and f_BaseSearcher.WindowData.FindBackEnabled;
//#UC END# *496B51C90345_4AB791130260_impl*
end;//TPrimBaseSearchForm.CheckFindEnabled

procedure TPrimBaseSearchForm.ClassNamesChanged;
//#UC START# *496B51D40055_4AB791130260_var*
//#UC END# *496B51D40055_4AB791130260_var*
begin
//#UC START# *496B51D40055_4AB791130260_impl*
 if VCMClosing then
  exit;
 SetupClasses(not f_InCreate);
//#UC END# *496B51D40055_4AB791130260_impl*
end;//TPrimBaseSearchForm.ClassNamesChanged

procedure TPrimBaseSearchForm.CloseWindow;
//#UC START# *496B51DC037D_4AB791130260_var*
//#UC END# *496B51DC037D_4AB791130260_var*
begin
//#UC START# *496B51DC037D_4AB791130260_impl*
 UnregisterFromSearcher;
 SafeClose;
//#UC END# *496B51DC037D_4AB791130260_impl*
end;//TPrimBaseSearchForm.CloseWindow

procedure TPrimBaseSearchForm.ActivateWindow(aNeedFlash: Boolean = True);
//#UC START# *496B51F202B1_4AB791130260_var*
var
 l_F : TafwCustomForm;
//#UC END# *496B51F202B1_4AB791130260_var*
begin
//#UC START# *496B51F202B1_4AB791130260_impl*
 if aNeedFlash then
  StartFlash;
 if ContextEdit.CanFocus then
 begin
  l_F := afw.GetParentForm(ContextEdit);
  if (l_F = nil) then
   Exit;
  while (l_F <> nil) do
  begin
   if not l_F.Visible then
    Exit;
   l_F := afw.GetAnotherParentForm(l_F);
  end;//l_F <> nil
  ContextEdit.SetFocus;
 end;//ContextEdit.CanFocus
//#UC END# *496B51F202B1_4AB791130260_impl*
end;//TPrimBaseSearchForm.ActivateWindow

procedure TPrimBaseSearchForm.HistoryChanged(const aNewHistory: IvcmStrings);
//#UC START# *496B53B70380_4AB791130260_var*
//#UC END# *496B53B70380_4AB791130260_var*
begin
//#UC START# *496B53B70380_4AB791130260_impl*
 ContextEdit.HistoryItems.Assign(aNewHistory);
//#UC END# *496B53B70380_4AB791130260_impl*
end;//TPrimBaseSearchForm.HistoryChanged

procedure TPrimBaseSearchForm.ContextSearched;
//#UC START# *496B53C30337_4AB791130260_var*
//#UC END# *496B53C30337_4AB791130260_var*
begin
//#UC START# *496B53C30337_4AB791130260_impl*
 // DoNothings;
//#UC END# *496B53C30337_4AB791130260_impl*
end;//TPrimBaseSearchForm.ContextSearched

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Lock;
//#UC START# *4995562701A0_4AB791130260_var*
//#UC END# *4995562701A0_4AB791130260_var*
begin
//#UC START# *4995562701A0_4AB791130260_impl*
 // DoNothings;
//#UC END# *4995562701A0_4AB791130260_impl*
end;//TPrimBaseSearchForm.Lock
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.BeforeUnlock;
//#UC START# *4995563201CA_4AB791130260_var*
//#UC END# *4995563201CA_4AB791130260_var*
begin
//#UC START# *4995563201CA_4AB791130260_impl*
 // DoNothings;
//#UC END# *4995563201CA_4AB791130260_impl*
end;//TPrimBaseSearchForm.BeforeUnlock
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Unlock;
//#UC START# *4995563E01A9_4AB791130260_var*
//#UC END# *4995563E01A9_4AB791130260_var*
begin
//#UC START# *4995563E01A9_4AB791130260_impl*
 if not VCMCLosing then
 begin
  if f_NeedPresentationChanged then
   PresentationChanged;
  if f_NeedParamsChanged then
   ParamsChanged;
 end;//if not VCMCLosing then
//#UC END# *4995563E01A9_4AB791130260_impl*
end;//TPrimBaseSearchForm.Unlock
{$IfEnd} //not NoVCM

procedure TPrimBaseSearchForm.CheckFragmentsCount;
//#UC START# *49FFD8050279_4AB791130260_var*
//#UC END# *49FFD8050279_4AB791130260_var*
begin
//#UC START# *49FFD8050279_4AB791130260_impl*
 DoCheckFragmentsCount(f_BaseSearcher.WindowData.FragmentsCountSuffix);
//#UC END# *49FFD8050279_4AB791130260_impl*
end;//TPrimBaseSearchForm.CheckFragmentsCount

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD47D0357_4AB791130260test_var*
//#UC END# *4A8AD47D0357_4AB791130260test_var*
begin
//#UC START# *4A8AD47D0357_4AB791130260test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A8AD47D0357_4AB791130260test_impl*
end;//TPrimBaseSearchForm.Result_OkExt_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD47D0357_4AB791130260exec_var*
//#UC END# *4A8AD47D0357_4AB791130260exec_var*
begin
//#UC START# *4A8AD47D0357_4AB791130260exec_impl*
 DoFindBtnClick;
//#UC END# *4A8AD47D0357_4AB791130260exec_impl*
end;//TPrimBaseSearchForm.Result_OkExt_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AB791130260test_var*
//#UC END# *4A97EBE702F8_4AB791130260test_var*
begin
//#UC START# *4A97EBE702F8_4AB791130260test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4A97EBE702F8_4AB791130260test_impl*
end;//TPrimBaseSearchForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AB791130260exec_var*
//#UC END# *4A97EBE702F8_4AB791130260exec_var*
begin
//#UC START# *4A97EBE702F8_4AB791130260exec_impl*
 DoFindBtnClick;
//#UC END# *4A97EBE702F8_4AB791130260exec_impl*
end;//TPrimBaseSearchForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AC5D61E0284_4AB791130260test_var*
//#UC END# *4AC5D61E0284_4AB791130260test_var*
begin
//#UC START# *4AC5D61E0284_4AB791130260test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4AC5D61E0284_4AB791130260test_impl*
end;//TPrimBaseSearchForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AC5D61E0284_4AB791130260exec_var*
//#UC END# *4AC5D61E0284_4AB791130260exec_var*
begin
//#UC START# *4AC5D61E0284_4AB791130260exec_impl*
 if CloseBtnEnabled then
  DoCloseBtnClick
 else
  aParams.DoneStatus := vcm_dsNotDone; 
//#UC END# *4AC5D61E0284_4AB791130260exec_impl*
end;//TPrimBaseSearchForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

function TPrimBaseSearchForm.Get_Container: IvcmContainer;
//#UC START# *4ACB63B502EA_4AB791130260get_var*
//#UC END# *4ACB63B502EA_4AB791130260get_var*
begin
//#UC START# *4ACB63B502EA_4AB791130260get_impl*
 Result := inherited Get_Container;
//#UC END# *4ACB63B502EA_4AB791130260get_impl*
end;//TPrimBaseSearchForm.Get_Container

procedure TPrimBaseSearchForm.EnclosedForms_CloseChild_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C43D2F002EC_4AB791130260test_var*
//#UC END# *4C43D2F002EC_4AB791130260test_var*
begin
//#UC START# *4C43D2F002EC_4AB791130260test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
//#UC END# *4C43D2F002EC_4AB791130260test_impl*
end;//TPrimBaseSearchForm.EnclosedForms_CloseChild_Test

procedure TPrimBaseSearchForm.EnclosedForms_CloseChild_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C43D2F002EC_4AB791130260exec_var*
//#UC END# *4C43D2F002EC_4AB791130260exec_var*
begin
//#UC START# *4C43D2F002EC_4AB791130260exec_impl*
 DoCloseBtnClick;
//#UC END# *4C43D2F002EC_4AB791130260exec_impl*
end;//TPrimBaseSearchForm.EnclosedForms_CloseChild_Execute

procedure TPrimBaseSearchForm.NsNotification(aType: TnsNotificationType);
//#UC START# *542BF11D00B6_4AB791130260_var*
//#UC END# *542BF11D00B6_4AB791130260_var*
begin
//#UC START# *542BF11D00B6_4AB791130260_impl*
 if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
  if aType = ntMainFormBecomeTopmostAtStartup then
  begin
   Assert(f_ContextEdit.CanFocus); // должно быть уже можно поставить фокус. Обязательно.
   f_ContextEdit.SetFocus;
  end;
//#UC END# *542BF11D00B6_4AB791130260_impl*
end;//TPrimBaseSearchForm.NsNotification

procedure TPrimBaseSearchForm.ForceUpdateClassForHistory;
//#UC START# *5437B4340246_4AB791130260_var*
//#UC END# *5437B4340246_4AB791130260_var*
begin
//#UC START# *5437B4340246_4AB791130260_impl*
 f_ActiveClassForSaveInHistory := f_BaseSearcher.WindowData.ActiveClass;
//#UC END# *5437B4340246_4AB791130260_impl*
end;//TPrimBaseSearchForm.ForceUpdateClassForHistory

procedure TPrimBaseSearchForm.NotifyContainersChanged(aNotification: Tl3TabbedContainerNotificationType);
//#UC START# *55321ADE02E9_4AB791130260_var*

 function IsActive: Boolean;
 var
  l_ActiveContainer: TvcmTabbedContainerForm;
  l_C: TWinControl;
 begin
  l_ActiveContainer := TvcmTabbedContainerFormDispatcher.Instance.ActiveContainer;
  if not Assigned(l_ActiveContainer) then
  begin
   Result := False;
   Exit;
  end;
  l_C := Parent;
  while Assigned(l_C) do
  begin
   if l_C = l_ActiveContainer then
   begin
    Result := True;
    Exit;
   end;
   l_C := l_C.Parent;
  end;
  Result := False;
 end;

 function lp_CanFocus(aControl: TControl): Boolean;
 begin
  Result := False;
  while Assigned(aControl) do
  begin
   if not (aControl.Enabled and aControl.Visible) then
    Exit;
   if not Assigned(aControl.Parent) and not (aControl is TCustomForm) then
    Exit;
   aControl := aControl.Parent;
  end;
  Result := True;
 end;

var
 l_NewActive: Boolean;
//#UC END# *55321ADE02E9_4AB791130260_var*
begin
//#UC START# *55321ADE02E9_4AB791130260_impl*
 if aNotification = tcnTabChanged then
 begin
  l_NewActive := IsActive;
  if not f_IsTabActive then
   if l_NewActive then // перешли на нашу вкладку
   begin
    if Assigned(f_ControlToActivate) then
    begin
     ActiveControl := f_ControlToActivate;
     f_ControlToActivate := nil;
    end else
    if lp_CanFocus(f_ContextEdit) then
     f_ContextEdit.SetFocus
    else
     Exit;
    f_IsTabActive := True;
   end else // переключились между другими вкладками
    Exit    // ничего делать не надо
  else
  if l_NewActive then // видимо, открыли вкладку в фоне. Ничего делать не надо
  else
  begin // перешли с нашей вкладки на другую
   f_ControlToActivate := ActiveControl;
   f_IsTabActive := False;
  end;
 end;
//#UC END# *55321ADE02E9_4AB791130260_impl*
end;//TPrimBaseSearchForm.NotifyContainersChanged

function TPrimBaseSearchForm.pm_GetIsActive: Boolean;
//#UC START# *567290190285_4AB791130260get_var*
//#UC END# *567290190285_4AB791130260get_var*
begin
//#UC START# *567290190285_4AB791130260get_impl*
 Result := f_IsActive;
//#UC END# *567290190285_4AB791130260get_impl*
end;//TPrimBaseSearchForm.pm_GetIsActive

procedure TPrimBaseSearchForm.Cleanup;
//#UC START# *479731C50290_4AB791130260_var*
//#UC END# *479731C50290_4AB791130260_var*
begin
//#UC START# *479731C50290_4AB791130260_impl*
 TvcmTabbedContainerFormDispatcher.Instance.Unsubscribe(Self);
 TnsNotificationManager.RemoveListener(Self);
 TnsSearchWindowManager.Instance.Unsubscribe(Self);
 f_ControlToActivate := nil;
 f_IsTabActive := False;
 if (Dispatcher <> nil) then
  if (Dispatcher.History <> nil) then
   Dispatcher.History.RemoveForm(Self.As_IvcmEntityForm);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=257393788
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309
  // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296636403#comment-296636403
 Dispatcher.FormDispatcher.RemoveLockListener(IvcmLockListener(Self));
 if Assigned(f_ContextHistory) then
  f_ContextHistory.RemoveNotifier(Self);
 f_ContextHistory := nil;
 UnregisterFromSearcher;
 f_BaseSearcher := nil;
 inherited;
//#UC END# *479731C50290_4AB791130260_impl*
end;//TPrimBaseSearchForm.Cleanup

procedure TPrimBaseSearchForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4AB791130260_var*
//#UC END# *47EA4E9002C6_4AB791130260_var*
begin
//#UC START# *47EA4E9002C6_4AB791130260_impl*
 inherited;
 f_ActiveClassForSaveInHistory := nil;
//#UC END# *47EA4E9002C6_4AB791130260_impl*
end;//TPrimBaseSearchForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AB791130260_var*
//#UC END# *49803F5503AA_4AB791130260_var*
begin
//#UC START# *49803F5503AA_4AB791130260_impl*
 inherited;
// if not aFromHistory then
 begin
(*  Assert(Dispatcher <> nil);
  Assert(Dispatcher.History <> nil);*)
 if not MainMenuLikeBaseSearch then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=326773370
 // - добавляем форму в историю, только когда она "висит в воздухе"
 //   и не сохраняется в историю вместе со своими родителями.
 // http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698567#comment-330698567  
  if (Dispatcher <> nil) then
   if (Dispatcher.History <> nil) then
    Dispatcher.History.AddForm(Self.As_IvcmEntityForm);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=257393788
   // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309
   // http://mdp.garant.ru/pages/viewpage.action?pageId=269069309&focusedCommentId=296636403#comment-296636403
 end;//not aFromHistory
 f_ContextHistory := nsGetContextHistory(ns_chkDocument);
 f_ContextHistory.AddNotifier(Self);
 HistoryChanged(f_ContextHistory.History);
 f_ControlToActivate := nil;
 f_IsTabActive := False;
 TvcmTabbedContainerFormDispatcher.Instance.Subscribe(Self);
 TnsNotificationManager.AddListener(Self);
 TnsSearchWindowManager.Instance.Subscribe(Self);
//#UC END# *49803F5503AA_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimBaseSearchForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_4AB791130260_var*
var
 l_ClassToSave: InsBaseSearchClass;
//#UC END# *49806ED503D5_4AB791130260_var*
begin
//#UC START# *49806ED503D5_4AB791130260_impl*
 if true{(aStateType = vcm_stContent)} then
 begin
  (*if not g_Dispatcher.History.InBF then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300515366
  // http://mdp.garant.ru/pages/viewpage.action?pageId=300515366&focusedCommentId=326769653#comment-326769653*)
  // - и без этого - работает, дело в CreateFormGUID было
  //if not WasSaved AND not VCMClosing then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=326773370
  // - нельзя так лечить ибо проблема в другом:
  //   http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698406#comment-330698406
   Assert(f_BaseSearcher <> nil, 'Форма БП, которую пытаемся писать в историю не была корретно инициализирована или находится в процессе уничтожения');
  // - нельзя так пока, не проходит тест K265406789, если перед ним что-то с БП
  //   делали. Повод для разборок на самом деле.

  if (f_BaseSearcher = nil) then
   Result := false
  else
  if (f_BaseSearcher.Presentation <> nil) AND
     f_BaseSearcher.Presentation.FormCloseWasRequested then
  begin
   // Боремся с:
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
   // bq. А иначе окно БП закрывается слишком поздно  Когда начнут крутится ProcessMessages. Ну и - привет. Окно БП уже сохранилось в историю для КЗ. А потом оно будет пытаться восстанавливаться. Ну и - бабах.
   Result := false;
   f_BaseSearcher.RemovePresentation(f_BaseSearcher.Presentation);
   // ЖЁСТКО отключаем невалидное представление, чтобы НЕПОВАДНО было туда лазать
  end//f_BaseSearcher.Presentation <> nil
  else
  begin
   f_BaseSearcher.ValidateBaseSearchForm(Self.As_IvcmEntityForm);
   if (f_ActiveClassForSaveInHistory <> nil) then
   begin
    l_ClassToSave := f_ActiveClassForSaveInHistory;
    f_ActiveClassForSaveInHistory := nil;
    // - очищаем, т.к. дальше нас интересует уже то, что было после поиска
   end
   else
    l_ClassToSave := f_BaseSearcher.WindowData.ActiveClassForSaveState;

   theState := TnsBaseSearchFormState.Make(f_BaseSearcher.WindowData,
    l_ClassToSave).As_IvcmBase;

   Result := true;
  end;//f_BaseSearcher = nil
 end//aStateType = vcm_stContent
 else
  Result := inherited DoSaveState(theState, aStateType, aForClone);
//#UC END# *49806ED503D5_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoSaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimBaseSearchForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_4AB791130260_var*
var
 l_State : InsBaseSearchFormState;
 l_BaseSearcherState: InsBaseSearcherInitialState;
//#UC END# *49807428008C_4AB791130260_var*
begin
//#UC START# *49807428008C_4AB791130260_impl*
 if true{(aStateType = vcm_stContent)} then
 begin
  l_State := aState As InsBaseSearchFormState;
  Assert(l_State <> nil);
  // Убираем Assert
   // Боремся с:
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
   // bq. А иначе окно БП закрывается слишком поздно  Когда начнут крутится ProcessMessages. Ну и - привет. Окно БП уже сохранилось в историю для КЗ. А потом оно будет пытаться восстанавливаться. Ну и - бабах.
  // Вернул Assert
   // См. TPrimBaseSearchForm.DoSaveState
   //  f_BaseSearcher.Presentation := nil
  if (l_State = nil) then
  begin
   Result := false;
   Self.SafeClose;
  end//l_State = nil
  else
  begin
   f_BaseSearcher := TnsBaseSearchService.Instance.GetBaseSearcher(As_IvcmEntityForm);
   f_BaseSearcher.AssignState((l_State.Data as InsBaseSearcher).MakeStateParams(ns_sseAll, True));
   Assert(f_BaseSearcher <> nil);
   f_ActiveClassForSaveInHistory := l_State.ActiveClass;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=327826220
   AfterSearcherSet;
   Result := true;
  end;//l_State = nil
 end//aStateType = vcm_stContent
 else
  Result := inherited DoLoadState(aState, aStateType);
//#UC END# *49807428008C_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoLoadState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimBaseSearchForm.NeedDrawCaption: Boolean;
//#UC START# *4A84183701B9_4AB791130260_var*
//#UC END# *4A84183701B9_4AB791130260_var*
begin
//#UC START# *4A84183701B9_4AB791130260_impl*
 Result := false;
//#UC END# *4A84183701B9_4AB791130260_impl*
end;//TPrimBaseSearchForm.NeedDrawCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.BecomeActive;
//#UC START# *4A8AE0FA03B2_4AB791130260_var*
//#UC END# *4A8AE0FA03B2_4AB791130260_var*
begin
//#UC START# *4A8AE0FA03B2_4AB791130260_impl*
 inherited;
 f_IsActive := True;
//#UC END# *4A8AE0FA03B2_4AB791130260_impl*
end;//TPrimBaseSearchForm.BecomeActive
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.InitControls;
//#UC START# *4A8E8F2E0195_4AB791130260_var*
//#UC END# *4A8E8F2E0195_4AB791130260_var*
begin
//#UC START# *4A8E8F2E0195_4AB791130260_impl*
 inherited;
 with ContextEdit do
 begin
  BorderStyle := bsNone;
  MaxLength := cMaxLen;
  OnPastingString := Self.ContextEditPastingString;
  OnChange := Self.ContextEditChange;
  OnSelect := Self.ContextEditSelect;
 end;//with ContextEdit
 with FlashTimer do
 begin
  Enabled := False;
  Interval := 250;
  OnTimer := Self.FlashTimerTimer;
 end;//with FlashTimer
//#UC END# *4A8E8F2E0195_4AB791130260_impl*
end;//TPrimBaseSearchForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.BecomeInactive;
//#UC START# *4AD5FA8E03DD_4AB791130260_var*
//#UC END# *4AD5FA8E03DD_4AB791130260_var*
begin
//#UC START# *4AD5FA8E03DD_4AB791130260_impl*
 f_IsActive := False;
//#UC END# *4AD5FA8E03DD_4AB791130260_impl*
end;//TPrimBaseSearchForm.BecomeInactive
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimBaseSearchForm.CreateFormGUID(var theGUID: TGUID);
//#UC START# *4EBBC63E032A_4AB791130260_var*
//#UC END# *4EBBC63E032A_4AB791130260_var*
begin
//#UC START# *4EBBC63E032A_4AB791130260_impl*
 if MainMenuLikeBaseSearch then
 // - разделяем случай когда БП встроен в ОМ и все остальные, а иначе при хождении
 //   по истории пропадает БП из ОМ
  inherited CreateFormGUID(theGUID)
 else
  //theGUID := NewBaseSearchFormDef;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=297701079
  // - проблема была в том, что иначе при создании формы по истории MakeSingleChild
  //   не находил уже созданной копии.
  TnsBaseSearchFormGUIDFactory.Instance.CreateFormGUID(Self.As_IvcmEntityForm, theGUID);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=330139744
  // http://mdp.garant.ru/pages/viewpage.action?pageId=330139744&focusedCommentId=330142549#comment-330142549
//#UC END# *4EBBC63E032A_4AB791130260_impl*
end;//TPrimBaseSearchForm.CreateFormGUID
{$IfEnd} //not NoVCM

procedure TPrimBaseSearchForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ActiveClassForSaveInHistory := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimBaseSearchForm.ClearFields

{$If not defined(NoVCM)}
function TPrimBaseSearchForm.DoGetNeedSaveToTabHistory: Boolean;
//#UC START# *55B9F0BD0069_4AB791130260_var*
//#UC END# *55B9F0BD0069_4AB791130260_var*
begin
//#UC START# *55B9F0BD0069_4AB791130260_impl*
 Result := {not MainMenuLikeBaseSearch}True;
//#UC END# *55B9F0BD0069_4AB791130260_impl*
end;//TPrimBaseSearchForm.DoGetNeedSaveToTabHistory
{$IfEnd} //not NoVCM

procedure TPrimBaseSearchForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_EnclosedForms, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, nil);
  ShowInContextMenu(en_Result, op_OkExt, true);
  ShowInToolbar(en_Result, op_OkExt, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, nil);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, false);
  {$IfEnd} //not NoVCM

  PublishOp(en_EnclosedForms, op_CloseChild, EnclosedForms_CloseChild_Execute, EnclosedForms_CloseChild_Test, nil);
  ShowInContextMenu(en_EnclosedForms, op_CloseChild, false);
  ShowInToolbar(en_EnclosedForms, op_CloseChild, false);
 end;//with Entities.Entities
end;

procedure TPrimBaseSearchForm.MakeControls;
begin
 inherited;
 f_FlashTimer := TTimer.Create(Self);
 f_FlashTimer.Name := 'FlashTimer';
 with AddUsertype(BaseSearchName,
  str_BaseSearchCaption,
  str_BaseSearchCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(BaseSearchName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_BaseSearchCaption
 str_BaseSearchCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimBaseSearch
 TtfwClassRef.Register(TPrimBaseSearchForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.