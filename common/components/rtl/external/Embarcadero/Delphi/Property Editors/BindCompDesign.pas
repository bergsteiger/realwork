{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit BindCompDesign;

interface

uses Data.Bind.Components, System.Classes, System.SysUtils, System.Rtti;


implementation

uses
  System.Generics.Collections, DesignEditors, BindCompEdit;

type

  TDataBindingFactoryItem = class
  private
    FFactory: IBindCompFactory;
    FGroup: Integer;
    constructor Create(AFactory: IBindCompFactory; AGroup: Integer);
  end;

  TDataBindingFactoryItems = class
  private
    FList: TList<TDataBindingFactoryItem>;
    procedure Add(AFactory: IBindCompFactory);
    procedure DeleteGroup(AGroup: Integer);
    constructor Create;
    destructor Destroy; override;
  end;

  TDataBindingDesignerItem = class
  private
    FDesigner: IBindCompDesigner;
    FClass: TContainedBindCompClass;
    FGroup: Integer;
    constructor Create(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner; AGroup: Integer);
  end;

  TDataBindingDesignerItems = class
  private
    FList: TList<TDataBindingDesignerItem>;
    procedure Add(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner);
    procedure DeleteGroup(AGroup: Integer);
    constructor Create;
    destructor Destroy; override;
  end;

  TDataBoundComponentsItem = class
  private
    FClass: TComponentClass;
    FFlags: TBoundComponentOptions;
    FGroup: Integer;
    constructor Create(AClass: TComponentClass; AFlags: TBoundComponentOptions; AGroup: Integer);
  end;

  TDataBoundComponentsItems = class
  private
    FDictionary: TDictionary<TComponentClass, TDataBoundComponentsItem>;
    procedure Add(AClass: TComponentClass; AFlags: TBoundComponentOptions);
    procedure DeleteGroup(AGroup: Integer);
    constructor Create;
    destructor Destroy; override;
  end;

type

  TCustomDataBindingRecord = record
    DataBindingClass: TContainedBindCompClass;
    GroupId: Integer;
  end;

  TCustomDataBindingRecordArray = array of TCustomDataBindingRecord;

  TCustomDataBindingClassesRecord = record
    Category: string;
    DataBindingRecords: TCustomDataBindingRecordArray;
    //Resource: TComponentClass;
  end;

  TCustomDataBindingClassesRecordArray = array of TCustomDataBindingClassesRecord;

  //TCategoryKind = (ckCategory, ckNone, ckAll);

  TNotifyDataBindingListChange = procedure;


//const
//  CategoryKinds: array[0..2] of TCategoryKind = (ckCategory, ckNone, ckAll);


//function CreateDataBinding(AOwner: TComponent; DataBindingClass: TContainedBindCompClass): TContainedBindComponent;
//procedure EnumDataBindings(Proc: TEnumDataBindingProc; Info: Pointer); forward;
//procedure UnRegDataBindings(const AClasses: array of TContainedBindCompClass);//! far;  forward;
//procedure RegDataBindings(const ACategory: string;
//  const AClasses: array of TContainedBindCompClass);  forward;


var
  GDataBindingFactoryItems: TDataBindingFactoryItems;
  GDataBindingDesignerItems: TDataBindingDesignerItems;
  GDataBoundComponentsItems: TDataBoundComponentsItems;
  NotifyDataBindingListChange: TNotifyDataBindingListChange = nil;
  GCustomDataBindingClassesArray: TCustomDataBindingClassesRecordArray;

{ TDataBindingFactories }

procedure GroupDeleted(AGroup: Integer);
begin
  if GDAtaBindingFactoryItems <> nil then
    GDAtaBindingFactoryItems.DeleteGroup(AGroup);
  if GDataBindingDesignerItems <> nil then
    GDataBindingDesignerItems.DeleteGroup(AGroup);
  if GDataBoundComponentsItems <> nil then
    GDataBoundComponentsItems.DeleteGroup(AGroup);
end;


function DataBindingFactoryItems: TDataBindingFactoryItems;
begin
  if GDataBindingFactoryItems = nil then
  begin
    TDataBindingFactoryItems.Create;
//    DesignEditors.NotifyGroupChange(GroupDeleted);
  end;
  Result := GDataBindingFactoryItems;
end;

function DataBindingDesignerItems: TDataBindingDesignerItems;
begin
  if GDataBindingDesignerItems = nil then
  begin
    TDataBindingDesignerItems.Create;
  end;
  Result := GDataBindingDesignerItems;
end;

procedure RegisterBindCompFactory(AFactory: IBindCompFactory);
begin
  DataBindingFactoryItems.Add(AFactory);
end;

procedure EnumRegisteredBindCompFactories(Proc: TEnumBindCompFactoryProc; Info: Pointer);
var
  LItem: TDataBindingFactoryItem;
begin
  if GDataBindingFactoryItems <> nil then
    for LItem in GDataBindingFactoryItems.FList do
      Proc(LItem.FFactory, Info);
end;

procedure RegisterBindCompDesigner(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner);
begin
  DataBindingDesignerItems.Add(AClass, ADesigner);
end;

function GetBindCompDesigner(AClass: TContainedBindCompClass): IBindCompDesigner;
var
  LItem: TDataBindingDesignerItem;
  I: Integer;
begin
  if GDataBindingDesignerItems <> nil then
  begin

    // Exact match
    for LItem in GDataBindingDesignerItems.FList do
      if LItem.FClass = AClass then
        Exit(LItem.FDesigner);
                                                                              

    // Look for inherited (in reverse order)
    for I := GDataBindingDesignerItems.FList.Count - 1 downto 0 do
    begin
      LItem := GDataBindingDesignerItems.FList[I];
      if AClass.InheritsFrom(LItem.FClass) then
      begin
        Exit(LItem.FDesigner)
      end;
    end;
  end;
  Result := nil;
end;

procedure RegisterBoundComponents(const AClasses: array of TComponentClass; AFlags: TBoundComponentOptions);
var
  LItem: TComponentClass;
begin
  if GDataBoundComponentsItems = nil then
  begin
    TDataBoundComponentsItems.Create;
  end;
  for LItem in AClasses do
    GDataBoundComponentsItems.Add(LItem, AFlags);
end;

function GetBoundComponentOptions(AClass: TComponentClass): TBoundComponentOptions;
var
  LItem: TDataBoundComponentsItem;
begin
  Result := [];
  // Exact match
  if GDataBoundComponentsItems <> nil then
  begin
    if GDataBoundComponentsItems.FDictionary.TryGetValue(AClass, LItem) then
    begin
      Result := LItem.FFlags;
      Exit;
    end;

                                                                              

    // Look for inherited
    for LItem in GDataBoundComponentsItems.FDictionary.Values do
    begin
      if AClass.InheritsFrom(LItem.FClass) then
      begin
        Result := LItem.FFlags;
        Exit;
      end;
    end;
  end;

end;

{ TDataBindingFactoryItem }

constructor TDataBindingFactoryItem.Create(AFactory: IBindCompFactory;
  AGroup: Integer);
begin
                                           
  FFactory := AFactory;
  FGroup := AGroup;
end;

{ TDataBindingDesignerItem }

constructor TDataBindingDesignerItem.Create(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner; AGroup: Integer);
begin
                                           
  FDesigner := ADesigner;
  FClass := AClass;
  FGroup := AGroup;
end;

{ TDataBindingFactoryItems }

procedure TDataBindingFactoryItems.Add(AFactory: IBindCompFactory);
begin
  FList.Add(TDataBindingFactoryItem.Create(AFactory, CurrentGroup));
end;

constructor TDataBindingFactoryItems.Create;
begin
  Assert(GDataBindingFactoryItems = nil);
  GDataBindingFactoryItems := Self;
  FList := TObjectList<TDataBindingFactoryItem>.Create(True); // Owns
end;

procedure TDataBindingFactoryItems.DeleteGroup(AGroup: Integer);
var
  I: Integer;
begin
  for I := FList.Count - 1 downto 0 do
    if FList[I].FGroup = AGroup then
      FList.Delete(I);
end;

destructor TDataBindingFactoryItems.Destroy;
begin
  Assert(GDataBindingFactoryItems = Self);
  GDataBindingFactoryItems := nil;
  FList.Free;
  inherited;
end;

{ TDataBindingDesignerItems }

procedure TDataBindingDesignerItems.Add(AClass: TContainedBindCompClass; ADesigner: IBindCompDesigner);
begin
  FList.Add(TDataBindingDesignerItem.Create(AClass, ADesigner, CurrentGroup));
end;

constructor TDataBindingDesignerItems.Create;
begin
  Assert(GDataBindingDesignerItems = nil);
  GDataBindingDesignerItems := Self;
  FList := TObjectList<TDataBindingDesignerItem>.Create(True); // Owns
end;

procedure TDataBindingDesignerItems.DeleteGroup(AGroup: Integer);
var
  I: Integer;
begin
  for I := FList.Count - 1 downto 0 do
    if FList[I].FGroup = AGroup then
      FList.Delete(I);
end;

destructor TDataBindingDesignerItems.Destroy;
begin
  Assert(GDataBindingDesignerItems = Self);
  GDataBindingDesignerItems := nil;
  FList.Free;
  inherited;
end;

{ TDataBoundComponentsItem }

constructor TDataBoundComponentsItem.Create(AClass: TComponentClass;
  AFlags: TBoundComponentOptions; AGroup: Integer);
begin
  FClass := AClass;
  FFlags := AFlags;
  FGroup := AGroup;
end;

{ TDataBoundComponentsItems }

procedure TDataBoundComponentsItems.Add(AClass: TComponentClass; AFlags: TBoundComponentOptions);
begin
  FDictionary.AddOrSetValue(AClass, TDataBoundComponentsItem.Create(AClass, AFlags, CurrentGroup));
end;

constructor TDataBoundComponentsItems.Create;
begin
  Assert(GDataBoundComponentsItems = nil);
  GDataBoundComponentsItems := Self;
  FDictionary := TObjectDictionary<TComponentClass, TDataBoundComponentsItem>.Create([doOwnsValues]);
end;

procedure TDataBoundComponentsItems.DeleteGroup(AGroup: Integer);
var
  LPair: TPair<TComponentClass, TDataBoundComponentsItem>;
  LKeys: TList<TComponentClass>;
  LKey: TComponentClass;
begin
  LKeys := TList<TComponentClass>.Create;
  try
    for LPair in FDictionary do
      if LPair.Value.FGroup = AGroup then
        LKeys.Add(LPair.Key);
    for LKey in LKeys do
      FDictionary.Remove(LKey);
  finally
    LKeys.Free;
  end;
end;

destructor TDataBoundComponentsItems.Destroy;
begin
  Assert(GDataBoundComponentsItems = Self);
  GDataBoundComponentsItems := nil;
  FDictionary.Free;
  inherited;
end;



procedure RegDataBindings(const ACategory: string;
  const AClasses: array of TContainedBindCompClass);
var
  CategoryIndex, Len, I, J, NewClassCount: Integer;
  NewClasses: array of TContainedBindCompClass;
  Skip: Boolean;
  S: string;
begin
//  // Remove resource from cache if it's there
//  if TActionResourceCache.GetInstance(AResource) <> nil then
//    TActionResourceCache.Remove(AResource);

  { Determine whether we're adding a new category, or adding to an existing one }
  CategoryIndex := -1;
  for I := Low(GCustomDataBindingClassesArray) to High(GCustomDataBindingClassesArray) do
    if CompareText(GCustomDataBindingClassesArray[I].Category, ACategory) = 0 then
    begin
      CategoryIndex := I;
      Break;
    end;

  { Adding a new category }
  if CategoryIndex = -1 then
  begin
    CategoryIndex := Length(GCustomDataBindingClassesArray);
    SetLength(GCustomDataBindingClassesArray, CategoryIndex + 1);
  end;

  with GCustomDataBindingClassesArray[CategoryIndex] do
  begin
    SetLength(NewClasses, Length(AClasses));
    { Remove duplicate classes }
    NewClassCount := 0;
    for I := Low(AClasses) to High(AClasses) do
    begin
      Skip := False;
      for J := Low(DataBindingRecords) to High(DataBindingRecords) do
        if AClasses[I] = DataBindingRecords[J].DataBindingClass then
        begin
          Skip := True;
          Break;
        end;
      if not Skip then
      begin
        NewClasses[Low(NewClasses) + NewClassCount] := AClasses[I];
        Inc(NewClassCount);
      end;
    end;

    { Pack NewClasses }
    SetLength(NewClasses, NewClassCount);

    SetString(S, PChar(ACategory), Length(ACategory));
    Category := S;
    //Resource := AResource;
    Len := Length(DataBindingRecords);
    SetLength(DataBindingRecords, Len + Length(NewClasses));
    for I := Low(NewClasses) to High(NewClasses) do
    begin
      RegisterNoIcon([NewClasses[I]]);
      System.Classes.RegisterClass(NewClasses[I]);
      with DataBindingRecords[Len + I] do
      begin
        DataBindingClass := NewClasses[I];
        GroupId := CurrentGroup;
      end;
    end;
  end;
  { Notify all available designers of new TAction class }
  if (BindCompEdit.DesignersList <> nil) and Assigned(NotifyDataBindingListChange) then
    NotifyDataBindingListChange;
end;

procedure UnRegDataBindings(const Classes: array of TContainedBindCompClass);//! far;
var
  I, J, K: Integer;
  LDataBindingClass: TContainedBindCompClass;
begin
  // Clear the resource cache
  //TActionResourceCache.Clear;

  for I := Low(Classes) to High(Classes) do
  begin
    LDataBindingClass := Classes[I];
    for J := Low(GCustomDataBindingClassesArray) to High(GCustomDataBindingClassesArray) do
      for K := Low(GCustomDataBindingClassesArray[J].DataBindingRecords) to High(GCustomDataBindingClassesArray[J].DataBindingRecords) do
        with GCustomDataBindingClassesArray[J].DataBindingRecords[K] do
          if LDataBindingClass = DataBindingClass then
          begin
            DataBindingClass := nil;
            GroupId := -1;
          end;
  end;
  if Assigned(NotifyDataBindingListChange) then
    NotifyDataBindingListChange;
end;

procedure EnumDataBindings(Proc: TEnumBindCompProc; Info: Pointer);
var
  I, J, Count: Integer;
  DataBindingClass: TContainedBindCompClass;
begin
  if GCustomDataBindingClassesArray <> nil then
    for I := Low(GCustomDataBindingClassesArray) to High(GCustomDataBindingClassesArray) do
    begin
      Count := 0;
      for J := Low(GCustomDataBindingClassesArray[I].DataBindingRecords) to High(GCustomDataBindingClassesArray[I].DataBindingRecords) do
      begin
        DataBindingClass := GCustomDataBindingClassesArray[I].DataBindingRecords[J].DataBindingClass;
        if DataBindingClass = nil then
          Continue;
        Proc(GCustomDataBindingClassesArray[I].Category, DataBindingClass, Info);
        Inc(Count);
      end;
      if Count = 0 then
        SetLength(GCustomDataBindingClassesArray[I].DataBindingRecords, 0);
    end;
end;

function CreateDataBinding(AOwner: TComponent; DataBindingClass: TContainedBindCompClass): TContainedBindComponent;
begin
  Result := DataBindingClass.Create(AOwner);
end;

initialization
  DesignEditors.NotifyGroupChange(GroupDeleted);
  RegisterBindCompFactoryProc := BindCompDesign.RegisterBindCompFactory;
  EnumRegisteredBindCompFactoriesProc := BindCompDesign.EnumRegisteredBindCompFactories;
  RegisterBindCompDesignerProc := BindCompDesign.RegisterBindCompDesigner;
  GetBindCompDesignerProc := BindCompDesign.GetBindCompDesigner;
  RegisterBindCompProc := BindCompDesign.RegDataBindings;
  UnRegisterBindCompProc := BindCompDesign.UnRegDataBindings;
  EnumRegisteredBindCompsProc := BindCompDesign.EnumDataBindings;
  CreateBindCompProc := BindCompDesign.CreateDataBinding;
  RegisterBoundComponentsProc := BindCompDesign.RegisterBoundComponents;
  GetBoundComponentOptionsProc := BindCompDesign.GetBoundComponentOptions;
finalization
  DesignEditors.UnnotifyGroupChange(GroupDeleted);
  RegisterBindCompFactoryProc := nil;
  EnumRegisteredBindCompFactoriesProc := nil;
  RegisterBindCompDesignerProc := nil;
  GetBindCompDesignerProc := nil;
  RegisterBindCompProc := nil;
  UnRegisterBindCompProc := nil;
  EnumRegisteredBindCompsProc := nil;
  CreateBindCompProc := nil;
  RegisterBoundComponentsProc := nil;
  GetBoundComponentOptionsProc := nil;
  GDataBindingFactoryItems.Free;
  GDataBindingDesignerItems.Free;
  GDataBoundComponentsItems.Free;
end.



