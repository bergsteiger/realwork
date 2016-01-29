unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, tmvInterfaces, eeButton, vtLabel,
  OvcBase, afwControl, vtPanel, evEditorWindow,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, evMemo,
  evCustomMemo, nevControl, afwControlPrim, afwBaseControl,
  afwTextControlPrim, afwTextControl, evCustomEdit, evEdit;

type
  TfmMain = class(TForm)
    Panel1: TvtPanel;
    Panel2: TvtPanel;
    PrevBtn: TeeBitBtn;
    NextBtn: TeeBitBtn;
    CloseBtn: TeeBitBtn;
    Panel3: TvtPanel;
    CaptionLabel: TvtLabel;
    CaptionText: TevMemo;
    FrequencyLabel: TvtLabel;
    FrequencyText: TevMemo;
    ContextLabel: TvtLabel;
    ContextText: TevMemo;
    MistakeLabel: TvtLabel;
    MistakeRadio1: TeeRadioButton;
    MistakeRadio2: TeeRadioButton;
    ProgressLabel: TvtLabel;
    InfoLabel: TvtLabel;
    MisPlaceLabel: TvtLabel;
    MistakeRadio3: TeeRadioButton;
    MistakeRadio4: TeeRadioButton;
    MistakeRadio8: TeeRadioButton;
    MistakeRadio7: TeeRadioButton;
    MistakeRadio6: TeeRadioButton;
    MistakeRadio5: TeeRadioButton;
    InfoEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure PrevBtnClick(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure Panel2Resize(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure MistakeRadio1Click(Sender: TObject);
    procedure InfoEditChange(Sender: TObject);
  private
    { Private declarations }
    f_Controller: ItmvController;
    f_PrevLeft: Integer;
    f_NextLeft: Integer;
    f_ContextWDelta: Integer;
    f_ContextHDelta: Integer;
    f_MistakeLabelDelta: Integer;
    f_MistakeRadioDelta: Integer;
    f_MistakeRadioInterval: Integer;
    f_InfoLabelDelta: Integer;
    f_InfoEditDelta: Integer;
    f_Checks: array [TtmvRecordKind] of TeeRadioButton;
    procedure UpdateIsMistake;
    procedure UpdateRecord;
    procedure AskClearClipboard(var aResult: Integer);
    procedure OnException(Sender: TObject; E: Exception);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses
 l3Interfaces,
 l3Chars,
 l3Base,

 evdStyles,
 evTypes,
 evEditorInterfaces,
 evTxtRd,

 nevBase,
 nevTools,

 tmvController;

{$R *.dfm}

procedure TfmMain.FormCreate(Sender: TObject);
var
 l_DataFileName: String;
 l_PositionFileName: String;

procedure lp_InitCheck(const aRadio: TeeRadioButton);
begin
 f_Checks[TtmvRecordKind(aRadio.Tag)] := aRadio;
end;

begin
 InfoEdit.MaxLength := c_tvmMaxInfoLength;
 Application.OnException := OnException;
 lp_InitCheck(MistakeRadio1);
 lp_InitCheck(MistakeRadio2);
 lp_InitCheck(MistakeRadio3);
 lp_InitCheck(MistakeRadio4);
 lp_InitCheck(MistakeRadio5);
 lp_InitCheck(MistakeRadio6);
 lp_InitCheck(MistakeRadio7);
 lp_InitCheck(MistakeRadio8);
 if ParamCount = 1 then
 begin
  l_DataFileName := ParamStr(1);
  l_PositionFileName := ChangeFileExt(l_DataFileName,'.cur');
  if ANSICompareText(l_DataFileName, l_PositionFileName) = 0 then
   l_PositionFileName := '';
 end
 else
 begin
  l_DataFileName := ChangeFileExt(Application.ExeName,'.dat');
  l_PositionFileName := ChangeFileExt(Application.ExeName,'.cur');
 end;
 f_Controller := TtmvController.Make(l_DataFileName, l_PositionFileName);
 f_NextLeft := Panel2.Width - NextBtn.Left;
 f_PrevLeft := Panel2.Width - PrevBtn.Left;
 f_ContextWDelta := Panel3.Width - (ContextText.Left + ContextText.Width);
 f_ContextHDelta := Panel3.Height - (ContextText.Top + ContextText.Height);
 f_MistakeLabelDelta := MistakeLabel.Top - (ContextText.Top + ContextText.Height);
 f_MistakeRadioDelta := MistakeRadio1.Top - (ContextText.Top + ContextText.Height);
 f_MistakeRadioInterval := MistakeRadio2.Top - MistakeRadio1.Top;
 f_InfoLabelDelta := InfoLabel.Top - (ContextText.Top + ContextText.Height);
 f_InfoEditDelta := InfoEdit.Top - (ContextText.Top + ContextText.Height);
 UpdateRecord;
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
 Application.OnException := nil;
 l3System.CheckClipboard(AskClearClipboard);
 f_Controller := nil;
end;

procedure TfmMain.CloseBtnClick(Sender: TObject);
begin
 Close;
end;

procedure TfmMain.UpdateIsMistake;
begin
 f_Checks[f_Controller.Current.MistakeKind].Checked := True;
 if f_Controller.Current.CanWriteInfo then
 begin
  InfoEdit.Enabled := True;
  InfoEdit.Color := clWindow;
 end
 else
 begin
  InfoEdit.Enabled := False;
  InfoEdit.Color := $00F9F8FA;
 end;
end;

procedure TfmMain.UpdateRecord;

 function lp_Process(const aStr: Il3CString): Tl3WString;
 begin
  if Assigned(aStr) then
   Result := aStr.AsWStr
  else
   Result := cc_EmptyStr;
 end;

var
 l_Op1 : InevOp;
 l_Op2 : InevOp;
 l_G   : InevTagGenerator;
begin
 l_Op1 := CaptionText.StartOp;
 try
  l_Op2 := ContextText.StartOp;
  try
   CaptionText.Buffer := lp_Process(f_Controller.Current.Caption);
   FrequencyText.Buffer := lp_Process(f_Controller.Current.Frequency);
   l_G := nil;
   ContextText.KeepAllFormatting := true;
   ContextText.TextSource.DocumentContainer.TagWriter.WriteTagEx(ContextText.View, TevCustomTxtReader.SetTo(l_G, f_Controller.Current.Context As IStream));
   PrevBtn.Enabled := f_Controller.CanPrev;
   NextBtn.Enabled := f_Controller.CanNext;
   ProgressLabel.CCaption := f_Controller.ProgressCaption;
   CaptionText.Select(ev_stDocument);
   CaptionText.TextPara.Formatting.HorizontalAligment := ed_halCenter;
   InevSelection(CaptionText.Selection).Unselect;
  finally
   l_Op2 := nil;
  end;//try..finally
 finally
  l_Op1 := nil;
 end;//try..finally
 InfoEdit.Text := f_Controller.Current.Info;
 UpdateIsMistake;
end;

procedure TfmMain.PrevBtnClick(Sender: TObject);
begin
 f_Controller.Prev;
 UpdateRecord;
end;

procedure TfmMain.NextBtnClick(Sender: TObject);
begin
 f_Controller.Next;
 UpdateRecord;
end;

procedure TfmMain.Panel2Resize(Sender: TObject);
begin
 NextBtn.Left := Panel2.Width - f_NextLeft;
 PrevBtn.Left := Panel2.Width - f_PrevLeft;
end;

procedure TfmMain.Panel3Resize(Sender: TObject);
var
 l_Bottom: Integer;
begin
 with ContextText do
  SetBounds(Left, Top, Panel3.Width - f_ContextWDelta - Left, Panel3.Height - f_ContextHDelta - Top);
 CaptionText.Width := ContextText.Width;
 InfoEdit.Width := ContextText.Width;
 l_Bottom := ContextText.Top + ContextText.Height;
 MistakeLabel.Top := f_MistakeLabelDelta + l_Bottom;
 MisPlaceLabel.Top := f_MistakeLabelDelta + l_Bottom;
 MistakeRadio1.Top := f_MistakeRadioDelta + l_Bottom;
 MistakeRadio2.Top := f_MistakeRadioDelta + f_MistakeRadioInterval + l_Bottom;
 MistakeRadio3.Top := f_MistakeRadioDelta + 2*f_MistakeRadioInterval + l_Bottom;
 MistakeRadio4.Top := f_MistakeRadioDelta + 3*f_MistakeRadioInterval + l_Bottom;
 MistakeRadio5.Top := f_MistakeRadioDelta + l_Bottom;
 MistakeRadio6.Top := f_MistakeRadioDelta + f_MistakeRadioInterval + l_Bottom;
 MistakeRadio7.Top := f_MistakeRadioDelta + 2*f_MistakeRadioInterval + l_Bottom;
 MistakeRadio8.Top := f_MistakeRadioDelta + 3*f_MistakeRadioInterval + l_Bottom;
 InfoLabel.Top := f_InfoLabelDelta + l_Bottom;
 InfoEdit.Top := f_InfoEditDelta + l_Bottom;
end;

procedure TfmMain.AskClearClipboard(var aResult: Integer);
begin
 aResult := ID_YES;
end;

procedure TfmMain.MistakeRadio1Click(Sender: TObject);
begin
 f_Controller.Current.MistakeKind := TtmvRecordKind(TControl(Sender).Tag);
 UpdateIsMistake;
end;

procedure TfmMain.OnException(Sender: TObject; E: Exception);
begin
 Application.ShowException(E);
 if E is EtvmInvalidFileFormat then
  Close;
end;

procedure TfmMain.InfoEditChange(Sender: TObject);
begin
 f_Controller.Current.Info := InfoEdit.Text;
end;

end.
