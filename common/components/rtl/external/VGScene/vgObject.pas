unit vgObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$IfNDef NoVGScene}

uses
  Classes,
  Controls,

  vgTypesPrim,
  vgTypes,
  vgInterfaces,
  vgAnyObjectList,
  vgCustomObject,
  vgSortableObjectList,
  vgCustomObjectList
  ;

type
  TvgObject = class(TvgCustomObject)
  private
    FStored: boolean;
  protected  
    FResourceName: string;
  private
    FNotifyList: TvgAnyObjectList;
    FTagObject: TObject;
    FTagFloat: single;
    FTagString: string;
    FBindingName: string;
    FIndex: integer;
    function GetScene: IvgScene;
    procedure ReaderSetName(Reader: TReader; Component: TComponent;
      var Name: string);
    procedure ReaderError(Reader: TReader; const Message: string;
      var Handled: Boolean);
    procedure SetResourceName(const Value: string);
    procedure SetStored(const Value: boolean);
    function GetChild(Index: integer): TvgObject;
    function GetChildrenCount: integer;
    procedure SetBindingName(const Value: string);
    function GetIndex: integer;
    procedure SetIndex(Idx: integer);
  protected
    //FIsVisual: boolean;
    FVisual: TvgObject{TvgVisualObject};
    FChildren: TvgSortableObjectList;
    FParent: TvgObject;
    FScene: IvgScene;
    function pm_GetIsVisual : Boolean; override;
    procedure SetNewScene(AScene: IvgScene); virtual;
    {$IfDef DesignTimeLibrary}
    procedure DoReleaseTimer(Sender: TObject);
    {$EndIf DesignTimeLibrary}
    { VCL }
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure SetParentComponent(Value: TComponent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    { }
    {$IfNDef Nemesis}
    procedure ChangeParent; virtual;
    {$EndIf  Nemesis}
    procedure SetParent(const Value: TvgObject); virtual;
    function HasClipParent: TvgObject{TvgVisualObject};
    { binding }
    function GetBinding(Index: string): Variant; virtual;
    procedure SetBinding(Index: string; const Value: Variant); virtual;
    function GetData: Variant; virtual;
    procedure SetData(const Value: Variant); virtual;
    { internal streaming }
  public
    procedure IntLoadFromBinStream(const AStream: TStream);
  protected  
    procedure IntSaveToBinStream(const AStream: TStream);
    { ani }
    procedure DoAniFinished(Sender: TObject);
   function DoTab(const aScene   : IvgScene;
                  aControl : TControl;
                  aShift   : Boolean): Boolean; virtual;
   function IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    {$IfDef DesignTimeLibrary}
    procedure Release(Delay: single = 0.1);
    {$EndIf DesignTimeLibrary}
    { design }
    {$IfDef vgDesign}
    function ItemClass: string; virtual;
    {$EndIf vgDesign}
    { clone }
    function Clone(const AOwner: TComponent): TvgObject;
    procedure CloneChildFromStream(AStream: TStream);
    { childs  }
    procedure AddObject(AObject: TvgObject); virtual;
    procedure RemoveObject(AObject: TvgObject); virtual;
    procedure Exchange(AObject1, AObject2: TvgObject); //virtual;
    procedure DeleteChildren; virtual;
    procedure BringToFront;
    procedure SendToBack;
    procedure AddObjectsToList(AList: TvgCustomObjectList);
    procedure AddControlsToList(AList: TvgCustomObjectList);
    procedure Sort(Compare: TvgObjectSortCompare);
    { notify }
    procedure AddFreeNotify(const AObject: TObject);
    procedure RemoveFreeNotify(const AObject: TObject);
    { i/o }
    procedure LoadFromStream(const AStream: TStream);
    procedure SaveToStream(const Stream: TStream);
    procedure LoadFromBinStream(const AStream: TStream);
    procedure SaveToBinStream(const AStream: TStream);
    { resoruce }
    function FindResource(const AResource: string): TvgObject; virtual;
    procedure UpdateResource; virtual;
    { animations }
    procedure StartAnimation(const AName: WideString); virtual;
    procedure StopAnimation(const AName: WideString); virtual;
    procedure StartTriggerAnimation(AInstance: TvgObject; ATrigger: string); virtual;
    procedure StartTriggerAnimationWait(AInstance: TvgObject; ATrigger: string); virtual;
    procedure StopTriggerAnimation(AInstance: TvgObject); virtual;
    procedure ApplyTriggerEffect(AInstance: TvgObject; ATrigger: string); virtual;
    { animation property }
    procedure AnimateFloat(const APropertyName: string; const NewValue: single; Duration: single = 0.2;
      AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
    procedure AnimateColor(const APropertyName: string; const NewValue: string; Duration: single = 0.2;
      AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
    procedure AnimateFloatDelay(const APropertyName: string; const NewValue: single; Duration: single = 0.2;
      Delay: single = 0.0; AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
    procedure AnimateFloatWait(const APropertyName: string; const NewValue: single; Duration: single = 0.2;
      AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
    { }
    //property IsVisual: boolean read FIsVisual;
    property Visual: TvgObject read FVisual;
    property Scene: IvgScene read FScene;
    property Stored: boolean read FStored write SetStored;
    { }
    property TagObject: TObject read FTagObject write FTagObject;
    property TagFloat: single read FTagFloat write FTagFloat;
    property TagString: string read FTagString write FTagString;
    { children }
    property ChildrenCount: integer read GetChildrenCount;
    property Children[Index: integer]: TvgObject read GetChild;
    { binding }
    function FindBinding(const ABinding: string): TvgObject;
    property Data: Variant read GetData write SetData;
    property Binding[Index: string]: Variant read GetBinding write SetBinding;
    procedure FreeChild(i : Integer);
  published
    property Index: integer read GetIndex write SetIndex stored false;
    property Parent: TvgObject read FParent write SetParent stored false;
    property BindingName: string read FBindingName write SetBindingName;
    property ResourceName: string read FResourceName write SetResourceName;
  end;//TvgObject

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  SysUtils,

  Forms,
  
  ExtCtrls,
  
  vg_Scene,
  vg_ani,
  vg_listbox,

  vgEffect,
  vgObjectList,
  vgVisual
  ;

{ TvgObject ==================================================================}

constructor TvgObject.Create(AOwner: TComponent);
begin
  inherited;
  AddResource(Self);
  FIndex := -1;
  FStored := true;
  //FIsVisual := Self is TvgVisualObject;
  if {F}IsVisual then
    FVisual := TvgVisualObject(Self)
  else
    FVisual := nil;
end;

type
  TvgHackVisual = class(TvgVisual)
  end;//TvgHackVisual

  TvgHackBrushResource = class(TvgBrushResource)
  end;//TvgHackBrushResource

  TvgHackPathData = class(TvgPathData)
  end;//TvgHackPathData

  TvgHackBitmap = class(TvgBitmap)
  end;//TvgHackBitmap

  THackComponent = class(TComponent)
  end;//THackComponent

procedure TvgObject.Cleanup;
var
  i: integer;
begin
 try
  if FScene <> nil then
  begin
    FScene.Notification(Self, opRemove);
  end;
  { NotifList }
  if (FNotifyList <> nil) then
  begin
   for i := FNotifyList.Count - 1 downto 0 do
   begin
    if (TObject(FNotifyList[i]) is TvgVisual) and
       (TvgVisual(FNotifyList[i]).VisualObject = Self) then
      TvgHackVisual(TvgVisual(FNotifyList[i])).FVisualObject := nil;
    if (TObject(FNotifyList[i]) is TvgBrushResource) and
       (TvgBrushResource(FNotifyList[i]).Resource = Self) then
      TvgHackBrushResource(FNotifyList[i]).FResource := nil;
    if (TObject(FNotifyList[i]) is TvgPathData) and
       (TvgPathData(FNotifyList[i]).Resource = Self) then
      TvgHackPathData(TvgPathData(FNotifyList[i])).FResource := nil;
    if (TObject(FNotifyList[i]) is TvgBitmap) and
       (TvgBitmap(FNotifyList[i]).Resource = Self) then
      TvgHackBitmap(TvgBitmap(FNotifyList[i])).FResource := nil;
    if (TObject(FNotifyList[i]) is TComponent) then
      THackComponent(FNotifyList[i]).Notification(Self, opRemove);
   end;//for i
   FreeAndNil(FNotifyList);
  end;//FNotifyList <> nil
  { Remove from ResorcesList }
 finally
  RemoveResource(Self);
 end;//try..finally 
(*  if (ResourceList <> nil) then
  begin
   i := ResourceList.IndexOf(Self);
   if i >= 0 then
     ResourceList[i] := nil;
  end;//ResourceList <> nil*)
  { }
  if FParent <> nil then
   FParent.RemoveObject(Self)
  else
  if FScene <> nil then
   FScene.RemoveObject(Self);
  FScene := nil;
  DeleteChildren;
  inherited;
end;

{$IfDef DesignTimeLibrary}
procedure TvgObject.Release(Delay: single = 0.1);
var
  T: TTimer;
begin
  T := TTimer.Create(Application);
  T.OnTimer := DoReleaseTimer;
  T.Interval := round(Delay * 1000);
  T.Enabled := true;
end;

procedure TvgObject.DoReleaseTimer(Sender: TObject);
var
 l_C : TvgObject;
begin
 l_C := Self;
 FreeAndNil(l_C);
 TTimer(Sender).Enabled := false;
end;
{$EndIf DesignTimeLibrary}

{$IfDef vgDesign}
function TvgObject.ItemClass: string;
begin
  Result := '';
end;
{$EndIf vgDesign}

procedure TvgObject.AddFreeNotify(const AObject: TObject);
begin
  if FNotifyList = nil then
    FNotifyList := TvgAnyObjectList.Create;
  FNotifyList.Add(AObject);
end;

procedure TvgObject.RemoveFreeNotify(const AObject: TObject);
begin
  if FNotifyList <> nil then
    FNotifyList.Remove(AObject);
end;

procedure TvgObject.ReaderSetName(Reader: TReader; Component: TComponent;
  var Name: string);
begin
  Name := '';
end;

procedure TvgObject.ReaderError(Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := true;
end;

procedure TvgObject.LoadFromStream(const AStream: TStream);
var
  BinStream: TStream;
begin
  { store }
  BinStream := TMemoryStream.Create;
  try
    ObjectTextToBinary(AStream, BinStream);
    BinStream.Position := 0;
    LoadFromBinStream(BinStream);
  finally
    FreeAndNil(BinStream);
  end;
end;

procedure TvgObject.SaveToStream(const Stream: TStream);
var
  BinStream: TStream;
begin
  { store }
  BinStream := TMemoryStream.Create;
  try
    BinStream.WriteComponent(Self);
    BinStream.Position := 0;
    ObjectBinaryToText(BinStream, Stream);
  finally
    FreeAndNil(BinStream);
  end;
end;

procedure TvgObject.LoadFromBinStream(const AStream: TStream);
var
  R: TReader;
begin
  R := TReader.Create(AStream, 1024);
  R.OnError := ReaderError;
  try
    R.ReadRootComponent(Self);
  finally
    FreeAndNil(R);
  end;
end;

procedure TvgObject.SaveToBinStream(const AStream: TStream);
begin
  AStream.WriteComponent(Self);
end;

procedure TvgObject.IntLoadFromBinStream(const AStream: TStream);
var
  R: TReader;
begin
  R := TReader.Create(AStream, 1024);
  R.OnSetName := ReaderSetName;
  R.OnError := ReaderError;
  try
    if not (csDesigning in ComponentState) then
    begin
      // need to force set unique name
      SetDesigning(true, false);
      R.ReadRootComponent(Self);
      SetDesigning(false, false);
    end
    else
      R.ReadRootComponent(Self);
  finally
    FreeAndNil(R);
  end;
end;

procedure TvgObject.IntSaveToBinStream(const AStream: TStream);
var
  SaveName: string;
begin
  { store }
  SaveName := Name;
  Name := '';
  AStream.WriteComponent(Self);
  Name := SaveName;
end;

function TvgObject.Clone(const AOwner: TComponent): TvgObject;
var
  S: TStream;
  SaveName: string;
begin
  S := TMemoryStream.Create;
  try
    { store }
    SaveName := Name;
    Name := '';
    S.WriteComponent(Self);
    Name := SaveName;
    S.Position := 0;
    { load }
    Result := TvgObjectClass(ClassType).Create(AOwner);
    if Result <> nil then
      Result.IntLoadFromBinStream(S);
  finally
    FreeAndNil(S);
  end;
end;

type
  TvgHackVisualObject = class(TvgVisualObject)
  end;//TvgHackVisualObject

procedure TvgObject.CloneChildFromStream(AStream: TStream);
var
  i: integer;
  Obj: TvgObject;
begin
  Obj := CreateObjectFromStream(Self, AStream);
  if (Obj <> nil) and (Obj.FChildren <> nil) and (Obj.FChildren.Count > 0) then
  begin
    { delete self childs }
    DeleteChildren;
    { copy parent }
    for i := 0 to Obj.FChildren.Count - 1 do
    begin
      if TvgObject(Obj.FChildren[0]).isVisual then
        TvgVisualObject(Obj.FChildren[0]).Locked := true;
      TvgObject(Obj.FChildren[0]).Stored := false;
      TvgObject(Obj.FChildren[0]).Parent := Self;
    end;
    { realign to new size }
    if Obj.isVisual and (isVisual) then
    begin
      TvgHackVisualObject(TvgVisualObject(Self)).FLastWidth := TvgVisualObject(Obj).Width;
      TvgHackVisualObject(TvgVisualObject(Self)).FLastHeight := TvgVisualObject(Obj).Height;
      TvgVisualObject(Self).Realign;
    end;
//    FreeAndNil(Obj);
  end;
end;

function TvgObject.GetScene: IvgScene;
begin
  if FScene <> nil then
    Result := FScene
  else
    if FParent <> nil then
    begin
      FScene := FParent.FScene;
      Result := FScene;
    end
    else
      Result := nil;
end;

function TvgObject.HasClipParent: TvgObject{TvgVisualObject};
var
  i: integer;
begin
  Result := nil;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if (TvgObject(FChildren[i]).IsVisual) and (TvgVisualObject(FChildren[i]).ClipParent) then
      begin
        Result := TvgVisualObject(FChildren[i]);
        Exit;
      end;
end;

{ Property animation }

procedure TvgObject.AnimateColor(const APropertyName, NewValue: string;
  Duration: single = 0.2; AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
var
  A: TvgColorAnimation;
begin
  A := TvgColorAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.OnFinish := DoAniFinished;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := true;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TvgObject.AnimateFloat(const APropertyName: string;
  const NewValue: single; Duration: single = 0.2;
  AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
var
  A: TvgFloatAnimation;
begin
  A := TvgFloatAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.OnFinish := DoAniFinished;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := true;
  A.StopValue := NewValue;
  A.Start;
end;

procedure TvgObject.AnimateFloatDelay(const APropertyName: string; const NewValue: single; Duration: single = 0.2;
  Delay: single = 0.0; AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
var
  A: TvgFloatAnimation;
begin
  A := TvgFloatAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.Delay := Delay;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := true;
  A.StopValue := NewValue;
  A.Start;
end;

type
  TvgHackAnimation = class(TvgAnimation)
  end;//TvgHackAnimation

procedure TvgObject.AnimateFloatWait(const APropertyName: string;
  const NewValue: single; Duration: single = 0.2;
  AType: TvgAnimationType = vgAnimationIn; AInterpolation: TvgInterpolationType = vgInterpolationLinear);
var
  A: TvgFloatAnimation;
begin
  A := TvgFloatAnimation.Create(Self);
  A.Parent := Self;
  A.AnimationType := AType;
  A.Interpolation := AInterpolation;
  A.Duration := Duration;
  A.PropertyName := APropertyName;
  A.StartFromCurrent := true;
  A.StopValue := NewValue;
  A.Start;
  while TvgHackAnimation(A).FRunning do
  begin
    Application.ProcessMessages;
    Sleep(0);
  end;
  FreeAndNil(A);
end;

procedure TvgObject.DoAniFinished(Sender: TObject);
begin
  FreeAndNil(TvgAnimation(Sender));
end;

function TvgObject.DoTab(const aScene   : IvgScene;
               aControl : TControl;
               aShift   : Boolean): Boolean;
var
 l_Index : Integer;
begin
 Result := false;
 if (FChildren <> nil) then
  for l_Index := 0 to Pred(FChildren.Count) do
   if TvgObject(FChildren[l_Index]).DoTab(aScene, aControl, aShift) then
   begin
    Result := true;
    Exit;
   end;//FChildren[l_Index].DoTab(aScene, aControl, aShift)
end;

function TvgObject.IsAcceptableControlForTabNavigation(aControl: TWinControl): Boolean;
var
 l_Index : Integer;
begin
 Result := true;
 if (FChildren <> nil) then
  for l_Index := 0 to Pred(FChildren.Count) do
   if not TvgObject(FChildren[l_Index]).IsAcceptableControlForTabNavigation(aControl) then
   begin
    Result := false;
    Exit;
   end;//FChildren[l_Index].DoTab(aScene, aControl, aShift)
end;

{ Animations }

procedure TvgObject.StartAnimation(const AName: WideString);
var
  i: integer;
  E: TvgAnimation;
begin
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if TvgObject(FChildren[i]) is TvgAnimation then
        if CompareText(TvgAnimation(FChildren[i]).Name, AName) = 0 then
        begin
          E := TvgAnimation(FChildren[i]);
          E.Start;
        end;
    end;
end;

procedure TvgObject.StopAnimation(const AName: WideString);
var
  i: integer;
  E: TvgAnimation;
begin
  if FChildren <> nil then
    for i := FChildren.Count - 1 downto 0 do
      if TvgObject(FChildren[i]) is TvgAnimation then
        if CompareText(TvgAnimation(FChildren[i]).Name, AName) = 0 then
        begin
          E := TvgAnimation(FChildren[i]);
          E.Stop;
        end;
end;

procedure TvgObject.StartTriggerAnimation(AInstance: TvgObject; ATrigger: string);
var
  i: integer;
begin
  StopTriggerAnimation(AInstance);
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if TvgObject(FChildren[i]) is TvgAnimation then
        TvgAnimation(FChildren[i]).StartTrigger(AInstance, ATrigger);
      { locked objects }
      if TvgObject(FChildren[i]).isVisual and TvgVisualObject(FChildren[i]).Locked and not TvgVisualObject(FChildren[i]).HitTest then
      begin
        TvgObject(FChildren[i]).StartTriggerAnimation(AInstance, ATrigger);
      end;
    end;
end;

procedure TvgObject.StartTriggerAnimationWait(AInstance: TvgObject; ATrigger: string);
var
  i: integer;
begin
  StopTriggerAnimation(AInstance);
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if TvgObject(FChildren[i]) is TvgAnimation then
      begin
        TvgAnimation(FChildren[i]).StartTrigger(AInstance, ATrigger);
        while TvgAnimation(FChildren[i]).Running do
        begin
          Application.ProcessMessages;
          Sleep(0);
        end;
      end;
      { locked objects }
      if TvgObject(FChildren[i]).isVisual and TvgVisualObject(FChildren[i]).Locked and not TvgVisualObject(FChildren[i]).HitTest then
      begin
        TvgObject(FChildren[i]).StartTriggerAnimationWait(AInstance, ATrigger);
      end;
    end;
end;

procedure TvgObject.StopTriggerAnimation(AInstance: TvgObject);
var
  i: integer;
  E: TvgAnimation;
begin
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if TvgObject(FChildren[i]) is TvgAnimation then
        if TvgAnimation(FChildren[i]).Trigger <> '' then
        begin
          E := TvgAnimation(FChildren[i]);
          E.Stop;
        end;
      { locked objects }
      if TvgObject(FChildren[i]).isVisual and TvgVisualObject(FChildren[i]).Locked and not TvgVisualObject(FChildren[i]).HitTest then
      begin
        TvgObject(FChildren[i]).StopTriggerAnimation(AInstance);
      end;
    end;
end;

procedure TvgObject.ApplyTriggerEffect(AInstance: TvgObject; ATrigger: string);
var
  i: integer;
begin
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if TvgObject(FChildren[i]) is TvgEffect then
        TvgEffect(FChildren[i]).ApplyTrigger(AInstance, ATrigger);
      { locked objects }
      if TvgObject(FChildren[i]).isVisual and TvgVisualObject(FChildren[i]).Locked and not TvgVisualObject(FChildren[i]).HitTest then
      begin
        TvgObject(FChildren[i]).ApplyTriggerEffect(AInstance, ATrigger);
      end;
    end;
end;

{ VCL }

function TvgObject.pm_GetIsVisual : Boolean;
begin
 Result := false;
end;

procedure TvgObject.SetNewScene(AScene: IvgScene);
var
  i: integer;
begin
  FScene := AScene;
  if (FChildren <> nil) and (FChildren.Count > 0) then
    for i := 0 to FChildren.Count - 1 do
      TvgObject(FChildren[i]).SetNewScene(FScene);
end;

{$IfNDef Nemesis}
procedure TvgObject.ChangeParent;
begin
end;
{$EndIf  Nemesis}

procedure TvgObject.SetParent(const Value: TvgObject);
begin
 if Parent <> Value then
 begin
  if FParent <> nil then
   FParent.RemoveObject(Self)
  else
  if FScene <> nil then
   FScene.RemoveObject(Self);
  if Value <> nil then
    Value.AddObject(Self)
  else
    FParent := Value;
 end;//Parent <> Value
end;

function TvgObject.GetChild(Index: integer): TvgObject;
begin
  if (FChildren <> nil) and (Index < FChildren.Count) then
    Result := TvgObject(FChildren[Index])
  else
    Result := nil;
end;

function TvgObject.GetChildrenCount: integer;
begin
  if (FChildren <> nil) then
    Result := FChildren.Count
  else
    Result := 0;
end;

procedure TvgObject.FreeChild(i : Integer);
var
 l_C : TvgObject;
begin
 l_C := TvgObject(FChildren[i]);
 FreeAndNil(l_C);
 //FChildren[i] := l_C;
end;

procedure TvgObject.SetParentComponent(Value: TComponent);
var
  SI: IvgScene;
begin
  inherited;
  if FParent <> nil then
    FParent.RemoveObject(Self);

  if (Value <> nil) and (Value is TvgObject) then
  begin
    TvgObject(Value).AddObject(Self);
  end
  else
    if (THackComponent(Value).QueryInterface(IvgScene, SI) = 0) and (Assigned(SI)) then
    begin
      SI.AddObject(Self);
    end
end;

procedure TvgObject.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  i, j: Integer;
begin
  inherited;
  if (Self is TvgContent) then Exit;

  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if (TvgObject(FChildren[i]) is TvgContent) and (TvgContent(FChildren[i]).FChildren <> nil) then
      begin
        for j := 0 to TvgContent(FChildren[i]).FChildren.Count - 1 do
          if TvgObject(TvgContent(FChildren[i]).FChildren[j]).Stored then
            Proc(TComponent(TvgContent(FChildren[i]).FChildren[j]));
      end;
      if TvgObject(FChildren[i]).Stored then
      begin
        Proc(TComponent(FChildren[i]));
      end;
    end;
end;

function TvgObject.GetParentComponent: TComponent;
begin
  if (FParent <> nil) and
     (FParent is TvgPopup) and
     (TvgPopup(FParent).Parent <> nil) and
     (TvgPopup(FParent).Parent is TvgPopupItem) then
    Result := TvgContent(FParent).Parent
  else
  if (FParent <> nil) and (FParent is TvgContent) then
    Result := TvgContent(FParent).Parent
  else
  if (FParent <> nil) and (FParent is TvgComboListBox)  then
    Result := TvgComboListBox(FParent).Parent
  else
    Result := FParent;
  if (Result = nil) and (FScene <> nil) then
    Result := FScene.GetComponent;
end;

function TvgObject.HasParent: Boolean;
begin
  Result := true;
end;

{ binding }

function TvgObject.GetData: Variant;
begin
  Result := Name;
end;

procedure TvgObject.SetData(const Value: Variant);
begin
end;

function TvgObject.GetBinding(Index: string): Variant;
var
  Obj: TvgObject;
begin
  Obj := FindBinding(Index);
  if Obj <> nil then
    Result := Obj.Data
  else
    Result := '';
end;

procedure TvgObject.SetBinding(Index: string; const Value: Variant);
var
  Obj: TvgObject;
begin
  Obj := FindBinding(Index);
  if Obj <> nil then
  begin
    try
      Obj.Data := Value;
    except
    end;
  end;
end;

function TvgObject.FindBinding(const ABinding: string): TvgObject;
var
  i: integer;
begin
  Result := nil;
  if CompareText(BindingName, ABinding) = 0 then
  begin
    Result := Self;
    Exit;
  end;
  if (FChildren <> nil) and (FChildren.Count > 0) then
  begin
    for i := 0 to FChildren.Count - 1 do
    begin
      if CompareText(TvgObject(FChildren[i]).BindingName, ABinding) = 0 then
      begin
        Result := TvgObject(FChildren[i]);
        Exit;
      end;
      Result := TvgObject(FChildren[i]).FindBinding(ABinding);
      if Result <> nil then Exit;
    end;
  end;
end;

procedure TvgObject.SetBindingName(const Value: string);
begin
 if FBindingName <> Value then
  FBindingName := Value;
end;

function TvgObject.FindResource(const AResource: string): TvgObject;
var
  i: integer;
begin
  Result := nil;
  if AResource = '' then Exit;
  if (FChildren <> nil) and (FChildren.Count > 0) then
  begin
    for i := 0 to FChildren.Count - 1 do
    begin
      if CompareText(TvgObject(FChildren[i]).ResourceName, AResource) = 0 then
      begin
        Result := TvgObject(FChildren[i]);
        Exit;
      end;//CompareText(TvgObject(FChildren[i]).ResourceName, AResource) = 0
      if TvgObject(FChildren[i]) is TvgControl then
       Continue;
      Result := TvgObject(FChildren[i]).FindResource(AResource);
      if Result <> nil then Exit;
    end;//for i
  end;//(FChildren <> nil) and (FChildren.Count > 0)
end;

procedure TvgObject.SetResourceName(const Value: string);
begin
 if FResourceName <> Value then
  FResourceName := Value;
end;

procedure TvgObject.SetStored(const Value: boolean);
var
  i: integer;
begin
  if FStored <> Value then
  begin
    FStored := Value;
    if (FChildren <> nil) and (FChildren.Count > 0) then
     for i := 0 to FChildren.Count - 1 do
      TvgObject(FChildren[i]).Stored := Value;
  end;//FStored <> Value
end;

procedure TvgObject.UpdateResource;
var
  i: integer;
begin
  if csLoading in ComponentState then Exit;  
  if csDestroying in ComponentState then Exit;
  if (FChildren <> nil) and (FChildren.Count > 0) then
   for i := 0 to FChildren.Count - 1 do
    TvgObject(FChildren[i]).UpdateResource;
end;

procedure TvgObject.DeleteChildren;
var
  i: integer;
  Child: TvgObject;
begin
  if Assigned(FChildren) then
  begin
    for i := FChildren.Count - 1 downto 0 do
    begin
      Child := TvgObject(FChildren[i]);
      Child.FParent := nil;
      Child.SetNewScene(nil);
      FreeAndNil(Child);
      FChildren[i] := nil;
    end;//for i
    FreeAndNil(FChildren);
  end;//Assigned(FChildren)
end;

procedure TvgObject.AddObjectsToList(AList: TvgCustomObjectList);
var
  i: integer;
begin
  AList.Add(Self);
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      TvgObject(FChildren[i]).AddObjectsToList(AList);
end;

procedure TvgObject.AddControlsToList(AList: TvgCustomObjectList);
var
  i: integer;
begin
  if (Self is TvgControl) then
    AList.Add(Self);
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      TvgObject(FChildren[i]).AddControlsToList(AList);
end;

procedure TvgObject.AddObject(AObject: TvgObject);
begin
  if AObject = nil then Exit;
  if AObject.Parent <> nil then
    AObject.Parent := nil;
  if FChildren = nil then
  begin
    FChildren := TvgSortableObjectList.Create;
    FChildren.Capacity := 10;
  end;//FChildren = nil
  if FChildren.IndexOf(AObject) >= 0 then Exit;
  FChildren.Add(AObject);
  AObject.FParent := Self;
  AObject.SetNewScene(FScene);
  {$IfNDef Nemesis}
  AObject.ChangeParent;
  {$EndIf  Nemesis}
  if AObject.IsVisual and not (csLoading in ComponentState) then
  begin
  end;
  if IsVisual and AObject.IsVisual and (TvgVisualObject(AObject.Visual).Align <> vaNone) then
    TvgHackVisualObject(TvgVisualObject(Self.Visual)).FNeedAlign := true;
  if IsVisual and (AObject is TvgEffect) and (TvgEffect(AObject).Enabled) then
  begin
    TvgHackVisualObject(TvgVisualObject(Visual)).FHasEffect := true;
    TvgVisualObject(Visual).UpdateEffects;
  end;//IsVisual and (AObject is TvgEffect) and (TvgEffect(AObject).Enabled) 
  if IsVisual and AObject.IsVisual then
  begin
    if TvgHackVisualObject(TvgVisualObject(Visual)).TempCanvas <> nil then
      TvgHackVisualObject(TvgVisualObject(AObject.Visual)).TempCanvas :=
       TvgHackVisualObject(TvgVisualObject(Visual)).TempCanvas;
    if Self.IsVisual then
      TvgHackVisualObject(TvgVisualObject(AObject)).FUpdating :=
       TvgHackVisualObject(TvgVisualObject(Self)).FUpdating;
    TvgHackVisualObject(TvgVisualObject(AObject.Visual)).NeedRecalcOpacity;
    TvgHackVisualObject(TvgVisualObject(AObject.Visual)).NeedRecalcAbsolute;
    TvgHackVisualObject(TvgVisualObject(AObject.Visual)).NeedRecalcUpdateRect;
    if TvgHackVisualObject(TvgVisualObject(Visual)).FHasEffect then
    begin
      TvgVisualObject(Visual).UpdateEffects;
      TvgVisualObject(Visual).Repaint;
    end;
    if AObject.isVisual and (TvgVisualObject(AObject).Align <> vaNone) then
      TvgVisualObject(Self).Realign
    else
      TvgVisualObject(Self).Repaint;
    if TvgHackVisualObject(TvgVisualObject(Self)).FTabList = nil then
      TvgHackVisualObject(TvgVisualObject(Self)).FTabList := TvgObjectList.Create;
    TvgHackVisualObject(TvgVisualObject(Self)).FTabList.Add(AObject);
  end;//IsVisual and AObject.IsVisual
end;

procedure TvgObject.Sort(Compare: TvgObjectSortCompare);
begin
  if FChildren <> nil then
    FChildren.Sort({TListSortCompare(}Compare{)});
end;

function TvgObject.GetIndex: integer;
begin
  if (FIndex < 0) and (FParent <> nil) then
    FIndex := FParent.FChildren.IndexOf(Self);
  Result := FIndex;
end;

procedure TvgObject.SetIndex(Idx: integer);
var
  i: integer;
begin
  if (Parent <> nil) and (Parent.FChildren.IndexOf(Self) >= 0) then
  begin
    Parent.FChildren.Remove(Self);
    Parent.FChildren.Insert(Idx, Self);
    // recalc Index
    for i := 0 to Parent.FChildren.Count - 1 do
      TvgObject(Parent.FChildren[i]).FIndex := -1;
    if IsVisual and not (csLoading in ComponentState) and (Parent.IsVisual) then
      TvgVisualObject(Parent.Visual).Realign;
  end;//(Parent <> nil) and (Parent.FChildren.IndexOf(Self) >= 0)
end;

procedure TvgObject.Exchange(AObject1, AObject2: TvgObject);
var
  Idx: integer;
begin
 if (FChildren <> nil) then
  if (AObject1.Parent = Self) and (AObject2.Parent = Self) then
  begin
    FChildren.Exchange(AObject1.Index, AObject2.Index);
    Idx := AObject1.FIndex;
    AObject1.FIndex := AObject2.Index;
    AObject2.FIndex := Idx;
    if IsVisual and not (csLoading in ComponentState) and (Parent.IsVisual) then
      TvgVisualObject(Parent.Visual).Realign;
  end;//(AObject1.Parent = Self) and (AObject2.Parent = Self)
end;

procedure TvgObject.RemoveObject(AObject: TvgObject);
var
  i: integer;
begin
  if (FChildren <> nil) and (FChildren.IndexOf(AObject) < 0) then Exit;
  if IsVisual and
     AObject.IsVisual and
     (TvgHackVisualObject(TvgVisualObject(Self)).FTabList <> nil) then
  begin
    TvgHackVisualObject(TvgVisualObject(AObject)).FUpdating := 0;
    TvgHackVisualObject(TvgVisualObject(Self)).FTabList.Remove(AObject);
{    if AObject.isVisual and (TvgVisualObject(AObject).Align <> vaNone) then
      TvgVisualObject(Self).Realign;}
  end;
  if IsVisual and AObject.IsVisual then
    TvgVisualObject(AObject.Visual).Repaint;
  AObject.FParent := nil;
  AObject.SetNewScene(nil);
  // recalc Index
  if AObject.FIndex >= 0 then
    for i := AObject.FIndex to FChildren.Count - 1 do
      TvgObject(FChildren[i]).FIndex := -1;

  if FChildren <> nil then
    FChildren.Remove(AObject);
  if IsVisual then
    TvgHackVisualObject(TvgVisualObject(Visual)).RecalcHasEffect;
  if IsVisual and AObject.IsVisual then
  begin
    TvgHackVisualObject(TvgVisualObject(Self)).RecalcNeedAlign;
    if TvgHackVisualObject(TvgVisualObject(AObject.Visual)).TempCanvas <> nil then
      TvgHackVisualObject(TvgVisualObject(AObject.Visual)).TempCanvas := nil;
  end;//IsVisual and AObject.IsVisual
end;

procedure TvgObject.BringToFront;
var
  i: integer;
begin
  if (Parent <> nil) and (Parent.FChildren <> nil) then
  begin
    Parent.FChildren.Remove(Self);
    Parent.FChildren.Add(Self);
    // recalc Index
    for i := 0 to Parent.FChildren.Count - 1 do
      TvgObject(Parent.FChildren[i]).FIndex := -1;
    if isVisual then
      TvgVisualObject(Self).Repaint;
  end;//(Parent <> nil) and (Parent.FChildren <> nil)
end;

procedure TvgObject.SendToBack;
var
  i: integer;
begin
  if (Parent <> nil) and (Parent.FChildren <> nil) then
  begin
    Parent.FChildren.Remove(Self);
    Parent.FChildren.Insert(0, Self);
    // recalc Index
    for i := 0 to Parent.FChildren.Count - 1 do
      TvgObject(Parent.FChildren[i]).FIndex := -1;
    if Parent.IsVisual then
      TvgVisualObject(Parent).Realign;
  end;//(Parent <> nil) and (Parent.FChildren <> nil)
end;

{$EndIf  NoVGScene}

end.