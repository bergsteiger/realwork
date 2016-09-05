program evd2html;

{ $Id: evd2html.dpr,v 1.9 2016/06/15 11:42:47 dinishev Exp $ }

{$I evDefine.inc}
{$I ProjectDefine.inc}

uses
  SysUtils,
  l3Types,
  l3Base,
  l3Chars,
  l3ConInd,
  l3Filer,
  l3String,
  l3FileUtils,
  k2TagGen,
  k2Reader,
  ddHTMLWriter,
  ddProfNewsHTMLWriter,
  ddNSRC_r,
  evdReader,
  ddDocTypeDetector,
  evCommentDecorator,
  ddPipeOutInterfaces,
  e2hCommentsFilter in 'e2hCommentsFilter.pas';

{$R *.res}
{$R versioninfo.res}

{$IfDef Delphi3}
{$APPTYPE CONSOLE}
{$EndIf Delphi3}

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;

procedure BadParams(const aMsg: string);
begin
 Writeln(DS(aMsg));
 Writeln;
 Writeln(DS('�������������: evd2html [-<����> [-<����>...]] <������� ����> [<���������� ��� ����������>]'));
 Writeln(DS('��������� �����:'));
 Writeln(DS('  -n  -  ������� ���� ������� NSRC (�� ��������� ��������� EVD)'));
 Writeln(DS('  -e  -  ������������ ������� ������ �� ��������� ������'));
 Writeln(DS('  -t  -  �������� ��� ����������� �����������'));
 Writeln(DS('  -c  -  ������� CSS (�� ��������, ����������� link �� garantdoc.css)'));
 ExitCode := 1;
end;

var
 InFileNameIndex : Long;
 Switch          : String;
 InFiler,
 OutFiler      : TevDOSFiler;
 G             : Tk2TagGenerator;
 Indicator     : Tl3ConsoleIndicator;
 Dt            : TDateTime;
 l_InFileName  : string;
 l_OutDir      : string;
 l_IsNSRC      : Boolean;
 l_ExtLinks    : Boolean;
 l_SkipTechComm  : Boolean;
 l_ExternalCSS : Boolean;
 NoTopicIdx    : Integer;

procedure DoOnNewDocument(Sender: TObject; TopicNo: Longint; aPart: TddExportDocPart; MainGroup: ShortString);
var
 l_FN: string;
 l_Written: Integer;
begin
 l_Written := OutFiler.Pos;
 if OutFiler.Opened then
  OutFiler.Close;
 if l_Written = 0 then
  DeleteFile(OutFiler.FileName); // ���� ���� ��������� ������, �������
 if TopicNo > 0 then
  l_FN := IntToStr(TopicNo)
 else
 begin
  Inc(NoTopicIdx);
  l_FN := ChangeFileExt(ExtractFileName(l_InFileName), '') + '_' + IntToStr(NoTopicIdx);
 end;

 OutFiler.FileName := ConcatDirName(l_OutDir, l_FN + '.html');
 OutFiler.Mode := l3_fmWrite;
 OutFiler.Open;
end;


begin
 Writeln('Everest and NSRC to HTML converter, (c) 2015-2016 Garant Service');
 Writeln;
 InFileNameIndex := 1;
 l_IsNSRC := False;
 l_ExtLinks := False;
 l_SkipTechComm := False;
 l_ExternalCSS := False;
 while (InFileNameIndex < ParamCount) do
 begin
  Switch := ParamStr(InFileNameIndex);
  if (Switch[1] = cc_Minus) then
  begin
   Inc(InFileNameIndex);
   case Switch[2] of
    'n', 'N': l_IsNSRC := True;
    'e', 'E': l_ExtLinks := True;
    't', 'T': l_SkipTechComm := True;
    'c', 'C': l_ExternalCSS := True;
   else
    BadParams(Format('����������� ����� (%s) � ����������', [Switch[2]]));
    Exit;
   end;
  end
  else
   break;
 end;{while InFileNameIndex..}
 l_InFileName := Trim(ParamStr(InFileNameIndex));
 l_OutDir := Trim(ParamStr(Succ(InFileNameIndex)));
 if (l_InFileName = '') then
 begin
  BadParams('�� ������ ������� ����');
  Exit;
 end;
 if not FileExists(l_InFileName) then
 begin
  BadParams(Format('���� %s �� ������.', [l_InFileName]));
  Exit;
 end;
 if not l_IsNSRC and AnsiSameText('.nsr', ExtractFileExt(l_InFileName)) then
  l_IsNSRC := True;
 if l_OutDir = '' then
  l_OutDir := GetCurrentDir;
 G := nil;
 NoTopicIdx := 0;
 InFiler := TevDOSFiler.Create(nil);
 try
  Indicator := Tl3ConsoleIndicator.Create;
  try
   Indicator.NeedProgressProc := true;
   InFiler.Indicator := Indicator;
   InFiler.Filename := l_InFileName;
   OutFiler := TevDOSFiler.Create(nil);
   try
    OutFiler.Filename := '#doc.html'; // ��� �����, ����� �� ���������� �����
    OutFiler.Mode := l3_fmWrite;
    try
     if l_ExternalCSS then
      TddProfNewsHTMLWriter.SetTo(G)
     else
      TddHTMLGenerator.SetTo(G);
     TddHTMLGenerator(G).Filer := OutFiler;
     TddHTMLGenerator(G).UseExternalLinks := l_ExtLinks;
     if not l_ExternalCSS then
	     TevCommentDecorator.SetTo(G);
     TddDocTypeDetector.SetTo(G);
     TddDocTypeDetector(G).OnStartDocumentProc := DoOnNewDocument;
     if l_SkipTechComm then
      Te2hCommentsFilter.SetTo(G);
     if l_IsNSRC then
      TCustomNSRCReader.SetTo(G)
     else
      TevdNativeReader.SetTo(G);
     Tk2CustomFileParser(G).Filer := InFiler;
     Dt := Now;
     try
      Tk2CustomFileParser(G).Execute;
     except
      on E: Exception do
      begin
       Writeln;
       Writeln(DS(Format('��������� ������: %s', [E.Message])));
       ExitCode := 1;
      end;
     end; // try..except
     Dt := Now - Dt;
     WriteLn;
     WriteLn(DS('����� ���������: ' + TimeToStr(Dt)));
    finally
     FreeAndNil(G);
    end;
   finally
    FreeAndNil(OutFiler);
   end;
  finally
   FreeAndNil(Indicator);
  end;
 finally
  FreeAndNil(InFiler);
 end;
 //Readln;
end.
