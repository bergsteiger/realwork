unit clRTTI;
{
Author: Chris Lichti
Email:  chlichti@mindspring.com
February 2, 2001

clRTTI is a utility unit that wraps Delphi's Run-Time Type Information in
a set of easy-to-use classes:

TrtWrapper
This class takes a class or object in its constructor and provides access to
properties in a manner similar to TTable.  For example, here is the code to
make every control on a form that can support a Popup menu use PopupMenu1:

  var
    RTObj: TrtWrapper;
    i: integer;
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      RTObj := TrtWrapper.Create(Components[i]);

      if RTObj.HasProperty('PopupMenu') then
        RTObj['PopupMenu'].AsObject := PopupMenu1;

      RTObj.Free;
    end;
  end;

And here is the code to get strings for the enumeration values of the Align
property of any TControl.  Notice that no created instance is required for this:

  var
    Prop: TrtProperty;
    i: integer;
  begin
    Prop := TrtProperty.Create( TControl, 'Align' );

    for i := 0 to Prop.EnumNames.Count - 1 do
    begin
      ShowMessage( Prop.EnumNames[i] );
    end;
  end;

TrtProperty
This class represents an individual published property of a class or object.
It provides a simple interface for checking attributes of the property, and it
provides convenient and familiar 'AsSomething' properties to get and set the
Property's value.  Here's an extension of the previous example, this time with
TrtProperty:

  var
    RTObj: TrtWrapper;
    Prop: TrtProperty;
    i, j: integer;
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      RTObj := TrtWrapper.Create(Components[i]);

      for j := 0 to RTObj.Count - 1 do
      begin
        Prop := RTObj.Items[j];

        //set all fonts to match the form font, regardless of property name
        if Prop.Kind = tkClass then
        begin
          if Prop.PropClassType.InheritsFrom( TFont ) then
            Prop.AsObject := Font;
        end;
      end;

      RTObj.Free;
    end;
  end;
}

interface

uses typinfo, Classes, SysUtils, contnrs;

type
  TStringArray = array of string;

  {
  Record types used by TrtProperty to wrap TypeData
  }
  PrtParamData = ^TrtParamData;
  TrtParamData = record
    Flags: TParamFlags;
    ParamName: ShortString;
    TypeName: ShortString;
  end;
  TrtMethodData = record
    MethodKind: TMethodKind;
    ParamCount: Byte;
    ParamList: array of TrtParamData;
    ResultType: ShortString;
  end;

  {
  TrtProperty is a class the represents a single property's RTTI.
  }
  TrtProperty = class
  private
    function GetReadOnly: boolean;
  protected
    FEnumNames: TStringList;
    FSetNames: TStringList;
    procedure VerifyWritable;

    function GetAsString: string;
    function GetAsFloat: extended;
    function GetAsInt64: int64;
    function GetAsInteger: integer;
    function GetAsMethod: TMethod;
    function GetAsObject: TObject;
    function GetAsVariant: Variant;
    function GetName: string;
    function GetValue: Variant;
    procedure SetAsFloat( const Value: extended );
    procedure SetAsInt64( const Value: int64 );
    procedure SetAsInteger( const Value: integer );
    procedure SetAsMethod( const Value: TMethod );
    procedure SetAsObject( const Value: TObject );
    procedure SetAsString( const Value: string );
    procedure SetAsVariant( const Value: Variant );
    procedure SetValue( const Value: Variant );

    function GetTypeKind: TTypeKind;
    function GetEnumNames: TStrings;
    function GetSetNames: TStrings;
    function GetPropClassType: TClass;
    function GetIsDelegate: boolean;
    function GetIsStored: boolean;
  public
    Instance: TObject;
    ObjClassType: TClass;
    TypeData: PTypeData;
    TypeInfo: PTypeInfo;
    PropInfo: PPropInfo;
    constructor Create( APropInfo: PPropInfo ); overload; virtual;
    constructor Create( AObject: TObject; propName: string ); overload; virtual;
    constructor Create( AClass: TClass; propName: string ); overload; virtual;
    destructor Destroy; override;

    //Getting and Setting the Property's Value
    property AsString: string read GetAsString write SetAsString;
    property AsInteger: integer read GetAsInteger write SetAsInteger;
    property AsInt64: int64 read GetAsInt64 write SetAsInt64;
    property AsFloat: extended read GetAsFloat write SetAsFloat;
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property Value: Variant read GetValue write SetValue;

    //Direct access to commonly used type information
    //The name of the property
    property Name: string read GetName;
    //The type kind of the property
    property Kind: TTypeKind read GetTypeKind;
    //If the property is an enumerated type, this string list contains string
    //  representations of the possible enumerator values.
    property EnumNames: TStrings read GetEnumNames;
    //If the property is a set type, this string list contains string
    //  representations of the possible set member values.
    property SetNames: TStrings read GetSetNames;
    //If the property is a set type, returns true if the set includes a member
    //  of the given type.
    function SetHasMember( MemberStr: string ): boolean;
    //If the property is a class type, returns the class type.
    property PropClassType: TClass read GetPropClassType;
    //If the property is a class type, it could be a reference or a delegate.
    //  This property returns true if the property is a delegate.
    property IsDelegate: boolean read GetIsDelegate;
    //Returns true if the property is going to be stored (isn't the default
    //  value)
    property IsStored: boolean read GetIsStored;
    //Returns true if the property is read-only.
    property ReadOnly: boolean read GetReadOnly;
    //Returns a TrtMethodData record, my own record for encapsulating method
    //  information.
    function MethodData: TrtMethodData;
    //A helper function to help determine how many characters would be
    //  needed to store all possible values of the property.  This is
    //  only works for Enumeration and Set types.
    function MaxStringLen: integer;
  end;

  {
  TrtPropertyList is a container class for TrtProperty instances.  It helps
  TrtWrapper (below) keep track of and clean up after instances of
  TrtPropertyList.
  }
  TrtPropertyList = class( TObjectList )
  private
    function GetItem( Index: Integer ): TrtProperty;
    procedure SetItem( Index: Integer; const Value: TrtProperty );
  public
    constructor Create; virtual;
    function Add( ArtPropObj: TrtProperty ): Integer;
    function Remove( ArtPropObj: TrtProperty ): Integer;
    property Items[Index: Integer]: TrtProperty read GetItem write SetItem; default;
  end;

  {
  TrtWrapper

  TrtWrapper is an object that is meant to parallel any object instance or class,
  providing random access to any of the published property type information
  of that instance or class.

  This class uses RTTI to navigate the published
  properties of an instance or class.  I encapsulates the logic of
  navigating specific property kinds (VisiblePropKinds), while avoiding
  properties of specific names (StopNames)
  }
  TrtWrapper = class
  protected
    nAllCount, nCount: integer;
    FVisiblePropKinds: TTypeKinds;
    FStopNames: TStringList;
    FMethods: TStringList;
    bInternalStopNameChange: boolean;

    FPropObjects: TrtPropertyList;

    FObjInstance: TObject;

    procedure SetStopNames( const Value: TStrings );
    procedure SetVisiblePropKinds( const Value: TTypeKinds );
    function GetStopNames: TStrings;
    procedure SetObjInstance( const Value: TObject );
    function GetMethods: TStringList;

    function NextAllIndexFromAllIndex( AllIndex: integer ): integer; virtual;
    function CreatePropertyObject( Index: integer ): TrtProperty;
    function GetPropertyObject( Index: integer ): TrtProperty;

    function GetItemByName( Name: string ): TrtProperty;
    function GetItemByIndex( index: integer ): TrtProperty;

    procedure StopNamesChanged( Sender: TObject );

    procedure Initialize; virtual;

    property PropertyObjects[index: integer]: TrtProperty read GetPropertyObject;
  public
    ObjClass: TClass;
    ObjTypeData: PTypeData;
    ObjTypeInfo: PTypeInfo;
    ObjPropList: PPropList;
    VisiblePropInfos: array of PPropInfo;

    constructor Create; overload; virtual;
    constructor Create( AClass: TClass; PropKinds: TTypeKinds = [] ); overload; virtual;
    constructor Create( AObject: TObject; PropKinds: TTypeKinds = [] ); overload; virtual;
    constructor Create( AClass: TClass; PropKinds: TTypeKinds; StopNames: array of string ); overload; virtual;
    constructor Create( AObject: TObject; PropKinds: TTypeKinds; StopNames: array of string ); overload; virtual;
    destructor Destroy; override;

    //Returns the number of properties that the wrapper is exposing with the
    // Items property, after filtering based on visible PropKinds and StopNames.
    function Count: integer;

    //Returns the total number of properties in the class or object being
    // wrapper <b>before</b> any filtering is done.
    function AllCount: integer;

    //Returns true if the wrapped class or object has a property of the given
    //  name. (includes all properties, not just the filtered properties)
    function HasProperty( PropertyName: string ): boolean;

    //The property kinds exposed by the wrapper. This is the value passed as
    //  the "PropKinds" parameter to the constructor. It can be changed at any time.
    property VisiblePropKinds: TTypeKinds read FVisiblePropKinds write SetVisiblePropKinds;

    //The names of properties to be removed from the list of properties exposed
    //  by the wrapper. This list can be modified at any time.
    property StopNames: TStrings read GetStopNames write SetStopNames;

    //Returns an instance of TrtProperty wrapping the property specified by
    //  name. This is the default property of the wrapper, to allow easy access.
    property ItemsByName[Name: string]: TrtProperty read GetItemByName; default;

    //Returns an instance of TrtProperty wrapping the property specified by
    //  index into the list of exposed properties. Use the Count method to
    //  iterate through this property.
    property Items[index: integer]: TrtProperty read GetItemByIndex;

    //The object instance being wrapped. This can be nil if the wrapper is
    //  wrapping a class. This property can be modified at any time, so a
    //  single wrapper can be re-used to work on multiple objects.
    property ObjInstance: TObject read FObjInstance write SetObjInstance;

    //Returns a TStringList populated with the published method names and
    //  pointers to the actual methods (stored in the "Objects" property of
    //  TStringList).
    property Methods: TStringList read GetMethods;
  end;

//Global Utility Functions
//Copies the values or published properties from one TPersistent to another
//  TPersistent. This is similar to the default cloning behavior in java.
procedure AssignSomePublishedProps( Src, Dest: TPersistent; PropKinds: TTypeKinds;
  StopNames: array of string ); // Don't overload due to Delphi 5 bug
procedure AssignPublishedProps( Src, Dest: TPersistent; PropKinds: TTypeKinds = [] );
//Find a component in the scope of all forms and data modules.
//  (Adapted from Borland's hidden version)
function rtFindGlobalComponent( const Name: string ): TComponent;
//Access a singleton TList of all the components in the scope of all forms and data modules.
function rtGlobalComponentList: TList;
//Convert a type kind into its string representation.
function TypeKindToStr( Kind: TTypeKind ): string;
//Get a list of published methods for a given class or object
procedure GetMethodList( FromClass: TClass; MethodList: TStrings ); overload;
procedure GetMethodList( AObject: TObject; MethodList: TStrings ); overload;
//Get/Set the string value of a property for an object
function GetPropertyString( Obj: TObject; sPropName: string ): string;
procedure SetPropertyString( Obj: TObject; sPropName: string; Value: string );

resourcestring
  ERR_NOINSTANCE = 'This method cannot be called without an object instance.  ' +
    'Construct the RTTI object by passing an object instance to the constructor.';
  ERR_READONLY = 'Cannot set a read-only property.';

implementation

uses Forms;

var
  FrtGlobalComponentList: TList; //Singleton accessed by rtGlobalComponentList

//---------- Internal Utility Functions ------------

{
GetSetString
  Since GetSetProp does not initialize Result to an empty string, I must do so
  for it.  silly bug...
}

function GetSetString( Obj: TObject; pInfo: PPropInfo; Brackets: boolean ): string;
begin
  SetLength( Result, 0 );
  Result := GetSetProp( Obj, pInfo, Brackets );
end;

{
GetEnumNamesFromTypeInfo
  Fill the TStrings with the enumeration names described in TypeInfo's TypeData
}

procedure GetEnumNamesFromTypeInfo( TypeInfo: PTypeInfo; sl: TStrings );
var
  TypeData: PTypeData;
  nValue: integer;
begin
  sl.Clear;
  TypeData := GetTypeData( TypeInfo );
  for nValue := TypeData.MinValue to TypeData.MaxValue do
  begin
    sl.AddObject( GetEnumName( TypeInfo, nValue ), TObject( nValue ) );
  end;
end;

//---------- Global Utility Functions ------------

{
rtFindGlobalComponent
  Find a component in the scope of all forms and data modules.
    (Adapted from Borland's hidden version)
}

function rtFindGlobalComponent( const Name: string ): TComponent;
var
  I: Integer;
begin
  for I := 0 to Screen.FormCount - 1 do
  begin
    Result := Screen.Forms[I];
    if not ( csInline in Result.ComponentState ) and
      ( CompareText( Name, Result.Name ) = 0 ) then Exit;
    Result := Result.FindComponent( Name );
    if Assigned( Result ) then Exit;
  end;
  for I := 0 to Screen.DataModuleCount - 1 do
  begin
    Result := Screen.DataModules[I];
    if CompareText( Name, Result.Name ) = 0 then Exit;
    Result := Result.FindComponent( Name );
    if Assigned( Result ) then Exit;
  end;
  Result := nil;
end;

procedure AssignPublishedProps( Src, Dest: TPersistent; PropKinds: TTypeKinds = [] );
begin
  AssignSomePublishedProps( Src, Dest, PropKinds, [] );
end;


procedure AssignSomePublishedProps( Src, Dest: TPersistent; PropKinds: TTypeKinds;
  StopNames: array of string );
var
  rtSource, rtDest: TrtWrapper;
  nSrcProp: Integer;
  pSrcProp, pDestProp: TrtProperty;
begin
  rtSource := nil;
  rtDest := nil;
  try
    rtSource := TrtWrapper.Create( Src, PropKinds, StopNames );
    rtDest := TrtWrapper.Create( Dest, PropKinds, StopNames );
    for nSrcProp := 0 to rtSource.Count - 1 do
    begin
      pSrcProp := rtSource.PropertyObjects[nSrcProp];
      pDestProp := rtDest.GetItemByName( pSrcProp.Name );
      if pDestProp <> nil then
      begin
        pDestProp.AsVariant := pSrcProp.AsVariant;
      end;
    end;
  finally
    rtSource.Free;
    rtDest.Free;
  end;
end;

{
rtGlobalComponentList
  Access a singleton TList of all the components in the scope of all forms and
  data modules.
}

function rtGlobalComponentList: TList;
var
  nContainer, nComp: Integer;
  Comp: TComponent;
  List: TList;
  procedure AddComp( AComp: TComponent );
  begin
    if List.IndexOf( AComp ) < 0 then
      List.Add( AComp );
  end;
begin
  if not Assigned( FrtGlobalComponentList ) then
  begin
    FrtGlobalComponentList := TList.Create;
  end;
  List := FrtGlobalComponentList;
  List.Clear;
  for nContainer := 0 to Screen.FormCount - 1 do
  begin
    Comp := Screen.Forms[nContainer];
    AddComp( Comp );
    for nComp := 0 to Comp.ComponentCount - 1 do
    begin
      AddComp( Comp.Components[nComp] );
    end;
  end;
  for nContainer := 0 to Screen.DataModuleCount - 1 do
  begin
    Comp := Screen.DataModules[nContainer];
    AddComp( Comp );
    for nComp := 0 to Comp.ComponentCount - 1 do
    begin
      AddComp( Comp.Components[nComp] );
    end;
  end;
  Result := List;
end;

{
TypeKindToStr
  Convert a type kind into its string representation.
}

function TypeKindToStr( Kind: TTypeKind ): string;
begin
  case Kind of
    tkUnknown: Result := 'tkUnknown';
    tkInteger: Result := 'tkInteger';
    tkChar: Result := 'tkChar';
    tkEnumeration: Result := 'tkEnumeration';
    tkFloat: Result := 'tkFloat';
    tkString: Result := 'tkString';
    tkSet: Result := 'tkSet';
    tkClass: Result := 'tkClass';
    tkMethod: Result := 'tkMethod';
    tkWChar: Result := 'tkWChar';
    tkLString: Result := 'tkLString';
    tkWString: Result := 'tkWString';
    tkVariant: Result := 'tkVariant';
    tkArray: Result := 'tkArray';
    tkRecord: Result := 'tkRecord';
    tkInterface: Result := 'tkInterface';
    tkInt64: Result := 'tkInt64';
    tkDynArray: Result := 'tkDynArray';
  end;
end;

//  Get a list of published methods for a given class or object

procedure GetMethodList( AObject: TObject; MethodList: TStrings ); overload;
begin
  GetMethodList( AObject.ClassType, MethodList );
end;

procedure GetMethodList( FromClass: TClass; MethodList: TStrings ); overload;
type
  PPointer = ^Pointer;
  PMethodRec = ^TMethodRec;
  TMethodRec = packed record
    wSize: Word;
    pCode: Pointer;
    sName: ShortString;
  end;
var
  MethodTable: PChar;
  AClass: TClass;
  MethodRec: PMethodRec;
  wCount: Word;
  nMethod: integer;
begin
  MethodList.Clear;
  AClass := FromClass;

  while AClass <> nil do
  begin
    //Get a pointer to the class's published method table
    MethodTable := PChar( Pointer( PChar( AClass ) + vmtMethodTable )^ );

    if MethodTable <> nil then
    begin
      //Get the count of the methods in the table
      Move( MethodTable^, wCount, 2 );

      //Position the MethodRec pointer at the first method in the table
        //(skip over the 2-byte method count)
      MethodRec := PMethodRec( MethodTable + 2 );

      //Iterate through all the published methods of this class
      for nMethod := 0 to wCount - 1 do
      begin
        //Add the method name and address to the MethodList TStrings
        MethodList.AddObject( MethodRec.sName, MethodRec.pCode );
        //Skip to the next method
        MethodRec := PMethodRec( PChar( MethodRec ) + MethodRec.wSize );
      end;
    end;
    //Get the ancestor (parent) class
    // The easy way:
    AClass := AClass.ClassParent;
  end;
end;

function GetPropertyString( Obj: TObject; sPropName: string ): string;
var
  Prop: TrtProperty;
begin
  Prop := nil;
  try
    Prop := TrtProperty.Create( Obj, sPropName );

    Result := Prop.AsString;
  finally
    Prop.Free;
  end;
end;

procedure SetPropertyString( Obj: TObject; sPropName: string; Value: string );
var
  Prop: TrtProperty;
begin
  Prop := nil;
  try
    Prop := TrtProperty.Create( Obj, sPropName );

    Prop.AsString := Value;
  finally
    Prop.Free;
  end;
end;

{ TrtProperty }

constructor TrtProperty.Create( AObject: TObject; propName: string );
var
  APropInfo: PPropInfo;
begin
  Instance := AObject;
  ObjClassType := AObject.ClassType;
  APropInfo := GetPropInfo( AObject, propName );
  Create( APropInfo );
end;

constructor TrtProperty.Create( APropInfo: PPropInfo );
begin
  PropInfo := APropInfo;
  TypeInfo := APropInfo^.PropType^;
  TypeData := GetTypeData( TypeInfo );
  FEnumNames := nil;
  FSetNames := nil;
end;

function TrtProperty.MaxStringLen: integer;
  function TotalLenWithCommas( sl: TStrings ): integer;
  var
    nStr: integer;
  begin
    Result := 0;
    for nStr := 0 to sl.Count - 1 do
      Result := Result + length( sl[nStr] ) + 1;
  end;
  function MaxStrLen( sl: TStrings ): integer;
  var
    nStr: integer;
  begin
    Result := 0;
    for nStr := 0 to sl.Count - 1 do
      if length( sl[nStr] ) > Result then
        Result := length( sl[nStr] );
  end;
begin
  Result := -1;
  case Kind of
    tkSet: Result := TotalLenWithCommas( SetNames );
    tkEnumeration: Result := MaxStrLen( EnumNames ) + 1;
  end;
end;

constructor TrtProperty.Create( AClass: TClass; propName: string );
var
  APropInfo: PPropInfo;
begin
  APropInfo := GetPropInfo( AClass, propName );
  ObjClassType := AClass;
  Create( APropInfo );
end;

destructor TrtProperty.Destroy;
begin
  if Assigned( FEnumNames ) then FEnumNames.Free;
  if Assigned( FSetNames ) then FSetNames.Free;
  inherited;
end;

function TrtProperty.GetAsFloat: extended;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := GetFloatProp( Instance, PropInfo );
end;

function TrtProperty.GetAsInt64: int64;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := GetInt64Prop( Instance, PropInfo );
end;

function TrtProperty.GetAsInteger: integer;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  case Kind of
    tkEnumeration: Result := GetEnumValue( TypeInfo, GetEnumProp( Instance, PropInfo ) );
  else
    Result := GetOrdProp( Instance, PropInfo );
  end;
end;

function TrtProperty.GetAsMethod: TMethod;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := GetMethodProp( Instance, PropInfo );
end;

function TrtProperty.GetAsObject: TObject;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := GetObjectProp( Instance, PropInfo );
end;

function TrtProperty.GetAsString: string;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  case Kind of
    tkEnumeration: Result := GetEnumProp( Instance, PropInfo );
    tkSet: Result := GetSetString( Instance, PropInfo, true );
  else
    Result := GetStrProp( Instance, PropInfo );
  end;
end;

function TrtProperty.GetAsVariant: Variant;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );

  // Don't use GetVariantProp; it doesn't do type checking - it assumes it's a variant
  Result := GetPropValue( Instance, Name );
end;

function TrtProperty.GetEnumNames: TStrings;
var
  nValue: integer;
begin
  if not Assigned( FEnumNames ) then
  begin
    FEnumNames := TStringList.Create;
    for nValue := TypeData.MinValue to TypeData.MaxValue do
    begin
      FEnumNames.Add( GetEnumName( TypeInfo, nValue ) );
    end;
  end;
  Result := FEnumNames;
end;

function TrtProperty.GetIsDelegate: boolean;
begin
  Result := PropClassType.InheritsFrom( TPersistent ) and
    ( not PropClassType.InheritsFrom( TComponent ) );
end;

function TrtProperty.GetIsStored: boolean;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := IsStoredProp( Instance, PropInfo );
end;

function TrtProperty.GetName: string;
begin
  Result := PropInfo^.Name;
end;

function TrtProperty.GetPropClassType: TClass;
resourcestring
  ERR_MUSTBETKCLASS = 'PropClassType property is only valid for tkClass properties';
begin
  Assert( Kind = tkClass, ERR_MUSTBETKCLASS );
  Result := TypeData.ClassType;
end;

function TrtProperty.MethodData: TrtMethodData;
type
  PParamFlags = ^TParamFlags;
var
  nParam: integer;

  ParamBuf: PChar;
  function ReadNextStr: string;
  begin
    Result := PShortString( ParamBuf )^;
    Inc( ParamBuf, length( Result ) + 1 );
  end;
begin
  Result.MethodKind := TypeData.MethodKind;
  Result.ParamCount := TypeData.ParamCount;

  SetLength( Result.ParamList, Result.ParamCount );

  ParamBuf := @TypeData.ParamList[0];
  for nParam := 0 to Result.ParamCount - 1 do
  begin
    Result.ParamList[nParam].Flags := PParamFlags( ParamBuf )^;
    Inc( ParamBuf, sizeof( TParamFlags ) );

    Result.ParamList[nParam].ParamName := ReadNextStr;

    Result.ParamList[nParam].TypeName := ReadNextStr;
  end;

  if Result.MethodKind in [mkFunction, mkClassFunction] then
  begin
    Result.ResultType := ReadNextStr;
  end
  else
    Result.ResultType := '';
end;

function TrtProperty.SetHasMember( MemberStr: string ): boolean;
resourcestring
  ERR_MUSTBETKSET = 'SetHasMember property is only valid for tkSet properties';
var
  nMemberIdx: integer;
  slSetValue: TStringList;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Assert( Kind = tkSet, ERR_MUSTBETKSET );

  Result := false;
  slSetValue := nil;
  try
    slSetValue := TStringList.Create;

    nMemberIdx := SetNames.IndexOf( MemberStr );
    if nMemberIdx < 0 then
      raise Exception.CreateFmt( 'SetHasMember: Unknown Member String (%s)', [MemberStr] );

    slSetValue.CommaText := Copy( AsString, 2, length( AsString ) - 2 );

    Result := ( slSetValue.IndexOf( MemberStr ) > -1 );
  finally
    slSetValue.Free;
  end;
end;

function TrtProperty.GetSetNames: TStrings;
var
  enumTypeInfo: PTypeInfo;
begin
  if not Assigned( FSetNames ) then
  begin
    FSetNames := TStringList.Create;
    enumTypeInfo := TypeData^.CompType^;
    if enumTypeInfo^.Kind = tkEnumeration then
      GetEnumNamesFromTypeInfo( enumTypeInfo, FSetNames );
  end;
  Result := FSetNames;
end;

function TrtProperty.GetReadOnly: boolean;
begin
  Result := not Assigned( PropInfo.SetProc );
end;

function TrtProperty.GetTypeKind: TTypeKind;
begin
  Result := TypeInfo^.Kind;
end;

function TrtProperty.GetValue: Variant;
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  Result := GetPropValue( Instance, Name );
end;

procedure TrtProperty.SetAsFloat( const Value: extended );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  SetFloatProp( Instance, PropInfo, Value );
end;

procedure TrtProperty.SetAsInt64( const Value: int64 );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  SetInt64Prop( Instance, PropInfo, Value );
end;

procedure TrtProperty.SetAsInteger( const Value: integer );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  case Kind of
    tkEnumeration: SetEnumProp( Instance, PropInfo, GetEnumName( TypeInfo, Value ) );
  else
    SetOrdProp( Instance, PropInfo, Value );
  end;
end;

procedure TrtProperty.SetAsMethod( const Value: TMethod );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  SetMethodProp( Instance, PropInfo, Value );
end;

procedure TrtProperty.SetAsObject( const Value: TObject );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  SetObjectProp( Instance, PropInfo, Value );
end;

procedure TrtProperty.SetAsString( const Value: string );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  case Kind of
    tkEnumeration: SetEnumProp( Instance, PropInfo, Value );
    tkSet: SetSetProp( Instance, propInfo, Value );
  else
    SetStrProp( Instance, PropInfo, Value );
  end;
end;

procedure TrtProperty.SetAsVariant( const Value: Variant );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  // Don't use SetVariantProp; it doesn't do type checking - it assumes it's a variant
  SetPropValue( Instance, Name, Value );
end;

procedure TrtProperty.SetValue( const Value: Variant );
begin
  Assert( Instance <> nil, ERR_NOINSTANCE );
  SetPropValue( Instance, Name, Value );
end;

procedure TrtProperty.VerifyWritable;
begin
  Assert( not ReadOnly, ERR_READONLY );
end;

{ TrtWrapper }

constructor TrtWrapper.Create( AClass: TClass; PropKinds: TTypeKinds );
begin
  FObjInstance := nil;
  ObjClass := AClass;
  ObjTypeInfo := AClass.ClassInfo;
  FVisiblePropKinds := PropKinds;

  Create;
end;

constructor TrtWrapper.Create( AObject: TObject; PropKinds: TTypeKinds );
begin
  FObjInstance := AObject;
  ObjClass := ObjInstance.ClassType;
  ObjTypeInfo := AObject.ClassInfo;
  FVisiblePropKinds := PropKinds;

  Create;
end;

constructor TrtWrapper.Create( AClass: TClass; PropKinds: TTypeKinds;
  StopNames: array of string );
var
  nStopName: integer;
begin
  if not Assigned( FStopNames ) then
    FStopNames := TStringList.Create;

  for nStopName := Low( StopNames ) to High( StopNames ) do
  begin
    FStopNames.Add( StopNames[nStopName] );
  end;

  Create( AClass, PropKinds );
end;

constructor TrtWrapper.Create( AObject: TObject; PropKinds: TTypeKinds;
  StopNames: array of string );
var
  nStopName: integer;
begin
  if not Assigned( FStopNames ) then
    FStopNames := TStringList.Create;

  for nStopName := Low( StopNames ) to High( StopNames ) do
  begin
    FStopNames.Add( StopNames[nStopName] );
  end;

  Create( AObject, PropKinds );
end;

constructor TrtWrapper.Create;
begin
  if not Assigned( FStopNames ) then
    FStopNames := TStringList.Create;
  FStopNames.OnChange := StopNamesChanged;
  bInternalStopNameChange := false;
  FPropObjects := TrtPropertyList.Create;
  ObjPropList := nil;
  Initialize;
end;

{
CreatePropertyObject
Creates a TrtProperty for the specified AllIndex.  If an instance is available,
it uses the instance to create the TrtProperty so that properties of that
instance can be manipulated.  If no instance is available, then it tries to
create the TrtProperty with a class.  If no class is available, then it just
uses the raw propInfo from the ObjPropList.
}

function TrtWrapper.CreatePropertyObject( Index: integer ): TrtProperty;
var
  propInfo: PPropInfo;
  propName: string;
begin
  propInfo := VisiblePropInfos[Index];
  propName := propInfo^.Name;
  if Assigned( ObjInstance ) then
    FPropObjects[Index] := TrtProperty.Create( ObjInstance, propName )
  else if Assigned( ObjClass ) then
    FPropObjects[Index] := TrtProperty.Create( ObjClass, propName )
  else
    FPropObjects[Index] := TrtProperty.Create( propInfo );
  Result := FPropObjects[Index];
end;

destructor TrtWrapper.Destroy;
begin
  FStopNames.Free;
  FPropObjects.Free;

  if Assigned( ObjPropList ) then
    FreeMem( ObjPropList, ObjTypeData^.PropCount * SizeOf( PPropInfo ) );

  inherited;
end;

function TrtWrapper.GetItemByName( Name: string ): TrtProperty;
var
  nProp: integer;
begin
  Result := nil;
  for nProp := 0 to Count - 1 do
  begin
    if CompareText( PropertyObjects[nProp].Name, Name ) = 0 then
    begin
      Result := PropertyObjects[nProp];
      break;
    end;
  end;
end;

function TrtWrapper.GetItemByIndex( index: integer ): TrtProperty;
begin
  Result := PropertyObjects[index];
end;

function TrtWrapper.GetMethods: TStringList;
begin
  if not Assigned( FMethods ) then
  begin
    FMethods := TStringList.Create;
    GetMethodList( ObjClass, FMethods );
  end;
  Result := FMethods;
end;

function TrtWrapper.GetStopNames: TStrings;
begin
  Result := FStopNames;
end;

function TrtWrapper.HasProperty( PropertyName: string ): boolean;
begin
  Result := IsPublishedProp( ObjClass, PropertyName );
end;

procedure TrtWrapper.Initialize;
var
  nHandledCount: integer;
  nAProp: integer;
begin
  //Clean up buffers from previous calls to Initialize...
  if Assigned( ObjPropList ) then
  begin
    FreeMem( ObjPropList, ObjTypeData^.PropCount * SizeOf( PPropInfo ) );
    ObjPropList := nil;
  end;

  FPropObjects.Clear;

  //Prepare buffer for a new property list
  ObjTypeData := GetTypeData( ObjTypeInfo );
  GetMem( ObjPropList, ObjTypeData^.PropCount * SizeOf( PPropInfo ) );

  nAllCount := GetPropList( ObjTypeInfo, tkAny, ObjPropList );

  SetLength( VisiblePropInfos, AllCount );

  //Calculate the count of the properties that are VisiblePropKinds and not in
  //  StopNames.  The logic for this is in NextAllIndexFromAllIndex
  nHandledCount := 0;
  nAProp := NextAllIndexFromAllIndex( -1 );
  while nAProp > -1 do
  begin
    VisiblePropInfos[nHandledCount] := ObjPropList[nAProp];
    FPropObjects.Add( nil ); //Place holder for the Property Object

    inc( nHandledCount );
    nAProp := NextAllIndexFromAllIndex( nAProp );
  end;

  SetLength( VisiblePropInfos, nHandledCount );
  nCount := nHandledCount;
end;

{
NextAllIndexFromAllIndex
Horrible name, huh?  The idea here is the indexes passed in and returned from
this method are relative to the entire list of properties, not just the ones
that are "visible".  Visible properties are properties that satisfy these
conditions:
  - The property's Kind is in VisiblePropKinds
  - The property's Name is not in StopNames
}

function TrtWrapper.NextAllIndexFromAllIndex( AllIndex: integer ): integer;
var
  propName: string;
  nAllProp: integer;
  propInfo: PPropInfo;
begin
  nAllProp := AllIndex + 1;
  Result := -1;
  while nAllProp < AllCount do
  begin
    propInfo := ObjPropList^[nAllProp];
    propName := ObjPropList^[nAllProp]^.Name;
    if FStopNames.IndexOf( LowerCase( propName ) ) = -1 then
      if ( VisiblePropKinds = [] ) or
        ( propInfo^.PropType^.Kind in VisiblePropKinds ) then
      begin
        Result := nAllProp;
        break;
      end;
    inc( nAllProp );
  end;
end;

{
GetPropertyObject
Gets the TrtProperty at the specified AllIndex.  Creates it if necessary.
}

function TrtWrapper.GetPropertyObject(
  Index: integer ): TrtProperty;
begin
  Result := FPropObjects[Index];
  if not Assigned( Result ) then
  begin
    Result := CreatePropertyObject( Index );
  end;
end;

procedure TrtWrapper.SetStopNames( const Value: TStrings );
var
  nName: integer;
begin
  FStopNames.Assign( Value );
  for nName := 0 to FStopNames.Count - 1 do
    FStopNames[nName] := LowerCase( FStopNames[nName] );
  Initialize;
end;

procedure TrtWrapper.SetVisiblePropKinds( const Value: TTypeKinds );
begin
  FVisiblePropKinds := Value;
  Initialize;
end;

procedure TrtWrapper.StopNamesChanged( Sender: TObject );
var
  nName: integer;
begin
  if bInternalStopNameChange then
  begin
    bInternalStopNameChange := false;
    exit;
  end;
  bInternalStopNameChange := true;

  FStopNames.BeginUpdate;

  for nName := 0 to FStopNames.Count - 1 do
    FStopNames[nName] := LowerCase( FStopNames[nName] );

  FStopNames.EndUpdate;

  Initialize;
end;

procedure TrtWrapper.SetObjInstance( const Value: TObject );
begin
  FObjInstance := Value;
  Initialize;
end;

function TrtWrapper.AllCount: integer;
begin
  Result := nAllCount;
end;

function TrtWrapper.Count: integer;
begin
  Result := nCount;
end;

{ TrtPropertyList }

function TrtPropertyList.Add( ArtPropObj: TrtProperty ): Integer;
begin
  Result := inherited Add( ArtPropObj );
end;

constructor TrtPropertyList.Create;
begin
  inherited;
  OwnsObjects := true;
end;

function TrtPropertyList.GetItem( Index: Integer ): TrtProperty;
begin
  Result := TrtProperty( inherited Items[index] );
end;

function TrtPropertyList.Remove( ArtPropObj: TrtProperty ): Integer;
begin
  Result := inherited Remove( ArtPropObj );
end;

procedure TrtPropertyList.SetItem( Index: Integer;
  const Value: TrtProperty );
begin
  inherited Items[index] := Value;
end;

end.

