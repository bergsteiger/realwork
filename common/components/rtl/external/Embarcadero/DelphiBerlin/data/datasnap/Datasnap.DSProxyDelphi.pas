{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Datasnap.DSProxyDelphi;

interface

uses Datasnap.DSProxyWriter;

type
  TDSCustomExtendedProxyWriter = class abstract(TDSCustomProxyWriter)
  protected
    function GetClassNameSuffix: string; virtual;
  public
    function GetProxyClassNames: TArray<string>; virtual;
  end;

implementation

uses
  Datasnap.DSCommonProxy;


{ TDSCustomExtendedProxyWriter }

function TDSCustomExtendedProxyWriter.GetClassNameSuffix: string;
begin
  Result := 'Client';
end;

function TDSCustomExtendedProxyWriter.GetProxyClassNames: TArray<string>;
var
  Item: TDSProxyClass;
begin
  SetLength(Result, 0);
  Item := Metadata.Classes;
  while Item <> nil do
  begin
    if IncludeClass(Item) then
    begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := Item.ProxyClassName + GetClassNameSuffix;
    end;
    Item := Item.Next;
  end;
end;

end.
