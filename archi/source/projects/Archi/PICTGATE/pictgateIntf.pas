unit PictGateIntf;

interface

function  DocSrcImageID(aDocID : Integer) : Integer;
procedure GoImageURL(aDocID : Integer; aSrcImageID : Integer; aDocLen, aDocPos : Int64);

implementation
uses Windows;

 //function  DocSrcImageID(aDocID : Integer) : Integer; stdcall; external 'pictgate.dll' name 'DocSrcImageID';
 //procedure GoImageURL(aDocID : Integer; aSrcImageID : Integer; aDocLen, aDocPos : Int64); stdcall; external 'pictgate.dll' name 'GoImageURL';

type

 TdllDocSrcImageID = function (aDocID : Integer) : Integer; stdcall;
 TdllGoImageURL = procedure (aDocID : Integer; aSrcImageID : Integer;
                             aDocLen, aDocPos : Int64); stdcall;

const
 PGDLL : THandle = 0;

 dllDocSrcImageID : TdllDocSrcImageID = nil;
 dllGoImageURL : TdllGoImageURL = nil;

function  DocSrcImageID(aDocID : Integer) : Integer;
begin
 Result := 0;
 Try
  If Assigned(dllDocSrcImageID) then
   Result := dllDocSrcImageID(aDocID)
 except
 end;
end;

procedure GoImageURL(aDocID : Integer; aSrcImageID : Integer; aDocLen, aDocPos : Int64);
begin
 If Assigned(dllGoImageURL) then
  dllGoImageURL(aDocID, aSrcImageID, aDocLen, aDocPos);
end;

initialization
 PGDLL := LoadLibrary('pictgate.dll');
 If PGDLL <> 0 then
 begin
  dllDocSrcImageID := GetProcAddress(PGDLL, 'DocSrcImageID');
  dllGoImageURL    := GetProcAddress(PGDLL, 'GoImageURL');
 end;

finalization
 If PGDLL <> 0 then FreeLibrary(PGDLL);
end.


