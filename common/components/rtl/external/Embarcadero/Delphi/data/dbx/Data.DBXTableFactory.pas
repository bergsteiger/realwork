{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXTableFactory;

interface

uses
  Data.DBXCommonTable;

type
  TDBXTableFactory = class
    class function CreateDBXTable: TDBXTable; static;
  end;

implementation

uses
  Data.DBXDBReaders;

class function TDBXTableFactory.CreateDBXTable: TDBXTable;
begin
  Result := TDBXMemoryTable.Create;
end;

end.
