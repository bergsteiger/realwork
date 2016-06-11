{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit uMRUList;

interface

uses
  uRESTObjects;



const
  MRUDBFILE = 'mru.dat';  // do not localize
  MRUCAPACITY = 40;

type
  TMRUList = class(TObject)
  private
    FItems : TRESTRequestParamsObjectList;
    FAutoSave : boolean;
    FFilename : string;
  public
    constructor Create( const AFilename : string = '' ); overload;
    destructor Destroy; override;

    procedure Clear;

    procedure AddItem( AItem : TRESTRequestParams );
    function ContainsItem( const AURL : string ) : boolean;
    function RemoveItem( const AURL : string ) : boolean;

    procedure SaveToFile( const AFilename : string = '' );
    procedure LoadFromFile( const AFilename : string = '' );

    property AutoSave : boolean read FAutoSave write FAutoSave;
    property Items : TRESTRequestParamsObjectList read FItems;
  end;


implementation

uses System.JSON, System.SysUtils, System.Classes;

{ TMRUList }

procedure TMRUList.AddItem( AItem : TRESTRequestParams );
var LItem : TRESTRequestParams;
begin
  Assert( Assigned(AItem) );

  /// we do not want duplicates in the mru-list
  if ContainsItem( AItem.ToString ) then
    RemoveItem( AItem.ToString );

  /// ensure that we do not exceed the desired capacity
  if (FItems.Count > MRUCAPACITY) then
    FItems.Delete( FItems.Count-1 );

  LItem:= TRESTRequestParams.Create;
  LItem.Assign( AItem );

  /// as this is a MRU-list, we want the most recent item on top
  FItems.Insert( 0, LItem );


  if FAutoSave then
    SaveToFile;
end;

procedure TMRUList.Clear;
begin
  FItems.Clear;
end;

function TMRUList.ContainsItem( const AURL : string ) : boolean;
var LItem : TRESTRequestParams;
begin
  result:= FALSE;
  for LItem IN FItems do
  begin
    if SameText(LItem.ToString, AURL) then
    begin
      result:= TRUE;
      BREAK;
    end;
  end;
end;

constructor TMRUList.Create( const AFilename : string = '' );
begin
  inherited Create;

  FFilename:= AFilename;
  FAutoSave:= (FFilename <> '');

  FItems:= TRESTRequestParamsObjectList.Create;
  FItems.OwnsObjects:= TRUE;

  if (FFilename <> '') AND FileExists(FFilename) then
    LoadFromFile( FFilename );
end;

destructor TMRUList.Destroy;
begin
  Clear;
  FreeAndNIL( FItems );

  inherited;
end;

procedure TMRUList.LoadFromFile( const AFilename : string = '' );
var LStream : TStringStream;
    LRoot : TJSONArray;
    LItem : TRESTRequestParams;
    LFilename : string;
    i : integer;
begin
  Clear;

  if (AFilename <> '') then
    LFilename:= AFilename
  else
    LFilename:= FFilename;

  if (LFilename = '') OR (NOT FileExists(LFilename)) then
    EXIT;

  LStream:= TStringStream.Create;
  TRY
    LStream.LoadFromFile( LFilename );

    LRoot:= TJSONObject.ParseJSONValue( LStream.DataString ) AS TJSONArray;
    for i:= 0 to LRoot.Count - 1 do
    begin
      LItem:= TRESTRequestParams.Create;
      LItem.FromJSONObject( LRoot.Items[i] AS TJSONObject );
      FItems.Add( LItem );
    end;

  FINALLY
    FreeAndNIL( LStream );
  END;


  LRoot:= TJSONArray.Create;
  TRY
    for LItem IN FItems do
      LRoot.Add( LItem.AsJSONObject );
  FINALLY
    FreeAndNIL( LRoot );
  END;
end;

function TMRUList.RemoveItem( const AURL : string ) : boolean;
var LItem : TRESTRequestParams;
begin
  result:= FALSE;

  for LItem IN FItems do
  begin
    if SameText(LItem.ToString, AURL) then
    begin
      FItems.Remove( LItem );
      result:= TRUE;
      BREAK;
    end;
  end;

  if FAutoSave then
    SaveToFile;
end;

procedure TMRUList.SaveToFile( const AFilename : string = '' );
var LStream : TStringStream;
      LRoot : TJSONArray;
      LItem : TRESTRequestParams;
      LFilename : string;
begin

  if (AFilename <> '') then
    LFilename:= AFilename
  else
    LFilename:= FFilename;

  if (LFilename = '') then
    EXIT;

  LRoot:= TJSONArray.Create;
  TRY
    for LItem IN FItems do
      LRoot.Add( LItem.AsJSONObject );

    LStream:= TStringStream.Create( LRoot.ToString );
    TRY
      LStream.SaveToFile( LFilename );
    FINALLY
      FreeAndNIL( LStream );
    END;

  FINALLY
    FreeAndNIL( LRoot );
  END;
end;

end.
