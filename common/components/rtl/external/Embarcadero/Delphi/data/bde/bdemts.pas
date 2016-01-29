{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit bdemts;

{$H+,X+}

interface

implementation

uses Winapi.Mtx, Bde.DBTables;

function GetObjectContext: IUnknown;
var
  ObjectContext: IObjectContext;
begin
  try
    ObjectContext := Winapi.Mtx.GetObjectContext;
  except
    ;
  end;
  if Assigned(ObjectContext) then Result := ObjectContext
  else Result := nil;
end;

begin
  if not Assigned(GetObjectContextProc) then
    GetObjectContextProc := GetObjectContext;
end.
