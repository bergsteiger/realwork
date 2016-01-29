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
{$I DCPROD.INC}
{.$I DC.INC}
(*
{$IFNDEF DREAMDESIGNER}
  {$R 'vclqrbmp.dcr'}
  {$R 'VCLDBBMP.DCR'}
  {$R 'vclstdbmp.DCR'}
  {$R 'vclsysbmp.dcr'}
  {$R 'vclwinbmp.dcr'}

  {$IFDEF D4}
    {$R 'vcl4bmp.dcr'}
  {$ENDIF}
{$ENDIF}
*)
uses
{$IFDEF DREAMIDE} dcpload,{$ENDIF}
{$IFDEF D3} checklst, {$ENDIF}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus,  dcstdctl, dcedit, StdCtrls, ExtCtrls, dcmenu, ComCtrls,
  dcpalet , DCGen, dcreg, dcsystem, Buttons, AviPlay, FormFill, dccommon,
  dcpedit, dcdreamlib, DCPalette;
                      
type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    FontPropEdit: TDCPropEditor;
    DCPropCheckBox1: TDCPropCheckBox;
    DCPropCheckBox2: TDCPropCheckBox;
    DCPropCheckBox3: TDCPropCheckBox;
    DCPropEditor3: TDCPropEditor;
    DCPropEditor5: TDCPropEditor;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    BrushStyle: TDCPropEditor;
    DCPropEditor6: TDCPropEditor;
    DCPropEditor7: TDCPropEditor;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TabSheet4: TTabSheet;
    PStoreMemo: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    TreeView1: TTreeView;
    TestPStoreMemo: TMemo;
    DCPropEditor1: TDCPropEditor;
    Label9: TLabel;
    Button1: TButton;
    DCPropEditor4: TDCPropEditor;
    Label10: TLabel;
    DCPropEditor8: TDCPropEditor;
    Label11: TLabel;
    DCPropStore1: TDCPropStore;
    Button2: TButton;
    Button3: TButton;
    TabSheet5: TTabSheet;
    VerbMemo: TMemo;
    Button4: TButton;
    Button5: TButton;
    VerbDispatcher1: TVerbDispatcher;
    Label12: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    PopupMenu1: TPopupMenu;
    ShowMessage1: TMenuItem;
    MessageDialog1: TMenuItem;
    Panel4: TPanel;
    Label1: TLabel;
    ColorEdit: TDCPropEditor;
    Label2: TLabel;
    DCPropEditor2: TDCPropEditor;
    DCSplitter1: TDCSplitter;
    TabSheet6: TTabSheet;
    MainMenu1: TMainMenu;
    Demo1: TMenuItem;
    PropEditors: TMenuItem;
    DCEditors1: TMenuItem;
    PropertyStorage1: TMenuItem;
    VerbDispacher1: TMenuItem;
    Othercontrols1: TMenuItem;
    Exit2: TMenuItem;
    Button6: TButton;
    PopupMenu2: TPopupMenu;
    Components1: TMenuItem;
    DCEditMemo: TMemo;
    GroupBox3: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    DCColorEdit1: TDCColorEdit;
    DCBrushStyleEdit1: TDCBrushStyleEdit;
    DCPenStyleEdit1: TDCPenStyleEdit;
    DCFileNameEdit1: TDCFileNameEdit;
    DCDirectoryEdit1: TDCDirectoryEdit;
    GroupBox4: TGroupBox;
    DCEdit1: TDCEdit;
    DCPropEditor9: TDCPropEditor;
    Label20: TLabel;
    DCPropEditor10: TDCPropEditor;
    Label21: TLabel;
    DCPropCheckBox9: TDCPropCheckBox;
    DCPropCheckBox10: TDCPropCheckBox;
    DCPropCheckBox11: TDCPropCheckBox;
    URLLabel: TLabel;
    DCCompPalette1: TDCCompPalette;
    Panel5: TPanel;
    DCCheckListBox1: TDCCheckListBox;
    OtherMemo: TMemo;
    DCSplitter2: TDCSplitter;
    TabSheet3: TTabSheet;
    Panel6: TPanel;
    LoadBut: TButton;
    Button8: TButton;
    PlayBut: TButton;
    Edit1: TEdit;
    SeekBut: TButton;
    InfoBut: TButton;
    DCPropCheckBox4: TDCPropCheckBox;
    DCPropCheckBox5: TDCPropCheckBox;
    DCPropCheckBox6: TDCPropCheckBox;
    DCPropCheckBox7: TDCPropCheckBox;
    Image1: TImage;
    TabSheet7: TTabSheet;
    Panel7: TPanel;
    Label13: TLabel;
    DCPropEditor11: TDCPropEditor;
    DCPropCheckBox8: TDCPropCheckBox;
    DCFormFill1: TDCFormFill;
    Aviplayer1: TMenuItem;
    Formfill1: TMenuItem;
    AVI: TDCAVIPlay;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Demo1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
    procedure InfoButClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure LoadButClick(Sender: TObject);
    procedure PlayButClick(Sender: TObject);
    procedure SeekButClick(Sender: TObject);
  private
    { Private declarations }
    avifile: PAVIFile;
    stream : PAVIStream;
    function  OpenAVIFile : boolean;
    procedure CloseAVIFile;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pgetframe : pointer;
  avifilename : string;

implementation
uses
{$IFDEF DREAMTREE}
  pstored,treemod,
{$ENDIF}
  unit2;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  CallPropertyEdit(TreeView1,'Items');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
{$IFDEF DREAMTREE}
  EditPropStore(Dcpropstore1);
{$ENDIF};
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
{$IFDEF DREAMTREE}
  EditStrings(Dcpropstore1.PropList, 'Editing PropList');
{$ENDIF};
end;

procedure ShowMess;
begin
  ShowMessage('Show Message Verb');
end;
procedure MessDlg;
begin
  MessageDlg('Message Dialog Verb',mtInformation,[mbOk],0);
end;

const
  VerbArray:Array[0..1] of TVerbData=(
    (Name:'CommonDemo.Showmessage' ; GetState:nil; Execute:ShowMess),
    (Name:'CommonDemo.MessageDlg'  ; GetState:nil ; Execute:MessDlg)
   );


procedure TForm1.Demo1Click(Sender: TObject);
begin
  with  PageControl1 do
    Case (Sender as TMenuItem).Tag of
      0 : ActivePage  := TabSheet1;
      1 : ActivePage  := TabSheet2;
      3 : ActivePage  := TabSheet4;
      4 : ActivePage  := TabSheet5;
      5 : ActivePage  := TabSheet6;
      6 : ActivePage  := TabSheet3;
      7 : ActivePage  := TabSheet7;
    end;
end;

procedure TForm1.Exit2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePage:=TabSheet1;
  {$IFDEF D3}
  URLLabel.Cursor:=crHandPoint;
  {$ENDIF}
  URLLabel.Caption:=CompanyURL;

  CorrectMemoText(PStoreMemo);
  CorrectMemoText(TestPStoreMemo);
  CorrectMemoText(VerbMemo);
  CorrectMemoText(DCEditMemo);
  CorrectMemoText(OtherMemo);

  RecreateWnd;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  CallPropertyEdit(VerbDispatcher1,'VerbList');
end;


procedure TForm1.URLLabelClick(Sender: TObject);
begin
  JumpToUrl(CompanyURL);
end;




function TForm1.OpenAVIFile : boolean;
begin
  result := false;
  if avifilename = '' then
    exit;
  AviFileInit;
  if (AVIFileOpen(@avifile, @(avifilename[1]), 0, nil) <> 0)
   or (AVIFileGetStream(avifile, @stream, 0, 0) <> 0) then
     begin
       result := false;
       exit;
     end;
  result := true;
end;

procedure TForm1.CloseAVIFile;
begin
  AVIStreamRelease(stream);
  AVIFileRelease(avifile);
  AviFileExit;
end;



procedure TForm1.InfoButClick(Sender: TObject);
var
  info        : TAVIFileInfo;
  sinfo       : TAVIStreamInfo;
  forminfo    : TForm2;
  videostream : PAVIStream;
  audiostream : PAVIStream;

  procedure _add;
  begin
    with forminfo.ListBox1.Items, sinfo do
      begin
        Add('fccType ' + IntToStr(fccType));
        Add('fccHandler ' + IntToStr(fccHandler));
        Add('dwFlags ' + IntToStr(dwFlags));
        Add('dwCaps ' + IntToStr(dwCaps));
        Add('wPriority ' + IntToStr(wPriority));
        Add('wLanguage ' + IntToStr(wLanguage));
        Add('dwScale ' + IntToStr(dwScale));
        Add('dwRate ' +IntToStr(dwRate));
        Add('dwStart ' + IntToStr(dwStart));
        Add('dwLength ' + IntToStr(dwLength));
        Add('dwInitialFrames ' + IntToStr(dwInitialFrames));
        Add('dwSuggestedBufferSize ' + IntToStr(dwSuggestedBufferSize));
        Add('dwQuality ' + IntToStr(dwQuality));
        Add('dwSampleSize ' + IntToStr(dwSampleSize));
        with rcFrame do
          Add('Frame : (' + IntToStr(left) + ', ' + IntToStr(Top) + ')-('+IntToStr(right) + ', ' + IntToStr(Bottom) + ')');

        Add('dwEditCount ' + IntToStr(dwEditCount));
        Add('dwFormatChangeCount ' + IntToStr(dwFormatChangeCount));
        Add(szName);
      end;
  end;

begin
  if not OpenAVIFile then
    exit;

  AVIFileInfo(avifile, @info, sizeof(info));
  forminfo := TForm2.Create(nil);
  try
    with forminfo.ListBox1.Items, info do
      begin
        Add('File information');
        Add('================');
        Add('dwMaxBytesPerSec ' + IntToStr(dwMaxBytesPerSec));
        Add('dwFlags ' + IntToStr(dwFlags));
        Add('dwCaps ' + IntToStr(dwCaps));
        Add('dwStreams ' + IntToStr(dwStreams));
        Add('dwSuggestedBufferSize ' + IntToStr(dwSuggestedBufferSize));
        Add('dwWidth ' + IntToStr(dwWidth));
        Add('dwHeight ' + IntToStr(dwHeight));
        Add('dwScale ' + IntToStr(dwScale));
        Add('dwRate ' + IntToStr(dwRate));
        Add('dwLength ' + IntToStr(dwLength));
        Add('dwEditCount ' + IntToStr(dwEditCount));
        Add(szFileType);

        if AVIFileGetStream(avifile, @videostream, streamtypeVIDEO, 0) = 0 then
          begin
            Add('');
            Add('Video Stream');
            Add('============');
            AVIStreamInfo(videostream, @sinfo, sizeof(sinfo));
            _add;
            AVIStreamRelease(videostream);
          end;

        if AVIFileGetStream(avifile, @audiostream, streamtypeAUDIO, 0) = 0 then
          begin
            Add('');
            Add('Audio Stream');
            Add('============');
            AVIStreamInfo(audiostream, @sinfo, sizeof(sinfo));
            _add;
            AVIStreamRelease(audiostream);
          end;

        forminfo.ShowModal;
      end;
  finally
    forminfo.Free;
  end;

  CloseAVIFile;
end;


procedure TForm1.Button8Click(Sender: TObject);
begin
  AVI.Stop;
end;


procedure TForm1.LoadButClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
      Caption := avifilename;
      avifilename := OpenDialog1.Filename;
      AVI.Filename := avifilename;
    end;
end;

procedure TForm1.PlayButClick(Sender: TObject);
begin
 with AVI do
   Play(0, FrameCount - 1, 0);

end;

procedure TForm1.SeekButClick(Sender: TObject);
begin
  try
    AVI.Seek(StrToInt(Edit1.Text));
  except
    exit;
  end;

end;

initialization
  RegisterVerbArray(VerbArray);

end.

