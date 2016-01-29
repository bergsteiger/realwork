{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.WSDLLookup;

interface

function GetWSDLLookup: TInterfacedObject;

implementation

uses
  System.Classes, System.Generics.Collections, System.SysUtils,
  Soap.WSDLBind, Soap.WSDLItems;

type
  TWSDLLookup = class(TInterfacedObject, IWSDLLookup)
  private
    FLookup: TDictionary<string, Variant>;
  public
    constructor Create;
    destructor Destroy; override;

    { IWSDLLookup }
    procedure BuildWSDLLookup(WSDLItems: IWSDLItems; IterateProc: TWSDLIterateProc); overload;
    procedure BuildWSDLLookup(WSDLItems: IWSDLItems); overload;
    procedure ClearWSDLLookup;
    procedure Add(const URLLocation: string; WSDLItems: IWSDLItems);
    procedure AddImport(const URLLocation, ImportURLLocation: string);
    function  Contains(const URLLocation: string): Boolean;
    function  GetWSDLItems(const URLLocation: string): IWSDLItems;
    function  GetWSDLImportList(const URLLocation: string): TList<string>;
    function  IsEmpty: Boolean;
  end;


function GetWSDLLookup: TInterfacedObject;
begin
  Result := TWSDLLookup.Create;
end;

{ TWSDLLookup }

constructor TWSDLLookup.Create;
begin
  FLookup := TDictionary<string, Variant>.Create;
end;

destructor TWSDLLookup.Destroy;
begin
  ClearWSDLLookup;
  FLookup.Free;
  inherited;
end;

procedure TWSDLLookup.Add(const URLLocation: string; WSDLItems: IWSDLItems);
begin
  if not Contains(URLLocation) then
  begin
    FLookup.Add(URLLocation, WSDLItems);
  end;
end;

procedure TWSDLLookup.AddImport(const URLLocation, ImportURLLocation: string);
begin
  if not Contains(URLLocation) then
  begin
    FLookup.Add(URLLocation, ImportURLLocation);
  end;
end;

procedure TWSDLLookup.BuildWSDLLookup(WSDLItems: IWSDLItems; IterateProc: TWSDLIterateProc);

  function isHTTP(const Name: String): boolean;
  const
    sHTTPPrefix = 'http://';
    sHTTPsPrefix= 'https://';
  begin
    Result := SameText(Copy(Name, 1, Length(sHTTPPrefix)), sHTTPPrefix) or
              SameText(Copy(Name, 1, Length(sHTTPsPrefix)),sHTTPsPrefix);
  end;

  function GetFullPath(const Path: string): string;
  begin
    Result := Path;
    if IsHTTP(Path) then
      Exit;
    if FileExists(Path) then
    begin
      Result := ExpandFileName(Path);
      if Result = '' then
        Result := Path;
    end;
  end;

  { Returns path of SchemaLoc relative to its Referer }
  function GetRelativePath(const Referer, SchemaLoc: String): String;
  const
    sPathSep: WideChar = '/';
  var
    HTTPRef: Boolean;
    Path: String;
    Len: Integer;
  begin
    if IsHTTP(SchemaLoc) then
    begin
      Result := SchemaLoc;
      Exit;
    end;
    HTTPRef := IsHTTP(Referer);
    if (HTTPRef) then
    begin
      Len := High(Referer);
      while (Len >= Low(string)) do
      begin
        if (Referer[Len] = sPathSep) then
        begin
          Path := Copy(Referer, 0, Len+1-Low(string));
          Result := Path + SchemaLoc;
          Exit;
        end;
        Dec(Len);
      end;
    end;

    if FileExists(SchemaLoc) then
    begin
      Result := SchemaLoc;
      Path := ExpandFileName(SchemaLoc);
      if Path <> '' then
        Result := Path;
      Exit;
    end;

    Path := ExtractFilePath(SchemaLoc);
    if Path = '' then
    begin
      Path := ExtractFilePath(Referer);
      if Path <> '' then
      begin
        Result := ExpandFileName(Path + SchemaLoc);
        Exit;
      end;
    end;

    Result := SchemaLoc;
  end;

var
  Index: Integer;
  Imports: IImports;
  ImportWSDLItems: IWSDLItems;
  WSDLItemsObj: TWSDLItems;
  MyLoc, ImportLoc: string;
  Stream: TMemoryStream;
begin
  { Add myself to the list }
  WSDLItemsObj := WSDLItems.GetWSDLItems;
  MyLoc := GetFullPath(WSDLItemsObj.FileName);
  if not Assigned(IterateProc) then
  begin
    if not Contains(MyLoc) then
      Add(MyLoc, WSDLItemsObj);
  end;

  { Get my imports }
  Imports := WSDLItemsObj.Definition.Imports;
  if Imports <> nil then
  begin
    for Index := 0 to Imports.Count -1 do
    begin
      ImportLoc := GetRelativePath(MyLoc, Imports[Index].Location);
      if Assigned(IterateProc) then
        IterateProc(ioBeforeLoad, nil, nil, ImportLoc);
      if not Contains(ImportLoc) then
      begin
        Stream := TMemoryStream.Create;
        try
          WSDLItems.GetWSDLItems.StreamLoader.Load(ImportLoc, Stream);
          ImportWSDLItems := TWSDLItems.Create(WSDLItemsObj, nil);
          ImportWSDLItems.GetWSDLItems.LoadFromStream(Stream);
          if HasDefinition(ImportWSDLItems) then
          begin
            ImportWSDLItems.GetWSDLItems.FileName := ImportLoc;
            Add(ImportLoc, ImportWSDLItems);
            BuildWSDLLookup(ImportWSDLItems.GetWSDLItems);
          end
          else
          begin
            // Here we probably have a Schema imported directly
            // by a WSDL document, unusual and not WS-I compliant but happens!
            AddImport(ImportLoc, MyLoc);
          end;
        finally
          Stream.Free;
        end;
      end;
    end;
  end;
end;

procedure TWSDLLookup.BuildWSDLLookup(WSDLItems: IWSDLItems);
begin
  BuildWSDLLookup(WSDLItems, TWSDLIterateProc(nil));
end;

procedure TWSDLLookup.ClearWSDLLookup;
begin
  FLookup.Clear;
end;

function TWSDLLookup.Contains(const URLLocation: string): Boolean;
begin
  Result := FLookup.ContainsKey(URLLocation);
end;

function TWSDLLookup.GetWSDLImportList(const URLLocation: string): TList<string>;
var
  AKey: string;
begin
  Result := TList<string>.Create;
  for AKey in FLookup.Keys do
  begin
    if (URLLocation = '') or (GetWSDLItems(AKey) <> nil) then
      Result.Add(AKey);
  end;
end;

function TWSDLLookup.GetWSDLItems(const URLLocation: string): IWSDLItems;
var
  V: Variant;
begin
  Result := nil;
  if Contains(URLLocation) then
  begin
    V := FLookup[URLLocation];
    if (TVarData(V).VType = varUnknown) then
      Result := IUnknown(TVarData(V).VUnknown) as IWSDLItems;
  end;
end;

function TWSDLLookup.IsEmpty: Boolean;
begin
  Result := FLookup.Count = 0;
end;


end.
