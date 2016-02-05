unit PrimPicture_Form;
 {* Рисунок }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Document_Strange_Controls
 , DocumentDomainInterfaces
 , L10nInterfaces
 , nsSaveDialog
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenproc
 {$IfEnd} // NOT Defined(NoImageEn)
 , Messages
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , Graphics
 , l3Interfaces
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 CM_AFTER_INIT = Messages.WM_USER + 201;

type
 TRange0_24 = 0 .. 24;

 TIntegerArray0_24 = array [TRange0_24] of Integer;

 TDelphiBitmap = TBitmap;
  {* Это нужно, чтобы избежать конфликтов между Graphics.TBitmap и Windows.TBitmap.
Спасибо, Borland. }

 IPictureFormState = interface(IvcmBase)
  ['{D1A52FF2-C978-4BD9-85E1-50127AB5E9C4}']
  function GetCaption: Il3CString;
  function GetBitmap: TDelphiBitmap;
  function GetScale: Integer;
  function GetFileName: TFileName;
  function GetInitialDir: AnsiString;
  function GetInfo: InsLinkedObjectDescription;
 end;//IPictureFormState

 TPictureFormState = class(TvcmCacheableBase{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , IPictureFormState)
  private
   f_Caption: Il3CString;
   f_Bitmap: TDelphiBitmap;
   f_Scale: Integer;
   f_FileName: TFileName;
   f_InitialDir: AnsiString;
   f_Info: InsLinkedObjectDescription;
  protected
   function GetCaption: Il3CString;
   function GetBitmap: TDelphiBitmap;
   function GetScale: Integer;
   function GetFileName: TFileName;
   function GetInitialDir: AnsiString;
   function GetInfo: InsLinkedObjectDescription;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aCaption: Il3CString;
    aBitmap: TDelphiBitmap;
    aScale: Integer;
    const aFileName: TFileName;
    const aInitialDir: AnsiString;
    const aInfo: InsLinkedObjectDescription); reintroduce;
   class function Make(const aCaption: Il3CString;
    aBitmap: TDelphiBitmap;
    aScale: Integer;
    const aFileName: TFileName;
    const aInitialDir: AnsiString;
    const aInfo: InsLinkedObjectDescription): IPictureFormState; reintroduce;
 end;//TPictureFormState

 _vcmChromeLikeTabIconUpdater_Parent_ = TvcmEntityForm;
 {$Include vcmChromeLikeTabIconUpdater.imp.pas}
 TPrimPictureForm = class(_vcmChromeLikeTabIconUpdater_)
  {* Рисунок }
  private
   f_InitViewer: Boolean;
   f_ieIO: TImageEnIO;
    {* Поле для свойства ieIO }
   f_ieViewer: TImageEnView;
    {* Поле для свойства ieViewer }
   f_ieProc: TImageEnProc;
    {* Поле для свойства ieProc }
   f_Scale: Integer;
    {* Поле для свойства Scale }
   f_SaveDialog: TnsSaveDialog;
    {* Поле для свойства SaveDialog }
  protected
   f_Info: InsLinkedObjectDescription;
   f_ValueMap: InsSpecialStringValueMap;
  private
   procedure AfterInit(var Message: TMessage);
  protected
   function Get_Scale: Integer;
   procedure Set_Scale(aValue: Integer);
   function GetSaveDialog: TnsSaveDialog;
   procedure FitInWindow;
   function CanEnlarge: Boolean;
   function CanShrink: Boolean;
   procedure Enlarge;
   procedure Shrink;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
    {* Сохраняет состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure FormInsertedIntoContainer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
   function DoGetTabImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
  public
   procedure InitNewContent; override;
  protected
   property Scale: Integer
    read Get_Scale
    write Set_Scale;
  public
   property ieIO: TImageEnIO
    read f_ieIO;
   property ieViewer: TImageEnView
    read f_ieViewer;
   property ieProc: TImageEnProc
    read f_ieProc;
   property SaveDialog: TnsSaveDialog
    read f_SaveDialog;
 end;//TPrimPictureForm

const
 FixedScales: TIntegerArray0_24 = (1, 2, 5, 10, 25, 50, 75, 100, 125, 150 , 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Stream
 , Classes
 , l3String
 , Windows
 , l3ValueMap
 , nsTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , afwFacade
 , nsTrialSupport
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Bitmap
 , nsConst
 , nsValueMaps
 {$If NOT Defined(NoImageEn)}
 , hyieutils
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , hyiedefs
 {$IfEnd} // NOT Defined(NoImageEn)
 , JclSysInfo
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , nsValueMapsIDs
 , l3InterfacesMisc
 {$If NOT Defined(NoImageEn)}
 , giflzw
 {$IfEnd} // NOT Defined(NoImageEn)
 , nsTabbedInterfaceTypes
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
;

const
 {* Локализуемые строки pfImageLocalConstants }
 str_pfImageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageCaption'; rValue : 'Просмотр графического объекта');
  {* Заголовок пользовательского типа "Просмотр графического объекта" }
 str_pfImageSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageSettingsCaption'; rValue : 'Документ: Просмотр графического объекта');
  {* Заголовок пользовательского типа "Просмотр графического объекта" для настройки панелей инструментов }

constructor TPictureFormState.Create(const aCaption: Il3CString;
 aBitmap: TDelphiBitmap;
 aScale: Integer;
 const aFileName: TFileName;
 const aInitialDir: AnsiString;
 const aInfo: InsLinkedObjectDescription);
//#UC START# *524951840150_52494F8A0055_var*
//#UC END# *524951840150_52494F8A0055_var*
begin
//#UC START# *524951840150_52494F8A0055_impl*
 inherited Create;
 f_Caption := aCaption;
 f_Bitmap := Graphics.TBitmap.Create;
 f_Scale := aScale;
 f_Bitmap.Assign(aBitmap);
 f_FileName := aFileName;
 f_InitialDir := aInitialDir;
 f_Info := aInfo;
//#UC END# *524951840150_52494F8A0055_impl*
end;//TPictureFormState.Create

class function TPictureFormState.Make(const aCaption: Il3CString;
 aBitmap: TDelphiBitmap;
 aScale: Integer;
 const aFileName: TFileName;
 const aInitialDir: AnsiString;
 const aInfo: InsLinkedObjectDescription): IPictureFormState;
var
 l_Inst : TPictureFormState;
begin
 l_Inst := Create(aCaption, aBitmap, aScale, aFileName, aInitialDir, aInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPictureFormState.Make

function TPictureFormState.GetCaption: Il3CString;
//#UC START# *52494EE802F8_52494F8A0055_var*
//#UC END# *52494EE802F8_52494F8A0055_var*
begin
//#UC START# *52494EE802F8_52494F8A0055_impl*
 Result := f_Caption;
//#UC END# *52494EE802F8_52494F8A0055_impl*
end;//TPictureFormState.GetCaption

function TPictureFormState.GetBitmap: TDelphiBitmap;
//#UC START# *52494EF50330_52494F8A0055_var*
//#UC END# *52494EF50330_52494F8A0055_var*
begin
//#UC START# *52494EF50330_52494F8A0055_impl*
 Result := f_Bitmap;
//#UC END# *52494EF50330_52494F8A0055_impl*
end;//TPictureFormState.GetBitmap

function TPictureFormState.GetScale: Integer;
//#UC START# *52494F19039C_52494F8A0055_var*
//#UC END# *52494F19039C_52494F8A0055_var*
begin
//#UC START# *52494F19039C_52494F8A0055_impl*
 Result := f_Scale;
//#UC END# *52494F19039C_52494F8A0055_impl*
end;//TPictureFormState.GetScale

function TPictureFormState.GetFileName: TFileName;
//#UC START# *52494F2E0141_52494F8A0055_var*
//#UC END# *52494F2E0141_52494F8A0055_var*
begin
//#UC START# *52494F2E0141_52494F8A0055_impl*
 Result := f_FileName;
//#UC END# *52494F2E0141_52494F8A0055_impl*
end;//TPictureFormState.GetFileName

function TPictureFormState.GetInitialDir: AnsiString;
//#UC START# *52494F3D0323_52494F8A0055_var*
//#UC END# *52494F3D0323_52494F8A0055_var*
begin
//#UC START# *52494F3D0323_52494F8A0055_impl*
 Result := f_InitialDir;
//#UC END# *52494F3D0323_52494F8A0055_impl*
end;//TPictureFormState.GetInitialDir

function TPictureFormState.GetInfo: InsLinkedObjectDescription;
//#UC START# *52494F4F0135_52494F8A0055_var*
//#UC END# *52494F4F0135_52494F8A0055_var*
begin
//#UC START# *52494F4F0135_52494F8A0055_impl*
 Result := f_Info;
//#UC END# *52494F4F0135_52494F8A0055_impl*
end;//TPictureFormState.GetInfo

procedure TPictureFormState.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52494F8A0055_var*
//#UC END# *479731C50290_52494F8A0055_var*
begin
//#UC START# *479731C50290_52494F8A0055_impl*
 f_Caption := nil;
 f_Info := nil;
 FreeAndNil(f_Bitmap);
 inherited;
//#UC END# *479731C50290_52494F8A0055_impl*
end;//TPictureFormState.Cleanup

type _Instance_R_ = TPrimPictureForm;

{$Include vcmChromeLikeTabIconUpdater.imp.pas}

function TPrimPictureForm.Get_Scale: Integer;
//#UC START# *4C87765001CE_4AAFCFB0014Bget_var*
//#UC END# *4C87765001CE_4AAFCFB0014Bget_var*
begin
//#UC START# *4C87765001CE_4AAFCFB0014Bget_impl*
 Result := f_Scale;
// Result := Integer(GetLongint(pi_Document_ImageScale, dv_Document_ImageScale));
//#UC END# *4C87765001CE_4AAFCFB0014Bget_impl*
end;//TPrimPictureForm.Get_Scale

procedure TPrimPictureForm.Set_Scale(aValue: Integer);
//#UC START# *4C87765001CE_4AAFCFB0014Bset_var*
//#UC END# *4C87765001CE_4AAFCFB0014Bset_var*
begin
//#UC START# *4C87765001CE_4AAFCFB0014Bset_impl*
 if aValue < 1 then
  FitInWindow
 else
 begin
  f_Scale := aValue;
  ieViewer.AutoFit := False;
  ieViewer.Zoom := f_Scale;
 end;
// PutLongint(pi_Document_ImageScale, Longint(aPercentage));
 {Image.Align := alNone;
 Image.Width  := (Image.Picture.Width  * f_Scale) div 100;
 Image.Height := (Image.Picture.Height * f_Scale) div 100;
 }
//#UC END# *4C87765001CE_4AAFCFB0014Bset_impl*
end;//TPrimPictureForm.Set_Scale

function TPrimPictureForm.GetSaveDialog: TnsSaveDialog;
//#UC START# *5245B8BC031D_4AAFCFB0014B_var*
//#UC END# *5245B8BC031D_4AAFCFB0014B_var*
begin
//#UC START# *5245B8BC031D_4AAFCFB0014B_impl*
 Result := SaveDialog;
//#UC END# *5245B8BC031D_4AAFCFB0014B_impl*
end;//TPrimPictureForm.GetSaveDialog

procedure TPrimPictureForm.FitInWindow;
//#UC START# *4C8775950053_4AAFCFB0014B_var*
//#UC END# *4C8775950053_4AAFCFB0014B_var*
begin
//#UC START# *4C8775950053_4AAFCFB0014B_impl*
 with ieViewer do
 begin
  AutoFit := True;
  f_Scale := Round(Zoom);
 end;
//#UC END# *4C8775950053_4AAFCFB0014B_impl*
end;//TPrimPictureForm.FitInWindow

function TPrimPictureForm.CanEnlarge: Boolean;
//#UC START# *4C8775AA017A_4AAFCFB0014B_var*
//#UC END# *4C8775AA017A_4AAFCFB0014B_var*
begin
//#UC START# *4C8775AA017A_4AAFCFB0014B_impl*
 Result := Scale < f_ValueMap.MaxValue;
//#UC END# *4C8775AA017A_4AAFCFB0014B_impl*
end;//TPrimPictureForm.CanEnlarge

function TPrimPictureForm.CanShrink: Boolean;
//#UC START# *4C8775D301F7_4AAFCFB0014B_var*
//#UC END# *4C8775D301F7_4AAFCFB0014B_var*
begin
//#UC START# *4C8775D301F7_4AAFCFB0014B_impl*
 Result := Scale > f_ValueMap.MinValue;
//#UC END# *4C8775D301F7_4AAFCFB0014B_impl*
end;//TPrimPictureForm.CanShrink

procedure TPrimPictureForm.Enlarge;
//#UC START# *4C8775F60070_4AAFCFB0014B_var*
var
 I: Integer;
//#UC END# *4C8775F60070_4AAFCFB0014B_var*
begin
//#UC START# *4C8775F60070_4AAFCFB0014B_impl*
 ieViewer.AutoFit := False;
 for I := Low(FixedScales) to High(FixedScales) do
  if FixedScales[I] > Scale then
  begin
   Scale := FixedScales[I];
   Break;
  end;
//#UC END# *4C8775F60070_4AAFCFB0014B_impl*
end;//TPrimPictureForm.Enlarge

procedure TPrimPictureForm.Shrink;
//#UC START# *4C87761302DC_4AAFCFB0014B_var*
var
 I: Integer;
//#UC END# *4C87761302DC_4AAFCFB0014B_var*
begin
//#UC START# *4C87761302DC_4AAFCFB0014B_impl*
 ieViewer.AutoFit := False;
 for I := High(FixedScales) downto Low(FixedScales) do
  if FixedScales[I] < Scale then
  begin
   Scale := FixedScales[I];
   Break;
  end;
//#UC END# *4C87761302DC_4AAFCFB0014B_impl*
end;//TPrimPictureForm.Shrink

procedure TPrimPictureForm.AfterInit(var Message: TMessage);
//#UC START# *52493BD40232_4AAFCFB0014B_var*
var
 l_Value : Il3CString;
//#UC END# *52493BD40232_4AAFCFB0014B_var*
begin
//#UC START# *52493BD40232_4AAFCFB0014B_impl*
 if not ieViewer.IEBitmap.VclBitmap.Empty then
 begin
  f_InitViewer := True;
  l_Value := afw.Settings.LoadString(piDocumentPictureScale, dvDocumentPictureScale);
  if l3Same(l_Value, cvDocumentPictureScaleFit) then
   FitInWindow
  else
   Scale := StrToInt(l3Str(l_Value));
 end;//not ieViewer.IEBitmap.VclBitmap.Empty
//#UC END# *52493BD40232_4AAFCFB0014B_impl*
end;//TPrimPictureForm.AfterInit

procedure TPrimPictureForm.InitNewContent;
//#UC START# *4AF32F3102BE_4AAFCFB0014B_var*
//#UC END# *4AF32F3102BE_4AAFCFB0014B_var*
begin
//#UC START# *4AF32F3102BE_4AAFCFB0014B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF32F3102BE_4AAFCFB0014B_impl*
end;//TPrimPictureForm.InitNewContent

procedure TPrimPictureForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AAFCFB0014B_var*
//#UC END# *479731C50290_4AAFCFB0014B_var*
begin
//#UC START# *479731C50290_4AAFCFB0014B_impl*
 f_ValueMap := nil;
 f_Info := nil;
 inherited;
//#UC END# *479731C50290_4AAFCFB0014B_impl*
end;//TPrimPictureForm.Cleanup

procedure TPrimPictureForm.InitFields;
//#UC START# *47A042E100E2_4AAFCFB0014B_var*
//#UC END# *47A042E100E2_4AAFCFB0014B_var*
begin
//#UC START# *47A042E100E2_4AAFCFB0014B_impl*
 inherited;
 f_ValueMap := nsStringMapManager.Map[smap_piDocumentPictureScale] as InsSpecialStringValueMap;
 with ieViewer.MouseWheelParams do
 begin
  Action := iemwVScroll;
  Variation := iemwPercentage;
  Value := 15;
 end;
 f_SaveDialog := TnsSaveDialog.Create(Self);
 with f_SaveDialog do
 begin
  Filter := vcmConstString(str_PictuteSaveDialogFilter);
  Title := vcmConstString(str_SaveAsDialogTitle);
  DefaultExt := vcmConstString(str_PictuteSaveDialogExtension);
  if GetWindowsVersion in [wvWin95, wvWin95OSR2, wvWinNT31, wvWinNT35, wvWinNT351, wvWinNT4] then
   Options := [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
  else
   Options := [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing, ofPathMustExist];
 end;
//#UC END# *47A042E100E2_4AAFCFB0014B_impl*
end;//TPrimPictureForm.InitFields

{$If NOT Defined(NoVCM)}
function TPrimPictureForm.DoSaveState(out theState: IvcmBase;
 aStateType: TvcmStateType;
 aForClone: Boolean): Boolean;
 {* Сохраняет состояние формы. Для перекрытия в потомках }
//#UC START# *49806ED503D5_4AAFCFB0014B_var*
var
 l_Scale : Integer;
//#UC END# *49806ED503D5_4AAFCFB0014B_var*
begin
//#UC START# *49806ED503D5_4AAFCFB0014B_impl*
 if aStateType = vcm_stContent then
 begin
  if ieViewer.AutoFit then
   l_Scale := -1
  else
   l_Scale := Scale;
  theState := TPictureFormState.Make(CCaption, ieViewer.IEBitmap.VclBitmap, l_Scale,
   SaveDialog.FileName, SaveDialog.InitialDir, f_Info);
 end;
//#UC END# *49806ED503D5_4AAFCFB0014B_impl*
end;//TPrimPictureForm.DoSaveState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimPictureForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_4AAFCFB0014B_var*
var
 l_PictureFormState : IPictureFormState;
 l_Scale            : Integer;
//#UC END# *49807428008C_4AAFCFB0014B_var*
begin
//#UC START# *49807428008C_4AAFCFB0014B_impl*
 if aStateType = vcm_stContent then
 if (l3BQueryInterface(aState, IPictureFormState, l_PictureFormState)) then
 begin
  CCaption := l_PictureFormState.GetCaption;
  SaveDialog.FileName := l_PictureFormState.GetFileName;
//  SaveDialog.InitialDir := l_PictureFormState.GetInitialDir;
  ieViewer.IEBitmap.Assign(l_PictureFormState.GetBitmap);
  l_Scale := l_PictureFormState.GetScale;
  if l_Scale > 1 then
   Scale := l_Scale
  else
   FitInWindow;
  f_Info := l_PictureFormState.GetInfo;
 end
 else
  Assert(False);
//#UC END# *49807428008C_4AAFCFB0014B_impl*
end;//TPrimPictureForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AAFCFB0014B_var*
//#UC END# *4A8E8F2E0195_4AAFCFB0014B_var*
begin
//#UC START# *4A8E8F2E0195_4AAFCFB0014B_impl*
 //ScrollBox.DoubleBuffered := true;
 ActiveControl := ieViewer;
 f_InitViewer := False;

 with ieViewer do
 begin
  Cursor := crArrow;
  BorderStyle := bsNone;
  LegacyBitmap := False;
  ZoomFilter := rfLanczos3;
  MouseInteract := [miScroll];
  DelayZoomFilter := True;
  Align := alClient;
  TabOrder := 0;
 end;
 with ieIO do
 begin
  AttachedImageEn := ieViewer;
  Background := $00F9F8FA;
  PreviewFont.Charset := RUSSIAN_CHARSET;
  PreviewFont.Color := clWindowText;
  PreviewFont.Height := -11;
  PreviewFont.Name := 'MS Sans Serif';
  PreviewFont.Style := [];
 end;
 with ieProc do
 begin
  AttachedImageEn := ieViewer;
  Background := $00F9F8FA;
  PreviewFont.Charset := RUSSIAN_CHARSET;
  PreviewFont.Color := clWindowText;
  PreviewFont.Height := -11;
  PreviewFont.Name := 'MS Sans Serif';
  PreviewFont.Style := [];
 end;
//#UC END# *4A8E8F2E0195_4AAFCFB0014B_impl*
end;//TPrimPictureForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimPictureForm.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_4AAFCFB0014B_var*
//#UC END# *4F7C65380244_4AAFCFB0014B_var*
begin
//#UC START# *4F7C65380244_4AAFCFB0014B_impl*
 if ieViewer.CanFocus then
 begin
  ieViewer.SetFocus;
 end;
//#UC END# *4F7C65380244_4AAFCFB0014B_impl*
end;//TPrimPictureForm.FormInsertedIntoContainer
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimPictureForm.ClearFields;
begin
 f_ValueMap := nil;
 inherited;
end;//TPrimPictureForm.ClearFields

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function TPrimPictureForm.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_4AAFCFB0014B_var*
//#UC END# *543E3AA801D0_4AAFCFB0014B_var*
begin
//#UC START# *543E3AA801D0_4AAFCFB0014B_impl*
 Result := nsTabIconIndex(titMain);
//#UC END# *543E3AA801D0_4AAFCFB0014B_impl*
end;//TPrimPictureForm.DoGetTabImageIndex
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

initialization
//#UC START# *52496599037C*
 DefGIF_LZWDECOMPFUNC:= GIFLZWDecompress;
 DefGIF_LZWCOMPFUNC:= GIFLZWCompress;
//#UC END# *52496599037C*
 str_pfImageCaption.Init;
 {* Инициализация str_pfImageCaption }
 str_pfImageSettingsCaption.Init;
 {* Инициализация str_pfImageSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimPictureForm);
 {* Регистрация PrimPicture }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
