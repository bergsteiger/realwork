{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Viewport3D;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, System.Generics.Collections, System.Types, System.UITypes, System.Messaging, FMX.Types, FMX.Types3D,
  FMX.Controls3D, FMX.Objects3D, FMX.Controls, FMX.Graphics;

type

{ TViewport3D }

  TViewport3D = class(TControl, IViewport3D)
  private
    FBitmap: TBitmap;
    FTexture: TTexture;
    FContext: TContext3D;
    FCamera: TCamera;
    FDesignCamera: TCamera;
    FDesignCameraZ: TDummy;
    FDesignCameraX: TDummy;
    FFill: TAlphaColor;
    FMultisample: TMultisample;
    FUsingDesignCamera: Boolean;
    FDrawing: Boolean;
    FRenderingList: TList<TControl3D>;
    FScaleChangedId: Integer;
    FLights: TList<TLight>;
    procedure SetFill(const Value: TAlphaColor);
    procedure SetMultisample(const Value: TMultisample);
    function GetFill: TAlphaColor;
    procedure SetUsingDesignCamera(const Value: Boolean);
    procedure RebuildRenderingList;
    procedure ScaleChangedHandler(const Sender: TObject; const Msg : TMessage);
    function GetCurrentCamera: TCamera;
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function FindTarget(P: TPointF; const Data: TDragObject): IControl; override;
    function ObjectAtPoint(P: TPointF): IControl; override;
    { children }
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    { IViewport3D }
    function GetObject: TFmxObject;
    function GetContext: TContext3D;
    function GetCamera: TCamera;
    function GetLightCount: Integer;
    function GetLight(Index: Integer): TLight;
    procedure AddLight(const ALight: TLight);
    procedure RemoveLight(const ALight: TLight);
    function GetUsingDesignCamera: Boolean;
    function GetViewportScale: Single;
    procedure SetCamera(const ACamera: TCamera);
    procedure NeedRender;
    { Events }
    procedure DoScaleChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Context: TContext3D read FContext write FContext;
  published
    property Align;
    property Anchors;
    property Camera: TCamera read FCamera write SetCamera;
    property ClipChildren;
    property ClipParent;
    property Color: TAlphaColor read GetFill write SetFill default TAlphaColors.White;
    property Cursor;
    property DragMode;
    property EnableDragHighlight;
    property Enabled;
    property Height;
    property HitTest;
    property Locked;
    property Padding;
    property Multisample: TMultisample read FMultisample write SetMultisample default TMultisample.FourSamples;
    property Margins;
    property Opacity;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property Size;
    property UsingDesignCamera: Boolean read FUsingDesignCamera write SetUsingDesignCamera default True;
    property Visible;
    property Width;
    {events}
    property OnDragDrop;
    property OnDragEnd;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnKeyDown;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnCanFocus;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

implementation

uses
  System.SysUtils, System.Math.Vectors, FMX.Forms;

type
  TOpenControl3D = class(TControl3D);

{ TViewport3D }

procedure TViewport3D.AddLight(const ALight: TLight);
begin
  FLights.Add(ALight);
end;

constructor TViewport3D.Create(AOwner: TComponent);
begin
  inherited;
  AutoCapture := True;
  ShowHint := True;
  Width := 100;
  Height := 100;
  FMultisample := TMultisample.FourSamples;
  FLights := TList<TLight>.Create;

  FUsingDesignCamera := True;
  FFill := TAlphaColors.White;

  FDesignCameraZ := TDummy.Create(Self);
  FDesignCameraZ.Tag := $FFFE;
  FDesignCameraZ.Locked := True;
  FDesignCameraZ.Stored := False;
  AddObject(FDesignCameraZ);

  FDesignCameraX := TDummy.Create(Self);
  FDesignCameraX.Tag := $FFFE;
  FDesignCameraX.Parent := FDesignCameraZ;
  FDesignCameraX.Locked := True;
  FDesignCameraX.Stored := False;
  FDesignCameraX.RotationAngle.X := -20;

  FDesignCamera := TCamera.Create(Self);
  FDesignCamera.Tag := $FFFE;
  FDesignCamera.Parent := FDesignCameraX;
  FDesignCamera.Locked := True;
  FDesignCamera.Stored := False;
  FDesignCamera.Position.Point := Point3D(0, 0, -20);

  FScaleChangedId := TMessageManager.DefaultManager.SubscribeToMessage(TScaleChangedMessage, ScaleChangedHandler);
end;

destructor TViewport3D.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TScaleChangedMessage, FScaleChangedId);
                                                                                                 
  DeleteChildren;
  FreeAndNil(FContext);
  FreeAndNil(FTexture);
  FreeAndNil(FBitmap);
  FreeAndNil(FLights);
  FreeAndNil(FRenderingList);
  inherited;
end;

procedure TViewport3D.RebuildRenderingList;
var
  I: Integer;
  CompareFunc: TRenderingCompare;
begin
  if (Children <> nil) and (Children.Count > 0) and (FUpdating = 0) then
  begin
    if FRenderingList = nil then
      FRenderingList := TList<TControl3D>.Create;
    FRenderingList.Clear;

    for I := 0 to Children.Count - 1 do
      if (Children[i] is TControl3D) then
        FRenderingList.Add(Children[I] as TControl3D);

    CompareFunc := TRenderingCompare.Create;
    try
      FRenderingList.Sort(CompareFunc);
    finally
      CompareFunc.Free;
    end;
  end;
end;

procedure TViewport3D.RemoveLight(const ALight: TLight);
begin
  FLights.Remove(ALight);
end;

procedure TViewport3D.Paint;
var
  R: TRectF;
  I: Integer;
begin
  if (csDesigning in ComponentState) then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
  if FDrawing then Exit;
  FDrawing := True;
  try
    if Context <> nil then
    begin
      Canvas.Flush;
      if Context.BeginScene then
      try
        Context.SetContextState(TContextState.csScissorOff);
        Context.Clear([TClearTarget.Color, TClearTarget.Depth], FFill, 1.0, 0);
        Context.SetCameraMatrix(GetCurrentCamera.CameraMatrix);
        Context.SetCameraAngleOfView(GetCurrentCamera.AngleOfView);
        Context.Lights.Clear;
        for I := 0 to FLights.Count - 1 do
          Context.Lights.Add(FLights[I].LightDescription);
        if (FRenderingList <> nil) and (FRenderingList.Count > 0) then
        begin
          for I := 0 to FRenderingList.Count - 1 do
            if FRenderingList[i].Visible or (not FRenderingList[i].Visible and
              (csDesigning in ComponentState) and not FRenderingList[i].Locked) then
              TOpenControl3D(FRenderingList[i]).RenderInternal;
        end;
      finally
        Context.EndScene;
      end;
      Context.CopyToBitmap(FBitmap, FBitmap.Bounds);
    end;
  finally
    FDrawing := False;
  end;
  { draw }
  inherited Canvas.DrawBitmap(FBitmap, FBitmap.BoundsF, LocalRect, AbsoluteOpacity, True);
end;

procedure TViewport3D.DoAddObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl3D then
  begin
    TOpenControl3D(AObject).SetNewViewport(Self);
    RebuildRenderingList;
  end;
  if (csDesigning in ComponentState) and (AObject is TCamera) and (AObject.Tag <> $FFFE) then
    Camera := TCamera(AObject);
end;

procedure TViewport3D.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl3D then
  begin
    TOpenControl3D(AObject).SetNewViewport(nil);
    RebuildRenderingList;
    Repaint;
  end;
end;

procedure TViewport3D.DoScaleChanged;
begin
  Resize;
end;

procedure TViewport3D.Resize;
begin
  inherited;
  FreeAndNil(FBitmap);
  FreeAndNil(FTexture);
  FreeAndNil(FContext);
  FTexture := TTexture.Create;
  FTexture.Style := [TTextureStyle.RenderTarget];
  ITextureAccess(FTexture).TextureScale := GetViewportScale;
  FTexture.SetSize(Round(Width * GetViewportScale), Round(Height * GetViewportScale));
  FContext := TContextManager.CreateFromTexture(FTexture, FMultisample, True);
  FBitmap := TBitmap.Create(FContext.Width, FContext.Height);
end;

procedure TViewport3D.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCamera) then
    FCamera := nil;
end;

function TViewport3D.ObjectAtPoint(P: TPointF): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  NewObj := inherited ObjectAtPoint(P);
  if NewObj = nil then
    Exit;
  NewObj := nil;

  // first screen projection
  GlobalDistance := $FFFF;
  GlobalProjection := TProjection.Screen;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.GetVisible and not(csDesigning in ComponentState) then
      Continue;
    NewObj := NewObj.ObjectAtPoint(P);
    if NewObj <> nil then
      Result := NewObj;
  end;
  if Result = nil then
  begin
    // second camera projection
    GlobalDistance := $FFFF;
    GlobalProjection := TProjection.Camera;
    for i := ChildrenCount - 1 downto 0 do
    begin
      Obj := Children[i];
      if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
        Continue;
      if not NewObj.GetVisible and not(csDesigning in ComponentState) then
        Continue;
      NewObj := NewObj.ObjectAtPoint(P);
      if NewObj <> nil then
        Result := NewObj;
    end;
  end;
  if Result = nil then
    Result := inherited ObjectAtPoint(P);
end;

function TViewport3D.FindTarget(P: TPointF; const Data: TDragObject): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  // first screen projection
  GlobalDistance := $FFFF;
  GlobalProjection := TProjection.Screen;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.Visible then
      Continue;
    NewObj := NewObj.FindTarget(P, Data);
    if NewObj <> nil then
      Result := NewObj;
  end;
  if Result = nil then
  begin
    // second camera projection
    GlobalDistance := $FFFF;
    GlobalProjection := TProjection.Camera;
    for i := ChildrenCount - 1 downto 0 do
    begin
      Obj := Children[i];
      if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
        Continue;
      if not NewObj.Visible then
        Continue;
      NewObj := NewObj.FindTarget(P, Data);
      if NewObj <> nil then
        Result := NewObj;
    end;
  end;
  if Result = nil then
    Result := inherited FindTarget(P, Data);
end;

function TViewport3D.GetFill: TAlphaColor;
begin
  Result := FFill;
end;

function TViewport3D.GetLight(Index: Integer): TLight;
begin
  Result := FLights[Index];
end;

function TViewport3D.GetLightCount: Integer;
begin
  Result := FLights.Count;
end;

procedure TViewport3D.SetFill(const Value: TAlphaColor);
begin
  if FFill <> Value then
  begin
    FFill := Value;
    Repaint;
  end;
end;

procedure TViewport3D.SetMultisample(const Value: TMultisample);
begin
  if FMultisample <> Value then
  begin
    FMultisample := Value;
    if Context <> nil then
      Context.SetMultisample(FMultisample);
  end;
end;

procedure TViewport3D.SetUsingDesignCamera(const Value: Boolean);
begin
  if FUsingDesignCamera <> Value then
  begin
    FUsingDesignCamera := Value;
    if FContext <> nil then
      NeedRender;
  end;
end;

function TViewport3D.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TViewport3D.GetCamera: TCamera;
begin
  Result := FCamera;
end;

function TViewport3D.GetContext: TContext3D;
begin
  Result := FContext;
end;

function TViewport3D.GetCurrentCamera: TCamera;
begin
  if (FCamera <> nil) and not (FUsingDesignCamera) and not (csDesigning in ComponentState) then
    Result := FCamera
  else
    Result := FDesignCamera;
end;

function TViewport3D.GetUsingDesignCamera: Boolean;
begin
  Result := FUsingDesignCamera;
end;

function TViewport3D.GetViewportScale: Single;
begin
  if Scene <> nil then
    Result := Scene.GetSceneScale
  else
    Result := 1.0;
end;

procedure TViewport3D.ScaleChangedHandler(const Sender: TObject; const Msg: TMessage);
begin
  DoScaleChanged;
end;

procedure TViewport3D.SetCamera(const ACamera: TCamera);
begin
  if FCamera <> ACamera then
  begin
    FCamera := ACamera;
    if (FContext <> nil) and not (FUsingDesignCamera) and not (csDesigning in ComponentState) then
      NeedRender;
  end;
end;

procedure TViewport3D.NeedRender;
begin
  Repaint;
  UpdateEffects;
end;

initialization
  RegisterFmxClasses([TViewport3D], []);
finalization
end.
