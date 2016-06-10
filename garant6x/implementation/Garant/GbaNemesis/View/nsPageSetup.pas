unit nsPageSetup;

{ Бизнес-объект настроек страницы }


interface

uses
  SysUtils,
  Classes,
  Printers,
  Windows,

  l3Interfaces,
  l3Base,

  evTypes,
  evDef,

  vcmExternalInterfaces,
  vcmInterfaces,

  SettingsUnit,

  nsTypes,
  nsConfiguration,

  ConfigInterfaces,

  l3PrinterInterfaces
  ;

type
  TnsPageSetup = class(TnsEditSettingsInfo, InsPageSettingsInfo)
  private
  // internal fields
   f_Printer: Il3Printer;
   f_pPapes: PWORD;
   f_pPapeSizes: PPOINT;
   f_PaperFormats: IvcmStrings;
   f_Orientation: Integer;
   f_PaperFormatIndex: Integer;
   f_Metrics: TnsMetrics;
   f_Colontituls: array [TevPageColontituls] of Il3CString;
  private
  // internal methods
  // InsEditSettingsInfo
   function pm_GetColontituls(aIndex: TevPageColontituls): Tl3WString;
   procedure pm_SetColontituls(aIndex: TevPageColontituls; const aValue: Tl3WString);
   function pm_GetMetrics(aIndex: TnsMetricsIndex): Double;
   procedure pm_SetMetrics(aIndex: TnsMetricsIndex; aValue: Double);
   function pm_GetOrientation: Integer;
   procedure pm_SetOrientation(aValue: Integer);
   function pm_GetPaperFormats(aIndex: LongInt): Il3CString;
   function pm_GetPaperFormatIndex: Integer;
   function pm_GetPaperSize(aIndex: LongInt): TPoint;
  private
  // internal methods
    procedure SaveIndents(aSaveAsDefault: Boolean = False);
      {-}
    procedure SaveCatchwords(aSaveAsDefault: Boolean = False);
      {-}
    procedure SavePageFormatToSettings(aSaveAsDefault: Boolean);
     overload;
      {-}
    procedure LoadFromPrinter;
      {-}
    procedure ValidatePaperIndex(aIndex: Integer);
      {-}
    procedure LoadPageFormat(aRestoreDefault: Boolean = False);
      {* - загружает ширину, высоту и ориентацию страницы. }
    procedure LoadIndents(aRestoreDefault: Boolean = False);
      {* - загружает значения отступов.}
    procedure LoadCatchwords(aRestoreDefault: Boolean = False);
      {* - загружает значения колонтитулов. }
    function OrientationToString(aOrientation : Integer): Il3CString;
      {-}
  protected
   function MakeEditingSettings: IvcmStrings;
    override;
   procedure DoLoad(aRestoreDefault: Boolean = False);
    override;
   procedure DoSave(aSaveAsDefault: Boolean = False);
    override;
  public
  // public methods
    constructor Create(const aConfig: IConfiguration = nil; const aPrinter: Il3Printer = nil);
      reintroduce;
      virtual;
      {-}
    class function Make(const aConfig : IConfiguration = nil; const aPrinter: Il3Printer = nil) : InsPageSettingsInfo;
      reintroduce;
      {-}
    procedure Cleanup;
      override;
      {-}
  public
  // public methods
  // InsEditSettingsInfo
    procedure SetPageFormat(aOrientation : Integer);
      {-}
    function GetCustomFormatIndex: Integer;
      {-}
    function GetFormatIndex(const aSize: TPoint): Integer;
      {-}
    function IsPaperFormatsExisits: Boolean;
      {-}
    function LoadPageFormatFromPrinter: Boolean;
      {-}
    procedure SavePageFormatToSettings;
     overload;
      {-}
    procedure SaveToPrinter;
      {-}
  public
  // public properties
  // InsEditSettingsInfo
   property Colontituls[aIndex: TevPageColontituls]: Tl3WString
       read pm_GetColontituls
      write pm_SetColontituls;
   property Metrics[aIndex: TnsMetricsIndex]: Double
       read pm_GetMetrics
      write pm_SetMetrics;
   property Orientation: Integer
       read pm_GetOrientation
      write pm_SetOrientation;
   property PaperFormat[aIndex: LongInt]: Il3CString
       read pm_GetPaperFormats;
   property PaperFormatIndex: Integer
       read pm_GetPaperFormatIndex;
   property PaperSize[aIndex: Longint]: TPOINT
       read pm_GetPaperSize;
  end;//TnsPageSetup

  EPaperFormatsUnassigned = class(EPrinter);

const
  c_MaxClientPageWidth      = 3760;
  c_MaxClientPageHeight     = 3760;
  c_PreviewColontitulHeight = 20;


implementation

uses
  WinSpool,

  l3String,
  l3Printer,

  vcmBase,
  vcmStringList,

  nsUtils,
  nsConst,

  stdRes;

const
  c_PaperDelta = 1.0;
  c_InchToMM   = 25.4;

var
 g_PageSetupProperties: IvcmStrings;

// TnsPageSetup

constructor TnsPageSetup.Create(const aConfig: IConfiguration = nil; const aPrinter: Il3Printer = nil);
begin
 inherited Create(aConfig);
 // редактируемая конфигурация
 if Assigned(aPrinter) then
  f_Printer := aPrinter
 else
  f_Printer := Tl3Printer.Make;
 f_pPapes := nil;
 f_pPapeSizes := nil;
 f_PaperFormats := nil;
 f_PaperFormatIndex := -1;

 Load(False);
 LoadFromPrinter;
end;

procedure TnsPageSetup.Cleanup;
var
 l_Index: TevPageColontituls;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  f_Colontituls[l_Index] := nil;
 f_Printer := nil;
 SetPageFormat(0);
//
 f_PaperFormats := nil;
 vcmFreeMem(f_pPapes);
 vcmFreeMem(f_pPapeSizes);
 inherited;
end;

procedure TnsPageSetup.LoadFromPrinter;
const
 c_FormatNameSize = 64;
var
 l_Device,
 l_Driver,
 l_Port          : array [0..255] of Char;
 l_hDeviceMode   : THandle;
 l_dmPaperSize,
 l_dmOrientation,
 i,
 l_PapesCount    : Integer;
 l_pFormatsArray : PChar;
 l_pDM           : PDeviceMode;
begin
 vcmFreeMem(f_pPapes);
 vcmFreeMem(f_pPapeSizes);
 f_PaperFormatIndex := -1;
 f_PaperFormats := nil;
 if not Assigned(f_Printer) then
  exit;
 try
  f_Printer.GetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
  l_PapesCount := DeviceCapabilities(l_Device, l_Port, DC_PAPERNAMES, nil, nil);
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;
 if l_PapesCount > 0 then
 begin
  l_dmOrientation := f_Orientation;
  try
   l_pDM := GlobalLock(l_hDeviceMode);
   try
    vcmGetMem(f_pPapes, l_PapesCount*sizeof(f_pPapes^));
    try
     vcmGetMem(f_pPapeSizes, l_PapesCount*sizeof(f_pPapeSizes^));
     try
      vcmGetMem(l_pFormatsArray, l_PapesCount*c_FormatNameSize);
     except
      l_pFormatsArray := nil;
      raise;
     end;
    except
     f_pPapeSizes := nil;
     raise;
    end;
   except
    f_pPapes := nil;
    raise;
   end;
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    l_pDM := nil;
   end;
  end;
  if (l_pDM <> nil) and (f_pPapes <> nil) and (f_pPapeSizes <> nil) and (l_pFormatsArray <> nil) then
  begin
   try
    l_dmPaperSize := l_pDM.dmPaperSize;
    l_dmOrientation := l_pDM.dmOrientation;
    DeviceCapabilities(l_Device, l_Port, DC_PAPERS, PChar(f_pPapes), nil);
    DeviceCapabilities(l_Device, l_Port, DC_PAPERSIZE, PChar(f_pPapeSizes), nil);
    DeviceCapabilities(l_Device, l_Port, DC_PAPERNAMES, l_pFormatsArray, nil);
    f_PaperFormats := TvcmStringList.Make;
    for i := 0 to Pred(l_PapesCount) do
     f_PaperFormats.Add(l_pFormatsArray + i*c_FormatNameSize);
   except
    f_PaperFormats := nil;
    raise;
   end;
  end
  else
   l_PapesCount := 0;
  if l_PapesCount = 0 then
  begin
   vcmFreeMem(f_pPapes);
   vcmFreeMem(f_pPapeSizes);
  end;
  GlobalUnlock(l_hDeviceMode);
  vcmFreeMem(l_pFormatsArray);
 end;
 if l_PapesCount > 0 then
 begin
  if f_Orientation <> 0 then
   l_dmOrientation := f_Orientation;
  if PaperFormatIndex = -1 then
  begin
   for i := 0 to l_PapesCount - 1 do
    if ((PWORD(PChar(f_pPapes) + i*sizeof(f_pPapes^)))^ = l_dmPaperSize) then
    begin
     f_PaperFormatIndex := i;
     Break;
    end;
  end;
  SetPageFormat(l_dmOrientation);
 end;
end;

procedure TnsPageSetup.LoadPageFormat(aRestoreDefault: Boolean = False);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   SetPageFormat(StringToOrientation(LoadString(pi_Print_Metrics_Orientation,
                                                dv_Print_Metrics_Orientation,
                                                aRestoreDefault)));
 end;
end;

procedure TnsPageSetup.LoadIndents(aRestoreDefault: Boolean = False);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   f_Metrics[pmLeftMargin] := LoadDouble(pi_Print_Metrics_Margins_Left,
                                        StrToFloat(dv_Print_Metrics_Margins_Left),
                                        aRestoreDefault);
   f_Metrics[pmRightMargin] := LoadDouble(pi_Print_Metrics_Margins_Right,
                                         StrToFloat(dv_Print_Metrics_Margins_Right),
                                         aRestoreDefault);
   f_Metrics[pmUpMargin] := LoadDouble(pi_Print_Metrics_Margins_Top,
                                      StrToFloat(dv_Print_Metrics_Margins_Top),
                                      aRestoreDefault);
   f_Metrics[pmDownMargin] := LoadDouble(pi_Print_Metrics_Margins_Bottom,
                                        StrToFloat(dv_Print_Metrics_Margins_Bottom),
                                        aRestoreDefault);
  end;//with Settings
end;

procedure TnsPageSetup.LoadCatchWords(aRestoreDefault: Boolean = False);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   f_Colontituls[pcUpLeftFirst] := LoadString(pi_Print_Catchwords_First_UpLeft,
                                              dv_Print_Catchwords_First_UpLeft,
                                              aRestoreDefault);
   f_Colontituls[pcUpRightFirst] := LoadString(pi_Print_Catchwords_First_UpRight,
                                               dv_Print_Catchwords_First_UpRight,
                                               aRestoreDefault);
   f_Colontituls[pcDownLeftFirst] := LoadString(pi_Print_Catchwords_First_BottomLeft,
                                                dv_Print_Catchwords_First_BottomLeft,
                                                aRestoreDefault);
   f_Colontituls[pcDownRightFirst] := LoadString(pi_Print_Catchwords_First_BottomRight,
                                                 dv_Print_Catchwords_First_BottomRight,
                                                 aRestoreDefault);

   f_Colontituls[pcUpLeft] := LoadString(pi_Print_Catchwords_Other_UpLeft,
                                         dv_Print_Catchwords_Other_UpLeft,
                                         aRestoreDefault);
   f_Colontituls[pcUpRight] := LoadString(pi_Print_Catchwords_Other_UpRight,
                                          dv_Print_Catchwords_Other_UpRight,
                                          aRestoreDefault);
   f_Colontituls[pcDownLeft] := LoadString(pi_Print_Catchwords_Other_BottomLeft,
                                           dv_Print_Catchwords_Other_BottomLeft,
                                           aRestoreDefault);
   f_Colontituls[pcDownRight] := LoadString(pi_Print_Catchwords_Other_BottomRight,
                                            dv_Print_Catchwords_Other_BottomRight,
                                            aRestoreDefault);
  end;//with Settings
end;

procedure TnsPageSetup.DoLoad(aRestoreDefault: Boolean = False);
begin
 LoadIndents(aRestoreDefault);
 LoadPageFormat(aRestoreDefault);
 LoadCatchWords(aRestoreDefault);
 if aRestoreDefault then
  SaveToPrinter;
end;

procedure TnsPageSetup.SaveToPrinter;
var
 l_pDM: PDeviceMode;
 l_Device,
 l_Driver,
 l_Port: array [0..255] of Char;
 l_hPrinter,
 l_hDeviceMode: THandle;
 l_dmPaperSize: SHORT;
begin
 if (not Assigned(f_Printer)) or (not Assigned(f_PaperFormats)) then
  exit;
 try
  f_Printer.GetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
  if OpenPrinter(l_Device, l_hPrinter, nil) then
   try
    l_pDM := GlobalLock(l_hDeviceMode);
//orientation apply
    if (l_pDM.dmOrientation <> f_Orientation) then begin
     l_pDM.dmFields := DM_ORIENTATION or DM_PAPERSIZE or DM_COPIES;
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=623080643
     l_pDM.dmOrientation := f_Orientation;
     DocumentProperties(
      0{Self.Handle},
      l_hPrinter,
      l_Device,
      l_pDM^,
      l_pDM^,
      DM_IN_BUFFER or DM_OUT_BUFFER);
    end;
//paper _format apply
    if (f_PaperFormatIndex >= 0) and (f_PaperFormatIndex < f_PaperFormats.Count) then
    begin
     l_dmPaperSize := (PWORD(PChar(f_pPapes) + f_PaperFormatIndex*sizeof(f_pPapes^)))^;
     if (l_pDM.dmPaperSize <> l_dmPaperSize) or
        ((l_pDM.dmPaperSize = l_dmPaperSize) and (l_dmPaperSize = DMPAPER_USER)) then
     begin
      l_pDM.dmFields := DM_ORIENTATION;
      l_pDM.dmOrientation := f_Orientation;
      DocumentProperties(
       0{Self.Handle},
       l_hPrinter,
       l_Device,
       l_pDM^,
       l_pDM^,
       DM_IN_BUFFER or DM_OUT_BUFFER);
      //SetPageFormat(l_pDM.dmPaperWidth/10.0, l_pDM.dmPaperLength/10.0, l_pDM.dmOrientation);
     end;
    end;
//to printer
    f_Printer.SetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
   finally
    GlobalUnlock(l_hDeviceMode);
    ClosePrinter(l_hPrinter);
   end;
 except
  on EPrinter do ; // давим ошибку при отсутствии принтера
 end;
end;

procedure TnsPageSetup.SaveIndents(aSaveAsDefault: Boolean = False);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   SaveDouble(pi_Print_Metrics_Margins_Left,
             f_Metrics[pmLeftMargin],
             StrToFloat(dv_Print_Metrics_Margins_Left),
             aSaveAsDefault);
   SaveDouble(pi_Print_Metrics_Margins_Right,
             f_Metrics[pmRightMargin],
             StrToFloat(dv_Print_Metrics_Margins_Right),
             aSaveAsDefault);
   SaveDouble(pi_Print_Metrics_Margins_Top,
             f_Metrics[pmUpMargin],
             StrToFloat(dv_Print_Metrics_Margins_Top),
             aSaveAsDefault);
   SaveDouble(pi_Print_Metrics_Margins_Bottom,
             f_Metrics[pmDownMargin],
             StrToFloat(dv_Print_Metrics_Margins_Bottom),
             aSaveAsDefault);
  end;//with Settings
end;

procedure TnsPageSetup.SaveCatchwords(aSaveAsDefault: Boolean = False);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   SaveString(pi_Print_Catchwords_First_UpLeft,
             f_Colontituls[pcUpLeftFirst],
             dv_Print_Catchwords_First_UpLeft,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_First_UpRight,
             f_Colontituls[pcUpRightFirst],
             dv_Print_Catchwords_First_UpRight,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_First_BottomLeft,
             f_Colontituls[pcDownLeftFirst],
             dv_Print_Catchwords_First_BottomLeft,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_First_BottomRight,
             f_Colontituls[pcDownRightFirst],
             dv_Print_Catchwords_First_BottomRight,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_Other_UpLeft,
             f_Colontituls[pcUpLeft],
             dv_Print_Catchwords_Other_UpLeft,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_Other_UpRight,
             f_Colontituls[pcUpRight],
             dv_Print_Catchwords_Other_UpRight,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_Other_BottomLeft,
             f_Colontituls[pcDownLeft],
             dv_Print_Catchwords_Other_BottomLeft,
             aSaveAsDefault);
   SaveString(pi_Print_Catchwords_Other_BottomRight,
             f_Colontituls[pcDownRight],
             dv_Print_Catchwords_Other_BottomRight,
             aSaveAsDefault);
  end;//with Settings
end;

procedure TnsPageSetup.DoSave(aSaveAsDefault: Boolean = False);
begin
 SaveToPrinter;
 if Modified then
 begin
  SaveIndents(aSaveAsDefault);
  SavePageFormatToSettings(aSaveAsDefault);
  SaveCatchwords(aSaveAsDefault);
 end;
end;

procedure TnsPageSetup.SavePageFormatToSettings;
begin
 SavePageFormatToSettings(False);
end;

procedure TnsPageSetup.SavePageFormatToSettings(aSaveAsDefault: Boolean);
begin
 if (Settings <> nil) then
  with Settings do
  begin
   SaveString(pi_Print_Metrics_Orientation,
              OrientationToString(f_Orientation),
              l3Str(OrientationToString(f_Orientation)),
              aSaveAsDefault);
  end;//with Settings
end;

function TnsPageSetup.LoadPageFormatFromPrinter: Boolean;
var
 l_pDM: PDeviceMode;
 l_Device,
 l_Driver,
 l_Port: array [0..255] of Char;
 l_hPrinter,
 l_hDeviceMode: THandle;
 i,
 l_Count,
 l_Index: Integer;
begin
 Result := False;
 if (not Assigned(f_Printer)) or (not Assigned(f_PaperFormats)) then
  exit;
 try
  l_Count := f_PaperFormats.Count;
  f_Printer.GetPrinter(l_Device, l_Driver, l_Port, l_hDeviceMode);
  if OpenPrinter(l_Device, l_hPrinter, nil) then
   try
    l_pDM := GlobalLock(l_hDeviceMode);
    try
     l_Index := -1;
     for i := 0 to l_Count - 1 do
      if ((PWORD(PChar(f_pPapes) + i*sizeof(f_pPapes^)))^ = l_pDM.dmPaperSize) then
       l_Index := i;
     if (l_Index >= 0) and (l_Index < l_Count) then
     begin
      SetPageFormat(l_pDM.dmOrientation);
     end
     else
      SetPageFormat(l_pDM.dmOrientation);
     Result := True;
    finally
     GlobalUnlock(l_hDeviceMode);
    end;
   finally
    ClosePrinter(l_hPrinter);
   end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
end;

procedure TnsPageSetup.SetPageFormat(aOrientation : Integer);
begin
 Orientation := aOrientation;
end;

function TnsPageSetup.OrientationToString(aOrientation: Integer): Il3CString;
begin
 if (aOrientation = DMORIENT_LANDSCAPE) then
  Result := nsCStr(li_Metrics_Orientation1)
 else
  Result := nsCStr(li_Metrics_Orientation0);
end;

function TnsPageSetup.GetCustomFormatIndex: Integer;
var
 i : Integer;
begin
 result := -1;
 if Assigned(f_pPapes) and Assigned(f_PaperFormats) then
  for i := 0 to f_PaperFormats.Count - 1 do
   if ((PWORD(PChar(f_pPapes) + i*sizeof(f_pPapes^)))^ = DMPAPER_USER) then
   begin
    result := i;
    break;
   end;
end;

function TnsPageSetup.GetFormatIndex(const aSize: TPoint): Integer;
var
 i        : Integer;
 l_pPoint : PPoint;
begin
 result := -1;
 if Assigned(f_pPapes) and Assigned(f_PaperFormats) then
  for i := 0 to f_PaperFormats.Count - 1 do
  begin
   l_pPoint := (PPOINT(PChar(f_pPapeSizes) + i*sizeof(f_pPapeSizes^)));
   if (Abs(aSize.X - l_pPoint^.x) <= c_PaperDelta) and (Abs(aSize.Y - l_pPoint^.y) <= c_PaperDelta * 10) then
   begin
    result := i;
    break;
   end;
  end;
 if result < 0 then
  result := GetCustomFormatIndex;
end;

function TnsPageSetup.MakeEditingSettings: IvcmStrings;
begin
 if not Assigned(g_PageSetupProperties) then
 begin
  g_PageSetupProperties := TvcmStringList.Make;
  with g_PageSetupProperties do
  begin
   Add(pi_Print_Metrics_Margins_Left);
   Add(pi_Print_Metrics_Margins_Right);
   Add(pi_Print_Metrics_Margins_Top);
   Add(pi_Print_Metrics_Margins_Bottom);
   Add(pi_Print_Metrics_Orientation);
   Add(pi_Print_Catchwords_First_UpLeft);
   Add(pi_Print_Catchwords_First_UpRight);
   Add(pi_Print_Catchwords_First_BottomLeft);
   Add(pi_Print_Catchwords_First_BottomRight);
   Add(pi_Print_Catchwords_Other_UpLeft);
   Add(pi_Print_Catchwords_Other_UpRight);
   Add(pi_Print_Catchwords_Other_BottomLeft);
   Add(pi_Print_Catchwords_Other_BottomRight);
  end;
 end;
 Result := g_PageSetupProperties;
end;

function TnsPageSetup.pm_GetColontituls(aIndex: TevPageColontituls): Tl3WString;
begin
 Result := nsWStr(f_Colontituls[aIndex]);
end;

function TnsPageSetup.pm_GetMetrics(aIndex: TnsMetricsIndex): Double;
begin
 Result := f_Metrics[aIndex];
end;

function TnsPageSetup.pm_GetOrientation: Integer;
begin
 Result := f_Orientation;
end;

function TnsPageSetup.pm_GetPaperFormatIndex: Integer;
begin
 Result := f_PaperFormatIndex;
end;

function TnsPageSetup.pm_GetPaperFormats(aIndex: LongInt): Il3CString;
begin
 if IsPaperFormatsExisits then
 begin
  ValidatePaperIndex(aIndex);
  Result := f_PaperFormats.ItemC[aIndex];
 end
 else
  Result := vcmCStr(str_UndefinedPaperFormat); 
end;

function TnsPageSetup.pm_GetPaperSize(aIndex: Integer): TPoint;
begin
 if IsPaperFormatsExisits then
 begin
  ValidatePaperIndex(aIndex);
  Result := PPOINT(PChar(f_pPapeSizes) + aIndex*sizeof(f_pPapeSizes^))^
 end
 else
  Result := Point(def_cmPaperWidth, def_cmPaperHeight);
end;

procedure TnsPageSetup.pm_SetColontituls(aIndex: TevPageColontituls;
                                        const aValue: Tl3WString);
begin
 if (not l3Same(f_Colontituls[aIndex], aValue)) then
 begin
  f_Colontituls[aIndex] := nsCStr(aValue);
  MarkModified;
 end;//not l3Same(f_Colontituls[aIndex]
end;

procedure TnsPageSetup.pm_SetMetrics(aIndex: TnsMetricsIndex;
  aValue: Double);
begin
 if f_Metrics[aIndex] <> aValue then
 begin
  f_Metrics[aIndex] := aValue;
  MarkModified;
 end;
end;

procedure TnsPageSetup.pm_SetOrientation(aValue: Integer);
begin
 if f_Orientation <> aValue then
 begin
  f_Orientation := aValue;
  MarkModified;
 end;
end;

procedure TnsPageSetup.ValidatePaperIndex(aIndex: Integer);
begin
 if not IsPaperFormatsExisits then
  raise EPaperFormatsUnassigned.Create('Paper formats not initialized');
 if (aIndex < 0) or (Assigned(f_PaperFormats) and (aIndex >= f_PaperFormats.Count)) then
  raise EListError.Create('Paper format index out of bounds');
end;

function TnsPageSetup.IsPaperFormatsExisits: Boolean;
begin
 Result := Assigned(f_PaperFormats);
end;

class function TnsPageSetup.Make(const aConfig: IConfiguration;
  const aPrinter: Il3Printer): InsPageSettingsInfo;
var l_Class: TnsPageSetup;
begin
 l_Class := Create(aConfig, aPrinter);
 try
  Result := l_Class;
 finally
  vcmFree(l_Class);
 end;
end;

initialization

finalization
 g_PageSetupProperties := nil;

end.
