unit D_GetAbo;

{ $Id: D_GetAbo.pas,v 1.37 2014/11/27 14:11:11 voba Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BottomBtnDlg, HelpCnst,
  OvcBase, l3Base, k2TagGen, k2Reader,  evEditorWindow, evEditor, evMemo,
  StdCtrls, ExtCtrls, Buttons, vtlister, vtSpin, Mask, vtCombo, vtDateEdit,
  evMultiSelectEditorWindow, evCustomEditor, evEditorWithOperations, vtStringLister,
  afwControl, afwInputControl, evCustomMemo, evCommonTypes, afwControlPrim,
  afwBaseControl, nevControl, evCustomEditorWindowPrim,
  evCustomEditorWindow, evCustomEditorWindowModelPart,
  evCustomEditorModelPart;

type
  TGetAbolishDataDlg = class(TBottomBtnDlg)
    lstNameStr: TvtStringlister;
    Label1: TLabel;
    Label2: TLabel;
    memoTextStr: TevMemo;
    Label3: TLabel;
    edtExpDate: TvtDateEdit;
    procedure edtExpDateInvalidDate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lstNameStrCurrentChanged(Sender: TObject; aNewCurrent: Integer; 
        aOldCurrent: Integer);
    procedure memoTextStrmemoTextStr_TextSourceGetReader(Sender: TObject;
      aFormat: Cardinal; var Reader: TevCustomFileReader);
    procedure memoTextStrmemoTextStr_TextSourceGetWriter(Sender: TObject;
      Format: Cardinal; var Writer: Tk2TagGenerator);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  l3Chars,
  l3String,

  k2Tags,

  evTxtRd,
  evTypes,
  evFacadeSelection,
  evFacadeUtils,
  evTagsListFilter,
  evTextFormatter,
                                   
  Readers,
  Writers,

  Block_Const,
  Hyperlink_Const,
  Sub_Const,
  TextPara_Const,
  Segment_Const,

  vtDialogs
  ;

{$R *.DFM}

procedure TGetAbolishDataDlg.edtExpDateInvalidDate(Sender: TObject);
begin
 vtMessageDlg(l3CStr('������� �������� ����'), mtError);
 ActiveControl := edtExpDate;
end;

procedure TGetAbolishDataDlg.FormCreate(Sender: TObject);
begin
 inherited;
 lstNameStrCurrentChanged(Self, 0, 0);
 HelpContext := hcSetAbolished;
 memoTextStr.TextSource.OnGetReader := memoTextStrmemoTextStr_TextSourceGetReader;
 memoTextStr.KeepAllFormatting := True;
 evSetPlainTextFlag(memoTextStr, False);
 edtExpDate.CheckOnExit := False;
end;

procedure TGetAbolishDataDlg.lstNameStrCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
begin
 case aNewCurrent of
   0 : memoTextStr.Text := '���������  ������� ���������� ����';
   1 : memoTextStr.Text := '���������  �������� ���������� ����';
   2 : memoTextStr.Text := '���������  �������� ���������� ����';
   3 : memoTextStr.Text := '���������  �������� ����������� ����';
   4 : memoTextStr.Text := '��������� ��������';
   5 : memoTextStr.Text := '���������� ��������';
   6 : memoTextStr.Text := '���������� ��������';
   7 : memoTextStr.Text := '���������� ��������';
   8 : memoTextStr.Text := '���� � ��������';
   9 : memoTextStr.Text := ''; //'��������� ������������ ������� � ����';
  10 : memoTextStr.Text := ''; //'��������� ������������ ���� � ������������';
  11 : memoTextStr.Text := ''; //�� ���������
  12 : memoTextStr.Text := '���������  �������';
  13 : memoTextStr.Text := '���������  ��������';
  14 : memoTextStr.Text := '���������  ��������';
  15 : memoTextStr.Text := '���������  ��������';
  16 : memoTextStr.Text := '�������� ��������������';
  17 : memoTextStr.Text := ''; //�� �����������
  18..21 : memoTextStr.Text := ''; //�� ������� � ����';
 end;
end;

procedure TGetAbolishDataDlg.memoTextStrmemoTextStr_TextSourceGetWriter(
  Sender: TObject; Format: Cardinal; var Writer: Tk2TagGenerator);
var
 l_TagFilter: TevTagsListFilter;
 l_Wrap: Ik2TagGeneratorWrap;
 l_Filter: Tk2TagGenerator;
begin
 inherited;
 if (Format = cf_RTF) then
 begin
  l3Free(Writer);
  Writer := TevRTFWriter.Create(nil);
  //Format = cf_RTF
 end
 else
  if (Format = cf_OEMText) then
  begin
   if (Writer Is TevCustomTextFormatter) then
    TevCustomTextFormatter(Writer).CodePage := CP_OEMLite;
   //Format = cf_OEMText
  end
  else
   if Writer <> nil then
   begin
    if (Format = cf_Text) OR (Format = cf_OEMText) then Exit;
    l_TagFilter := TevTagsListFilter.Make([k2_typBlock, k2_typHyperlink], // - ��� ���� ���������
                                       [k2_typSub, k2_typSegment],  // - ��� ���� ��������
                                       [evTagAttr(k2_typTextPara, k2_tiStyle), evTagAttr(k2_typTextPara, k2_tiFont)]);
    try
     if Supports(l_TagFilter, Ik2TagGeneratorWrap, l_Wrap) then
     begin
      l_Filter := l_Wrap.Generator;
      l_Filter.Link(Writer);
      l3Set(Writer, l_Filter);
     end;
    finally
     l3Free(l_TagFilter);
    end;{try..finally}
   end;
end;

procedure TGetAbolishDataDlg.memoTextStrmemoTextStr_TextSourceGetReader(
  Sender: TObject; aFormat: Cardinal; var Reader: TevCustomFileReader);
var
 l_Filter : TevTagsListFilter;
begin
 inherited;
 if (aFormat = cf_RTF) or (aFormat = cf_RTFLite) then
  begin
   l3Free(Reader);
   Reader := TevRTFReader.Create(nil);
   if (aFormat = cf_RTFLite) then
    TevRTFReader(Reader).LiteVersion := True;
   Exit;
  end;{aFormat = cf_RTF}

 if (Reader <> nil) then
 begin
  if (aFormat = cf_Text) OR (aFormat = cf_OEMText) then Exit;
  l_Filter := TevTagsListFilter.Make([k2_typSub, k2_typSegment], // - ��� ���� ���������
                                   [k2_typBlock, k2_typHyperlink],  // - ��� ���� ��������
                                   [evTagAttr(k2_typTextPara, k2_tiStyle)]
                                   );
  try
   Reader.Generator := l_Filter;
  finally
   l3Free(l_Filter);
  end;{try..finally}
 end;{Reader <> nil}
end;

end.
