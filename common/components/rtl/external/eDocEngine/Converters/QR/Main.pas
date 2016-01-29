
{***************************************************************************}
{  gtQR => eDocEngine QR!                                                   }
{  Conversion utility                                                       }
{                                                                           }
{  Copyright © 1998-2008 Gnostice Information Technologies Private Limited  }
{                                                                           }
{***************************************************************************}

{!!!!!!!!!!!!!!!!!!!!!!! IMPORTANT !!!!!!!!!!!!!!!!!!!!!!!!!}
{                                                           }
{ COMPILE THIS PROJECT IN THE SAME VERSION OF DELPHI/       }
{ C++ BUIDLER AS THE PROJECTS, WHICH WILL BE CONVERTED,     }
{ WERE DEVELOPED IN.                                        }
{                                                           }
{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}

unit Main;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, Buttons, FileCtrl, ExtCtrls, ShellAPI, ComCtrls;

type
	TfrmMain = class(TForm)
		btnStart: TBitBtn;
		gbSingleFile: TGroupBox;
		gbMultiFile: TGroupBox;
		rbSingleFile: TRadioButton;
		rbFolderFiles: TRadioButton;
		edSingleFile: TEdit;
		btnSelectFile: TSpeedButton;
		edMultiFile: TEdit;
		btnSelectDir: TSpeedButton;
		gbFileType: TGroupBox;
		Bevel1: TBevel;
		lblFilesDone: TLabel;
		Image1: TImage;
		lblCurrentFile: TLabel;
		Image2: TImage;
		GroupBox2: TGroupBox;
		Label1: TLabel;
		Label2: TLabel;
		Label3: TLabel;
		Label4: TLabel;
		Label5: TLabel;
		Label6: TLabel;
		Label7: TLabel;
		Label8: TLabel;
		Label9: TLabel;
		Label10: TLabel;
		Label11: TLabel;
		Label12: TLabel;
		Label13: TLabel;
		Bevel2: TBevel;
		Bevel3: TBevel;
		lblCount0: TLabel;
    lblCount1: TLabel;
    lblCount2: TLabel;
    lblCount3: TLabel;
    lblCount4: TLabel;
    lblCount5: TLabel;
    lblCount6: TLabel;
    lblCount7: TLabel;
    lblCount8: TLabel;
    lblCount9: TLabel;
    lblCount10: TLabel;
    lblCount11: TLabel;
		lblSum: TLabel;
		Image3: TImage;
    progFiles: TProgressBar;
		Bevel4: TBevel;
		progLines: TProgressBar;
		Bevel5: TBevel;
		OpenDialog: TOpenDialog;
		lblLinesLeft: TLabel;
		chbBackup: TCheckBox;
		edBackupDir: TEdit;
    cbxDFM: TCheckBox;
    cbxPAS: TCheckBox;
    cbxCPP: TCheckBox;
    cbxH: TCheckBox;
    cbxOther1: TCheckBox;
    edOther1: TEdit;
    cbxOther2: TCheckBox;
    edOther2: TEdit;
		procedure btnStartClick(Sender: TObject);
		procedure btnSelectDirClick(Sender: TObject);
		procedure rbSingleFileClick(Sender: TObject);
		procedure rbFolderFilesClick(Sender: TObject);
		procedure btnSelectFileClick(Sender: TObject);
		procedure edPathChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);
    procedure cbxOther1Click(Sender: TObject);
    procedure edOther1KeyPress(Sender: TObject; var Key: Char);
    procedure cbxOther2Click(Sender: TObject);
	private
		FFileCount: Integer;
		FCurrPathEdit: TEdit;
		procedure UpdateStartBtn;
	public
	end;

var
	frmMain: TfrmMain;
  LeftPos: Integer;
  Resl: Integer;
  VisibleFilters: String;

implementation

{$R *.DFM}

type

	THackWinControl = class(TWinControl);

	TgtQRClass = (ccTQRLabel, ccTQRDBText, ccTQRExpr,
		ccTQRSysData, ccTQRMemo, ccTQRExprMemo, ccTQRRichText, ccTQRDBRichText,
		ccTQRShape, ccTQRImage, ccImageFormat, ccTQRDBImage, ccTQRChart,
    ccQRExportFilter, ccQRDocumentExportFilter, ccQRPDFExportFilter,
    ccQRHTMLExportFilter, ccQRRTFExportFilter, ccQRExcelExportFilter,
    ccQRTextExportFilter, ccQRGIFExportFilter, ccQRJPEGExportFilter,
    ccQRBMPExportFilter, ccQREMFExportFilter, ccQRWMFExportFilter,
    ccQRNavigatorType,
    ccQRDocument, ccQRRTF, ccQRPDF, ccQRHTML
    );

const
	ClassNames: array[TgtQRClass] of string = ('QRLabel', 'QRDBText',
		'QRExpr', 'QRSysData', 'QRMemo', 'QRExprMemo', 'QRRichText',
		'QRDBRichText', 'QRShape', 'QRImage', 'ImageFormat', 'QRDBImage', 'QRChart',
    'QRExportFilter', 'QRDocumentExportFilter', 'QRPDFExportFilter',
    'QRRTFExportFilter', 'QRHTMLExportFilter', 'QRExcelExportFilter',
    'QRTextExportFilter', 'QRGIFExportFilter', 'QRJPEGExportFilter',
    'QRBMPExportFilter', 'QREMFExportFilter', 'QRWMFExportFilter',
    'QRNavigatorType',
    'QRDocument', 'QRRTF', 'QRPDF', 'QRHTML'
    );
  OldClassNames: array[1..12] of string = (
    ': TgtQRPDFExport', ': TgtQRRTFExport', ': TgtQRHTMLExport',
    ': TgtQRExcelExport',': TgtQRTextExport', ': TgtQRGIFExport',
    ': TgtQRJPEGExport', ': TgtQRBMPExport',': TgtQREMFExport',
    ': TgtQRWMFExport',': TgtQRXHTMLExport',': TgtQRExportHub');
  NewClassNames: array[1..11] of string = (
    'object %s: TgtPDFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''pdf''' + #13#10 +
    '  FileDescription = ''Adobe PDF Files''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET'  + #13#10 +
    '  Font.Color = clWindowText'  + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  InputXRes = %d' + #13#10 +
    '  InputYRes = %d' + #13#10 +
    '  FontEncoding = feWinAnsiEncoding' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtRTFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''rtf''' + #13#10 +
    '  FileDescription = ''Rich Text Format''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifJPEG' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Preferences.GraphicDataInBinary = False' + #13#10 +
    '  DocumentEncodingType = etPositionalAccuracy' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtHTMLEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''htm''' + #13#10 +
    '  FileDescription = ''HyperText Markup Language''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Preferences.AutoScroll = False' + #13#10 +
    '  Preferences.OptimizeForIE = False' + #13#10 +
    '  Navigator.LinkFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Navigator.LinkFont.Color = clBlue' + #13#10 +
    '  Navigator.LinkFont.Height = -27' + #13#10 +
    '  Navigator.LinkFont.Name =''Wingdings''' + #13#10 +
    '  Navigator.LinkFont.Style = []' + #13#10 +
    '  TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  TOCPageSettings.ItemFont.Color = clWindowText' + #13#10 +
    '  TOCPageSettings.ItemFont.Height = -11' + #13#10 +
    '  TOCPageSettings.ItemFont.Name = ''MS Sans Serif''' + #13#10 +
    '  TOCPageSettings.ItemFont.Style = []' + #13#10 +
    '  TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  TOCPageSettings.TitleFont.Color = clWindowText' + #13#10 +
    '  TOCPageSettings.TitleFont.Height = -11' + #13#10 +
    '  TOCPageSettings.TitleFont.Name = ''MS Sans Serif''' + #13#10 +
    '  TOCPageSettings.TitleFont.Style = []' + #13#10 +
    '  TOCPageSettings.Title = ''Table Of Contents''' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtExcelEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''xls''' + #13#10 +
    '  FileDescription = ''Microsoft Excel Workbook''' + #13#10 +
    '  ItemsToRender = [irText, irImage]' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Preferences.AutoFormatCells = False' + #13#10 +
    '  Formatting.ColumnSpacing = -1' + #13#10 +
    '  Formatting.RowSpacing = -1' + #13#10 +
    '  Formatting.ScaleX = 1.000000000000000000 ' + #13#10 +
    '  Formatting.ScaleY = 1.000000000000000000' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifMetafile' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtTextEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''txt''' + #13#10 +
    '  FileDescription = ''Text Document''' + #13#10 +
    '  DefaultFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  DefaultFont.Color = clWindowText' + #13#10 +
    '  DefaultFont.Height = -11' + #13#10 +
    '  DefaultFont.Name = ''MS Sans Serif''' + #13#10 +
    '  DefaultFont.Style = []' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  PageEndLines = True' + #13#10 +
    '  ColumnSpacing = 1' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtGIFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''gif''' + #13#10 +
    '  FileDescription = ''Graphics Interchange Format''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtJPEGEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''jpg''' + #13#10 +
    '  FileDescription =''JPEG File Interchange Format''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end' ,
    'object %s: TgtBMPEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''bmp''' + #13#10 +
    '  FileDescription = ''Windows Bitmap''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''  ' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtEMFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''emf''' + #13#10 +
    '  FileDescription = ''Enhanced Metafiles''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end ' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end ',

    'object %s: TgtWMFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''wmf''' + #13#10 +
    '  FileDescription = ''Windows Metafiles''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface ' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtXHTMLEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''htm''' + #13#10 +
    '  FileDescription = ''Extended HyperText Markup Language''' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Preferences.AutoScroll = False' + #13#10 +
    '  Preferences.OptimizeForIE = False' + #13#10 +
    '  Navigator.LinkFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Navigator.LinkFont.Color = clBlue' + #13#10 +
    '  Navigator.LinkFont.Height = -27' + #13#10 +
    '  Navigator.LinkFont.Name =''Wingdings''' + #13#10 +
    '  Navigator.LinkFont.Style = []' + #13#10 +
    '  TOCPageSettings.ItemFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  TOCPageSettings.ItemFont.Color = clWindowText' + #13#10 +
    '  TOCPageSettings.ItemFont.Height = -11' + #13#10 +
    '  TOCPageSettings.ItemFont.Name = ''MS Sans Serif''' + #13#10 +
    '  TOCPageSettings.ItemFont.Style = []' + #13#10 +
    '  TOCPageSettings.TitleFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  TOCPageSettings.TitleFont.Color = clWindowText' + #13#10 +
    '  TOCPageSettings.TitleFont.Height = -11' + #13#10 +
    '  TOCPageSettings.TitleFont.Name = ''MS Sans Serif''' + #13#10 +
    '  TOCPageSettings.TitleFont.Style = []' + #13#10 +
    '  TOCPageSettings.Title = ''Table Of Contents''' + #13#10 +
    'end' + #13#10 +
    'object gtQRExportInterface%d: TgtQRExportInterface' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end'
  );

  UnitNames: array[1..8] of string = ('gtClasses','gtUtils','gtConsts','gtHash',
    'gtPDFFont','gtDZLIB','gtPDFCrypt','gtFilters' );
{------------------------------------------------------------------------------}

{-String routines--------------------------------------------------------------}

function AnsiContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

{-Conversion & file routines --------------------------------------------------}

function AppendTrailingBackslash(const S: string): string;
begin
	Result := S;
	if not IsPathDelimiter(Result, Length(Result)) then Result := Result + '\';
end;

{------------------------------------------------------------------------------}

function GetFilesInDirectory(const DirName, FileTypes: string;
	Attrib: Integer): TStringList;

	procedure AddFileNamesToList(const ADir, AFileExt: string; AAttrib: Integer;
		AList: TStrings);
	var
		SRec: TSearchRec;
		S: string;
	begin
		S := AppendTrailingBackslash(ADir) + '*.' + AFileExt;
		if FindFirst(S, AAttrib, SRec) = 0 then
			with AList do
			begin
				repeat
						Add(SRec.Name);
				until FindNext(SRec) <> 0;
				FindClose(SRec);
			end;
	end;

var
	I: Integer;
begin
	Result := nil;
	if DirectoryExists(DirName) then
	begin
		Result := TStringList.Create;
		with TStringList.Create do
			try
				CommaText := FileTypes;
				for I := 0 to Count - 1 do
					AddFileNamesToList(DirName, Strings[I], Attrib, Result);
			finally
				Free;
			end;
	end;
end;

{------------------------------------------------------------------------------}

function IsDFMBinary(FileName: string): Boolean;
var
	F: TFileStream;
	B: Byte;
begin
	B := 0;
	F := TFileStream.Create(FileName, fmOpenRead);
	try
		F.Read(B, 1);
		Result := B = $FF;
	finally
		F.Free;
	end;
end;

{------------------------------------------------------------------------------}

procedure DFM2TXT(Src, Dest: string);
var
	SrcS, DestS: TFileStream;
begin
	SrcS := TFileStream.Create(Src, fmOpenRead);
	DestS := TFileStream.Create(Dest, fmCreate);
	try
		ObjectResourceToText(SrcS, DestS);
	finally
		SrcS.Free;
		DestS.Free;
	end;
end;

{------------------------------------------------------------------------------}

function ReplaceString(const S, OldPattern, NewPattern: string;
	var NumFound: Integer): string;

	function IsWholeMatch(const S, Patt: string; StartPos: Integer): Boolean;
	begin
		Result := ((StartPos = 1) or not(S[StartPos - 1] in ['A'..'Z', '0'..'9']))
			and	((StartPos + Length(Patt) >= Length(S)) or
				not(S[StartPos + Length(Patt)] in ['A'..'Z', '0'..'9']));
	end;

var
	I: Integer;
	SearchStr, Str, OldPat: string;
begin
	SearchStr := AnsiUpperCase(S);
	OldPat := AnsiUpperCase(OldPattern);
	Str := S;
	NumFound := 0;
	Result := '';
	while SearchStr <> '' do
	begin
		I := AnsiPos(OldPat, SearchStr);
		if I = 0 then
		begin
			Result := Result + Str;
			Break;
		end;
		// ------ Match whole words only ------
		if IsWholeMatch(SearchStr, OldPat, I) then
		begin
			Inc(NumFound);
			Result := Result + Copy(Str, 1, I - 1) + NewPattern;
		end
		else
			Result := Result + Copy(Str, 1, I + Length(OldPat) - 1);
		Str := Copy(Str, I + Length(OldPattern), MaxInt);
		SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
	end;
end;

{------------------------------------------------------------------------------}

procedure TXT2DFM(Src, Dest: string);
var
	SrcS, DestS: TFileStream;
begin
	SrcS := TFileStream.Create(Src, fmOpenRead);
	DestS := TFileStream.Create(Dest, fmCreate);
	try
		ObjectTextToResource(SrcS, DestS);
	finally
		SrcS.Free;
		DestS.Free;
	end;
end;

{------------------------------------------------------------------------------}

procedure ConvertFile(SrcFile, DestFile: string; AProgressBar: TProgressBar;
	AProgressLabel: TLabel; var ChangeCount: array of Integer;
	var ChangeSum: Integer; var IsUnitChanged, IsDFM: Boolean);

  procedure ConvertDFM;
  var
    I, K: Integer;
    LStr: String;
    dfmFile: TStringList;
    Count: Integer;
  begin
    Count := 0;
    dfmFile := TStringList.Create;
    dfmFile.LoadFromFile(SrcFile);

    I := 0;
    while (I < dfmFile.Count-1) do
    begin
      for K := 1 to 11 do
      begin
        if(AnsiContainsText(dfmFile.Strings[I],OldClassNames[K])) then
        begin
          Inc(Count);
          LStr := StringReplace(dfmFile.Strings[I], OldClassNames[K], '', [rfIgnoreCase]);
          LStr := StringReplace(LStr, 'object', '', [rfIgnoreCase]);
          LStr := Trim(LStr);
          dfmFile.Delete(I);
          while(Trim(dfmFile.Strings[I]) <> 'end') do
            dfmFile.Delete(I);
          // Only for PDF
          if (K = 1) then
            dfmFile.Strings[I] := StringReplace(dfmFile.Strings[I], dfmFile.Strings[I],
              Format(NewClassNames[K], [LStr, LeftPos, Resl, Resl, Count,
                LeftPos+32, LStr]), [rfIgnoreCase])
          else
            dfmFile.Strings[I] := StringReplace(dfmFile.Strings[I], dfmFile.Strings[I],
              Format(NewClassNames[K], [LStr, LeftPos, Count, LeftPos+32, LStr]), [rfIgnoreCase]);
          Inc(LeftPos, 64);
        end;
      end;

      //for hub
      if (AnsiContainsText(dfmFile.Strings[I],OldClassNames[12])) then
      begin
        dfmFile.Delete(I);
        while(Trim(dfmFile.Strings[I]) <> 'end') do
        begin
          if pos('VisibleFilters',dfmFile.Strings[I]) <> 0 then
          VisibleFilters := dfmFile.Strings[I];
          dfmFile.Delete(I);
        end;

        if pos('fkPDF',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtPDFEngine';
            dfmFile.Insert(I,(Format(NewClassNames[1], [LStr, LeftPos, Resl, Resl, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkRTF',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtRTFEngine';
            dfmFile.Insert(I,(Format(NewClassNames[2], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkHTML',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtHTMLEngine';
            dfmFile.Insert(I,(Format(NewClassNames[3], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkBMP',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtBMPEngine';
            dfmFile.Insert(I,(Format(NewClassNames[8], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkXHTML',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtXHTMLEngine';
            dfmFile.Insert(I,(Format(NewClassNames[11], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkText',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtTextEngine';
            dfmFile.Insert(I,(Format(NewClassNames[5], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkGIF',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtGIFEngine';
            dfmFile.Insert(I,(Format(NewClassNames[6], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkEMF',VisibleFilters)<> 0 then
        begin
          Inc(count);
           LStr:='gtEMFEngine';
            dfmFile.Insert(I,(Format(NewClassNames[9], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkJPEG',VisibleFilters)<> 0 then
        begin
          Inc(count);
          LStr:='gtJPEGEngine';
          dfmFile.Insert(I,(Format(NewClassNames[7], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkExcel',VisibleFilters)<> 0 then
        begin
          Inc(count);
          LStr:='gtExcelEngine';
          dfmFile.Insert(I,(Format(NewClassNames[4], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        if pos('fkWMF',VisibleFilters)<> 0 then
        begin
          Inc(count);
          LStr:='gtWMFEngine';
          dfmFile.Insert(I,(Format(NewClassNames[10], [LStr, LeftPos, Count, LeftPos+32, LStr])));
          Inc(LeftPos, 64);
          Inc(I);
        end;
        dfmFile.Delete(I);
        Dec(I);
      end;
      Inc(I);
    end;
    dfmFile.SaveToFile(DestFile);
    dfmFile.Free;
  end;

  procedure ConvertPAS;
  var
    Myf: TStringList;
    tempstring1: string;
    TempString: string;
    UsesString:string;
    i : Integer;
    p,q,r: integer;
    infcnt : integer;
     j: integer;

    procedure convert_hub();
    var
    Hub_String: String;
    begin
      Hub_String:='';
      if(pos('fkPDF',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtPDFEngine: TgtPDFEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkHTML',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtHTMLEngine: TgtHTMLEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkXHTML',VisibleFilters) <> 0) then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtXHTMLEngine: TgtXHTMLEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkRTF',VisibleFilters) <> 0)   then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtRTFEngine: TgtRTFEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkExcel',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtExcelEngine: TgtExcelEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkText',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtTextEngine: TgtTextEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkGIF',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtGIFEngine: TgtGIFEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkJPEG',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtJPEGEngine: TgtJPEGEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkBMP',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtBMPEngine: TgtBMPEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkEMF',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtEMFEngine: TgtEMFEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      if(pos('fkWMF',VisibleFilters) <> 0)  then
      begin
        inc(infcnt);
        Hub_String:=Hub_String+'    gtWMFEngine: TgtWMFEngine;'+ #13#10 +
        '    gtQRExportInterface'+ IntToStr(infcnt) +': TgtQRExportInterface;'+ #13#10 ;
      end;
      myf.Strings[i]:=Trim(myf.Strings[i]);
      myf.Strings[i]:=StringReplace(myf.Strings[i],myf.Strings[i],Hub_String,[rfIgnoreCase]);
    end;

    procedure convert(oldstring,newstring :string);
    begin
      inc(infcnt);
      myf.Strings[i] := StringReplace(myf.Strings[I], oldstring, newstring, [rfIgnoreCase]);
      myf.Insert(i+1, '    gtQRExportInterface' + IntToStr(infcnt) + ': TgtQRExportInterface;');
      Inc(I);
    end;

  begin
    i := 0;
    infcnt := 0;
    r := 0;
    q := 0;
    Myf := TStringList.Create;
    Myf.LoadFromFile(SrcFile);
    P := pos('uses',myf.Text);
    UsesString:='';
    TempString:='';
    while(myf.text[p+4] <> ';') do
    begin
      tempstring :=tempstring+myf.text[P+4];
      inc(p);
    end;
    //clasify doc and graphic
    if(pos('gtQRXport_Doc',tempstring) > 0) then
    begin
      if(pos('gtQRXport_Graphic',tempstring) > 0) then
        r := 1
      else
        q := 1;
    end
    else if(pos('gtQRXport_Graphic',tempstring) > 0) then
    begin
      TempString:= StringReplace(TempString, 'gtQRXport_Doc', '',
        [rfIgnoreCase]);
    end;

    //both d & g
    if(r = 1) then
    begin
      if((pos('gtQRXport_PDF', tempstring) > 0) or
        (pos('gtQRXport_RTF', tempstring) > 0) or
        (pos('gtQRXport_HTML', tempstring) > 0) or
        (pos('gtQRXport_XHTML', tempstring) > 0)) then
      begin
        tempstring:= StringReplace(tempstring, 'gtQRXport_Doc',
          'gtXportIntf', [rfIgnoreCase]);
        tempstring:= StringReplace(tempstring, 'gtQRXport_Graphic', 'gtCstGfxEng',
          [rfIgnoreCase]);
      end
      else
      begin
        tempstring:= StringReplace(tempstring, 'gtQRXport_Graphic',
          'gtCstGfxEng', [rfIgnoreCase]);
      end;
    end;
    // only doc
    if(q = 1) then
    begin
      if((pos('gtQRXport_PDF', tempstring) > 0) or
        (pos('gtQRXport_RTF', tempstring) > 0) or
        (pos('gtQRXport_HTML', tempstring) > 0) or
        (pos('gtQRXport_XHTML', tempstring) > 0)) then
      begin
        tempstring:= StringReplace(tempstring, ',',
          ' ,gtClasses, gtCstDocEng, gtCstPlnEng, ', [rfIgnoreCase]);
        tempstring := StringReplace(tempstring, 'gtQRXport_Doc',
          'gtXportIntf', [rfIgnoreCase]);
      end
      else
      begin
        tempstring:= StringReplace(tempstring, ',',
          ' ,gtClasses, gtCstDocEng', [rfIgnoreCase]);
        tempstring := StringReplace(tempstring, 'gtQRXport_Doc',
          'gtXportIntf', [rfIgnoreCase]);    //*************
      end;
    end;

    //PDF
    if(pos('gtQRXport_PDF', tempstring) > 0) then
      tempstring := StringReplace(tempstring,'gtQRXport_PDF',
        'gtCstPDFEng, gtExPDFEng, gtPDFEng', [rfIgnoreCase]);
    //RTF
    if(pos('gtQRXport_RTF', tempstring) > 0) then
      tempstring:= StringReplace(tempstring, 'GTQRXPORT_RTF', 'gtRTFEng',
        [rfIgnoreCase]);
    //EXCEL
    if(pos('gtQRXport_Excel', tempstring) > 0) then
      tempstring := StringReplace(tempstring, 'GTQRXPORT_EXCEL',
        'gtCstSpdEng, gtCstXLSEng, gtExXLSEng, gtXLSEng', [rfIgnoreCase]);
    //HTML & XHTML
    if((pos('gtQRXport_HTML', tempstring) > 0) or
      (pos('gtQRXport_XHTML', tempstring) > 0)) then
      begin
        tempstring:= StringReplace(tempstring, 'GTQRXPORT_HTML',
        'gtCstHTMLEng, gtExHTMLEng, gtHTMLEng', [rfIgnoreCase]);
      if (pos('gtQRXport_XHTML', tempstring) > 0) then
        tempstring := StringReplace(tempstring, 'GTQRXPORT_XHTML',
        'gtXHTMLEng', [rfIgnoreCase]);
      end;
    //TEXT
    if(pos('gtQRXport_Text', tempstring) > 0) then
      tempstring:= StringReplace(tempstring, 'GTQRXPORT_Text', 'gtTXTEng',
        [rfIgnoreCase]);
    //GIF
    if(pos('gtQRXport_GIF', tempstring) > 0) then
      tempstring:= StringReplace(tempstring, 'GTQRXPORT_GIF', 'gtGIFEng',
        [rfIgnoreCase]);
    //JPEG
    if(pos('gtQRXport_JPEG', tempstring) > 0) then
       tempstring:= StringReplace(tempstring, 'GTQRXPORT_JPEG', 'gtJPEGEng',
        [rfIgnoreCase]);
    //BMP
    if(pos('gtQRXport_BMP', tempstring) > 0) then
       tempstring:= StringReplace(tempstring, 'GTQRXPORT_BMP', 'gtBMPEng',
        [rfIgnoreCase]);
    // EMF  &  WMF
    if((pos('gtQRXport_EMF', tempstring) > 0) or
      (pos('gtQRXport_WMF', tempstring) > 0)) then
    begin
      tempstring:= StringReplace(tempstring, 'gtQRXport_Metafile','gtMetafileEng',[rfIgnoreCase]);
      tempstring:= StringReplace(tempstring, 'GTQRXPORT_EMF',
        'gtEMFEng', [rfIgnoreCase]);
      tempstring := StringReplace(tempstring, 'GTQRXPORT_WMF', 'gtWMFEng',
        [rfIgnoreCase]);
    end
    else
    begin
      if(pos('gtQRXport_EMF', tempstring) > 0) then
         tempstring:= StringReplace(tempstring, 'GTQRXPORT_EMF',
          'gtMetafileEng, gtEMFEng', [rfIgnoreCase]);
      if(pos('gtQRXport_WMF', tempstring) > 0) then
         tempstring:= StringReplace(tempstring, 'GTQRXPORT_WMF',
          'gtMetafileEng, gtWMFEng', [rfIgnoreCase]);
    end;
    //for hub
    if((pos('gtQRXport_Hub',TempString) <> 0)) then
    begin
      if(pos('fkPDF',VisibleFilters) <> 0) then
       //gtClasses, gtCstDocEng, gtCstPlnEng, gtCstPDFEng, gtExPDFEng,   gtPDFEng
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstPlnEng',TempString) =0) and
            (pos('gtCstPlnEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstPlnEng,';
        if ((pos('gtCstPDFEng',TempString) =0) and
            (pos('gtCstPDFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstPDFEng,';
        if ((pos('gtExPDFEng',TempString) =0) and
            (pos('gtExPDFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtExPDFEng,';
        if ((pos('gtPDFEng',TempString) =0) and
            (pos('gtPDFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtPDFEng,';
      end;
      if((pos('fkHTML',VisibleFilters) <> 0) and
       //gtClasses, gtCstDocEng, gtCstPlnEng, gtCstHTMLEng, gtExHTMLEng,  gtHTMLEng
         (pos('gtHTMLEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstPlnEng',TempString) =0) and
            (pos('gtCstPlnEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstPlnEng,';
        if ((pos('gtCstHTMLEng',TempString) =0) and
            (pos('gtCstHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstHTMLEng,';
        if ((pos('gtExHTMLEng',TempString) =0) and
            (pos('gtExHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtExHTMLEng,';
        if ((pos('gtHTMLEng',TempString) =0) and
            (pos('gtHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtHTMLEng,';
      end;
      if((pos('fkXHTML',VisibleFilters) <> 0) and
      //gtClasses, gtCstDocEng, gtCstPlnEng, gtCstHTMLEng, gtExHTMLEng,  gtHTMLEng, gtXHTMLEng
         (pos('gtXHTMLEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstPlnEng',TempString) =0) and
            (pos('gtCstPlnEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstPlnEng,';
        if ((pos('gtCstHTMLEng',TempString) =0) and
            (pos('gtCstHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstHTMLEng,';
        if ((pos('gtExHTMLEng',TempString) =0) and
            (pos('gtExHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtExHTMLEng,';
        if ((pos('gtHTMLEng',TempString) =0) and
            (pos('gtHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtHTMLEng,';
        if ((pos('gtXHTMLEng',TempString) =0) and
            (pos('gtXHTMLEng',UsesString) =0)) then
        UsesString:=UsesString+'gtXHTMLEng,';
      end;
      if((pos('fkRTF',VisibleFilters) <> 0) and
      // gtClasses, gtCstDocEng, gtCstPlnEng, gtRTFEng
         (pos('gtRTFEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstPlnEng',TempString) =0) and
            (pos('gtCstPlnEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstPlnEng,';
        if ((pos('gtRTFEng',TempString) =0) and
            (pos('gtRTFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtRTFEng,';
      end;
      if((pos('fkExcel',VisibleFilters) <> 0) and
      // gtClasses, gtCstDocEng, gtCstSpdEng, gtCstXLSEng, gtExXLSEng,  gtXLSEng
         (pos('gtXLSEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstSpdEng',TempString) =0) and
            (pos('gtCstSpdEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstSpdEng,';
        if ((pos('gtCstXLSEng',TempString) =0) and
            (pos('gtCstXLSEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstXLSEng,';
        if ((pos('gtExXLSEng',TempString) =0) and
            (pos('gtExXLSEng',UsesString) =0)) then
        UsesString:=UsesString+'gtExXLSEng,';
        if ((pos('gtXLSEng',TempString) =0) and
            (pos('gtXLSEng',UsesString) =0)) then
        UsesString:=UsesString+'gtXLSEng,';
      end;
      if((pos('fkText',VisibleFilters) <> 0) and
      // gtClasses, gtCstDocEng, gtTXTEng
         (pos('gtQRXport_Text', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtTXTEng',TempString) =0) and
            (pos('gtTXTEng',UsesString) =0)) then
        UsesString:=UsesString+'gtTXTEng,';
      end;
      if((pos('fkGIF',VisibleFilters) <> 0) and
       // gtClasses, gtCstDocEng, gtCstGfxEng, gtGIFEng
         (pos('gtGIFEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstGfxEng',TempString) =0) and
            (pos('gtCstGfxEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstGfxEng,';
        if ((pos('gtGIFEng',TempString) =0) and
            (pos('gtGIFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtGIFEng,';
      end;
      if((pos('fkJPEG',VisibleFilters) <> 0) and
      // gtClasses, gtCstDocEng, gtCstGfxEng, gtJPEGEng
         (pos('gtQRXport_JPEG', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstGfxEng',TempString) =0) and
            (pos('gtCstGfxEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstGfxEng,';
        if ((pos('gtJPEGEng',TempString) =0) and
            (pos('gtJPEGEng',UsesString) =0)) then
        UsesString:=UsesString+'gtJPEGEng,';
      end;
      if((pos('fkBMP',VisibleFilters) <> 0) and
       //gtClasses, gtCstDocEng, gtCstGfxEng, gtBMPEng
         (pos('gtQRXport_BMP', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstGfxEng',TempString) =0) and
            (pos('gtCstGfxEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstGfxEng,';
        if ((pos('gtBMPEng',TempString) =0) and
            (pos('gtBMPEng',UsesString) =0)) then
        UsesString:=UsesString+'gtBMPEng,';
      end;
      if((pos('fkEMF',VisibleFilters) <> 0) and
      //gtClasses, gtCstDocEng, gtCstGfxEng, gtMetafileEng, gtEMFEng
         (pos('gtEMFEng', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstGfxEng',TempString) =0) and
            (pos('gtCstGfxEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstGfxEng,';
        if ((pos('gtMetafileEng',TempString) =0) and
            (pos('gtMetafileEng',UsesString) =0)) then
        UsesString:=UsesString+'gtMetafileEng,';
        if ((pos('gtEMFEng',TempString) =0) and
            (pos('gtEMFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtEMFEng,';
      end;
      if((pos('fkWMF',VisibleFilters) <> 0) and
      // gtClasses, gtCstDocEng, gtCstGfxEng, gtMetafileEng, gtWMFEng
         (pos('gtQRXport_WMF', tempstring) = 0 )) then
      begin
        if ((pos('gtClasses',TempString) =0) and
            (pos('gtClasses',UsesString) =0)) then
        UsesString:=UsesString+'gtClasses,';
        if ((pos('gtCstDocEng',TempString) =0) and
            (pos('gtCstDocEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstDocEng,';
        if ((pos('gtCstGfxEng',TempString) =0) and
            (pos('gtCstGfxEng',UsesString) =0)) then
        UsesString:=UsesString+'gtCstGfxEng,';
        if ((pos('gtMetafileEng',TempString) =0) and
            (pos('gtMetafileEng',UsesString) =0)) then
        UsesString:=UsesString+'gtMetafileEng,';
        if ((pos('gtWMFEng',TempString) =0) and
            (pos('gtWMFEng',UsesString) =0)) then
        UsesString:=UsesString+'gtWMFEng,';
      end;
      delete(UsesString,Length(UsesString),1);
      TempString:=StringReplace(TempString,'GTQRXPORT_HUB',UsesString,[rfIgnoreCase]);
    end;
    if (pos('gtQRXport',tempstring) > 0) then
      TempString := StringReplace(TempString, 'gtQRXport','gtQRXportIntf ', [rfIgnoreCase]);
    if (pos('gtQrCtrls',tempstring) > 0) then
    begin
      P:=PosEx('gtQRRtns',tempstring);
      TempString := StringReplace(TempString, 'gtQRRtns','', [rfIgnoreCase]);
      if (P <> 0) then
      begin
        while((TempString[p]<>';') and (TempString[p] <>',')) do
          Inc(P);
        if (TempString[p] = ',') then
          delete(TempString,P,1);
      end;
      P:=PosEx('gtQrCtrls',tempstring);
      TempString := StringReplace(TempString, 'gtQrCtrls','', [rfIgnoreCase]);
      if (P <> 0) then
      begin
        while((TempString[p]<>';') and (TempString[p] <>',') and (p < Length(TempString))) do
          Inc(P);
        if (TempString[p] = ',') then
          delete(TempString, p, 1)
        else if(TempString[p] = #0) then
          begin
            if (p > Length(TempString)) then
              begin
                TempString := TrimRight(TempString);
                if (TempString[Length(TempString)] = ',') then
                  delete(TempString, Length(TempString), 1)
              end;
          end;
      end;
    end;
    P := pos('uses',myf.Text);
    tempstring1:='';
    while(myf.text[p+4] <> ';') do
    begin
      tempstring1 :=tempstring1+myf.text[P+4];
      inc(p);
    end;
    myf.Text:=StringReplace(myf.Text,tempstring1,TempString,[rfIgnoreCase]);
    //uses end
    while (I <= myf.Count - 1) do
    begin
      if(pos(': TGTQRPDFEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRPDFExport', ': TgtPDFEngine')
      else if(pos(': TGTQRRTFEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRRTFExport', ': TgtRTFEngine')
      else if(pos(': TGTQREXCELEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRExcelExport', ': TgtExcelEngine')
      else if(pos(': TGTQRHTMLEXPORT' ,uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRHTMLExport', ': TgtHTMLEngine')
      else if(pos(': TGTQRTEXTEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRTextExport', ': TgtTextEngine')
      else if(pos(': TGTQRGIFEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRGIFExport', ': TgtGIFEngine')
      else if(pos(': TGTQRJPEGEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRJPEGExport', ': TgtJPEGEngine')
      else if(pos(': TGTQRBMPEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRBMPExport', ': TgtBMPEngine')
      else if(pos(': TGTQREMFEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQREMFExport', ': TgtEMFEngine')
      else if(pos(': TGTQRWMFEXPORT', uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRWMFExport', ': TgtWMFEngine')
      else if(pos(': TGTQRXHTMLEXPORT' ,uppercase(myf.Strings[i])) > 0) then
        convert(': TgtQRXHTMLExport', ': TgtXHTMLEngine')
      else if(pos(': TGTQREXPORTHUB', uppercase(myf.Strings[i])) > 0) then
        convert_hub();
      Inc(I);
      if(pos('IMPLEMENTATION', uppercase(myf.Strings[i-1])) > 0) then
        Break;
    end;
    Myf.SaveToFile(DestFile);
    Myf.Free;
  end;

	procedure UpdateLineStatus(I: Integer);
	begin
		AProgressBar.Position := I;
		AProgressBar.Update;
		AProgressLabel.Caption := Format('%d of %d', [I,  AProgressBar.Max]);
		AProgressLabel.Update;
	end;

var
	I,J, Count: Integer;
	C: TgtQRClass;
	S: string;
	Lines: TStringList;
begin
	Lines := TStringList.Create;
	try
		Lines.LoadFromFile(SrcFile);
		AProgressBar.Max := Lines.Count - 1;

		for I := Lines.Count - 1 downto 0 do
		begin
			UpdateLineStatus(I);
			S := Lines[I];
			for C := Low(ClassNames) to High(ClassNames) do
			begin
        if AnsiPos('TQRExportFilter', S) > 0 then
          Continue;
        S := ReplaceString(S, 'Tgt' + ClassNames[C], 'T' + ClassNames[C],
          Count);
        S := ReplaceString(S, 'TGP' + ClassNames[C], 'T' + ClassNames[C],
          Count);
        S := ReplaceString(S, 'TPs' + ClassNames[C], 'T' + ClassNames[C],
          Count);
        S := ReplaceString(S, 'Tgt' + ClassNames[C] + 'Filter', 'T' + ClassNames[C] + 'ExportFilter', Count);
				if Count <> 0 then
				begin
					Inc(ChangeSum, Count);
					Inc(ChangeCount[Ord(C)], Count);
				end;
			end;
      for J := Low(UnitNames) to High(UnitNames) do
        S := StringReplace(S, UnitNames[J], UnitNames[J]+IntToStr(3), [rfReplaceAll]);
			Lines[I] := S;
			Application.ProcessMessages;
		end;
	finally
		Lines.SaveToFile(DestFile);
		Lines.SaveToFile(SrcFile);
    if IsDFM then
    ConvertDFM
    else
    ConvertPAS;
		Lines.Free;
	end;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
	FCurrPathEdit := edMultiFile;
end;

{-Convert-method selection ----------------------------------------------------}

procedure EnableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := True;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clInactiveBorder) then
				THackWinControl(Controls[I]).Color := clWindow;
	end;
end;

{------------------------------------------------------------------------------}

procedure DisableGroupBox(AGroupBox: TGroupBox);
var
	I: Integer;
begin
	with AGroupBox do
	begin
		Enabled := False;
		for I := 0 to ControlCount - 1 do
			if (Controls[I] is TWinControl) and
					(THackWinControl(Controls[I]).Color = clWindow) then
				THackWinControl(Controls[I]).Color := clInactiveBorder;
	end;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.rbSingleFileClick(Sender: TObject);
begin
	DisableGroupBox(gbFileType);
	DisableGroupBox(gbMultiFile);
	EnableGroupBox(gbSingleFile);
	FCurrPathEdit := edSingleFile;
	UpdateStartBtn;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.rbFolderFilesClick(Sender: TObject);
begin
	DisableGroupBox(gbSingleFile);
	EnableGroupBox(gbMultiFile);
	EnableGroupBox(gbFileType);
	FCurrPathEdit := edMultiFile;
	UpdateStartBtn;
end;

{-File/Folder dialog invoke ---------------------------------------------------}

procedure TfrmMain.btnSelectFileClick(Sender: TObject);
begin
	if OpenDialog.Execute then
		edSingleFile.Text := OpenDialog.FileName;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.btnSelectDirClick(Sender: TObject);
var
	S: string;
begin
{$IFDEF VER100}
	S := '\';
	if SelectDirectory(S, [sdAllowCreate, sdPerformCreate, sdPrompt], 0) then
{$ELSE}
	if SelectDirectory('Select folder to find files in', '\', S) then
{$ENDIF}
		edMultiFile.Text := S;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.edPathChange(Sender: TObject);
begin
	UpdateStartBtn;
end;

procedure TfrmMain.UpdateStartBtn;
begin
	btnStart.Enabled := FCurrPathEdit.Text <> '';
end;

{-Get file-List and start conversion ------------------------------------------}

procedure TfrmMain.btnStartClick(Sender: TObject);

var
	FileList, FileTypeList: TStringList;
	I, ChangeSum: Integer;
	TempFile, FileName, PathName, FileExt: string;
	ChangeCount: array[TgtQRClass] of Integer;
  UnitChanged: Boolean;
  IsDFM: Boolean;

	function CopyFiles(AFileList: TStrings; const SrcPath,
		DestPath: string): Boolean;
	var
		Fo: TSHFileOpStruct;
		Buff: array[0..1024 * 32] of Char;
		P: PChar;
		I: Integer;
		SPath: string;

		procedure InitBuff;
		begin
			FillChar(Buff, SizeOf(Buff), #0);
			P := @Buff;
		end;

		procedure DoCopyFiles;
		begin
			FillChar(Fo, SizeOf(Fo), #0);
			Fo.Wnd := Handle;
			Fo.wFunc := FO_COPY;
			Fo.pFrom := @Buff;
			Fo.pTo := PChar(AppendTrailingBackslash(DestPath));
			Fo.fFlags := 0;
			Fo.lpszProgressTitle := 'Copying files to Backup folder...';
			Result := (SHFileOperation(Fo) = 0) and (
				Fo.fAnyOperationsAborted = False);
			InitBuff;
		end;

	begin
		Result := True;
		InitBuff;
		SPath := AppendTrailingBackslash(SrcPath);
		for I := 0 to AFileList.Count - 1 do
		begin
			//**** Copy in batches if there are too many files ****
			if (P - @Buff) + Length(SPath + AFileList[I]) + 2 > SizeOf(Buff) then
				DoCopyFiles;
			if not Result then Break;
			P := StrECopy(P, PChar(SPath + AFileList[I])) + 1;
		end;
		if Result then DoCopyFiles;
	end;

	procedure UpdateFileStatus(I: Integer; CurrFile: string);
	begin
		progFiles.Position := I + 1;
		progFiles.Update;
		lblFilesDone.Caption := Format('%d of %d', [I + 1, FFileCount]);
		lblFilesDone.Update;
		lblCurrentFile.Caption := CurrFile;
		lblCurrentFile.Update;
	end;

	procedure InitCountVars;
	var
		I: TgtQRClass;
	begin
		for I := Low(ClassNames) to High(ClassNames) do
		begin
			ChangeCount[I] := 0;
			TLabel(FindComponent('lblCount' + IntToStr(Ord(I)))).Caption := '0';
		end;
		ChangeSum := 0;
		lblSum.Caption := '0';
	end;

	procedure UpdateCounts;
	var
		I: TgtQRClass;
		Ctrl: TLabel;
	begin
		for I := Low(ClassNames) to High(ClassNames) do
    begin
      Ctrl := TLabel(FindComponent('lblCount' + IntToStr(Ord(I))));
      if Ctrl <> nil then
        Ctrl.Caption := IntToStr(ChangeCount[I]);
    end;
		lblSum.Caption := IntToStr(ChangeSum);
	end;

  procedure PrepareFileTypeList;
  begin
    FileTypeList := TStringList.Create;
    if cbxDFM.Checked then
      FileTypeList.Add('dfm');
    if cbxPAS.Checked then
      FileTypeList.Add('pas');
    if cbxCPP.Checked then
      FileTypeList.Add('cpp');
    if cbxH.Checked then
      FileTypeList.Add('h');
    if cbxOther1.Checked and (edOther1.Text <> '') then
      FileTypeList.Add(edOther1.Text);
    if cbxOther2.Checked and (edOther2.Text <> '') then
      FileTypeList.Add(edOther2.Text);
  end;

begin
	FileList := nil;
	Screen.Cursor := crHourGlass;
	btnStart.Enabled := False;
  PrepareFileTypeList;
    
	try
		if rbSingleFile.Checked then
		begin
			FileList := TStringList.Create;
			if FileExists(edSingleFile.Text) then
			begin
				FileList.Add(ExtractFileName(edSingleFile.Text));
				PathName := AppendTrailingBackslash(ExtractFilePath(edSingleFile.Text));
			end;
		end
		else
		begin
			PathName := AppendTrailingBackslash(edMultiFile.Text);
			if DirectoryExists(PathName) then
				Filelist := GetFilesInDirectory(PathName,
					FileTypeList.CommaText, faAnyFile - faDirectory);
		end;
		if (FileList = nil) or (FileList.Count = 0) then
		begin
			MessageDlg('No files to convert!'#13#10#13#10 +
				'Make sure the file/folder specified is correct', mtError, [mbOK], 0);
			Exit;
		end;

		//------------- Backup files before conversion -------------------
		if chbBackup.Checked then
		begin
			ForceDirectories(PathName + edBackupDir.Text);
			if not CopyFiles(FileList, PathName, PathName + edBackupDir.Text) then
				if MessageDlg('Backup operation did not complete successfully!' +
					'#13#10#13#10 Continue anyway?', mtConfirmation, [mbYes, mbNO], 0) =
						mrNo then
					Exit;
		end;

		//------------- Supply file name and get it converted ------------
		InitCountVars;
		FFileCount := FileList.Count;
		progFiles.Max := FFileCount;
    FileList.Sort;
		for I := 0 to FFileCount - 1 do
		begin
      if pos('.dfm',FileList[I]) <> 0 then
        IsDFM := True
      else
        IsDFM := False;

			UpdateFileStatus(I, FileList[I]);
			FileName := PathName + FileList[I];
			TempFile := ChangeFileExt(FileName, '.$$$');
			if FileExists(TempFile) then
				DeleteFile(TempFile);

      if (FileGetAttr(FileName) and faReadOnly) <> 0 then
        if MessageDlg(FileName + ' is marked read-only.' + #13#10 +
            'Continue anyway?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          FileSetAttr(FileName, FileGetAttr(FileName) - faReadOnly)
        else
          Continue;

			if IsDFMBinary(FileName) then
			begin
				DFM2TXT(FileName, TempFile);
				ConvertFile(TempFile, TempFile, progLines, lblLinesLeft,
					ChangeCount, ChangeSum, UnitChanged, IsDFM);
				TXT2DFM(TempFile, FileName);

			end
			else
			begin
				RenameFile(FileName, TempFile);
				ConvertFile(TempFile, FileName, progLines, lblLinesLeft,
					ChangeCount, ChangeSum, UnitChanged, IsDFM);
			end;
			FileExt := ExtractFileExt(FileName);
			UpdateCounts;
			DeleteFile(TempFile);
		end;

		MessageDlg('Gnostice QR => QR All Done!', mtInformation, [mbOK], 0);
	finally
		FileList.Free;
    FileTypeList.Free;
		Screen.Cursor := crDefault;
		btnStart.Enabled := True;
	end;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.cbxOther1Click(Sender: TObject);
begin
  edOther1.Enabled := cbxOther1.Checked;
end;

{------------------------------------------------------------------------------}

procedure TfrmMain.edOther1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (UpCase(Key) in ['A'..'Z', '0'..'9', #8]) then
    Key := #0;
end;

procedure TfrmMain.cbxOther2Click(Sender: TObject);
begin
  edOther2.Enabled := cbxOther2.Checked;
end;

end.
