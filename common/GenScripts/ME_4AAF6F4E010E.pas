unit PrimPreview_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Search_ScalingSupport_Controls
 , Search_Strange_Controls
 , afwInterfaces
 {$If Defined(Nemesis)}
 , nscPreviewPanel
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

type
 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimPreviewForm = {abstract} class(_vcmChromeLikeTabIconUpdater_)
  private
   f_PreviewPanel: TnscPreviewPanel;
    {* Поле для свойства PreviewPanel }
  protected
   f_Preview: IafwDocumentPreview;
  protected
   function IsReady: Boolean;
    {* все готово, можно печатать }
   function Preview: IafwDocumentPreview;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   class function Make(const aData: IafwDocumentPreview): File; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Print; override;
    {* Печать }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure PrintDialog; override;
    {* Печать... }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   function ChangeScale: Boolean; override;
    {* Изменить масштаб }
   function CanChangeScale: TCanChangeScale; override;
    {* Масштабирование запрещено }
   procedure ZoomIn; override;
   procedure ZoomOut; override;
   procedure ZoomWidth; override;
   procedure ZoomPage; override;
   procedure FullSelectedSwitch; override;
   procedure RGBGrayscaleSwitch; override;
   procedure PrintInfoSwitch; override;
   {$If NOT Defined(NoVCM)}
   procedure Ok; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property PreviewPanel: TnscPreviewPanel
    read f_PreviewPanel;
 end;//TPrimPreviewForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTrialSupport
 , evStyles_SH
 , nsTabbedInterfaceTypes
 {$If NOT Defined(NoVCM)}
 , vcmHistoryService
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
;

const
 {* Локализуемые строки utPrintPreviewLocalConstants }
 str_utPrintPreviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utPrintPreviewCaption'; rValue : 'Предварительный просмотр печати');
  {* Заголовок пользовательского типа "Предварительный просмотр печати" }
 {* Локализуемые строки Local }
 str_PrintPreviewTabCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrintPreviewTabCaption'; rValue : 'Предварительный просмотр');
  {* 'Предварительный просмотр' }

type _Instance_R_ = TPrimPreviewForm;

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas}

function TPrimPreviewForm.IsReady: Boolean;
 {* все готово, можно печатать }
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

class function TPrimPreviewForm.Make(const aData: IafwDocumentPreview): File;
var
 l_Inst : TPrimPreviewForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimPreviewForm.Make

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.Print;
 {* Печать }
//#UC START# *49521D8E0295_4AAF6F4E010E_var*
//#UC END# *49521D8E0295_4AAF6F4E010E_var*
begin
//#UC START# *49521D8E0295_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *49521D8E0295_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Print
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.PrintDialog;
 {* Печать... }
//#UC START# *495220DE0298_4AAF6F4E010E_var*
//#UC END# *495220DE0298_4AAF6F4E010E_var*
begin
//#UC START# *495220DE0298_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *495220DE0298_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.PrintDialog
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.Cancel;
 {* Отмена }
//#UC START# *4A8AD46D0226_4AAF6F4E010E_var*
//#UC END# *4A8AD46D0226_4AAF6F4E010E_var*
begin
//#UC START# *4A8AD46D0226_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD46D0226_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.Ok;
 {* OK }
//#UC START# *4A97EBE702F8_4AAF6F4E010E_var*
//#UC END# *4A97EBE702F8_4AAF6F4E010E_var*
begin
//#UC START# *4A97EBE702F8_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97EBE702F8_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

function TPrimPreviewForm.ChangeScale: Boolean;
 {* Изменить масштаб }
//#UC START# *4BB32C1401C0_4AAF6F4E010E_var*
//#UC END# *4BB32C1401C0_4AAF6F4E010E_var*
begin
//#UC START# *4BB32C1401C0_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BB32C1401C0_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.ChangeScale

function TPrimPreviewForm.CanChangeScale: TCanChangeScale;
 {* Масштабирование запрещено }
//#UC START# *4BB366A901D7_4AAF6F4E010E_var*
//#UC END# *4BB366A901D7_4AAF6F4E010E_var*
begin
//#UC START# *4BB366A901D7_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BB366A901D7_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.CanChangeScale

procedure TPrimPreviewForm.ZoomIn;
//#UC START# *4C43D04C01D8_4AAF6F4E010E_var*
//#UC END# *4C43D04C01D8_4AAF6F4E010E_var*
begin
//#UC START# *4C43D04C01D8_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D04C01D8_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.ZoomIn

procedure TPrimPreviewForm.ZoomOut;
//#UC START# *4C43D058000A_4AAF6F4E010E_var*
//#UC END# *4C43D058000A_4AAF6F4E010E_var*
begin
//#UC START# *4C43D058000A_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D058000A_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.ZoomOut

procedure TPrimPreviewForm.ZoomWidth;
//#UC START# *4C43D0610127_4AAF6F4E010E_var*
//#UC END# *4C43D0610127_4AAF6F4E010E_var*
begin
//#UC START# *4C43D0610127_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D0610127_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.ZoomWidth

procedure TPrimPreviewForm.ZoomPage;
//#UC START# *4C43D06C0150_4AAF6F4E010E_var*
//#UC END# *4C43D06C0150_4AAF6F4E010E_var*
begin
//#UC START# *4C43D06C0150_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D06C0150_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.ZoomPage

procedure TPrimPreviewForm.FullSelectedSwitch;
//#UC START# *4C43D0A70151_4AAF6F4E010E_var*
//#UC END# *4C43D0A70151_4AAF6F4E010E_var*
begin
//#UC START# *4C43D0A70151_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D0A70151_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.FullSelectedSwitch

procedure TPrimPreviewForm.RGBGrayscaleSwitch;
//#UC START# *4C43D0B20376_4AAF6F4E010E_var*
//#UC END# *4C43D0B20376_4AAF6F4E010E_var*
begin
//#UC START# *4C43D0B20376_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D0B20376_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.RGBGrayscaleSwitch

procedure TPrimPreviewForm.PrintInfoSwitch;
//#UC START# *4C43D0C20003_4AAF6F4E010E_var*
//#UC END# *4C43D0C20003_4AAF6F4E010E_var*
begin
//#UC START# *4C43D0C20003_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C43D0C20003_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.PrintInfoSwitch

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.Ok;
 {* OK }
//#UC START# *4C762A1501FC_4AAF6F4E010E_var*
//#UC END# *4C762A1501FC_4AAF6F4E010E_var*
begin
//#UC START# *4C762A1501FC_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762A1501FC_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Ok
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.Cancel;
 {* Отмена }
//#UC START# *4C762AB601E1_4AAF6F4E010E_var*
//#UC END# *4C762AB601E1_4AAF6F4E010E_var*
begin
//#UC START# *4C762AB601E1_4AAF6F4E010E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762AB601E1_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPreviewForm.Cleanup;
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPreviewForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimPreviewForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_var*
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_var*
begin
//#UC START# *53F1C6EF02C9_4AAF6F4E010E_impl*
 Result := str_PrintPreviewTabCaption.AsCStr;
//#UC END# *53F1C6EF02C9_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimPreviewForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4AAF6F4E010E_var*
//#UC END# *543E3AA801D0_4AAF6F4E010E_var*
begin
//#UC START# *543E3AA801D0_4AAF6F4E010E_impl*
 Result := NsTabIconIndex(titPrintPreview);
//#UC END# *543E3AA801D0_4AAF6F4E010E_impl*
end;//TPrimPreviewForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
 str_utPrintPreviewCaption.Init;
 {* Инициализация str_utPrintPreviewCaption }
 str_PrintPreviewTabCaption.Init;
 {* Инициализация str_PrintPreviewTabCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPreviewForm);
 {* Регистрация PrimPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
