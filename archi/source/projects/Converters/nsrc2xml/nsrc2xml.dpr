


program nsrc2xml;

{$APPTYPE CONSOLE}

uses
  EvdSchema,
  SysUtils,
  ddCmdLineUtils,
  l3FileUtils,
  ddFileIterator,
  ddNSRC_r,
  k2TagGen,
  l3Filer,
  evdXMLWriter,
  npbAttributesFilter,
  evdCommentFilter,
  l3Types,
  k2FileGenerator,
  k2Reader,
  l3ProtoObject,
  ddDocTypeDetector,
  DT_Types,
  ddZipUtils,
  StrUtils,
  ddFormula2PictureFilter,
  l3Base;

type
 TNSR2XMLCmdLine = class(TddCmdLine)
 private
  f_DataFolder: string;
  f_DestFolder: String;
  f_SrcFolder: string;
 protected
  procedure Init; override;
 public
  property DataFolder: string read f_DataFolder;
  property DestFolder: String read f_DestFolder;
  property SrcFolder: string read f_SrcFolder;
 end;

 TmcfrConverter = class(Tl3ProtoObject)
 private
  f_CmdLine: TNSR2XMLCmdLine;
  f_DestFiler: Tl3DOSFiler;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function ConvertFiles: Boolean;
  procedure Execute;
  procedure OnDocumentStart(Sender: TObject; TopicNo: Longint; FilerType: Byte;
      MainGroup: ShortString);
  procedure ZipResults;
 end;

 TmcfrFileNameMaker = class(TddDocTypeDetector)
 public
 end;




procedure TNSR2XMLCmdLine.Init;
begin
 inherited Init;
 AddFolder('src', 'Source folder', '', f_SrcFolder);
 AddString('dest', 'Destination folder', '', f_DestFolder);
 AddString('data', 'Data folder', '', f_DataFolder);
end;

constructor TmcfrConverter.Create;
begin
 inherited Create;
 f_CmdLine := TNSR2XMLCmdLine.Create(True);
end;

procedure TmcfrConverter.Cleanup;
begin
 inherited;
 FreeAndNil(f_CmdLine);
end;

function TmcfrConverter.ConvertFiles: Boolean;
var
 i: Integer;
 l_G: Tk2TagGenerator;
 l_SrcFiler: Tl3DOSFiler;
 l_Writer: Tk2CustomFileGenerator;
 l_Reader: Tk2CustomFileParser;
 l_TempFileName: String;
begin
 Result:= False;
 with f_CmdLine do
 begin
  if DirExists(SrcFolder) and ForceDirectories(DestFolder) then
  begin
   with TddFileIterator.Make(SrcFolder, '*.nsr') do
   try
    if FileList.Count > 0 then
    begin
     Writeln('Convert files...');
     l_TempFileName:= l3GetTempFileName('mcf');
     try
      l_SrcFiler:= Tl3DOSFiler.Create(nil);
      try
       f_DestFiler:= Tl3DOSFiler.Create(nil);
       try
        l_G:= nil;
        try
         TevdXMLWriter.SetTo(l_G);
         l_Writer:= TevdXMLWriter(l_G);
         TddFormula2PictureFilter.SetTo(l_G);
         TnpbAttributesFilter.SetTo(l_G);  // npbAttributesFilter
         TevdCommentFilter.SetTo(l_G); // evdCommentFilter
         // Тут нужно вставить генератор имени файла
         TmcfrFileNameMaker.SetTo(l_G);
         TmcfrFileNameMaker(l_G).OnStartDocument:= OnDocumentStart;
         TCustomNSRCReader.SetTo(l_G);
         l_Reader:= TCustomNSRCReader(l_G);
         TCustomNSRCReader(l_Reader).PictureDir:= DataFolder;

         for i:= 0 to Pred(FileList.Count) do
         begin
          if DataFolder = '' then
           TCustomNSRCReader(l_Reader).PictureDir:= ExtractFilePath(FileList[i]);
          l_SrcFiler.FileName:= FileList[i];
          l_SrcFiler.Mode:= l3_fmRead;
          l_Reader.Filer:= l_SrcFiler;

          f_DestFiler.FileName:= l_TempFileName;
          f_DestFiler.Mode:= l3_fmWrite;
          l_Writer.Filer:= f_DestFiler;

          l_Reader.Start;
          try
           TCustomNSRCReader(l_G).Read;
          finally
           l_Reader.Finish;
          end;
         end; // for i

        finally
         FreeAndNil(l_G);
        end;
       finally
        FreeAndNil(f_DestFiler);
       end;
      finally
       FreeAndNil(l_SrcFiler);
      end;
     finally
      DeleteFile(l_TempFileName);
     end;
     Result:= True;
    end; // for i
   finally
    Free;
   end; // TddFileIterator
  end;
 end;
end;

procedure TmcfrConverter.Execute;
begin
 with f_CmdLine do
 begin
  if NeedHelp then
   Writeln(HelpText)
  else
   ConvertFiles;
 end; // with 
end;

procedure TmcfrConverter.OnDocumentStart(Sender: TObject; TopicNo: Longint;
    FilerType: Byte; MainGroup: ShortString);
var
 l_Folder: String;
begin
 //l3System.Msg2Log('%d', [TopicNo]);
 if TDocType(TmcfrFileNameMaker(Sender).DocType) = dtObject then
  l_Folder:= ConcatDirName(f_CmdLine.DestFolder, 'attachments')
 else
  l_Folder:= ConcatDirName(f_CmdLine.DestFolder, 'documents');
 ForceDirectories(l_Folder);
 f_destFiler.FileName:= ConcatDirName(l_Folder, IntToStr(TopicNo)+IfThen(FilerType = 2, 'a', '')+'.xml');
 f_DestFiler.Mode:= l3_fmWrite;
end;

procedure TmcfrConverter.ZipResults;
var
 l_FileName: String;
 l_DateStr : String;
begin
 Writeln('Compress result...');
 DateTimeToString(l_DateStr, 'dd-mm-yyyy_hh_nn', Now);
 l_FileName:= ConcatDirName(f_CmdLine.DestFolder, 'garant_pack_'+l_DateStr) + '.zip';
 ZipFiles(l_FileName, f_CmdLine.DestFolder, '*.xml'{, True});
 DeleteFilesByMaskRecur(f_CmdLine.DestFolder, '*.xml');
end;

begin
 with TmcfrConverter.Create do
 try
  Execute
 finally
  Free;
 end;
end.

