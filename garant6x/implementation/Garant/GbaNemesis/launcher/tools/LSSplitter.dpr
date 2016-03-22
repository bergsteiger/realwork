program LSSplitter;

{$APPTYPE CONSOLE}
{$R *.RES}

uses
 Windows
 , SysUtils
 , Classes
 ;

function AnsiToOEM(const a_String: string): string;
begin
 SetLength(Result, Succ(Length(a_String)));
 CharToOemBuff(PChar(a_String), PChar(Result), Length(Result));
 //
 Result := PChar(Result); // remove last `\x0`
end;

function RemoveFinalSlash(const a_String: string): string;
var
 l_Length: Integer;
begin
 Result := a_String;
 //
 l_Length := Length(Result);
 if ((l_Length > 0) and (Result[l_Length] = '\')) then
  SetLength(Result, Pred(l_Length));
end;

procedure SplitLSFile(const a_LSFile: string; const a_Folder: string);
var
 l_Stream: TStream;
 //
 l_IntegerSize: Byte;
 l_Length: Integer;
 l_Name: string;
 l_Size: Int64;
begin
 if (FileExists(a_LSFile)) then
 begin
  if (not(DirectoryExists(a_Folder)) and not(ForceDirectories(a_Folder))) then
  begin
   WriteLN(Format('ERROR: Can not create folder "%s"', [a_Folder]));
   Abort;
  end
  else
  begin
   l_Stream := TFileStream.Create(a_LSFile, fmOpenRead+fmShareDenyNone);
   try
    with l_Stream do
     repeat
      ReadBuffer(l_IntegerSize, SizeOf(l_IntegerSize));
      //
      if (l_IntegerSize = $FF) then
       Break;
      //
      if (SizeOf(l_Length) <= l_IntegerSize) then
      begin
       l_Length := 0; // full bytes cleanup
       //
       ReadBuffer(l_Length, l_IntegerSize);
      end
      else
      begin
       WriteLN(Format('ERROR: Unsupported size (%d) of INTEGER type', [l_IntegerSize]));
       Abort;
      end;
      //
      SetLength(l_Name, l_Length);
      ReadBuffer(PChar(l_Name)^, l_Length);
      l_Name := PChar(l_Name); // remove last `\0`
      //
      ReadBuffer(l_Size, SizeOf(l_Size));
      //
      WriteLN(Format('INFO: Found file "%s"', [l_Name]));
      //
      with TFileStream.Create(Format('%s\%s', [a_Folder, l_Name]), fmCreate) do
       try
        CopyFrom(l_Stream, l_Size);
       finally
        Free;
       end;
     until (Position > Size);
   finally
    FreeAndNil(l_Stream);
   end;
  end;
 end
 else
 begin
  WriteLN(Format('ERROR: LSFile "%s" does not exist', [a_LSFile]));
  Abort;
 end;
end;

var
 l_Folder: string;
 l_LSFile: string;
begin
 WriteLN;
 WriteLN(Format('TOOL "%s" (C) SIE "GARANT-SERVICE-UNIVERSITY" LLC, 1990-2016', [ExtractFileName(ParamStr(0))]));
 //
 try
  if (ParamCount >= 1) then
  begin
   l_LSFile := ParamStr(1);
   //
   if (ParamCount > 1) then
    l_Folder := RemoveFinalSlash(ParamStr(2))
   else
    l_Folder := '.';
   //
   WriteLN;
   WriteLN('Current options:');
   WriteLN(Format('  LSFile: "%s"', [l_LSFile]));
   WriteLN(Format('  Folder: "%s"', [l_Folder]));
   WriteLN;
   //
   SplitLSFile(l_LSFile, l_Folder);
   //
   WriteLN;
   WriteLN('LSFile splitted successfully');
  end
  else
  begin
   WriteLN;
   WriteLN('Available options:');
   WriteLN('  <ls_file> [path_to_folder]');
   WriteLN;
   //
   ExitCode := 1;
  end;
 except
  on EAbort do ExitCode := -1;
  on E: Exception do
  begin
   WriteLN(AnsiToOEM(E.Message));
   //
   ExitCode := -1;
  end;
 end;
end.
