{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit System.StartUpCopy;

interface

implementation

uses
  System.SysUtils, System.IOUtils;

procedure CopyStartUpFiles;
var
  Source, Destination : string;

  procedure DoCopyFiles(const Src:string; const Dst: string);
  var
    SearchRec : TSearchRec;
    Res : Integer;
  begin
    Res := FindFirst(src + '*', faAnyFile, SearchRec);
    while Res = 0 do
    begin
      if (SearchRec.Attr and faDirectory) = faDirectory then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
        begin
          if ForceDirectories(Dst+SearchRec.Name) then
            // Do the recurse thing...
            DoCopyFiles(Src+SearchRec.Name+PathDelim, Dst+SearchRec.Name+PathDelim);
        end;
      end
      else begin
        if not FileExists(Dst+SearchRec.Name) then
        begin
          TFile.Copy(Src+SearchRec.Name, Dst+SearchRec.Name, false); // copy without overwriting.
        end
      end;
      Res := FindNext(SearchRec);
    end;
  end;
begin
  Source := ExtractFilePath(ParamStr(0)) + 'StartUp' + PathDelim;
  if DirectoryExists(Source) then
  begin
    Destination := GetHomePath+PathDelim;
    DoCopyFiles(Source, Destination);
  end;
end;

initialization
begin
  CopyStartUpFiles;
end;

end.
