{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Forms3D;

interface

uses
  System.TypInfo, System.Math, System.Classes, System.SysUtils, System.Types,
  System.UITypes, FMX.Types, FMX.Types3D, System.Generics.Collections,
  FMX.ActnList, FMX.Messages, FMX.Controls3D, FMX.Objects3D, FMX.Forms;

{$SCOPEDENUMS ON}

type

  { TCustomForm3D }

  TCustomForm3D = class(TCommonCustomForm, IContextObject, IViewport3D)
  private
    FCamera: TCamera;
    FDesignCamera: TCamera;
    FDesignCameraZ: TDummy;
    FDesignCameraX: TDummy;
    FFill: TAlphaColor;
    FMultisample: TMultisample;
    FUsingDesignCamera: Boolean;
    FDrawing: Boolean;
    FOnRender: TRenderEvent;
    FEffectBitmap: TBitmap;
    FContext: TContext3D;
    FRenderingList: TList<TControl3D>;
    FLights: TList<TLight>;
    procedure SetFill(const Value: TAlphaColor);
    procedure SetMultisample(const Value: TMultisample);
    function GetFill: TAlphaColor;
    procedure RebuildRenderingList;
    procedure SetUsingDesignCamera(const Value: Boolean);
    procedure SkipTransparency(Reader: TReader);
    { IViewport3D }
    function GetObject: TFmxObject;
    function GetContext: TContext3D;
    function GetCamera: TCamera;
    function GetUsingDesignCamera: Boolean;
    function GetViewportScale: Single;
    function GetLightCount: Integer;
    function GetLight(Index: Integer): TLight;
    procedure SetCamera(const ACamera: TCamera);
    procedure AddLight(const ALight: TLight);
    procedure RemoveLight(const ALight: TLight);
    procedure NeedRender;
    function GetCurrentCamera: TCamera;
  protected
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
    { Context }
    procedure CreateContext; virtual;
    procedure DestroyContext; virtual;
    { Handle }
    procedure CreateHandle; override;
    procedure DestroyHandle; override;
    procedure ResizeHandle; override;
    procedure PaintRects(const UpdateRects: array of TRectF); override;
    { Preload }
    procedure AddPreloadProperyNames(const PropertyNames: TList<string>); override;
    procedure SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>); override;
    { inherited }
    procedure Realign; override;
    function FindTarget(P: TPointF; const Data: TDragObject): IControl; override;
    procedure SetTransparency(const Value: Boolean); override;
    procedure DoScaleChanged; override;
    { }
    function ScreenToLocal(P: TPointF): TPointF;
    function LocalToScreen(P: TPointF): TPointF;
    { Window style }
    function GetWindowStyle: TWindowStyles; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    procedure EndUpdate; override;
    procedure InitializeNewForm; override;
    property Context: TContext3D read FContext;
    property Multisample: TMultisample read FMultisample write SetMultisample default TMultisample.ms4Samples;
    property Color: TAlphaColor read GetFill write SetFill default TAlphaColors.White;
    property Camera: TCamera read FCamera write SetCamera;
    property UsingDesignCamera: Boolean read FUsingDesignCamera write SetUsingDesignCamera default True;
    function ObjectAtPoint(P: TPointF): IControl; override;
    property OnRender: TRenderEvent read FOnRender write FOnRender;
  end;

  TForm3D = class(TCustomForm3D)
  published
    property BiDiMode;
    property Camera;
    property Caption;
    property Color default TAlphaColors.White;
    property Cursor default crDefault;
    property Border;
    property BorderIcons default [TBorderIcon.biSystemMenu, TBorderIcon.biMinimize, TBorderIcon.biMaximize];
    property BorderStyle default TFmxFormBorderStyle.bsSizeable;
    property ClientHeight;
    property ClientWidth;
    property Height;
    property Left;
    property Padding;
    property Multisample default TMultisample.ms4Samples;
    property Position default TFormPosition.poDefaultPosOnly;
    property StyleBook;
    property StaysOpen default True;
    property ShowActivated default True;
    property Top;
    property TopMost default False;
    property UsingDesignCamera default True;
    property Visible;
    property Width;
    property WindowState default TWindowState.wsNormal;
    property FormFactor;
    property FormFamily;
    {events}
    property OnActivate;
    property OnCreate;
    property OnClose;
    property OnCloseQuery;
    property OnDeactivate;
    property OnDestroy;
    property OnKeyDown;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnRender;
    property OnResize;
    property OnShow;
    property OnHide;
    property OnVirtualKeyboardShown;
    property OnVirtualKeyboardHidden;
  end;

implementation

uses
  System.Variants,
  System.Generics.Defaults,
  System.RTLConsts,
  System.Rtti, System.Actions,
  FMX.Consts,
  FMX.Dialogs,
  FMX.Controls,
  FMX.Platform, FMX.Menus, FMX.Styles,
  FMX.Filter, FMX.Materials, FMX.TextLayout, FMX.Objects, FMX.Text;

type
  TOpenFmxObject = class (TFmxObject)
  end;

  TOpenControl = class (TControl)
  end;

{ TCustomForm3D }

type
  TOpenContext = class(TContext3D);
  TOpenControl3D = class(TControl3D);

// Required to force Delphi-style initialization when used from C++.
constructor TCustomForm3D.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TCustomForm3D.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
end;

procedure TCustomForm3D.InitializeNewForm;
begin
  inherited;
  FUsingDesignCamera := True;
  FFill := TAlphaColors.White;

  FLights := TList<TLight>.Create;

  FDesignCameraZ := TDummy.Create(nil);
  FDesignCameraZ.Tag := $FFFE;
  FDesignCameraZ.Locked := True;
  FDesignCameraZ.Stored := False;
  AddObject(FDesignCameraZ);

  FDesignCameraX := TDummy.Create(nil);
  FDesignCameraX.Tag := $FFFE;
  FDesignCameraX.Parent := FDesignCameraZ;
  FDesignCameraX.Locked := True;
  FDesignCameraX.Stored := False;
  FDesignCameraX.RotationAngle.X := -20;

  FDesignCamera := TCamera.Create(nil);
  FDesignCamera.Tag := $FFFE;
  FDesignCamera.Parent := FDesignCameraX;
  FDesignCamera.Locked := True;
  FDesignCamera.Stored := False;
  FDesignCamera.Position.Point := Point3D(0, 0, -20);
end;

destructor TCustomForm3D.Destroy;
begin
  if Assigned(FRenderingList) then
    FreeAndNil(FRenderingList);
  if Assigned(FEffectBitmap) then
    FreeAndNil(FEffectBitmap);
                                                                                             
  DeleteChildren;
  if Assigned(FContext) then
    FreeAndNil(FContext);
//  if Assigned(FChildren) then
//    FreeAndNil(FChildren);
  FreeAndNil(FLights);
  inherited;
end;

procedure TCustomForm3D.AddPreloadProperyNames(const PropertyNames: TList<string>);
begin
  inherited ;
  PropertyNames.Add('Multisample');
end;

procedure TCustomForm3D.SetPreloadProperies(const PropertyStore: TDictionary<string, Variant>);
var
  Val: Variant;
begin
  inherited ;
  // Default
  FMultisample := TMultisample.ms4Samples;
  // Preload
  PropertyStore.TryGetValue('Multisample', Val);
  if (Val <> Unassigned) and (Val <> Null) then
    FMultisample := TMultisample(GetEnumValue(TypeInfo(TMultisample), Val));
end;

procedure TCustomForm3D.CreateHandle;
begin
  inherited;
  CreateContext;
end;

procedure TCustomForm3D.ResizeHandle;
begin
  inherited;
  if Assigned(Context) and (ClientWidth > 0) and (ClientHeight > 0) then
  begin
    Context.SetSize(ClientWidth, ClientHeight);
    Context.SetCameraMatrix(GetCurrentCamera.CameraMatrix);
    Realign;
  end;
end;

procedure TCustomForm3D.DestroyHandle;
begin
  DestroyContext;
  inherited;
end;

procedure TCustomForm3D.CreateContext;
begin
  FContext := TContextManager.CreateFromWindow(Handle, ClientWidth, ClientHeight, FMultisample, True);
end;

procedure TCustomForm3D.DestroyContext;
begin
  FreeAndNil(FContext);
end;

procedure TCustomForm3D.DefineProperties(Filer: TFiler);
begin
  inherited;
  // Only for backward compatibility with XE2
  Filer.DefineProperty('Transparency', SkipTransparency, nil, False);
end;

procedure TCustomForm3D.SkipTransparency(Reader: TReader);
begin
  Reader.ReadBoolean; // skip this
end;

procedure TCustomForm3D.DoScaleChanged;
begin
  inherited;
  DestroyContext;
  CreateContext;
end;

procedure TCustomForm3D.EndUpdate;
begin
  inherited;
  if FUpdating = 0 then
    RebuildRenderingList;
end;

procedure TCustomForm3D.RebuildRenderingList;
var
  I: Integer;
  CompareFunc: TRenderingCompare;
begin
  if Assigned(Children) and (Children.Count > 0) and (FUpdating = 0) then
  begin
    if Not Assigned(FRenderingList) then
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

procedure TCustomForm3D.AddLight(const ALight: TLight);
begin
  FLights.Add(ALight);
end;

procedure TCustomForm3D.RemoveLight(const ALight: TLight);
begin
  FLights.Remove(ALight);
end;

procedure TCustomForm3D.PaintRects(const UpdateRects: array of TRectF);
var
  I: Integer;
  Ver: TVertexBuffer;
  Ind: TIndexBuffer;
  Mat: TTextureMaterial;
  Control: TOpenControl3D;
  P: TPointF;
begin
  if Not Assigned(Context) then
    Exit;
  if FDrawing then
    Exit;
  FDrawing := True;
  try
    if Context.BeginScene then
    try
      Context.Clear([TClearTarget.ctColor, TClearTarget.ctDepth], FFill, 1.0, 0);
      Context.SetCameraMatrix(GetCurrentCamera.CameraMatrix);
      Context.Lights.Clear;
      for I := 0 to FLights.Count - 1 do
        Context.Lights.Add(FLights[I].LightDescription);
      if Assigned(FOnRender) then
        FOnRender(Self, Context);
      if Assigned(FRenderingList) and (FRenderingList.Count > 0) then
      begin
        for I := 0 to FRenderingList.Count - 1 do
          if FRenderingList[i].Visible or (not FRenderingList[i].Visible and
            (csDesigning in ComponentState) and not FRenderingList[i].Locked) then
          begin
            Control := TOpenControl3D(FRenderingList[i]);
            if (csDesigning in Control.ComponentState) and not Control.DesignVisible then
              Continue;
            Control.RenderInternal;
          end;
      end;
      { post-processing }
      if Assigned(Children) then
      begin
        for i := 0 to Children.Count - 1 do
          if (TFmxObject(Children[i]) is TEffect) and (TEffect(Children[i]).Enabled) then
          begin
            if Not Assigned(FEffectBitmap) then
              FEffectBitmap := TBitmap.Create(FContext.Width, FContext.Height);
            FEffectBitmap.Assign(Context);
            TEffect(Children[i]).ProcessEffect(nil, FEffectBitmap, 1);
            // create quad
            Ver := TVertexBuffer.Create([TVertexFormat.vfVertex, TVertexFormat.vfTexCoord0], 4);

            P := Context.PixelToPixelPolygonOffset;
            Ver.Vertices[0] := Point3D(P.X, P.Y, 0);
            Ver.TexCoord0[0] := PointF(0.0, 0.0);
            Ver.Vertices[1] := Point3D(FEffectBitmap.Width + P.X, P.Y, 0);
            Ver.TexCoord0[1] := PointF(1.0, 0.0);
            Ver.Vertices[2] := Point3D(FEffectBitmap.Width + P.X, FEffectBitmap.Height + P.Y, 0);
            Ver.TexCoord0[2] := PointF(1.0, 1.0);
            Ver.Vertices[3] := Point3D(P.X, FEffectBitmap.Height + P.Y, 0);
            Ver.TexCoord0[3] := PointF(0.0, 1.0);

            Ind := TIndexBuffer.Create(6);
            Ind[0] := 0;
            Ind[1] := 1;
            Ind[2] := 3;
            Ind[3] := 3;
            Ind[4] := 1;
            Ind[5] := 2;
            // params
            Context.SetMatrix(IdentityMatrix3D);
            Context.SetContextState(TContextState.cs2DScene);
            Context.SetContextState(TContextState.csAllFace);
            Context.SetContextState(TContextState.csAlphaBlendOff);
            Context.SetContextState(TContextState.csZWriteOff);
            Context.SetContextState(TContextState.csZTestOff);
            // texture
            Mat := TTextureMaterial.Create;
            Mat.Texture := FEffectBitmap.Texture;
            // render quad
            Context.DrawTriangles(Ver, Ind, Mat, 1);
            if Assigned(Mat) then
              Mat.Free;
            if Assigned(Ind) then
              Ind.Free;
            if Assigned(Ver) then
              Ver.Free;
          end;
      end;
    finally
      { buffer }
      Context.EndScene;
    end;
  finally
    { off flag }
    FDrawing := False;
  end;
end;

procedure TCustomForm3D.DoAddObject(const AObject: TFmxObject);
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

procedure TCustomForm3D.DoRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TControl3D then
  begin
    TOpenControl3D(AObject).SetNewViewport(nil);
    RebuildRenderingList;
  end;
end;

procedure TCustomForm3D.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCamera) then
    FCamera := nil;
end;

function TCustomForm3D.ObjectAtPoint(P: TPointF): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  // first screen projection
  GlobalDistance := $FFFF;
  GlobalProjection := TProjection.pjScreen;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.GetVisible and not(csDesigning in ComponentState) then
      Continue;
    NewObj := NewObj.ObjectAtPoint(P);
    if Assigned(NewObj) then
      Result := NewObj;
  end;
  if Not Assigned(Result) then
  begin
    // second camera projection
    GlobalDistance := $FFFF;
    GlobalProjection := TProjection.pjCamera;
    for i := ChildrenCount - 1 downto 0 do
    begin
      Obj := Children[i];
      if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
        Continue;
      if not NewObj.GetVisible and not(csDesigning in ComponentState) then
        Continue;
      NewObj := NewObj.ObjectAtPoint(P);
      if Assigned(NewObj) then
        Result := NewObj;
    end;
  end;
end;

function TCustomForm3D.FindTarget(P: TPointF; const Data: TDragObject): IControl;
var
  i: Integer;
  Obj: TFmxObject;
  NewObj: IControl;
begin
  Result := nil;
  // first screen projection
  GlobalDistance := $FFFF;
  GlobalProjection := TProjection.pjScreen;
  for i := ChildrenCount - 1 downto 0 do
  begin
    Obj := Children[i];
    if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
      Continue;
    if not NewObj.Visible then Continue;
    NewObj := NewObj.FindTarget(P, Data);
    if Assigned(NewObj) then
      Result := NewObj;
  end;
  if Not Assigned(Result) then
  begin
    // second camera projection
    GlobalDistance := $FFFF;
    GlobalProjection := TProjection.pjCamera;
    for i := ChildrenCount - 1 downto 0 do
    begin
      Obj := Children[i];
      if IInterface(Obj).QueryInterface(IControl, NewObj) <> 0 then
        Continue;
      if not NewObj.Visible then Continue;
      NewObj := NewObj.FindTarget(P, Data);
      if Assigned(NewObj) then
        Result := NewObj;
    end;
  end;
end;

function TCustomForm3D.GetFill: TAlphaColor;
begin
  Result := FFill;
end;

function TCustomForm3D.GetLight(Index: Integer): TLight;
begin
  Result := FLights[Index];
end;

function TCustomForm3D.GetLightCount: Integer;
begin
  Result := FLights.Count;
end;

procedure TCustomForm3D.SetFill(const Value: TAlphaColor);
begin
  if FFill <> Value then
  begin
    FFill := Value;
    NeedRender;
  end;
end;

function TCustomForm3D.ScreenToLocal(P: TPointF): TPointF;
begin
  Result := ScreenToClient(P);
end;

function TCustomForm3D.LocalToScreen(P: TPointF): TPointF;
begin
  Result := ClientToScreen(P);
end;

procedure TCustomForm3D.SetMultisample(const Value: TMultisample);
begin
  if FMultisample <> Value then
  begin
    FMultisample := Value;
    Recreate;
  end;
end;

procedure TCustomForm3D.SetTransparency(const Value: Boolean);
begin
  Transparency := False;
end;

procedure TCustomForm3D.SetUsingDesignCamera(const Value: Boolean);
begin
  if FUsingDesignCamera <> Value then
  begin
    FUsingDesignCamera := Value;
    if Assigned(FContext) then
      NeedRender;
  end;
end;

{ IViewport3D }

function TCustomForm3D.GetObject: TFmxObject;
begin
  Result := Self;
end;

function TCustomForm3D.GetCamera: TCamera;
begin
  Result := FCamera;
end;

function TCustomForm3D.GetCurrentCamera: TCamera;
begin
  if Assigned(FCamera) and not (FUsingDesignCamera) and not (csDesigning in ComponentState) then
    Result := FCamera
  else
    Result := FDesignCamera;
end;

function TCustomForm3D.GetContext: TContext3D;
begin
  Result := FContext;
end;

function TCustomForm3D.GetUsingDesignCamera: Boolean;
begin
  Result := FUsingDesignCamera;
end;

function TCustomForm3D.GetViewportScale: Single;
begin
  Result := FWinService.GetWindowScale(Self);
end;

function TCustomForm3D.GetWindowStyle: TWindowStyles;
begin
  Result := [TWindowStyle.wsGPUSurface];
end;

procedure TCustomForm3D.SetCamera(const ACamera: TCamera);
begin
  if FCamera <> ACamera then
  begin
    FCamera := ACamera;
    if Assigned(FContext) and not (FUsingDesignCamera) and not (csDesigning in ComponentState) then
      NeedRender;
  end;
end;

procedure TCustomForm3D.NeedRender;
begin
  InvalidateRect(RectF(0, 0, FContext.Width, FContext.Height)); // because is a HW context
end;

procedure TCustomForm3D.Realign;
begin
  AlignObjects(Self, Padding, FContext.Width, FContext.Height, FLastWidth, FLastHeight, FDisableAlign);
  InvalidateRect(ClientRect);
end;

end.
