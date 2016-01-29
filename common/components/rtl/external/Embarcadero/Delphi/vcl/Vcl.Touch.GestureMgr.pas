{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.GestureMgr;

interface

uses
  Winapi.Windows, System.SysUtils, System.Generics.Collections, System.Classes,
  Vcl.Controls, Vcl.ActnList, Vcl.Touch.Gestures;

type
  TGestureCollectionItem = class;
  TGestureManager = class;

  TGestureCollectionItem = class(TCustomGestureCollectionItem)
  private
    FAction: TBasicAction;
    FDeviation: Integer;
    FErrorMargin: Integer;
    FGestureID: TGestureID;
    FName: string;
    FOptions: TGestureOptions;
    FPoints: TGesturePointArray;
    procedure ReadDeviation(Reader: TReader);
    procedure ReadErrorMargin(Reader: TReader);
    procedure ReadGestureID(Reader: TReader);
    procedure ReadName(Reader: TReader);
    procedure ReadOptions(Reader: TReader);
    procedure ReadPoints(Stream: TStream);
    procedure WriteDeviation(Writer: TWriter);
    procedure WriteErrorMargin(Writer: TWriter);
    procedure WriteGestureID(Writer: TWriter);
    procedure WriteName(Writer: TWriter);
    procedure WriteOptions(Writer: TWriter);
    procedure WritePoints(Stream: TStream);
  strict protected
    function GetAction: TBasicAction; override;
    function GetDeviation: Integer; override;
    function GetErrorMargin: Integer; override;
    function GetGestureID: TGestureID; override;
    function GetGestureType: TGestureType; override;
    function GetOptions: TGestureOptions; override;
    function GetName: string; override;
    function GetPoints: TGesturePointArray; override;
    procedure SetAction(const Value: TBasicAction); override;
    procedure SetDeviation(const Value: Integer); override;
    procedure SetErrorMargin(const Value: Integer); override;
    procedure SetGestureID(const Value: TGestureID); override;
    procedure SetName(const Value: string); override;
    procedure SetOptions(const Value: TGestureOptions); override;
    procedure SetPoints(const Value: TGesturePointArray); override;
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Action;
  end;

  TGestureNotification = (gnChanged, gnDeleted);

  TGestureItemChangeEvent = procedure(Sender: TObject; Action: TGestureNotification;
    Item: TCustomGestureCollectionItem) of object;

  TGestureCollection = class(TCustomGestureCollection)
  strict private
    FGestureManager: TGestureManager;
    FOnItemChange: TGestureItemChangeEvent;
  protected
    FStreamGestureDetails: Boolean; // For internal use only
    function GetGestureManager: TCustomGestureManager; override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create; overload; virtual;
    constructor Create(AGestureManager: TGestureManager); overload; virtual;
    destructor Destroy; override;
    function Add: TGestureCollectionItem;
    function AddGesture: TCustomGestureCollectionItem; override;
    function FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; overload; override;
    function FindGesture(const AName: string): TCustomGestureCollectionItem; overload; override;
    function GetUniqueGestureID: TGestureID; override;
    procedure RemoveGesture(AGestureID: TGestureID); override;
    property OnItemChange: TGestureItemChangeEvent read FOnItemChange write FOnItemChange;
  end;

  TGestureManager = class(TCustomGestureManager)
  strict private
    class var FInstanceList: TList<TCustomGestureManager>;
    class var FNextGestureID: TGestureID;
    class var FRegisteredGestures: TGestureCollection;
    class constructor Create;
    class destructor Destroy;
    class function GetRegisteredGestureCount: Integer; static;
    class function GetRegisteredGestures: TGestureArray; static;
  strict private type
    TGestureControlList = TDictionary<TControl, TGestureCollection>;
    TDesignerHook = procedure(AGesture: TCustomGestureCollectionItem) of object;
  strict private
    FControls: TGestureControlList;
    FFileName: TFileName;
    FLoading: Boolean;
    FNotifyList: TList<TControl>;
    FRecordedGestures: TGestureCollection;
    FSaved: Boolean;
    FStreamCollection: TCollection;
    FUpdating: Boolean;
    procedure GestureItemChanged(Sender: TObject;
      Action: TGestureNotification; Item: TCustomGestureCollectionItem);
    function GetCustomGestureCount: Integer;
    function GetCustomGestures: TGestureArray;
    function GetRecordedGestureCount: Integer;
    function GetRecordedGestures: TGestureArray;
    procedure ReadControlData(Reader: TReader);
    procedure ReadRecordedGestures(Reader: TReader);
    procedure WriteControlData(Writer: TWriter);
    procedure WriteRecordedGestures(Writer: TWriter);
  protected
    class var FDesignerHook: TDesignerHook; // For internal use only
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetGestureList(Control: TControl): TGestureArray; override;
    function GetStandardGestures(AControl: TControl): TStandardGestures; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifyControls(Msg: Cardinal; Operation: Integer; GestureID: TGestureID);
    procedure SetStandardGestures(AControl: TControl; AStandardGestures: TStandardGestures); override;
    property Loading: Boolean read FLoading;
  public
    class function RegisterGesture(AGesture: TCustomGestureCollectionItem): TGestureID; static;
    class procedure UnregisterGesture(AGesture: TGestureID); static;
    class property RegisteredGestureCount: Integer read GetRegisteredGestureCount;
    class property RegisteredGestures: TGestureArray read GetRegisteredGestures;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddRecordedGesture(Item: TCustomGestureCollectionItem): TGestureID; override;
    procedure ChangeNotification(AControl: TControl);
    function FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindCustomGesture(const AName: string): TCustomGestureCollectionItem; override;
    function FindGesture(AControl: TControl; AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindGesture(AControl: TControl; const AName: string): TCustomGestureCollectionItem; override;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RegisterControl(AControl: TControl); override;
    procedure RemoveChangeNotification(AControl: TControl);
    procedure RemoveRecordedGesture(AGestureID: TGestureID); override;
    procedure RemoveRecordedGesture(AGesture: TCustomGestureCollectionItem); override;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(S: TStream);
    function SelectGesture(AControl: TControl; AGestureID: TGestureID): Boolean; override;
    function SelectGesture(AControl: TControl; const AName: string): Boolean; override;
    procedure SetRecordedGestures(Gestures: TGestureArray); // For designtime support only
    procedure UnregisterControl(AControl: TControl); override;
    procedure UnselectGesture(AControl: TControl; AGestureID: TGestureID); override;
    property CustomGestureCount: Integer read GetCustomGestureCount;
    property CustomGestures: TGestureArray read GetCustomGestures;
    property RecordedGestureCount: Integer read GetRecordedGestureCount;
    property RecordedGestures: TGestureArray read GetRecordedGestures;
  published
    property FileName: TFileName read FFileName write FFileName;
  end;

implementation

uses
  System.UITypes,
  System.RTLConsts, Vcl.Consts, Vcl.Touch.GestureConsts, System.Types, Vcl.Dialogs, Vcl.Forms;

{ TGestureListItem }

constructor TGestureCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FDeviation := 20;
  FErrorMargin := 20;
  FOptions := [goUniDirectional, goRotate];
end;

destructor TGestureCollectionItem.Destroy;
begin
  if (FAction <> nil) and (Collection <> nil) and
     (TGestureCollection(Collection).GestureManager <> nil) then
    FAction.RemoveFreeNotification(TGestureCollection(Collection).GestureManager);
  inherited;
end;

procedure TGestureCollectionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TGestureCollectionItem then
    with TGestureCollectionItem(Dest) do
    begin
      FAction := Self.FAction;
      FDeviation := Self.FDeviation;
      FErrorMargin := Self.FErrorMargin;
      FGestureID := Self.FGestureID;
      FName := Self.FName;
      FOptions := Self.FOptions;
      FPoints := Copy(Self.FPoints, 0, Length(Self.FPoints));
    end
  else
    inherited;
end;

procedure TGestureCollectionItem.DefineProperties(Filer: TFiler);

  function DoStream: Boolean;
  begin
    // GestureType will be gtNone while streaming in
    Result := ((GestureType = gtRecorded) or (GestureType = gtNone)) and
      TGestureCollection(Collection).FStreamGestureDetails;
  end;

begin
  inherited;
  Filer.DefineProperty('Deviation', ReadDeviation, WriteDeviation, DoStream);      // do not localize
  Filer.DefineProperty('ErrorMargin', ReadErrorMargin, WriteErrorMargin, DoStream);// do not localize
  Filer.DefineProperty('GestureID', ReadGestureID, WriteGestureID, GestureType <> gtRegistered);  // do not localize
  Filer.DefineProperty('Name', ReadName, WriteName, (GestureType = gtRegistered) or DoStream);    // do not localize
  Filer.DefineProperty('Options', ReadOptions, WriteOptions, DoStream);    // do not localize
  Filer.DefineBinaryProperty('Points', ReadPoints, WritePoints, DoStream); // do not localize
end;

function TGestureCollectionItem.GetAction: TBasicAction;
begin
  Result := FAction;
end;

function TGestureCollectionItem.GetDeviation: Integer;
begin
  Result := FDeviation;
end;

function TGestureCollectionItem.GetDisplayName: string;
var
  S: string;
begin
  if GestureType = gtStandard then
  begin
    GestureToIdent(FGestureID, S);
    Result := Copy(S, 4, Length(S) - 3); // trim "sgi" from ID name
  end
  else
    Result := FName;
end;

function TGestureCollectionItem.GetErrorMargin: Integer;
begin
  Result := FErrorMargin;
end;

function TGestureCollectionItem.GetGestureID: TGestureID;
begin
  Result := FGestureID;
end;

function TGestureCollectionItem.GetGestureType: TGestureType;
begin
  case FGestureID of
    sgiNoGesture: Result := gtNone;
    sgiFirst..sgiLast: Result := gtStandard;
    cgiFirst..cgiLast: Result := gtRecorded;
    rgiFirst..rgiLast: Result := gtRegistered;
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [FGestureID]);
  end;
end;

function TGestureCollectionItem.GetName: string;
begin
  case GestureType of
    gtNone, gtStandard:
      Result := DisplayName;
    gtRecorded, gtRegistered:
      Result := FName;
  end;
end;

function TGestureCollectionItem.GetOptions: TGestureOptions;
begin
  Result := FOptions;
end;

function TGestureCollectionItem.GetPoints: TGesturePointArray;
begin
  Result := FPoints;
end;

procedure TGestureCollectionItem.ReadDeviation(Reader: TReader);
begin
  FDeviation := Reader.ReadInteger;
end;

procedure TGestureCollectionItem.ReadErrorMargin(Reader: TReader);
begin
  FErrorMargin := Reader.ReadInteger;
end;

procedure TGestureCollectionItem.ReadGestureID(Reader: TReader);
var
  I: Integer;
  Ident: string;
begin
  if Reader.NextValue = vaIdent then
  begin
    Ident := Reader.ReadIdent;
    if IdentToGesture(Ident, I) then
      FGestureID := I
    else
    begin
      if TryStrToInt(Ident, I) then
        FGestureID := I
      else
        raise EReadError.CreateRes(@SInvalidPropertyValue);
    end;
  end
  else
    FGestureID := Reader.ReadInteger;
end;

procedure TGestureCollectionItem.ReadName(Reader: TReader);
begin
  FName := Reader.ReadString;
end;

procedure TGestureCollectionItem.ReadOptions(Reader: TReader);
begin
  FOptions := TGestureOptions(Byte(Reader.ReadInteger));
end;

const
  StreamVersion1 = 1;

procedure TGestureCollectionItem.ReadPoints(Stream: TStream);
var
  I, Len: Integer;
  LPoint: TSmallPoint;
  LStreamVersion: Byte;
begin
  Stream.Read(LStreamVersion, SizeOf(Byte));
  if LStreamVersion <> StreamVersion1 then
    raise EGestureException.CreateRes(@SInvalidStreamFormat);

  Stream.Read(Len, SizeOf(Integer));
  SetLength(FPoints, Len);

  for I := 0 to Len - 1 do
  begin
    Stream.Read(LPoint, SizeOf(LPoint));
    FPoints[I] := SmallPointToPoint(LPoint);
  end;
end;

procedure TGestureCollectionItem.SetAction(const Value: TBasicAction);
begin
  if Value <> FAction then
  begin
    if (FAction <> nil) and (TGestureCollection(Collection).GestureManager <> nil) then
      FAction.RemoveFreeNotification(TGestureCollection(Collection).GestureManager);
    FAction := Value;
    if (FAction <> nil) and (TGestureCollection(Collection).GestureManager <> nil) then
      FAction.FreeNotification(TGestureCollection(Collection).GestureManager);
    Changed(False);
  end;
end;

procedure TGestureCollectionItem.SetDeviation(const Value: Integer);
begin
  if Value <> FDeviation then
  begin
    FDeviation := Value;
    Changed(False);
  end;
end;

procedure TGestureCollectionItem.SetErrorMargin(const Value: Integer);
begin
  if Value <> FErrorMargin then
  begin
    FErrorMargin := Value;
    Changed(False);
  end;
end;

procedure TGestureCollectionItem.SetGestureID(const Value: TGestureID);
begin
  FGestureID := Value;
end;

procedure TGestureCollectionItem.SetName(const Value: string);
begin
  if Value <> FName then
  begin
    if Collection <> nil then
    begin
      if TCustomGestureCollection(Collection).FindGesture(Value) <> nil then
        raise EGestureException.CreateResFmt(@SDuplicateGestureName, [Value]);
    end;
    FName := Value;
    Changed(False);
  end;
end;

procedure TGestureCollectionItem.SetOptions(const Value: TGestureOptions);
begin
  if Value <> FOptions then
  begin
    FOptions := Value;
    Changed(False);
  end;
end;

procedure TGestureCollectionItem.SetPoints(const Value: TGesturePointArray);
begin
  if Value <> FPoints then
    FPoints := Value;
end;

procedure TGestureCollectionItem.WriteDeviation(Writer: TWriter);
begin
  Writer.WriteInteger(FDeviation);
end;

procedure TGestureCollectionItem.WriteErrorMargin(Writer: TWriter);
begin
  Writer.WriteInteger(FErrorMargin);
end;

procedure TGestureCollectionItem.WriteGestureID(Writer: TWriter);
var
  Ident: string;
begin
  if not GestureToIdent(FGestureID, Ident) then
    Ident := IntToStr(FGestureID);
  Writer.WriteIdent(Ident);
end;

procedure TGestureCollectionItem.WriteName(Writer: TWriter);
begin
  Writer.WriteString(FName);
end;

procedure TGestureCollectionItem.WriteOptions(Writer: TWriter);
begin
  Writer.WriteInteger(Byte(FOptions));
end;

procedure TGestureCollectionItem.WritePoints(Stream: TStream);
var
  I: Integer;
  LPoint: TSmallPoint;
  LStreamVersion: Byte;
begin
  LStreamVersion := StreamVersion1;
  Stream.Write(LStreamVersion, SizeOf(Byte));
  I := Length(FPoints);
  Stream.Write(I, SizeOf(Integer));
  for I := 0 to Length(FPoints) - 1 do
  begin
    LPoint := PointToSmallPoint(FPoints[I]);
    Stream.Write(LPoint, SizeOf(LPoint));
  end;
end;

{ TGestureCollection }

constructor TGestureCollection.Create;
begin
  inherited Create(TGestureCollectionItem);
  FStreamGestureDetails := False;
end;

constructor TGestureCollection.Create(AGestureManager: TGestureManager);
begin
  Create;
  FGestureManager := AGestureManager;
end;

destructor TGestureCollection.Destroy;
begin
  inherited;
end;

function TGestureCollection.AddGesture: TCustomGestureCollectionItem;
var
  LItem: TGestureCollectionItem;
  LGestureID: TGestureID;
begin
  LGestureID := GetUniqueGestureID;
  LItem := TGestureCollectionItem(inherited Add);
  LItem.GestureID := LGestureID;
  Result := LItem;
end;

function TGestureCollection.Add: TGestureCollectionItem;
begin
  Result := TGestureCollectionItem(AddGesture);
end;

function TGestureCollection.FindGesture(AGestureID: TGestureID): TCustomGestureCollectionItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].GestureID = AGestureID then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TGestureCollection.FindGesture(const AName: string): TCustomGestureCollectionItem;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if CompareText(Items[I].Name, AName, loUserLocale) = 0 then
    begin
      Result := Items[I];
      Break;
    end;
end;

function TGestureCollection.GetUniqueGestureID: TGestureID;
begin
  Result := cgiLast;
  while FindGesture(Result) <> nil do
    Dec(Result);
end;

function TGestureCollection.GetGestureManager: TCustomGestureManager;
begin
  Result := FGestureManager;
end;

procedure TGestureCollection.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if (Action = System.Classes.TCollectionNotification.cnDeleting) and Assigned(FOnItemChange) then
    FOnItemChange(Self, gnDeleted, TCustomGestureCollectionItem(Item));
end;

procedure TGestureCollection.RemoveGesture(AGestureID: TGestureID);
var
  LGesture: TCustomGestureCollectionItem;
begin
  LGesture := FindGesture(AGestureID);
  if LGesture <> nil then
    LGesture.Free;
end;

procedure TGestureCollection.Update(Item: TCollectionItem);
begin
  if Assigned(FOnItemChange) then
    FOnItemChange(Self, gnChanged, TCustomGestureCollectionItem(Item));
end;

type
  TGestureStreamData = class(TCollectionItem)
  private
    FControl: TControl;
    FCollection: TGestureCollection;
  published
    constructor Create(Collection: TCollection); override;
    property Control: TControl read FControl write FControl;
    property Collection: TGestureCollection read FCollection write FCollection;
  end;
  TGestureStreamDataClass = class of TGestureStreamData;

  TGestureStreamList = class(TCollection)
  private
    FReading: Boolean;
    function GetItem(Index: Integer): TGestureStreamData;
    procedure SetItem(Index: Integer; const Value: TGestureStreamData);
  public
    constructor Create(Reading: Boolean);
    function Add: TGestureStreamData;
    property Items[Index: Integer]: TGestureStreamData read GetItem write SetItem; default;
  end;

{ TGestureStreamData }

constructor TGestureStreamData.Create(Collection: TCollection);
begin
  inherited;
  if TGestureStreamList(Collection).FReading then
    FCollection := TGestureCollection.Create;
end;

{ TGestureStreamList }

constructor TGestureStreamList.Create(Reading: Boolean);
begin
  inherited Create(TGestureStreamData);
  FReading := Reading;
end;

function TGestureStreamList.Add: TGestureStreamData;
begin
  Result := TGestureStreamData(inherited Add);
end;

function TGestureStreamList.GetItem(Index: Integer): TGestureStreamData;
begin
  Result := TGestureStreamData(inherited GetItem(Index));
end;

procedure TGestureStreamList.SetItem(Index: Integer; const Value: TGestureStreamData);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

{ TCustomGestureManager }

class constructor TGestureManager.Create;
begin
  FInstanceList := TList<TCustomGestureManager>.Create;
  FRegisteredGestures := TGestureCollection.Create;
  FNextGestureID := rgiLast;
end;

constructor TGestureManager.Create(AOwner: TComponent);
begin
  inherited;
  FControls := TGestureControlList.Create;
  FInstanceList.Add(Self);
  FRecordedGestures := TGestureCollection.Create;
  FRecordedGestures.OnItemChange := GestureItemChanged;
  FNotifyList := TList<TControl>.Create;
  FUpdating := False;
end;

class destructor TGestureManager.Destroy;
begin
  FreeAndNil(FInstanceList);
  FreeAndNil(FRegisteredGestures);
end;

destructor TGestureManager.Destroy;
begin
  FInstanceList.Remove(Self);
  FreeAndNil(FControls);
  FreeAndNil(FRecordedGestures);
  FreeAndNil(FNotifyList);
  inherited;
end;

function TGestureManager.AddRecordedGesture(Item: TCustomGestureCollectionItem): TGestureID;
var
  NewItem: TGestureCollectionItem;
begin
  if FRecordedGestures.FindGesture(Item.Name) <> nil then
    raise EGestureException.CreateResFmt(@SDuplicateRecordedGestureName, [Item.Name]);

  NewItem := FRecordedGestures.Add;
  Result := NewItem.GestureID;
  NewItem.Assign(Item);
  NewItem.GestureID := Result;
  NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnAdded, Result);
end;

procedure TGestureManager.ChangeNotification(AControl: TControl);
begin
  if AControl <> nil then
  begin
    FNotifyList.Add(AControl);
    AControl.FreeNotification(Self);
  end;
end;

procedure TGestureManager.DefineProperties(Filer: TFiler);

  function StreamData: Boolean;
  var
    P: TPair<TControl, TGestureCollection>;
  begin
    Result := False;
    for P in FControls do
      if P.Value.Count > 0 then
      begin
        Result := True;
        Break;
      end;
  end;

begin
  inherited;
  Filer.DefineProperty('CustomGestures', ReadRecordedGestures, WriteRecordedGestures, FRecordedGestures.Count > 0); // do not localize
  Filer.DefineProperty('GestureData', ReadControlData, WriteControlData, StreamData); // do not localize
end;

function TGestureManager.FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := FRecordedGestures.FindGesture(AGestureID);
  if Result = nil then
    Result := FRegisteredGestures.FindGesture(AGestureID);
end;

function TGestureManager.FindCustomGesture(const AName: string): TCustomGestureCollectionItem;
begin
  Result := FRecordedGestures.FindGesture(AName);
  if Result = nil then
    Result := FRegisteredGestures.FindGesture(AName);
end;

function TGestureManager.FindGesture(AControl: TControl;
  const AName: string): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AName);
end;

function TGestureManager.FindGesture(AControl: TControl;
  AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AGestureID);
end;

procedure TGestureManager.GestureItemChanged(Sender: TObject;
  Action: TGestureNotification; Item: TCustomGestureCollectionItem);
var
  I: Integer;
  LAction: TBasicAction;
  P: TPair<TControl, TGestureCollection>;
begin
  case Action of
    gnChanged:
      if Item <> nil then
      begin
        // Refresh gesture items preserving the Action property
        for P in FControls do
          for I := P.Value.Count - 1 downto 0 do
            if (P.Value[I].GestureID = Item.GestureID) then
            begin
              LAction := P.Value[I].Action;
              P.Value[I].Assign(Item);
              P.Value[I].Action := LAction;
            end;
        NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnModified, Item.GestureID);
      end;
    gnDeleted:
      if not FUpdating and (Item <> nil) then
        // Remove Item.GestureID from all control's gesture lists
        for P in FControls do
          for I := P.Value.Count - 1 downto 0 do
            if (P.Value[I].GestureID = Item.GestureID) then
              P.Value.Delete(I);
  end;
end;

function TGestureManager.GetCustomGestureCount: Integer;
begin
  Result := FRecordedGestures.Count + FRegisteredGestures.Count;
end;

function TGestureManager.GetCustomGestures: TGestureArray;
var
  LItems: TGestureArray;
begin
  Result := RecordedGestures;
  if FRegisteredGestures.Count > 0 then
  begin
    LItems := RegisteredGestures;
    SetLength(Result, Length(Result) + Length(LItems));
      Move(LItems[0], Result[RecordedGestureCount], Length(LItems) * SizeOf(LItems[0]));
  end;
end;

function TGestureManager.GetGestureList(Control: TControl): TGestureArray;
var
  LList: TCustomGestureCollection;
  I: Integer;
begin
  if FControls.ContainsKey(Control) then
    LList := FControls.Items[Control]
  else
    raise EGestureException.CreateRes(@SControlNotFound);

  SetLength(Result, LList.Count);
  for I := 0 to LList.Count - 1 do
    Result[I] := LList[I];
end;

function TGestureManager.GetRecordedGestureCount: Integer;
begin
  Result := FRecordedGestures.Count;
end;

function TGestureManager.GetRecordedGestures: TGestureArray;
var
  Count: Integer;
  Item: TCollectionItem;
begin
  Count := 0;
  SetLength(Result, FRecordedGestures.Count);
  for Item in FRecordedGestures do
  begin
    Result[Count] := TCustomGestureCollectionItem(Item);
    Inc(Count);
  end;
  SetLength(Result, Count);
end;

class function TGestureManager.GetRegisteredGestureCount: Integer;
begin
  Result := FRegisteredGestures.Count;
end;

class function TGestureManager.GetRegisteredGestures: TGestureArray;
var
  Count: Integer;
  Item: TCollectionItem;
begin
  Count := 0;
  SetLength(Result, FRegisteredGestures.Count);
  for Item in FRegisteredGestures do
  begin
    Result[Count] := TCustomGestureCollectionItem(Item);
    Inc(Count);
  end;
  SetLength(Result, Count);
end;

function TGestureManager.GetStandardGestures(AControl: TControl): TStandardGestures;
var
  I: Integer;
  List: TGestureCollection;
begin
  Result := [];

  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Add predefined gestures to set
  for I := 0 to List.Count - 1 do
    if List[I].GestureType = gtStandard then
      Include(Result, TStandardGesture(List[I].GestureID));
end;

procedure TGestureManager.Loaded;
var
  S: string;
  I, J: Integer;
  LControl: TControl;
  LStreamCollection: TGestureStreamList;
  LItem, LSourceItem: TCustomGestureCollectionItem;
  MissingGestures: TList<TCustomGestureCollectionItem>;

  // Copy properties except Action from Source to Dest
  procedure UpdateProperties(Source, Dest: TCustomGestureCollectionItem);
  var
    LAction: TBasicAction;
  begin
    if Source <> nil then
    begin
      LAction := Dest.Action;
      Dest.Assign(Source);
      Dest.Action := LAction;
    end;
  end;

begin
  inherited Loaded;
  if FLoading then Exit;
  if not (csDesigning in ComponentState) and FileExists(FFileName) then
    LoadFromFile(FFileName)
  else if FStreamCollection <> nil then
  begin
    MissingGestures := TList<TCustomGestureCollectionItem>.Create;
    try
      LStreamCollection := TGestureStreamList(FStreamCollection);
      for I := 0 to FStreamCollection.Count - 1 do
      begin
        LControl := LStreamCollection[I].Control;
        if LControl is TWinControl then
          RegisterControl(TWinControl(LControl))
        else
          RegisterControl(LControl);

        // Free any existing collection rather than assign the new one to it
        // so linked component references can be fixed up later.
        if FControls.Items[LControl] <> nil then
          FControls.Items[LControl].Free;
        FControls.Items[LControl] := LStreamCollection[I].Collection;

        // Add properties to items for custom and registered gestures.
        // For custom gestures these are streamed once with the GestureManager,
        // with only the ID streamed for each control. For registered
        // gestures only the name is streamed since the ID may change.
        for J := 0 to FControls.Items[LControl].Count - 1 do
        begin
          LItem := FControls.Items[LControl][J];
          case LItem.GestureType of
            gtRecorded:
              begin
                LSourceItem := FRecordedGestures.FindGesture(LItem.GestureID);
                UpdateProperties(LSourceItem, LItem);
              end;
            // Registered gestures will appear as gtNone since only the name
            // was streamed. Once the gesture properties have been assigned,
            // they will appear as gtRegistsred.
            gtNone:
              begin
                LSourceItem := FRegisteredGestures.FindGesture(LItem.Name);
                if LSourceItem <> nil then
                  UpdateProperties(LSourceItem, LItem)
                else
                  MissingGestures.Add(LItem);
              end;
          end;
        end;

        // If any registered gestures weren't found, display a message and
        // free the corresponding collection items. Don't throw and exception
        // as we want the application to continue lolading normally.
        if MissingGestures.Count > 0 then
        begin
          S := '';
          for LItem in MissingGestures do
          begin
            S := S + LItem.Name + #13#10;
            LItem.Free;
          end;
          MessageDlg(Format(SRegisteredGestureNotFound, [S]), mtError, [mbClose], 0);
        end;
      end;
    finally
      MissingGestures.Free;
    end;
    FreeAndNil(FStreamCollection);
  end;
end;

procedure TGestureManager.LoadFromFile(const Filename: string);
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyWrite);
  try
    try
      LoadFromStream(LStream);
    except
      //  swallow exceptions here because we still want the app to start
      FreeAndNil(LStream);
      if MessageDlg(Format(SErrorLoadingFile, [FileName]), mtError,
         [mbYes, mbNo], 0) = mrYes then
        DeleteFile(FileName);
    end;
  finally
    LStream.Free;
  end;
end;

procedure TGestureManager.LoadFromStream(S: TStream);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  FLoading := True;
  try
    Stream.LoadFromStream(S);
    Stream.Position := 0;
    Stream.ReadComponent(Self);
    inherited Loaded;  // Reset the csLoading flag
  finally
    FLoading := False;
    Stream.Free;
  end;
  NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRefreshAll, 0);
end;

procedure TGestureManager.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  LGestureID: TGestureID;
  LCustomGestureChanged: Boolean;
  LStandardGestureChanged: Boolean;
  P: TPair<TControl, TGestureCollection>;
begin
  inherited;
  if Application.Terminated and (Length(FFileName) > 0) and not FSaved then
  begin
    SaveToFile(FFileName);
    FSaved := True;
  end;
  if Operation = opRemove then
  begin
    if AComponent is TBasicAction then
    begin
      // Remove Action from gestures
      LGestureID := 0; // suppress compiler warning
      LCustomGestureChanged := False;
      LStandardGestureChanged := False;
      for P in FControls do
        for I := 0 to P.Value.Count - 1 do
          if (P.Value[I].Action = AComponent) then
          begin
            P.Value[I].Action := nil;
            LGestureID := P.Value[I].GestureID;
            if P.Value[I].GestureType = gtStandard then
              LStandardGestureChanged := True
            else
              LCustomGestureChanged := True;
          end;

      // Notify controls to refresh gesture lists
      if LStandardGestureChanged then
        NotifyControls(CM_STANDARDGESTURESCHANGED, gcnModified, LGestureID);
      if LCustomGestureChanged then
        NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnModified, LGestureID);
    end
    else
      if AComponent is TControl then
      begin
        if FNotifyList.Contains(TControl(AComponent)) then
          FNotifyList.Remove(TControl(AComponent))
        else
          if not (csDestroying in ComponentState) then
            UnregisterControl(TControl(AComponent));
      end;
  end;
end;

procedure TGestureManager.NotifyControls(Msg: Cardinal; Operation: Integer;
  GestureID: TGestureID);
var
  I: Integer;
begin
  for I := 0 to FNotifyList.Count - 1 do
    FNotifyList[I].Perform(Msg, Operation, GestureID);
end;

procedure TGestureManager.ReadRecordedGestures(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FRecordedGestures);
end;

procedure TGestureManager.ReadControlData(Reader: TReader);
begin
  FStreamCollection := TGestureStreamList.Create(csReading in ComponentState);
  Reader.ReadValue;
  Reader.ReadCollection(FStreamCollection);
end;

procedure TGestureManager.RegisterControl(AControl: TControl);
begin
  if AControl <> nil then
  begin
    // Create entry in dictionary
    if not FControls.ContainsKey(AControl) then
      FControls.Add(AControl, TGestureCollection.Create(Self));

    // Copy standard gestures into the control's collection
    if not (csLoading in ComponentState) then
      StandardGestures[AControl] := AControl.Touch.StandardGestures;

    // Create a gesture engine if not at design time
    if not (csDesigning in AControl.ComponentState) then
      TGestureEngine.CreateEngine(AControl);
  end;
end;

class function TGestureManager.RegisterGesture(AGesture: TCustomGestureCollectionItem): TGestureID;
var
  LItem: TGestureCollectionItem;
  LGestureManager: TCustomGestureManager;
begin
  if FNextGestureID = rgiFirst then
    raise EGestureException.CreateRes(@STooManyRegisteredGestures);

  if FRegisteredGestures.FindGesture(AGesture.Name) <> nil then
    raise EGestureException.CreateResFmt(@SDuplicateRegisteredGestureName, [AGesture.Name]);

  LItem := FRegisteredGestures.Add;
  LItem.Assign(AGesture);
  LItem.GestureID := FNextGestureID;
  Result := LItem.GestureID;
  Dec(FNextGestureID);

  if Assigned(FDesignerHook) then
    FDesignerHook(AGesture);

  for LGestureManager in FInstanceList do
    if LGestureManager is TGestureManager then
      TGestureManager(LGestureManager).NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnAdded, Result);
end;

procedure TGestureManager.RemoveChangeNotification(AControl: TControl);
begin
  if FNotifyList.Contains(AControl) then
  begin
    FNotifyList.Remove(AControl);
    AControl.RemoveFreeNotification(Self);
  end;
end;

procedure TGestureManager.RemoveRecordedGesture(AGesture: TCustomGestureCollectionItem);
begin
  if AGesture <> nil then
  begin
    NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRemoved, AGesture.GestureID);
    AGesture.Free;
  end;
end;

procedure TGestureManager.RemoveRecordedGesture(AGestureID: TGestureID);
begin
  RemoveRecordedGesture(FRecordedGestures.FindGesture(AGestureID));
end;

procedure TGestureManager.SaveToFile(const Filename: string);
var
  LStream: TStream;
begin
  try
    LStream := TFileStream.Create(ExpandFileName(Filename), fmCreate);
    try
      try
        SaveToStream(LStream);
      except
        //  catch all exceptions because we still want the app to shutdown
      end;
    finally
      LStream.Free;
    end;
  except
    ShowMessage(SUnableToSaveSettings);
  end;
end;

procedure TGestureManager.SaveToStream(S: TStream);
var
  BinaryStream: TMemoryStream;
begin
  BinaryStream := TMemoryStream.Create;
  try
    BinaryStream.WriteComponent(Self);
    BinaryStream.Position := 0;
    S.CopyFrom(BinaryStream, BinaryStream.Size);
  finally
    BinaryStream.Free;
  end;
end;

                                                                                    
function TGestureManager.SelectGesture(AControl: TControl;
  AGestureID: TGestureID): Boolean;
var
  LGesture: TCustomGestureCollectionItem;
  LGestureList: TCustomGestureCollection;
begin
  if FControls.ContainsKey(AControl) then
    LGestureList := FControls.Items[AControl]
  else
    raise EGestureException.CreateRes(@SControlNotFound);

  case AGestureID of
    sgiFirst..sgiLast:
      begin
        LGestureList.AddGesture.GestureID := AGestureID;
        Result := True;
      end;
    cgiFirst..cgiLast,
    rgiFirst..rgiLast:
      begin
        LGesture := FindCustomGesture(AGestureID);
        Result := LGesture <> nil;
        if Result then
          LGestureList.AddGesture.Assign(LGesture);
      end
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [AGestureID]);
  end;
end;

function TGestureManager.SelectGesture(AControl: TControl;
  const AName: string): Boolean;
var
  LGestureID: TGestureID;
  LGesture: TCustomGestureCollectionItem;
begin
  LGesture := FindCustomGesture(AName);
  Result := LGesture <> nil;
  if not Result then
    Result := FindStandardGesture(AName, LGestureID)
  else
    LGestureID := LGesture.GestureID;

  if Result then
    Result := SelectGesture(AControl, LGestureID)
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureName, [AName]);
end;

procedure TGestureManager.SetRecordedGestures(Gestures: TGestureArray);
var
  I, J: Integer;
  Item: TCustomGestureCollectionItem;
  P: TPair<TControl, TGestureCollection>;
begin
  FUpdating := True;
  try
    FRecordedGestures.Clear;
    for Item in Gestures do
      FRecordedGestures.Add.Assign(Item);
  finally
    FUpdating := False;
  end;

  // Allow designers to modify list
  if not (csDesigning in ComponentState) then
  begin
    // Iterate through each control's list and remove custom gestures
    for P in FControls do
      for I := P.Value.Count - 1 downto 0 do
        if (P.Value[I].GestureType = gtRecorded) then
          P.Value.Delete(I);
  end
  else
    // Iterate through each control's list and remove gesture ID's
    // that don't exist in the updated FCustomGestures list
                                                                            
    for P in FControls do
      for I := P.Value.Count - 1 downto 0 do
        for J := 0 to FRecordedGestures.Count - 1 do
        begin
          if (P.Value[I].GestureType = gtRecorded) and
             (FRecordedGestures.FindGesture(P.Value[I].GestureID) = nil) then
            P.Value.Delete(I);
        end;

  // Notify controls registered for notifications
  NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRefreshAll, 0);
end;

procedure TGestureManager.SetStandardGestures(AControl: TControl;
  AStandardGestures: TStandardGestures);
var
  I: Integer;
  List: TGestureCollection;
  LGesture: TStandardGesture;
begin
  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Remove any predefined gestures
  for I := List.Count - 1 downto 0 do
    if List[I].GestureType = gtStandard then
      List[I].Free;

  // Add new set of predefined gestures
  for LGesture := Low(TStandardGesture) to High(TStandardGesture) do
    if LGesture in AStandardGestures then
      List.Add.GestureID := TGestureID(LGesture);
end;

procedure TGestureManager.UnregisterControl(AControl: TControl);
var
  List: TGestureCollection;
begin
  if (AControl <> nil) and FControls.ContainsKey(AControl) then
  begin
    List := FControls.Items[AControl];
    FControls.Remove(AControl);
    List.Free;
  end;
end;

class procedure TGestureManager.UnregisterGesture(AGesture: TGestureID);
var
  LItem: TCustomGestureCollectionItem;
  LGestureManager: TCustomGestureManager;
begin
  for LGestureManager in FInstanceList do
    if LGestureManager is TGestureManager then
      TGestureManager(LGestureManager).NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRemoved, AGesture);

  LItem := FRegisteredGestures.FindGesture(AGesture);
  if LItem <> nil then
    LItem.Free;
end;

procedure TGestureManager.UnselectGesture(AControl: TControl; AGestureID: TGestureID);
var
  LGestureList: TCustomGestureCollection;
begin
  if FControls.ContainsKey(AControl) then
    LGestureList := FControls.Items[AControl]
  else
    raise EGestureException.CreateRes(@SControlNotFound);
  LGestureList.RemoveGesture(AGestureID);
end;

procedure TGestureManager.WriteRecordedGestures(Writer: TWriter);
begin
  FRecordedGestures.FStreamGestureDetails := True;
  try
    Writer.WriteCollection(FRecordedGestures);
  finally
    FRecordedGestures.FStreamGestureDetails := False;
  end;
end;

procedure TGestureManager.WriteControlData(Writer: TWriter);
var
  P: TPair<TControl, TGestureCollection>;
  LStreamCollection: TGestureStreamList;
begin
  LStreamCollection := TGestureStreamList.Create(csReading in ComponentState);
  try
    for P in FControls do
      with LStreamCollection.Add do
      begin
        Control := P.Key;
        Collection := P.Value;
      end;

    Writer.WriteCollection(LStreamCollection);
  finally
    LStreamCollection.Free;
  end;
end;

end.
