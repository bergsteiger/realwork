unit Mainform;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, ExtCtrls, TextSrch,
  StdCtrls, OvcNbk, vtHeader, Mask, OvcBase, l3Types, l3Filer,
  //evEdWnd, W95Meter, {evParser,} k2TagGen, l3Intf,
  k2DocumentGenerator, Readers, l3IniFile, vtSpin,
  ComCtrls, ToolWin, ImgList, StBase, StShBase, StBrowsr,
  vtStatusBar, l3ProgressComponent, evTextFormatter, k2TagGen,
  k2StackGenerator, evdDocumentFilter, l3InterfacedComponent;

type
  TInFormat = (ifUnknown, ifRTF, ifTXT, ifHTML, ifDOC);

  TFileSrchForm = class(TForm)
    ToolBar1: TToolBar;
    tbFindFile: TToolButton;
    sbImport: TToolButton;
    sbExit: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label9: TLabel;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    Label7: TLabel;
    SpeedButton2: TSpeedButton;
    Label8: TLabel;
    Label10: TLabel;
    ComboBox1: TComboBox;
    edtRootDirectory: TEdit;
    outDirectory: TEdit;
    inpCPL: TvtSpinEdit;
    comboOutFormat: TComboBox;
    cbUseFormatting: TCheckBox;
    Panel2: TPanel;
    StatusBar1: TvtStatusBar;
    RTFFiler: TevDOSFiler;
    NSRCFiler: TevDOSFiler;
    TextFormatter: TevTextFormatter;
    ImageList1: TImageList;
    lstSrchResult: TListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbFindFileClick(Sender: TObject);
    procedure tbStopFindClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ResListFooterSizing(Sender: TObject; ASection,
      AWidth: Integer);
    procedure sbImportClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MyIdle(Sender: TObject; var Done: Boolean);
    procedure sbExitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);

  private
    f_Max: Longint;
    StBrowser1: TStBrowser;
    TextSrchLog : Boolean;
    SaveActiveControl : TWinControl;
    RTFReader: TRTFReader;
    CFG: TCFGList;
    f_FileMask: string;
    SelfDestroy: Boolean;
    Procedure InitDirNavigator;
    procedure ConvertOneFile(const InName: String);
    function InFileType(const InName: String): TInFormat;
    procedure ReadCFG;
    procedure WriteCFG;
  public
    { Public declarations }
  end;

var
 FileSrchForm : TFileSrchForm;

implementation

{$R *.DFM}

 Uses
   l3Base, l3Chars,

   Printers,
   //Str_man,
   evTypes,
   evTxtRd,
   evNSRWrt,
   evdWriter,
   {ddNSRC_w,}ddDOCReader, ddHTML_r, ddFileIterator, k2FileGenerator, evdPlainTextWriter;

procedure TFileSrchForm.FormCreate(Sender: TObject);
 begin
  StBrowser1:= TStBrowser.Create(Self);
  comboOutFormat.ItemIndex:= 0;
  ReadCFG;
  SelfDestroy:= False;
  RTFReader:= TRTFReader.Create(Self);
  RTFREader.LightVersion:= True;
  RTFReader.Filer:= RTFFiler;
  RTFREader.Generator:= TextFormatter;

  if UpperCase(ParamStr(1)) = '/AUTO' then
  begin
    Application.ProcessMessages;
    Application.OnIdle:= MyIdle;
  end;
 end;

procedure TFileSrchForm.MyIdle(Sender: TObject; var Done: Boolean);
begin
  Application.OnIdle:= nil;
  Done:= True;
  tbFindFileClick(Self);
  Application.ProcessMessages;
  sbImportClick(Self);
  Close;
end;


procedure TFileSrchForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if RTFFiler.CloseQuery(Handle) then
  Action := caHide
 else
  Action := caNone;
end;

Procedure TFileSrchForm.InitDirNavigator;
begin
 with TddFileIterator.Make(edtRootDirectory.Text, f_FileMask) do
 try
  lstSrchResult.Items:= FileList;
  sbImport.Enabled:= lstSrchResult.Items.Count > 0;
 finally
  Free;
 end;
end;

procedure TFileSrchForm.tbFindFileClick(Sender: TObject);
  procedure DisableCtrl(DisLog : Boolean);
   Begin
    tbFindFile       .Enabled  := Not DisLog;
    edtRootDirectory .Enabled  := Not DisLog;
   end;

  Begin
   if ComboBox1.ItemIndex < 0 then
   begin
     ShowMessage('Перед началом поиска необходимо выбрать тип файла');
     exit;
   end;

   InitDirNavigator;

  TextSrchLog:=false;
   DisableCtrl(True);


   SaveActiveControl:=ActiveControl;

   DisableCtrl(False);
   ActiveControl:=SaveActiveControl;
 end;

procedure TFileSrchForm.tbStopFindClick(Sender: TObject);
begin
 RTFFiler.CloseQuery(0);
end;

procedure TFileSrchForm.ResListFooterSizing(Sender: TObject; ASection,
  AWidth: Integer);
 Var
{  I : Byte; }
  C : TControl;
  Delta : Integer absolute AWidth;
 begin
  if Delta=0 then Exit;
  C:=nil;

  If Assigned(C) then C.Width := C.Width + Delta;

 end;

procedure TFileSrchForm.sbImportClick(Sender: TObject);
var
  i,j: Integer;
begin
 ForceDirectories(outDirectory.Text);
  try
    RTFReader.CharsInLine:= inpCPL.AsInteger;
    if lstSrchResult.SelCount > 0 then
    begin
      j:= 0;
      for i:= 0 to Pred(lstSrchResult.Items.Count) do
      begin
        if lstSrchResult.Selected[i] then
        begin
          Inc(j);
          StatusBar1.Panels[0].Text:= Format('%d из %d', [j, lstSrchResult.SelCount]);
          ConvertOneFile(lstSrchResult.Items[i]);
        end;
      end;
    end
    else
    for i:= 0 to Pred(lstSrchResult.Items.Count) do
    begin
      StatusBar1.Panels[0].Text:= Format('%d из %d', [i, lstSrchResult.Items.Count]);
      ConvertOneFile(lstSrchResult.Items[i]);
    end;
  finally
   ShowMessage('Преобразование закончено');
  end;
end;

function TFileSrchForm.InFileType(const InName: String): TInFormat;
var
  S: String;
begin
  S:= UpperCase(ExtractFileExt(InName));
  if S = '.RTF' then
    Result:= ifRTF
  else
  if S = '.TXT' then
    Result:= ifTXT
  else
  if (S = '.HTM') or (S = '.HTML') then
    Result:= ifHTML
  else
  if (S = '.DOC') then
    Result:= ifDOC
  else
    Result:= ifUnknown;
end;

procedure TFileSrchForm.ConvertOneFile(const InName: String);
var
  OutName: String;
  TxtR: TevTxtReader;
  HTMR: TddHTMLReader;
  NSRCGen: Tk2CustomFileGenerator;//TevNSRCWriter;//TddNSRCGenerator;
  DocReader: TddDocReader;
  ExtS: String;
begin
  StatusBar1.Panels[2].Text := InName;

  case comboOutFormat.ItemIndex of
    0: begin
         NsrcGen:= TevNSRCWriter.Create(nil);//TddNsrcGenerator.Create(nil);
         NSRCGen.CharsInLine:= inpCPL.AsInteger;
         ExtS:= '.nsr';
       end;
    1,2: begin
         NSRCGen:= TevdPlainTextWriter.Create(nil);
         NSRCGen.CharsInLine:= inpCPL.AsInteger;
         ExtS:= '.txt';
       end;
    3 : begin
          NSRCGen:= TevdNativeWriter.Create(nil);
          ExtS:= '.evd';
        end;
  else
    exit
  end;

  try
    if comboOutFormat.ItemIndex = 2 then
      TextFormatter.FormatOrdinalParas := false;
    TextFormatter.Generator:= NSRCGen;
    NSRCGen.Filer:= NSRCFiler;
    Application.ProcessMessages;
    if OutDirectory.Text = '' then
      OutName:= ChangeFileExt(InName, ExtS)
    else
    begin
      OutName:= OutDirectory.Text;
      if OutName[Length(OutName)] <> '\' then
        OutName:= OutName + '\';
      OutName:= OutName + ChangeFileExt(ExtractFileName(InName), ExtS);
    end;
    { В зависимости от формата входного файла нужно задействовать
     различные входные читалки }
    NSRCFiler.FileName:= OutName;
    NSRCFiler.CodePage:= CP_OEM;
    RTFFiler.FileName:= InName;

    case InFileType(InName) of
      ifRTF:
        begin
          RTFREader.LightVersion:= not cbUseFormatting.Checked;
          RTFReader.Execute;
        end;
      ifTXT:
        begin
          TxtR:= TevTxtReader.Create(nil);
          try
            TxtR.Filer:= RTFFiler;
            TxtR.Generator:= TextFormatter;
            TxtR.Execute;
          finally
            l3Free(TxtR);
          end;
        end;
      ifHTML:
        begin
          HTMR:= TddHTMLReader.Create(nil);
          try
            HTMR.Filer:= RTFFiler;
            HTMR.Generator:= TextFormatter;
            HTMR.Execute;
          finally
            l3Free(HTMR);
          end;
        end;
      ifDOC :
        begin
          DocReader:= TddDocReader.Create(nil);
          try
            DocReader.CharsInLine:= inpCPL.AsInteger;
            DocReader.UseOle:= True;
            DocReader.Filer:= RTFFiler;
            DocReader.Generator:= TextFormatter;
            DocReader.LightVersion:= not cbUseFormatting.Checked;
            DocReader.Execute;
          finally
            l3Free(DocReader);
          end;
        end;
    end; { case }


  finally
    l3Free(NSRCGen);
    Application.ProcessMessages;
    StatusBar1.Panels[2].Text := '';
  end;
end;

procedure TFileSrchForm.FormDestroy(Sender: TObject);
begin
  WriteCFG;
  l3Free(RTFReader);
end;

procedure TFileSrchForm.ReadCFG;
begin
  {}
  CFG:= TCFGlist.Create('');
  try
    with CFG do
    begin
      Section:= 'File';
      edtRootDirectory.Text:= ReadParamStrDef('Input', '');
      outDirectory.Text:= ReadParamStrDef('Output', '');
      f_FileMask:= ReadParamStrDef('Include', '*.rtf');
      ComboBox1.ItemIndex:= ReadParamIntDef('FileType', 0);
      comboOutFormat.ItemIndex:= ReadParamIntDef('OutFormat', 0);
      inpCPL.Value:= ReadParamIntDef('CharPerLine', 77);
    end;
  except
  end;
end;

procedure TFileSrchForm.WriteCFG;
begin
  try
    with CFG do
    begin
      Section:= 'File';
      WriteParamStr('Input', edtRootDirectory.Text);
      WriteParamStr('Output', outDirectory.Text);
      WriteParamStr('Include', f_FileMask);
      WriteParamInt('FileType', ComboBox1.ItemIndex);
      WriteParamInt('OutFormat', comboOutFormat.ItemIndex);
      WriteParamInt('CharPerLine', inpCPL.AsInteger);
    end;
  finally
    CFG.Free;
  end;
end;

procedure TFileSrchForm.sbExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFileSrchForm.Button1Click(Sender: TObject);
begin
  stBrowser1.Execute;
end;

procedure TFileSrchForm.SpeedButton1Click(Sender: TObject);
begin
  case TSpeedButton(Sender).Tag of
    1: begin
         stBrowser1.SelectedFolder:= edtRootDirectory.Text;
         stBrowser1.AdditionalText:= 'Из этого каталога будут браться файлы для конвертации';
         if stBrowser1.Execute then
           edtRootDirectory.Text:= stBrowser1.SelectedFolder
       end;
    2: begin
         stBrowser1.SelectedFolder:= outDirectory.Text;
         stBrowser1.AdditionalText:= 'В этот каталог будут записываься файлы после конвертации';
         if stBrowser1.Execute then
           outDirectory.Text:= stBrowser1.SelectedFolder
       end;
  end;
end;

procedure TFileSrchForm.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: f_FileMask:= '*.rtf';
    1: f_FileMask:= '*.txt';
    2: f_FileMask:= '*.doc';
    3: f_FileMask:= '*.htm;*.html';
    4: f_FileMask:= '*.doc;*.rtf;*.txt;*.htm;*.html';
    5: f_FileMask:= '*.*';
  end;
end;

end.
