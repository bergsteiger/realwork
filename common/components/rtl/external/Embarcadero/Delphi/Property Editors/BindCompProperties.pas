{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompProperties;


interface

uses
  System.SysUtils, System.Classes,   Data.Bind.Components,
  System.Rtti, System.Generics.Collections, System.TypInfo;

type
  TEnumeratePropertyProc = function(LProperty: TRttiProperty; AParentType: TRttiType; AParentProperties: TList<TRttiProperty>;
    var AEnumChildren: Boolean): Boolean of object;

  TDataBindingComponentPropertyNames = class
  private
    FList: TList<string>;
    FHasProperties: Boolean;
    FComponent: TObject;
    procedure UpdatePropertyNames;
    function ListEnumeratePropertyCallback(AProperty: TRttiProperty;
      AParentType: TRttiType; AParentProperties: TList<TRttiProperty>;
        var LEnumChildren: Boolean): Boolean;
    function HasEnumeratePropertyCallback(AProperty: TRttiProperty;
      AParentType: TRttiType; AParentProperties: TList<TRttiProperty>;
        var LEnumChildren: Boolean): Boolean;
    function GetPropertyNames: TArray<string>;
    function FilterProperty(AProperty: TRttiProperty): Boolean;
    function GetHasProperties: Boolean;
    function FindObjectPropertyInstance(AProperty: TRttiProperty;
      AParentType: TRttiType; AParentProperties: TList<TRttiProperty>): TObject;
    function CanAccessObjectProperties(AInstance: TObject): Boolean;
  public
    constructor Create(AComponent: TObject);
    destructor Destroy; override;
    property PropertyNames: TArray<string> read GetPropertyNames;
    property HasProperties: Boolean read GetHasProperties;
  end;

//procedure EnumeratePropertyNames(AType: TRttiType; AProc: TEnumeratePropertyProc); overload; forward;
//procedure EnumeratePropertyNames(AObject: TObject; AProc: TEnumeratePropertyProc); overload; forward;


implementation

uses Vcl.Graphics;

procedure EnumeratePropertyNames(AType: TRttiType; AParentProperty: TRttiProperty; AParentTypes: TList<TRttiType>;
  AParentProperties: TList<TRttiProperty>;
  AProc: TEnumeratePropertyProc); overload;
var
  LProperties: TArray<TRttiProperty>;
  LField: TRttiProperty;
  LParentTypes: TList<TRttiType>;
  LParentProperties: TList<TRttiProperty>;
  LEnumChildren: Boolean;
begin
  LProperties := AType.GetProperties;
  if Length(LProperties) > 0 then
  begin
    if AParentTypes.Contains(AType) then
    begin
      // Recursive
      Exit;
    end;
    if AParentProperty <> nil then
      AParentProperties.Add(AParentProperty);
    AParentTypes.Add(AType);
    for LField in LProperties do
    begin
      LParentTypes := TList<TRttiType>.Create(AParentTypes);
      LParentProperties := TList<TRttiProperty>.Create(AParentProperties);
      try
        LEnumChildren := True;
        if not AProc(LField, LParentTypes[0], LParentProperties, LEnumChildren) then
          break;
                                                            
        if LEnumChildren then
          EnumeratePropertyNames(LField.PropertyType, LField, LParentTypes, LParentProperties, AProc);
      finally
        LParentTypes.Free;
        LParentProperties.Free;
      end;
    end;
  end;
end;


procedure EnumeratePropertyNames(AType: TRttiType; AProc: TEnumeratePropertyProc); overload;
var
  LParentTypes: TList<TRttiType>;
  LParentProperties: TList<TRttiProperty>;
begin
  LParentTypes := TList<TRttiType>.Create;
  LParentProperties := TList<TRttiProperty>.Create;
  try
    EnumeratePropertyNames(AType, nil, LParentTypes, LParentProperties, AProc);
  finally
    LParentTypes.Free;
    LParentProperties.Free;
  end;
end;

procedure EnumeratePropertyNames(AObject: TObject; AProc: TEnumeratePropertyProc); overload;
var
  LContext: TRttiContext;
  LType: TRttiInstanceType;
begin
  if AObject <> nil then
  begin
    LType := LContext.GetType(AObject.ClassType) as TRttiInstanceType;
    EnumeratePropertyNames(LType, AProc);
  end;
end;

constructor TDataBindingComponentPropertyNames.Create(AComponent: TObject);
var
  LScopeComponent: IScopeComponent;
begin
  Assert(AComponent <> nil);
  if Supports(AComponent, IScopeComponent, LScopeComponent) then
    FComponent := LScopeComponent.GetScopeObject
  else
    FComponent := AComponent;
end;

destructor TDataBindingComponentPropertyNames.Destroy;
begin
  FList.Free;
  inherited;
end;

function TDataBindingComponentPropertyNames.FilterProperty(AProperty: TRttiProperty): Boolean;

  function GetEnumBaseType(ATypeInfo: PTypeInfo): PTypeInfo;
  var
    pResult: PPTypeInfo;
  begin
    if (ATypeInfo = nil) or (ATypeInfo^.Kind <> tkEnumeration) then
      Exit(nil);
    Result := ATypeInfo;
    while True do
    begin
      pResult := GetTypeData(Result)^.BaseType;
      if (pResult <> nil) and (pResult^ <> nil) and (pResult^ <> Result) then
        Result := pResult^
      else
        Break;
    end;
  end;
  function IsBoolType(ATypeInfo: PTypeInfo): Boolean;
  begin
    ATypeInfo := GetEnumBaseType(ATypeInfo);
    Result := (ATypeInfo = System.TypeInfo(Boolean)) or
      (ATypeInfo = System.TypeInfo(ByteBool)) or
      (ATypeInfo = System.TypeInfo(WordBool)) or
      (ATypeInfo = System.TypeInfo(LongBool));
  end;
begin
  Result := False;
  if not AProperty.IsWritable then
    Exit;
  if AProperty.Visibility = TMemberVisibility.mvPrivate then
    Exit;
  if AProperty.Visibility = TMemberVisibility.mvProtected then
    Exit;
  case AProperty.PropertyType.TypeKind of
    tkUnknown: ;
    tkInteger:  Result := True;
    tkChar:      Result := True;
    tkEnumeration:  Result := IsBoolType(AProperty.PropertyType.Handle);  // Only boolean enumeration supported
    tkFloat:   Result := True;
    tkString:  Result := True;
    tkSet:   Result := False;  // Sets not supported
    tkClass: Result := True; // Caller is responsible for filtering object types
    tkMethod: ;
    tkWChar:   Result := True;
    tkLString:  Result := True;
    tkWString:  Result := True;
    tkVariant:  Result := True;
    tkArray:   ;
    tkRecord:  ;                                              
    tkInterface: ;
    tkInt64:     Result := True;
    tkDynArray:  ;
    tkUString:    Result := True;
    tkClassRef:  ;
    tkPointer:   ;
    tkProcedure:  ;
  end;
end;


function TDataBindingComponentPropertyNames.HasEnumeratePropertyCallback(
  AProperty: TRttiProperty; AParentType: TRttiType;
  AParentProperties: TList<TRttiProperty>; var LEnumChildren: Boolean): Boolean;
begin
  LEnumChildren := False;
  if not FilterProperty(AProperty) then
    Exit(True);
  FHasProperties := True;
  Exit(False);
end;

function TDataBindingComponentPropertyNames.CanAccessObjectProperties(AInstance: TObject): Boolean;
begin
  Result := True;
  if AInstance is TPicture then
    Result := False;
end;

function TDataBindingComponentPropertyNames.FindObjectPropertyInstance(AProperty: TRttiProperty; AParentType: TRttiType; AParentProperties: TList<TRttiProperty>): TObject;
var
  LParentProperty: TRttiProperty;
  LInstance: TObject;
  LValue: TValue;
begin
  Result := nil;
  try
    LInstance := Self.FComponent;
    for LParentProperty in  AParentProperties do
    begin

      LValue := LParentProperty.GetValue(LInstance);
      if LValue.IsObject then
        LInstance := LValue.AsObject
      else
        LInstance := nil;
      if LInstance = nil then
        break;
    end;

    if LInstance <> nil then
    begin
      if not CanAccessObjectProperties(LInstance) then
        Result := nil
      else
      begin
        LValue := AProperty.GetValue(LInstance);
        if LValue.IsObject then
          Result := LValue.AsObject
      end;
    end;
  except
    // Ignore exceptions while retreiving.  Some
    // objects raise exception when property getter is called.
    // Such as VCL TImage.Bitmap

  end;



end;

function TDataBindingComponentPropertyNames.ListEnumeratePropertyCallback(AProperty: TRttiProperty; AParentType: TRttiType; AParentProperties: TList<TRttiProperty>;
        var LEnumChildren: Boolean): Boolean;
var
  LName: string;
  LParentProperty: TRttiProperty;
  LInstance: TObject;
  LSkipProperty: Boolean;
  LParentInstance: TObject;
begin
  // Only go one level deep for child properties
  LEnumChildren := (AParentProperties.Count < 1) and (AProperty.PropertyType.TypeKind = tkClass);
  if LEnumChildren then
  begin
    LParentInstance := FindObjectPropertyInstance(AProperty, AParentType, AParentProperties);
    LEnumChildren := LParentInstance <> nil;
  end;
  LSkipProperty := False;
  if not FilterProperty(AProperty) then
    LSkipProperty := True
  else if AProperty.PropertyType.TypeKind = tkClass then
  begin
    LInstance := FindObjectPropertyInstance(AProperty, AParentType, AParentProperties);
    if LInstance = nil then
      LSkipProperty := True
    else
    begin
      if Supports(LInstance, IStreamPersist)   // Support bitmaps and TStrings
        // or (LInstance is TPersistent)
        then
      begin
        // Allow
      end
      else
        LSkipProperty := True;
    end;
  end;
  if LSkipProperty then
    Exit(True);
  try
    for LParentProperty in AParentProperties do
      if LName <> '' then
        LName := LName + '.' + LParentProperty.Name
      else
        LName := LParentProperty.Name;
    if LName <> '' then
      LName := LName + '.' + AProperty.Name
    else
      LName := AProperty.Name;
  except
    LName := AProperty.Name;
  end;
  if not FList.Contains(LName) then
    FList.Add(LName);
  Result := True;
end;

function TDataBindingComponentPropertyNames.GetHasProperties: Boolean;
begin
  FHasProperties := False;
  EnumeratePropertyNames(FComponent, HasEnumeratePropertyCallback);
  Result := FHasProperties;
end;

function TDataBindingComponentPropertyNames.GetPropertyNames: TArray<string>;
begin
  if FList = nil then
  begin
    FList := TList<string>.Create;
    UpdatePropertyNames;
  end;
  Result := FList.ToArray;
end;


procedure TDataBindingComponentPropertyNames.UpdatePropertyNames;
begin
  FList.Clear;
  EnumeratePropertyNames(FComponent, ListEnumeratePropertyCallback);
end;

end.
