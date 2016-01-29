//...........................................................................................................................................................................................................................................................
{ Тестер для всяческих читалок-писалок. }

unit Main;

{$DEFINE writer}
{$define Lite}
{$DEFINE Searcher}
{$DEFINE OneStep}
{.$DEFINE AAC}
{$DEFINE evdNeedEverestTxt}
interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  XPStyleActnCtrls, ActnMan, l3InterfacedComponent, l3ProgressComponent,
  evTextSource, evEditorWindow, Menus, AppEvnts,
  ActnList, Dialogs, ImgList, ToolWin, ActnCtrls, ComCtrls, vtStatusBar,
  evMultiSelectEditorWindow, evCustomEditor, 
  evTunedEditor, evEditor, evRuler, OvcBase,  vtPanel,
  evToolPanel, evLinkedToolPanel, evSubPn,
  Forms, ExtCtrls, StdCtrls, Buttons,
  Mask, ActnMenus, evCustomTextSource, evEditorWindowTextSource,
  nevControl, evCustomEditorWindowPrim, evCustomEditorWindowModelPart,
  afwControlPrim, afwBaseControl, afwControl, afwTextControlPrim,
  afwTextControl,
  evMenu,
  l3Filer, l3Base, l3Interfaces,
  k2TagGen, k2Base, k2Reader,
  dxBar, XPMan, afwInterfaces,
  k2FileGenerator, evCustomEditorModelPart, evTextSourcePublished, l3Types,
  StdStyleActnCtrls, evCustomEditorWindow, evEditorWithOperations,
  evSubPanel;

type
  TddInOutType = (otUnknown, otRTF, otEVD, otEVR, otHTML, otNSRC,
                  otDoc, otPlainText, otPDF);

  TTesterForm = class(TForm)
    dlgOpenFile: TOpenDialog;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    SpellItem: TMenuItem;
    menuSaveAsEverest: TPopupMenu;
    N2: TMenuItem;
    dlgSaveFile: TSaveDialog;
    ActionList1: TActionList;
    actNewDocument: TAction;
    actOpenFile: TAction;
    actConvert2Everest: TAction;
    actConvert2RTF: TAction;
    actConvert2HTML: TAction;
    actConvert2NSRC: TAction;
    actConvert2TXT: TAction;
    actText2Table: TAction;
    actSpelling: TAction;
    actInsertTOC: TAction;
    actExit: TAction;
    actShowSpecial: TAction;
    actTest: TAction;
    actCreateBlockStruct: TAction;
    actSaveAs: TAction;
    act1Level: TAction;
    act2Level: TAction;
    act3Level: TAction;
    act4Level: TAction;
    actAllLevels: TAction;
    actBlendBlock: TAction;
    actRepairSections: TAction;
    ApplicationEvents1: TApplicationEvents;
    actLoadStyleTable: TAction;
    actTour: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    TextSource: TevTextSource;
    StatusBar1: TvtStatusBar;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    HTML1: TMenuItem;
    NSRC1: TMenuItem;
    RTF1: TMenuItem;
    XT1: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N110: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N20: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    actConvert2Anno: TAction;
    N22: TMenuItem;
    actConvert2AAS: TAction;
    N23: TMenuItem;
    evRuler1: TevRuler;
    actSource: TAction;
    N24: TMenuItem;
    evSubDescriptors1: TevSubDescriptors;
    Editor: TevEditor;
    evSubPanel1: TevSubPanel;

    procedure actOpenFileExecute(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure TXT1Click(Sender: TObject);
    procedure RTF1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OutFiler2ProgressProc(aState: Byte; aValue: Longint;
      const aMsg: String);
    procedure HTML1Click(Sender: TObject);
    procedure NsrcButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConvClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ProgressIndicatorProgressProc(aState: Byte; aValue: Integer; const aMsg: String);
    procedure ToolButton5Click(Sender: TObject);
    procedure NewDocClick(Sender: TObject);
    procedure BorbdersClick(Sender: TObject);
    procedure ActionSaveBinaryExecute(Sender: TObject);
    procedure menuPreferenceClick(Sender: TObject);
    procedure SaveAsPlainTextExecute(Sender: TObject);
    procedure SpellCheckExecute(Sender: TObject);
    procedure CollectTOCExecute(Sender: TObject);
    procedure Doc2RtfExecute(Sender: TObject);
    procedure actShowSpecialExecute(Sender: TObject);
    procedure comboZoomChange(Sender: TObject);
    procedure actCreateBlockStructExecute(Sender: TObject);
    procedure actSaveAsExecute(Sender: TObject);
    procedure act1LevelExecute(Sender: TObject);
    procedure actBlendBlockExecute(Sender: TObject);
    procedure actRepairSectionsExecute(Sender: TObject);
    procedure actLoadStyleTableExecute(Sender: TObject);
    procedure actConvert2AnnoExecute(Sender: TObject);
    procedure actSaveStyleTableExecute(Sender: TObject);
    procedure actSourceExecute(Sender: TObject);
    procedure actTestExecute(Sender: TObject);
  private
    { Private declarations }
    f_InFileName: String;
    f_OutFileName: String;
    f_OutDir    : String;
    f_InDir     : String;
    f_LastExt   : Integer;
    f_InType    : TddInOutType;
    f_OutType   : TddInOutType;
    f_MaxValue  : Longint;
    f_WriteLog  : Boolean;

    f_InFiler   : Tl3CustomFiler;
    f_OutFiler  : Tl3CustomFiler;
    f_Reader    : Tk2CustomFileReader;
    f_Writer    : Tk2CustomFileGenerator;
    procedure AppException(Sender: TObject; E: Exception);
    function ElapsedTimeToString(aStart, aStop: TDateTime): string;
    procedure InnerOpenFile;
    procedure MakeOutFileName;
    function MakeWriter(aOutType: TddInOutType): Tk2TagGenerator;
    procedure WriteToFile(aOutType: TddInOutType);
   function OpenFile: Boolean;
   function SaveFile: Boolean;
   procedure MsgDlg(const aMessage : String);
    procedure ReadSettings;
    procedure RTFKeywordFound(Sender: TObject; Keyword: Long; KeywordName: String;
        Param: Long; HasParam: Boolean);
    procedure WriteSettings;
    procedure WriteToAnnotation;
  protected
    procedure wmDropFiles(var Message: TMessage); message WM_DROPFILES;
  public
    procedure errorHandler(const aDescription: String; aCategory: Integer);
    { Public declarations }
    property OutDir: String
      read f_OutDir write f_OutDir;
    property InDir: String
      read f_InDir write f_InDir;
    property LastExt : Integer
      read f_LastExt write f_LastExt;
    property InType: TddInOutType
      read f_InType write f_InType;
    property OutType: TddInOutType
      read f_OutType write f_OutType;
  end;

  TPagesetup = class(Tl3Base, IafwPageSetup)
    function pm_GetExtent: Tl3_Point;
    function pm_GetMargins: Tl3_Rect;
    function pm_GetOrientation: Tl3PageOrientation;
  end;

var
  TesterForm: TTesterForm;

implementation

Uses
  Registry, DateUtils,
  l3Memory, l3WindowsStorageFiler, l3Prg, l3Const,
  l3Stream,
  k2Tags, k2DocumentBuffer,
  evEVDReader, evTextFormatter, evSegLst, evdStyles,
  evInternalInterfaces, evStyleTableTools, evStyleInterfaceEx,
  evDocumentPreview,

  ddUtils, ddRTFwriter, ddHTMLWriter, ddNSRC_r, ddNSRC_w, ddExtAnnoPipe, ddXMLAnnoWriter,
  {evTableConverter,} ddDocReader, ddRTFReader, ddSectionRepair,// ddSectionmaker,
  ddParaEliminator, ddFixFilter,
  ddHTML_r, evContentTable, evAutoBlock, evNestedDocumentEliminator,

  evdWriter, evIntf, evTypes, evNSRWrt, evdPlainTextWriter, evHiddenFilter,
  rxDialogs, dd_lcTableEliminator,
  k2StackGenerator, evFacadeSelection,
  evFacadTextSource, ddSpaceTrimmer, TextPara_Const,
  evExtFormat, nevPersistentDocumentContainer, evSimpleTextPainter,
  ddSectionWithSub2Para,  nevTools, evOp, ddPDFReader,
  JclStringConversions, evEmptyTableEliminator,
  ddPictureFilter, l3FileUtils,
  ShellAPI, l3ShellUtils, evNSRCPlusWriter, ddFormula2PictureFilter, npbAttributesFilter,
  evdHyperlinkEliminator, evdCommentFilter, npbHyperlinkFilter,
  dd_lcHiddenTextExtractor, EvdBufferedFilter, Bitmappara_const, StrUtils//, ddSpaceTrimmer
  {ddAddPictureHandle, ddTextAnonymizer, ddHyperlinkCleaner};

{$R *.DFM}

procedure TTesterForm.WriteToFile(aOutType: TddInOutType);
var
 F: TevTextFormatter;
 T1, T2: TDateTime;
 l_S: String;
 l_Reader: TddSectionRepairFilter;
 l_G : Tk2TagGenerator;
 l_PageSetup : TPageSetup;
 l_SecRep: TddSectionRepairFilter;
begin
 if OpenFile  then
 try
  StatusBar1.Panels[1].Enabled:= True;
  OutType:= aOutType;
  if BrowseDirectory(f_OutDir, 'Куда будем сохранять?', 0) then
  begin
   f_OutFiler:= TevDosFiler.Create;
   try
    l_G := MakeWriter(aOutType);
    if l_G = nil then                            
     exit;
    MakeOutFileName;
    Tk2CustomFileGenerator(l_G).Filer:= f_OutFiler;
    TevDOSFiler(f_OutFiler).FileName:= f_OutFileName;
    try
     l_PageSetup := TPageSetup.Create;
     try
      {$IFNDEF AAC}
      //TddNumberUpcaseFilter.SetTo(l_G);
      //TddSectionMaker.SetTo(l_G);
      //TddSectionRepairFilter.SetTo(l_G);
      //TddSectionRepairFilter(l_G).MinFontSize := 6;
      {$ENDIF}
       if OutType in [otNSRC, otPlainText] then
       begin
        TevSimpleTextPainter.SetTo(l_G);
        if OutType = otPlainText then
         TevTextFormatter(l_G).FormatOrdinalParas := false;
        //else
         //TddAddPictureHandleFilter.SetTo(l_G);
       end
       else
       if OutType in [otRTF] then
        TevNestedDocumentEliminator.SetTo(l_G);
      //TddFormula2PictureFilter.SetTo(l_G); // ddFormula2PictureFilter
      //TnpbAttributesFilterEx.SetTo(l_G);  // npbAttributesFilter
      //TnpbHyperlinkFilter.SetTo(l_G);  // evdHyperlinkEliminator
      //TevdCommentFilter.SetTo(l_G); // evdCommentFilter
      {$IFNDEF AAC}
      //TddSectionWithSub2ParaFilter.SetTo(l_G);
      {$ENDIF}
      //TddParaEliminator.SetTo(l_G);
      //TevHiddenFilter.SetTo([Abs(ev_saANSIDOS), Abs(ev_saContents)], l_G);
      //TevUserCommentFilter.SetTo(l_G);
      //TevPageParamsFilter.SetTo(l_PageSetup, l_G);
      {$IFDEF AAC}
       l_F:= Tdd_lcTextFormatter.SetTo(l_G);
       TlcTableEliminator2.SetTo(l_G);
       l_F.OnHeaderFound:= TlcTableEliminator2(l_G).HeaderFound;
       TddSpaceTrimmerFilter.SetTo(l_G);
       Tdd_lcNameGenerator.SetTo(l_G);
       Tdd_lcVASCodeCorrector.SetTo(l_G);
       Tdd_lcYearCodeCorrector.setTo(l_G);
       Tdd_lcVASSourceCorrector.SetTo(l_G);
       Tdd_lcTypeConverter2.SetTo(l_G, 1, errorHandler, ConcatDirName(ExtractFilePath(Application.ExeName), 'source.txt'));
       Tdd_lcSourceConverterFilter.SetTo(l_G, ConcatDirName(ExtractFilePath(Application.ExeName), 'source.csv'));
       Tdd_lcTypeConverter.setTo(l_G, 1, errorHandler, ConcatDirName(ExtractFilePath(Application.ExeName), 'lctypes.csv'));
       Tdd_lcMisspellFilter.SetTo(l_G, 1, errorHandler, ConcatDirName(ExtractFilePath(Application.ExeName), 'lcMissspell.csv'));
      {$ENDIF}
       //TddPictureFilter.SetTo(l_G, k2_idtextPara);
 //      TevEmptyTableEliminator.SetTo(l_G);
       //TevdChildBufferedFilter.SetTo(l_G, k2_idBitmappara);
       //TlcTableEliminator2.SetTo(l_G);
       //Tdd_lcHiddenTextExtractor.SetTo(l_G);
       //TddTextAnonymizer.setTo(l_G);
       //TddHyperlinkCleaner.SetTo(l_G);
       f_Reader.Generator:= l_G;
        T1:= Time;
        f_Reader.Execute;
        //l_SecRep.SaveListTo(f_OutDir + '\nums.txt');
        T2 := Time;
        l_S:= Format('Файл успешно преобразован за %s', [ElapsedTimeToString(T1, T2)]);
      finally
       l3Free(l_PageSetup);
      end;
    finally
     l3Free(l_G);
    end;
   finally
    l3Free(f_OutFiler);
   end;
  end;
 finally
  l3Free(f_InFiler);
  l3Free(f_Reader);
  StatusBar1.Panels[1].Enabled:= False;
 end;
 MsgDlg(l_S);
end;

procedure TTesterForm.ExitClick(Sender: TObject);
begin
 Close;
end;

procedure TTesterForm.NewDocClick(Sender: TObject);
begin
  TextSource.New;
end;

procedure TTesterForm.actOpenFileExecute(Sender: TObject);
{ Выливка на экран }
var
 l_Start, l_Stop: TDateTime;
 l_S: String;
 l_Pack: InevOp;
begin
 if OpenFile then
 begin
  StatusBar1.Panels[1].Enabled:= True;
  try
   f_Reader.Filer := f_InFiler;
   Screen.Cursor:= crHourGlass;
   l3System.Msg2Log('Чтение файла %s', [f_InFileName]);
   l_Start:= Time;
   TextSource.Load(f_Reader);



   l_Stop:= Time;
   l_S := 'Файл прочитан за ' + ElapsedTimeToString(l_Start, l_Stop);
   MsgDlg(l_S);
   l3System.Msg2Log(l_S);
   TextSource.Invalidate;
  finally
   actAllLevels.Execute;
   l3Free(f_Reader);
   Screen.Cursor:= crDefault;
   l3Free(f_InFiler);
  end;{try..finally}
  StatusBar1.Panels[1].Enabled:= False;
 end; // if OpenFile
end;


procedure TTesterForm.TXT1Click(Sender: TObject);
begin
 WriteToFile(otEVR);
end;

procedure TTesterForm.ActionSaveBinaryExecute(Sender: TObject);
begin
 WriteToFile(otEVD);
end;



procedure TTesterForm.RTF1Click(Sender: TObject);
begin
 WriteToFile(otRTF);
end;

procedure TTesterForm.HTML1Click(Sender: TObject);
begin
 WriteToFile(otHTML);
end;

procedure TTesterForm.NsrcButtonClick(Sender: TObject);
begin
 WriteToFile(otNSRC);
end;


procedure TTesterForm.FormCreate(Sender: TObject);
begin
 //ActionManager1.FileName := ChangeFileExt(Application.ExeName, '.layout');
 f_WriteLog:= False;
 Caption:= 'Тяни-Толкай';
 Application.OnException := AppException;
  StatusBar1.Panels[2].Text:= GetProgramVersion;
  ReadSettings;
  dlgOpenFile.InitialDir:= InDir;
  dlgOpenFile.FilterIndex:= LastExt;
  TextSource.Indicator.OnProgressProc := ProgressIndicatorProgressProc;
  TextSource.New;
 if ParamCount > 0 then
 begin
  f_InFileName:= ParamStr(1);
  InnerOpenFile;
  StatusBar1.Panels[1].Enabled:= True;
  try
   f_Reader.Filer := f_InFiler;
   Screen.Cursor:= crHourGlass;
   TextSource.Load(f_Reader);
   TextSource.Invalidate;
  finally
   actAllLevels.Execute;
   l3Free(f_Reader);
   Screen.Cursor:= crDefault;
   l3Free(f_InFiler);
  end;{try..finally}
  StatusBar1.Panels[1].Enabled:= False;
 end;
 evSubPanel1.SubDescriptors:= evSubDescriptors1;
 evSubPanel1.Width:= 50;
 evRuler1.Units:= ev_unCm;
 DragAcceptFiles(Self.Handle, True);
end;

procedure TTesterForm.OutFiler2ProgressProc(aState: Byte; aValue: Longint;
  const aMsg: String);
begin
 with StatusBar1.Panels[1].GaugeAttrs do
  case aState of
   0: begin
       Position:= 0;
       f_MaxValue:= aValue;
      end;
   1: Position:= MulDiv(aValue, 100, f_MaxValue);
   2: Position:= f_MaxValue;
  end;
  Application.ProcessMessages;
end;

procedure TTesterForm.MakeOutFileName;
var
  S: String;
begin
  S:= ExtractFileName(f_InFileName);
  S:= OutDir + '\' + S;
  case outType of
    otRTF : f_OutFileName:= ChangeFileExt(S, '.RTF');
    otEVD : f_OutFileName:= ChangeFileExt(S, '.EVD');
    otEVR : f_OutFileName:= ChangeFileExt(S, '.EVD');
    otHTML: f_OutFileName:= ChangeFileExt(S, '.HTML');
    otNSRC: f_OutFileName:= ChangeFileExt(S, '.NSR');
    otPlainText: f_OutFileName:= ChangeFileExt(S, '.txt');
  else
    f_OutFileName:= ''
  end;
end;

procedure TTesterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 { Здесь попытаюсь запихнуть все текущие установки в Registry }
  WriteSettings;
end;


procedure TTesterForm.ConvClick(Sender: TObject);
begin
  //ConvertText2Table(Editor);
end;

procedure TTesterForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose:= True;
end;

procedure TTesterForm.ProgressIndicatorProgressProc(aState: Byte; aValue: Integer; const aMsg: String);
begin
 try
  case aState of
    0: begin
        StatusBar1.Panels[1].GaugeAttrs.Position:= 0;
        StatusBar1.Panels[1].Enabled:= True;
        f_MaxValue:= aValue;
        StatusBar1.Panels[2].Text:= aMsg;
       end;

    1:
     if (f_MAxValue <> 0) and (aValue <= f_MaxValue) then
      StatusBar1.Panels[1].GaugeAttrs.Position:= MulDiv(aValue, 100, f_MaxValue)
     else
      StatusBar1.Panels[1].GaugeAttrs.Position:= 100;
    2: begin
        StatusBar1.Panels[1].GaugeAttrs.Position:= 100;
        StatusBar1.Panels[1].Enabled:= False;
        StatusBar1.Panels[2].Text:= '';
       end;
  end;
  Application.ProcessMessages;
 except
  l3System.Msg2Log(Format('Ошибка в функции прогресса - Состояние %d (%d из %d)',
                          [aState, aValue, f_MaxValue]));
 end;
end;

function TTesterForm.SaveFile: Boolean;
begin
 if dlgSaveFile.Execute then
 begin
  f_InFileName:= dlgSaveFile.FileName;
  case dlgSaveFile.FilterIndex of
   1: OutType:= otNSRC;
   2: OutType:= otEVR;
   3: OutType:= otRTF;
   4: OutType:= otHTML;
  else
   OutType:= otUnknown
  end; // case dlgSaveFile.FilterIndex
  OutDir:= ExtractFileDir(f_InFileName);
 end; // dlgSaveFile.Execute
 Result:= OutType <> otUnknown;
end;

function TTesterForm.OpenFile: Boolean;
var
  S: String;
begin
  if dlgOpenFile.Execute then
  //if agOpenDialog1.Execute then
  begin
    Result:= True;
    f_InFileName:= dlgOpenFile.FileName;
    InnerOpenFile;
  end
  else
  begin
    f_InFileName:= '';
    Result:= False;
  end;
end;

procedure TTesterForm.ToolButton5Click(Sender: TObject);
begin
  l3System.Send(Editor, wm_paste, 0, 0);
end;


procedure TTesterForm.BorbdersClick(Sender: TObject);
//var
//  BorderDlg: TBorderDlg;
begin
(*
  BorderDlg:= TBorderDlg.Create(Application);
  try
    BorderDlg.Execute(Editor.Range);
  finally
    BorderDlg.Free;
  end;
*)  
end;

procedure TTesterForm.menuPreferenceClick(Sender: TObject);
begin
  {}
end;

procedure TTesterForm.SaveAsPlainTextExecute(Sender: TObject);
begin
  WriteToFile(otPlainText);
end;

procedure TTesterForm.SpellCheckExecute(Sender: TObject);
//var
//  SpellChecker: TSpellChecker;
begin
(*
 SpellChecker := TSpellChecker.Create(Self);
 try
  try
   Editor.Find(SpellChecker, SpellChecker.Replacer,[ev_soReplaceAll, ev_soConfirm])
  except
     {on EevSearchFailed do}
  end;{try..except}
  MsgDlg('Проверка орфографии завершена');
 finally
  l3Free(SpellChecker);
 end; // try..finally
*)
end;

procedure TTesterForm.CollectTOCExecute(Sender: TObject);
begin
  { Накапливаем оглавление }
  CollectContentTable(Editor, 0, False, not Editor.HasSelection);
end;

procedure TTesterForm.Doc2RtfExecute(Sender: TObject);
begin
  f_WriteLog:= True;
  WriteToFile(otRTF);
  f_WriteLog:= False;
end;

procedure TTesterForm.MsgDlg(const aMessage : String);
begin
 ShowMessage(aMessage);
end;

procedure TTesterForm.actShowSpecialExecute(Sender: TObject);
begin
 Editor.Canvas.DrawSpecial:= actShowSpecial.Checked;
 evSetShowDocumentParts(Editor, nil, actShowSpecial.Checked);
end;

procedure TTesterForm.comboZoomChange(Sender: TObject);
begin
 (*
 with Editor.Canvas do
  case comboZoom.ItemIndex of                    evFacade
   0: Zoom:= 125;
   1: Zoom:= 100;
   2: Zoom:= 75;
   3: Zoom:= 50;
   4: Zoom:= 25;
   5: ;
  end;
  *)
end;

procedure TTesterForm.actCreateBlockStructExecute(Sender: TObject);
var
 l_Start,
 l_Finish: TDateTime;
 l_Sec, l_Suffix: Longint;
 l_S : String;
begin
 CreateBlockStructure(Editor);
 l_Finish:= Time;
end;


procedure TTesterForm.actSaveAsExecute(Sender: TObject);
var
 F: TevTextFormatter;
 t1: TDateTime;
 l_s: String;
begin
 if SaveFile then
 begin
  f_OutFiler:= TevDosFiler.Create;
  try
   case OutType of
    otRTF:
     begin
      f_Writer:= TevRTFObjectGenerator.Create;
      {$IFDEF OnStep}
      (f_Writer as TevRTFObjectGenerator).OneStep := True;
      {$ELSE}
      (f_Writer as TevRTFObjectGenerator).OneStep := False;
      {$ENDIF}
     end;
    otHTML: f_Writer:= TddHTMLGenerator.Create;
    otNSRC:
     begin
       F:= TevTextFormatter.Create(nil);
       f_Writer:= TddNSRCGenerator.Create(nil);
       TddNSRCGenerator(f_Writer).ExportDirectory := OutDir;
     end;
    otEVD,
    otEVR :
     begin
       f_Writer:= TevdNativeWriter.Create(nil);
       TevdNativeWriter(f_Writer).Binary:= OutType = otEVD;
     end;
    otPlainText:
      begin
        f_Writer:= TevdCustomNativeWriter.Create(nil);
        F:= TevTextFormatter.Create(nil);
      end;
   else
    System.exit;
  end;

  try
    MakeOutFileName;

    f_Writer.Filer:= f_OutFiler;
    TevDOSFiler(f_OutFiler).FileName:= f_OutFileName;
    T1:= Time;
     if OutType in [otNSRC, otPlainText] then
     begin
       F.Generator:= f_Writer;
       if OutType = otPlainText then
         F.FormatOrdinalParas := false;
      Editor.TextSource.Save(F, True);
     end
     else
      Editor.TextSource.Save(f_Writer, True);
     l_S:= Format('Файл успешно преобразован за %d секунд', [SecondsBetween(Time, T1)]);
   finally
    if OutType in [otNSRC, otPlainText] then
      l3Free(F);
    l3Free(f_Writer);
   end;
  finally
   l3Free(f_OutFiler);
  end;
 end;
end;

procedure TTesterForm.act1LevelExecute(Sender: TObject);
begin
 Editor.TextSource.ShowLevel:= (Sender as TComponent).Tag;
end;


procedure TTesterForm.actBlendBlockExecute(Sender: TObject);
(*
var
 l_Start,
 l_Finish: TDateTime;
 l_Sec: Longint;
 l_S : String;
 l_Cursor: TevCursor;
 l_Block: TevBlock;
*)
begin
(*
 if Editor.InPara(k2_idBlock, l_Cursor) then
 begin
  l_Cursor.Target.MakeInterface(ev_iidBlock, l_Block);
  try
  Editor.Selection.Assign(l_Block);
  finally
   l3Free(l_Block);
  end;
//  CreateBlockStructure(Editor, 0, 0);
 end;
 l3Free(l_Cursor);
 l_Finish:= Time;
*)
end;

procedure TTesterForm.actRepairSectionsExecute(Sender: TObject);
var
 l_Start, l_Stop: TDateTime;
 l_S, l_TimeS: String;
 l_Time: Int64;
 l_Reader: TddSectionRepairFilter;
 l_Gen : Tk2TagGenerator;
begin
(*
 if OpenFile then
 begin
  StatusBar1.Panels[1].Enabled:= True;
  Screen.Cursor:= crHourGlass;
  try
   f_Reader.Filer := f_InFiler;
   l_Reader:= TddSectionRepairFilter.Create;
   try
    f_reader.Generator := l_Reader;
    l_Start:= Time;

    l_Gen := TextSource.GetGenerator;
    try
     l_Reader.Generator := l_Gen;
    finally
     l3Free(l_Gen);
    end;//try..finally
    f_Reader.Execute;

    l_Stop:= Time;
    l_Time:= SecondsBetween(l_Stop, l_Start);
    case l_Time mod 10 of
     0, 5..9: l_S:= '';
     1: l_S:= 'у';
     2..4: l_S:= 'ы';
    end;

    if l_Time > 0 then
    begin
     case l_Time of
      1: l_TimeS:= 'одну';
      2: l_TimeS:= 'две';
      3: l_TimeS:= 'три';
      4: l_TimeS:= 'четыре';
      5: l_TimeS:= 'пять';
      6: l_TimeS:= 'шесть';
      7: l_TimeS:= 'семь';
      8: l_TimeS:= 'восемь';
      9: l_TimeS:= 'девять';
     else
      l_TimeS:= IntToStr(l_Time);
     end;
     l_S:= Format('Файл прочитан за %s секунд%s', [l_TimeS, l_S])
    end
    else
     l_S:= Format('Файл прочитан за %d миллисекунд', [MilliSecondsBetween(l_Stop, l_Start)]);
    MsgDlg(l_S);
    l3System.Msg2Log(l_S);
    TextSource.Invalidate;
   finally
    l3Free(l_Reader);
   end;
  finally
   actAllLevels.Execute;
   l3Free(f_Reader);
   Screen.Cursor:= crDefault;
   l3Free(f_InFiler);
  end;{try..finally}
  StatusBar1.Panels[1].Enabled:= False;
 end; // if OpenFile
*)
end;

procedure TTesterForm.AppException(Sender: TObject; E: Exception);
begin
 Application.ShowException(E);
end;

procedure TTesterForm.actLoadStyleTableExecute(Sender: TObject);
var
 SI : TevStyleInterfaceEx;
 S  : TStream;
 Indx: Integer;
begin
 Indx:= dlgOpenFile.FilterIndex;
 dlgOpenFile.FilterIndex:= 6;
 if dlgOpenFile.Execute then
 begin
  SI := TevStyleInterfaceEx.Make;
  try
   S := Tl3FileStream.Create(dlgOpenFile.FileName, l3_fmRead);
   try
    SI.Load(S);
   finally
    l3Free(S);
   end;{try..finally}
  finally
   l3Free(SI);
  end;{try..finally}
 end; // dlgOpenFile.Execute
 dlgOpenFile.FilterIndex:= Indx;
end;

function TTesterForm.ElapsedTimeToString(aStart, aStop: TDateTime): string;
var
 l_Time : Int64;
 l_S: String;
begin
  l_Time:= abs(SecondsBetween(aStop, aStart));
  case l_Time mod 10 of
   0, 5..9: l_S:= '';
   1: l_S:= 'у';
   2..4: l_S:= 'ы';
  end;

  if l_Time > 0 then
  begin
   case l_Time of
    1: Result:= 'одну';
    2: Result:= 'две';
    3: Result:= 'три';
    4: Result:= 'четыре';
    5: Result:= 'пять';
    6: Result:= 'шесть';
    7: Result:= 'семь';
    8: Result:= 'восемь';
    9: Result:= 'девять';
   else
    Result := IntToStr(l_Time);
   end;
   Result := Format('%s секунд%s', [Result, l_S])
  end
  else
   Result := Format('%d миллисекунд', [MilliSecondsBetween(aStop, aStart)]);
end;

function TTesterForm.MakeWriter(aOutType: TddInOutType): Tk2TagGenerator;
begin

  case aOutType of
   otRTF:
    begin
     Result := TevRTFObjectGenerator.Create;
     (Result as TevRTFObjectGenerator).UseExternalLinks:= True;
     (Result as TevRTFObjectGenerator).Host:= 'localhost://';
     {$IFDEF OneStep}
     (Result as TevRTFObjectGenerator).OneStep:= True;
     {$ELSE}
     (Result as TevRTFObjectGenerator).OneStep:= False;
     {$ENDIF}
     {
     (Result as TevRTFObjectGenerator).DontTranslateChars:= True;
     (Result as TevRTFObjectGenerator).WithoutSegments:= True;
     }
    end; // otRTF
   otHTML:
    begin
     Result := TddHTMLGenerator.Create;
     {$IFDEF OneStep}
     //(Result as TddHTMLGenerator).OneStep:= True;
     {$ENDIF}
     (Result as TddHTMLGenerator).UseExternalLinks:= True;
    end; // otHTML
   otNSRC:
    begin
     Result := TddNSRCGenerator.Create(nil);
     TddNSRCGenerator(Result).ExportDirectory := OutDir;
     //Result := TevNSRCPlusWriter.Create;
    end;
   otEVD,
   otEVR :
    begin
     Result := TevdNativeWriter.Create(nil);
     //TevdNativeWriter(Result).Binary:= OutType = otEVD;
     TevdNativeWriter(Result).OutEndComment:= True;
    end;
   otPlainText:
    begin
     Result:= TevdPlainTextWriter.Create(nil);
    end;
   else
    Result := nil;
  end; // case;
end;

procedure TTesterForm.WriteToAnnotation;
var
 F: TevTextFormatter;
 T1, T2: TDateTime;
 l_S: String;
 l_Reader: TddSectionRepairFilter;
 l_G : Tk2TagGenerator;
begin
 if OpenFile then
 try
  StatusBar1.Panels[1].Enabled:= True;
  f_OutFiler:= TevDosFiler.Create;
  try
   OutType := otEVR;
   l_G := makeWriter(otEVR);
   MakeOutFileName;
   Tk2CustomFileGenerator(l_G).Filer:= f_OutFiler;
   TevDOSFiler(f_OutFiler).FileName:= f_OutFileName;
   TddExtAnnotationFilter.SetTo(l_G);
   try
      T1:= Time;
      f_Reader.Generator := l_G;
      f_Reader.Execute;
      T2 := Time;
      l_S:= Format('Файл успешно преобразован за %s', [ElapsedTimeToString(T1, T2)]);
   finally
    l3Free(l_G);
   end;
  finally
   l3Free(f_OutFiler);
  end;
 finally
  l3Free(f_InFiler);
  l3Free(f_Reader);
  StatusBar1.Panels[1].Enabled:= False;
 end;
 MsgDlg(l_S);
end;

procedure TTesterForm.actConvert2AnnoExecute(Sender: TObject);
begin
 writeToAnnotation;
end;

function TPagesetup.pm_GetExtent: Tl3_Point;
begin
 Result.X := 11906; // PageWidth
 Result.Y := 16838; // PageHeight
end;

function TPagesetup.pm_GetMargins: Tl3_Rect;
begin
 Result.Left := 1134; // Left
 Result.Right:= 850; // Right
 Result.Top:= 1700; // Top
 Result.Bottom:= 1700; // Bottom
end;

function TPagesetup.pm_GetOrientation: Tl3PageOrientation;
begin
 Result := l3_poPortrait; // Orientation
end;

procedure TTesterForm.actSaveStyleTableExecute(Sender: TObject);
var
 SI : TevStyleInterfaceEx;
 S  : TStream;
 Indx: Integer;
begin
 Indx:= dlgSaveFile.FilterIndex;
 dlgSaveFile.FilterIndex:= 6; //?
 if dlgSaveFile.Execute then
 begin
  SI := TevStyleInterfaceEx.Make;
  try
   S := Tl3FileStream.Create(dlgSaveFile.FileName, l3_fmWrite);
   try
    SI.Save(S, False);
   finally
    l3Free(S);
   end;{try..finally}
  finally
   l3Free(SI);
  end;{try..finally}
 end; // dlgOpenFile.Execute
 dlgSaveFile.FilterIndex:= Indx;
end;

procedure TTesterForm.actSourceExecute(Sender: TObject);
begin
 if FileExists(f_InFileName) then
  FileExecute('notepad.exe', f_InfileName, '', esNormal);
end;

procedure TTesterForm.actTestExecute(Sender: TObject);
var
 l_Filt: TddSpaceTrimmerFilter;
begin
 l_Filt := TddSpaceTrimmerFilter.Create;
 try
  EvRangeInsertFrom(Editor, l_Filt);
 finally
  FreeAndNil(l_Filt);
 end;
end;

procedure TTesterForm.wmDropFiles(var Message: TMessage);
var
 l_numFiles : longInt;
 l_buffer : array[0..MAX_PATH] of char;
begin
 l_numFiles := DragQueryFile(TWMDROPFILES(Message).Drop, $FFFFFFFF, nil, 0) ;
 if l_numFiles > 1 then
  ShowMessage('Можно перетаскивать только один файл за раз')
 else
 begin
  DragQueryFile(TWMDROPFILES(Message).Drop, 0, @l_buffer, sizeof(l_buffer)) ;
  f_InFileName:= l_buffer;
  InnerOpenFile;
  StatusBar1.Panels[1].Enabled:= True;
  try
   f_Reader.Filer := f_InFiler;
   Screen.Cursor:= crHourGlass;
   TextSource.Load(f_Reader);
   TextSource.Invalidate;
  finally
   actAllLevels.Execute;
   l3Free(f_Reader);
   Screen.Cursor:= crDefault;
   l3Free(f_InFiler);
  end;{try..finally}
  StatusBar1.Panels[1].Enabled:= False;
 end;
end;

procedure TTesterForm.errorHandler(const aDescription: String; aCategory: Integer);
begin
 // TODO -cMM: TTesterForm.errorHandler необходимо написать реализацию
end;

procedure TTesterForm.InnerOpenFile;
var
 S: String;
begin
 InDir:= ExtractFileDir(f_InFileName);
 LastExt:= dlgOpenFile.FilterIndex;
 S:= UpperCase(ExtractFileExt(f_InFileName));
 if S = '.RTF' then
   InType:= otRTF
 else
 if S = '.NSR' then
   InType:= otNSRC
 else
 if ((S = '.HTM') or (S = '.HTML')) then
   InType:= otHTML
 else
 if S = '.EVD' then
   InType:= otEVD
 else
 if S = '.EVR' then
   InType:= otEVR                         
 else
 if (S = '.DOC') or (S = '.DOCX') then
   InType:= otDoc
 else
 if S = '.PDF' then
   InType:= otPDF
 else
   InType:= otUnknown;

 case InType of

   otRTF ,
   otDOC :
     begin
      (*
       f_Reader:= TddDOCReader.Create(nil);//R := TRTF2Everest.Create(nil);
       TddDOCReader(f_Reader).EnablePictures:= True;
       TddDOCReader(f_Reader).OnKeywordFound:= RTFKeywordFound;
       {$IFDEF Lite}
       TddDOCReader(f_Reader).LiteVersion:= True;
       {$ELSE}
       TddDOCReader(f_Reader).LiteVersion:= False;
       {$ENDIF}
      *) 
     end;

   otNSRC:
     begin
       f_Reader:= TCustomNSRCReader.Create(nil);
       TCustomNSRCReader(f_Reader).StrictFormat:= False;
     end;
   otEVD,
   otEVR : f_Reader:= TevEvdStorageReader.Create(nil);
   otHTML:
    begin
     f_Reader:= {Tdd_lcHTMLCardReader.Create(nil); //}TddHTMLReader.Create(nil);
     TddHTMLReader(f_reader).Lite:= False;
     //TddHTMLReader(f_reader).CodePage:= cp_UTF8;
    end;
   otPDF : f_Reader:= TddPDFReader.Create(nil);
 else
   System.exit;
 end; // case
 f_InFiler:= Tl3DOSFiler.Create;
 f_InFiler.NeedProcessMessages:= True;
 f_Reader.Filer:= f_InFiler;
 Tl3WindowsStorageFiler(f_InFiler).FileName:= f_InFileName;
 Tl3ProgressIndicator(f_InFiler.Indicator).NeedProgressProc:= True;
 Tl3ProgressIndicator(f_InFiler.Indicator).OnProgressProc:= ProgressIndicatorProgressProc;
 Caption:= Format('Тяни-толкай - %s', [f_InFileName]);
 Application.ProcessMessages;
end;

procedure TTesterForm.ReadSettings;
begin
 with TRegistry.Create do
 try
   RootKey:= HKEY_CURRENT_USER;
   OpenKey('SOFTWARE\Tigers of Softland\Pull-Pusher', True);
   try
    f_OutDir:= ReadString('OutDir');
   except
    f_OutDir:= 'c:\@out';
   end;
   try
    f_InDir:= ReadString('InDir');
   except
    InDir:= 'c:\Nsrc';
   end;
   try
    if ReadBool('ShowSpecial') then
     actShowSpecialExecute(Self);
   except
   end;
   try
    LastExt:= ReadInteger('LastExt');
   except
    LastExt:= 1;
   end; //
 finally
   Free;
 end;
end;

procedure TTesterForm.RTFKeywordFound(Sender: TObject; Keyword: Long;
    KeywordName: String; Param: Long; HasParam: Boolean);
var
 l_S: String;
begin
 if Keyword > 0 then
 begin
  l_S:= IfThen(KeywordName[1] in ['{','}'], '', '\');

  if HasParam then
   l3System.Str2Log(Format('\%s%d', [KeywordName, Param]))
  else
   l3System.Str2Log(Format('%s%s', [l_S, KeywordName]));
 end
end;

procedure TTesterForm.WriteSettings;
begin
 with TRegistry.Create do
 try
   RootKey:= HKEY_CURRENT_USER;
   OpenKey('SOFTWARE\Tigers of Softland\Pull-Pusher', True);
   WriteString('OutDir', OutDir);
   WriteString('InDir', InDir);
   WriteInteger('LastExt', LastExt);
  WriteBool('ShowSpecial', actShowSpecial.Checked);
 finally
  Free;
 end;
end;

end.

