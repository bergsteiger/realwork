unit ViewForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, l3InterfacedComponent, l3ProgressComponent, evCustomTextSource,
  evEditorWindowTextSource, evTextSource, OvcBase, afwControlPrim,
  afwBaseControl, afwControl, nevControl, evCustomEditorWindowPrim,
  evCustomEditorWindow, evCustomEditorWindowModelPart,
  evMultiSelectEditorWindow, evCustomEditorModelPart, evCustomEditor,
  evEditorWithOperations, evTunedEditor, evEditor, ExtCtrls, k2Interfaces,
  StdCtrls, afwTextControlPrim, afwTextControl, vtPanel, evToolPanel,
  evLinkedToolPanel, evSubPn;

type
  TCompareViewForm = class(TForm)
    textOut: TevTextSource;
    textEtalon: TevTextSource;
    panelEtalon: TPanel;
    Panel2: TPanel;
    edEtalon: TevEditor;
    PanelResult: TPanel;
    Panel1: TPanel;
    edOut: TevEditor;
    btnSaveAsEtalon: TButton;
    btnSourceEtalon: TButton;
    procedure btnSaveAsEtalonClick(Sender: TObject);
    procedure btnSourceEtalonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    f_EtalonFileName: String;
    f_IsSource: Boolean;
    f_ResultFileName: String;
    f_SourceFileName: string;
    procedure AnalyzeText;
    procedure FindMismatch(const aS1, aS2: string; out theStart, theFinish:
        Integer);
    function GetNextPara(aDoc: Tl3Tag; var aChildIndex: Integer): Tl3Tag;
    procedure LoadEtalonText;
    procedure LoadFile(const aFileName: String; aTextSource: TevTextSource);
    procedure LoadSourceText;
    procedure MakeSegment(aPara: Tl3Tag; aStart, aFinish: Integer);
    procedure MarkDifference(aEtalonPara, aResultPara: Tl3Tag);
    { Private declarations }
  public
    function Execute(const aEtalonFileName, aSourceFileName, aResultFileName:
        String): Boolean;
    { Public declarations }
  end;

var
  Form2: TCompareViewForm;

implementation

uses
 k2tagGen, k2Reader, evdStyles,
 evEvdReader, TextPara_Const, k2tags, TextSegment_Const, evdTypes, l3FileUtils,
 ddDocReader;

{$R *.dfm}

procedure TCompareViewForm.AnalyzeText;
var
 l_EtalonParaIndex,
 l_ResultParaIndex: Integer;
 l_EtalonPara,
 l_ResultPara: Tl3Tag;
begin
 textEtalon.ReadOnly:= False;
 textOut.ReadOnly:= False;
 l_EtalonParaIndex:= 0;
 l_ResultParaIndex:= 0;
 repeat
  l_EtalonPara:= GetNextPara(textEtalon.Document, l_EtalonParaIndex);
  l_ResultPara:= GetNextPara(textOut.Document, l_ResultParaIndex);
  if (l_EtalonPara <> nil) and (l_ResultPara <> nil) then
  begin
   if not AnsiSameText(l_EtalonPara.StrA[k2_tiText], l_ResultPara.StrA[k2_tiText]) or
      (l_EtalonPara.IntA[k2_tiStyle] <> l_ResultPara.IntA[k2_tiStyle]) then
    MarkDifference(l_EtalonPara, l_ResultPara);
  end; // (l_EtalonPara <> nil) and (l_ResultPara <> nil)
 until (l_EtalonPara = nil) or (l_ResultPara = nil);
 repeat
  l_ResultPara:= GetNextPara(textOut.Document, l_ResultParaIndex);
  if (l_ResultPara <> nil) then
  begin
   MarkDifference(nil, l_ResultPara);
  end; // (l_EtalonPara <> nil) and (l_ResultPara <> nil)
 until (l_ResultPara = nil);
 textEtalon.ReadOnly:= True;
 textOut.ReadOnly:= True;
end;

procedure TCompareViewForm.btnSaveAsEtalonClick(Sender: TObject);
begin
 CopyFile(f_ResultFileName, f_EtalonFileName);
 ModalResult:= mrOk;
end;

procedure TCompareViewForm.btnSourceEtalonClick(Sender: TObject);
begin
 f_IsSource:= not f_IsSource;
 if f_IsSource then
  LoadSourceText
 else
  LoadEtalonText;
 LoadFile(f_ResultFileName, TextOut);
 AnalyzeText;
end;

function TCompareViewForm.Execute(const aEtalonFileName, aSourceFileName,
    aResultFileName: String): Boolean;
begin
 Caption:= ExtractFileName(aEtalonFileName);
 f_EtalonFileName:= aEtalonFileName;
 f_SourceFileName:= aSourceFileName;
 f_ResultFileName:= aResultFileName;
 if FileExists(aEtalonFileName) then
  LoadEtalonText
 else
  LoadSourceText;
 LoadFile(aResultFileName, TextOut);
 AnalyzeText;
 ModalResult:= mrCancel;
 Result:= IsPositiveResult(ShowModal);
end;

procedure TCompareViewForm.FindMismatch(const aS1, aS2: string; out theStart,
    theFinish: Integer);
var
 i: Integer;
begin
 theStart:= Succ(Length(aS1));
 if (aS1 <> '') and (aS2 <> '') then
 begin
   for i:= 1 to Length(aS1) do
    if (i <= Length(aS2)) then
    begin
     if (aS1[i] <> aS2[i]) then
     begin
      theStart:= i;
      break;
     end;
    end
    else
     break;
   theFinish:= Length(aS2);
   if Length(aS1) > theStart then
    for i:= theStart to length(aS2) do
     if (aS1[theStart] = aS2[i]) then
     begin
      theFinish:= Pred(i);
      break
     end
     else
     if ((Length(aS1) > Succ(theStart)) and (aS1[Succ(theStart)] = aS2[i])) then
     begin
      theFinish:= Pred(i);
      break
     end;
 end;
end;

procedure TCompareViewForm.FormCreate(Sender: TObject);
begin
 edEtalon.DrawSpecial:= True;
 edOut.DrawSpecial:= True;
 edEtalon.Zoom:= 95;
 edOut.Zoom:= 95;
 f_IsSource:= False;
 panelEtalon.Width:= ClientWidth div 2;
end;

procedure TCompareViewForm.FormResize(Sender: TObject);
begin
 panelEtalon.Width:= ClientWidth div 2;
end;

function TCompareViewForm.GetNextPara(aDoc: Tl3Tag; var aChildIndex: Integer):
    Tl3Tag;
var
 i: Integer;
begin
 Result := nil;
 for i:= aChildIndex to Pred(aDoc.ChildrenCount) do
  if aDoc.Child[i].InheritsFrom(k2_idTextPara) then
  begin
   Result:= aDoc.Child[i];
   aChildIndex:= Succ(i);
   break;
  end
end;

procedure TCompareViewForm.LoadEtalonText;
begin
 f_IsSource:= False;
 btnSourceEtalon.Caption:= 'Исходный текст';
 Panel2.Caption:= 'Эталонный текст';
 LoadFile(f_EtalonFileName, TextEtalon);
end;

procedure TCompareViewForm.LoadFile(const aFileName: String; aTextSource:
    TevTextSource);
var
 l_Reader: Tk2TagGenerator;
begin
 aTextSource.New;
 if FileExists(aFileName) then
 begin
  l_Reader:= nil;
  try
   if AnsiSameText(ExtractFileExt(aFileName), '.evd') then
    TevEvdStorageReader.SetTo(l_Reader, aFileName)
   else
    TddDocReader.SetTo(l_Reader, aFileName);
   aTextSource.Load(l_Reader as Tk2CustomReader);
  finally
   FreeAndNil(l_Reader);
  end;
 end;
end;

procedure TCompareViewForm.LoadSourceText;
begin
 f_IsSource:= True;
 btnSourceEtalon.Caption:= 'Эталонный текст';
 Panel2.Caption:= 'Исходный текст';
 LoadFile(f_SourceFileName, TextEtalon);
end;

procedure TCompareViewForm.MakeSegment(aPara: Tl3Tag; aStart, aFinish: Integer);
var
 l_Seg: Tl3Tag;
begin
 if aPara <> nil then
  if (aStart > 1) then
   with aPara.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, ev_slView], nil) do
   begin
    l_Seg := k2_typTextSegment.MakeTag;
    l_Seg.IntW[k2_tiStart, nil]:= aStart;
    l_Seg.IntW[k2_tiFinish, nil]:= aFinish;
    l_Seg.IntW[k2_tiStyle, nil]:= ev_saFoundWords;
    AddChild(l_Seg);
   end // with aResultPara
  else
   aPara.CAtom(k2_tiFont).IntW[k2_tibackColor, nil]:= clLtGray;
end;

procedure TCompareViewForm.MarkDifference(aEtalonPara, aResultPara: Tl3Tag);
var
 l_Start, l_End: Integer;
 l_EtalonText, l_ResultText: String;
begin
 if aEtalonPara <> nil then
  l_EtalonText:= aEtalonPara.StrA[k2_tiText]
 else
  l_EtalonText:= '';

 if aResultPara <> nil then
  l_ResultText:= aResultPara.StrA[k2_tiText]
 else
  l_ResultText:= '';

 if Length(l_ResultText) > Length(l_EtalonText) then
 begin
   FindMismatch(l_EtalonText, l_ResultText, l_Start, l_End);
   MakeSegment(aResultPara, l_Start, l_End);
 end
 else
 if Length(l_ResultText) < Length(l_EtalonText) then
 begin
  FindMismatch(l_ResultText, l_EtalonText, l_Start, l_End);
  MakeSegment(aEtalonPara, l_Start, l_End);
 end
 else
 begin
  FindMismatch(l_ResultText, l_EtalonText, l_Start, l_End);
  MakeSegment(aEtalonPara, l_Start, l_End);
  MakeSegment(aResultPara, l_Start, l_End);
 end
end;

end.
