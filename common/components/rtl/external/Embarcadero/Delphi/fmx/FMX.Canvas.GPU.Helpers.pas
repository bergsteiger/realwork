{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.Canvas.GPU.Helpers;

{ FireMonkey NextGen Canvas helper that provides low-level drawing interface. }

interface

uses
  System.Types, System.UITypes, System.UIConsts, System.Classes, System.SysUtils,
  System.Math, FMX.Types, FMX.Types3D, FMX.Materials.Canvas, FMX.PixelFormats;

type
  // The drawing mode of the HUD, mainly to accomodate stencil-based 2D text output.
  TDrawingMode = (dmNormal, dmWriteStencilInvert, dmReadStencil, dmClearStencil);
  // Specific how the HUD rendering should work like.
  TAlphaBlendingApproach = (baNormal, baPremultipliedAlpha);

  // Canvas low-level drawing helper.
  TCanvasHelper = class
  public type
    TVertexArray = array of TPointF;
    TAlphaColorArray = array of TAlphaColor;
    TIndexArray = array of Integer;
    TTransformCallback = procedure(var Position: TPointF) of object;
  private const
    ZeroPt: TPointF = (X: 0.0; Y: 0.0);
    MaxBatchedVertices = 8192;
    MaxBatchedIndices = 12288;
  private type
    PVertexBufferItem = ^TVertexBufferItem;
    TVertexBufferItem = packed record
      Position: TPoint3D;
      TexCoord: TPointF;
      VtxColor: TAlphaColor;
    end;
    TIndexBufferItem = Word;
    TBatchVertexBuffer = packed array [0 .. MaxBatchedVertices - 1] of TVertexBufferItem;
    TBatchIndexBuffer = packed array [0 .. MaxBatchedIndices - 1] of TIndexBufferItem;
    TBatchingTopology = (btNone, btPixels, btLines, btTriangles);
  private
    FCurrentTexture: TTexture;
    FCurrentTopology: TBatchingTopology;
    FCurrentMaterial: TMaterial;
    FBatchedVertices: Integer;
    FBatchedIndices: Integer;
    FBatchVertexBuffer: TBatchVertexBuffer;
    FBatchIndexBuffer: TBatchIndexBuffer;
    FFlushCountPerFrame: Integer;
    FTexMat: TCanvasTextureMaterial;
    FSolidMat: TCanvasSolidMaterial;
    FGradientMat: TCanvasGradientMaterial;
    [Weak] FContext: TContext3D;

    FAlphaBlendingApproach: TAlphaBlendingApproach;
    FDrawingMode: TDrawingMode;

    TempVertices4: TVertexArray;
    TempTexCoords4: TVertexArray;
    TempColors4: TAlphaColorArray;
    TempIndices6: TIndexArray;
    FPrimitiveCountPerFrame: Integer;

    procedure SetDrawingMode(const Value: TDrawingMode);
    procedure InsertIndex(const Value: Integer);
    procedure InsertVertex(const Position, TexCoord: TPointF;
      const Color: TAlphaColor);
    procedure ResetBatchingStatus(const Topology: TBatchingTopology; const Texture: TTexture;
      const Material: TMaterial);
    procedure UpdateBatchingStatus(const Topology: TBatchingTopology; const MinVertexCount, MinIndexCount: Integer;
      const Texture: TTexture; const Material: TMaterial);
    procedure UpdateScissorRect;
    procedure DrawBuffers();
    function CalculateTopLeft(const ARect: TRectF; const TransformCallback: TTransformCallback): TPointF;
  protected
    // Scissor rectangle that limits drawing to certain portion of the screen.
    FScissorRect: TRect;

    // Implements actual code that changes the scissor rectangle.
    procedure SetScissorRect(const Value: TRect);

    // Does the actual clearing of the stencil buffer on hardware device.
    procedure DoClearStencil(const StencilValue: Cardinal);
  public
    constructor Create(AAlphaBlendingApproach: TAlphaBlendingApproach = TAlphaBlendingApproach.baNormal); virtual;
    destructor Destroy(); override;

    // Begins rendering on the HUD.
    procedure BeginRender();
    // Finishes rendering on the HUD.
    procedure EndRender();

    // This method is called when drawing mode has been changed.
    procedure UpdateDrawingMode();

    // Flushes buffers of HUD renderer, sending them to graphics hardware for processing.
    procedure Flush();

    // Draws a single pixel on the screen.
    procedure Pixel(const Point: TPointF; const Color: TAlphaColor); overload;
    procedure Pixel(const X, Y: Single; const Color: TAlphaColor); overload;

    // Draws a line between two points on the screen.
    procedure Line(const Point1, Point2: TPointF; const Color1, Color2: TAlphaColor); overload;
    procedure Line(const Point1, Point2: TPointF; const Color: TAlphaColor); overload;
    procedure Line(const X1, Y1, X2, Y2: Single; const Color1, Color2: TAlphaColor); overload;
    procedure Line(const X1, Y1, X2, Y2: Single; const Color: TAlphaColor); overload;

    // Renders a list of triangles on the screen.
    procedure FillTriangles(const Vertices: TVertexArray; const Colors: TAlphaColorArray; const Indices: TIndexArray;
      const VertexCount, PrimitiveCount: Integer);

    // Draws a frame rectangle (line around 4 corners) on the screen.
    procedure FrameRect(const Corners: TCornersF; const Color1, Color2, Color3, Color4: TAlphaColor); overload;
    procedure FrameRect(const Corners: TCornersF; const Color: TAlphaColor); overload;
    procedure FrameRect(const X, Y, Width, Height: Single; const Color: TAlphaColor); overload;

    // Draws a filled rectangle optionally with gradient on the screen.
    procedure FillRect(const Corners: TCornersF; const Color1, Color2, Color3, Color4: TAlphaColor); overload;
    procedure FillRect(const Corners: TCornersF; const Color: TAlphaColor); overload;
    procedure FillRect(const X, Y, Width, Height: Single; const Color: TAlphaColor); overload;

    procedure FillEllipse(const ARect: TRectF; const AColor: TAlphaColor;
      const TransformCallback: TTransformCallback = nil);
    procedure FillQuad(const P1, P2, P3, P4: TPointF; const AColor: TAlphaColor);

    // Draws a list of textured triangles on the screen.
    procedure TexTriangles(const Texture: TTexture; const Vertices: TVertexArray; const TexCoords: TVertexArray;
      const Colors: TAlphaColorArray; const Indices: TIndexArray; const VertexCount, PrimitiveCount: Integer);

    { Draws a textured rectangle on the screen, optionally adding a color or
      even a gradient to the final image; this is achieved by multiplying image
      pixels by the specified color or gradient. }
    procedure TexRect(const DestCorners, SrcCorners: TCornersF; const Texture: TTexture;
      const Color1, Color2, Color3, Color4: TAlphaColor); overload;
    procedure TexRect(const DestCorners, SrcCorners: TCornersF; const Texture: TTexture; const Color: TAlphaColor); overload;
    procedure TexRect(const Corners: TCornersF; const Texture: TTexture; const Color: TAlphaColor); overload;
    procedure TexRect(const X, Y, Width, Height: Single; const Texture: TTexture; const Color: TAlphaColor); overload;

    procedure TexQuad(const P1, P2, P3, P4, TC1, TC2, TC3, TC4: TPointF;
      const AColor: TAlphaColor; const ATexture: TTexture);

    procedure TexEllipse(const ARect: TRectF; const AColor: TAlphaColor; const ATexture: TTexture;
      const TransformCallback: TTransformCallback = nil); overload;
    procedure TexEllipse(const ARect, ATexCoord: TRectF; const AColor: TAlphaColor; const ATexture: TTexture;
      const TransformCallback: TTransformCallback = nil); overload;

    procedure GradientRect(const DestCorners: TCornersF; const AGradient: TGradient); overload;
    procedure GradientEllipse(const ARect: TRectF; const AGradient: TGradient;
      const TransformCallback: TTransformCallback = nil);
    procedure GradientQuad(const P1, P2, P3, P4: TPointF;
      const AGradient: TGradient);
    procedure GradientTriangles(const AGradient: TGradient; const Vertices: TVertexArray; const TexCoords: TVertexArray;
      const Indices: TIndexArray; const VertexCount, PrimitiveCount: Integer);

    procedure ResetScissorRect;

    // The scissor rectangle, which limits rendering to a specific portion of the screen.
    property ScissorRect: TRect read FScissorRect write SetScissorRect;
    // Current drawing mode that involves stencil buffer and typically used to display 2D text.
    property DrawingMode: TDrawingMode read FDrawingMode write SetDrawingMode;
    // Indicates how many times the flush has been called per frame (which is detrimal for batching performance).
    property FlushCountPerFrame: Integer read FFlushCountPerFrame;
    // Indicates the rendering approach used by this HUD.
    property AlphaBlendingApproach: TAlphaBlendingApproach read FAlphaBlendingApproach;
    property PrimitiveCountPerFrame: Integer read FPrimitiveCountPerFrame;
    //
    procedure SetContext(const Context: TContext3D);
  end;

implementation

uses FMX.Consts;

constructor TCanvasHelper.Create(AAlphaBlendingApproach: TAlphaBlendingApproach = TAlphaBlendingApproach.baNormal);
begin
  inherited Create();

  FAlphaBlendingApproach := AAlphaBlendingApproach;

  SetLength(TempVertices4, 4);
  SetLength(TempTexCoords4, 4);
  SetLength(TempColors4, 4);
  SetLength(TempIndices6, 6);

  FTexMat := TCanvasTextureMaterial.Create;
  FSolidMat := TCanvasSolidMaterial.Create;
  FGradientMat := TCanvasGradientMaterial.Create;
end;

destructor TCanvasHelper.Destroy();
begin
  FreeAndNil(FGradientMat);
  FreeAndNil(FTexMat);
  FreeAndNil(FSolidMat);
  inherited;
end;

procedure TCanvasHelper.DoClearStencil(const StencilValue: Cardinal);
begin

end;

procedure TCanvasHelper.SetDrawingMode(const Value: TDrawingMode);
begin
  if (FDrawingMode <> Value) then
  begin
    Flush();

    FDrawingMode := Value;
    UpdateDrawingMode();
  end;
end;

procedure TCanvasHelper.ResetScissorRect;
begin
  Flush();
  if Assigned(FContext) then
  begin
    FContext.SetContextState(TContextState.csScissorOff);
    FScissorRect := Rect(0, 0, 0, 0);
  end;
end;

procedure TCanvasHelper.UpdateScissorRect;
begin
  Flush();
  if Assigned(FContext) then
  begin
    FContext.SetScissorRect(FScissorRect);
    FContext.SetContextState(TContextState.csScissorOn);
  end;
end;

procedure TCanvasHelper.SetScissorRect(const Value: TRect);
var
  NewValue: TRect;
begin
  if Assigned(FContext) then
  begin
    NewValue := Value;

    if (NewValue.Left < 0) then
      NewValue.Left := 0;
    if (NewValue.Top < 0) then
      NewValue.Top := 0;

    if (NewValue.Right > FContext.Width) then
      NewValue.Right := FContext.Width;

    if (NewValue.Bottom > FContext.Height) then
      NewValue.Bottom := FContext.Height;

    if (NewValue.Right < NewValue.Left) then
      NewValue.Right := NewValue.Left;
    if (NewValue.Bottom < NewValue.Top) then
      NewValue.Bottom := NewValue.Top;

    if (FScissorRect.Left <> NewValue.Left) or (FScissorRect.Top <> NewValue.Top) or
       (FScissorRect.Right <> NewValue.Right) or (FScissorRect.Bottom <> NewValue.Bottom) then
    begin
      Flush();

      FScissorRect := NewValue;
      UpdateScissorRect();
    end;
  end;
end;

procedure TCanvasHelper.BeginRender();
begin
  if Assigned(FContext) then
  begin
    FContext.SetMatrix(IdentityMatrix3D);
    FContext.SetContextState(TContextState.cs2DScene);
    FContext.SetContextState(TContextState.csAllFace);
    FContext.SetContextState(TContextState.csZWriteOff);
    FContext.SetContextState(TContextState.csZTestOff);
  end;

  FFlushCountPerFrame := 0;
  FPrimitiveCountPerFrame := 0;
  FCurrentTopology := TBatchingTopology.btNone;
  FCurrentTexture := nil;
  FCurrentMaterial := nil;
  FBatchedVertices := 0;
  FBatchedIndices := 0;
  FDrawingMode := TDrawingMode.dmNormal;

  UpdateDrawingMode();
end;

procedure TCanvasHelper.EndRender;
begin
  if Assigned(FContext) then
    FContext.SetContextState(TContextState.csScissorOff);
  FContext := nil;
end;

procedure TCanvasHelper.Pixel(const Point: TPointF; const Color: TAlphaColor);
begin

end;

procedure TCanvasHelper.Pixel(const X, Y: Single; const Color: TAlphaColor);
begin
  Pixel(PointF(X, Y), Color);
end;

procedure TCanvasHelper.Line(const Point1, Point2: TPointF; const Color: TAlphaColor);
begin
  Line(Point1, Point2, Color, Color);
end;

procedure TCanvasHelper.Line(const X1, Y1, X2, Y2: Single; const Color1, Color2: TAlphaColor);
begin
  Line(PointF(X1, Y1), PointF(X2, Y2), Color1, Color2);
end;

procedure TCanvasHelper.Line(const X1, Y1, X2, Y2: Single; const Color: TAlphaColor);
begin
  Line(PointF(X1, Y1), PointF(X2, Y2), Color, Color);
end;

procedure TCanvasHelper.Line(const Point1, Point2: TPointF; const Color1,
  Color2: TAlphaColor);
begin

end;

procedure TCanvasHelper.FrameRect(const Corners: TCornersF; const Color1, Color2, Color3, Color4: TAlphaColor);
begin
  Line(Corners[0], Corners[1], Color1, Color2);
  Line(Corners[1], Corners[2], Color2, Color3);
  Line(Corners[2], Corners[3], Color3, Color4);
  Line(Corners[3], Corners[0], Color4, Color1);
end;

procedure TCanvasHelper.FrameRect(const Corners: TCornersF; const Color: TAlphaColor);
begin
  FrameRect(Corners, Color, Color, Color, Color);
end;

procedure TCanvasHelper.FrameRect(const X, Y, Width, Height: Single; const Color: TAlphaColor);
begin
  FrameRect(CornersF(X, Y, Width, Height), Color, Color, Color, Color);
end;

procedure TCanvasHelper.FillRect(const Corners: TCornersF; const Color1, Color2, Color3, Color4: TAlphaColor);
begin
  TempVertices4[0] := Corners[0];
  TempVertices4[1] := Corners[1];
  TempVertices4[2] := Corners[2];
  TempVertices4[3] := Corners[3];

  TempColors4[0] := Color1;
  TempColors4[1] := Color2;
  TempColors4[2] := Color3;
  TempColors4[3] := Color4;

  TempIndices6[0] := 0;
  TempIndices6[1] := 2;
  TempIndices6[2] := 3;
  TempIndices6[3] := 0;
  TempIndices6[4] := 1;
  TempIndices6[5] := 2;

  FillTriangles(TempVertices4, TempColors4, TempIndices6, 4, 2);
end;

procedure TCanvasHelper.FillRect(const Corners: TCornersF; const Color: TAlphaColor);
begin
  FillRect(Corners, Color, Color, Color, Color);
end;

procedure TCanvasHelper.FillRect(const X, Y, Width, Height: Single; const Color: TAlphaColor);
begin
  FillRect(CornersF(X, Y, Width, Height), Color, Color, Color, Color);
end;

procedure TCanvasHelper.UpdateBatchingStatus(const Topology: TBatchingTopology; const MinVertexCount,
  MinIndexCount: Integer; const Texture: TTexture; const Material: TMaterial);
var
  BatchInvalid: Boolean;
  M: TMaterial;
begin
  if (MinVertexCount >= MaxBatchedVertices) or (MinIndexCount >= MaxBatchedIndices) then
    raise EInvalidCallingConditions.CreateResFmt(@SInvalidCallingConditions, [ClassName]);

  if Assigned(Material) then
    M := Material
  else if Assigned(Texture) then
    M := FTexMat
  else
    M := FSolidMat;

  BatchInvalid := (FBatchedVertices + MinVertexCount >= MaxBatchedVertices) or
    (FBatchedIndices + MinIndexCount >= MaxBatchedIndices) or
    (FCurrentTopology = TBatchingTopology.btNone) or (FCurrentTopology <> Topology) or
    (FCurrentTexture <> Texture) or (FCurrentMaterial <> M);

  if (BatchInvalid) then
    ResetBatchingStatus(Topology, Texture, M);
end;

procedure TCanvasHelper.ResetBatchingStatus(const Topology: TBatchingTopology;
  const Texture: TTexture; const Material: TMaterial);
begin
  Flush;

  FCurrentMaterial := Material;
  FCurrentTexture := Texture;
  FCurrentTopology := Topology;
end;

procedure TCanvasHelper.Flush;
begin
  try
    if Assigned(FContext) and (FBatchedVertices > 0) then
    begin
      DrawBuffers;
      Inc(FFlushCountPerFrame);
    end;
  finally
    FBatchedVertices := 0;
    FBatchedIndices := 0;
    FCurrentTexture := nil;
    FCurrentMaterial := nil;
  end;
end;

procedure TCanvasHelper.UpdateDrawingMode;
begin
  if Assigned(FContext) then
  begin
    case DrawingMode of
      TDrawingMode.dmNormal:
        begin
          FContext.SetContextState(TContextState.csStencilOff);
          FContext.SetContextState(TContextState.csColorWriteOn);
        end;
      TDrawingMode.dmWriteStencilInvert:
        begin
          FContext.SetContextState(TContextState.csStencilOn);
          FContext.SetStencilFunc(TStencilFunc.sfAlways, 0, $FF);
          FContext.SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soInvert);

          FContext.SetContextState(TContextState.csColorWriteOff);
        end;
      TDrawingMode.dmReadStencil:
        begin
          FContext.SetContextState(TContextState.csStencilOn);
          FContext.SetStencilFunc(TStencilFunc.sfNotEqual, 0, $FF);
          FContext.SetStencilOp(TStencilOp.soKeep, TStencilOp.soKeep, TStencilOp.soKeep);

          FContext.SetContextState(TContextState.csColorWriteOn);
        end;
      TDrawingMode.dmClearStencil:
        begin
          FContext.SetContextState(TContextState.csStencilOn);
          FContext.SetStencilFunc(TStencilFunc.sfAlways, 0, $FF);
          FContext.SetStencilOp(TStencilOp.soZero, TStencilOp.soZero, TStencilOp.soZero);

          FContext.SetContextState(TContextState.csColorWriteOff);
        end;
    end;

    if (DrawingMode <> TDrawingMode.dmWriteStencilInvert) then
    begin
      FContext.SetContextState(TContextState.csAlphaBlendOn);

  {    if (AlphaBlendingApproach = TAlphaBlendingApproach.baNormal) then
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
      else
        glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);}
    end
    else
      FContext.SetContextState(TContextState.csAlphaBlendOff);
  end;
end;

procedure TCanvasHelper.InsertVertex(const Position, TexCoord: TPointF; const Color: TAlphaColor);
begin
  FBatchVertexBuffer[FBatchedVertices].Position.X := Position.X;
  FBatchVertexBuffer[FBatchedVertices].Position.Y := Position.Y;
  if Assigned(FCurrentTexture) and Assigned(FContext) and (TTextureStyle.tsRenderTarget in FCurrentTexture.Style) and (TContextStyle.RenderTargetFlipped in FContext.Style) then
    FBatchVertexBuffer[FBatchedVertices].TexCoord := TPointF.Create(TexCoord.X, 1 - TexCoord.Y)
  else
    FBatchVertexBuffer[FBatchedVertices].TexCoord := TexCoord;
  if Assigned(FContext) then
    AlphaColorToPixel(Color, @FBatchVertexBuffer[FBatchedVertices].VtxColor, FContext.PixelFormat)
  else
    FBatchVertexBuffer[FBatchedVertices].VtxColor := Color;

  Inc(FBatchedVertices);
end;

procedure TCanvasHelper.InsertIndex(const Value: Integer);
begin
  FBatchIndexBuffer[FBatchedIndices] := Value;
  Inc(FBatchedIndices);
end;

procedure TCanvasHelper.DrawBuffers;
var
  SolidDecl: TVertexDeclaration;
begin
  if (FCurrentMaterial = FTexMat) then
  begin
    SetLength(SolidDecl, 3);
    SolidDecl[0].Format := TVertexFormat.vfVertex;
    SolidDecl[0].Offset := 0;
    SolidDecl[1].Format := TVertexFormat.vfTexCoord0;
    SolidDecl[1].Offset := 12;
    SolidDecl[2].Format := TVertexFormat.vfColor0;
    SolidDecl[2].Offset := 20;
    FTexMat.Texture := FCurrentTexture;
    FContext.DrawPrimitives(TPrimitivesKind.pkTriangles, @FBatchVertexBuffer[0], @FBatchIndexBuffer[0], SolidDecl,
      SizeOf(TVertexBufferItem), FBatchedVertices, SizeOf(TIndexBufferItem), FBatchedIndices, FCurrentMaterial, 1.0);
  end else if FCurrentMaterial <> FSolidMat then
  begin
    SetLength(SolidDecl, 3);
    SolidDecl[0].Format := TVertexFormat.vfVertex;
    SolidDecl[0].Offset := 0;
    SolidDecl[1].Format := TVertexFormat.vfTexCoord0;
    SolidDecl[1].Offset := 12;
    SolidDecl[2].Format := TVertexFormat.vfColor0;
    SolidDecl[2].Offset := 20;
    FContext.DrawPrimitives(TPrimitivesKind.pkTriangles, @FBatchVertexBuffer[0], @FBatchIndexBuffer[0], SolidDecl,
      SizeOf(TVertexBufferItem), FBatchedVertices, SizeOf(TIndexBufferItem), FBatchedIndices, FCurrentMaterial, 1.0);
  end else begin
    SetLength(SolidDecl, 2);
    SolidDecl[0].Format := TVertexFormat.vfVertex;
    SolidDecl[0].Offset := 0;
    SolidDecl[1].Format := TVertexFormat.vfColor0;
    SolidDecl[1].Offset := 20;
    FContext.DrawPrimitives(TPrimitivesKind.pkTriangles, @FBatchVertexBuffer[0], @FBatchIndexBuffer[0], SolidDecl,
      SizeOf(TVertexBufferItem), FBatchedVertices, SizeOf(TIndexBufferItem), FBatchedIndices, FCurrentMaterial, 1.0);
  end;
end;

procedure TCanvasHelper.TexRect(const DestCorners, SrcCorners: TCornersF; const Texture: TTexture;
  const Color1, Color2, Color3, Color4: TAlphaColor);
var
  InvTexSize: TPointF;
begin
  if (not Assigned(Texture)) or (Texture.Width < 1) or (Texture.Height < 1) then
    Exit;

  TempVertices4[0] := DestCorners[0];
  TempVertices4[1] := DestCorners[1];
  TempVertices4[2] := DestCorners[2];
  TempVertices4[3] := DestCorners[3];

  InvTexSize := PointF(1.0 / Texture.Width, 1.0 / Texture.Height);

  TempTexCoords4[0] := SrcCorners[0] * InvTexSize;
  TempTexCoords4[1] := SrcCorners[1] * InvTexSize;
  TempTexCoords4[2] := SrcCorners[2] * InvTexSize;
  TempTexCoords4[3] := SrcCorners[3] * InvTexSize;

  TempColors4[0] := Color1;
  TempColors4[1] := Color2;
  TempColors4[2] := Color3;
  TempColors4[3] := Color4;

  TempIndices6[0] := 0;
  TempIndices6[1] := 2;
  TempIndices6[2] := 3;
  TempIndices6[3] := 0;
  TempIndices6[4] := 1;
  TempIndices6[5] := 2;

  TexTriangles(Texture, TempVertices4, TempTexCoords4, TempColors4, TempIndices6, 4, 2);
end;

procedure TCanvasHelper.TexRect(const DestCorners, SrcCorners: TCornersF; const Texture: TTexture;
  const Color: TAlphaColor);
begin
  TexRect(DestCorners, SrcCorners, Texture, Color, Color, Color, Color);
end;

procedure TCanvasHelper.TexRect(const Corners: TCornersF; const Texture: TTexture; const Color: TAlphaColor);
begin
  if (not Assigned(Texture)) then
    Exit;

  TexRect(Corners, CornersF(0.0, 0.0, Texture.Width, Texture.Height), Texture, Color, Color, Color, Color);
end;

procedure TCanvasHelper.TexRect(const X, Y, Width, Height: Single; const Texture: TTexture; const Color: TAlphaColor);
begin
  TexRect(CornersF(X, Y, Width, Height), Texture, Color);
end;

procedure TCanvasHelper.SetContext(const Context: TContext3D);
begin
  FContext := Context;
  if Assigned(FContext) then
    FContext.SetContextState(TContextState.csScissorOff);
end;

procedure TCanvasHelper.FillEllipse(const ARect: TRectF; const AColor: TAlphaColor;
  const TransformCallback: TTransformCallback);
const
  MinFlatDistance = 8.0;
var
  Vertices: TVertexArray;
  Colors: TAlphaColorArray;
  Indices: TIndexArray;
  Index, SubdivCount: Integer;
  Angle: Single;
  Radius: TPointF;
  Center, CurPt: TPointF;
begin
  Radius.X := ARect.Width / 2.0;
  Radius.Y := ARect.Height / 2.0;

  SubdivCount := Max(Ceil(2.0 * Pi * Max(Radius.X, Radius.Y) / MinFlatDistance), 12);

  Center.X := (ARect.Left + ARect.Right) / 2.0;
  Center.Y := (ARect.Top + ARect.Bottom) / 2.0;

  SetLength(Vertices, 1 + SubdivCount);
  SetLength(Colors, 1 + SubdivCount);
  SetLength(Indices, SubdivCount * 3);

  CurPt := Center;

  if Assigned(TransformCallback) then
    TransformCallback(CurPt);

  Vertices[0] := CurPt;
  Colors[0] := AColor;

  for Index := 0 to SubdivCount - 1 do
  begin
    Angle := Index * 2.0 * Pi / SubdivCount;

    CurPt.X := Cos(Angle) * Radius.X;
    CurPt.Y := Sin(Angle) * Radius.Y;

    CurPt.Offset(Center);

    if Assigned(TransformCallback) then
      TransformCallback(CurPt);

    Vertices[1 + Index] := CurPt;
    Colors[1 + Index] := AColor;

    Indices[(Index * 3) + 0] := 0;
    Indices[(Index * 3) + 1] := 1 + Index;
    Indices[(Index * 3) + 2] := 1 + ((1 + Index) mod SubdivCount);
  end;

  FillTriangles(Vertices, Colors, Indices, Length(Vertices), SubdivCount);
end;

procedure TCanvasHelper.FillQuad(const P1, P2, P3, P4: TPointF; const AColor: TAlphaColor);
begin
  UpdateBatchingStatus(btTriangles, 4, 6, nil, nil);

  InsertIndex(FBatchedVertices + 0);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 2);

  InsertVertex(P1, ZeroPt, AColor);
  InsertVertex(P2, ZeroPt, AColor);
  InsertVertex(P3, ZeroPt, AColor);
  InsertVertex(P4, ZeroPt, AColor);
end;

procedure TCanvasHelper.FillTriangles(const Vertices: TVertexArray;
  const Colors: TAlphaColorArray; const Indices: TIndexArray; const VertexCount,
  PrimitiveCount: Integer);
var
  Index: Integer;
begin
  UpdateBatchingStatus(btTriangles, VertexCount, PrimitiveCount * 3, nil, nil);

  for Index := 0 to (PrimitiveCount * 3) - 1 do
    InsertIndex(FBatchedVertices + Indices[Index]);

  for Index := 0 to VertexCount - 1 do
    InsertVertex(Vertices[Index], ZeroPt, Colors[Index]);

  Inc(FPrimitiveCountPerFrame, PrimitiveCount);
end;

procedure TCanvasHelper.TexQuad(const P1, P2, P3, P4: TPointF; const TC1, TC2, TC3, TC4: TPointF;
  const AColor: TAlphaColor; const ATexture: TTexture);
begin
  UpdateBatchingStatus(btTriangles, 4, 6, ATexture, nil);

  InsertIndex(FBatchedVertices + 0);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 2);

  InsertVertex(P1, TC1, AColor);
  InsertVertex(P2, TC2, AColor);
  InsertVertex(P3, TC3, AColor);
  InsertVertex(P4, TC4, AColor);

  Inc(FPrimitiveCountPerFrame, 2);
end;

procedure TCanvasHelper.TexTriangles(const Texture: TTexture;
  const Vertices, TexCoords: TVertexArray; const Colors: TAlphaColorArray;
  const Indices: TIndexArray; const VertexCount, PrimitiveCount: Integer);
var
  Index: Integer;
begin
  UpdateBatchingStatus(btTriangles, VertexCount, PrimitiveCount * 3, Texture, nil);

  for Index := 0 to (PrimitiveCount * 3) - 1 do
    InsertIndex(FBatchedVertices + Indices[Index]);

  for Index := 0 to VertexCount - 1 do
    InsertVertex(Vertices[Index], TexCoords[Index], Colors[Index]);

  Inc(FPrimitiveCountPerFrame, PrimitiveCount);
end;

procedure TCanvasHelper.TexEllipse(const ARect, ATexCoord: TRectF;
  const AColor: TAlphaColor; const ATexture: TTexture; const TransformCallback: TTransformCallback = nil);
const
  MinFlatDistance = 8.0;
var
  TexCoords, Vertices: TVertexArray;
  Colors: TAlphaColorArray;
  Indices: TIndexArray;
  Index, SubdivCount: Integer;
  Angle: Single;
  Radius: TPointF;
  TexPt, Center, LocalPt, CurPt: TPointF;
begin
  Radius.X := ARect.Width / 2.0;
  Radius.Y := ARect.Height / 2.0;

  SubdivCount := Max(Ceil(2.0 * Pi * Max(Radius.X, Radius.Y) / MinFlatDistance), 12);

  Center.X := (ARect.Left + ARect.Right) / 2.0;
  Center.Y := (ARect.Top + ARect.Bottom) / 2.0;

  SetLength(Vertices, 1 + SubdivCount);
  SetLength(Colors, 1 + SubdivCount);
  SetLength(TexCoords, 1 + SubdivCount);
  SetLength(Indices, SubdivCount * 3);

  LocalPt := Center;
  CurPt := LocalPt;
  if Assigned(TransformCallback) then
    TransformCallback(CurPt);

  Vertices[0] := CurPt;
  Colors[0] := AColor;
  TexPt := TPointF.Create((LocalPt.X - ARect.Left) / ARect.Width,
    (LocalPt.Y - ARect.Top) / ARect.Height);
  TexCoords[0] := TPointF.Create(ATexCoord.Left + TexPt.X * ATexCoord.Width,
    ATexCoord.Top + TexPt.Y * ATexCoord.Height);

  for Index := 0 to SubdivCount - 1 do
  begin
    Angle := Index * 2.0 * Pi / SubdivCount;

    LocalPt.X := Cos(Angle) * Radius.X;
    LocalPt.Y := Sin(Angle) * Radius.Y;

    LocalPt.Offset(Center);

    CurPt := LocalPt;
    if Assigned(TransformCallback) then
      TransformCallback(CurPt);

    Vertices[1 + Index] := CurPt;
    Colors[1 + Index] := AColor;
    TexPt := TPointF.Create((LocalPt.X - ARect.Left) / ARect.Width,
      (LocalPt.Y - ARect.Top) / ARect.Height);
    TexCoords[1 + Index] := TPointF.Create(ATexCoord.Left + TexPt.X * ATexCoord.Width,
      ATexCoord.Top + TexPt.Y * ATexCoord.Height);

    Indices[(Index * 3) + 0] := 0;
    Indices[(Index * 3) + 1] := 1 + Index;
    Indices[(Index * 3) + 2] := 1 + ((1 + Index) mod SubdivCount);
  end;

  TexTriangles(ATexture, Vertices, TexCoords, Colors, Indices, Length(Vertices), SubdivCount);
end;

procedure TCanvasHelper.TexEllipse(const ARect: TRectF; const AColor: TAlphaColor; const ATexture: TTexture;
  const TransformCallback: TTransformCallback = nil);
begin
  TexEllipse(ARect, RectF(0, 0, 1, 1), AColor, ATexture, TransformCallback);
end;

procedure TCanvasHelper.GradientRect(const DestCorners: TCornersF;
  const AGradient: TGradient);
begin
  TempVertices4[0] := DestCorners[0];
  TempVertices4[1] := DestCorners[1];
  TempVertices4[2] := DestCorners[2];
  TempVertices4[3] := DestCorners[3];

  TempTexCoords4[0] := TPointF.Create(0, 0);
  TempTexCoords4[1] := TPointF.Create(1, 0);
  TempTexCoords4[2] := TPointF.Create(1, 1);
  TempTexCoords4[3] := TPointF.Create(0, 1);

  TempIndices6[0] := 0;
  TempIndices6[1] := 2;
  TempIndices6[2] := 3;
  TempIndices6[3] := 0;
  TempIndices6[4] := 1;
  TempIndices6[5] := 2;

  GradientTriangles(AGradient, TempVertices4, TempTexCoords4, TempIndices6, 4, 2);
end;

procedure TCanvasHelper.GradientQuad(const P1, P2, P3, P4: TPointF;
  const AGradient: TGradient);
begin
  if not FGradientMat.Gradient.Equal(AGradient) then
    Flush;
  FGradientMat.Gradient := AGradient;
  UpdateBatchingStatus(btTriangles, 4, 6, nil, FGradientMat);

  InsertIndex(FBatchedVertices + 0);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 3);
  InsertIndex(FBatchedVertices + 1);
  InsertIndex(FBatchedVertices + 2);

  InsertVertex(P1, PointF(0, 0), $FFFFFFFF);
  InsertVertex(P2, PointF(1, 0), $FFFFFFFF);
  InsertVertex(P3, PointF(1, 1), $FFFFFFFF);
  InsertVertex(P4, PointF(0, 1), $FFFFFFFF);

  Inc(FPrimitiveCountPerFrame, 2);
end;

function TCanvasHelper.CalculateTopLeft(const ARect: TRectF; const TransformCallback: TTransformCallback): TPointF;
var
  Temp: TPointF;
begin
  // Top-left corner.
  Result := ARect.TopLeft;

  if Assigned(TransformCallback) then
    TransformCallback(Result);

  // Top-right corner.
  Temp := PointF(ARect.Right, ARect.Top);

  if Assigned(TransformCallback) then
    TransformCallback(Temp);

  Result.X := Min(Result.X, Temp.X);
  Result.Y := Min(Result.Y, Temp.Y);

  // Bottom-right corner.
  Temp := ARect.BottomRight;

  if Assigned(TransformCallback) then
    TransformCallback(Temp);

  Result.X := Min(Result.X, Temp.X);
  Result.Y := Min(Result.Y, Temp.Y);

  // Bottom-left corner.
  Temp := PointF(ARect.Left, ARect.Bottom);

  if Assigned(TransformCallback) then
    TransformCallback(Temp);

  Result.X := Min(Result.X, Temp.X);
  Result.Y := Min(Result.Y, Temp.Y);
end;

procedure TCanvasHelper.GradientEllipse(const ARect: TRectF; const AGradient: TGradient;
  const TransformCallback: TTransformCallback = nil);
const
  MinFlatDistance = 8.0;
var
  TexCoords, Vertices: TVertexArray;
  Indices: TIndexArray;
  Index, SubdivCount: Integer;
  Angle: Single;
  Radius: TPointF;
  Center, CurPt, TopLeft: TPointF;
begin
  Radius.X := ARect.Width / 2.0;
  Radius.Y := ARect.Height / 2.0;

  SubdivCount := Max(Ceil(2.0 * Pi * Max(Radius.X, Radius.Y) / MinFlatDistance), 12);

  TopLeft := CalculateTopLeft(ARect, TransformCallback);

  Center.X := (ARect.Left + ARect.Right) / 2.0;
  Center.Y := (ARect.Top + ARect.Bottom) / 2.0;

  SetLength(Vertices, 1 + SubdivCount);
  SetLength(TexCoords, 1 + SubdivCount);
  SetLength(Indices, SubdivCount * 3);

  CurPt := Center;

  if Assigned(TransformCallback) then
    TransformCallback(CurPt);

  Vertices[0] := CurPt;
  TexCoords[0] := TPointF.Create((CurPt.X - TopLeft.X) / ARect.Width, (CurPt.Y - TopLeft.Y) / ARect.Height);

  for Index := 0 to SubdivCount - 1 do
  begin
    Angle := Index * 2.0 * Pi / SubdivCount;

    CurPt.X := Cos(Angle) * Radius.X;
    CurPt.Y := Sin(Angle) * Radius.Y;

    CurPt.Offset(Center);

    if Assigned(TransformCallback) then
      TransformCallback(CurPt);

    Vertices[1 + Index] := CurPt;
    TexCoords[1 + Index] := TPointF.Create((CurPt.X - TopLeft.X) / ARect.Width, (CurPt.Y - TopLeft.Y) / ARect.Height);

    Indices[(Index * 3) + 0] := 0;
    Indices[(Index * 3) + 1] := 1 + Index;
    Indices[(Index * 3) + 2] := 1 + ((1 + Index) mod SubdivCount);
  end;

  GradientTriangles(AGradient, Vertices, TexCoords, Indices, Length(Vertices), SubdivCount);
end;

procedure TCanvasHelper.GradientTriangles(const AGradient: TGradient;
  const Vertices, TexCoords: TVertexArray;
  const Indices: TIndexArray; const VertexCount, PrimitiveCount: Integer);
var
  Index: Integer;
begin
  if not FGradientMat.Gradient.Equal(AGradient) then
    Flush;
  FGradientMat.Gradient := AGradient;
  UpdateBatchingStatus(btTriangles, VertexCount, PrimitiveCount * 3, nil, FGradientMat);

  for Index := 0 to (PrimitiveCount * 3) - 1 do
    InsertIndex(FBatchedVertices + Indices[Index]);

  for Index := 0 to VertexCount - 1 do
    InsertVertex(Vertices[Index], TexCoords[Index], $FFFFFFFF);

  Inc(FPrimitiveCountPerFrame, PrimitiveCount);
end;

end.
