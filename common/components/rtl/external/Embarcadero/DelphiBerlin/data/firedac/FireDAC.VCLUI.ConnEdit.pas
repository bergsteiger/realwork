{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{           FireDAC TFDConnection editor form           }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.ConnEdit;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Messages, Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
    Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls, System.IniFiles, Vcl.Graphics,
    Vcl.Buttons, Vcl.ToolWin, Vcl.ImgList, Vcl.ActnList, Vcl.Dialogs,
    System.ImageList, System.Actions,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Async, FireDAC.Stan.Util,
  FireDAC.Phys.Intf,
  FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Comp.UI,
    FireDAC.Comp.ScriptCommands,
  FireDAC.VCLUI.OptsBase, FireDAC.VCLUI.Controls, FireDAC.VCLUI.Login,
    FireDAC.VCLUI.UpdateOptions, FireDAC.VCLUI.FormatOptions,
    FireDAC.VCLUI.FetchOptions, FireDAC.VCLUI.ResourceOptions,
    FireDAC.UI.Intf, FireDAC.VCLUI.Memo, FireDAC.VCLUI.Script;

type
  TfrmFDGUIxFormsConnEdit = class(TfrmFDGUIxFormsOptsBase)
    pcMain: TPageControl;
    tsConnection: TTabSheet;
    sgParams: TStringGrid;
    cbParams: TComboBox;
    edtParams: TEdit;
    pnlTitle: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cbServerID: TComboBox;
    cbConnectionDefName: TComboBox;
    Panel2: TPanel;
    tsOptions: TTabSheet;
    ptreeOptions: TFDGUIxFormsPanelTree;
    frmFormatOptions: TfrmFDGUIxFormsFormatOptions;
    frmFetchOptions: TfrmFDGUIxFormsFetchOptions;
    frmUpdateOptions: TfrmFDGUIxFormsUpdateOptions;
    frmResourceOptions: TfrmFDGUIxFormsResourceOptions;
    pnlConnection: TPanel;
    pnlOptions: TPanel;
    tsSQL: TTabSheet;
    tsInfo: TTabSheet;
    pnlInfo: TPanel;
    mmInfo: TMemo;
    pnlSQL: TPanel;
    Splitter1: TSplitter;
    mmLog: TMemo;
    scrEngine: TFDScript;
    sdMain: TFDGUIxScriptDialog;
    ActionList1: TActionList;
    acNewScript: TAction;
    acOpenScript: TAction;
    acSaveScript: TAction;
    acSaveScriptAs: TAction;
    acSaveLog: TAction;
    acExit: TAction;
    acRun: TAction;
    acRunByStep: TAction;
    acSkipStep: TAction;
    acContinueOnError: TAction;
    acDropNonexistObj: TAction;
    acShowMessages: TAction;
    acHelp: TAction;
    acAbout: TAction;
    ilMain: TImageList;
    ToolBar1: TToolBar;
    tbtRun: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    btnDefaults: TButton;
    btnTest: TButton;
    btnWizard: TButton;
    btnWiki: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnWizardClick(Sender: TObject);
    procedure sgParamsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cbServerIDClick(Sender: TObject);
    procedure EditorExit(Sender: TObject);
    procedure sgParamsTopLeftChanged(Sender: TObject);
    procedure EditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgParamsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgParamsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbConnectionDefNameClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgParamsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnDefaultsClick(Sender: TObject);
    procedure frmOptionsModified(Sender: TObject);
    procedure cbParamsDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure mmScriptKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mmScriptMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure scrEngineBeforeExecute(Sender: TObject);
    procedure scrEngineAfterExecute(Sender: TObject);
    procedure scrEngineConsoleGet(AEngine: TFDScript; const APrompt: string;
      var AResult: string);
    procedure scrEngineConsoleLockUpdate(AEngine: TFDScript; ALock: Boolean);
    procedure scrEngineConsolePut(AEngine: TFDScript; const AMessage: string;
      AKind: TFDScriptOutputKind);
    procedure scrEnginePause(AEngine: TFDScript; const AText: string);
    procedure mmLogDblClick(Sender: TObject);
    procedure acRunUpdate(Sender: TObject);
    procedure acRunExecute(Sender: TObject);
    procedure acRunByStepUpdate(Sender: TObject);
    procedure acRunByStepExecute(Sender: TObject);
    procedure acSkipStepUpdate(Sender: TObject);
    procedure acSkipStepExecute(Sender: TObject);
    procedure btnWikiClick(Sender: TObject);
    procedure bedtParamsRightButtonClick(Sender: TObject);
  private
    FConnection: TFDCustomConnection;
    FTempConnection: TFDCustomConnection;
    FModified: Boolean;
    FDriverID: String;
    FConnectionDefName: String;
    FConnectionDef: IFDStanConnectionDef;
    FDefaults, FResults, FEdited: TStrings;
    FOptions: IFDStanOptions;
    FOnModified: TNotifyEvent;
    FLockResize: Boolean;
    FLastGridWidth: Integer;
    FEditor: Integer;
    function GetPageControl: TPageControl;
    procedure GetDriverParams(const ADrvID: String; AStrs: TStrings);
    procedure GetConnectionDefParams(const AConnectionDefName: String; AStrs: TStrings);
    procedure OverrideBy(AThis, AByThat: TStrings);
    procedure FillParamValues(AAsIs: Boolean);
    procedure FillParamGrids(AResetPosition: Boolean);
    procedure AdjustEditor(ACtrl: TWinControl; ACol, ARow: Integer);
    procedure FillConnParams(AParams: TStrings);
    procedure Modified;
    function IsDriverKnown(const ADrvID: String;
      out ADrvMeta: IFDPhysDriverMetadata): Boolean;
    procedure ResetConnectionDef;
    procedure ResetOpts;
    function GetGridWidth: Integer;
    function GetEditor: TWinControl;
    function GetTempConnection: TFDCustomConnection;
    function GetTestConnection: TFDCustomConnection;
    procedure ReleaseTempConnection;
    procedure SetConnectionParams(AConnection: TFDCustomConnection);
  protected
    procedure LoadFormState(AIni: TCustomIniFile); override;
    procedure SaveFormState(AIni: TCustomIniFile); override;
  public
    mmScript: TFDGUIxFormsMemo;
    bedtParams: TButtonedEdit;
    class function Execute(AConn: TFDCustomConnection; const ACaption: String;
      const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean; overload;
    class function Execute(var AConnStr: String; const ACaption: String;
      const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean; overload;
    class function Execute(AConnDef: IFDStanConnectionDef; const ACaption: String;
      const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean; overload;
    constructor CreateForConnectionDefEditor;
    procedure LoadData(AConnectionDef: IFDStanConnectionDef);
    procedure PostChanges;
    procedure SaveData;
    procedure ResetState(AClear: Boolean);
    procedure ResetData;
    procedure ResetPage;
    procedure TestConnection;
    procedure FillConnectionInfo(AConnection: TFDCustomConnection; ATryToConnect: Boolean);
    procedure SetReadOnly(AValue: Boolean);
    property LockResize: Boolean read FLockResize write FLockResize;
    property PageControl: TPageControl read GetPageControl;
    property OnModified: TNotifyEvent read FOnModified write FOnModified;
  end;

var
  frmFDGUIxFormsConnEdit: TfrmFDGUIxFormsConnEdit;

implementation

uses
  System.Variants, System.Types, System.UITypes, Data.DB,
  FireDAC.Stan.Consts, FireDAC.Stan.ResStrs,
  FireDAC.DatS;

{$R *.dfm}

type
  __TWinControl = class(TWinControl)
  end;

{------------------------------------------------------------------------------}
// General

procedure TfrmFDGUIxFormsConnEdit.FormCreate(Sender: TObject);
var
  iBorderY, iBorderX: Integer;
begin
  iBorderY := GetSystemMetrics(SM_CYBORDER);
  iBorderX := GetSystemMetrics(SM_CXBORDER);
  sgParams.DefaultRowHeight := GetEditor.Height - iBorderY;
  FLastGridWidth := GetGridWidth;
  sgParams.ColWidths[0] := MulDiv(FLastGridWidth, 1, 3) - 2 * iBorderX;
  sgParams.ColWidths[1] := MulDiv(FLastGridWidth, 1, 3) - 2 * iBorderX;
  sgParams.ColWidths[2] := MulDiv(FLastGridWidth, 1, 3) - 2 * iBorderX;
  FDefaults := TFDStringList.Create;
  FResults := TFDStringList.Create;
  FEdited := TFDStringList.Create;
  mmScript := TFDGUIxFormsMemo.Create(Self);
  mmScript.Parent := pnlSQL;
  mmScript.Align := alClient;
  mmScript.OnKeyUp := mmScriptKeyUp;
  mmScript.OnMouseUp := mmScriptMouseUp;

  bedtParams := TButtonedEdit.Create(Self);
  bedtParams.Parent := pnlConnection;
  bedtParams.Images := ilMain;
  bedtParams.RightButton.ImageIndex := 6;
  bedtParams.RightButton.Visible := True;
  bedtParams.OnRightButtonClick := bedtParamsRightButtonClick;
  bedtParams.OnExit := EditorExit;
  bedtParams.OnKeyDown := EditorKeyDown;
  bedtParams.Visible := False;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.FormDestroy(Sender: TObject);
begin
  scrEngine.Connection := nil;
  ReleaseTempConnection;
  FOptions := nil;
  FDFreeAndNil(FDefaults);
  FDFreeAndNil(FResults);
  FDFreeAndNil(FEdited);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.pcMainChange(Sender: TObject);
begin
  if pcMain.ActivePage = tsInfo then
    FillConnectionInfo(nil, True)
  else if pcMain.ActivePage = tsSQL then
    scrEngine.Connection := GetTestConnection;
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.GetPageControl: TPageControl;
begin
  Result := pcMain;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.SetConnectionParams(AConnection: TFDCustomConnection);
begin
  PostChanges;
  AConnection.Close;
  frmFetchOptions.SaveTo(AConnection.FetchOptions);
  frmFormatOptions.SaveTo(AConnection.FormatOptions);
  frmUpdateOptions.SaveTo(AConnection.UpdateOptions);
  frmResourceOptions.SaveTo(AConnection.ResourceOptions);
  FillConnParams(AConnection.Params);
  if FConnection <> nil then
    if FConnectionDefName <> '' then
      AConnection.ConnectionDefName := FConnectionDefName
    else
      AConnection.DriverName := FDriverID
  else
    if (CompareText(FResults.Values[S_FD_DefinitionParam_Common_Name], FConnectionDefName) = 0) or
       (FConnectionDefName = '') then
      AConnection.DriverName := FDriverID
    else
      AConnection.ConnectionDefName := FConnectionDefName;
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.GetTempConnection: TFDCustomConnection;
begin
  if FTempConnection = nil then begin
    FTempConnection := TFDConnection.Create(nil);
    if FConnection <> nil then
      FTempConnection.Name := FConnection.Name;
    SetConnectionParams(FTempConnection);
  end;
  Result := FTempConnection;
  if (FConnection <> nil) and FConnection.Temporary then
    Result.Params.Pooled := False;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.ReleaseTempConnection;
begin
  if FTempConnection <> nil then begin
    scrEngine.Connection := nil;
    FDFreeAndNil(FTempConnection);
  end;
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.GetTestConnection: TFDCustomConnection;
begin
  if (FConnection <> nil) and FConnection.Connected and not FModified then
    Result := FConnection
  else
    Result := GetTempConnection;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.Modified;
begin
  FModified := True;
  ReleaseTempConnection;
  if Assigned(FOnModified) then
    FOnModified(Self);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.LoadFormState(AIni: TCustomIniFile);
begin
  inherited LoadFormState(AIni);
  ptreeOptions.LoadState(Name, AIni);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.SaveFormState(AIni: TCustomIniFile);
begin
  inherited SaveFormState(AIni);
  ptreeOptions.SaveState(Name, AIni);
end;

{------------------------------------------------------------------------------}
// ConnDef page

procedure TfrmFDGUIxFormsConnEdit.ResetConnectionDef;
begin
  GetEditor.Visible := False;
  FEdited.Clear;
  FillParamValues(True);
  FillParamGrids(True);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.ResetOpts;
var
  oOpts: IFDStanOptions;
begin
  oOpts := TFDOptionsContainer.Create(nil, TFDFetchOptions, TFDUpdateOptions,
    TFDResourceOptions, nil);
  frmFetchOptions.LoadFrom(oOpts.FetchOptions);
  frmFormatOptions.LoadFrom(oOpts.FormatOptions);
  frmUpdateOptions.LoadFrom(oOpts.UpdateOptions);
  frmResourceOptions.LoadFrom(oOpts.ResourceOptions);
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.IsDriverKnown(const ADrvID: String;
  out ADrvMeta: IFDPhysDriverMetadata): Boolean;
var
  i: Integer;
  oManMeta: IFDPhysManagerMetadata;
begin
  Result := False;
  FDPhysManager.CreateMetadata(oManMeta);
  for i := 0 to oManMeta.DriverCount - 1 do
    if CompareText(oManMeta.DriverID[i], ADrvID) = 0 then begin
      oManMeta.CreateDriverMetadata(ADrvID, ADrvMeta);
      Result := True;
      Break;
    end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.GetDriverParams(const ADrvID: String;
  AStrs: TStrings);
var
  oDrvMeta: IFDPhysDriverMetadata;
  oTab: TFDDatSTable;
  i: Integer;
begin
  if IsDriverKnown(ADrvID, oDrvMeta) then begin
    oTab := oDrvMeta.GetConnParams(AStrs);
    try
      for i := 0 to oTab.Rows.Count - 1 do
        AStrs.Add(oTab.Rows[i].GetData('Name') + '=' + oTab.Rows[i].GetData('DefVal'));
    finally
      FDFree(oTab);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.GetConnectionDefParams(const AConnectionDefName: String;
  AStrs: TStrings);
var
  oConnectionDef: IFDStanConnectionDef;
begin
  if FConnectionDef <> nil then
    oConnectionDef := FConnectionDef
  else
    oConnectionDef := FDManager.ConnectionDefs.ConnectionDefByName(AConnectionDefName);
  AStrs.AddStrings(oConnectionDef.Params);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.OverrideBy(AThis, AByThat: TStrings);
var
  i: Integer;
  sKey, sValue: String;
begin
  for i := 0 to AByThat.Count - 1 do begin
    sKey := AByThat.Names[i];
    sValue := AByThat.Values[sKey];
    AThis.Values[sKey] := sValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.FillParamValues(AAsIs: Boolean);
var
  oStrs: TFDStringList;
begin
  oStrs := TFDStringList.Create;
  try
    FDefaults.Clear;
    if FDriverID <> '' then
      GetDriverParams(FDriverID, FDefaults);
    if FConnectionDefName <> '' then begin
      GetConnectionDefParams(FConnectionDefName, oStrs);
      OverrideBy(FDefaults, oStrs);
    end;
    FResults.SetStrings(FDefaults);
    if (CompareText(FResults.Values[S_FD_DefinitionParam_Common_Name], FConnectionDefName) = 0) or
       (FConnectionDefName = '') then
      FResults.Values[S_FD_ConnParam_Common_DriverID] := FDriverID
    else
      FResults.Values[S_FD_DefinitionParam_Common_ConnectionDef] := FConnectionDefName;
    if not AAsIs then
      OverrideBy(FResults, FEdited);
  finally
    FDFree(oStrs);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.FillConnParams(AParams: TStrings);
var
  i, j: Integer;
  lChanged: Boolean;
  sKey, sVal: String;
begin
  AParams.Clear;
  if FConnectionDef <> nil then
    AParams.SetStrings(FEdited)
  else
    for i := 0 to FEdited.Count - 1 do begin
      sKey := FEdited.Names[i];
      sVal := FEdited.Values[sKey];
      lChanged := False;
      for j := 1 to sgParams.RowCount - 1 do
        if AnsiCompareText(sgParams.Cells[0, j], sKey) = 0 then begin
          lChanged := True;
          Break;
        end;
      if lChanged then
        lChanged := FDefaults.Values[sKey] <> sVal;
      if lChanged then
        AParams.Add(sKey + '=' + sVal);
    end;
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.GetGridWidth: Integer;
begin
  Result := sgParams.ClientWidth - GetSystemMetrics(SM_CXVSCROLL) - 5;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.FillParamGrids(AResetPosition: Boolean);
var
  oDrvMeta: IFDPhysDriverMetadata;
  oTab: TFDDatSTable;
  i: Integer;
begin
  if not IsDriverKnown(FDriverID, oDrvMeta) then
    sgParams.RowCount := 2
  else begin
    oTab := oDrvMeta.GetConnParams(FResults);
    try
      sgParams.RowCount := oTab.Rows.Count + 1;
      for i := 0 to oTab.Rows.Count - 1 do begin
        sgParams.Cells[0, i + 1] := oTab.Rows[i].GetData('Name');
        sgParams.Cells[1, i + 1] := FResults.Values[oTab.Rows[i].GetData('Name')];
        sgParams.Cells[2, i + 1] := oTab.Rows[i].GetData('DefVal');
      end;
    finally
      FDFree(oTab);
    end;
  end;
  sgParams.Cells[0, 0] := S_FD_ParParameter;
  sgParams.Cells[1, 0] := S_FD_ParValue;
  sgParams.Cells[2, 0] := S_FD_ParDefault;
  sgParams.FixedRows := 1;
  if AResetPosition then begin
    if sgParams.RowCount > 2 then
      sgParams.Row := 2
    else
      sgParams.Row := 1;
    sgParams.Col := 1;
  end;
end;

{------------------------------------------------------------------------------}
function TfrmFDGUIxFormsConnEdit.GetEditor: TWinControl;
begin
  case FEditor of
  0:   Result := edtParams;
  1:   Result := cbParams;
  2:   Result := bedtParams;
  else Result := nil
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.AdjustEditor(ACtrl: TWinControl;
  ACol, ARow: Integer);
var
  R: TRect;
  oCtrl: __TWinControl;
begin
  oCtrl := __TWinControl(ACtrl);
  R := sgParams.CellRect(ACol, ARow);
  R.TopLeft := sgParams.Parent.ScreenToClient(sgParams.ClientToScreen(R.TopLeft));
  R.BottomRight := sgParams.Parent.ScreenToClient(sgParams.ClientToScreen(R.BottomRight));
  oCtrl.Left := R.Left;
  oCtrl.Top := R.Top;
  oCtrl.Width := R.Right - R.Left;
  oCtrl.Text := sgParams.Cells[ACol, ARow];
  oCtrl.Visible := True;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.cbServerIDClick(Sender: TObject);
var
  s: String;
begin
  s := cbServerID.Text;
  if (s <> '') and ((FConnectionDef = nil) and (FConnectionDefName <> '') or (FDriverID <> s)) then begin
    if FConnectionDef = nil then
      FConnectionDefName := '';
    cbConnectionDefName.Text := '';
    FDriverID := s;
    FEdited.Clear;
    FillParamValues(True);
    FillParamGrids(True);
    GetEditor.Visible := False;
    Modified;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.cbConnectionDefNameClick(Sender: TObject);
var
  s: String;
begin
  s := cbConnectionDefName.Text;
  if (s <> '') and (FConnectionDefName <> s) then begin
    FConnectionDefName := s;
    FDriverID := FDManager.ConnectionDefs.ConnectionDefByName(s).Params.DriverID;
    cbServerID.Text := '';
    FEdited.Clear;
    FillParamValues(True);
    FillParamGrids(True);
    GetEditor.Visible := False;
    Modified;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.sgParamsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  oDrvMeta: IFDPhysDriverMetadata;
  oTab: TFDDatSTable;
  iNewEditor: Integer;
begin
  if not cbServerID.Enabled then
    Exit;
  if (ACol = 1) and (ARow > 1) then begin
    if IsDriverKnown(FDriverID, oDrvMeta) then begin
      oTab := oDrvMeta.GetConnParams(FResults);
      try
        iNewEditor := FDGUIxSetupEditor(cbParams, edtParams, bedtParams,
          OpenDialog1, oTab.Rows[ARow - 1].GetData('Type'));
      finally
        FDFree(oTab);
      end;
      if iNewEditor <> FEditor then begin
        case iNewEditor of
        0:
          begin
            edtParams.Visible := True;
            cbParams.Visible := False;
            bedtParams.Visible := False;
          end;
        1:
          begin
            edtParams.Visible := False;
            cbParams.Visible := True;
            bedtParams.Visible := False;
          end;
        2:
          begin
            edtParams.Visible := False;
            cbParams.Visible := False;
            bedtParams.Visible := True;
          end;
        end;
        FEditor := iNewEditor;
      end;
      AdjustEditor(GetEditor, ACol, ARow);
    end
    else
      GetEditor.Visible := False;
  end
  else
    GetEditor.Visible := False;
  CanSelect := True;
  if GetEditor.CanFocus and (not tsSQL.TabVisible or Visible) then
    GetEditor.SetFocus
  else
    GetEditor.Visible := False;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.sgParamsTopLeftChanged(Sender: TObject);
begin
  if GetEditor.Visible then
    AdjustEditor(GetEditor, sgParams.Col, sgParams.Row);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.sgParamsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F2) and GetEditor.Visible then begin
    GetEditor.BringToFront;
    GetEditor.SetFocus;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.sgParamsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  sgParamsTopLeftChanged(sgParams);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.FormResize(Sender: TObject);
var
  d: Double;
  iW0, iW1, iW2: Integer;
begin
  if not FLockResize and (GetGridWidth > 80) then begin
    if FLastGridWidth > 0 then begin
      d := GetGridWidth / FLastGridWidth;
      iW0 := Round(d * sgParams.ColWidths[0]);
      if iW0 < 20 then
        iW0 := 20;
      iW1 := Round(d * sgParams.ColWidths[1]);
      if iW1 < 20 then
        iW1 := 20;
      iW2 := Round(d * sgParams.ColWidths[2]);
      if iW2 < 20 then
        iW2 := 20;
      sgParams.ColWidths[0] := iW0;
      sgParams.ColWidths[1] := iW1;
      sgParams.ColWidths[2] := iW2;
      sgParamsMouseUp(nil, mbLeft, [], 0, 0);
    end;
    FLastGridWidth := GetGridWidth;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.sgParamsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sKey, sValue: String;
  oGrid: TStringGrid;
  oCanvas: TCanvas;
  oFont: TFont;
begin
  if gdFocused in State then
    Exit;
  oGrid := TStringGrid(Sender);
  oCanvas := oGrid.Canvas;
  oFont := oCanvas.Font;
  if ((ACol = 0) or (ACol = 1)) and (ARow = 1) or
     (ACol = 2) and (ARow > 0) then begin
    oFont.Color := clBtnShadow;
    oFont.Style := oFont.Style + [fsItalic];
  end
  else if (ACol = 1) and (ARow > 0) then begin
    sKey := oGrid.Cells[0, ARow];
    sValue := oGrid.Cells[1, ARow];
    if FDefaults.Values[sKey] <> sValue then
      oCanvas.Brush.Color := clInfoBk;
    oFont.Color := clHotLight;
  end;
    if oCanvas.Brush.Color = clInfoBk then
      oCanvas.FillRect(Rect);
    oCanvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 3, oGrid.Cells[ACol, ARow]);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.EditorExit(Sender: TObject);
var
  sKey, sVal: String;
  i: Integer;
begin
  sKey := sgParams.Cells[0, sgParams.Row];
  sVal := __TWinControl(GetEditor).Text;
  if sgParams.Cells[1, sgParams.Row] <> sVal then begin
    sgParams.Cells[1, sgParams.Row] := sVal;
    i := FEdited.IndexOfName(sKey);
    if i = -1 then
      i := FEdited.Add('');
    FEdited[i] := (sKey + '=' + sVal);
    FillParamValues(False);
    FillParamGrids(False);
    Modified;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.EditorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (GetEditor = cbParams) and cbParams.DroppedDown and (cbParams.Style <> csSimple) then
    Exit;
  if Key = VK_ESCAPE then begin
    AdjustEditor(GetEditor, sgParams.Col, sgParams.Row);
    case FEditor of
    0: edtParams.SelectAll;
    1: cbParams.SelectAll;
    2: bedtParams.SelectAll;
    end;
    Key := 0;
  end
  else if (Key = VK_RETURN) or (Key = VK_DOWN) and (Shift = []) then begin
    if sgParams.Row < sgParams.RowCount - 1 then begin
      EditorExit(nil);
      sgParams.Row := sgParams.Row + 1;
    end;
    Key := 0;
  end
  else if (Key = VK_UP) and (Shift = []) then begin
    if sgParams.Row > sgParams.FixedRows + 1 then begin
      EditorExit(nil);
      sgParams.Row := sgParams.Row - 1;
    end;
    Key := 0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.cbParamsDblClick(Sender: TObject);
begin
  if cbParams.ItemIndex + 1 >= cbParams.Items.Count then
    cbParams.ItemIndex := 0
  else
    cbParams.ItemIndex := cbParams.ItemIndex + 1;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.bedtParamsRightButtonClick(
  Sender: TObject);
begin
  OpenDialog1.FileName := bedtParams.Text;
  if OpenDialog1.Execute then begin
    bedtParams.Text := OpenDialog1.FileName;
    EditorExit(nil);
    bedtParams.SetFocus;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.frmOptionsModified(Sender: TObject);
begin
  Modified;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.btnTestClick(Sender: TObject);
var
  oConn: TFDCustomConnection;
  oDlg: TFDGUIxLoginDialog;
begin
  oConn := GetTempConnection;
  oDlg := TFDGUIxLoginDialog.Create(nil);
  try
    oDlg.HistoryEnabled := True;
    oDlg.VisibleItems.Text := '*';
    oConn.LoginDialog := oDlg;
    oConn.Close;
    oConn.Open;
    ShowMessage(S_FD_LoginDialogTestOk);
  finally
    FDFree(oDlg);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.btnWizardClick(Sender: TObject);
var
  oConn: TFDCustomConnection;
  oDrv: IFDPhysDriver;
  oWizard: IFDPhysDriverConnectionWizard;
  pWindowList: TTaskWindowList;
  hWin: HWND;
begin
  oConn := GetTempConnection;
  oConn.Close;
  oConn.CheckConnectionDef;
  FDPhysManager.CreateDriver(oConn.Params.DriverID, oDrv);
  oDrv.CreateConnectionWizard(oWizard);
  if oWizard = nil then
    MessageDlg(S_FD_WizardNotAccessible, mtWarning, [mbOK], -1)
  else begin
    hWin := GetActiveWindow;
    pWindowList := DisableTaskWindows(0);
    try
      if oWizard.Run(oConn.ResultConnectionDef, hWin) then begin
        FEdited.SetStrings(oConn.Params);
        FillParamValues(False);
        FillParamGrids(True);
      end;
    finally
      EnableTaskWindows(pWindowList);
      SetActiveWindow(hWin);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.btnDefaultsClick(Sender: TObject);
begin
  ResetData;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.btnWikiClick(Sender: TObject);
var
  sID, sDesc: String;
begin
  try
    sID := FDManager.GetBaseDriverID(FDriverID);
    if CompareText(sID, S_FD_IBLiteId) = 0 then
      sID := S_FD_IBId;
    sDesc := FDManager.GetBaseDriverDesc(sID);
  except
    ShowMessage(Format(S_FD_ConnEditNoDrv, [FDriverID]));
    Exit;
  end;
  sDesc := StringReplace(sDesc, ' ', '_', [rfReplaceAll]);
  FDShell(Format(S_FD_Docu_ConnectToLink, [sDesc]), S_FD_LComp_Design);
end;

{------------------------------------------------------------------------------}
// Info page

procedure TfrmFDGUIxFormsConnEdit.FillConnectionInfo(AConnection: TFDCustomConnection;
  ATryToConnect: Boolean);
var
  eItems: TFDInfoReportItems;
var
  oConn: TFDCustomConnection;
begin
  if AConnection = nil then
    oConn := GetTestConnection
  else begin
    oConn := AConnection;
    ATryToConnect := False;
  end;
  eItems := [riConnDef .. riKeepConnected];
  if not ATryToConnect then
    eItems := eItems - [riTryConnect, riKeepConnected];
  oConn.GetInfoReport(mmInfo.Lines, eItems);
end;

{------------------------------------------------------------------------------}
// SQL page

procedure TfrmFDGUIxFormsConnEdit.mmScriptKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  scrEngineBeforeExecute(nil);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.mmScriptMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  scrEngineBeforeExecute(nil);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEngineBeforeExecute(Sender: TObject);
begin
  scrEngine.SQLScripts[0].SQL.Text := mmScript.Lines.Text;
  scrEngine.Position := mmScript.CaretPos;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEngineAfterExecute(Sender: TObject);
begin
  if not scrEngine.Eof then
    mmScript.CaretPos := scrEngine.Position
  else
    mmScript.SelStart := mmScript.GetTextLen;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEngineConsoleGet(AEngine: TFDScript;
  const APrompt: string; var AResult: string);
begin
  InputQuery(S_FD_ConnEditEnterVal, APrompt, AResult);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEngineConsoleLockUpdate(AEngine: TFDScript;
  ALock: Boolean);
begin
  if ALock then
    mmLog.Lines.BeginUpdate
  else
    mmLog.Lines.EndUpdate;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEngineConsolePut(AEngine: TFDScript;
  const AMessage: string; AKind: TFDScriptOutputKind);
var
  i: Integer;
begin
  if AEngine.CurrentCommand <> nil then
    i := AEngine.CurrentCommand.Position.Y
  else
    i := -1;
  mmLog.Lines.AddObject(AMessage, {$IFDEF AUTOREFCOUNT} TFDValWrapper.Create(i) {$ELSE}
                                                        TObject(i) {$ENDIF});
  Application.ProcessMessages;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.scrEnginePause(AEngine: TFDScript;
  const AText: string);
begin
  ShowMessage(AText + #13#10 + S_FD_ConnEditPressOk);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.mmLogDblClick(Sender: TObject);
var
  i: Integer;
  o: TObject;
begin
  if (mmLog.CaretPos.Y >= 0) and (mmLog.CaretPos.Y < mmLog.Lines.Count) then begin
    o := mmLog.Lines.Objects[mmLog.CaretPos.Y];
    i := {$IFDEF AUTOREFCOUNT} TFDValWrapper(o).AsInt {$ELSE} LongWord(o) {$ENDIF};
    if i >= 0 then
      mmScript.CaretPos := Point(0, i);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acRunUpdate(Sender: TObject);
begin
  acRun.Enabled := (scrEngine.Connection <> nil) and not scrEngine.IsEmpty;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acRunExecute(Sender: TObject);
begin
  mmScript.CaretPos := Point(0, 0);
  scrEngine.ValidateAll;
  if scrEngine.Status = ssFinishSuccess then
    scrEngine.ExecuteAll;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acRunByStepUpdate(Sender: TObject);
begin
  acRunByStep.Enabled := (scrEngine.Connection <> nil) and not scrEngine.Eof;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acRunByStepExecute(Sender: TObject);
var
  rPos: TPoint;
begin
  rPos := mmScript.CaretPos;
  scrEngine.ExecuteStep;
  if scrEngine.TotalErrors <> 0 then
    mmScript.CaretPos := rPos;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acSkipStepUpdate(Sender: TObject);
begin
  acSkipStep.Enabled := not scrEngine.Eof;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.acSkipStepExecute(Sender: TObject);
begin
  scrEngine.ValidateStep;
end;

{------------------------------------------------------------------------------}
// TFDConnection editor

class function TfrmFDGUIxFormsConnEdit.Execute(AConn: TFDCustomConnection;
  const ACaption: String; const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean;
var
  oFrm: TfrmFDGUIxFormsConnEdit;
  lFreeFrm: boolean;
begin
  lFreeFrm := False;
  if ACustomFrm <> nil then
    oFrm := ACustomFrm
  else begin
    oFrm := TfrmFDGUIxFormsConnEdit.Create(nil);
    lFreeFrm := True;
  end;
  try
    oFrm.LoadState;
    oFrm.FConnection := AConn;
    oFrm.Caption := Format(S_FD_ConnEditCaption, [ACaption]);
    FDManager.GetDriverNames(oFrm.cbServerID.Items);
    FDManager.GetConnectionDefNames(oFrm.cbConnectionDefName.Items);
    if AConn.ConnectionDefName <> '' then begin
      oFrm.cbConnectionDefName.Text := AConn.ConnectionDefName;
      oFrm.FConnectionDefName := AConn.ConnectionDefName;
      try
        oFrm.FDriverID := FDManager.ConnectionDefs.ConnectionDefByName(
          AConn.ConnectionDefName).Params.DriverID;
      except
        Application.HandleException(nil);
        oFrm.cbConnectionDefName.Text := '';
        oFrm.FConnectionDefName := '';
      end;
    end
    else if AConn.DriverName <> '' then begin
      oFrm.cbServerID.Text := AConn.DriverName;
      oFrm.FDriverID := AConn.DriverName;
    end;
    oFrm.FEdited.SetStrings(AConn.Params);
    oFrm.FillParamValues(False);
    oFrm.FillParamGrids(True);
    oFrm.frmFetchOptions.LoadFrom(AConn.FetchOptions);
    oFrm.frmFormatOptions.LoadFrom(AConn.FormatOptions);
    oFrm.frmUpdateOptions.LoadFrom(AConn.UpdateOptions);
    oFrm.frmResourceOptions.LoadFrom(AConn.ResourceOptions);
    Result := (oFrm.ShowModal = mrOK);
    if Result then
      oFrm.SetConnectionParams(AConn);
    oFrm.SaveState;
  finally
    if lFreeFrm then
      FDFree(oFrm);
  end;
end;

{------------------------------------------------------------------------------}
class function TfrmFDGUIxFormsConnEdit.Execute(var AConnStr: String;
  const ACaption: String; const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean;
var
  oConn: TFDCustomConnection;
begin
  oConn := TFDCustomConnection.Create(nil);
  try
    oConn.Temporary := True;
    oConn.ResultConnectionDef.ParseString(AConnStr);
    Result := Execute(oConn, ACaption, ACustomFrm);
    if Result then
      AConnStr := oConn.ResultConnectionDef.BuildString();
  finally
    FDFree(oConn);
  end;
end;

{------------------------------------------------------------------------------}
class function TfrmFDGUIxFormsConnEdit.Execute(AConnDef: IFDStanConnectionDef;
  const ACaption: String; const ACustomFrm: TfrmFDGUIxFormsConnEdit = nil): Boolean;
var
  oConn: TFDCustomConnection;
  sName: String;
begin
  oConn := TFDCustomConnection.Create(nil);
  try
    oConn.Temporary := True;
    oConn.Params.SetStrings(AConnDef.Params);
    AConnDef.ReadOptions(oConn.FormatOptions, oConn.UpdateOptions,
      oConn.FetchOptions, oConn.ResourceOptions);
    sName := AConnDef.Name;
    Result := Execute(oConn, ACaption, ACustomFrm);
    if Result then begin
      AConnDef.Params.SetStrings(oConn.Params);
      AConnDef.WriteOptions(oConn.FormatOptions, oConn.UpdateOptions,
        oConn.FetchOptions, oConn.ResourceOptions);
      AConnDef.Name := sName;
    end;
  finally
    FDFree(oConn);
  end;
end;

{------------------------------------------------------------------------------}
// ConnectionDef editor

constructor TfrmFDGUIxFormsConnEdit.CreateForConnectionDefEditor;
const
  C_TitleHeight = 27;
begin
  inherited Create(nil);
  BorderStyle := bsNone;
  sgParams.Top := sgParams.Top - (pnlTitle.Height - C_TitleHeight);
  sgParams.Height := sgParams.Height + (pnlTitle.Height - C_TitleHeight);
  sgParams.Color := clBtnFace;
  pnlTitle.Height := C_TitleHeight;
  Label2.Visible := False;
  cbConnectionDefName.Visible := False;
  cbServerID.Left := cbServerID.Left + 5;
  pnlButtons.Visible := False;
  btnDefaults.Visible := False;
  btnTest.Visible := False;
  btnWizard.Visible := False;
  btnWiki.Visible := False;
  FLockResize := True;
  ActionList1.State := asSuspended;
  tsSQL.TabVisible := False;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.LoadData(AConnectionDef: IFDStanConnectionDef);
begin
  FConnectionDef := AConnectionDef;
  FDManager.GetDriverNames(cbServerID.Items);
  FConnectionDefName := AConnectionDef.Name;
  cbServerID.Text := AConnectionDef.Params.DriverID;
  FDriverID := AConnectionDef.Params.DriverID;
  FEdited.SetStrings(AConnectionDef.Params);
  FillParamValues(False);
  FillParamGrids(True);
  FOptions := TFDOptionsContainer.Create(nil, TFDFetchOptions, TFDUpdateOptions,
    TFDTopResourceOptions, nil);
  AConnectionDef.ReadOptions(FOptions.FormatOptions, FOptions.UpdateOptions,
    FOptions.FetchOptions, FOptions.ResourceOptions);
  frmFetchOptions.LoadFrom(FOptions.FetchOptions);
  frmFormatOptions.LoadFrom(FOptions.FormatOptions);
  frmUpdateOptions.LoadFrom(FOptions.UpdateOptions);
  frmResourceOptions.LoadFrom(FOptions.ResourceOptions);
  FLockResize := False;
  FModified := False;
  ReleaseTempConnection;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.PostChanges;
begin
  if GetEditor.Visible then
    EditorExit(nil);
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.SaveData;
begin
  frmFetchOptions.SaveTo(FOptions.FetchOptions);
  frmFormatOptions.SaveTo(FOptions.FormatOptions);
  frmUpdateOptions.SaveTo(FOptions.UpdateOptions);
  frmResourceOptions.SaveTo(FOptions.ResourceOptions);

  FillConnParams(FConnectionDef.Params);
  FConnectionDef.Name := FConnectionDefName;
  FConnectionDef.Params.DriverID := FDriverID;
  FConnectionDef.WriteOptions(FOptions.FormatOptions, FOptions.UpdateOptions,
    FOptions.FetchOptions, FOptions.ResourceOptions);
  FModified := False;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.ResetState(AClear: Boolean);
begin
  GetEditor.Visible := False;
  if AClear then
    FConnectionDef := nil;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.ResetData;
begin
  ResetOpts;
  ResetConnectionDef;
  Modified;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.ResetPage;
begin
  if pcMain.ActivePage = tsConnection then begin
    ResetConnectionDef;
    Modified;
  end
  else if pcMain.ActivePage = tsOptions then begin
    ResetOpts;
    Modified;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.SetReadOnly(AValue: Boolean);
begin
  if AValue then begin
    sgParams.Font.Color := clGray;
    Label1.Enabled := False;
    cbServerID.Enabled := False;
    tsOptions.Enabled := False;
    ptreeOptions.Enabled := False;
    GetEditor.Visible := False;
  end
  else begin
    sgParams.Font.Color := clWindowText;
    Label1.Enabled := True;
    cbServerID.Enabled := True;
    tsOptions.Enabled := True;
    ptreeOptions.Enabled := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmFDGUIxFormsConnEdit.TestConnection;
begin
  btnTestClick(nil);
end;

end.
