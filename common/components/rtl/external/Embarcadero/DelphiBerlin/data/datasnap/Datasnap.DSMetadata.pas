{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSMetadata;

interface

uses
  System.Classes, Datasnap.DSCommonProxy;

type
  TDSCustomMetaDataProvider = class(TComponent)
  public
    function HasProvider: Boolean; virtual;
    function GetProvider: IDSProxyMetaDataLoader; virtual;
  end;


implementation

{ TDSCustomMetaDataProvider }

function TDSCustomMetaDataProvider.GetProvider: IDSProxyMetaDataLoader;
begin
  Result := nil;
end;

function TDSCustomMetaDataProvider.HasProvider: Boolean;
begin
  Result := True;
end;

end.
