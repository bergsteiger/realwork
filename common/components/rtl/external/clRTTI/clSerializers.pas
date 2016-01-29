unit clSerializers;
{
  clSerializers
  Author: Chris Lichti
  Updated: 4/8/2002
  First version: February 28, 2001

  This unit provides simple functions for saving and loading objects to/from
  an INI files and Registry trees.

  These functions all support the following property kinds:
      tkInteger, tkChar, tkString, tkLString, tkWString, tkEnumeration, tkSet,
      tkFloat, tkClass

  The support for tkClass includes support for both object reference properties
  and delegate objects, including TCollection descendants and TStrings.

  If you need these functions to work with an additional property type or
  class, please let me know via email. (chlichti@mindspring.com)

  This unit requires my RTTI Wrapper classes in clRTTI.pas

  The simplest possible way to use these functions is by calling the versions
  that take a pointer to any object and a string with a starting header in it.

  For example:
  IniSerializer.SaveObjToIniFile( MyObject, 'MyApp.ini', 'MyObject' );
  -and-
  IniSerializer.LoadObjFromIniFile( MyObject, 'MyApp.ini', 'MyObject' );

  or

  RegSerializer.SaveObjToRegistry( MyObject, 'Software\Mine\MyApp\MyObject' );
  -and-
  IniSerializer.LoadObjFromIniFile( MyObject, 'Software\Mine\MyApp\MyObject' );

  However, should you require more power over which properties are saved/loaded,
  or how the TIniFile or TRegistry is configured, you can use one of the
  overloaded versions of these functions which allow you to set up your own
  TIniFile or TRegistry and/or your own TrtWrapper object.

  For example:
  You can filter out property names and property kinds that get saved/loaded
  by creating your own instance of rtWrapper, setting the StopNames or
  VisibleKinds properties, and passing it to one of the overloaded versions
  of the save/load functions.

  These functions are object-centric.  If you are save/loading a class called
  TMyObject, and you later remove a property from TMyObject, these functions
  will simply not try to load the removed property.  If you later add a property
  and try to load an older version from the ini file, LoadObjFromIniFile will
  return a comma-separated list containing the missing property(ies).  You are
  then responsible for filling in default values for those missing properties,
  if necessary.  In most cases, it is easier to just fill all the properties
  of MyObject with defaults before calling LoadObjFromIniFile.  However, if
  you need to change values depending on other conditions, you can get at the
  missing properties like this:

  var
    slMissingProps: TStringList;
    rtMyObj: TrtWrapper;
    nProp: integer;
  begin
    slMissingProps := nil;
    rtMyObj := nil;
    try
      slMissingProps := TStringList.Create;
      slMissingProps.CommaText :=
        LoadObjFromIniFile( MyObject, 'MyApp\MyObject' );

      if slMissingProps.Count > 0 then
      begin
        rtMyObj := TrtWrapper.Create( MyObject );

        for nProp := 0 to slMissingProps.Count - 1 do
        begin
          rtMyObj[slMissingProps[nProp]].Value := //some default value
        end;
      end;
    finally
      rtMyObj.Free;
      slMissingProps.Free;
    end;
  end;
}


interface

uses clRTTI, classes, inifiles, registry, windows;

resourcestring
  ERR_OBJISNIL = '%s: %s cannot be nil';
  ERR_REGISTRY_NOOPENKEY = '%s: TRegistry object (%s) does not have an open key';
  ERR_REGISTRY_OPENKEY = '%s: Error opening key (%s)';
  ERR_NOVALINREGISTRY = '%s: Property value (%s) is not in the registry';

type
  TclAbstractSerializer = class
  protected
    function GetParentSection( sSectionName: string ): string; virtual;
    function FormatSubSection( sSectionName, sSubSection: string ): string; virtual;
    function ExtractSubSectionName( sSectionName: string ): string; virtual;
    //Abstract read/write functions to override
    procedure CreateSection( sSectionName: string ); virtual; abstract;
    procedure RemoveSection( sSectionName: string ); virtual; abstract;
    function SectionExists( sSectionName: string ): boolean; virtual; abstract;
    function ValueExists( sSectionName, sName: string ): boolean; virtual; abstract;
    procedure WriteString( sSectionName: string; sName: string; sValue: string ); virtual; abstract;
    procedure WriteDateTime( sSectionName: string; sName: string; fValue: double ); virtual; abstract;
    procedure WriteTime( sSectionName: string; sName: string; fValue: double ); virtual; abstract;
    procedure WriteDate( sSectionName: string; sName: string; fValue: double ); virtual; abstract;
    procedure WriteFloat( sSectionName: string; sName: string; fValue: double ); virtual; abstract;
    procedure WriteInteger( sSectionName: string; sName: string; nValue: integer ); virtual; abstract;
    function ReadString( sSectionName: string; sName: string): string; virtual; abstract;
    function ReadDateTime( sSectionName: string; sName: string): double; virtual; abstract;
    function ReadTime( sSectionName: string; sName: string): double; virtual; abstract;
    function ReadDate( sSectionName: string; sName: string): double; virtual; abstract;
    function ReadFloat( sSectionName: string; sName: string): double; virtual; abstract;
    function ReadInteger( sSectionName: string; sName: string): integer; virtual; abstract;
    //Internal serialization methods to call
    procedure DoSerializeFrom( Source: TObject; sSection: string ); overload; virtual;
    procedure DoSerializeFrom( Source: TrtWrapper; sSection: string ); overload; virtual;
    function DoDeserializeTo( Target: TObject; sSection: string ): string; overload; virtual;
    function DoDeserializeTo( Target: TrtWrapper; sSection: string ): string; overload; virtual;
  public
    constructor Create; virtual;
  end;

  TclIniSerializer = class( TclAbstractSerializer )
  protected
    IniFile: TIniFile;
    procedure CreateSection( sSectionName: string ); override;
    procedure RemoveSection( sSectionName: string ); override;
    function SectionExists( sSectionName: string ): boolean; override;
    function ValueExists( sSectionName, sName: string ): boolean; override;
    procedure WriteString( sSectionName: string; sName: string; sValue: string ); override;
    procedure WriteDateTime( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteTime( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteDate( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteFloat( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteInteger( sSectionName: string; sName: string; nValue: integer ); override;
    function ReadString( sSectionName: string; sName: string): string; override;
    function ReadDateTime( sSectionName: string; sName: string): double; override;
    function ReadTime( sSectionName: string; sName: string): double; override;
    function ReadDate( sSectionName: string; sName: string): double; override;
    function ReadFloat( sSectionName: string; sName: string): double; override;
    function ReadInteger( sSectionName: string; sName: string): integer; override;
  public
    //      Saving...
    procedure SaveObjToIniFile( Source: TObject; Target: TIniFile;
      IniSection: string); overload;
    procedure SaveObjToIniFile( Source: TObject; IniFilename, IniSection: string); overload;
    procedure SaveObjToIniFile( Source: TrtWrapper; IniFilename, IniSection: string); overload;
    procedure SaveObjToIniFile( Source: TrtWrapper; Target: TIniFile;
      IniSection: string); overload;
    //      Loading...
    function LoadObjFromIniFile( Target: TObject; IniFilename,
      IniSection: string ): string; overload;
    function LoadObjFromIniFile( Target: TrtWrapper; IniFilename,
      IniSection: string ): string; overload;
    function LoadObjFromIniFile( Source: TIniFile; IniSection: string; Target: TObject ): string; overload;
    function LoadObjFromIniFile( Source: TIniFile; IniSection: string; Target: TrtWrapper ): string; overload;
  end;

  TclRegSerializer = class( TclAbstractSerializer )
  protected
    //Registry Support
    slRegistries: TStringList;
    BaseReg: TRegistry;
    function GetRegForKey( sKey: string ): TRegistry;
    procedure CleanUpRegistries;
    procedure ClearKey(sKey: string);
    //Overrides
    procedure CreateSection( sSectionName: string ); override;
    procedure RemoveSection( sSectionName: string ); override;
    function SectionExists( sSectionName: string ): boolean; override;
    function ValueExists( sSectionName, sName: string ): boolean; override;
    procedure WriteString( sSectionName: string; sName: string; sValue: string ); override;
    procedure WriteDateTime( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteTime( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteDate( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteFloat( sSectionName: string; sName: string; fValue: double ); override;
    procedure WriteInteger( sSectionName: string; sName: string; nValue: integer ); override;
    function ReadString( sSectionName: string; sName: string): string; override;
    function ReadDateTime( sSectionName: string; sName: string): double; override;
    function ReadTime( sSectionName: string; sName: string): double; override;
    function ReadDate( sSectionName: string; sName: string): double; override;
    function ReadFloat( sSectionName: string; sName: string): double; override;
    function ReadInteger( sSectionName: string; sName: string): integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    //      Saving...
    procedure SaveObjToRegistry( Source: TObject; Target: TRegistry ); overload;
    procedure SaveObjToRegistry( Source: TObject; RegistryKey: string;
      RootKey: HKEY = HKEY_CURRENT_USER ); overload;
    procedure SaveObjToRegistry( Source: TrtWrapper; RegistryKey: string;
      RootKey: HKEY = HKEY_CURRENT_USER ); overload;
    procedure SaveObjToRegistry( Source: TrtWrapper; Target: TRegistry ); overload;

    //      Loading...
    function LoadObjFromRegistry( Target: TObject; RegistryKey: string;
      RootKey: HKEY = HKEY_CURRENT_USER ): string; overload;
    function LoadObjFromRegistry( Source: TRegistry; Target: TObject ): string; overload;
    function LoadObjFromRegistry( Source: TRegistry; Target: TrtWrapper ): string; overload;
  end;

function IniSerializer: TclIniSerializer;
function RegSerializer: TclRegSerializer;

implementation

uses typinfo, sysutils;

var
  FIniSerializer: TclIniSerializer;
  FRegSerializer: TclRegSerializer;

function IniSerializer: TclIniSerializer;
begin
  if not Assigned(FIniSerializer) then
  begin
    FIniSerializer := TclIniSerializer.Create;
  end;
  Result := FIniSerializer;
end;

function RegSerializer: TclRegSerializer;
begin
  if not Assigned(FRegSerializer) then
  begin
    FRegSerializer := TclRegSerializer.Create;
  end;
  Result := FRegSerializer;
end;


{ TclAbstractSerializer }

constructor TclAbstractSerializer.Create;
begin
  //stupid virtual base constructor that should be in TObject.  sigh...
end;

function TclAbstractSerializer.DoDeserializeTo(Target: TrtWrapper; sSection: string ): string;
  {
  LoadSubObject
  Loads a SubObject from the specified SubSection in the IniFile.

  This method provides any special handling required for special subobjects,
  such as TCollection and TStrings.
  }
  procedure LoadSubObject( SubSection: string; Instance: TObject );
  var
    SubWrapper: TrtWrapper;

    Strings: TStrings;
    nSLine: integer;

    Collection: TCollection;
    nCItem: integer;
    sCSubSection: string;
  begin
    if not Assigned( Instance ) then exit;
    SubWrapper := nil;
    try
      //Create a TrtWrapper and configure it with the same settings as Source
      SubWrapper := TrtWrapper.Create( Instance, Target.VisiblePropKinds );
      SubWrapper.StopNames := Target.StopNames;

      if Instance is TStrings then
      begin //Read in the Text property for TStrings
        Strings := TStrings( Instance );
        Strings.Clear;
        nSLine := 0;
        while ValueExists( SubSection, 'Line' + InttoStr(nSLine) ) do
        begin
          Strings.Add(ReadString( SubSection, 'Line' + InttoStr(nSLine)));
          inc(nSLine);
        end;
      end
      else  //Read in the entire object for everything else
        DoDeserializeTo( Instance, SubSection );

      //If the SubObject is a collection, read in the collection items
      if Instance is TCollection then
      begin
        Collection := TCollection( Instance );
        Collection.Clear;

        for nCItem := 0 to MaxInt do
        begin
          sCSubSection := 'CItem' + InttoStr( nCItem );
          if SectionExists( SubSection + '\' + sCSubSection ) then
          begin
            LoadSubObject( SubSection + '\' + sCSubSection, Collection.Add )
          end
          else break;
        end;
      end;

    finally
      SubWrapper.Free;
    end;
  end;
var
  Prop: TrtProperty;
  nProp: integer;
begin
  //Enforce assumptions
  Assert( Assigned( Target ),
    Format(ERR_OBJISNIL, ['DoDeserializeTo', 'Target'] ));

  Result := '';

  //Loop through the published properties of the object
  for nProp := 0 to Target.Count - 1 do
  begin
    Prop := Target.Items[nProp];

    if Prop.ReadOnly then continue;

    if (not ValueExists( sSection, Prop.Name )) and
      (not SectionExists( sSection + '\' + Prop.Name)) then
    begin
      if length(Result) > 0 then Result := Result + ',';
      Result := Result + Prop.Name;
      continue;
    end;

    //Load the property using the TIniFile method appropriate for the property kind.
    case Prop.Kind of
      tkInteger, tkChar: Prop.AsInteger := ReadInteger( sSection, Prop.Name );
      tkString, tkLString, tkWString, tkEnumeration, tkSet:
        begin
          Prop.AsString := ReadString( sSection, Prop.Name );
        end;
      tkFloat:
        begin
          if SameText( Prop.TypeInfo.Name, 'TDateTime' ) then
          begin
            Prop.AsFloat := ReadDateTime( sSection, Prop.Name );
          end
          else if SameText( Prop.TypeInfo.Name, 'TTime' ) then
          begin
            Prop.AsFloat := ReadTime( sSection, Prop.Name );
          end
          else if SameText( Prop.TypeInfo.Name, 'TDate' ) then
          begin
            Prop.AsFloat := ReadDate( sSection, Prop.Name );
          end
          else
            Prop.AsFloat := ReadFloat( sSection, Prop.Name );
        end;
      tkClass:
        begin
          if Prop.IsDelegate then
          begin
            LoadSubObject( sSection + '\' + Prop.Name, Prop.AsObject );
          end
          else
          begin
            if Prop.ObjClassType = TComponent then
            begin
              Prop.AsObject := rtFindGlobalComponent(
                ReadString( sSection, Prop.Name ) );
            end;
          end;
        end;
    end;
  end;
end;

function TclAbstractSerializer.DoDeserializeTo(Target: TObject; sSection: string ): string;
var
  TargetWrapper: TrtWrapper;
begin
  Assert( Assigned( Target ),
    Format(ERR_OBJISNIL, ['DoDeserializeTo', 'Target'] ));

  TargetWrapper := nil;
  try
    TargetWrapper := TrtWrapper.Create( Target );

    Result := DoDeserializeTo( TargetWrapper, sSection );
  finally
    TargetWrapper.Free;
  end;
end;

procedure TclAbstractSerializer.DoSerializeFrom(Source: TrtWrapper; sSection: string );
  {
  StoreSubObject
  Stores a SubObject in the specified SubSection in the IniFile.

  This method provides any special handling required for special subobjects,
  such as TCollection and TStrings.
  }
  procedure StoreSubObject( SubSection: string; SubObject: TObject );
  var
    SubWrapper: TrtWrapper;

    Strings: TStrings;
    nSLine: integer;

    Collection: TCollection;
    nCItem: integer;
  begin
    if not Assigned( SubObject ) then exit;
    SubWrapper := nil;
    try
      //Create a TrtWrapper and configure it with the same settings as Source
      SubWrapper := TrtWrapper.Create( SubObject, Source.VisiblePropKinds );
      SubWrapper.StopNames := Source.StopNames;

      RemoveSection( SubSection );
      CreateSection( SubSection );

      if SubObject is TStrings then
      begin  //Write out the text property of a TStrings
        Strings := TStrings( SubObject );
        for nSLine := 0 to Strings.Count - 1 do
          WriteString( SubSection, 'Line' + InttoStr(nSLine), Strings[nSLine] );
      end
      else  //Save the SubObject
        DoSerializeFrom( SubWrapper, SubSection );

      //If the SubObject is a collection, write out the collection items
      if SubObject is TCollection then
      begin
        //Create a section to indicate that the collection property's sub-
        //  items are stored.
        WriteString( SubSection, 'rt_TCollection', '1' );

        //Clear any existing collection item sections
        nCItem := 0;
        while SectionExists( FormatSubSection( SubSection, 'CItem' + InttoStr( nCItem ) ) ) do
        begin
          RemoveSection( FormatSubSection( SubSection, 'CItem' + InttoStr( nCItem ) ) );
          inc( nCItem );
        end;

        //Store collection items
        Collection := TCollection( SubObject );
        for nCItem := 0 to Collection.Count - 1 do
        begin
          StoreSubObject( FormatSubSection( SubSection, 'CItem' + InttoStr( nCItem ) ),
            Collection.Items[nCItem] );
        end;
      end;

    finally
      SubWrapper.Free;
    end;
  end;
var
  Prop: TrtProperty;
  nProp: integer;
begin
  //Enforce assumptions
  Assert( Assigned( Source ),
    Format(ERR_OBJISNIL, ['DoSerializeFrom', 'Source'] ));
  Assert( Assigned( Source.ObjInstance ),
    Format(ERR_OBJISNIL, ['DoSerializeFrom', 'Source wrapper''s object'] ));

  RemoveSection( sSection );

  //Loop through the published properties of the object
  for nProp := 0 to Source.Count - 1 do
  begin
    Prop := Source.Items[nProp];

    if Prop.ReadOnly then continue;

    //Save the property with the TIniFile method appropriate for the property kind.
    case Prop.Kind of
      tkInteger, tkChar: WriteInteger( sSection, Prop.Name, Prop.AsInteger );
      tkString, tkLString, tkWString, tkEnumeration, tkSet:
        begin
          WriteString( sSection, Prop.Name, Prop.AsString );
        end;
      tkFloat:
        begin
          if SameText( Prop.TypeInfo.Name, 'TDateTime' ) then
          begin
            WriteDateTime( sSection, Prop.Name, Prop.AsFloat );
          end
          else if SameText( Prop.TypeInfo.Name, 'TTime' ) then
          begin
            WriteTime( sSection, Prop.Name, Prop.AsFloat );
          end
          else if SameText( Prop.TypeInfo.Name, 'TDate' ) then
          begin
            WriteDate( sSection, Prop.Name, Prop.AsFloat );
          end
          else
            WriteFloat( sSection, Prop.Name, Prop.AsFloat );
        end;
      tkClass:
        begin
          if Prop.IsDelegate then
          begin
            StoreSubObject( FormatSubSection( sSection, Prop.Name), Prop.AsObject );
          end
          else
          begin
            if Prop.ObjClassType = TComponent then
            begin
              WriteString( sSection, Prop.Name, TComponent( Prop.AsObject ).Name );
            end;
          end;
        end;
    end;
  end;
end;

procedure TclAbstractSerializer.DoSerializeFrom(Source: TObject; sSection: string );
var
  SourceWrapper: TrtWrapper;
begin
  Assert( Assigned( Source ), Format(ERR_OBJISNIL, ['DoSerializeFrom', 'Source'] ));

  SourceWrapper := nil;
  try
    SourceWrapper := TrtWrapper.Create( Source );
    DoSerializeFrom( SourceWrapper, sSection );
  finally
    SourceWrapper.Free;
  end;
end;

function TclAbstractSerializer.GetParentSection(sSectionName: string): string;
begin
  Result := ExtractFilePath( sSectionName );
end;

function TclAbstractSerializer.FormatSubSection(sSectionName,
  sSubSection: string): string;
begin
  Result := sSectionName + '\' + sSubSection;
end;

function TclAbstractSerializer.ExtractSubSectionName(
  sSectionName: string): string;
begin
  Result := ExtractFileName( sSectionName );
end;

{ TclIniSerializer }

procedure TclIniSerializer.CreateSection(sSectionName: string);
begin
  //no need, since TIniFile will automatically create sections if we ask nicely.
end;

function TclIniSerializer.LoadObjFromIniFile(Source: TIniFile;
  IniSection: string; Target: TObject): string;
begin
  IniFile := Source;
  DoDeserializeTo( Target, IniSection );
end;

function TclIniSerializer.LoadObjFromIniFile(Source: TIniFile;
  IniSection: string; Target: TrtWrapper): string;
begin
  IniFile := Source;
  DoDeserializeTo( Target, IniSection );
end;

function TclIniSerializer.LoadObjFromIniFile(Target: TrtWrapper;
  IniFilename, IniSection: string): string;
var
  IniFile: TIniFile;
begin
  Assert( Assigned(Target),
    Format(ERR_OBJISNIL, ['LoadObjFromIniFile', 'Target'] ));

  IniFile := nil;
  try
    IniFile := TIniFile.Create( IniFilename );
    Result := LoadObjFromIniFile( IniFile, IniSection, Target );
  finally
    IniFile.Free;
  end;
end;

function TclIniSerializer.LoadObjFromIniFile(Target: TObject; IniFilename,
  IniSection: string): string;
var
  IniFile: TIniFile;
begin
  Assert( Assigned(Target),
    Format(ERR_OBJISNIL, ['LoadObjFromIniFile', 'Target'] ));

  IniFile := nil;
  try
    IniFile := TIniFile.Create( IniFilename );
    Result := LoadObjFromIniFile( IniFile, IniSection, Target )
  finally
    IniFile.Free;
  end;
end;

function TclIniSerializer.ReadDate(sSectionName, sName: string): double;
begin
  Result := IniFile.ReadDate( sSectionName, sName, 0 );
end;

function TclIniSerializer.ReadDateTime(sSectionName, sName: string): double;
begin
  Result := IniFile.ReadDateTime( sSectionName, sName, 0 );
end;

function TclIniSerializer.ReadFloat(sSectionName, sName: string): double;
begin
  Result := IniFile.ReadFloat( sSectionName, sName, 0 );
end;

function TclIniSerializer.ReadInteger(sSectionName, sName: string): integer;
begin
  Result := IniFile.ReadInteger( sSectionName, sName, 0 );
end;

function TclIniSerializer.ReadString(sSectionName, sName: string): string;
begin
  Result := IniFile.ReadString( sSectionName, sName, '' );
end;

function TclIniSerializer.ReadTime(sSectionName, sName: string): double;
begin
  Result := IniFile.ReadTime( sSectionName, sName, 0 );
end;

procedure TclIniSerializer.RemoveSection(sSectionName: string);
begin
  IniFile.EraseSection( sSectionName );
end;

procedure TclIniSerializer.SaveObjToIniFile(Source: TrtWrapper;
  Target: TIniFile; IniSection: string);
begin
  IniFile := Target;
  DoSerializeFrom( Source, IniSection );
end;

procedure TclIniSerializer.SaveObjToIniFile(Source: TObject;
  Target: TIniFile; IniSection: string);
begin
  IniFile := Target;
  DoSerializeFrom( Source, IniSection );
end;

procedure TclIniSerializer.SaveObjToIniFile(Source: TObject; IniFilename,
  IniSection: string);
var
  RObj: TrtWrapper;
begin
  Assert( Assigned( Source ), Format(ERR_OBJISNIL, ['SaveObjToIniFile', 'Source'] ));

  RObj := nil;
  try
    RObj := TrtWrapper.Create( Source );
    SaveObjToIniFile( RObj, IniFilename, IniSection )
  finally
    RObj.Free;
  end;
end;

procedure TclIniSerializer.SaveObjToIniFile(Source: TrtWrapper;
  IniFilename, IniSection: string);
var
  IniFile: TIniFile;
begin
  Assert( Assigned( Source ), Format(ERR_OBJISNIL, ['SaveObjToIniFile', 'Source'] ));

  IniFile := nil;
  try
    IniFile := TIniFile.Create(IniFilename);
    SaveObjToIniFile( Source, IniFile, IniSection )
  finally
    IniFile.Free;
  end;
end;

function TclIniSerializer.SectionExists(sSectionName: string): boolean;
begin
  Result := IniFile.SectionExists(sSectionName);
end;

function TclIniSerializer.ValueExists(sSectionName,
  sName: string): boolean;
begin
  Result := IniFile.ValueExists(sSectionName, sName);
end;

procedure TclIniSerializer.WriteDate(sSectionName, sName: string;
  fValue: double);
begin
  IniFile.WriteDate(sSectionName, sName, fValue);
end;

procedure TclIniSerializer.WriteDateTime(sSectionName, sName: string;
  fValue: double);
begin
  IniFile.WriteDateTime(sSectionName, sName, fValue);
end;

procedure TclIniSerializer.WriteFloat(sSectionName, sName: string;
  fValue: double);
begin
  IniFile.WriteFloat(sSectionName, sName, fValue);
end;

procedure TclIniSerializer.WriteInteger(sSectionName, sName: string;
  nValue: integer);
begin
  IniFile.WriteInteger(sSectionName, sName, nValue);
end;

procedure TclIniSerializer.WriteString(sSectionName, sName,
  sValue: string);
begin
  IniFile.WriteString(sSectionName, sName, sValue);
end;

procedure TclIniSerializer.WriteTime(sSectionName, sName: string;
  fValue: double);
begin
  IniFile.WriteTime(sSectionName, sName, fValue);
end;

{ TclRegSerializer }

procedure TclRegSerializer.CleanUpRegistries;
var
  Reg: TRegistry;
  i: integer;
begin
  for i := slRegistries.Count - 1 downto 0 do
  begin
    Reg := TRegistry(slRegistries.Objects[i]);
    Reg.CloseKey;
    Reg.Free;
    slRegistries.Delete(i);
  end;
end;

{
ClearKey
Completely remove the specified registry key
}
procedure TclRegSerializer.ClearKey(sKey: string);
var
  slKeys: TStringList;
  i: integer;
  Reg: TRegistry;
begin
  slKeys := nil;
  try
    slKeys := TStringList.Create;
    Reg := GetRegForKey( sKey );
    if Reg.OpenKey( sKey, false ) then
    begin
      //Remove all sub-keys
      Reg.GetKeyNames( slKeys );
      for i := 0 to slKeys.Count - 1 do
        ClearKey( sKey + '\' + slKeys[i] );

      //Close and delete the specified key
      Reg.CloseKey;
      if not Reg.DeleteKey( sKey ) then
        raise Exception.CreateFmt( 'Error deleting key (%s)', [sKey] );
    end;
  finally
    slKeys.Free;
  end;
end;

constructor TclRegSerializer.Create;
begin
  inherited;
  slRegistries := TStringList.Create;
end;

procedure TclRegSerializer.CreateSection(sSectionName: string);
begin
  GetRegForKey(sSectionName);
end;

destructor TclRegSerializer.Destroy;
begin
  slRegistries.Free;
  inherited;
end;

function TclRegSerializer.GetRegForKey(sKey: string): TRegistry;
begin
  //If one doesn't exist
  if slRegistries.IndexOf( sKey ) < 0 then
  begin //create it
    Result := TRegistry.Create;
    Result.RootKey := BaseReg.RootKey;
    Result.OpenKey( sKey, true );
    slRegistries.AddObject( sKey, Result );
  end
  else
  begin
    Result := TRegistry(slRegistries.Objects[slRegistries.IndexOf( sKey )]);
  end;
end;

function TclRegSerializer.LoadObjFromRegistry(Target: TObject;
  RegistryKey: string; RootKey: HKEY): string;
var
  Reg: TRegistry;
begin
  Assert( Assigned(Target),
    Format(ERR_OBJISNIL, ['LoadObjFromRegistry', 'Target'] ));

  Reg := nil;
  try
    Reg := TRegistry.Create;
    Reg.RootKey := RootKey;
    if Reg.OpenKey( RegistryKey, true ) then
      Result := LoadObjFromRegistry( Reg, Target )
    else
      raise Exception.CreateFmt( 'SaveObjToRegistry: Error opening key (%s)',
        [RegistryKey] );
  finally
    Reg.Free;
  end;
end;

function TclRegSerializer.LoadObjFromRegistry(Source: TRegistry;
  Target: TObject): string;
begin
  BaseReg := Source;
  Result := DoDeserializeTo( Target, Source.CurrentPath );
end;

function TclRegSerializer.LoadObjFromRegistry(Source: TRegistry;
  Target: TrtWrapper): string;
begin
  BaseReg := Source;
  Result := DoDeserializeTo( Target, Source.CurrentPath );
end;

function TclRegSerializer.ReadDate(sSectionName, sName: string): double;
begin
  Result := GetRegForKey( sSectionName ).ReadDate( sName );
end;

function TclRegSerializer.ReadDateTime(sSectionName,
  sName: string): double;
begin
  Result := GetRegForKey( sSectionName ).ReadDateTime( sName );
end;

function TclRegSerializer.ReadFloat(sSectionName, sName: string): double;
begin
  Result := GetRegForKey( sSectionName ).ReadFloat( sName );
end;

function TclRegSerializer.ReadInteger(sSectionName,
  sName: string): integer;
begin
  Result := GetRegForKey( sSectionName ).ReadInteger( sName );
end;

function TclRegSerializer.ReadString(sSectionName, sName: string): string;
begin
  Result := GetRegForKey( sSectionName ).ReadString( sName );
end;

function TclRegSerializer.ReadTime(sSectionName, sName: string): double;
begin
  Result := GetRegForKey( sSectionName ).ReadTime( sName );
end;

procedure TclRegSerializer.RemoveSection(sSectionName: string);
var
  Reg: TRegistry;
begin
  Reg := GetRegForKey( sSectionName );
  Reg.CloseKey;
  ClearKey( sSectionName );
  Reg.OpenKey( sSectionName, true );
end;

procedure TclRegSerializer.SaveObjToRegistry(Source: TObject;
  RegistryKey: string; RootKey: HKEY);
var
  RObj: TrtWrapper;
begin
  Assert( Assigned( Source ), Format(ERR_OBJISNIL, ['SaveObjToRegistry', 'Source'] ));

  RObj := nil;
  try
    RObj := TrtWrapper.Create( Source );
    SaveObjToRegistry( RObj, RegistryKey, RootKey )
  finally
    RObj.Free;
  end;
end;

procedure TclRegSerializer.SaveObjToRegistry(Source: TObject;
  Target: TRegistry);
begin
  BaseReg := Target;
  DoSerializeFrom( Source, BaseReg.CurrentPath );
end;

procedure TclRegSerializer.SaveObjToRegistry(Source: TrtWrapper;
  Target: TRegistry);
begin
  BaseReg := Target;
  DoSerializeFrom( Source, BaseReg.CurrentPath );
end;

procedure TclRegSerializer.SaveObjToRegistry(Source: TrtWrapper;
  RegistryKey: string; RootKey: HKEY);
var
  Reg: TRegistry;
begin
  Assert( Assigned( Source ), Format(ERR_OBJISNIL, ['SaveObjToRegistry', 'Source'] ));

  Reg := nil;
  try
    Reg := TRegistry.Create;
    Reg.RootKey := RootKey;
    if Reg.OpenKey( RegistryKey, true ) then
      SaveObjToRegistry( Source, Reg )
    else
      raise Exception.CreateFmt( ERR_REGISTRY_OPENKEY,
        ['SaveObjToRegistry', RegistryKey] );
  finally
    Reg.Free;
  end;
end;

function TclRegSerializer.SectionExists(sSectionName: string): boolean;
begin
  Result := GetRegForKey( GetParentSection( sSectionName ) ).KeyExists( ExtractSubSectionName( sSectionName ) );
end;

function TclRegSerializer.ValueExists(sSectionName,
  sName: string): boolean;
begin
  Result := GetRegForKey( sSectionName ).ValueExists( sName );
end;

procedure TclRegSerializer.WriteDate(sSectionName, sName: string;
  fValue: double);
begin
  GetRegForKey( sSectionName ).WriteDate( sName, fValue );
end;

procedure TclRegSerializer.WriteDateTime(sSectionName, sName: string;
  fValue: double);
begin
  GetRegForKey( sSectionName ).WriteDateTime( sName, fValue );
end;

procedure TclRegSerializer.WriteFloat(sSectionName, sName: string;
  fValue: double);
begin
  GetRegForKey( sSectionName ).WriteFloat( sName, fValue );
end;

procedure TclRegSerializer.WriteInteger(sSectionName, sName: string;
  nValue: integer);
begin
  GetRegForKey( sSectionName ).WriteInteger( sName, nValue );
end;

procedure TclRegSerializer.WriteString(sSectionName, sName,
  sValue: string);
begin
  GetRegForKey( sSectionName ).WriteString( sName, sValue );
end;

procedure TclRegSerializer.WriteTime(sSectionName, sName: string;
  fValue: double);
begin
  GetRegForKey( sSectionName ).WriteTime( sName, fValue );
end;

initialization
  FIniSerializer := nil;
  FRegSerializer := nil;
finalization
  FIniSerializer.Free;
  FRegSerializer.Free;

end.

