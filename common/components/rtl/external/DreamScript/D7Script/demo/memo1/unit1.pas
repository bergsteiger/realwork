{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit Unit1;

interface
{$include PROD.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, dcsystem, dcparser, Db, DBTables, dccontrols,
  dcdbmemo, dcstring, ComCtrls, StdCtrls, DBCtrls, dcstdctl, dccommon,
  dcmemo, dcedit, dcenvopt, editunit,dcconsts, {dcmemoreg,}
  dcapi,dcmemopt,
  Grids {$IFDEF DREAMINSPECTOR},oinspect{$ENDIF}, PropCB;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DelphiParser: TDelphiParser;
    Panel1: TPanel;
    DCMemo1: TDCMemo;
    GroupBox1: TGroupBox;
    DCPropEditor1: TDCColorEdit;
    Label1: TLabel;
    Label2: TLabel;
    DCPropEditor2: TEdit;
    GroupBox2: TGroupBox;
    DCPropEditor3: TDCColorEdit;
    DCPropEditor4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    DCPropCheckBox2: TDCPropCheck;
    DCPropCheckBox3: TDCPropCheck;
    GroupBox4: TGroupBox;
    Button2: TSpeedButton;
    Button1: TSpeedButton;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    DCMemo2: TDCMemo;
    VBParser: TVBScriptParser;
    TabSheet3: TTabSheet;
    Panel3: TPanel;
    DCMemo3: TDCMemo;
    RadioGroup1: TRadioGroup;
    CParser: TCPPParser;
    TabSheet4: TTabSheet;
    DCMemo4: TDCMemo;
    Panel4: TPanel;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    StatusBar1: TStatusBar;
    TabSheet5: TTabSheet;
    DCMemo5: TDCMemo;
    Memo: TDCMemo;
    DCSplitter1: TDCSplitter;
    MemoSource1: TMemoSource;
    TabSheet6: TTabSheet;
    Panel5: TPanel;
    DBNavigator1: TDBNavigator;
    ActiveProp: TDCPropCheck;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    DBMemoSource1: TDBMemoSource;
    JavaScriptParser: TJavaScriptParser;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    DBMemo1: TDBMemo;
    Panel9: TPanel;
    Table1: TTable;
    Table1ID: TAutoIncField;
    Table1Extention: TStringField;
    Table1Memo: TMemoField;
    DataSource1: TDataSource;
    TabSheet7: TTabSheet;
    DCMemo8: TDCMemo;
    Label6: TLabel;
    DCMemo6: TDCMemo;
    Button8: TButton;
    Button9: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Panel10: TPanel;
    TabSheet8: TTabSheet;
    Panel11: TPanel;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    DCMemo9: TDCMemo;
    Panel12: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DCSplitter2: TDCSplitter;
    Panel13: TPanel;
    DCSplitter5: TDCSplitter;
    DCSplitter3: TDCSplitter;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    Panel14: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Panel15: TPanel;
    Label12: TLabel;
    Panel16: TPanel;
    Label13: TLabel;
    Panel17: TPanel;
    DownloadURL: TLabel;
    HelpFilesURL: TLabel;
    ManualURL: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    GroupBox5: TGroupBox;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    OpenPicDialog: TOpenDialog;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    DCPropEditor5: TComboBox;
    Button3: TButton;
    Label7: TLabel;
    DCPropEditor6: TDCColorEdit;
    Label8: TLabel;
    DCPropEditor7: TDCColorEdit;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    DCPropEditor8: TComboBox;
    Button13: TButton;
    DCPropEditor9: TDCColorEdit;
    DCPropEditor10: TDCColorEdit;
    Label26: TLabel;
    DCPropCheckBox1: TDCPropCheck;
    DCPropCheckBox4: TDCPropCheck;
    TabSheet11: TTabSheet;
    Panel18: TPanel;
    DCMemo7: TDCMemo;
    GroupBox8: TGroupBox;
    DCPropCheckBox6: TDCPropCheck;
    GroupBox9: TGroupBox;
    DCPropCheckBox5: TDCPropCheck;
    DCPropCheckBox7: TDCPropCheck;
    DCPropCheckBox8: TDCPropCheck;
    DCPropCheckBox9: TDCPropCheck;
    DCPropEditor11: TDCColorEdit;
    DCPropEditor12: TDCPenStyleEdit;
    Label27: TLabel;
    Label28: TLabel;
    DCPropCheckBox10: TDCPropCheck;
    Label21: TLabel;
    Image1: TImage;
    Label22: TLabel;
    Label29: TLabel;
    lblWWW: TLabel;
    Label23: TLabel;
    lblEMail: TLabel;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DCMemo4StateChange(Sender: TObject; State: TMemoStates);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure lblWWWClick(Sender: TObject);
    procedure lblEMailClick(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure DownloadURLClick(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure DCMemo3HintPopup(Sender: TObject; Strings: TStrings;
      var AllowPopup: Boolean; var PopupType: TPopupType);
    procedure DCMemo3HintInsert(Sender: TObject; var s: String);
    procedure DCPropEditor1Change(Sender: TObject);
    procedure DCPropEditor2Exit(Sender: TObject);
    procedure DCPropEditor2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCPropEditor3Change(Sender: TObject);
    procedure DCPropEditor4Exit(Sender: TObject);
    procedure DCPropEditor4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DCPropEditor11Change(Sender: TObject);
    procedure DCPropEditor12Change(Sender: TObject);
    procedure DCPropEditor6Change(Sender: TObject);
    procedure DCPropEditor7Change(Sender: TObject);
    procedure DCPropEditor9Change(Sender: TObject);
    procedure DCPropEditor10Change(Sender: TObject);
    procedure DCPropEditor5Change(Sender: TObject);
    procedure DCPropEditor8Change(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

uses ShellApi;

{$R *.DFM}

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'OK to overwrite %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  GutterWid = 6;

const
  DelphiLines ='procedure TForm1.Button1Click(Sender: TObject);'#13#10+
               'begin'#13#10+
               '  DCMemo1.GetSource.ToggleBookmark(10);'#13#10+
               'end;'#13#10+
               #13#10+
               'procedure TForm1.Button2Click(Sender: TObject);'#13#10+
               'begin'#13#10+
               '  DCMemo1.ToggleImageAndTextStyle(STxtStBreakPnt);'#13#10+
               'end;'#13#10+
               #13#10+
               'function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;'#13#10+
               'asm'#13#10+
               '       PUSH    ESI'#13#10+
               '       PUSH    EDI'#13#10+
               '       MOV     ESI,P1'#13#10+
               '       MOV     EDI,P2'#13#10+
               '       MOV     EDX,ECX'#13#10+
               '       XOR     EAX,EAX'#13#10+
               '       AND     EDX,3'#13#10+
               '       SHR     ECX,1'#13#10+
               '       SHR     ECX,1'#13#10+
               '       REPE    CMPSD'#13#10+
               '       JNE     @@2'#13#10+
               '       MOV     ECX,EDX'#13#10+
               '       REPE    CMPSB'#13#10+
               '       JNE     @@2'#13#10+
               '@@1:   INC     EAX'#13#10+
               '@@2:   POP     EDI'#13#10+
               '       POP     ESI // asm code'#13#10+
              'end;';

  CPPLines =   'void __fastcall TForm1::New1Click(TObject *Sender)'#13#10+
               '{'#13#10+
               '  MainIDEObject()->NewObjectOfClass(__classid(TIDEMemoObject),"Text",true);'#13#10+
               '  SetImages();'#13#10+
               '}'#13#10+
               '//---------------------------------------------------------------------------'#13#10+
               'void __fastcall TForm1::Open1Click(TObject *Sender)'#13#10+
               '{'#13#10+
               '  MainIDEObject()->Open();'#13#10+
               '  SetImages();'#13#10+
               '}'#13#10+
               '//---------------------------------------------------------------------------';

  VBLines   =  'Sub Button2Click(Sender)'#13#10+
               '  AFlat = not AFlat'#13#10+
               '  call SetFlatProp(A,AFlat)'#13#10+
               '  Showmessage(Format(mes1,Array("Flat","OpenBut,SaveBut,CloseBut,FindBut") ) )'#13#10+
               'End Sub'#13#10+
               #13#10+
               'Sub Button1Click(Sender)'#13#10+
               '  AEnabled = not AEnabled'#13#10+
               '  call SetEnabledControls(A,AEnabled)'#13#10+
               '  Showmessage(Format(mes1,Array("Enabled","OpenBut,SaveBut,CloseBut,FindBut") ) )'#13#10+
               'End Sub';

var
  Descriptions : array[1..60] of string =

('TDCMemo.MarginPen =Indicates the pen used to draw the right margin. Use this property to specify the pen to use for drawing margins in memo control.'+
'The value of Pen is a TPen object. Set the properties of the TPen object to specify the color, style, width, and mode of the pen.',
'TDCMemo.BackGround =Specifies the background image that is displayed in the memo.',
'TDCMemo.BkgndOption =Specifies how the background image is displayed in the memo. Assign boCenter to this property if you want the image to be displayed in the center of the memo, boStreched - to stretch the image to the whole memo client area,'+
' boTile - to tile the image, boNone - to disable the image',
'TDCMemo.BlockIndent =Contains the indent of the current block.',
'TDCMemo.BorderStyle =Use BorderStyle to affect the sharpness with which the client area of the memo control stands out. '+
'BorderStyle can have a value of either bsSingle or bsNone. If BorderSyle is bsSingle, the memo control has a single-line border around the client area. If BorderStyle is bsNone, there will be no border.',
'TDCMemo.Color =Use this property to specify the color of the memo control.',
'TDCMemo.Ctl3D =Use Ctl3D to control the appearance of the control. If Ctl3D is True, the control has a 3-D appearance. If Ctl3D is False, the control appears flat.',
'TDCMemo.Cursor =Specifies the image used to represent the mouse pointer when it passes into the region covered by the control.',
'TDCMemo.DisabledColor =Contains the color that will be used to draw the memo content when the memo is disabled.',
'TDCMemo.DragCursor =Indicates the image used to represent the mouse pointer when the control is being dragged.',
'TDCMemo.Enabled =Use Enabled to change the availability of the control to the user. To disable a control, set Enabled to False. Disabled controls appear dimmed. If Enabled is '+
'False, the control ignores mouse and keyboard events.To re-enable a control, set Enabled to True.',
'TDCMemo.Font =Controls the attributes of text written in the control. To change to a new font, specify a new TFont object. To modify a font, change the value of the Color, Height, Name, Pitch, Size, or Style of the TFont object.',
'TDCMemo.GutterBackColor =Stores the background color of gutter that is displayed in the memo control.',
'TDCMemo.GutterBrush =GutterBrush specifies the color and pattern used for filling the gutter.',
'TDCMemo.GutterLineColor =Indicates the color used to display the vertical line on the gutter.',
'TDCMemo.GutterWidth =Stores the horizontal size of gutter. You can change the value stored in this property from 5 to MaxInt.',
'TDCMemo.HideCaret =Assign True to this property in order to hide the caret in the memo control.',
'TDCMemo.HideScrollBars =Assign True to this property in order to hide scroll bars in the memo control.',
'TDCMemo.HideSelection =Assign True to this property in order to the current selection made in the memo control.',
'TDCMemo.HorzMaxPos =Indicates the maximal position (in characters) of the horizontal scroll bar in memo. This property is used only to calculate the size of scroll pointer, it does not matter on the horizontal '+
'size (length) of the text that can be displayed in a memo.',
'TDCMemo.KeyMapping =This property stores the name of registered keyboard mapping. The values of this property can be ''Default'', ''Classic'', and ''Epsilon''.',
'TDCMemo.LeftIndent =This property contains the left indent that is applied to the memo text if Options.moLeftIndent is True.',
'TDCMemo.LineNumAlign =Indicates the alignment of line numbers in memo.',
'TDCMemo.LineNumColor =Stores the color of line numbers in memo.',
'TDCMemo.Lines =This property is the same to TCustomMemoSource.Strings property that stores the text that is displayed in the memo.',
'TDCMemo.MarginPen =Use this property to specify the pen to use for drawing margins in memo control. The value of Pen is a TPen object. Set the properties of the TPen object to specify the color, style, width, and mode of the pen.',
'TDCMemo.MarginPos =Stores the right margin in memo (in characters). You can change this value of this property from 2 to MaxInt.',
'TDCMemo.MatchBackColor =Stores the background color used to highlight found substring.',
'TDCMemo.MatchColor =Stores the color used to highlight found substring.',
'TDCMemo.Options =Options property specifies various display and behavioral parameters of the memo control.',
'TDCMemo.PrintOptions =PrintOptions property specifies various parameters that are used to print the content of the memo control.',
'TDCMemo.ReadOnly =This property indicates whether the user can change text in memo control. To restrict the edit control to display only, set the ReadOnly property to True.',
'TDCMemo.ScrollBars =Determines whether the memo control has any scroll bars and specifies which scroll bars it has (if any).',
'TDCMemo.SelBackColor =Indicates the background color of selected text.',
'TDCMemo.SelColor =Indicates the color of selected text.',
'TDCMemo.SpacesInTab =This property is used when there are tab characters in strings that are loaded from file/stream or from clipboard.',
'TDCMemo.StringsOptions =Options property specifies various display and behavioral properties of the memo source.',
'TDCMemo.SyntaxParser =This property contains the Syntax Parser that is used to highlight memo text.',
'TDCMemo.TabStops =This property stores the string with the values of tab stops. These values are retrieved from external (if any) or internal MemoSource that is specified in MemoSource property of the Memo.',
'TDCMemo.TemplatesType =This property contains the type of code templates that are used in memo (press Ctrl-J in the memo to see different templates)',
'TDCMemo.WantReturns = The WantReturns property determines if returns are enabled in a memo control. To enable returns for those controls set WantReturns to True. To turn returns off, set WantReturnsto False.',
'TDCMemo.WantTabs =The WantTabs property determines if tabs are enabled in a memo control. To enable tabs for those controls set WantTabs to True. To turn tabs off, set WantTabs to False.',
'TDCMemo.Options.moDrawMargin =Check to display a line at the right margin of the Code Editor.',
'TDCMemo.Options.moDrawGutter =Gutter is displayed if this moDrawGutter is set.',
'TDCMemo.Options.moThumbTracking =Determines whether the memo moves before the thumb tab is released.',
'TDCMemo.Options.moDblClickLine =Highlights the line when the user double-clicks any character in the line. If disabled, only the selected word is highlighted',
'TDCMemo.Options.moColorSyntax =Enables/disables syntax highlighting.',
'TDCMemo.Options.moLineNumbers =Enables/disables line numbering.',
'TDCMemo.Options.moDisableDrag =Enables/disables drag-and-drop in the memo control.',
'TDCMemo.Options.moLeftIndent =If this option is set then the value specified in TDCMemo.LeftIndent property will be applied to the text as a left indent.',
'TDCMemo.Options.moOverwriteCaret =If this option is set then the caret changes its shape when the user changes insert/overwrite mode in the memo control.',
'TDCMemo.Options.moSelectOnlyText =If this option is set then only text will be selected when the user makes a selection. Otherwise free space will also get into the selection.',
'TDCMemo.PrintOptions.poInColor =If this option is set then the memo text is printed in color.',
'TDCMemo.PrintOptions.poLineNumbers =If this option is set the the line numbers will be printed.',
'TDCMemo.PrintOptions.poPrintSel =If this option is set then only selected text will be printed.',
'TDCMemo.PrintOptions.poShowProgress =If this option is set the the progress dialog is displayed while printing.',
'TDCMemo.PrintOptions.poPrintHeader =If this option is set then the header with subordinate information is printed on each page.',
'TDCMemo.PrintOptions.poPrintSyntax =If this option is set then the memo text is printed with highlighting.',
'','');

procedure TForm1.Button1Click(Sender: TObject);
begin
  DCMemo1.GetSource.ToggleBookmark((Sender as TSpeedButton).Tag);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DCMemo1.ToggleImageAndTextStyle(STxtStBreakPnt);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if OpenPicDialog.Execute then
    DCMemo2.BackGround.LoadFromFile(OpenPicDialog.FileName);
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  with DCMemo3 do
    case RadioGroup1.ItemIndex of
      0  :
        begin
          Lines.Text := DelphiLines;
          SyntaxParser := DelphiParser;
          TemplatesType := 'Delphi';
        end;
      1  :
        begin
          Lines.Text := CPPLines;
          SyntaxParser := CParser;
          TemplatesType := 'C++ Builder';
        end;
      2  :
        begin
          Lines.Text := VBLines;
          SyntaxParser := VBParser;
          TemplatesType := 'Custom';
          CodeTemplates.Clear;
          with TMemoCodeTemplate(CodeTemplates.Add) do
          begin
            Name := 'Custom';
            Description := 'Your description';
            Code.Text := 'Your code';
          end;
        end;
   end;

end;

procedure TForm1.FormCreate(Sender: TObject);
const
  MemoDBName = 'dcmemo.db';
var
  AppFolder : string;
  i         : integer;
  {$IFDEF DREAMINSPECTOR}
  OI : TObjectInspector;
  DCSplitter: TDCSplitter;
  PropertyHelp: TPropertyHelp;
  {$ENDIF}
  MemoDBfolder,UpFolder:String;
begin
  RadioGroup1Click(Self);
  TreeView1.FullExpand;
  DCMemo7.Text := DCMemo2.Text;
  {$IFDEF DREAMINSPECTOR}

  OI:= TObjectInspector.Create(self);
  DCSplitter:= TDCSplitter.Create(self);
  PropertyHelp:= TPropertyHelp.Create(self);

  PropertyHelp.Parent := Panel13;
  PropertyHelp.Align := alBottom;
  PropertyHelp.Visible := True;
  DCSplitter.Parent := Panel13;
  DCSplitter.Align := alBottom;
  DCSplitter.Visible := True;
  OI.Parent := Panel13;
  OI.Align := alClient;
  OI.CurrentControl := DCMemo8;
  strarraytostrings(OI.Descriptions, descriptions);
  OI.FixedColWidth := OI.Width div 2;
  OI.Visible := True;
  PropertyHelp.Inspector := OI;
  {$ELSE}
  Tabsheet7.Free;
  {$ENDIF}
  PageControl1.ActivePage := TabSheet10;

  AppFolder := ExtractFilePath(ParamStr(0));
  if (Length(AppFolder) > 0) and (AppFolder[length(AppFolder)] <> '\') then
    AppFolder := AppFolder + '\';

  DCPropEditor1.SelectedColor := DCMemo1.GutterBrush.Color;
  DCPropEditor2.Text := IntToStr(DCMemo1.GutterWidth);
  DCPropEditor3.SelectedColor := DCMemo1.MarginPen.Color;
  DCPropEditor4.Text := IntToStr(DCMemo1.MarginPos);
  DCPropEditor5.ItemIndex := integer(DCMemo2.MemoBackground.BkgndOption);
  DCPropEditor6.SelectedColor := DCMemo2.MemoBackground.GradientBeginColor;
  DCPropEditor7.SelectedColor := DCMemo2.MemoBackground.GradientEndColor;
  DCPropEditor8.ItemIndex := integer(DCMemo2.GutterBackground.BkgndOption);
  DCPropEditor9.SelectedColor := DCMemo2.GutterBackground.GradientBeginColor;
  DCPropEditor10.SelectedColor := DCMemo2.GutterBackground.GradientEndColor;
  DCPropEditor11.SelectedColor := DCMemo7.LineSeparator.Pen.Color;
  DCPropEditor12.PenStyle := DCMemo7.LineSeparator.Pen.Style;
  {$IFDEF D3}
  DownloadURL.Cursor := crHandPoint;
  HelpFilesURL.Cursor := crHandPoint;
  ManualURL.Cursor := crHandPoint;
  Label16.Cursor := crHandPoint;
  lblWWW.Cursor := crHandPoint;
  lblEMail.Cursor := crHandPoint;
  {$ENDIF}

  MemoDBFolder:=AddSlash(DCUpFolder(DCUpFolder(AppFolder))) + 'MEMODB\';
  UpFolder:=AddSlash(DCUpFolder(AppFolder));

  with Table1 do
    if FileExists(MemoDBfolder+MemoDBName) then
      DataBaseName := MemoDBfolder
    else
    if FileExists(AppFolder+MemoDBName) then
      DataBaseName := AppFolder
    else
    if FileExists(UpFolder+MemoDBName) then
      DataBaseName := UpFolder
    else
      raise Exception.Create('Can''t find ' + MemoDBName);
  Table1.Open;
  ActiveProp.Checked := true;

  OpenDialog1.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog1.InitialDir := OpenDialog1.InitialDir;

  with DCMemo1.GetSource do
  begin
    BeginUpdate(acItemStateChanged);
    CollapseState[0] := csExpanded;
    for i :=  1 to 9 do
      LineVisible[i] := false;
    CollapseState[10] := csExpanded;
    for i :=  11 to 37 do
      LineVisible[i] := false;
    CollapseState[38] := csExpanded;
    for i :=  39 to Lines.Count - 1 do
      LineVisible[i] := false;
    EndUpdate;
  end;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
  DCMemo4.GetSource.ShowSearchDialog;
  DCMemo4.SetFocus;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  DCMemo4.GetSource.ShowReplaceDialog;
  DCMemo4.SetFocus;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  ShowEnvironmentOptions;
  DCMemo4.SetFocus;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  DCMemo4.GetSource.ShowGoToLineDialog;
  DCMemo4.SetFocus;
end;

procedure TForm1.DCMemo4StateChange(Sender: TObject; State: TMemoStates);
begin
  if StatusBar1 <> nil then
    UpdateStatusBar(StatusBar1,DcMemo4 ,State);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  DBMemoSource1.AutoDisplay := CheckBox1.Checked;
  DBMemo1.AutoDisplay  :=CheckBox1.Checked;;

end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  DBMemoSource1.ReadOnly := CheckBox2.Checked;
  DBMemo1.ReadOnly :=CheckBox2.Checked;;

end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
var
  s : string;
begin
  If Field<>nil then
    exit;
  s:= UpperCase(Table1Extention.AsString);
  With DBMemoSource1 do
  if S  = 'PAS' then
    SyntaxParser := DelphiParser
  else
  if S = 'JS' then
    SyntaxParser := JavaScriptParser
  else
  if S = 'VBS' then
    SyntaxParser := VBParser
  else
    SyntaxParser := nil;

end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    DCMemo4.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  with SaveDialog1 do
  begin
    DefaultExt := 'cpp';
    FilterIndex := 3;
    if Execute then
      DCMemo4.Lines.SaveToFile(FileName);
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  DCMemo9.PrintWithDialog;
end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  with SaveDialog1 do
  begin
    DefaultExt := 'rtf';
    FilterIndex := 6;
    if Execute then
      DCMemo9.ExportToRtfFile(FileName);
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
begin
  with SaveDialog1 do
  begin
    DefaultExt := 'html';
    FilterIndex := 7;
    if Execute then
      DCMemo9.ExportToHtmlFile(FileName);
  end;
end;

procedure TForm1.lblWWWClick(Sender: TObject);
begin
  JumpToURL('www.dream-com.com');
end;

procedure TForm1.lblEMailClick(Sender: TObject);
begin
  JumpToURL('mailto:contact@dream-com.com');
end;

procedure TForm1.Label16Click(Sender: TObject);
begin
  JumpToURL('http://www.dream-com.com');
end;

procedure TForm1.DownloadURLClick(Sender: TObject);
begin
  JumpToURL('http://www.dream-com.com/download.html');
end;

procedure TForm1.Button13Click(Sender: TObject);
begin
  if OpenPicDialog.Execute then
    DCMemo2.GutterBackGround.Background.LoadFromFile(OpenPicDialog.FileName);

end;

procedure TForm1.DCMemo3HintPopup(Sender: TObject; Strings: TStrings;
  var AllowPopup: Boolean; var PopupType: TPopupType);
var
  s : string;
begin
  with DcMemo3, GetSource do
  begin
    s := Strings[CaretPoint.Y];
    if (CaretPoint.X > 0) and (CaretPos.X <= length(s)) then
      AllowPopup := s[CaretPoint.X ] = '.';
  end;
  if AllowPopup then
  begin
    Strings.Add('--Sample--');
    Strings.Add('Align|~property');
    Strings.Add('Width|~property');
    Strings.Add('Create|~constructor');
    Strings.Add('Free|~procedure');
  end;
  PopupType := ptListBox;
end;

procedure TForm1.DCMemo3HintInsert(Sender: TObject; var s: String);
begin
  if Pos('|', s) <> 0 then
    s := Copy(s, 1, Pos('|', s) - 1);
end;

procedure TForm1.DCPropEditor1Change(Sender: TObject);
begin
  DCMemo1.GutterBrush.Color := DCPropEditor1.SelectedColor;
end;

procedure TForm1.DCPropEditor2Exit(Sender: TObject);
begin
  DCMemo1.GutterWidth := StrToInt(DCPropEditor2.Text);
end;

procedure TForm1.DCPropEditor2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    DCPropEditor2Exit(Sender);
end;

procedure TForm1.DCPropEditor3Change(Sender: TObject);
begin
  DCMemo1.MarginPen.Color := DCPropEditor3.SelectedColor;
end;

procedure TForm1.DCPropEditor4Exit(Sender: TObject);
begin
  DCMemo1.MarginPos := StrToInt(DCPropEditor4.Text);
end;

procedure TForm1.DCPropEditor4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    DCPropEditor4Exit(Sender);
end;

procedure TForm1.DCPropEditor11Change(Sender: TObject);
begin
  DCMemo7.LineSeparator.Pen.Color := DCPropEditor11.SelectedColor;
end;

procedure TForm1.DCPropEditor12Change(Sender: TObject);
begin
  DCMemo7.LineSeparator.Pen.Style := DCPropEditor12.PenStyle;
end;

procedure TForm1.DCPropEditor6Change(Sender: TObject);
begin
  DCMemo2.MemoBackground.GradientBeginColor := DCPropEditor6.SelectedColor;
end;

procedure TForm1.DCPropEditor7Change(Sender: TObject);
begin
  DCMemo2.MemoBackground.GradientEndColor := DCPropEditor7.SelectedColor;
end;

procedure TForm1.DCPropEditor9Change(Sender: TObject);
begin
  DCMemo2.GutterBackground.GradientBeginColor := DCPropEditor9.SelectedColor;
end;

procedure TForm1.DCPropEditor10Change(Sender: TObject);
begin
  DCMemo2.GutterBackground.GradientEndColor := DCPropEditor10.SelectedColor;
end;

procedure TForm1.DCPropEditor5Change(Sender: TObject);
begin
  DCMemo2.MemoBackground.BkgndOption := TBkgndOption(DCPropEditor5.ItemIndex);
end;

procedure TForm1.DCPropEditor8Change(Sender: TObject);
begin
  DCMemo2.GutterBackground.BkgndOption := TBkgndOption(DCPropEditor8.ItemIndex);
end;

end.
