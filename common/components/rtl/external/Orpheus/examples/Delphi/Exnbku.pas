unit Exnbku;
    
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, OvcNbk, OvcBase, OvcEf, OvcSf,
  OvcCal, OvcPb, OvcPf, OvcNf, OvcMisc, OvcSc, OvcData, ExtCtrls, Buttons,
  OvcTimer, STDate;

type
  TForm1 = class(TForm)
    btnTabPos: TButton;
    btnShadowText: TButton;
    Label1: TLabel;
    btnChangeTab: TButton;
    btnFontColor: TButton;
    ColorDialog1: TColorDialog;
    FontDialog1: TFontDialog;
    btnFontSel: TButton;
    NB1: TOvcNotebook;
    OvcFourWaySpinner1: TOvcFourWaySpinner;
    Label2: TLabel;
    OvcSimpleField1: TOvcSimpleField;
    OvcNotebook2: TOvcNotebook;
    OvcCalendar1: TOvcCalendar;
    Label3: TLabel;
    OvcPictureField1: TOvcPictureField;
    btnCalDate: TButton;
    OvcSimpleField2: TOvcSimpleField;
    OvcPictureField2: TOvcPictureField;
    OvcNumericField1: TOvcNumericField;
    Label4: TLabel;
    Label5: TLabel;
    btnTabDisable: TButton;
    OvcSimpleField3: TOvcSimpleField;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    OvcFourWaySpinner2: TOvcFourWaySpinner;
    Panel1: TPanel;
    btnClose: TBitBtn;
    TP: TOvcTimerPool;
    btnAuto: TBitBtn;
    OvcController1: TOvcController;
    OvcSpinner1: TOvcSpinner;
    procedure btnTabPosClick(Sender: TObject);
    procedure btnShadowTextClick(Sender: TObject);
    procedure btnChangeTabClick(Sender: TObject);
    procedure btnFontColorClick(Sender: TObject);
    procedure btnFontSelClick(Sender: TObject);
    procedure OvcFourWaySpinner1Click(Sender: TObject; State: TSpinState;
      Delta: Double; Wrap: Boolean);
    procedure btnCalDateClick(Sender: TObject);
    procedure OvcCalendar1Change(Sender: TObject);
    procedure btnTabDisableClick(Sender: TObject);
    procedure TPAllTriggers(Sender: TObject;
      TriggerHandle: Integer; Interval: Word; ElapsedTime: Longint);
    procedure FormCreate(Sender: TObject);
    procedure btnAutoClick(Sender: TObject);
    procedure NB1PageChanged(Sender: TObject; Index: Integer);
  private
    { Private declarations }
    T1,
    T2,
    T3 : Integer;  {trigger handles}
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


procedure TForm1.btnTabPosClick(Sender: TObject);
begin
  with NB1 do
    if TabOrientation = toRight then
      TabOrientation := toTop
    else
      TabOrientation := toRight;
end;

procedure TForm1.btnShadowTextClick(Sender: TObject);
begin
  with NB1 do
    ShadowedText := not ShadowedText;
end;

procedure TForm1.btnChangeTabClick(Sender: TObject);
begin
  NB1.PageIndex := OvcSimpleField1.AsInteger;
end;

procedure TForm1.btnFontColorClick(Sender: TObject);
begin
  ColorDialog1.Color := NB1.Font.Color;
  ColorDialog1.Execute;
  NB1.Font.Color := ColorDialog1.Color;
end;

procedure TForm1.btnFontSelClick(Sender: TObject);
begin
  FontDialog1.Font := NB1.Font;
  FontDialog1.Execute;
  NB1.Font := FontDialog1.Font;
end;

procedure TForm1.OvcFourWaySpinner1Click(Sender: TObject;
  State: TSpinState; Delta: Double; Wrap: Boolean);
begin
  with NB1 do begin
    if TabOrientation = toTop then begin
      case State of
        ssUpBtn : TabHeight := TabHeight + 1;
        ssDownBtn : TabHeight := TabHeight - 1;
        ssRightBtn : TabWidth := TabWidth + 5;
        ssLeftBtn : TabWidth := TabWidth - 5;
      end;
     end else begin
      case State of
        ssRightBtn : TabHeight := TabHeight + 1;
        ssLeftBtn : TabHeight := TabHeight - 1;
        ssUpBtn : TabWidth := TabWidth + 5;
        ssDownBtn : TabWidth := TabWidth - 5;
      end;
     end;
  end;
end;

procedure TForm1.btnCalDateClick(Sender: TObject);
begin
  {second page (index 1) contains the calendar}
  NB1.PageIndex := 1;
  {change the calendar date}
  OvcCalendar1.CalendarDate := OvcPictureField1.AsOvcDate;
end;

procedure TForm1.OvcCalendar1Change(Sender: TObject);
var
  S : string[25];
  Y : Word;
begin
  Y := OvcCalendar1.Year;
  S := Format('%d', [Y]);
  Panel1.Caption := OvcCalendar1.DateString('www, dd nnn yyyy');
end;

procedure TForm1.btnTabDisableClick(Sender: TObject);
begin
  with NB1 do
    PagesEnabled[3] := not PagesEnabled[3];
end;

procedure TForm1.TPAllTriggers(Sender: TObject;
  TriggerHandle: Integer; Interval: Word; ElapsedTime: Longint);
  {respond to all trigger events here}
const
  C : Integer = 0;
begin
  if TriggerHandle = T1 then begin
    Inc(C);
    if C > NB1.Pages.Count-1 then
      C := 0;
    if NB1.IsValid(C) then
      NB1.PageIndex := C;
  end;

  if TriggerHandle = T2 then begin
    btnTabPosClick(Sender);
  end;

  if TriggerHandle = T3 then begin
    btnTabDisableClick(Sender);
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Buf : array[0..255] of Char;
begin
  OvcSimpleField1.AsInteger := Form1.NB1.PageIndex;
  OvcCalendar1.CalendarDate := CurrentDate;
  {set picture mask to correspond with the control panel settings}
  OvcPictureField1.PictureMask :=
    StrPas(OvcCalendar1.IntlSupport.InternationalDatePChar(Buf, True));
  OvcPictureField1.AsOvcDate := CurrentDate;
  OvcSimpleField2.AsString := 'Simple Field Editor';
  OvcPictureField2.AsString := 'Picture Field Editor';
  OvcNumericField1.AsFloat := 32768.90;
end;

procedure TForm1.btnAutoClick(Sender: TObject);
const
  Started : Boolean = False;
begin
  Started := not Started;
  if Started then begin
    T1 := TP.Add(nil, 1000);
    T2 := TP.Add(nil, 7000);
    T3 := TP.Add(nil, 5000);
    btnAuto.Caption := 'Stop Auto Demo';
  end else begin
    TP.RemoveAll;
    btnAuto.Caption := 'Start Auto Demo';
  end;
end;

procedure TForm1.NB1PageChanged(Sender: TObject; Index: Integer);
begin
  OvcSimpleField1.AsInteger := Index;
end;

end.
