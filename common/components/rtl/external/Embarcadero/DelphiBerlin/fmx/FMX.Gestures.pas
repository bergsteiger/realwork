{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Gestures;

interface

{$SCOPEDENUMS ON}

uses
  FMX.Types, System.Classes, System.SysUtils, System.Types, System.Generics.Collections, FMX.ActnList;

const
  // Recorded custom gestures ID range
  cgiFirst = -512;
  cgiLast  = -1;

  // Registered custom gestures ID range
  rgiFirst = -1024;
  rgiLast  = -513;

  CustomGestureTypes: TGestureTypes = [TGestureType.Recorded, TGestureType.Registered];

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
    FActionClient: Boolean;
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
    procedure SetActionClient(const Value: Boolean);
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
    TGestureControlList = TDictionary<TComponent, TGestureCollection>;
    TDesignerHook = procedure(AGesture: TCustomGestureCollectionItem) of object;
  strict private
    FControls: TGestureControlList;
    FFileName: TFileName;
    FLoading: Boolean;
    FNotifyList: TList<TComponent>;
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
    procedure SetSensitivity(const AValue: Single);
    function GetSensitivity: Single;
  protected
    class var FDesignerHook: TDesignerHook; // For internal use only
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function GetGestureList(Control: TComponent): TGestureArray; override;
    function GetStandardGestures(AControl: TComponent): TStandardGestures; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetStandardGestures(AControl: TComponent; AStandardGestures: TStandardGestures); override;
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
    procedure ChangeNotification(const AControl: TComponent);
    function FindCustomGesture(AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindCustomGesture(const AName: string): TCustomGestureCollectionItem; override;
    function FindGesture(const AControl: TComponent; AGestureID: TGestureID): TCustomGestureCollectionItem; override;
    function FindGesture(const AControl: TComponent; const AName: string): TCustomGestureCollectionItem; override;
    procedure LoadFromFile(const Filename: string);
    procedure LoadFromStream(S: TStream);
    procedure RegisterControl(const AControl: TComponent); override;
    procedure RemoveChangeNotification(const AControl: TComponent);
    procedure RemoveRecordedGesture(AGestureID: TGestureID); override;
    procedure RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem); override;
    procedure SaveToFile(const Filename: string);
    procedure SaveToStream(const S: TStream);
    function SelectGesture(const AControl: TComponent; AGestureID: TGestureID): Boolean; override;
    function SelectGesture(const AControl: TComponent; const AName: string): Boolean; override;
    procedure SetRecordedGestures(const Gestures: TGestureArray); // For designtime support only
    procedure UnregisterControl(const AControl: TComponent); override;
    procedure UnselectGesture(const AControl: TComponent; AGestureID: TGestureID); override;
    property CustomGestureCount: Integer read GetCustomGestureCount;
    property CustomGestures: TGestureArray read GetCustomGestures;
    property RecordedGestureCount: Integer read GetRecordedGestureCount;
    property RecordedGestures: TGestureArray read GetRecordedGestures;
  published
    property FileName: TFileName read FFileName write FFileName;
    ///<summary>This property sets the default global sensitivity of the standard gestures.</summary>
    property Sensitivity: Single read GetSensitivity write SetSensitivity;
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
    ///<summary>This procedure sets the starting point to capture the points of the recognizing gesture.</summary>
    procedure SetInitialPoint(const Value: TPointF); virtual;
    ///<summary>The pattern recognizer which the engine is using.</summary>
    class var FRecognizer: TCustomGestureRecognizer;
    ///<summary>Default class to create recognizers.</summary>
    class var FDefaultRecognizerClass: TCustomGestureRecognizerClass;
    ///<summary>Class of th current gesture engine.</summary>
    class var FGestureEngineType: TGestureEngineType;
    ///<summary>This function returns an engine that the control is using. It can return nil.</summary>
    class function GetGestureEngine(const AControl: TComponent): TGestureEngine; virtual; abstract;
    ///<summary>Returns a list containing the gesture forms that the control wants to catch.</summary>
    class procedure GetCompleteGestureList(const AControl: TComponent; const AGestureList: TGestureList);
    ///<summary>Function to set a default gesture recognizer class when SetDefaultRecognizerClass is called.</summary>
    class procedure DoSetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass); virtual;
    ///<summary>Function to set a default gesture recognizer class.</summary>
    class procedure SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass); static;
    ///<summary>Returns the current recognizer because of the call to GetRecognizer.</summary>
    class function DoGetRecognizer: TCustomGestureRecognizer; virtual;
    ///<summary>Getter for the class Recognizer property.</summary>
    class function GetRecognizer: TCustomGestureRecognizer; static;
    ///<summary>This property represents the current recognizer.</summary>
    class property Recognizer: TCustomGestureRecognizer read GetRecognizer;
    ///<summary>This property represents the current recognizer class in order to be able to create recognizers.</summary>
    class property DefaultRecognizerClass: TCustomGestureRecognizerClass
      read FDefaultRecognizerClass write SetDefaultRecognizerClass;
  public
    ///<summary>Adds a point to the engine in order to be processed as a part of a gesture.</summary>
    procedure AddPoint(const X, Y: Single);
    ///<summary>Creates a new engine and associates it to the given component. It uses the default class to create the
    ///engine.</summary>
    class procedure CreateEngine(const AControl: TComponent);
    ///<summary>Returns true if the point list is recognized as a standard gesture.</summary>
    class function IsGesture(const Points: array of TPointF; const Items: TGestureList; GestureTypes: TGestureTypes;
      var EventInfo: TGestureEventInfo): Boolean; static;
    ///<summary>This property sets the default global sensitivity of the standard gestures.</summary>
    class property Sensitivity: Integer read FSensitivity write SetSensitivity;
    property InitialPoint: TPointF read FInitialPoint write SetInitialPoint;
    property PointCount: Integer read GetPointCount;
    property Points: TGesturePointArray read GetPoints;
    procedure BroadcastGesture(const AControl: TComponent; EventInfo: TGestureEventInfo); override;
    procedure ClearPoints;
    destructor Destroy; override;
  end;

  TCustomGestureRecognizer = class
  protected
    ///<summary>Returns the probability that the incoming points are a gesture.</summary>
    class function IsPointsGesture(const Points, GesturePoints: array of TPointF; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer; static;
    ///<summary>Returns the probability that the incoming points are a scratchout.</summary>
    class function IsScratchout(const Points: array of TPointF; GestureID: TGestureID;
      const Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer; static;
    ///<summary>Creates a new array of gesture points.</summary>
    class function ReverseGesturePoints(const Points: array of TPointF): TGesturePointArray; static;
    ///<summary>This creates a copy of a gesture point array.</summary>
    class function CopyGesturePoints(const Points: TGesturePoints): TGesturePointArray; static;
    ///<summary>Returns a new array containing the source points interpolated.</summary>
    class function InterpolateGesturePoints(const Points: array of TPointF): TGesturePointArray; static;
    ///<summary>Returns a new gesture point list without the duplicated vertices.</summary>
    class function RemoveDuplicatedGesturePoints(const Points: array of TPointF): TGesturePointArray; static;
    ///<summary>Returns a new gesture point list rotated by an angle.</summary>
    class function RotateGesturePoints(const Points, GesturePoints: array of TPointF; ErrorMargin: Integer;
      var Angle: Double): TGesturePointArray; static;
    ///<summary>Returns a new gesture point list with the normalized points.</summary>
    class function NormalizeGesturePoints(const Points: array of TPointF): TGesturePointArray; static;
    ///<summary>Returns a new gesture point list scaled.</summary>
    class function ScaleGesturePoints(const Points, GesturePoints: array of TPointF; const MinScale: Integer;
      const Scaling: Boolean = False): TGesturePointArray; static;
  public
    ///<summary>Returns the probability that the incomming points belong to one gesture.</summary>
    function Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; virtual; abstract;
    ///<summary>Returns a new gesture point list with the normalized points.</summary>
    function NormalizePoints(const Points: array of TPointF): TGesturePointArray; virtual;
    ///<summary>Returns a new gesture point list rotated by an angle.</summary>
    function RotatePoints(const Points, GesturePoints: array of TPointF; ErrorMargin: Integer;
      var Angle: Double): TGesturePointArray; virtual;
    ///<summary>Returns a new gesture point list scaled.</summary>
    function ScalePoints(const Points, GesturePoints: array of TPointF; MinScale: Integer;
      Scaling: Boolean = False): TGesturePointArray; virtual;
    ///<summary>Returns a new gesture point list without the duplicated vertices.</summary>
    function RemoveDuplicates(const Points: array of TPointF): TGesturePointArray; virtual;
    ///<summary>Resets the recognizer, so a new gesture can begin.</summary>
    procedure Reset; virtual; abstract;
  end;

  TStandardGestureData = record
    Points: TGesturePointArray;
    GestureID: TGestureID;
    Options: TGestureOptions;
    Deviation: Integer;
    ErrorMargin: Integer;
  end;

function FindStandardGesture(AGestureID: TGestureID; var AGestureData: TStandardGestureData): Boolean; overload;
function FindStandardGesture(const AName: string; var AGestureID: TGestureID): Boolean; overload;

function GestureToIdent(ID: Integer; var Ident: string): Boolean;
function IdentToGesture(const Ident: string; var ID: Integer): Boolean;

implementation

uses
  System.UITypes, System.RTLConsts, System.Math, System.Actions, FMX.Dialogs, FMX.DialogService, FMX.Consts, FMX.Forms, FMX.Utils
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
{$IFDEF ANDROID}
  , FMX.Gestures.Android
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
    FControl: TComponent;
    FCollection: TGestureCollection;
  published
    constructor Create(Collection: TCollection); override;
    property Control: TComponent read FControl write FControl;
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
  if FRecordedGestures.FindGesture(Item.Name) <> nil then
    raise EGestureException.CreateResFmt(@SDuplicateRecordedGestureName, [Item.Name]);

  NewItem := FRecordedGestures.Add;
  Result := NewItem.GestureID;
  NewItem.Assign(Item);
  NewItem.GestureID := Result;
end;

procedure TGestureManager.ChangeNotification(const AControl: TComponent);
begin
  if AControl <> nil then
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
  FNotifyList := TList<TComponent>.Create;
  FUpdating := False;
end;

procedure TGestureManager.DefineProperties(Filer: TFiler);

  function StreamData: Boolean;
  var
    P: TPair<TComponent, TGestureCollection>;
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
  LArray: TArray<TPair<TComponent,TGestureCollection>>;
  I: Integer;
  LGObj: IGestureControl;
begin
  FInstanceList.Remove(Self);

  //For each control from FControls, remove gesture manager.
  LArray := FControls.ToArray;
  for I := 0 to Length(LArray)-1 do
    begin
    if Supports(LArray[I].Key, IGestureControl, LGObj) then
      LGObj.TouchManager.GestureManager := nil;
  end;
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
  if Result = nil then
    Result := FRegisteredGestures.FindGesture(AGestureID);
end;

function TGestureManager.FindCustomGesture(const AName: string): TCustomGestureCollectionItem;
begin
  Result := FRecordedGestures.FindGesture(AName);
  if Result = nil then
    Result := FRegisteredGestures.FindGesture(AName);
end;

function TGestureManager.FindGesture(const AControl: TComponent; const AName: string): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AName);
end;

function TGestureManager.FindGesture(const AControl: TComponent; AGestureID: TGestureID): TCustomGestureCollectionItem;
begin
  Result := FControls.Items[AControl].FindGesture(AGestureID);
end;

procedure TGestureManager.GestureItemChanged(Sender: TObject; Action: TGestureNotification; Item: TCustomGestureCollectionItem);
var
  I: Integer;
  LAction: TCustomAction;
  P: TPair<TComponent, TGestureCollection>;
begin
  case Action of
    TGestureNotification.gnChanged:
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
      end;
    TGestureNotification.gnDeleted:
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

function TGestureManager.GetGestureList(Control: TComponent): TGestureArray;
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

function TGestureManager.GetSensitivity: Single;
begin
  Result := TGestureEngine.Sensitivity;
end;

function TGestureManager.GetStandardGestures(AControl: TComponent): TStandardGestures;
var
  I: Integer;
  List: TGestureCollection;
begin
  Result := [];

  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Add predefined gestures to set
  for I := 0 to List.Count - 1 do
    if List[I].GestureType = TGestureType.Standard then
      Include(Result, TStandardGesture(List[I].GestureID));
end;

procedure TGestureManager.Loaded;
var
  S: string;
  I, J: Integer;
  LControl: TComponent;
  LStreamCollection: TGestureStreamList;
  LItem, LSourceItem: TCustomGestureCollectionItem;
  MissingGestures: TList<TCustomGestureCollectionItem>;

  // Copy properties except Action from Source to Dest
  procedure UpdateProperties(Source, Dest: TCustomGestureCollectionItem);
  var
    LAction: TCustomAction;
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
  if FLoading then
    Exit;
  if not(csDesigning in ComponentState) and FileExists(FFileName) then
    LoadFromFile(FFileName)
  else if FStreamCollection <> nil then
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
        if FControls.Items[LControl] <> nil then
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
            TGestureType.Recorded:
              begin
                LSourceItem := FRecordedGestures.FindGesture(LItem.GestureID);
                UpdateProperties(LSourceItem, LItem);
              end;
            // Registered gestures will appear as TGestureType.None since only the name
            // was streamed. Once the gesture properties have been assigned,
            // they will appear as gtRegistsred.
            TGestureType.None:
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
            LItem.DisposeOf;
          end;
          TDialogService.MessageDialog(Format(SRegisteredGestureNotFound, [S]), TMsgDlgType.mtError,
            [TMsgDlgBtn.mbClose], TMsgDlgBtn.mbClose, 0, nil);
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
end;

procedure TGestureManager.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
  P: TPair<TComponent, TGestureCollection>;
begin
  inherited;
  if ((Application = nil) or (Application.Terminated)) and (Length(FFileName) > 0) and not FSaved then
  begin
    SaveToFile(FFileName);
    FSaved := True;
  end;

  if Operation = opRemove then
  begin
    if AComponent is TCustomAction then
    begin
      // Remove Action from gestures
      for P in FControls do
        for I := 0 to P.Value.Count - 1 do
          if (P.Value[I].Action = AComponent) then
          begin
            P.Value[I].Action := nil;
          end;
    end
    else if not (AComponent is TGestureManager) then
    begin
      if (FNotifyList <> nil) and FNotifyList.Contains(AComponent) then
        FNotifyList.Remove(AComponent)
      else if not(csDestroying in ComponentState) then
        UnregisterControl(AComponent);
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

procedure TGestureManager.RegisterControl(const AControl: TComponent);
var
  LGObj: IGestureControl;
begin
  if AControl <> nil then
  begin
    // Create entry in dictionary
    if not FControls.ContainsKey(AControl) then
      FControls.Add(AControl, TGestureCollection.Create(Self));

    // Copy standard gestures into the control's collection
    if not(csLoading in ComponentState) and Supports(AControl, IGestureControl, LGObj) then
      StandardGestures[AControl] := LGObj.TouchManager.StandardGestures;

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

  if FRegisteredGestures.FindGesture(AGesture.Name) <> nil then
    raise EGestureException.CreateResFmt(@SDuplicateRegisteredGestureName,
      [AGesture.Name]);

  LItem := FRegisteredGestures.Add;
  LItem.Assign(AGesture);
  LItem.GestureID := FNextGestureID;
  Result := LItem.GestureID;
  Dec(FNextGestureID);

  if Assigned(FDesignerHook) then
    FDesignerHook(AGesture);
end;

procedure TGestureManager.RemoveChangeNotification(const AControl: TComponent);
begin
  if FNotifyList.Contains(AControl) then
  begin
    FNotifyList.Remove(AControl);
    AControl.RemoveFreeNotification(Self);
  end;
end;

procedure TGestureManager.RemoveRecordedGesture(const AGesture: TCustomGestureCollectionItem);
begin
  if AGesture <> nil then
  begin
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
    TDialogService.ShowMessage(SUnableToSaveSettings);
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

function TGestureManager.SelectGesture(const AControl: TComponent; const AName: string): Boolean;
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

function TGestureManager.SelectGesture(const AControl: TComponent; AGestureID: TGestureID): Boolean;
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

procedure TGestureManager.SetRecordedGestures(const Gestures: TGestureArray);
var
  I, J: Integer;
  Item: TCustomGestureCollectionItem;
  P: TPair<TComponent, TGestureCollection>;
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
        if (P.Value[I].GestureType = TGestureType.Recorded) then
          P.Value.Delete(I);
  end
  else
    // Iterate through each control's list and remove gesture ID's
    // that don't exist in the updated FCustomGestures list
    for P in FControls do
      for I := P.Value.Count - 1 downto 0 do
        for J := 0 to FRecordedGestures.Count - 1 do
        begin
          if (P.Value[I].GestureType = TGestureType.Recorded) and
            (FRecordedGestures.FindGesture(P.Value[I].GestureID) = nil)
          then
            P.Value.Delete(I);
        end;
end;

procedure TGestureManager.SetSensitivity(const AValue: Single);
begin
  TGestureEngine.Sensitivity := Round(AValue);
end;

procedure TGestureManager.SetStandardGestures(AControl: TComponent; AStandardGestures: TStandardGestures);
var
  I: Integer;
  List: TGestureCollection;
  LGesture: TStandardGesture;
begin
  // Get list of gestures for the AControl
  List := FControls.Items[AControl];

  // Remove any predefined gestures
  for I := List.Count - 1 downto 0 do
    if List[I].GestureType = TGestureType.Standard then
      List[I].DisposeOf;

  // Add new set of predefined gestures
  for LGesture := Low(TStandardGesture) to High(TStandardGesture) do
    if LGesture in AStandardGestures then
      List.Add.GestureID := TGestureID(LGesture);
end;

procedure TGestureManager.UnregisterControl(const AControl: TComponent);
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

class procedure TGestureManager.UnregisterGesture(const AGesture: TGestureID);
var
  LItem: TCustomGestureCollectionItem;
begin
  LItem := FRegisteredGestures.FindGesture(AGesture);
  if LItem <> nil then
    LItem.Free;
end;

procedure TGestureManager.UnselectGesture(const AControl: TComponent; AGestureID: TGestureID);
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
  P: TPair<TComponent, TGestureCollection>;
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
    // GestureType will be TGestureType.None while streaming in
    Result := ((GestureType = TGestureType.Recorded) or
      (GestureType = TGestureType.None)) and TGestureCollection(Collection).FStreamGestureDetails;
  end;

begin
  inherited;
  Filer.DefineProperty('Deviation', ReadDeviation, WriteDeviation, DoStream);// do not localize
  Filer.DefineProperty('ErrorMargin', ReadErrorMargin, WriteErrorMargin, DoStream); // do not localize
  Filer.DefineProperty('GestureID', ReadGestureID, WriteGestureID, GestureType <> TGestureType.Registered); // do not localize
  Filer.DefineProperty('Name', ReadName, WriteName, (GestureType = TGestureType.Registered) or DoStream); // do not localize
  Filer.DefineBinaryProperty('Points', ReadPoints, WritePoints, DoStream);// do not localize
end;

destructor TGestureCollectionItem.Destroy;
begin
  if (Action <> nil) and (Collection <> nil) and
    (TGestureCollection(Collection).GestureManager <> nil) then
    Action.RemoveFreeNotification(TGestureCollection(Collection).GestureManager);
  if FActionLink <> nil then
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
  if ActionLink <> nil then
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
  if GestureType = TGestureType.Standard then
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
    sgiNoGesture: Result := TGestureType.None;
    sgiFirst..sgiLast: Result := TGestureType.Standard;
    cgiFirst..cgiLast: Result := TGestureType.Recorded;
    rgiFirst..rgiLast: Result := TGestureType.Registered;
  else
    raise EGestureException.CreateResFmt(@SInvalidGestureID, [FGestureID]);
  end;
end;

function TGestureCollectionItem.GetName: string;
begin
  case GestureType of
    TGestureType.None, TGestureType.Standard:
      Result := DisplayName;
    TGestureType.Recorded, TGestureType.Registered:
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
    if (TGestureCollection(Collection).GestureManager <> nil) and (Action <> nil) then
      TGestureCollection(Collection).GestureManager.RemoveActionNotification(Action, Self);
    if Value = nil then
    begin
      FreeAndNil(FActionLink);
      SetActionClient(False);
    end
    else
    begin
      if ActionLink = nil then
      begin
        lClass := GetActionLinkClass;
        if lClass = nil then
          raise EActionError.CreateFMT(StrEActionNoSuported, [ClassName]);
        ActionLink := lClass.Create(Self);
      end;
      ActionLink.Action := Value;
      ActionLink.OnChange := DoActionChange;
      ActionChange(Value, csLoading in Value.ComponentState);
      if TGestureCollection(Collection).GestureManager <> nil then
        Value.FreeNotification(TGestureCollection(Collection).GestureManager);
      SetActionClient(True);
    end;
  end;
end;

procedure TGestureCollectionItem.SetActionClient(const Value: Boolean);
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
  if LGesture <> nil then
    LGesture.Free;
end;

procedure TGestureCollection.Update(Item: TCollectionItem);
begin
  if Assigned(FOnItemChange) then
    FOnItemChange(Self, TGestureNotification.gnChanged, TCustomGestureCollectionItem(Item));
end;

{ Standard gesture definitions }

const
  PDefaultLeft: array [0 .. 1] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0));

  CDefaultLeft: TStandardGestureData = (GestureID: sgiLeft;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRight: array [0 .. 1] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0));

  CDefaultRight: TStandardGestureData = (GestureID: sgiRight;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUp: array [0 .. 1] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0));

  CDefaultUp: TStandardGestureData = (GestureID: sgiUp;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDown: array [0 .. 1] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200));

  CDefaultDown: TStandardGestureData = (GestureID: sgiDown;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpLeft: array [0 .. 2] of TPointF = ((X: 200; Y: 200), (X: 200; Y: 0),
    (X: 0; Y: 0));

  CDefaultUpLeft: TStandardGestureData = (GestureID: sgiUpLeft;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpRight: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultUpRight: TStandardGestureData = (GestureID: sgiUpRight;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownLeft: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 200;
    Y: 200), (X: 0; Y: 200));

  CDefaultDownLeft: TStandardGestureData = (GestureID: sgiDownLeft;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownRight: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 200; Y: 200));

  CDefaultDownRight: TStandardGestureData = (GestureID: sgiDownRight;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftUp: array [0 .. 2] of TPointF = ((X: 200; Y: 200), (X: 0; Y: 200),
    (X: 0; Y: 0));

  CDefaultLeftUp: TStandardGestureData = (GestureID: sgiLeftUp;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftDown: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0),
    (X: 0; Y: 200));

  CDefaultLeftDown: TStandardGestureData = (GestureID: sgiLeftDown;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightUp: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 200;
    Y: 200), (X: 200; Y: 0));

  CDefaultRightUp: TStandardGestureData = (GestureID: sgiRightUp;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightDown: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0),
    (X: 200; Y: 200));

  CDefaultRightDown: TStandardGestureData = (GestureID: sgiRightDown;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpDown: array [0 .. 2] of TPointF = ((X: 0; Y: 200), (X: 0; Y: 0),
    (X: 0; Y: 200));

  CDefaultUpDown: TStandardGestureData = (GestureID: sgiUpDown;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownUp: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 0; Y: 0));

  CDefaultDownUp: TStandardGestureData = (GestureID: sgiDownUp;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultLeftRight: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultLeftRight: TStandardGestureData = (GestureID: sgiLeftRight;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultRightLeft: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 200; Y: 0),
    (X: 0; Y: 0));

  CDefaultRightLeft: TStandardGestureData = (GestureID: sgiRightLeft;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpLeftLong: array [0 .. 2] of TPointF = ((X: 200; Y: 100), (X: 200;
    Y: 0), (X: 0; Y: 0));

  CDefaultUpLeftLong: TStandardGestureData = (GestureID: sgiUpLeftLong;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultUpRightLong: array [0 .. 2] of TPointF = ((X: 0; Y: 100), (X: 0;
    Y: 0), (X: 200; Y: 0));

  CDefaultUpRightLong: TStandardGestureData = (GestureID: sgiUpRightLong;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownLeftLong: array [0 .. 2] of TPointF = ((X: 200; Y: 0), (X: 200;
    Y: 100), (X: 0; Y: 100));

  CDefaultDownLeftLong: TStandardGestureData = (GestureID: sgiDownLeftLong;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultDownRightLong: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 0;
    Y: 100), (X: 200; Y: 100));

  CDefaultDownRightLong: TStandardGestureData = (GestureID: sgiDownRightLong;
    Options: [TGestureOption.UniDirectional]; Deviation: 30; ErrorMargin: 20);

  PDefaultScratchout: array [0 .. 1] of TPointF = ((X: 0; Y: 0),
    (X: 200; Y: 0));

  CDefaultScratchout: TStandardGestureData = (GestureID: sgiScratchout;
    Options: []; Deviation: 30; ErrorMargin: 20);

  PDefaultTriangle: array [0 .. 3] of TPointF = ((X: 100; Y: 0), (X: 0; Y: 141),
    (X: 200; Y: 141), (X: 100; Y: 0));

  CDefaultTriangle: TStandardGestureData = (GestureID: sgiTriangle;
    Options: [TGestureOption.Skew, TGestureOption.Endpoint,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 40);

  PDefaultSquare: array [0 .. 4] of TPointF = ((X: 0; Y: 0), (X: 0; Y: 200),
    (X: 200; Y: 200), (X: 200; Y: 0), (X: 0; Y: 0));

  CDefaultSquare: TStandardGestureData = (GestureID: sgiSquare;
    Options: [TGestureOption.Skew, TGestureOption.Endpoint,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 40);

  PDefaultCheck: array [0 .. 2] of TPointF = ((X: 0; Y: 140), (X: 80; Y: 200),
    (X: 200; Y: 0));

  CDefaultCheck: TStandardGestureData = (GestureID: sgiCheck;
    Options: [TGestureOption.UniDirectional, TGestureOption.Rotate];
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
    Options: [TGestureOption.UniDirectional, TGestureOption.Skew,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 20);

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
    Options: [TGestureOption.UniDirectional, TGestureOption.Skew,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultCircle: array [0 .. 16] of TPointF = ((X: 50; Y: 0), (X: 32; Y: 4),
    (X: 16; Y: 16), (X: 4; Y: 31), (X: 0; Y: 50), (X: 4; Y: 67), (X: 15; Y: 85),
    (X: 31; Y: 95), (X: 50; Y: 100), (X: 68; Y: 96), (X: 84; Y: 84), (X: 96;
    Y: 69), (X: 100; Y: 50), (X: 97; Y: 30), (X: 85; Y: 14), (X: 68; Y: 3),
    (X: 50; Y: 0));

  CDefaultCircle: TStandardGestureData = (GestureID: sgiCircle;
    Options: [TGestureOption.Skew, TGestureOption.Endpoint]; Deviation: 30;
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
    Options: [TGestureOption.Skew, TGestureOption.Endpoint]; Deviation: 30;
    ErrorMargin: 40);

  PDefaultSemiCircleLeft: array [0 .. 8] of TPointF = ((X: 100; Y: 50), (X: 97;
    Y: 30), (X: 85; Y: 14), (X: 68; Y: 3), (X: 50; Y: 0), (X: 32; Y: 4), (X: 16;
    Y: 16), (X: 4; Y: 31), (X: 0; Y: 50));

  CDefaultSemiCircleLeft: TStandardGestureData = (GestureID: sgiSemiCircleLeft;
    Options: [TGestureOption.UniDirectional, TGestureOption.Endpoint,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultSemiCircleRight: array [0 .. 8] of TPointF = ((X: 0; Y: 50), (X: 4;
    Y: 31), (X: 16; Y: 16), (X: 32; Y: 4), (X: 50; Y: 0), (X: 68; Y: 3), (X: 85;
    Y: 14), (X: 97; Y: 30), (X: 100; Y: 50));

  CDefaultSemiCircleRight: TStandardGestureData = (GestureID: sgiSemiCircleLeft;
    Options: [TGestureOption.UniDirectional, TGestureOption.Endpoint,
    TGestureOption.Rotate]; Deviation: 30; ErrorMargin: 30);

  PDefaultChevronUp: array [0 .. 2] of TPointF = ((X: 0; Y: 100), (X: 100;
    Y: 0), (X: 200; Y: 100));

  CDefaultChevronUp: TStandardGestureData = (GestureID: sgiChevronUp;
    Options: [TGestureOption.Skew, TGestureOption.Rotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronDown: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 100;
    Y: 100), (X: 200; Y: 0));

  CDefaultChevronDown: TStandardGestureData = (GestureID: sgiChevronDown;
    Options: [TGestureOption.Skew, TGestureOption.Rotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronLeft: array [0 .. 2] of TPointF = ((X: 100; Y: 0), (X: 0;
    Y: 100), (X: 100; Y: 200));

  CDefaultChevronLeft: TStandardGestureData = (GestureID: sgiChevronLeft;
    Options: [TGestureOption.Skew, TGestureOption.Rotate]; Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronRight: array [0 .. 2] of TPointF = ((X: 0; Y: 0), (X: 100;
    Y: 100), (X: 0; Y: 200));

  CDefaultChevronRight: TStandardGestureData = (GestureID: sgiChevronRight;
    Options: [TGestureOption.Skew, TGestureOption.Rotate]; Deviation: 20;
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

function CheckPointInGestureWindow(Point: TPointF; const SourcePoints: array of TPointF; const GestureIndex: Integer;
  var Verification: TDoubleDynArray; ADeviation, ErrorMargin: Integer): Boolean;
var
  Index: Integer;
  Percentage: Double;
begin
  Result := False;

  if (GestureIndex < Length(SourcePoints)) and (GestureIndex < Length(Verification)) then
    for Index := 0 to GestureIndex do
    begin
      Percentage := CheckPoint(Point, SourcePoints[Index], ADeviation, ErrorMargin);
      if Percentage > ErrorMargin then
      begin
        if Verification[Index] < Percentage then
          Verification[Index] := Percentage;
        Result := True;
      end;
    end;
end;

function CheckLineIntersectsCircle(const Line: TLine2D; const SourcePoints: array of TPointF; GestureIndex, Radius: Integer; var Verification: TIntegerDynArray): Boolean;
var
  Index: Integer;
begin
  Result := False;

  if (GestureIndex < Length(SourcePoints)) and (GestureIndex < Length(Verification)) then
    for Index := 0 to GestureIndex do
      if Line.Intersects(TCircle2D.Create(SourcePoints[Index], Radius)) then
      begin
        Result := True;
        Inc(Verification[Index]);
      end;
end;

type
  TGesturePoint = record
    Point: TPointF;
    Angle: Single;
    Index: Integer;
  end;

  TPointList = TList<TGesturePoint>;

procedure TGestureEngine.AddPoint(const X, Y: Single);
const
  DistanceThreshold = 6;
var
  StepX, StepY: Single;
  DeltaXF, DeltaYF: Single;
  I, DeltaX, DeltaY: Integer;
  LastPoint, NextPoint: TPointF;
  CountX, CountY, Count: Integer;
begin
  if FPoints = nil then
    FPoints := TGesturePoints.Create;

  if FPoints.Count = 0 then
    FPoints.Add(TPointF.Create(X, Y))
  else
  begin
    NextPoint := TPointF.Create(X, Y);
    LastPoint := FPoints[FPoints.Count - 1];

    // Determine distance between points
    DeltaXF := Abs(NextPoint.X - LastPoint.X);
    DeltaYF := Abs(NextPoint.Y - LastPoint.Y);

    // If points are too close together discard the new point
    if (DeltaXF < 1) and (DeltaYF < 1) then
      Exit;

    // If the difference is too small, use the last coordinate.
    if DeltaXF < 1 then
      NextPoint.X := LastPoint.X;
    if DeltaYF < 1 then
      NextPoint.Y := LastPoint.Y;

    // If points are too far apart insert intermediate points.
    if (DeltaXF > DistanceThreshold) or (DeltaYF > DistanceThreshold) then
    begin
      // Determine integer distance between points.
      DeltaX := Round(DeltaXF);
      DeltaY := Round(DeltaYF);

      // Determine how many points to insert
      CountX := DeltaX div 5;
      if (DeltaX mod 5) = 0 then
        Dec(CountX);
      CountY := DeltaY div 5;
      if (DeltaY mod 5) = 0 then
        Dec(CountY);
      Count := Max(CountX, CountY);

      // Determine spacing between inserted points
      StepX := (NextPoint.X - LastPoint.X) / Count;
      StepY := (NextPoint.Y - LastPoint.Y) / Count;

      // Insert points
      for I := 1 to Count - 1 do
        FPoints.Add(TPointF.Create(LastPoint.X + Round(StepX * I), LastPoint.Y + Round(StepY * I)));
    end;

    // Add captured point
    FPoints.Add(NextPoint);
  end;
end;


procedure TGestureEngine.BroadcastGesture(const AControl: TComponent; EventInfo: TGestureEventInfo);
var
  LObj: IGestureControl;
begin
  EventInfo.Location := InitialPoint;
  if Supports(AControl, IGestureControl, LObj) then
    LObj.BroadcastGesture(EventInfo);
end;

procedure TGestureEngine.ClearPoints;
begin
  if FPoints = nil then
    FPoints := TGesturePoints.Create
  else
    FPoints.Clear;
end;

class constructor TGestureEngine.Create;
begin
  FSensitivity := 80; // 80% by default
end;

class procedure TGestureEngine.CreateEngine(const AControl: TComponent);
var
  LGObj: IGestureControl;
begin
  FGestureEngineType := TPlatformGestureEngine;
  if not(csDesigning in AControl.ComponentState) and Supports(AControl, IGestureControl, LGObj) and (LGObj.TouchManager.GestureEngine = nil) then
    LGObj.TouchManager.GestureEngine := FGestureEngineType.GetGestureEngine(AControl);
end;

destructor TGestureEngine.Destroy;
begin
  if FPoints <> nil then
    FreeAndNil(FPoints);
  inherited;
end;

class procedure TGestureEngine.DoSetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass);
begin
  if Value <> FDefaultRecognizerClass then
  begin
    FDefaultRecognizerClass := Value;
    FreeAndNil(FRecognizer);
  end;
end;

class procedure TGestureEngine.GetCompleteGestureList(const AControl: TComponent; const AGestureList: TGestureList);
var
  LItem: TCustomGestureCollectionItem;
  LGObj: IGestureControl;
  LTouchManager: TTouchManager;
begin
  if Supports(AControl, IGestureControl, LGObj) then
  begin
    LTouchManager := LGObj.TouchManager;
    if LTouchManager.GestureManager <> nil then
      for LItem in LTouchManager.GestureList do
        AGestureList.Add(LItem);
  end;
end;

function TGestureEngine.GetPointCount: Integer;
begin
  if FPoints <> nil then
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
  if FPoints <> nil then
    Result := GesturePointsToArray(FPoints)
  else
    Result := TGesturePointArray.Create();
end;

class function TGestureEngine.DoGetRecognizer: TCustomGestureRecognizer;
begin
  if FRecognizer = nil then
    FRecognizer := DefaultRecognizerClass.Create;
  Result := FRecognizer;
end;

class function TGestureEngine.GetRecognizer: TCustomGestureRecognizer;
begin
  Result := DoGetRecognizer;
end;

class function TGestureEngine.IsGesture(const Points: array of TPointF; const Items: TGestureList;
  GestureTypes: TGestureTypes; var EventInfo: TGestureEventInfo): Boolean;
var
  LItem: TCustomGestureCollectionItem;
  LData: TStandardGestureData;
  LWeight, TempWeight: Single;
  I: Integer;
begin
  Result := False;
  FillChar(EventInfo, Sizeof(EventInfo), 0);

  if Items <> nil then
  begin
    LWeight := 0;

    // Process standard gestures
    if TGestureType.Standard in GestureTypes then
      for I := 0 to Items.Count - 1 do
      begin
        LItem := Items[I];
        if LItem.GestureType = TGestureType.Standard then
        begin
          if not FindStandardGesture(LItem.GestureID, LData) then
            raise EGestureException.CreateResFmt(@SInvalidGestureID, [LItem.GestureID]);

          TempWeight := Recognizer.Match(Points, LData.Points, LData.Options, LData.GestureID, LData.Deviation, LData.ErrorMargin);
          if TempWeight > LWeight then
          begin
            LWeight := TempWeight;
            EventInfo.GestureID := LItem.GestureID;
          end;
        end;
      end;

    if LWeight > 0 then
      Exit(True);

    // Process custom gestures
    if CustomGestureTypes * GestureTypes = CustomGestureTypes then
      for I := 0 to Items.Count - 1 do
      begin
        LItem := Items[I];
        if LItem.GestureType in CustomGestureTypes then
        begin
          TempWeight := Recognizer.Match(Points, LItem.Points, LItem.Options, LItem.GestureID, LItem.Deviation, LItem.ErrorMargin);

          if TempWeight > LWeight then
          begin
            LWeight := TempWeight;
            EventInfo.GestureID := LItem.GestureID;
          end;
        end;
      end;

    if LWeight > 0 then
      Exit(True);

    // No gesture was recognized. Return True if 3 or more points are in the list
    // so the listener is notified that a gesture occurred but wasn't recognized
    EventInfo.GestureID := sgiNoGesture;
    Result := Length(Points) >= 3;
  end;
end;

class procedure TGestureEngine.SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass);
begin
  DoSetDefaultRecognizerClass(Value);
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
      FSensitivity := Value
    else
      raise Exception.CreateResFmt(@SOutOfRange, [1, 100]);
  end;
end;

{ TCustomGestureRecognizer }

class function TCustomGestureRecognizer.IsPointsGesture(const Points, GesturePoints: array of TPointF;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer;
var
  Index: Integer;
  AnglesMatched: Integer;
  LowestPercentage: Double;
  DegreeError: Double;
  Match: TDoubleDynArray;
  GestureIndex: Integer;
  DistancePoints: array of TPointF;
  Distances: TSingleDynarray;
  Distance: Single;
  PointsCount: Integer;
  GestureCount: Integer;
  GestureAngles: TDoubleDynArray;
  DistanceAngles: TDoubleDynArray;
  LinesMatched: Integer;
  LinesMatch: TIntegerDynArray;
  PointsIndex: Integer;
  PointsMatch: TDoubleDynArray;
  Passes, Fails: Double;
  PassesCount, FailsCount: Integer;
  Point: TPointF;
  GesturePointsPercentage: Integer;
  PointsPercentage: Integer;
begin
  Result := 0;

  PointsCount := Length(Points);
  GestureCount := Length(GesturePoints);

  if (PointsCount > 0) and (GestureCount > 0) then
  begin
    SetLength(Match, GestureCount);
    SetLength(Distances, GestureCount);
    SetLength(DistancePoints, GestureCount);
    SetLength(GestureAngles, GestureCount);
    SetLength(DistanceAngles, GestureCount);
    SetLength(LinesMatch, GestureCount);
    SetLength(PointsMatch, PointsCount);
    PointsPercentage := 0;
    GestureIndex := 0;
    LinesMatched := 0;
    PointsIndex := 0;

    for Index := 0 to GestureCount - 1 do
    begin
      // Initialize distances between the points and the gestures as very far.
      Distances[Index] := MaxInt;

      while (PointsIndex + 1 < PointsCount) and IsPointInCircle(GesturePoints[Index], Points[PointsIndex + 1], Deviation) do
        Inc(PointsIndex);

      CheckPointInGestureWindow(GesturePoints[Index], Points, PointsIndex, PointsMatch, Deviation, ErrorMargin);
    end;

    for Index := 0 to PointsCount - 1 do
    begin
      Inc(PointsPercentage, Round(PointsMatch[Index]));

      while (GestureIndex + 1 < GestureCount) and IsPointInCircle(Points[Index], GesturePoints[GestureIndex + 1], Deviation) do
        Inc(GestureIndex);

      CheckPointInGestureWindow(Points[Index], GesturePoints, GestureIndex, Match, Deviation, ErrorMargin);

      if Index + 1 < PointsCount - 1 then
        CheckLineIntersectsCircle(TLine2D.Create(Points[Index], Points[Index + 1]), GesturePoints, GestureIndex, Deviation, LinesMatch);
    end;

    // Find the distances between the points.
    for Index := 0 to PointsCount - 1 do
    begin
      Point := Points[Index];

      for GestureIndex := 0 to GestureCount - 1 do
      begin
        // Calculate the closest point to the gesture points.
        Distance := Point.Distance(GesturePoints[GestureIndex]);

        if Distance < Distances[GestureIndex] then
        begin
          Distances[GestureIndex] := Distance;
          DistancePoints[GestureIndex] := Point;
        end;
      end;
    end;

    // Calculate the angle between the points and the gesture's points.
    Index := 0;
    GesturePointsPercentage := 0;
    while Index < GestureCount do
    begin
      Inc(GesturePointsPercentage, Round(Match[Index]));

      if LinesMatch[Index] > 0 then
        Inc(LinesMatched);

      if Index + 1 < GestureCount - 1 then
      begin
        GestureAngles[Index] := ArcTan2(GesturePoints[Index].X - GesturePoints[Index + 1].X, GesturePoints[Index].Y - GesturePoints[Index + 1].Y);
        DistanceAngles[Index] := ArcTan2(DistancePoints[Index].X - DistancePoints[Index + 1].X, DistancePoints[Index].Y - DistancePoints[Index + 1].Y);
      end
      else
      begin
        GestureAngles[Index] := ArcTan2(GesturePoints[Index - 1].X - GesturePoints[Index].X, GesturePoints[Index - 1].Y - GesturePoints[Index].Y);
        DistanceAngles[Index] := ArcTan2(DistancePoints[Index - 1].X - DistancePoints[Index].X, DistancePoints[Index - 1].Y - DistancePoints[Index].Y);
      end;

      Inc(Index);
    end;

    AnglesMatched := 0;
    DegreeError := (ErrorMargin * Pi) / 100;

    for Index := 0 to GestureCount - 1 do
    begin
      if (DistanceAngles[Index] = 0) or ((GestureAngles[Index] - DegreeError) < DistanceAngles[Index]) and (DistanceAngles[Index] < (GestureAngles[Index] + DegreeError)) then
      begin
        Inc(AnglesMatched);
      end;
    end;

    Percentages[0] := PointsPercentage div PointsCount;
    Percentages[1] := GesturePointsPercentage div GestureCount;
    Percentages[2] := 100 * AnglesMatched / GestureCount;
    Percentages[3] := 100 * LinesMatched / GestureCount;

    LowestPercentage := MaxInt;

    for Index := 0 to Length(Percentages) - 1 do
    begin
      if Percentages[Index] < LowestPercentage then
        LowestPercentage := Percentages[Index];
    end;

    if (100 - ErrorMargin) < LowestPercentage then
      Result := Trunc(LowestPercentage)
    else
    begin
      Passes := 0;
      PassesCount := 0;
      Fails := 0;
      FailsCount := 0;

      for Index := 0 to Length(Percentages) - 1 do
      begin
        if Percentages[Index] <= ((100 - ErrorMargin) div 4) then
          Exit;

        if (100 - ErrorMargin) < Percentages[Index] then
        begin
          Inc(PassesCount);
          Passes := Passes + Percentages[Index];
        end
        else
        begin
          Inc(FailsCount);
          Fails := Fails + Percentages[Index];
        end;
      end;

      if (Passes <> 0) and (Fails <> 0) then
      begin
        Passes := Passes / PassesCount;
        Fails := Fails / FailsCount;
        Result := Trunc((Passes + Fails) / 2);

        if (100 - ErrorMargin) >= Result then
          Result := 0;
      end;
    end;
  end;
end;

type
  TSegmentArray = array of TGesturePointArray;

class function TCustomGestureRecognizer.IsScratchout(const Points: array of TPointF; GestureID: TGestureID;
  const Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer;

  function SegmentPoints(const Points: array of TPointF; var Right: Boolean): TSegmentArray;
  const
    SegmentPointCountThreshold = 5;
  var
    Index: Integer;
    Max, Min: Double;
    Segment: TGesturePoints;
    Diff: Double;
    LRight: Boolean;
  begin
    Min := MaxInt;
    Max := 0;
    if Length(Points) > 2 then
    begin
      Diff := Points[1].X - Points[0].X;

      if Diff = 0 then
        Exit
      else if Diff > 0 then
        Right := True
      else
        Right := False;

      LRight := Right;
      Segment := TGesturePoints.Create;

      try
        for Index := 0 to Length(Points) - 1 do
        begin
          if LRight and (Points[Index].X > Max) then
          begin
            Max := Points[Index].X;
            Segment.Add(Points[Index]);
          end
          else if not LRight and (Points[Index].X < Min) then
          begin
            Min := Points[Index].X;
            Segment.Add(Points[Index]);
          end
          else if Points[Index].X = 0 then
            Segment.Add(Points[Index])
          else
          begin
            SetLength(Result, Length(Result) + 1);
            Result[Length(Result) - 1] := CopyGesturePoints(Segment);
            Min := MaxInt;
            Max := 0;
            Segment.Clear;
            Segment.Add(Points[Index]);
            LRight := not LRight;
          end;
        end;

        if Segment.Count > 0 then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := CopyGesturePoints(Segment);
        end;

        // The last line segment may be short, so if it is less than a few points
        // throw it out.
        if (Length(Result) > 0) and (Length(Result[Length(Result) - 1]) < SegmentPointCountThreshold) then
          SetLength(Result, Length(Result) - 1);
      finally
        Segment.Free;
      end;
    end;
  end;

  function HeightDeviation(const Points: array of TPointF): Double;
  var
    Index, Count: Integer;
    Min, Max: Double;
    Point: TPointF;
  begin
    Result := MaxInt;
    Count := Length(Points);

    if Count > 0 then
    begin
      Min := MaxInt;
      Max := 0;

      for Index := 0 to Count - 1 do
      begin
        Point := Points[Index];

        if Point.Y < Min then
          Min := Point.Y;
        if Point.Y > Max then
          Max := Point.Y;
      end;

      Result := Max - Min;
    end;
  end;

var
  Index, PercentagesIndex: Integer;
  Segments: TSegmentArray;
  Gesture, SecondGesture, FirstGesture: TStandardGestureData;
  Right: Boolean;
  LPoints, LGesturePoints, LFirstPoints, LSecondPoints: TGesturePointArray;
  Results: array of Integer;
  SegmentsCount, Weight: Integer;
  LowestPercentage: Double;
  LPercentages: array of Double;
  Angles: array of Double;
begin
  Result := 0;
  LPoints := RemoveDuplicatedGesturePoints(Points);
  if HeightDeviation(LPoints) > Deviation then
    Exit;
  Segments := SegmentPoints(LPoints, Right);
  SegmentsCount := Length(Segments);

  if SegmentsCount >= 3 then
  begin
    SetLength(LPercentages, Length(Percentages));
    SetLength(Angles, SegmentsCount);

    if Right then
    begin
      FindStandardGesture(sgiRight, FirstGesture);
      LFirstPoints := InterpolateGesturePoints(FirstGesture.Points);
      LFirstPoints := RemoveDuplicatedGesturePoints(LFirstPoints);

      FindStandardGesture(sgiLeft, SecondGesture);
      LSecondPoints := InterpolateGesturePoints(SecondGesture.Points);
      LSecondPoints := RemoveDuplicatedGesturePoints(LSecondPoints);
    end
    else
    begin
      FindStandardGesture(sgiLeft, FirstGesture);
      LFirstPoints := InterpolateGesturePoints(FirstGesture.Points);
      LFirstPoints := RemoveDuplicatedGesturePoints(LFirstPoints);

      FindStandardGesture(sgiRight, SecondGesture);
      LSecondPoints := InterpolateGesturePoints(SecondGesture.Points);
      LSecondPoints := RemoveDuplicatedGesturePoints(LSecondPoints);
    end;

    for Index := 0 to SegmentsCount - 1 do
    begin
      case Index mod 2 of
        0:
          begin
            Gesture := FirstGesture;
            LGesturePoints := LFirstPoints;
          end;
        1:
          begin
            Gesture := SecondGesture;
            LGesturePoints := LSecondPoints;
          end;
      end;

      LPoints := RotateGesturePoints(Segments[Index], LGesturePoints, ErrorMargin, Angles[Index]);
      LPoints := NormalizeGesturePoints(LPoints);
      LPoints := ScaleGesturePoints(LPoints, Gesture.Points, Deviation, False);
      LPoints := RemoveDuplicatedGesturePoints(LPoints);
      Weight := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
        ErrorMargin, LPercentages);
      SetLength(Results, Length(Results) + 1);
      Results[Length(Results) - 1] := Weight;

      for PercentagesIndex := 0 to Length(Percentages) - 1 do
      begin
        Percentages[PercentagesIndex] := Percentages[PercentagesIndex] + LPercentages[PercentagesIndex];
        LPercentages[PercentagesIndex] := 0;
      end;
    end;

    LowestPercentage := MaxInt;

    for PercentagesIndex := 0 to Length(Percentages) - 1 do
      Percentages[PercentagesIndex] := Percentages[PercentagesIndex] / SegmentsCount;

    for Index := 0 to Length(Percentages) - 1 do
    begin
      if Percentages[Index] < LowestPercentage then
        LowestPercentage := Percentages[Index];
    end;

    if (100 - ErrorMargin) < LowestPercentage then
      Result := Trunc(LowestPercentage);
  end;
end;

class function TCustomGestureRecognizer.NormalizeGesturePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index: Integer;
  SmallestX, SmallestY: Single;
begin
  SetLength(Result, Length(Points));
  // Find the delta.
  SmallestX := MaxInt;
  SmallestY := MaxInt;

  for Index := 0 to Length(Points) - 1 do
  begin
    if SmallestX > Points[Index].X then
      SmallestX := Points[Index].X;

    if SmallestY > Points[Index].Y then
      SmallestY := Points[Index].Y;
  end;

  // Apply the delta.
  SetLength(Result, Length(Points));
  for Index := 0 to Length(Points) - 1 do
    Result[Index] := TPointF.Create(Points[Index].X - SmallestX, Points[Index].Y - SmallestY);
end;

function TCustomGestureRecognizer.NormalizePoints(const Points: array of TPointF): TGesturePointArray;
begin
  Result := NormalizeGesturePoints(Points);
end;

class function TCustomGestureRecognizer.RemoveDuplicatedGesturePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index, PointsCount: Integer;
  LastPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        LastPoint := Points[Index];

        if (LastPoint.X <> NextPoint.X) or (LastPoint.Y <> NextPoint.Y) then
          ResultPoints.Add(NextPoint);
      end;
    end;

    Result := CopyGesturePoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;
end;

function TCustomGestureRecognizer.RemoveDuplicates(const Points: array of TPointF): TGesturePointArray;
begin
  Result := RemoveDuplicatedGesturePoints(Points);
end;

class function TCustomGestureRecognizer.RotateGesturePoints(const Points, GesturePoints: array of TPointF;
  ErrorMargin: Integer; var Angle: Double): TGesturePointArray;

  function WithinError(const Point1, Point2: TPointF; ErrorMargin: Integer; var Angle: Double): Boolean;
  var
    Angle1, Angle2: Double;
    DegreeError: Double;
  begin
    Result := False;
    Angle1 := ArcTan2(Point1.X, Point1.Y);
    Angle2 := ArcTan2(Point2.X, Point2.Y);
    Angle := Angle1 - Angle2;
    DegreeError := (ErrorMargin * Pi) / 100;
    if Abs(Angle) < DegreeError then
      Result := True;
  end;

var
  Index, GestureCount, PointsCount: Integer;
  Origin, Point2: TPointF;
  Success: Boolean;
begin
  Success := False;
  GestureCount := Length(GesturePoints);
  PointsCount := Length(Points);
  SetLength(Result, PointsCount);

  if (GestureCount > 1) and (PointsCount > 1) then
  begin
    Origin := GesturePoints[0];
    Point2 := GesturePoints[GestureCount - 1];

    if (Origin.X = Points[0].X) and (Origin.Y = Points[0].Y) then
    begin
      if WithinError(Point2, Points[PointsCount - 1], ErrorMargin, Angle) then
      begin
        Success := True;
        for Index := 0 to Length(Points) - 1 do
        begin
          Result[Index].X := Points[Index].X * Cos(Angle) + Points[Index].Y * Sin(Angle);
          Result[Index].Y := Points[Index].Y * Cos(Angle) - Points[Index].X * Sin(Angle);
        end;
      end;
    end;
  end;

  if not Success and (PointsCount > 0) then
  begin
    SetLength(Result, PointsCount);
    Move(Points[0], Result[0], PointsCount * Sizeof(TPointF));
  end;
end;

function TCustomGestureRecognizer.RotatePoints(const Points, GesturePoints: array of TPointF; ErrorMargin: Integer;
  var Angle: Double): TGesturePointArray;
begin
  Result := RotateGesturePoints(Points, GesturePoints, ErrorMargin, Angle);
end;

class function TCustomGestureRecognizer.ScaleGesturePoints(const Points, GesturePoints: array of TPointF;
  const MinScale: Integer; const Scaling: Boolean): TGesturePointArray;
var
  Index: Integer;
  LargestX1, LargestX2, LargestY1, LargestY2: Double;
  ScaleX, ScaleY, Scale: Double;
  LPoint: TPointF;
begin
  // Find the delta.
  LargestX1 := 0;
  LargestY1 := 0;
  LargestX2 := 0;
  LargestY2 := 0;

  for Index := 0 to Length(Points) - 1 do
  begin
    if LargestX1 < Abs(Points[Index].X) then
      LargestX1 := Abs(Points[Index].X);

    if LargestY1 < Abs(Points[Index].Y) then
      LargestY1 := Abs(Points[Index].Y);
  end;

  for Index := 0 to Length(GesturePoints) - 1 do
  begin
    if LargestX2 < Abs(GesturePoints[Index].X) then
      LargestX2 := Abs(GesturePoints[Index].X);

    if LargestY2 < Abs(GesturePoints[Index].Y) then
      LargestY2 := Abs(GesturePoints[Index].Y);
  end;

  if (LargestX1 = 0) or (LargestX2 = 0) then
    ScaleX := 1
  else
    ScaleX := LargestX2 / LargestX1;

  if (LargestY1 = 0) or (LargestY2 = 0) then
    ScaleY := 1
  else
    ScaleY := LargestY2 / LargestY1;

  // Apply the scale.
  SetLength(Result, Length(Points));

  if Scaling or (ScaleX = 1) or (ScaleY = 1) then
  begin
    for Index := 0 to Length(Result) - 1 do
    begin
      LPoint := Points[Index];
      Result[Index] := TPointF.Create(Round(LPoint.X * ScaleX), Round(LPoint.Y * ScaleY));
    end;
  end
  else if (ScaleX <> 1) and (ScaleY <> 1) then
  begin
    if ScaleX < ScaleY then
      Scale := ScaleX
    else
      Scale := ScaleY;

    for Index := 0 to Length(Result) - 1 do
    begin
      LPoint := Points[Index];

      Result[Index] := TPointF.Create(Round(LPoint.X * Scale), Round(LPoint.Y * Scale));
    end;
  end;

end;

function TCustomGestureRecognizer.ScalePoints(const Points, GesturePoints: array of TPointF; MinScale: Integer;
  Scaling: Boolean): TGesturePointArray;
begin
  Result := ScaleGesturePoints(Points, GesturePoints, MinScale, Scaling);
end;

class function TCustomGestureRecognizer.CopyGesturePoints(const Points: TGesturePoints)
  : TGesturePointArray;
var
  Index: Integer;
begin
  SetLength(Result, Points.Count);
  for Index := 0 to Points.Count - 1 do
    Result[Index] := Points[Index];
end;

class function TCustomGestureRecognizer.InterpolateGesturePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index, PointsCount: Integer;
  StepX, StepY: Double;
  I, DeltaX, DeltaY, Count: Integer;
  CurrentPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  Count := 0; // avoid compiler warning
  StepX := 0; // avoid compiler warning
  StepY := 0; // avoid compiler warning
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        CurrentPoint := Points[Index];

        // Determine distance between points
        DeltaX := Round(NextPoint.X - CurrentPoint.X);
        DeltaY := Round(NextPoint.Y - CurrentPoint.Y);

        if (DeltaX <> 0) and (DeltaY <> 0) then
        begin
          if Abs(DeltaX) > Abs(DeltaY) then
            Count := Abs(DeltaY)
          else
            Count := Abs(DeltaX);

          StepX := DeltaX / Count;
          StepY := DeltaY / Count;
        end
        else if (DeltaX = 0) and (DeltaY <> 0) then
        begin
          StepX := 0;
          StepY := DeltaY div Abs(DeltaY);
          Count := Abs(DeltaY);
        end
        else if (DeltaX <> 0) and (DeltaY = 0) then
        begin
          StepY := 0;
          StepX := DeltaX div Abs(DeltaX);
          Count := Abs(DeltaX);
        end;

        for I := 1 to Count - 1 do
        begin
          ResultPoints.Add(TPointF.Create(CurrentPoint.X + Trunc(StepX * I),
            CurrentPoint.Y + Trunc(StepY * I)));
        end;
      end;

      ResultPoints.Add(NextPoint);
    end;

    Result := CopyGesturePoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;
end;

class function TCustomGestureRecognizer.ReverseGesturePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index1, Index2, Count: Integer;
begin
  Count := Length(Points);
  SetLength(Result, Count);
  Index2 := Count - 1;

  for Index1 := 0 to Count - 1 do
  begin
    Result[Index2] := Points[Index1];
    Dec(Index2);
  end;
end;

initialization
  RegisterIntegerConsts(TypeInfo(TGestureID), IdentToGesture, GestureToIdent);
end.
