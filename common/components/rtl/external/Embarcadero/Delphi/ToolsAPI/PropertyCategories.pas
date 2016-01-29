{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit PropertyCategories;

interface

uses System.TypInfo, System.Classes, System.Masks, System.Contnrs, DesignIntf, DesignEditors;

{ Property Categories Classes
  The following three components make up the category management system.
  Access to them is usually managed by the following support functions.

  TPropertyCategoryList
    Contains and maintains the list of TPropertyCategories.  There are numerous
    'As a whole' access and manipulation methods for categories as well as
    simplified access functions.
  TPropertyCategory
    Contains and maintains the list of TPropertyFilters.  There are numerous
    'As a whole' access and manipulation methods for filters as well as data
    about the category itself.
  TPropertyFilter
    Maintains the information about a single filter associated with a particular
    category.  Along with its filter specific data it also encapsulates the
    matching algorithm. }

type
  TPropertyFilter = class(TObject)
  private
    FMask: TMask;
    FGroup: Integer;
  public
    constructor Create(const APropertyName: string; AGroup: Integer);
    destructor Destroy; override;
    function Match(const APropertyName: string; const DesignObject: IDesignObject;
      const AProperty: IProperty = nil): Boolean; overload; virtual;
  end;

  TComponentPropertyFilter = class(TPropertyFilter)
  private
    FComponentClass: TClass;
    FPropertyType: PTypeInfo;
  public
    constructor Create(const APropertyName: string; AComponentClass: TClass;
      APropertyType: PTypeInfo);
    function Match(const APropertyName: string; const DesignObject: IDesignObject;
      const AProperty: IProperty = nil): Boolean; overload; override;
    function Match(const APropertyName: string; AComponentClass: TClass;
      APropertyType: PTypeInfo): Boolean; overload;
    property ComponentClass: TClass read FComponentClass;
    property PropertyType: PTypeInfo read FPropertyType;
  end;

  TPropertyCategory = class(TObject)
  private
    FList: TObjectList;
    FMatchCount: Integer;
    FEditor: TPropertyEditor;
    FEnabled: Boolean;
    FGroup: Integer;
    FName: string;
    FVisible: Boolean;
  protected
    function GetFilter(Index: Integer): TPropertyFilter;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;
    function Add(AFilter: TPropertyFilter): TPropertyFilter;
    procedure Remove(AFilter: TPropertyFilter);
    function Count: Integer;
    function Match(const APropertyName: string; const DesignObject: IDesignObject;
      const AProperty: IProperty = nil): Boolean; overload;
    function Match(const APropertyName: string; AComponentClass: TClass;
      APropertyType: PTypeInfo): Boolean; overload;
    procedure ClearMatches;
    procedure FreeEditorGroup(AGroup: Integer);
    property Filters[Index: Integer]: TPropertyFilter read GetFilter;
    property MatchCount: Integer read FMatchCount;
    property Visible: Boolean read FVisible write FVisible;
    property Editor: TPropertyEditor read FEditor write FEditor;
    property Name: string read FName;
  end;

  TPropertyCategoryClass = class of TPropertyCategory;

  TPropertyCategoryVisibleMode = (pcvAll, pcvToggle, pcvNone, pcvNotListed,
    pcvOnlyListed);

  TPropertyCategoryList = class(TObject)
  private
    FList: TObjectList;
    FMiscCategory: TPropertyCategory;
    FHiddenCategories: TStringList;
  protected
    function GetCategory(Index: Integer): TPropertyCategory;
  public
    constructor Create;
    destructor Destroy; override;
    function FindCategory(const ACategoryName: string): TPropertyCategory;
    function IndexOf(const ACategoryName: string): Integer;
    procedure ClearMatches;
    procedure FreeEditorGroup(AGroup: Integer);
    function MiscCategory: TPropertyCategory;
    function Count: integer;
    function Match(const APropertyName: string; const DesignObject: IDesignObject;
      const AProperty: IProperty = nil): Boolean; overload;
    function Match(const APropertyName: string; AComponentClass: TClass;
      APropertyType: PTypeInfo = nil): Boolean; overload;
    function ChangeVisibility(AMode: TPropertyCategoryVisibleMode): Boolean; overload;
    function ChangeVisibility(AMode: TPropertyCategoryVisibleMode;
      const ANames: array of string): Boolean; overload;
    property Categories[Index: Integer]: TPropertyCategory read GetCategory; default;

    procedure LoadHiddenCategories;
    procedure SaveHiddenCategories;
  end;

{ Property Category Query Functions }

function IsPropertyInCategory(const Category: string; ComponentClass: TClass;
  const PropertyName: string): Boolean; overload;
function IsPropertyInCategory(const Category: string; const ClassName,
  PropertyName: string): Boolean; overload;

function PropertyCategoryList: TPropertyCategoryList;

var
  GetHiddenCategoriesProc: function: string;
  SetHiddenCategoriesProc: procedure(const Value: string);
  
implementation

uses System.SysUtils;

{ TPropertyFilter }

constructor TPropertyFilter.Create(const APropertyName: string; AGroup: Integer);
begin
  inherited Create;
  if APropertyName <> '' then
    FMask := TMask.Create(APropertyName);
  FGroup := AGroup;
end;

destructor TPropertyFilter.Destroy;
begin
  FMask.Free;
  inherited Destroy;
end;

function TPropertyFilter.Match(const APropertyName: string;
  const DesignObject: IDesignObject; const AProperty: IProperty): Boolean;
begin
  Result := not Assigned(FMask) or FMask.Matches(APropertyName);
end;

{ TVCLPropertyFilter }

constructor TComponentPropertyFilter.Create(const APropertyName: string;
  AComponentClass: TClass; APropertyType: PTypeInfo);
begin
  inherited Create(APropertyName, CurrentGroup);
  FComponentClass := AComponentClass;
  FPropertyType := APropertyType;
end;

function TComponentPropertyFilter.Match(const APropertyName: string;
  AComponentClass: TClass; APropertyType: PTypeInfo): Boolean;

  function MatchName: Boolean;
  begin
    Result := not Assigned(FMask) or FMask.Matches(APropertyName);
  end;

  function MatchClass: Boolean;
  begin
    Result := Assigned(AComponentClass) and
      ((ComponentClass = AComponentClass) or
      (AComponentClass.InheritsFrom(ComponentClass)));
  end;

  function MatchType: Boolean;
  begin
    Result := Assigned(APropertyType) and ((PropertyType = APropertyType) or
      ((PropertyType^.Kind = tkClass) and (APropertyType^.Kind = tkClass) and
      GetTypeData(APropertyType)^.ClassType.InheritsFrom(GetTypeData(PropertyType)^.ClassType)));
  end;

begin
  if Assigned(ComponentClass) then
    if Assigned(PropertyType) then
      Result := MatchClass and MatchType and MatchName
    else
      Result := MatchClass and MatchName
  else
    if Assigned(PropertyType) then
      Result := MatchType and MatchName
    else
      Result := MatchName;
end;

function TComponentPropertyFilter.Match(const APropertyName: string;
  const DesignObject: IDesignObject; const AProperty: IProperty): Boolean;
var
  LPersistent: IDesignPersistent;
  LPropInfo: PPropInfo;
  LTypeInfo: PTypeInfo;
  LPropertyName: string;
begin
  Result := False;
  LPropertyName := APropertyName;
  if (LPropertyName = '') and (AProperty <> nil) then
    LPropertyName := AProperty.GetName;
  if Supports(DesignObject, IDesignPersistent, LPersistent) then
  begin
    LTypeInfo := nil;
    if AProperty <> nil then
      LTypeInfo := AProperty.GetPropType
    else
    begin
      LPropInfo := GetPropInfo(PTypeInfo(LPersistent.Persistent.ClassInfo), APropertyName);
      if Assigned(LPropInfo) then
        LTypeInfo := LPropInfo.PropType^;
    end;
    Result := Match(LPropertyName, LPersistent.Persistent.ClassType, LTypeInfo);
  end;
end;

{ TPropertyCategory }

function TPropertyCategory.Add(AFilter: TPropertyFilter): TPropertyFilter;
begin
  FList.Insert(0, AFilter);
  Result := AFilter;
end;

procedure TPropertyCategory.ClearMatches;
begin
  FMatchCount := 0;
end;

function TPropertyCategory.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPropertyCategory.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
  FList := TObjectList.Create;
  FVisible := True;
  FEnabled := True;
  FGroup := CurrentGroup;
end;

destructor TPropertyCategory.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

procedure TPropertyCategory.FreeEditorGroup(AGroup: Integer);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if Filters[I].FGroup = AGroup then
      FList.Delete(I);
end;

function TPropertyCategory.GetFilter(Index: Integer): TPropertyFilter;
begin
  Result := TPropertyFilter(FList[Index])
end;

function TPropertyCategory.Match(const APropertyName: string;
  AComponentClass: TClass; APropertyType: PTypeInfo): Boolean;
var
  I: Integer;
  LPropInfo: PPropInfo;
  Filter: TPropertyFilter;
begin
  Result := False;

  if not Assigned(APropertyType) and
     Assigned(AComponentClass) then
  begin
    LPropInfo := GetPropInfo(PTypeInfo(AComponentClass.ClassInfo), APropertyName);
    if Assigned(LPropInfo) then
      APropertyType := LPropInfo.PropType^;
  end;

  for I := 0 to Count - 1 do
  begin
    Filter := Filters[I];
    if (Filter is TComponentPropertyFilter) and
      TComponentPropertyFilter(Filter).Match(APropertyName, AComponentClass, APropertyType) then
    begin
      Result := True;
      Break;
    end;
  end;

  if Result then
    Inc(FMatchCount);
end;

function TPropertyCategory.Match(const APropertyName: string;
  const DesignObject: IDesignObject; const AProperty: IProperty): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Filters[I].Match(APropertyName, DesignObject, AProperty) then
    begin
      Result := True;
      Break;
    end;
  if Result then
    Inc(FMatchCount);
end;

procedure TPropertyCategory.Remove(AFilter: TPropertyFilter);
begin
  FList.Remove(AFilter);
end;

{ TPropertyCategoryList }

function TPropertyCategoryList.ChangeVisibility(AMode: TPropertyCategoryVisibleMode): Boolean;
begin
  Result := ChangeVisibility(AMode, ['']);
end;

function TPropertyCategoryList.ChangeVisibility(AMode: TPropertyCategoryVisibleMode;
  const ANames: array of string): Boolean;
var
  I: Integer;
  LChanged: Boolean;

  procedure ChangeIfNot(ACategory: TPropertyCategory; Value: Boolean);
  begin
    if (ACategory.Visible <> Value) and (ACategory.MatchCount > 0) then
    begin
      ACategory.Visible := Value;
      LChanged := True;
    end;
  end;

  function ListedCategory(const AName: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    if ANames[Low(ANames)] <> '' then
      for I := Low(ANames) to High(ANames) do
        if AName = ANames[I] then
        begin
          Result := True;
          break;
        end;
  end;

begin
  LChanged := False;
  for I := 0 to Count - 1 do
    case AMode of
      pcvAll:        ChangeIfNot(Categories[I], True);
      pcvToggle:     ChangeIfNot(Categories[I], not Categories[I].Visible);
      pcvNone:       ChangeIfNot(Categories[I], False);
      pcvNotListed:  ChangeIfNot(Categories[I], not ListedCategory(Categories[I].Name));
      pcvOnlyListed: ChangeIfNot(Categories[I], ListedCategory(Categories[I].Name));
    end;
  Result := LChanged;
end;

procedure TPropertyCategoryList.ClearMatches;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Categories[I].ClearMatches;
end;

function TPropertyCategoryList.Count: integer;
begin
  Result := FList.Count
end;

constructor TPropertyCategoryList.Create;
begin
  inherited Create;
  FList := TObjectList.Create;
  FHiddenCategories := TStringList.Create;
end;

destructor TPropertyCategoryList.Destroy;
begin
  FList.Free;
  FHiddenCategories.Free;
  inherited Destroy;
end;

function TPropertyCategoryList.FindCategory(const ACategoryName: string): TPropertyCategory;
var
  I: Integer;
begin
  I := IndexOf(ACategoryName);
  if I <> -1 then
    Result := Categories[I]
  else
  begin
    Result := TPropertyCategory.Create(ACategoryName);
    FList.Insert(0, Result);
    Result.Visible := FHiddenCategories.IndexOf(Result.Name) = -1;
  end;
end;

procedure TPropertyCategoryList.FreeEditorGroup(AGroup: Integer);
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    if Categories[I] <> MiscCategory then
      if Categories[I].FGroup = AGroup then
        FList.Delete(I)
      else
        Categories[I].FreeEditorGroup(AGroup);
end;

function TPropertyCategoryList.GetCategory(Index: Integer): TPropertyCategory;
begin
  Result := TPropertyCategory(FList[Index])
end;

function TPropertyCategoryList.IndexOf(const ACategoryName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Categories[I].Name = ACategoryName then
    begin
      Result := I;
      break;
    end;
end;

procedure TPropertyCategoryList.LoadHiddenCategories;
var
  I: Integer;
begin
  Assert(Assigned(GetHiddenCategoriesProc));
  if Assigned(GetHiddenCategoriesProc) then
    FHiddenCategories.CommaText := GetHiddenCategoriesProc;
  for I := 0 to Count - 1 do
    Categories[I].Visible := FHiddenCategories.IndexOf(Categories[I].Name) = -1;
end;

function TPropertyCategoryList.Match(const APropertyName: String;
  AComponentClass: TClass; APropertyType: PTypeInfo = nil): Boolean;
var
  I: Integer;
  LThisMatch, LAnyMatches: Boolean;
  LPropInfo: PPropInfo;
begin
  // assume the worst
  Result := False;
  LAnyMatches := False;

  // make sure we have good data
  if not Assigned(APropertyType) and
     Assigned(AComponentClass) then
  begin
    LPropInfo := GetPropInfo(PTypeInfo(AComponentClass.ClassInfo), APropertyName);
    if Assigned(LPropInfo) then
      APropertyType := LPropInfo.PropType^;
  end;

  // for each category...
  for I := 0 to Count - 1 do
    if Categories[I] <> MiscCategory then begin

      // found something?
      LThisMatch := Categories[I].Match(APropertyName, AComponentClass, APropertyType);
      LAnyMatches := LAnyMatches or LThisMatch;

      // if this is a good match and its visible then...
      Result := LThisMatch and Categories[I].Visible;
      if Result then
        break;
    end;

  // if no matches then check the misc category
  if not LAnyMatches then
  begin
    LThisMatch := MiscCategory.Match(APropertyName, AComponentClass, APropertyType);
    Result := LThisMatch and MiscCategory.Visible;
  end;
end;

function TPropertyCategoryList.Match(const APropertyName: string;
  const DesignObject: IDesignObject; const AProperty: IProperty): Boolean;
var
  I: Integer;
  LThisMatch, LAnyMatches: Boolean;
begin
  Result := False; // Supress false warning
  LAnyMatches := False;
  // for each category...
  for I := 0 to Count - 1 do
    if Categories[I] <> MiscCategory then begin

      // found something?
      LThisMatch := Categories[I].Match(APropertyName, DesignObject, AProperty);
      LAnyMatches := LAnyMatches or LThisMatch;

      // if this is a good match and its visible then...
      Result := LThisMatch and Categories[I].Visible;
      if Result then
        Break;
    end;

  // if no matches then check the misc category
  if not LAnyMatches then
  begin
    LThisMatch := MiscCategory.Match(APropertyName, DesignObject, AProperty);
    Result := LThisMatch and MiscCategory.Visible;
  end;
end;

function TPropertyCategoryList.MiscCategory: TPropertyCategory;
begin
  if FMiscCategory = nil then
    FMiscCategory := FindCategory(sMiscellaneousCategoryName);
  Result := FMiscCategory;
end;

procedure TPropertyCategoryList.SaveHiddenCategories;
var
  I: Integer;
begin
  FHiddenCategories.Clear;
  for I := 0 to Count - 1 do
    if not Categories[I].Visible then
      FHiddenCategories.Add(Categories[I].Name);
  SetHiddenCategoriesProc(FHiddenCategories.CommaText);
end;

var
  InternalPropertyCategoryList: TPropertyCategoryList;

function IsPropertyInCategory(const Category: string;
  ComponentClass: TClass; const PropertyName: string): Boolean;
begin
  Result := PropertyCategoryList.FindCategory(Category).Match(PropertyName,
    ComponentClass, nil);
end;

function IsPropertyInCategory(const Category: string; const ClassName: string;
  const PropertyName: string): Boolean;
begin
  Result := PropertyCategoryList.FindCategory(Category).Match(PropertyName,
    FindClass(ClassName), nil);
end;

function PropertyCategoryList: TPropertyCategoryList;
begin
  // if it doesn't exists then make it
  if not Assigned(InternalPropertyCategoryList) then
  begin
    InternalPropertyCategoryList := TPropertyCategoryList.Create;

    // add the catch all misc category
    InternalPropertyCategoryList.MiscCategory.Add(TPropertyFilter.Create('', -1));
    InternalPropertyCategoryList.MiscCategory.Add(TComponentPropertyFilter.Create('', nil, nil));

    // Find out what is hidden
    InternalPropertyCategoryList.LoadHiddenCategories;
  end;

  // ok return it then
  Result := InternalPropertyCategoryList;
end;

procedure RegisterPropertyInCategory(const CategoryName: string;
  ComponentClass: TClass; PropertyType: PTypeInfo; const PropertyName: string); export;
begin
  PropertyCategoryList.FindCategory(CategoryName).Add(TComponentPropertyFilter.Create(PropertyName,
    ComponentClass, PropertyType));
end;

procedure FreeCategoryGroup(Group: Integer); export;
begin
  if InternalPropertyCategoryList <> nil then
    InternalPropertyCategoryList.FreeEditorGroup(Group);
end;

initialization
  DesignIntf.RegisterPropertyInCategoryProc := RegisterPropertyInCategory;
  NotifyGroupChange(FreeCategoryGroup);

finalization
  UnnotifyGroupChange(FreeCategoryGroup);
  DesignIntf.RegisterPropertyInCategoryProc := nil;
  InternalPropertyCategoryList.Free;

end.
