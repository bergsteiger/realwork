{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Gestures;

interface

uses FMX.Types, System.Classes, System.SysUtils, System.Types,
  System.Generics.Collections, System.UITypes, FMX.ActnList;

const
  // Recorded custom gestures ID range
  cgiFirst = -512;
  cgiLast  = -1;

  // Registered custom gestures ID range
  rgiFirst = -1024;
  rgiLast  = -513;

  CustomGestureTypes: TGestureTypes = [TGestureType.gtRecorded, TGestureType.gtRegistered];

type
  TGesturePoints = TList<TPointF>;

type
  TGestureManager = class;
  TGestureCollectionItem = class;

  TGestureNotification = (gnChanged, gnDeleted);
  TGestureItemChangeEvent = procedure(Sender: TObject; Action: TGestureNotification; Item: TCustomGestureCollectionItem) of object;

  EGestureException = class(Exception);

  TGestureCollectionItem = class(TCustomGestureCollectionItem)
  private
    FActionLink: TActionLink;
    FActionClient: boolean;
    FDeviation: Integer;
    FErrorMargin: Integer;
    FGestureID: TGestureID;
    FName: string;
    FOptions: TGestureOptions;
    FPoints: TGesturePointArray;
    procedure DoActionClientChanged; virtual;
    procedure ReadDeviation(Reader: TReader);
    procedure ReadErrorMargin(Reader: TReader);
    procedure ReadGestureID(Reader: TReader);
    procedure ReadName(Reader: TReader);
    procedure ReadPoints(Stream: TStream);
    procedure SetActionClient(const Value: boolean);
    procedure WriteDeviation(Writer: TWriter);
    procedure WriteErrorMargin(Writer: TWriter);
    procedure WriteGestureID(Writer: TWriter);
    procedure WriteName(Writer: TWriter);
    procedure WritePoints(Stream: TStream);
  strict protected
    function GetAction: TCustomAction; override;
    function GetActionLinkClass: TActionLinkClass; virtual;    
    function GetDeviation: Integer; override;
    function GetErrorMargin: Integer; override;
    function GetGestureID: TGestureID; override;
    function GetGestureType: TGestureType; override;
    function GetName: string; override;
    function GetOptions: TGestureOptions; override;
    function GetPoints: TGesturePointArray; override;
    procedure ActionChange(Sender: TBasicAction; CheckDefaults: Boolean); virtual;
    procedure DoActionChange(Sender: TObject); virtual;
    procedure SetAction(const Value: TCustomAction); override;
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
    property ActionLink: TActionLink read FActionLink write FActionLink;
  published
    property Action;
  end;

  TGestureCollection = class(TCustomGestureCollection)
  strict private
    FGestureManager: TGestureManager;
    FOnItemChange: TGestureItemChangeEvent;
  protected
    FStreamGestureDetails: Boolean; // For internal use only
    function GetGestureManager: TCustomGestureManager; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create; overload; virtual;
    constructor Create(const AGestureManager: TGestureManager); overload; virtual;
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
  strict private
  type
    TGestureControlList = TDictionary<TFmxObject, TGestureCollection>;
    TDesignerHook = procedure(AGesture: TCustomGestureCollectionItem) of object;
  strict private
    FControls: TGestureControlList;
    FFileName: TFileName;
    FLoading: Boolean;
    FNotifyList: TList<TFmxObject>;
    FRecordedGestures: TGestureCollection;
    FSaved: Boolean;
    FStreamCollection: TCollection;
    FUpdating: Boolean;
    procedure GestureItemChanged(Sender: TObject; Action: TGestureNotification; Item: TCustomGestureCollectionItem);
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
    function GetGestureList(Control: TFmxObject): TGestureArray; override;
    function GetStandardGestures(AControl: TFmxObject): TStandardGestures; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetStandardGestures(AControl: TFmxObject; AStandardGestures: TStandardGestures); override;
    property Loading: Boolean read FLoading;
  public
    class function RegisterGesture(const AGesture: TCustomGestureCollectionItem): TGestureID; static;
    class procedure UnregisterGesture(const AGesture: TGestureID); static;
    class property RegisteredGestureCount: Integer read GetRegisteredGestureCount;
    class property RegisteredGestures: TGestureArray read GetRegisteredGestures;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddRecordedGesture(const Item: TCustomGestureCollectionItem): TGestureID; override;
    procedure ChangeNotification(const AControl: TFmxObject);
    function FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindCustomGesture(const AName: string): TCustomGestureCollectionItem; override;
    function FindGesture(const AControl: TFmxObject; AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindGesture(const AControl: TFmxObject; const AName: string): TCustomGestureCollectionItem; override;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RegisterControl(const AControl: TFmxObject); override;
    procedure RemoveChangeNotification(const AControl: TFmxObject);
    procedure RemoveRecordedGesture(AGestureID: TGestureID); override;
    procedure RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem); override;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(const S: TStream);
    function SelectGesture(const AControl: TFmxObject; AGestureID: TGestureID): Boolean; override;
    function SelectGesture(const AControl: TFmxObject; const AName: string): Boolean; override;
    procedure SetRecordedGestures(const Gestures: TGestureArray); // For designtime support only
    procedure UnregisterControl(const AControl: TFmxObject); override;
    procedure UnselectGesture(const AControl: TFmxObject; AGestureID: TGestureID); override;
    property CustomGestureCount: Integer read GetCustomGestureCount;
    property CustomGestures: TGestureArray read GetCustomGestures;
    property RecordedGestureCount: Integer read GetRecordedGestureCount;
    property RecordedGestures: TGestureArray read GetRecordedGestures;
  published
    property FileName: TFileName read FFileName write FFileName;
  end;

  TGestureList = TList<TCustomGestureCollectionItem>;

  TGestureEngineClass = class of TCustomGestureEngine;
  TCustomGestureRecognizer = class;
  TCustomGestureRecognizerClass = class of TCustomGestureRecognizer;

  TGestureEngine = class(TCustomGestureEngine)
  strict private
    FInitialPoint: TPointF;
    class var FSensitivity: Integer;
    class constructor Create;
    function GetPointCount: Integer;
    function GetPoints: TGesturePointArray;
    class procedure SetSensitivity(const Value: Integer); static;
  protected type
    TGestureEngineType = class of TGestureEngine;
  protected
    FPoints: TGesturePoints;
    class var FGestureEngineType: TGestureEngineType;
    class function GetGestureEngine(const AControl: TFmxObject): TGestureEngine; virtual; abstract;
    class procedure GetCompleteGestureList(const AControl: TFmxObject; const AGestureList: TGestureList);
    procedure SetInitialPoint(const Value: TPointF); virtual;
  public
    class procedure CreateEngine(const AControl: TFmxObject);
    class property Sensitivity: Integer read FSensitivity write SetSensitivity;
    property InitialPoint: TPointF read FInitialPoint write SetInitialPoint;
    property PointCount: Integer read GetPointCount;
    property Points: TGesturePointArray read GetPoints;
    procedure BroadcastGesture(const AControl: TFmxObject; EventInfo: TGestureEventInfo); override;
    procedure ClearPoints;
    destructor Destroy; override;
  end;

  TCustomGestureRecognizer = class
  public
    function Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; virtual; abstract;
    function NormalizePoints(const Points: array of TPointF): TGesturePointArray; virtual; abstract;
    function ScalePoints(const Points, GesturePoints: array of TPointF;
      MinScale: Integer; Scaling: Boolean = False): TGesturePointArray; virtual; abstract;
    procedure Reset; virtual; abstract;
  end;

  TStandardGestureData = record
    Points: TGesturePointArray;
    GestureID: TGestureID;
    Options: TGestureOptions;
    Deviation: Integer;
    ErrorMargin: Integer;
  end;
  
  TOpenCustomAction = class (TCustomAction)
  end;

function FindStandardGesture(AGestureID: TGestureID; var AGestureData: TStandardGestureData): Boolean; overload;
function FindStandardGesture(const AName: string; var AGestureID: TGestureID): Boolean; overload;

function GestureToIdent(ID: Integer; var Ident: string): Boolean;
function IdentToGesture(const Ident: string; var ID: Integer): Boolean;


implementation


uses FMX.Dialogs, FMX.Consts, FMX.Forms, System.RTLConsts, System.Math, System.Actions
{$IFDEF MSWINDOWS}
    , FMX.Gestures.Win
{$ENDIF}
{$IFDEF MACOS}
{$IFNDEF NEXTGEN}
    , FMX.Gestures.Mac
{$ENDIF}
{$ENDIF}
{$IFDEF IOS}
  , FMX.Gestures.iOS
{$ENDIF}
;

const

  GestureNameMap: array[0..34] of TIdentMapEntry = (
    (Value: sgiNoGesture;       Name: 'sgiNoGesture'),
    (Value: sgiLeft;            Name: 'sgiLeft'),
    (Value: sgiRight;           Name: 'sgiRight'),
    (Value: sgiUp;              Name: 'sgiUp'),
    (Value: sgiDown;            Name: 'sgiDown'),
    (Value: sgiUpLeft;          Name: 'sgiUpLeft'),
    (Value: sgiUpRight;         Name: 'sgiUpRight'),
    (Value: sgiDownLeft;        Name: 'sgiDownLeft'),
    (Value: sgiDownRight;       Name: 'sgiDownRight'),
    (Value: sgiLeftUp;          Name: 'sgiLeftUp'),
    (Value: sgiLeftDown;        Name: 'sgiLeftDown'),
    (Value: sgiRightUp;         Name: 'sgiRightUp'),
    (Value: sgiRightDown;       Name: 'sgiRightDown'),
    (Value: sgiUpDown;          Name: 'sgiUpDown'),
    (Value: sgiDownUp;          Name: 'sgiDownUp'),
    (Value: sgiLeftRight;       Name: 'sgiLeftRight'),
    (Value: sgiRightLeft;       Name: 'sgiRightLeft'),
    (Value: sgiUpLeftLong;      Name: 'sgiUpLeftLong'),
    (Value: sgiUpRightLong;     Name: 'sgiUpRightLong'),
    (Value: sgiDownLeftLong;    Name: 'sgiDownLeftLong'),
    (Value: sgiDownRightLong;   Name: 'sgiDownRightLong'),
    (Value: sgiScratchout;      Name: 'sgiScratchout'),
    (Value: sgiTriangle;        Name: 'sgiTriangle'),
    (Value: sgiSquare;          Name: 'sgiSquare'),
    (Value: sgiCheck;           Name: 'sgiCheck'),
    (Value: sgiCurlicue;        Name: 'sgiCurlicue'),
    (Value: sgiDoubleCurlicue;  Name: 'sgiDoubleCurlicue'),
    (Value: sgiCircle;          Name: 'sgiCircle'),
    (Value: sgiDoubleCircle;    Name: 'sgiDoubleCircle'),
    (Value: sgiSemiCircleLeft;  Name: 'sgiSemiCircleLeft'),
    (Value: sgiSemiCircleRight; Name: 'sgiSemiCircleRight'),
    (Value: sgiChevronUp;       Name: 'sgiChevronUp'),
    (Value: sgiChevronDown;     Name: 'sgiChevronDown'),
    (Value: sgiChevronLeft;     Name: 'sgiChevronLeft'),
    (Value: sgiChevronRight;    Name: 'sgiChevronRight'));

function GestureToIdent(ID: Integer; var Ident: string): Boolean;
begin
  Result := IntToIdent(ID, Ident, GestureNameMap);
end;

function IdentToGesture(const Ident: string; var ID: Integer): Boolean;
begin
  Result := IdentToInt(Ident, ID, GestureNameMap);
end;

type
  TGestureStreamData = class(TCollectionItem)
  private
    FControl: TFmxObject;
    FCollection: TGestureCollection;
  published
    constructor Create(Collection: TCollection); override;
    property Control: TFmxObject read FControl write FControl;
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

{ TGestureManager }

function TGestureManager.AddRecordedGesture(const Item: TCustomGestureCollectionItem): TGestureID;
var
  NewItem: TGestureCollectionItem;
begin
  if Assigned(FRecordedGestures.FindGesture(Item.Name)) then
    raise EGestureException.CreateResFmt(@SDuplicateRecordedGestureName, [Item.Name]);

  NewItem := FRecordedGestures.Add;
  Result := NewItem.GestureID;
  NewItem.Assign(Item);
  NewItem.GestureID := Result;
  //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnAdded, Result);
end;

procedure TGestureManager.ChangeNotification(const AControl: TFmxObject);
begin
  if Assigned(AControl) then
  begin
    FNotifyList.Add(AControl);
    AControl.FreeNotification(Self);
  end;
end;

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
  FNotifyList := TList<TFmxObject>.Create;
  FUpdating := False;
end;

procedure TGestureManager.DefineProperties(Filer: TFiler);

  function StreamData: Boolean;
  var
    P: TPair<TFmxObject, TGestureCollection>;
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

destructor TGestureManager.Destroy;
var
    LArray: TArray<TPair<TFmxObject,TGestureCollection>>;
    I: Integer;
begin
  FInstanceList.Remove(Self);

  //For each control from FControls, remove gesture manager.
  LArray := FControls.ToArray;
  for I := 0 to Length(LArray)-1 do
    LArray[I].Key.Touch.GestureManager := nil;
  Setlength(LArray, 0);

  FreeAndNil(FControls);
  FreeAndNil(FRecordedGestures);
  FreeAndNil(FNotifyList);
  inherited;
end;

class destructor TGestureManager.Destroy;
begin
  FreeAndNil(FInstanceList);
  FreeAndNil(FRegisteredGestures);
end;

function TGestureManager.FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := FRecordedGestures.FindGesture(AGestureID);
  if not Assigned(Result) then
    Result := FRegisteredGestures.FindGesture(AGestureID);
end;

function TGestureManager.FindCustomGesture(const AName: string): TCustomGestureCollectionItem;
begin
  Result := FRecordedGestures.FindGesture(AName);
  if not Assigned(Result) then
    Result := FRegisteredGestures.FindGesture(AName);
end;

function TGestureManager.FindGesture(const AControl: TFmxObject; const AName: string): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AName);
end;

function TGestureManager.FindGesture(const AControl: TFmxObject; AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AGestureID);
end;

procedure TGestureManager.GestureItemChanged(Sender: TObject; Action: TGestureNotification; Item: TCustomGestureCollectionItem);
var
  I: Integer;
  LAction: TCustomAction;
  P: TPair<TFmxObject, TGestureCollection>;
begin
  case Action of
    gnChanged:
      if Assigned(Item) then
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
        //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnModified, Item.GestureID);
      end;
    gnDeleted:
      if not FUpdating and Assigned(Item) then
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

function TGestureManager.GetGestureList(Control: TFmxObject): TGestureArray;
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

function TGestureManager.GetStandardGestures(AControl: TFmxObject): TStandardGestures;
var
  I: Integer;
  List: TGestureCollection;
begin
  Result := [];

  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Add predefined gestures to set
  for I := 0 to List.Count - 1 do
    if List[I].GestureType = TGestureType.gtStandard then
      Include(Result, TStandardGesture(List[I].GestureID));
end;

procedure TGestureManager.Loaded;
var
  S: string;
  I, J: Integer;
  LControl: TFmxObject;
  LStreamCollection: TGestureStreamList;
  LItem, LSourceItem: TCustomGestureCollectionItem;
  MissingGestures: TList<TCustomGestureCollectionItem>;

  // Copy properties except Action from Source to Dest
  procedure UpdateProperties(Source, Dest: TCustomGestureCollectionItem);
  var
    LAction: TCustomAction;
  begin
    if Assigned(Source) then
    begin
      LAction := Dest.Action;
      Dest.Assign(Source);
      Dest.Action := LAction;
    end;
  end;

begin
  inherited Loaded;
  if FLoading then
    Exit;
  if not(csDesigning in ComponentState) and FileExists(FFileName) then
    LoadFromFile(FFileName)
  else if Assigned(FStreamCollection) then
  begin
    MissingGestures := TList<TCustomGestureCollectionItem>.Create;
    try
      LStreamCollection := TGestureStreamList(FStreamCollection);
      for I := 0 to FStreamCollection.Count - 1 do
      begin
        LControl := LStreamCollection[I].Control;
        RegisterControl(LControl);

        // Free any existing collection rather than assign the new one to it
        // so linked component references can be fixed up later.
        if Assigned(FControls.Items[LControl]) then
          FControls.Items[LControl].DisposeOf;
        FControls.Items[LControl] := LStreamCollection[I].Collection;

        // Add properties to items for custom and registered gestures.
        // For custom gestures these are streamed once with the GestureManager,
        // with only the ID streamed for each control. For registered
        // gestures only the name is streamed since the ID may change.
        for J := 0 to TCollection(FControls.Items[LControl]).Count - 1 do
        begin
          LItem := FControls.Items[LControl][J];
          case LItem.GestureType of
            TGestureType.gtRecorded:
              begin
                LSourceItem := FRecordedGestures.FindGesture(LItem.GestureID);
                UpdateProperties(LSourceItem, LItem);
              end;
            // Registered gestures will appear as gtNone since only the name
            // was streamed. Once the gesture properties have been assigned,
            // they will appear as gtRegistsred.
            TGestureType.gtNone:
              begin
                LSourceItem := FRegisteredGestures.FindGesture(LItem.Name);
                if Assigned(LSourceItem) then
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
            LItem.DisposeOf;
          end;
          MessageDlg(Format(SRegisteredGestureNotFound, [S]), TMsgDlgType.mtError, [TMsgDlgBtn.mbClose], 0);
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
      //swallow exceptions here because we still want the app to start
      FreeAndNil(LStream);
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
    inherited Loaded;// Reset the csLoading flag
  finally
    FLoading := False;
    Stream.Free;
  end;
  //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRefreshAll, 0);
end;

procedure TGestureManager.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  //LGestureID: TGestureID;
  //LCustomGestureChanged: Boolean;
  //LStandardGestureChanged: Boolean;
  P: TPair<TFmxObject, TGestureCollection>;
begin
  inherited;
  if Application.Terminated and (Length(FFileName) > 0) and not FSaved then
  begin
    SaveToFile(FFileName);
    FSaved := True;
  end;

  if Operation = opRemove then
  begin
    if AComponent is TCustomAction then
    begin
      // Remove Action from gestures

      //LGestureID := 0; // suppress compiler warning
      //LCustomGestureChanged := False;
      //LStandardGestureChanged := False;

      for P in FControls do
        for I := 0 to P.Value.Count - 1 do
          if (P.Value[I].Action = AComponent) then
          begin
            P.Value[I].Action := nil;
            //LGestureID := P.Value[I].GestureID;
            //if P.Value[I].GestureType = TGestureType.gtStandard then
            //LStandardGestureChanged := True
            //else
            //LCustomGestureChanged := True;
          end;

      // Notify controls to refresh gesture lists
      //if LStandardGestureChanged then
      //NotifyControls(CM_STANDARDGESTURESCHANGED, gcnModified, LGestureID);
      //if LCustomGestureChanged then
      //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnModified, LGestureID);
    end
    else if AComponent is TFmxObject then
    begin
      if FNotifyList.Contains(TFmxObject(AComponent)) then
        FNotifyList.Remove(TFmxObject(AComponent))
      else if not(csDestroying in ComponentState) then
        UnregisterControl(TFmxObject(AComponent));
    end;
  end;
end;

procedure TGestureManager.ReadControlData(Reader: TReader);
begin
  FStreamCollection := TGestureStreamList.Create(csReading in ComponentState);
  Reader.ReadValue;
  Reader.ReadCollection(FStreamCollection);
end;

procedure TGestureManager.ReadRecordedGestures(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FRecordedGestures);
end;

procedure TGestureManager.RegisterControl(const AControl: TFmxObject);
begin
  if Assigned(AControl) then
  begin
    // Create entry in dictionary
    if not FControls.ContainsKey(AControl) then
      FControls.Add(AControl, TGestureCollection.Create(Self));

    // Copy standard gestures into the control's collection
    if not(csLoading in ComponentState) then
      StandardGestures[AControl] := AControl.Touch.StandardGestures;

    // Create a gesture engine if not at design time
    if not(csDesigning in AControl.ComponentState) then
      TGestureEngine.CreateEngine(AControl);
  end;
end;

class function TGestureManager.RegisterGesture(const AGesture: TCustomGestureCollectionItem): TGestureID;
var
  LItem: TGestureCollectionItem;
begin
  if FNextGestureID = rgiFirst then
    raise EGestureException.CreateRes(@STooManyRegisteredGestures);

  if Assigned(FRegisteredGestures.FindGesture(AGesture.Name)) then
    raise EGestureException.CreateResFmt(@SDuplicateRegisteredGestureName,
      [AGesture.Name]);

  LItem := FRegisteredGestures.Add;
  LItem.Assign(AGesture);
  LItem.GestureID := FNextGestureID;
  Result := LItem.GestureID;
  Dec(FNextGestureID);

  if Assigned(FDesignerHook) then
    FDesignerHook(AGesture);

  // for LGestureManager in FInstanceList do
  // if LGestureManager is TGestureManager then
  // TGestureManager(LGestureManager).NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnAdded, Result);
end;

procedure TGestureManager.RemoveChangeNotification(const AControl: TFmxObject);
begin
  if FNotifyList.Contains(AControl) then
  begin
    FNotifyList.Remove(AControl);
    AControl.RemoveFreeNotification(Self);
  end;
end;

procedure TGestureManager.RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem);
begin
  if Assigned(AGesture) then
  begin
    //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRemoved, AGesture.GestureID);
    AGesture.DisposeOf;
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
        //catch all exceptions because we still want the app to shutdown
      end;
    finally
      LStream.Free;
    end;
  except
    ShowMessage(SUnableToSaveSettings);
  end;
end;

procedure TGestureManager.SaveToStream(const S: TStream);
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

function TGestureManager.SelectGesture(const AControl: TFmxObject; const AName: string): Boolean;
var
  LGestureID: TGestureID;
  LGesture: TCustomGestureCollectionItem;
begin
  LGesture := FindCustomGesture(AName);
  Result := Assigned(LGesture);
  if not Result then
    Result := FindStandardGesture(AName, LGestureID)
  else
    LGestureID := LGesture.GestureID;

  if Result then
    Result := SelectGesture(AControl, LGestureID)
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureName, [AName]);
end;

function TGestureManager.SelectGesture(const AControl: TFmxObject; AGestureID: TGestureID): Boolean;
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
        Result := Assigned(LGesture);
        if Result then
          LGestureList.AddGesture.Assign(LGesture);
      end
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [AGestureID]);
  end;
end;

procedure TGestureManager.SetRecordedGestures(const Gestures: TGestureArray);
var
  I, J: Integer;
  Item: TCustomGestureCollectionItem;
  P: TPair<TFmxObject, TGestureCollection>;
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
  if not(csDesigning in ComponentState) then
  begin
    // Iterate through each control's list and remove custom gestures
    for P in FControls do
      for I := P.Value.Count - 1 downto 0 do
        if (P.Value[I].GestureType = TGestureType.gtRecorded) then
          P.Value.Delete(I);
  end
  else
    // Iterate through each control's list and remove gesture ID's
    // that don't exist in the updated FCustomGestures list
                                                                            
    for P in FControls do
      for I := P.Value.Count - 1 downto 0 do
        for J := 0 to FRecordedGestures.Count - 1 do
        begin
          if (P.Value[I].GestureType = TGestureType.gtRecorded) and
            (not Assigned(FRecordedGestures.FindGesture(P.Value[I].GestureID)))
          then
            P.Value.Delete(I);
        end;

  // Notify controls registered for notifications
  //NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRefreshAll, 0);
end;

procedure TGestureManager.SetStandardGestures(AControl: TFmxObject; AStandardGestures: TStandardGestures);
var
  I: Integer;
  List: TGestureCollection;
  LGesture: TStandardGesture;
begin
  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Remove any predefined gestures
  for I := List.Count - 1 downto 0 do
    if List[I].GestureType = TGestureType.gtStandard then
      List[I].DisposeOf;

  // Add new set of predefined gestures
  for LGesture := Low(TStandardGesture) to High(TStandardGesture) do
    if LGesture in AStandardGestures then
      List.Add.GestureID := TGestureID(LGesture);
end;

procedure TGestureManager.UnregisterControl(const AControl: TFmxObject);
var
  List: TGestureCollection;
begin
  if Assigned(AControl) and FControls.ContainsKey(AControl) then
  begin
    List := FControls.Items[AControl];
    FControls.Remove(AControl);
    List.Free;
  end;
end;

class procedure TGestureManager.UnregisterGesture(const AGesture: TGestureID);
var
  LItem: TCustomGestureCollectionItem;
begin
  // for LGestureManager in FInstanceList do
  // if LGestureManager is TGestureManager then
  // TGestureManager(LGestureManager).NotifyControls(CM_CUSTOMGESTURESCHANGED, gcnRemoved, AGesture);

  LItem := FRegisteredGestures.FindGesture(AGesture);
  if Assigned(LItem) then
    LItem.Free;
end;

procedure TGestureManager.UnselectGesture(const AControl: TFmxObject; AGestureID: TGestureID);
var
  LGestureList: TCustomGestureCollection;
begin
  if FControls.ContainsKey(AControl) then
    LGestureList := FControls.Items[AControl]
  else
    raise EGestureException.CreateRes(@SControlNotFound);
  LGestureList.RemoveGesture(AGestureID);
end;

procedure TGestureManager.WriteControlData(Writer: TWriter);
var
  P: TPair<TFmxObject, TGestureCollection>;
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

procedure TGestureManager.WriteRecordedGestures(Writer: TWriter);
begin
  FRecordedGestures.FStreamGestureDetails := True;
  try
    Writer.WriteCollection(FRecordedGestures);
  finally
    FRecordedGestures.FStreamGestureDetails := False;
  end;
end;


{ TGestureCollectionItem }

procedure TGestureCollectionItem.ActionChange(Sender: TBasicAction; CheckDefaults: Boolean);
begin
  inherited;
end;

procedure TGestureCollectionItem.AssignTo(Dest: TPersistent);
begin
  if Dest is TGestureCollectionItem then
    with TGestureCollectionItem(Dest) do
    begin
      Action := Self.Action;
      FDeviation := Self.FDeviation;
      FErrorMargin := Self.FErrorMargin;
      FGestureID := Self.FGestureID;
      FName := Self.FName;
      FPoints := Copy(Self.FPoints, 0, Length(Self.FPoints));
    end
  else
    inherited;
end;

constructor TGestureCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FDeviation := 20;
  FErrorMargin := 20;
end;

procedure TGestureCollectionItem.DefineProperties(Filer: TFiler);

  function DoStream: Boolean;
  begin
    // GestureType will be gtNone while streaming in
    Result := ((GestureType = TGestureType.gtRecorded) or
      (GestureType = TGestureType.gtNone)) and TGestureCollection(Collection).FStreamGestureDetails;
  end;

begin
  inherited;
  Filer.DefineProperty('Deviation', ReadDeviation, WriteDeviation, DoStream);// do not localize
  Filer.DefineProperty('ErrorMargin', ReadErrorMargin, WriteErrorMargin, DoStream); // do not localize
  Filer.DefineProperty('GestureID', ReadGestureID, WriteGestureID, GestureType <> TGestureType.gtRegistered); // do not localize
  Filer.DefineProperty('Name', ReadName, WriteName, (GestureType = TGestureType.gtRegistered) or DoStream); // do not localize
  Filer.DefineBinaryProperty('Points', ReadPoints, WritePoints, DoStream);// do not localize
end;

destructor TGestureCollectionItem.Destroy;
begin
  if Assigned(Action) and Assigned(Collection) and
    Assigned(TGestureCollection(Collection).GestureManager) then
    Action.RemoveFreeNotification(TGestureCollection(Collection).GestureManager);
  if Assigned(FActionLink) then
    FreeAndNil(FActionLink);
  inherited;
end;

procedure TGestureCollectionItem.DoActionChange(Sender: TObject);
begin
  if Sender = Action then
    ActionChange(TCustomAction(Sender), False);
end;

procedure TGestureCollectionItem.DoActionClientChanged;
begin

end;

function TGestureCollectionItem.GetAction: TCustomAction;
begin
  if Assigned(ActionLink) then
    Result := TCustomAction(ActionLink.Action)
  else
    Result := nil;
end;

function TGestureCollectionItem.GetActionLinkClass: TActionLinkClass;
begin
  Result := TActionLink;
end;

function TGestureCollectionItem.GetDeviation: Integer;
begin
  Result := FDeviation;
end;

function TGestureCollectionItem.GetDisplayName: string;
var
  S: string;
begin
  if GestureType = TGestureType.gtStandard then
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
    sgiNoGesture: Result := TGestureType.gtNone;
    sgiFirst..sgiLast: Result := TGestureType.gtStandard;
    cgiFirst..cgiLast: Result := TGestureType.gtRecorded;
    rgiFirst..rgiLast: Result := TGestureType.gtRegistered;
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [FGestureID]);
  end;
end;

function TGestureCollectionItem.GetName: string;
begin
  case GestureType of
    TGestureType.gtNone, TGestureType.gtStandard:
      Result := DisplayName;
    TGestureType.gtRecorded, TGestureType.gtRegistered:
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

const
  StreamVersion1 = 1;

procedure TGestureCollectionItem.ReadPoints(Stream: TStream);
var
  I, Len: Integer;
  LPoint: TPointF;
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
    FPoints[I] := LPoint;
  end;
end;

procedure TGestureCollectionItem.SetAction(const Value: TCustomAction);
var
  lClass: TActionLinkClass;
begin
  if Value <> Action then
  begin
    if Assigned(TGestureCollection(Collection).GestureManager) and (Assigned(Action)) then
      TGestureCollection(Collection).GestureManager.RemoveActionNotification(Action, Self);
    if Not Assigned(Value) then
    begin
      FreeAndNil(FActionLink);
      SetActionClient(False);
    end
    else
    begin
      if Not Assigned(ActionLink) then
      begin
        lClass := GetActionLinkClass;
        if Not Assigned(lClass) then
          raise EActionError.CreateFMT(StrEActionNoSuported, [ClassName]);
        ActionLink := lClass.Create(Self);
      end;
      ActionLink.Action := Value;
      ActionLink.OnChange := DoActionChange;
      ActionChange(Value, csLoading in Value.ComponentState);
      if Assigned(TGestureCollection(Collection).GestureManager) then
        Value.FreeNotification(TGestureCollection(Collection).GestureManager);
      SetActionClient(True);
    end;
  end;
end;

procedure TGestureCollectionItem.SetActionClient(const Value: boolean);
begin
  if FActionClient <> Value then
  begin
    FActionClient := Value;
    DoActionClientChanged;
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
    if Assigned(Collection) then
    begin
      if Assigned(TCustomGestureCollection(Collection).FindGesture(Value)) then
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

procedure TGestureCollectionItem.WritePoints(Stream: TStream);
var
  I: Integer;
  LPoint: TPointF;
  LStreamVersion: Byte;
begin
  LStreamVersion := StreamVersion1;
  Stream.Write(LStreamVersion, SizeOf(Byte));
  I := Length(FPoints);
  Stream.Write(I, SizeOf(Integer));
  for I := 0 to Length(FPoints) - 1 do
  begin
    LPoint := FPoints[I];
    Stream.Write(LPoint, SizeOf(LPoint));
  end;
end;


{ TGestureCollection }

function TGestureCollection.Add: TGestureCollectionItem;
begin
  Result := TGestureCollectionItem(AddGesture);
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

constructor TGestureCollection.Create;
begin
  inherited Create(TGestureCollectionItem);
  FStreamGestureDetails := False;
end;

constructor TGestureCollection.Create(const AGestureManager: TGestureManager);
begin
  Create;
  FGestureManager := AGestureManager;
end;

destructor TGestureCollection.Destroy;
begin
  inherited;
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

function TGestureCollection.GetGestureManager: TCustomGestureManager;
begin
  Result := FGestureManager;
end;

function TGestureCollection.GetUniqueGestureID: TGestureID;
begin
  Result := cgiLast;
  while FindGesture(Result) <> nil do
    Dec(Result);
end;

procedure TGestureCollection.RemoveGesture(AGestureID: TGestureID);
var
  LGesture: TCustomGestureCollectionItem;
begin
  LGesture := FindGesture(AGestureID);
  if Assigned(LGesture) then
    LGesture.Free;
end;

procedure TGestureCollection.Update(Item: TCollectionItem);
begin
  if Assigned(FOnItemChange) then
    FOnItemChange(Self, gnChanged, TCustomGestureCollectionItem(Item));
end;

{ Standard gesture definitions }

const
  PDefaultLeft: array [0 .. 1] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0));

  CDefaultLeft: TStandardGestureData = (GestureID: sgiLeft;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRight: array [0 .. 1] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0));

  CDefaultRight: TStandardGestureData = (GestureID: sgiRight;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUp: array [0 .. 1] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0));

  CDefaultUp: TStandardGestureData = (GestureID: sgiUp;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDown: array [0 .. 1] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200));

  CDefaultDown: TStandardGestureData = (GestureID: sgiDown;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpLeft: array [0 .. 2] of TPointF = ((X: 200; Y: 200), (X: 200; Y: 0),
    (X: 0; Y: 0));

  CDefaultUpLeft: TStandardGestureData = (GestureID: sgiUpLeft;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpRight: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultUpRight: TStandardGestureData = (GestureID: sgiUpRight;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownLeft: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 200;
    Y: 200), (X: 0; Y: 200));

  CDefaultDownLeft: TStandardGestureData = (GestureID: sgiDownLeft;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownRight: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 200; Y: 200));

  CDefaultDownRight: TStandardGestureData = (GestureID: sgiDownRight;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftUp: array [0 .. 2] of TPointF = ((X: 200; Y: 200), (X: 0; Y: 200),
    (X: 0; Y: 0));

  CDefaultLeftUp: TStandardGestureData = (GestureID: sgiLeftUp;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftDown: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0),
    (X: 0; Y: 200));

  CDefaultLeftDown: TStandardGestureData = (GestureID: sgiLeftDown;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightUp: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 200;
    Y: 200), (X: 200; Y: 0));

  CDefaultRightUp: TStandardGestureData = (GestureID: sgiRightUp;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightDown: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0),
    (X: 200; Y: 200));

  CDefaultRightDown: TStandardGestureData = (GestureID: sgiRightDown;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpDown: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0),
    (X: 0; Y: 200));

  CDefaultUpDown: TStandardGestureData = (GestureID: sgiUpDown;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownUp: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 0; Y: 0));

  CDefaultDownUp: TStandardGestureData = (GestureID: sgiDownUp;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftRight: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultLeftRight: TStandardGestureData = (GestureID: sgiLeftRight;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightLeft: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0),
    (X: 0; Y: 0));

  CDefaultRightLeft: TStandardGestureData = (GestureID: sgiRightLeft;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpLeftLong: array [0 .. 2] of TPointF = ((X: 200; Y: 100), (X: 200;
    Y: 0), (X: 0; Y: 0));

  CDefaultUpLeftLong: TStandardGestureData = (GestureID: sgiUpLeftLong;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpRightLong: array [0 .. 2] of TPointF = ((X: 0; Y: 100), (X: 0;
    Y: 0), (X: 200; Y: 0));

  CDefaultUpRightLong: TStandardGestureData = (GestureID: sgiUpRightLong;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownLeftLong: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 200;
    Y: 100), (X: 0; Y: 100));

  CDefaultDownLeftLong: TStandardGestureData = (GestureID: sgiDownLeftLong;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownRightLong: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0;
    Y: 100), (X: 200; Y: 100));

  CDefaultDownRightLong: TStandardGestureData = (GestureID: sgiDownRightLong;
    Options: [TGestureOption.goUniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultScratchout: array [0 .. 1] of TPointF = ((X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultScratchout: TStandardGestureData = (GestureID: sgiScratchout;
    Options: []; Deviation: 30; ErrorMargin: 20);

  PDefaultTriangle: array [0 .. 3] of TPointF = ((X: 100; Y: 0), (X: 0; Y: 141),
    (X: 200; Y: 141), (X: 100; Y: 0));

  CDefaultTriangle: TStandardGestureData = (GestureID: sgiTriangle;
    Options: [TGestureOption.goSkew, TGestureOption.goEndpoint,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 40);

  PDefaultSquare: array [0 .. 4] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 200; Y: 200), (X: 200; Y: 0), (X: 0; Y: 0));

  CDefaultSquare: TStandardGestureData = (GestureID: sgiSquare;
    Options: [TGestureOption.goSkew, TGestureOption.goEndpoint,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 40);

  PDefaultCheck: array [0 .. 2] of TPointF = ((X: 0; Y: 140), (X: 80; Y: 200),
    (X: 200; Y: 0));

  CDefaultCheck: TStandardGestureData = (GestureID: sgiCheck;
    Options: [TGestureOption.goUniDirectional, TGestureOption.goRotate];
    Deviation: 50; ErrorMargin: 20);

  PDefaultCurlicue: array [0 .. 60] of TPointF = ((X: 0; Y: 97), (X: 5; Y: 96),
    (X: 11; Y: 96), (X: 16; Y: 95), (X: 21; Y: 95), (X: 26; Y: 94), (X: 31;
    Y: 92), (X: 36; Y: 89), (X: 41; Y: 87), (X: 47; Y: 84), (X: 52; Y: 79),
    (X: 56; Y: 74), (X: 59; Y: 69), (X: 62; Y: 64), (X: 66; Y: 59), (X: 68;
    Y: 54), (X: 71; Y: 48), (X: 72; Y: 43), (X: 72; Y: 38), (X: 73; Y: 32),
    (X: 74; Y: 27), (X: 74; Y: 22), (X: 72; Y: 17), (X: 67; Y: 13), (X: 62;
    Y: 10), (X: 57; Y: 8), (X: 52; Y: 7), (X: 47; Y: 6), (X: 42; Y: 5), (X: 37;
    Y: 5), (X: 32; Y: 6), (X: 27; Y: 8), (X: 22; Y: 12), (X: 20; Y: 17), (X: 20;
    Y: 22), (X: 20; Y: 27), (X: 20; Y: 32), (X: 22; Y: 37), (X: 25; Y: 42),
    (X: 28; Y: 47), (X: 33; Y: 50), (X: 38; Y: 53), (X: 43; Y: 54), (X: 48;
    Y: 54), (X: 53; Y: 55), (X: 58; Y: 55), (X: 63; Y: 55), (X: 68; Y: 55),
    (X: 73; Y: 54), (X: 79; Y: 52), (X: 84; Y: 50), (X: 88; Y: 45), (X: 91;
    Y: 40), (X: 94; Y: 35), (X: 96; Y: 30), (X: 99; Y: 25), (X: 101; Y: 20),
    (X: 104; Y: 15), (X: 108; Y: 10), (X: 110; Y: 5), (X: 113; Y: 0));

  CDefaultCurlicue: TStandardGestureData = (GestureID: sgiCurlicue;
    Options: [TGestureOption.goUniDirectional, TGestureOption.goSkew,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 20);

  PDefaultDoubleCurlicue: array [0 .. 77] of TPointF = ((X: 0; Y: 175), (X: 5;
    Y: 171), (X: 10; Y: 168), (X: 14; Y: 163), (X: 18; Y: 158), (X: 20; Y: 153),
    (X: 23; Y: 148), (X: 25; Y: 143), (X: 28; Y: 137), (X: 29; Y: 132), (X: 31;
    Y: 126), (X: 32; Y: 121), (X: 32; Y: 115), (X: 32; Y: 110), (X: 32; Y: 105),
    (X: 32; Y: 99), (X: 29; Y: 94), (X: 26; Y: 89), (X: 21; Y: 86), (X: 16;
    Y: 83), (X: 11; Y: 83), (X: 6; Y: 84), (X: 4; Y: 89), (X: 2; Y: 94), (X: 2;
    Y: 99), (X: 2; Y: 105), (X: 5; Y: 110), (X: 11; Y: 114), (X: 16; Y: 116),
    (X: 21; Y: 118), (X: 26; Y: 118), (X: 31; Y: 118), (X: 36; Y: 118), (X: 42;
    Y: 118), (X: 47; Y: 114), (X: 52; Y: 111), (X: 56; Y: 106), (X: 58; Y: 101),
    (X: 60; Y: 96), (X: 61; Y: 90), (X: 61; Y: 84), (X: 61; Y: 79), (X: 61;
    Y: 74), (X: 61; Y: 69), (X: 61; Y: 64), (X: 60; Y: 59), (X: 59; Y: 54),
    (X: 59; Y: 48), (X: 57; Y: 42), (X: 54; Y: 36), (X: 49; Y: 31), (X: 44;
    Y: 30), (X: 39; Y: 33), (X: 37; Y: 38), (X: 35; Y: 43), (X: 35; Y: 48),
    (X: 37; Y: 53), (X: 42; Y: 57), (X: 47; Y: 61), (X: 53; Y: 64), (X: 58;
    Y: 66), (X: 63; Y: 67), (X: 68; Y: 67), (X: 73; Y: 67), (X: 78; Y: 64),
    (X: 84; Y: 61), (X: 89; Y: 56), (X: 91; Y: 51), (X: 93; Y: 46), (X: 94;
    Y: 41), (X: 95; Y: 35), (X: 95; Y: 30), (X: 95; Y: 25), (X: 95; Y: 20),
    (X: 95; Y: 15), (X: 95; Y: 10), (X: 95; Y: 5), (X: 94; Y: 0));

  CDefaultDoubleCurlicue: TStandardGestureData = (GestureID: sgiDoubleCurlicue;
    Options: [TGestureOption.goUniDirectional, TGestureOption.goSkew,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultCircle: array [0 .. 16] of TPointF = ((X: 50; Y: 0), (X: 32; Y: 4),
    (X: 16; Y: 16), (X: 4; Y: 31), (X: 0; Y: 50), (X: 4; Y: 67), (X: 15; Y: 85),
    (X: 31; Y: 95), (X: 50; Y: 100), (X: 68; Y: 96), (X: 84; Y: 84), (X: 96;
    Y: 69), (X: 100; Y: 50), (X: 97; Y: 30), (X: 85; Y: 14), (X: 68; Y: 3),
    (X: 50; Y: 0));

  CDefaultCircle: TStandardGestureData = (GestureID: sgiCircle;
    Options: [TGestureOption.goSkew, TGestureOption.goEndpoint]; Deviation: 30;
    ErrorMargin: 30);

  PDefaultDoubleCircle: array [0 .. 33] of TPointF = ((X: 50; Y: 0), (X: 32;
    Y: 4), (X: 16; Y: 16), (X: 4; Y: 31), (X: 0; Y: 50), (X: 4; Y: 67), (X: 15;
    Y: 85), (X: 31; Y: 95), (X: 50; Y: 100), (X: 68; Y: 96), (X: 84; Y: 84),
    (X: 96; Y: 69), (X: 100; Y: 50), (X: 97; Y: 30), (X: 85; Y: 14), (X: 68;
    Y: 3), (X: 50; Y: 0), (X: 50; Y: 0), (X: 32; Y: 4), (X: 16; Y: 16), (X: 4;
    Y: 31), (X: 0; Y: 50), (X: 4; Y: 67), (X: 15; Y: 85), (X: 31; Y: 95),
    (X: 50; Y: 100), (X: 68; Y: 96), (X: 84; Y: 84), (X: 96; Y: 69), (X: 100;
    Y: 50), (X: 97; Y: 30), (X: 85; Y: 14), (X: 68; Y: 3), (X: 50; Y: 0));

  CDefaultDoubleCircle: TStandardGestureData = (GestureID: sgiDoubleCircle;
    Options: [TGestureOption.goSkew, TGestureOption.goEndpoint]; Deviation: 30;
    ErrorMargin: 40);

  PDefaultSemiCircleLeft: array [0 .. 8] of TPointF = ((X: 100; Y: 50), (X: 97;
    Y: 30), (X: 85; Y: 14), (X: 68; Y: 3), (X: 50; Y: 0), (X: 32; Y: 4), (X: 16;
    Y: 16), (X: 4; Y: 31), (X: 0; Y: 50));

  CDefaultSemiCircleLeft: TStandardGestureData = (GestureID: sgiSemiCircleLeft;
    Options: [TGestureOption.goUniDirectional, TGestureOption.goEndpoint,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultSemiCircleRight: array [0 .. 8] of TPointF = ((X: 0; Y: 50), (X: 4;
    Y: 31), (X: 16; Y: 16), (X: 32; Y: 4), (X: 50; Y: 0), (X: 68; Y: 3), (X: 85;
    Y: 14), (X: 97; Y: 30), (X: 100; Y: 50));

  CDefaultSemiCircleRight: TStandardGestureData = (GestureID: sgiSemiCircleLeft;
    Options: [TGestureOption.goUniDirectional, TGestureOption.goEndpoint,
    TGestureOption.goRotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultChevronUp: array [0 .. 2] of TPointF = ((X: 0; Y: 100), (X: 100;
    Y: 0), (X: 200; Y: 100));

  CDefaultChevronUp: TStandardGestureData = (GestureID: sgiChevronUp;
    Options: [TGestureOption.goSkew, TGestureOption.goRotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronDown: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 100;
    Y: 100), (X: 200; Y: 0));

  CDefaultChevronDown: TStandardGestureData = (GestureID: sgiChevronDown;
    Options: [TGestureOption.goSkew, TGestureOption.goRotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronLeft: array [0 .. 2] of TPointF = ((X: 100; Y: 0), (X: 0;
    Y: 100), (X: 100; Y: 200));

  CDefaultChevronLeft: TStandardGestureData = (GestureID: sgiChevronLeft;
    Options: [TGestureOption.goSkew, TGestureOption.goRotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronRight: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 100;
    Y: 100), (X: 0; Y: 200));

  CDefaultChevronRight: TStandardGestureData = (GestureID: sgiChevronRight;
    Options: [TGestureOption.goSkew, TGestureOption.goRotate]; Deviation: 20;
    ErrorMargin: 20);

function AssignDefaultGestureData(const AGestureData: TStandardGestureData;
  const Points: array of TPointF): TStandardGestureData;
var
  Count: Integer;
begin
  Result := AGestureData;
  Count := Length(Points);
  if Count > 0 then
  begin
    SetLength(Result.Points, Count);
    Move(Points[0], Result.Points[0], Count * SizeOf(TPointF));
  end;
end;

function FindStandardGesture(AGestureID: TGestureID; var AGestureData: TStandardGestureData): Boolean;
begin
  Result := True;
  case AGestureID of
    sgiLeft:
      AGestureData := AssignDefaultGestureData(CDefaultLeft, PDefaultLeft);
    sgiRight:
      AGestureData := AssignDefaultGestureData(CDefaultRight, PDefaultRight);
    sgiUp:
      AGestureData := AssignDefaultGestureData(CDefaultUp, PDefaultUp);
    sgiDown:
      AGestureData := AssignDefaultGestureData(CDefaultDown, PDefaultDown);
    sgiUpLeft:
      AGestureData := AssignDefaultGestureData(CDefaultUpLeft, PDefaultUpLeft);
    sgiUpRight:
      AGestureData := AssignDefaultGestureData(CDefaultUpRight,
        PDefaultUpRight);
    sgiDownLeft:
      AGestureData := AssignDefaultGestureData(CDefaultDownLeft,
        PDefaultDownLeft);
    sgiDownRight:
      AGestureData := AssignDefaultGestureData(CDefaultDownRight,
        PDefaultDownRight);
    sgiLeftUp:
      AGestureData := AssignDefaultGestureData(CDefaultLeftUp, PDefaultLeftUp);
    sgiLeftDown:
      AGestureData := AssignDefaultGestureData(CDefaultLeftDown,
        PDefaultLeftDown);
    sgiRightUp:
      AGestureData := AssignDefaultGestureData(CDefaultRightUp,
        PDefaultRightUp);
    sgiRightDown:
      AGestureData := AssignDefaultGestureData(CDefaultRightDown,
        PDefaultRightDown);
    sgiUpDown:
      AGestureData := AssignDefaultGestureData(CDefaultUpDown, PDefaultUpDown);
    sgiDownUp:
      AGestureData := AssignDefaultGestureData(CDefaultDownUp, PDefaultDownUp);
    sgiLeftRight:
      AGestureData := AssignDefaultGestureData(CDefaultLeftRight,
        PDefaultLeftRight);
    sgiRightLeft:
      AGestureData := AssignDefaultGestureData(CDefaultRightLeft,
        PDefaultRightLeft);
    sgiUpLeftLong:
      AGestureData := AssignDefaultGestureData(CDefaultUpLeftLong,
        PDefaultUpLeftLong);
    sgiUpRightLong:
      AGestureData := AssignDefaultGestureData(CDefaultUpRightLong,
        PDefaultUpRightLong);
    sgiDownLeftLong:
      AGestureData := AssignDefaultGestureData(CDefaultDownLeftLong,
        PDefaultDownLeftLong);
    sgiDownRightLong:
      AGestureData := AssignDefaultGestureData(CDefaultDownRightLong,
        PDefaultDownRightLong);
    sgiScratchout:
      AGestureData := AssignDefaultGestureData(CDefaultScratchout,
        PDefaultScratchout);
    sgiTriangle:
      AGestureData := AssignDefaultGestureData(CDefaultTriangle,
        PDefaultTriangle);
    sgiSquare:
      AGestureData := AssignDefaultGestureData(CDefaultSquare, PDefaultSquare);
    sgiCheck:
      AGestureData := AssignDefaultGestureData(CDefaultCheck, PDefaultCheck);
    sgiCurlicue:
      AGestureData := AssignDefaultGestureData(CDefaultCurlicue,
        PDefaultCurlicue);
    sgiDoubleCurlicue:
      AGestureData := AssignDefaultGestureData(CDefaultDoubleCurlicue,
        PDefaultDoubleCurlicue);
    sgiCircle:
      AGestureData := AssignDefaultGestureData(CDefaultCircle, PDefaultCircle);
    sgiDoubleCircle:
      AGestureData := AssignDefaultGestureData(CDefaultDoubleCircle,
        PDefaultDoubleCircle);
    sgiSemiCircleLeft:
      AGestureData := AssignDefaultGestureData(CDefaultSemiCircleLeft,
        PDefaultSemiCircleLeft);
    sgiSemiCircleRight:
      AGestureData := AssignDefaultGestureData(CDefaultSemiCircleRight,
        PDefaultSemiCircleRight);
    sgiChevronUp:
      AGestureData := AssignDefaultGestureData(CDefaultChevronUp,
        PDefaultChevronUp);
    sgiChevronDown:
      AGestureData := AssignDefaultGestureData(CDefaultChevronDown,
        PDefaultChevronDown);
    sgiChevronLeft:
      AGestureData := AssignDefaultGestureData(CDefaultChevronLeft,
        PDefaultChevronLeft);
    sgiChevronRight:
      AGestureData := AssignDefaultGestureData(CDefaultChevronRight,
        PDefaultChevronRight);
  else
    begin
      FillChar(AGestureData, Sizeof(AGestureData), 0);
      Result := False;
    end;
  end;
end;

function FindStandardGesture(const AName: string; var AGestureID: TGestureID): Boolean;
var
  Entry: TIdentMapEntry;
begin
  Result := False;
  for Entry in GestureNameMap do
    if CompareText(AName, Copy(Entry.Name, 4, $FF)) = 0 then
    begin
      AGestureID := Entry.Value;
      Result := True;
      Break;
    end;
end;

{ TGestureEngine }

procedure TGestureEngine.BroadcastGesture(const AControl: TFmxObject; EventInfo: TGestureEventInfo);
var
  LControl: TFmxObject;
  LItem: TGestureCollectionItem;
  Obj: IControl;
  LAction: TOpenCustomAction;
begin
  // Find control that will respond to the gesture
  LItem := nil;
  LControl := AControl;
  while Assigned(LControl) do
  begin
    if Assigned(LControl.Touch.GestureManager) then
      if EventInfo.GestureID <> sgiNoGesture then
      begin
        LItem := TGestureCollectionItem(LControl.Touch.GestureManager.FindGesture(LControl, EventInfo.GestureID));
        if Assigned(LItem) then
          Break;
      end
      else
        Break;
    if LControl.Parent is TFmxObject then
      LControl := LControl.Parent
    else
      LControl := nil;
  end;

  // Execute the action or notify the control
  if not(csDesigning in AControl.ComponentState) and Assigned(LItem) and
    Assigned(LItem.Action) and Assigned(LItem.ActionLink) then
  begin
    // LItem.Action.Execute; then
    if LItem.ActionLink.Action is TCustomAction then
      LAction := TOpenCustomAction(LItem.ActionLink.Action)
    else
      LAction := nil;
    if Assigned(LAction) then
    begin
      if not LAction.Supported then
        Exit;
      LAction.SetTarget(LControl);
    end;
    try
      if not LItem.ActionLink.Execute(LControl) then
        LControl.ExecuteAction(LItem.ActionLink.Action);
    finally
      if Assigned(LAction) then
        LAction.SetTarget(nil);
    end;
  end
  else if Assigned(LControl) then
  begin
    Obj := LControl.AsIControl;
    if Obj <> nil then
      EventInfo.Location := Obj.ScreenToLocal(InitialPoint)
    else if LControl is TCommonCustomForm then
      EventInfo.Location := TCommonCustomForm(LControl).ScreenToClient(InitialPoint)
    else
      EventInfo.Location := InitialPoint;
    LControl.CMGesture(EventInfo);
  end;
end;

procedure TGestureEngine.ClearPoints;
begin
  if not Assigned(FPoints) then
    FPoints := TGesturePoints.Create
  else
    FPoints.Clear;
end;

class constructor TGestureEngine.Create;
begin
  FSensitivity := 80; // 80% by default
end;

class procedure TGestureEngine.CreateEngine(const AControl: TFmxObject);
begin
  FGestureEngineType := TPlatformGestureEngine;
  if not(csDesigning in AControl.ComponentState) then
    if not Assigned(AControl.Touch.GestureEngine) then
    begin
      AControl.Touch.GestureEngine := FGestureEngineType.GetGestureEngine(AControl);
    end;
end;

destructor TGestureEngine.Destroy;
begin
  if Assigned(FPoints) then
    FreeAndNil(FPoints);
  inherited;
end;

class procedure TGestureEngine.GetCompleteGestureList(const AControl: TFmxObject; const AGestureList: TGestureList);
var
  LControl: TFmxObject;
  LItem: TCustomGestureCollectionItem;
begin
  LControl := AControl;
  while Assigned(LControl) do
  begin
    if Assigned(LControl.Touch.GestureManager) then
      for LItem in LControl.Touch.GestureList do
        AGestureList.Add(LItem);
    if LControl.Parent is TFmxObject then
      LControl := LControl.Parent
    else
      LControl := nil;
  end;
end;

function TGestureEngine.GetPointCount: Integer;
begin
  if Assigned(FPoints) then
    Result := FPoints.Count
  else
    Result := 0;
end;

function GesturePointsToArray(const Source: TGesturePoints): TGesturePointArray;
var
  I: Integer;
begin
  SetLength(Result, Source.Count);
  for I := 0 to Source.Count - 1 do
    Result[I] := TPointF(Source[I]);
end;

function TGestureEngine.GetPoints: TGesturePointArray;
begin
  if Assigned(FPoints) then
    Result := GesturePointsToArray(FPoints)
  else
    Result := TGesturePointArray.Create();
end;


procedure TGestureEngine.SetInitialPoint(const Value: TPointF);
begin
  FInitialPoint := Value;
end;

class procedure TGestureEngine.SetSensitivity(const Value: Integer);
begin
  if Value <> FSensitivity then
  begin
    if (Value > 0) and (Value <= 100) then
      FSensitivity := Value;
   // else
      //raise Exception.CreateResFmt(@SOutOfRange, [1, 100]);
  end;
end;

initialization
  RegisterIntegerConsts(TypeInfo(TGestureID), IdentToGesture, GestureToIdent);
end.
