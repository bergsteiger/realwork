unit PrimPreview_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPreview_Form.pas"
// Начат: 15.09.2009 14:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPreview
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscPreviewPanel
  {$IfEnd} //Nemesis
  ,
  Search_Strange_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  Search_ScalingSupport_Controls
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimPreview_utPrintPreview_UserType
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmBase {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimPreviewForm = {abstract form} class(_vcmChromeLikeTabIconUpdater_)
 private
 // private fields
   f_PreviewPanel : TnscPreviewPanel;
    {* Поле для свойства PreviewPanel}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure File_Print_Test(const aParams: IvcmTestParamsPrim);
     {* Печать }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
     {* Печать... }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   function Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
     {* Изменить масштаб }
   procedure Scalable_ChangeScale(const aParams: IvcmExecuteParams);
     {* Изменить масштаб }
   function Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
     {* Масштабирование запрещено }
   procedure Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
     {* Масштабирование запрещено }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
   function DoGetTabImageIndex: Integer; override;
    {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
 protected
 // protected fields
   f_Preview : IafwDocumentPreview;
 protected
 // protected methods
   function IsReady: Boolean;
     {* все готово, можно печатать }
   function Preview: IafwDocumentPreview;
 public
 // public methods
   class function Make(const aData: IafwDocumentPreview;
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property PreviewPanel: TnscPreviewPanel
     read f_PreviewPanel;
 end;//TPrimPreviewForm

 TvcmEntityFormRef = TPrimPreviewForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsTrialSupport,
  evStyles_SH,
  nsTabbedInterfaceTypes,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

type _Instance_R_ = TPrimPreviewForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

var
   { Локализуемые строки utPrintPreviewLocalConstants }
  str_utPrintPreviewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utPrintPreviewCaption'; rValue : 'Предварительный просмотр печати');
   { Заголовок пользовательского типа "Предварительный просмотр печати" }

var
   { Локализуемые строки Local }
  str_PrintPreviewTabCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintPreviewTabCaption'; rValue : 'Предварительный просмотр');
   { 'Предварительный просмотр' }

// start class TPrimPreviewForm

function TPrimPreviewForm.IsReady: Boolean;
//#UC START# *4AC61241009B_4AAF6F4E010E_var*
//#UC END# *4AC61241009B_4AAF6F4E010E_var*
begin
//#UC START# *4AC61241009B_4AAF6F4E010E_impl*
 Result := (PreviewPanel <> nil) AND PreviewPanel.IsReady and
           PreviewPanel.Preview.Printer.HasPrinter and
           not PreviewPanel.Preview.InPrinting;
//#UC END# *4AC61241009B_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.IsReady

function TPrimPreviewForm.Preview: IafwDocumentPreview;
//#UC START# *4AC612AF032F_4AAF6F4E010E_var*
//#UC END# *4AC612AF032F_4AAF6F4E010E_var*
begin
//#UC START# *4AC612AF032F_4AAF6F4E010E_impl*
 if (f_Preview = nil) AND (PreviewPanel <> nil) then
  f_Preview := PreviewPanel.Preview;
 Result := f_Preview;
//#UC END# *4AC612AF032F_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Preview

class function TPrimPreviewForm.Make(const aData: IafwDocumentPreview;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimPreviewForm);
 begin
  with aForm do
  begin
//#UC START# *4AC610DF03A7_4AAF6F4E010E_impl*
   f_Preview := aData;
   PreviewPanel.Preview := f_Preview;
//#UC END# *4AC610DF03A7_4AAF6F4E010E_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.File_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49521D8E0295_4AAF6F4E010Etest_var*
//#UC END# *49521D8E0295_4AAF6F4E010Etest_var*
begin
//#UC START# *49521D8E0295_4AAF6F4E010Etest_impl*
 aParams.CallControl;
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)} 
 nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *49521D8E0295_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.File_Print_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.File_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *495220DE0298_4AAF6F4E010Etest_var*
//#UC END# *495220DE0298_4AAF6F4E010Etest_var*
begin
//#UC START# *495220DE0298_4AAF6F4E010Etest_impl*
 aParams.CallControl;
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)} 
 nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *495220DE0298_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.File_PrintDialog_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD46D0226_4AAF6F4E010Eexec_var*
//#UC END# *4A8AD46D0226_4AAF6F4E010Eexec_var*
begin
//#UC START# *4A8AD46D0226_4AAF6F4E010Eexec_impl*
 if IsModalForm then
  ModalResult := mrCancel
 else
  Dispatcher.History.Back;
//#UC END# *4A8AD46D0226_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.Result_Ok_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A97EBE702F8_4AAF6F4E010Etest_var*
//#UC END# *4A97EBE702F8_4AAF6F4E010Etest_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Etest_impl*
 if not IsReady then
  aParams.Op.Flag[vcm_ofEnabled] := false;
 {$If not defined(Admin) AND not defined(Monitorings)}
 nsDisableOperationInTrialMode(aParams);
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *4A97EBE702F8_4AAF6F4E010Etest_impl*
end;//TPrimPreviewForm.Result_Ok_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.Result_Ok_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A97EBE702F8_4AAF6F4E010Egetstate_var*
//#UC END# *4A97EBE702F8_4AAF6F4E010Egetstate_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Egetstate_impl*
 State := st_user_Result_Ok_Print;
//#UC END# *4A97EBE702F8_4AAF6F4E010Egetstate_impl*
end;//TPrimPreviewForm.Result_Ok_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.Result_Ok_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A97EBE702F8_4AAF6F4E010Eexec_var*
var
 l_Printed: Boolean;
//#UC END# *4A97EBE702F8_4AAF6F4E010Eexec_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010Eexec_impl*
 l_Printed := PreviewPanel.Print;
 if IsModalForm then
  ModalResult := mrOk
 else
  if l_Printed then
   Dispatcher.History.Back;
//#UC END# *4A97EBE702F8_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Result_Ok_Execute
{$IfEnd} //not NoVCM

function TPrimPreviewForm.Scalable_ChangeScale_Execute(aInc: Boolean): Boolean;
//#UC START# *4BB32C1401C0_4AAF6F4E010Eexec_var*
//#UC END# *4BB32C1401C0_4AAF6F4E010Eexec_var*
begin
//#UC START# *4BB32C1401C0_4AAF6F4E010Eexec_impl*
 Result := False;
//#UC END# *4BB32C1401C0_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Scalable_ChangeScale_Execute

procedure TPrimPreviewForm.Scalable_ChangeScale(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IScalable_ChangeScale_Params) do
  ResultValue := Scalable_ChangeScale_Execute(Inc);
end;

function TPrimPreviewForm.Scalable_CanChangeScale_Execute(anInc: Boolean): TCanChangeScale;
//#UC START# *4BB366A901D7_4AAF6F4E010Eexec_var*
const
 cCanChangeScaleArr : array[Boolean] of TCanChangeScale = (ccsNo, ccsYesIfPossible);
//#UC END# *4BB366A901D7_4AAF6F4E010Eexec_var*
begin
//#UC START# *4BB366A901D7_4AAF6F4E010Eexec_impl*
 Result := cCanChangeScaleArr[SHevStyles.PrintAndExportDefaultSetting];
//#UC END# *4BB366A901D7_4AAF6F4E010Eexec_impl*
end;//TPrimPreviewForm.Scalable_CanChangeScale_Execute

procedure TPrimPreviewForm.Scalable_CanChangeScale(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IScalable_CanChangeScale_Params) do
  ResultValue := Scalable_CanChangeScale_Execute(nInc);
end;

procedure TPrimPreviewForm.Cleanup;
//#UC START# *479731C50290_4AAF6F4E010E_var*
//#UC END# *479731C50290_4AAF6F4E010E_var*
begin
//#UC START# *479731C50290_4AAF6F4E010E_impl*
 f_Preview := nil;
 inherited;
//#UC END# *479731C50290_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Cleanup

procedure TPrimPreviewForm.InitFields;
//#UC START# *47A042E100E2_4AAF6F4E010E_var*
//#UC END# *47A042E100E2_4AAF6F4E010E_var*
begin
//#UC START# *47A042E100E2_4AAF6F4E010E_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *47A042E100E2_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.InitFields

{$If not defined(NoVCM)}
function TPrimPreviewForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_4AAF6F4E010E_var*
//#UC END# *4980407F0076_4AAF6F4E010E_var*
begin
//#UC START# *4980407F0076_4AAF6F4E010E_impl*
 Result := inherited CallCloseQuery(aCaller);
 if Result AND (Preview <> nil) AND Preview.InProcess then
 begin
  // Разрешаем удалять во время подготовки печати, потому, что защитили
  // соответствующие методы в Preview вызовами afw.BeginOp, afw.EndOp;
  //Result := false;
  Preview.Stop(Handle);
 end;//Result
//#UC END# *4980407F0076_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.CallCloseQuery
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimPreviewForm.InitControls;
//#UC START# *4A8E8F2E0195_4AAF6F4E010E_var*
//#UC END# *4A8E8F2E0195_4AAF6F4E010E_var*
begin
//#UC START# *4A8E8F2E0195_4AAF6F4E010E_impl*
 ActiveControl := PreviewPanel;
 with PreviewPanel do
 begin
  Cursor := 1;
  Align := alClient;
  BevelOuter := bvNone;
  Constraints.MinHeight := 120;
  Constraints.MinWidth := 160;
  UseDockManager := False;
  TabOrder := 0;
  TabStop := True;
 end;
//#UC END# *4A8E8F2E0195_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimPreviewForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_var*
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_var*
begin
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_impl*
 Result := str_PrintPreviewTabCaption.AsCStr;
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabCaption
{$IfEnd} //not NoVCM

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
function TPrimPreviewForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4AAF6F4E010E_var*
//#UC END# *543E3AA801D0_4AAF6F4E010E_var*
begin
//#UC START# *543E3AA801D0_4AAF6F4E010E_impl*
 Result := NsTabIconIndex(titPrintPreview);
//#UC END# *543E3AA801D0_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabImageIndex
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

procedure TPrimPreviewForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Scalable, nil);
  PublishFormEntity(en_Preview, nil);
  PublishFormEntity(en_Document, nil);
  ToolbarAtBottom(en_Result);
  ToolbarAtBottom(en_Result);
  ContextMenuWeight(en_File, -1);
  ContextMenuWeight(en_Result, 10);
  {$If not defined(NoVCM)}
  PublishOp(en_File, op_Print, nil, File_Print_Test, nil);
  ShowInToolbar(en_File, op_Print, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_File, op_PrintDialog, nil, File_PrintDialog_Test, nil);
  ShowInContextMenu(en_File, op_PrintDialog, false);
  ShowInToolbar(en_File, op_PrintDialog, false);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, nil, nil);
  ShowInContextMenu(en_Result, op_Cancel, false);
  ShowInToolbar(en_Result, op_Cancel, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Ok, Result_Ok_Execute, Result_Ok_Test, Result_Ok_GetState);
  ShowInContextMenu(en_Result, op_Ok, false);
  ShowInToolbar(en_Result, op_Ok, true);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_Scalable, op_ChangeScale, Scalable_ChangeScale, nil, nil);
  PublishOpWithResult(en_Scalable, op_CanChangeScale, Scalable_CanChangeScale, nil, nil);
  PublishOp(en_Preview, op_ZoomIn, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomIn, true);
  ShowInToolbar(en_Preview, op_ZoomIn, true);
  ContextMenuWeight(en_Preview, op_ZoomIn, 1);
  PublishOp(en_Preview, op_ZoomOut, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomOut, true);
  ShowInToolbar(en_Preview, op_ZoomOut, true);
  ContextMenuWeight(en_Preview, op_ZoomOut, 2);
  PublishOp(en_Preview, op_ZoomWidth, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomWidth, true);
  ShowInToolbar(en_Preview, op_ZoomWidth, true);
  ContextMenuWeight(en_Preview, op_ZoomWidth, 3);
  PublishOp(en_Preview, op_ZoomPage, nil, nil, nil);
  ShowInContextMenu(en_Preview, op_ZoomPage, true);
  ShowInToolbar(en_Preview, op_ZoomPage, true);
  ContextMenuWeight(en_Preview, op_ZoomPage, 4);
  PublishOp(en_Document, op_FullSelectedSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_FullSelectedSwitch, true);
  ShowInToolbar(en_Document, op_FullSelectedSwitch, true);
  PublishOp(en_Document, op_RGBGrayscaleSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_RGBGrayscaleSwitch, true);
  ShowInToolbar(en_Document, op_RGBGrayscaleSwitch, true);
  PublishOp(en_Document, op_PrintInfoSwitch, nil, nil, nil);
  ShowInContextMenu(en_Document, op_PrintInfoSwitch, true);
  ShowInToolbar(en_Document, op_PrintInfoSwitch, true);
 end;//with Entities.Entities
end;

procedure TPrimPreviewForm.MakeControls;
begin
 inherited;
 f_PreviewPanel := TnscPreviewPanel.Create(Self);
 f_PreviewPanel.Name := 'PreviewPanel';
 f_PreviewPanel.Parent := Self;
 with AddUsertype(utPrintPreviewName,
  str_utPrintPreviewCaption,
  str_utPrintPreviewCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utPrintPreviewName
end;

{$IfEnd} //not Admin

initialization
{$If not defined(Admin)}
// Инициализация str_utPrintPreviewCaption
 str_utPrintPreviewCaption.Init;
{$IfEnd} //not Admin
{$If not defined(Admin)}
// Инициализация str_PrintPreviewTabCaption
 str_PrintPreviewTabCaption.Init;
{$IfEnd} //not Admin
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimPreview
 TtfwClassRef.Register(TPrimPreviewForm);
{$IfEnd} //not Admin AND not NoScripts

end.