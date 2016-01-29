
{***************************************************************************}
{  AceExport => eDocEngine Ace Interface!                                   }
{  Conversion utility                                                       }
{                                                                           }
{  Copyright © 2000-2008 Gnostice Information Technologies Private Limited  }
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
  StdCtrls, Buttons, ComCtrls, ExtCtrls, StrUtils, FileCtrl, ShellAPI;

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
    progFiles: TProgressBar;
		Bevel4: TBevel;
		chbBackup: TCheckBox;
		edBackupDir: TEdit;
    cbxDFM: TCheckBox;
    cbxPAS: TCheckBox;
    cbxH: TCheckBox;
    OpenDialog: TOpenDialog;
		procedure btnStartClick(Sender: TObject);
		procedure btnSelectDirClick(Sender: TObject);
		procedure rbSingleFileClick(Sender: TObject);
		procedure rbFolderFilesClick(Sender: TObject);
		procedure btnSelectFileClick(Sender: TObject);
		procedure edPathChange(Sender: TObject);
		procedure FormCreate(Sender: TObject);

	private
		FFileCount: Integer;
		FCurrPathEdit: TEdit;

		procedure UpdateStartBtn;
	end;

var
	frmMain: TfrmMain;
  LeftPos: Integer;
  Resl: Integer;

implementation

{$R *.DFM}

type

	THackWinControl = class(TWinControl);

const

 OldClassNames: array[1..10] of string = (
    ': TgtAceExportPDF', ': TgtAceExportRTF', ': TgtAceExportHTML', ': TgtAceExportExcel',
    ': TgtAceExportText', ': TgtAceExportGIF', ': TgtAceExportJPEG', ': TgtAceExportBMP',
    ': TgtAceExportEMF', ': TgtAceExportWMF');
  NewClassNames: array[1..10] of string = (
    'object %s: TgtPDFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''pdf''' + #13#10 +
    '  FileDescription = ''Adobe PDF Files''' + #13#10 +
    '  ReferencePoint = rpBand' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET'  + #13#10 +
    '  Font.Color = clWindowText'  + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 ' + #13#10 +
    '  InputXRes = %d' + #13#10 +
    '  InputYRes = %d' + #13#10 +
    '  FontEncoding = feWinAnsiEncoding' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtRTFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''rtf''' + #13#10 +
    '  FileDescription = ''Rich Text Format''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifJPEG' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  Preferences.GraphicDataInBinary = False' + #13#10 +
    '  DocumentEncodingType = etPositionalAccuracy' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtHTMLEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''htm''' + #13#10 +
    '  FileDescription = ''HyperText Markup Language''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
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
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtExcelEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''xls''' + #13#10 +
    '  FileDescription = ''Microsoft Excel Workbook''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  ItemsToRender = [irText, irImage]' + #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  Preferences.AutoFormatCells = False' + #13#10 +
    '  Formatting.ColumnSpacing = -1' + #13#10 +
    '  Formatting.RowSpacing = -1' + #13#10 +
    '  Formatting.ScaleX = 1.000000000000000000 ' + #13#10 +
    '  Formatting.ScaleY = 1.000000000000000000' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifMetafile' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtTextEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''txt''' + #13#10 +
    '  FileDescription = ''Text Document''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  DefaultFont.Charset = DEFAULT_CHARSET' + #13#10 +
    '  DefaultFont.Color = clWindowText' + #13#10 +
    '  DefaultFont.Height = -11' + #13#10 +
    '  DefaultFont.Name = ''MS Sans Serif''' + #13#10 +
    '  DefaultFont.Style = []' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  PageEndLines = True' + #13#10 +
    '  ColumnSpacing = 1' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtGIFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''gif''' + #13#10 +
    '  FileDescription = ''Graphics Interchange Format''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtJPEGEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''jpg''' + #13#10 +
    '  FileDescription =''JPEG File Interchange Format''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end' ,
    'object %s: TgtBMPEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''bmp''' + #13#10 +
    '  FileDescription = ''Windows Bitmap''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''  ' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end',

    'object %s: TgtEMFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''emf''' + #13#10 +
    '  FileDescription = ''Enhanced Metafiles''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end ' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end ',

    'object %s: TgtWMFEngine' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  FileExtension = ''wmf''' + #13#10 +
    '  FileDescription = ''Windows Metafiles''' + #13#10 +
    '  ReferencePoint = rpBand'+ #13#10 +
    '  Font.Charset = DEFAULT_CHARSET' + #13#10 +
    '  Font.Color = clWindowText' + #13#10 +
    '  Font.Height = -11' + #13#10 +
    '  Font.Name = ''MS Sans Serif''' + #13#10 +
    '  Font.Style = []' + #13#10 +
    '  ImageSettings.SourceDPI = 96' + #13#10 +
    '  ImageSettings.OutputImageFormat = ifBMP' + #13#10 +
    '  Page.Width = 8.347500000000000000' + #13#10 +
    '  Page.Height = 11.805700000000000000' + #13#10 +
    '  Page.BinNumber = 0 '+ #13#10 +
    '  ScaleX = 1.000000000000000000' + #13#10 +
    '  ScaleY = 1.000000000000000000' + #13#10 +
    'end' + #13#10 +
    'object gtAceExportInterface%d: TgtAceExportInterface ' + #13#10 +
    '  DoBeginDoc = True' + #13#10 +
    '  DoEndDoc = True' + #13#10 +
    '  Left = %d' + #13#10 +
    '  Top = 100' + #13#10 +
    '  Engine = %s' + #13#10 +
    'end'
  );

  UnitNames: array[1..8] of string = ('gtClasses','gtUtils','gtConsts','gtHash',
    'gtPDFFont','gtDZLIB','gtPDFCrypt','gtFilters' );
{------------------------------------------------------------------------------}

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

procedure ConvertFile(SrcFile, DestFile: string; var IsDFM: Boolean);

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
      for K := 1 to 10 do
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
      Inc(I);
    end;
    dfmFile.SaveToFile(DestFile);
    dfmFile.Free;
  end;

  procedure ConvertPAS;
  var
    Myf: TStringList;
    tempstring1: string;
    tempstring: string;
    i,c : Integer;
    p,q,r: integer;
    infcnt : integer;
    S : string;
    procedure convert(oldstring,newstring :string);
    begin
      inc(infcnt);
      myf.Strings[i] := StringReplace(myf.Strings[I], oldstring, newstring, [rfIgnoreCase]);
      myf.Insert(i+1, '    gtAceExportInterface' + IntToStr(infcnt) + ': TgtAceExportInterface;');
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
    while(myf.text[p+4] <> ';') do
    begin
      tempstring1 :=tempstring1+myf.text[P+4];
      inc(p);
    end;

    tempstring := uppercase(tempstring1);
    //clasify doc and graphic
    if(pos('GTACEEXPORT_DOCUMENT',tempstring) > 0) then
    begin
      if(pos('GTACEEXPORT_GRAPHIC',tempstring) > 0) then
        r := 1
      else
        q := 1;
    end
    else if(pos('GTACEEXPORT_GRAPHIC',tempstring) > 0) then
    begin
      myf.text := StringReplace(myf.text, 'gtAceExport_Main',  //GTRPRENDER_MAIN
        'gtClasses, gtCstDocEng, gtCstGfxEng', [rfIgnoreCase]);
      myf.Text := StringReplace(myf.text, 'gtAceExport_Graphic',//GTRPRENDER_GRAPHIC',
        'gtXportIntf, gtAceXportIntf', [rfIgnoreCase]);
      myf.text := StringReplace(myf.text, 'gtAceExport_Document', '',//GTRPRENDER_DOCUMENT', '',
        [rfIgnoreCase]);
    end;

    //both d & g
    if(r = 1) then
    begin
      if((pos('GTACEEXPORT_PDF', tempstring) > 0) or
        (pos('GTACEEXPORT_RTF', tempstring) > 0) or
        (pos('GTACEEXPORT_HTML', tempstring) > 0)) then
      begin
        myf.text := StringReplace(myf.text, 'gtAceExport_Main',
          'gtClasses, gtCstDocEng, gtCstPlnEng', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Document',
          'gtXportIntf, gtAceXportIntf', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Graphic', 'gtCstGfxEng',
          [rfIgnoreCase]);
      end
      else
      begin
        myf.text := StringReplace(myf.text, 'gtAceExport_Main',
          'gtClasses, gtCstDocEng', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Document',
          'gtXportIntf, gtAceXportIntf', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Graphic',
          'gtCstGfxEng', [rfIgnoreCase]);
      end;
    end;
    // only doc
    if(q = 1) then
    begin
      if((pos('GTACEEXPORT_PDF', tempstring) > 0) or
        (pos('GTACEEXPORT_RTF', tempstring) > 0) or
        (pos('GTACEEXPORT_HTML', tempstring) > 0)) then
      begin
        myf.text := StringReplace(myf.text, 'gtAceExport_Main',
          'gtClasses, gtCstDocEng, gtCstPlnEng', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Document',
          'gtXportIntf, gtAceXportIntf', [rfIgnoreCase]);
      end
      else
      begin
        myf.text := StringReplace(myf.text, 'gtAceExport_Main',
          'gtClasses, gtCstDocEng', [rfIgnoreCase]);
        myf.text := StringReplace(myf.text, 'gtAceExport_Document',
          'gtXportIntf, gtAceXportIntf', [rfIgnoreCase]);
      end;
    end;

    //PDF
    if(pos('GTACEEXPORT_PDF', tempstring) > 0) then
      myf.text := StringReplace(myf.text,'gtAceExport_PDF',
        'gtCstPDFEng, gtExPDFEng, gtPDFEng', [rfIgnoreCase]);
    //RTF
    if(pos('GTACEEXPORT_RTF', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_RTF', 'gtRTFEng',
        [rfIgnoreCase]);
    //EXCEL
    if(pos('GTACEEXPORT_EXCEL', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_EXCEL',
        'gtCstSpdEng, gtCstXLSEng, gtExXLSEng, gtXLSEng', [rfIgnoreCase]);
    //HTML
    if(pos('GTACEEXPORT_HTML', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_HTML',
        'gtCstHTMLEng, gtExHTMLEng, gtHTMLEng', [rfIgnoreCase]);
    //TEXT
    if(pos('GTACEEXPORT_TEXT', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_Text', 'gtTXTEng',
        [rfIgnoreCase]);
    //GIF
    if(pos('GTACEEXPORT_GIF', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_GIF', 'gtGIFEng',
        [rfIgnoreCase]);
    //JPEG
    if(pos('GTACEEXPORT_JPEG', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_JPEG', 'gtJPEGEng',
        [rfIgnoreCase]);
    //BMP
    if(pos('GTACEEXPORT_BMP', tempstring) > 0) then
      myf.text := StringReplace(myf.text, 'gtAceExport_BMP', 'gtBMPEng',
        [rfIgnoreCase]);
    // EMF  &  WMF
    if((pos('GTACEEXPORT_EMF', tempstring) > 0) and
      (pos('GTACEEXPORT_WMF', tempstring) > 0)) then
    begin
      myf.text := StringReplace(myf.text, 'gtAceExport_EMF',
        'gtMetafileEng, gtEMFEng', [rfIgnoreCase]);
      myf.text := StringReplace(myf.text, 'gtAceExport_WMF', 'gtWMFEng',
        [rfIgnoreCase]);
    end
    else
    begin
      if(pos('GTACEEXPORT_EMF', tempstring) > 0) then
        myf.text := StringReplace(myf.text, 'gtAceExport_EMF',
          'gtMetafileEng, gtEMFEng', [rfIgnoreCase]);
      if(pos('GTACEEXPORT_WMF', tempstring) > 0) then
        myf.text := StringReplace(myf.text, 'gtAceExport_WMF',
          'gtMetafileEng, gtWMFEng', [rfIgnoreCase]);
    end;

    while (I <= myf.Count - 1) do
    begin
      if(pos(': TGTACEEXPORTPDF', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTPDF', ': TgtPDFEngine')
      else if(pos(': TGTACEEXPORTRTF', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTRTF', ': TgtRTFEngine')
      else if(pos(': TGTACEEXPORTEXCEL', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTEXCEL', ': TgtExcelEngine')
      else if(pos(': TGTACEEXPORTHTML' ,uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTHTML', ': TgtHTMLEngine')
      else if(pos(': TGTACEEXPORTTEXT', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTTEXT', ': TgtTextEngine')
      else if(pos(': TGTACEEXPORTGIF', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTGIF', ': TgtGIFEngine')
      else if(pos(': TGTACEEXPORTJPEG', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTJPEG', ': TgtJPEGEngine')
      else if(pos(': TGTACEEXPORTBMP', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTBMP', ': TgtBMPEngine')
      else if(pos(': TGTACEEXPORTEMF', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTEMF', ': TgtEMFEngine')
      else if(pos(': TGTACEEXPORTWMF', uppercase(myf.Strings[i])) > 0) then
        convert(': TGTACEEXPORTWMF', ': TgtWMFEngine');

      Inc(I);

      if(pos('IMPLEMENTATION', uppercase(myf.Strings[i])) > 0) then
        Break;
      S := Myf[I];
      for C := Low(UnitNames) to High(UnitNames) do
        S := StringReplace(S, UnitNames[C], UnitNames[C]+IntToStr(3), [rfReplaceAll]);
	  Myf[I] := S;
    end;
    Myf.SaveToFile(DestFile);
    Myf.Free;
  end;

begin
  if IsDFM  then
    ConvertDFM
  else
    ConvertPAS;
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
	FileList, FileTypeList: TStrings;
	I: Integer;
	TempFile, FileName, PathName: string;
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
	end;

  procedure PrepareFileTypeList;
  begin
    FileTypeList := TStringList.Create;
    if cbxDFM.Checked then
      FileTypeList.Add('dfm');
    if cbxPAS.Checked then
      FileTypeList.Add('pas');
    if cbxH.Checked then
      FileTypeList.Add('h');
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
		FFileCount := FileList.Count;
		progFiles.Max := FFileCount;
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
        ConvertFile(TempFile, TempFile, IsDFM);
        TXT2DFM(TempFile, FileName);
			end
			else
			begin

				RenameFile(FileName, TempFile);
				ConvertFile(TempFile, FileName, IsDFM);
			end;
			DeleteFile(TempFile);
		end;
		MessageDlg('All Done!' , mtInformation, [mbOK], 0);
	finally
		FileList.Free;
    FileTypeList.Free;
		Screen.Cursor := crDefault;
		btnStart.Enabled := True;
	end;
end;

{------------------------------------------------------------------------------}

initialization
  LeftPos := 25;
  Resl := Screen.PixelsPerInch;
finalization

end.
