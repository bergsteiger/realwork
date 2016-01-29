{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2013 Embarcadero Technologies, Inc.      }
{                                                       }
{*******************************************************}

unit FMX.StrokeBuilder;

interface

uses
  System.Types, System.UITypes, System.UIConsts, System.Math, FMX.Types, FMX.Canvas.GPU.Helpers;

{$DEFINE SafeInitArrays}
{$DEFINE BuildSanityChecks}

type
  TStrokeBuilder = class
  private
    FMatrix: TMatrix;
    FBrush: TStrokeBrush;

    FVertices: TCanvasHelper.TVertexArray;
    FColors: TCanvasHelper.TAlphaColorArray;
    FIndices: TCanvasHelper.TIndexArray;

    FCurrentVertex: Integer;
    FCurrentIndex: Integer;

    FSegmentCount: Integer;
    FLastSegmentFraction: Single;
    FExtraPieces: Integer;
    FLastDashExtend: Boolean;
    FThickness: Single;
    FHalfThickness: Single;
    FStrokeColor: TAlphaColor;

    FEllipseCenter: TPointF;
    FEllipseRadius: TPointF;
    FEllipseCircumf: Single;
    FEllipseTransfCenter: TPointF;
    FUndeterminedMode: Boolean;

    function GetMatrixScale(): TPointF;

    procedure ArrayFillCheck();
    procedure InitArrays(const VertexCount, IndexCount: Integer); inline;
    procedure FinalizeArrays();
    procedure InitArrayPointers();

    procedure InsertVertex(const VertexPos: TPointF; const Color: TAlphaColor);
    procedure InsertIndex(const Value: Integer);
    function GetCapDivisions(): Integer; inline;
    procedure GetDashEstimate(out VertexCount, IndexCount: Integer);
    procedure InsertDash(SrcPos, DestPos: TPointF; const DashDirVec, ThickPerp: TPointF);
    procedure GetDotEstimate(out VertexCount, IndexCount: Integer);
    procedure InsertDot(const MidPos, DotDirVec, ThickPerp: TPointF);
    function GetPatternStepCount(): Integer;
    procedure ComputeBuildEstimates(const TentSegmentCount: Single; out VertexCount, IndexCount: Integer);
    procedure InsertSegment(const SegmentPos, SegDirVec, ThickPerp, DestPos: TPointF; IsLast: Boolean);

    function GetEllipseTransfAt(const Delta: Single): TPointF;
    procedure InsertEllipseSegment(const SegInitDist: Single; IsLast: Boolean);
  public
    procedure BuildLine(const SrcPos, DestPos: TPointF; const Opacity: Single);
    procedure BuildIntermEllipse(const Center, Radius: TPointF; const Opacity: Single);
    procedure BuildSolidEllipse(const Center, Radius: TPointF; const Opacity: Single);
    procedure BuildIntermPath(const Path: TPathData; const Opacity: Single);
    procedure BuildSolidPath(const Path: TPathData; const Opacity: Single);

    procedure ResetArrays();

    property Matrix: TMatrix read FMatrix write FMatrix;
    property Brush: TStrokeBrush read FBrush write FBrush;

    property Vertices: TCanvasHelper.TVertexArray read FVertices;
    property Colors: TCanvasHelper.TAlphaColorArray read FColors;
    property Indices: TCanvasHelper.TIndexArray read FIndices;
  end;

implementation

function PointFDot(const P1, P2: TPointF): Single;
begin
  Result := (P1.X * P2.X) + (P1.Y * P2.Y);
end;

{$REGION 'Stroke Builder implementation'}

function TStrokeBuilder.GetMatrixScale(): TPointF;
const
  BaseVector: TVector = (X: 0.0; Y: 0.0; W: 1.0);
begin
  Result.X := FMatrix.Transform(Vector(1.0, 0.0)).ToPointF().Distance(FMatrix.Transform(BaseVector).ToPointF());
  Result.Y := FMatrix.Transform(Vector(0.0, 1.0)).ToPointF().Distance(FMatrix.Transform(BaseVector).ToPointF());
end;

procedure TStrokeBuilder.InitArrayPointers();
begin
  FCurrentVertex := 0;
  FCurrentIndex := 0;
end;

procedure TStrokeBuilder.InitArrays(const VertexCount, IndexCount: Integer);
{$IFDEF SafeInitArrays}
var
  Index: Integer;
{$ENDIF}
begin
  SetLength(FVertices, VertexCount);
  SetLength(FColors, VertexCount);
  SetLength(FIndices, IndexCount);

{$IFDEF SafeInitArrays}
  for Index := 0 to IndexCount - 1 do
    FIndices[Index] := -1;

  FillChar(FVertices[0], SizeOf(TPointF) * VertexCount, 0);
  FillChar(FColors[0], SizeOf(TAlphaColor) * VertexCount, 0);
{$ENDIF}
  InitArrayPointers();
end;

procedure TStrokeBuilder.ResetArrays();
begin
  SetLength(FVertices, 0);
  SetLength(FColors, 0);
  SetLength(FIndices, 0);
end;

procedure TStrokeBuilder.ArrayFillCheck();
begin
{$IFDEF BuildSanityChecks}
  Assert(FCurrentVertex = Length(FVertices), 'Vertices have not been filled correctly.');
  Assert(FCurrentIndex = Length(FIndices), 'Indices have not been filled correctly.');
{$ENDIF}
end;

procedure TStrokeBuilder.FinalizeArrays();
begin
  if (FUndeterminedMode) then
  begin
    SetLength(FVertices, FCurrentVertex);
    SetLength(FColors, FCurrentVertex);
    SetLength(FIndices, FCurrentIndex);
  end;
end;

procedure TStrokeBuilder.InsertVertex(const VertexPos: TPointF; const Color: TAlphaColor);
var
  NewValue: Integer;
begin
  if (FUndeterminedMode) and (Length(FVertices) <= FCurrentVertex) then
  begin
    NewValue := 8 + Ceil(Length(FVertices) * 1.5);

    SetLength(FVertices, NewValue);
    SetLength(FColors, NewValue);
  end;

{$IFDEF BuildSanityChecks}
  Assert(FCurrentVertex < Length(FVertices), 'Too many vertices.');
{$ENDIF}
  FVertices[FCurrentVertex] := VertexPos;
  FColors[FCurrentVertex] := Color;
  Inc(FCurrentVertex);
end;

procedure TStrokeBuilder.InsertIndex(const Value: Integer);
var
  NewValue: Integer;
begin
  if (FUndeterminedMode) and (Length(FIndices) <= FCurrentIndex) then
  begin
    NewValue := 12 + Ceil(Length(FIndices) * 1.5);
    SetLength(FIndices, NewValue);
  end;

{$IFDEF BuildSanityChecks}
  Assert(FCurrentIndex < Length(FIndices), 'Too many indices.');
{$ENDIF}
  FIndices[FCurrentIndex] := Value;
  Inc(FCurrentIndex);
end;

function TStrokeBuilder.GetCapDivisions(): Integer;
begin
  if (FBrush.Cap = TStrokeCap.scRound) then
    Result := Max(Ceil(FThickness * Pi / 4.0), 2)
  else
    Result := 0;
end;

procedure TStrokeBuilder.GetDashEstimate(out VertexCount, IndexCount: Integer);
var
  Divisions: Integer;
begin
  case FBrush.Cap of
    TStrokeCap.scRound:
      begin
        Divisions := GetCapDivisions();

        VertexCount := 6 + Divisions * 2;
        IndexCount := 6 + (Divisions + 1) * 6;
      end;

  else
    begin
      VertexCount := 4;
      IndexCount := 6;
    end;
  end;
end;

procedure TStrokeBuilder.InsertDash(SrcPos, DestPos: TPointF; const DashDirVec, ThickPerp: TPointF);
var
  InitIndex, DivIndex, Divisions: Integer;
  SinValue, CosValue: Single;
  RoundShift: TPointF;
begin
  if (FBrush.Cap = TStrokeCap.scRound) then
  begin
    RoundShift := DashDirVec.Scale(FHalfThickness);

    SrcPos := SrcPos + RoundShift;
    DestPos := DestPos - RoundShift;
  end;

  InitIndex := FCurrentVertex;

  InsertVertex(SrcPos + ThickPerp, FStrokeColor);
  InsertVertex(DestPos + ThickPerp, FStrokeColor);
  InsertVertex(DestPos - ThickPerp, FStrokeColor);
  InsertVertex(SrcPos - ThickPerp, FStrokeColor);

  InsertIndex(InitIndex + 0);
  InsertIndex(InitIndex + 1);
  InsertIndex(InitIndex + 2);
  InsertIndex(InitIndex + 2);
  InsertIndex(InitIndex + 3);
  InsertIndex(InitIndex + 0);

  if (FBrush.Cap = TStrokeCap.scRound) then
  begin
    InsertVertex(SrcPos, FStrokeColor);
    InsertVertex(DestPos, FStrokeColor);

    Divisions := GetCapDivisions();

    for DivIndex := 0 to Divisions - 1 do
    begin
      SinCos((DivIndex + 1) * Pi / (Divisions + 1), SinValue, CosValue);

      InsertVertex(PointF(SrcPos.X + ThickPerp.X * CosValue - ThickPerp.Y * SinValue, SrcPos.Y + ThickPerp.X * SinValue + ThickPerp.Y *
        CosValue), FStrokeColor);
    end;

    for DivIndex := 0 to Divisions - 1 do
    begin
      SinCos((DivIndex + 1) * Pi / (Divisions + 1), SinValue, CosValue);

      InsertVertex(PointF(DestPos.X + ThickPerp.Y * SinValue - ThickPerp.X * CosValue,
        DestPos.Y - (ThickPerp.X * SinValue + ThickPerp.Y * CosValue)), FStrokeColor);
    end;

    InsertIndex(InitIndex + 4);
    InsertIndex(InitIndex + 0);
    InsertIndex(InitIndex + 6);

    InsertIndex(InitIndex + 4);
    InsertIndex(InitIndex + 5 + Divisions);
    InsertIndex(InitIndex + 3);

    for DivIndex := 0 to Divisions - 2 do
    begin
      InsertIndex(InitIndex + 4);
      InsertIndex(InitIndex + 6 + DivIndex);
      InsertIndex(InitIndex + 7 + DivIndex);
    end;

    InsertIndex(InitIndex + 2);
    InsertIndex(InitIndex + 6 + Divisions);
    InsertIndex(InitIndex + 5);

    InsertIndex(InitIndex + 5);
    InsertIndex(InitIndex + 5 + Divisions * 2);
    InsertIndex(InitIndex + 1);

    for DivIndex := 0 to Divisions - 2 do
    begin
      InsertIndex(InitIndex + 5);
      InsertIndex(InitIndex + 6 + Divisions + DivIndex);
      InsertIndex(InitIndex + 7 + Divisions + DivIndex);
    end;
  end;
end;

procedure TStrokeBuilder.GetDotEstimate(out VertexCount, IndexCount: Integer);
var
  Divisions: Integer;
begin
  case FBrush.Cap of
    TStrokeCap.scRound:
      begin
        Divisions := GetCapDivisions();

        VertexCount := 3 + Divisions * 2;
        IndexCount := (Divisions + 1) * 6;
      end;

  else
    begin
      VertexCount := 4;
      IndexCount := 6;
    end;
  end;
end;

procedure TStrokeBuilder.InsertDot(const MidPos, DotDirVec, ThickPerp: TPointF);
var
  InitIndex, DivIndex, Divisions: Integer;
  SinValue, CosValue: Single;
  DotParShift: TPointF;
begin
  InitIndex := FCurrentVertex;

  if (FBrush.Cap = TStrokeCap.scFlat) then
  begin
    DotParShift := DotDirVec.Scale(FHalfThickness);

    InsertVertex(MidPos + ThickPerp - DotParShift, FStrokeColor);
    InsertVertex(MidPos + DotParShift + ThickPerp, FStrokeColor);
    InsertVertex(MidPos + DotParShift - ThickPerp, FStrokeColor);
    InsertVertex(MidPos - (ThickPerp + DotParShift), FStrokeColor);

    InsertIndex(InitIndex + 0);
    InsertIndex(InitIndex + 1);
    InsertIndex(InitIndex + 2);
    InsertIndex(InitIndex + 2);
    InsertIndex(InitIndex + 3);
    InsertIndex(InitIndex + 0);
  end
  else
  begin
    InsertVertex(MidPos, FStrokeColor);

    Divisions := 2 + GetCapDivisions() * 2;

    for DivIndex := 0 to Divisions - 1 do
    begin
      SinCos(DivIndex * (Pi * 2.0) / Divisions, SinValue, CosValue);

      InsertVertex(PointF(MidPos.X + ThickPerp.X * CosValue - ThickPerp.Y * SinValue, MidPos.Y + ThickPerp.X * SinValue + ThickPerp.Y *
        CosValue), FStrokeColor);
    end;

    for DivIndex := 0 to Divisions - 1 do
    begin
      InsertIndex(InitIndex);
      InsertIndex(InitIndex + 1 + DivIndex);
      InsertIndex(InitIndex + 1 + ((DivIndex + 1) mod Divisions));
    end;
  end;
end;

function TStrokeBuilder.GetPatternStepCount(): Integer;
begin
  case FBrush.Dash of
    TStrokeDash.sdSolid, TStrokeDash.sdCustom:
      Result := 1;

    TStrokeDash.sdDash:
      Result := 4;

    TStrokeDash.sdDot:
      Result := 2;

    TStrokeDash.sdDashDot:
      Result := 6;

    TStrokeDash.sdDashDotDot:
      Result := 8;

  else
    Result := 0;
  end;
end;

procedure TStrokeBuilder.ComputeBuildEstimates(const TentSegmentCount: Single; out VertexCount, IndexCount: Integer);
var
  PieceVertices, PieceIndices, FloorSegmentCount, CeilSegmentCount: Integer;
begin
  FExtraPieces := 0;
  FLastDashExtend := False;

  FLastSegmentFraction := Frac(TentSegmentCount);

  FloorSegmentCount := Floor(TentSegmentCount);
  CeilSegmentCount := Ceil(TentSegmentCount);

  case FBrush.Dash of
    TStrokeDash.sdSolid, TStrokeDash.sdCustom:
      begin
        FSegmentCount := 1;
        GetDashEstimate(VertexCount, IndexCount);
      end;

    TStrokeDash.sdDash:
      begin
        FSegmentCount := FloorSegmentCount;

        if (FLastSegmentFraction >= 0.25) then
        begin
          FSegmentCount := CeilSegmentCount;
          FLastDashExtend := (CeilSegmentCount <> FloorSegmentCount) and (FLastSegmentFraction < 0.75);
        end;

        GetDashEstimate(PieceVertices, PieceIndices);

        VertexCount := PieceVertices * FSegmentCount;
        IndexCount := PieceIndices * FSegmentCount;
      end;

    TStrokeDash.sdDot:
      begin
        FSegmentCount := Round(TentSegmentCount);

        GetDotEstimate(PieceVertices, PieceIndices);

        VertexCount := PieceVertices * FSegmentCount;
        IndexCount := PieceIndices * FSegmentCount;
      end;

    TStrokeDash.sdDashDot:
      begin
        FSegmentCount := FloorSegmentCount;

        if (FLastSegmentFraction >= 1.0 / 6.0) then
        begin
          FSegmentCount := CeilSegmentCount;
          FLastDashExtend := (CeilSegmentCount <> FloorSegmentCount) and (FLastSegmentFraction < 0.5);
        end
        else
          FLastSegmentFraction := 1.0;

        GetDashEstimate(PieceVertices, PieceIndices);
        VertexCount := PieceVertices * FSegmentCount;
        IndexCount := PieceIndices * FSegmentCount;

        GetDotEstimate(PieceVertices, PieceIndices);

        if (FSegmentCount > 1) then
        begin
          Inc(VertexCount, PieceVertices * (FSegmentCount - 1));
          Inc(IndexCount, PieceIndices * (FSegmentCount - 1));
        end;

        if (FLastSegmentFraction >= 5.0 / 6.0) then
        begin
          Inc(VertexCount, PieceVertices);
          Inc(IndexCount, PieceIndices);
          Inc(FExtraPieces);
        end;
      end;

    TStrokeDash.sdDashDotDot:
      begin
        FSegmentCount := FloorSegmentCount;

        if (FLastSegmentFraction >= 1.0 / 8.0) then
        begin
          FSegmentCount := CeilSegmentCount;
          FLastDashExtend := (CeilSegmentCount <> FloorSegmentCount) and (FLastSegmentFraction < 3.0 / 8.0);
        end
        else
          FLastSegmentFraction := 1.0;

        GetDashEstimate(PieceVertices, PieceIndices);
        VertexCount := PieceVertices * FSegmentCount;
        IndexCount := PieceIndices * FSegmentCount;

        GetDotEstimate(PieceVertices, PieceIndices);

        if (FSegmentCount > 1) then
        begin
          Inc(VertexCount, PieceVertices * (FSegmentCount - 1) * 2);
          Inc(IndexCount, PieceIndices * (FSegmentCount - 1) * 2);
        end;

        if (FLastSegmentFraction >= 7.0 / 8.0) then
        begin
          Inc(VertexCount, PieceVertices * 2);
          Inc(IndexCount, PieceIndices * 2);
          Inc(FExtraPieces, 2);
        end
        else if (FLastSegmentFraction >= 5.0 / 8.0) then
        begin
          Inc(VertexCount, PieceVertices);
          Inc(IndexCount, PieceIndices);
          Inc(FExtraPieces);
        end;
      end;
  end;
end;

procedure TStrokeBuilder.InsertSegment(const SegmentPos, SegDirVec, ThickPerp, DestPos: TPointF; IsLast: Boolean);
var
  PieceTail: TPointF;
begin
  case FBrush.Dash of
    TStrokeDash.sdSolid, TStrokeDash.sdCustom:
      InsertDash(SegmentPos, DestPos, SegDirVec, ThickPerp);

    TStrokeDash.sdDash:
      begin
        if (IsLast) and (FLastDashExtend) then
          PieceTail := DestPos
        else
          PieceTail := SegmentPos + SegDirVec.Scale(FThickness * 3.0);

        InsertDash(SegmentPos, PieceTail, SegDirVec, ThickPerp);
      end;

    TStrokeDash.sdDot:
      InsertDot(SegmentPos + SegDirVec.Scale(FHalfThickness), SegDirVec, ThickPerp);

    TStrokeDash.sdDashDot:
      begin
        if (IsLast) and (FLastDashExtend) then
          PieceTail := DestPos
        else
          PieceTail := SegmentPos + SegDirVec.Scale(FThickness * 3.0);

        InsertDash(SegmentPos, PieceTail, SegDirVec, ThickPerp);

        if (not IsLast) or (FExtraPieces > 0) then
          InsertDot(SegmentPos + SegDirVec.Scale(FThickness * 4.5), SegDirVec, ThickPerp);
      end;

    TStrokeDash.sdDashDotDot:
      begin
        if (IsLast) and (FLastDashExtend) then
          PieceTail := DestPos
        else
          PieceTail := SegmentPos + SegDirVec.Scale(FThickness * 3.0);

        InsertDash(SegmentPos, PieceTail, SegDirVec, ThickPerp);

        if (not IsLast) or (FExtraPieces > 0) then
          InsertDot(SegmentPos + SegDirVec.Scale(FThickness * 4.5), SegDirVec, ThickPerp);

        if (not IsLast) or (FExtraPieces > 1) then
          InsertDot(SegmentPos + SegDirVec.Scale(FThickness * 6.5), SegDirVec, ThickPerp);
      end;
  end;
end;

procedure TStrokeBuilder.BuildLine(const SrcPos, DestPos: TPointF; const Opacity: Single);
var
  FinalSrcPos, FinalDestPos, PiecePos, StepDelta, ThickPerp: TPointF;
  PieceDirVec, CurScale: TPointF;
  StepSize, PiecesCount: Single;
  StepIndex, LastStepIndex, PatternStepCount: Integer;
  LineLength: Single;
  TotalVertices, TotalIndices: Integer;
begin
  CurScale := GetMatrixScale();

  FThickness := FBrush.Thickness * (CurScale.X + CurScale.Y) * 0.5;
  FHalfThickness := FThickness * 0.5;
  FStrokeColor := PremultiplyAlpha(MakeColor(FBrush.Color, Opacity));
  FUndeterminedMode := False;

  FinalSrcPos := Matrix.Transform(SrcPos);
  FinalDestPos := Matrix.Transform(DestPos);
  LineLength := FinalSrcPos.Distance(FinalDestPos);

  PieceDirVec := (FinalDestPos - FinalSrcPos).Normalize();

  PatternStepCount := GetPatternStepCount();

  if (PatternStepCount > 0) then
    StepSize := FThickness * PatternStepCount
  else
    StepSize := LineLength;

  StepDelta := PieceDirVec.Scale(StepSize);

  PiecePos := FinalSrcPos;
  ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FThickness * 0.5);

  PiecesCount := LineLength / StepSize;

  ComputeBuildEstimates(PiecesCount, TotalVertices, TotalIndices);
  if (FSegmentCount < 1) or (LineLength < FThickness) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  LastStepIndex := FSegmentCount - 1;

  InitArrays(TotalVertices, TotalIndices);

  for StepIndex := 0 to LastStepIndex do
  begin
    InsertSegment(PiecePos, PieceDirVec, ThickPerp, FinalDestPos, StepIndex >= LastStepIndex);
    PiecePos := PiecePos + StepDelta;
  end;

  ArrayFillCheck();
end;

function TStrokeBuilder.GetEllipseTransfAt(const Delta: Single): TPointF;
var
  Angle, CosAngle, SinAngle: Single;
  SampleAt: TPointF;
begin
  Angle := Delta * 2.0 * Pi / FEllipseCircumf;

  SinCos(Angle, SinAngle, CosAngle);

  SampleAt.X := FEllipseCenter.X + CosAngle * FEllipseRadius.X;
  SampleAt.Y := FEllipseCenter.Y - SinAngle * FEllipseRadius.Y;

  Result := FMatrix.Transform(SampleAt);
end;

procedure TStrokeBuilder.InsertEllipseSegment(const SegInitDist: Single; IsLast: Boolean);
var
  TempDelta: Single;
  SegSrcPos, SegDestPos, SegDirVec, ThickPerp: TPointF;
begin
  case FBrush.Dash of
    TStrokeDash.sdDash:
      begin
        SegSrcPos := GetEllipseTransfAt(SegInitDist);

        if (IsLast) and (FLastDashExtend) then
          TempDelta := FEllipseCircumf
        else
          TempDelta := SegInitDist + FThickness * 3.0;

        SegDestPos := GetEllipseTransfAt(TempDelta);

        SegDirVec := (SegDestPos - SegSrcPos).Normalize();
        ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

        InsertDash(SegSrcPos, SegDestPos, SegDirVec, ThickPerp);
      end;

    TStrokeDash.sdDot:
      begin
        TempDelta := SegInitDist + FHalfThickness;

        SegSrcPos := GetEllipseTransfAt(TempDelta);

        SegDirVec := (GetEllipseTransfAt(TempDelta + FHalfThickness) - GetEllipseTransfAt(TempDelta - FHalfThickness)).Normalize();
        ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

        InsertDot(SegSrcPos, SegDirVec, ThickPerp);
      end;

    TStrokeDash.sdDashDot:
      begin
        SegSrcPos := GetEllipseTransfAt(SegInitDist);

        if (IsLast) and (FLastDashExtend) then
          TempDelta := FEllipseCircumf
        else
          TempDelta := SegInitDist + FThickness * 3.0;

        SegDestPos := GetEllipseTransfAt(TempDelta);

        SegDirVec := (SegDestPos - SegSrcPos).Normalize();
        ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

        InsertDash(SegSrcPos, SegDestPos, SegDirVec, ThickPerp);

        if (not IsLast) or (FExtraPieces > 0) then
        begin
          TempDelta := SegInitDist + FThickness * 4.5;

          SegSrcPos := GetEllipseTransfAt(TempDelta);

          SegDirVec := (GetEllipseTransfAt(TempDelta + FHalfThickness) - GetEllipseTransfAt(TempDelta - FHalfThickness)).Normalize();
          ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

          InsertDot(SegSrcPos, SegDirVec, ThickPerp);
        end;
      end;

    TStrokeDash.sdDashDotDot:
      begin
        SegSrcPos := GetEllipseTransfAt(SegInitDist);

        if (IsLast) and (FLastDashExtend) then
          TempDelta := FEllipseCircumf
        else
          TempDelta := SegInitDist + FThickness * 3.0;

        SegDestPos := GetEllipseTransfAt(TempDelta);

        SegDirVec := (SegDestPos - SegSrcPos).Normalize();
        ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

        InsertDash(SegSrcPos, SegDestPos, SegDirVec, ThickPerp);

        if (not IsLast) or (FExtraPieces > 0) then
        begin
          TempDelta := SegInitDist + FThickness * 4.5;

          SegSrcPos := GetEllipseTransfAt(TempDelta);

          SegDirVec := (GetEllipseTransfAt(TempDelta + FHalfThickness) - GetEllipseTransfAt(TempDelta - FHalfThickness)).Normalize();
          ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

          InsertDot(SegSrcPos, SegDirVec, ThickPerp);
        end;

        if (not IsLast) or (FExtraPieces > 1) then
        begin
          TempDelta := SegInitDist + FThickness * 6.5;

          SegSrcPos := GetEllipseTransfAt(TempDelta);

          SegDirVec := (GetEllipseTransfAt(TempDelta + FHalfThickness) - GetEllipseTransfAt(TempDelta - FHalfThickness)).Normalize();
          ThickPerp := PointF(-SegDirVec.Y, SegDirVec.X).Scale(FHalfThickness);

          InsertDot(SegSrcPos, SegDirVec, ThickPerp);
        end;
      end;
  end;
end;

procedure TStrokeBuilder.BuildIntermEllipse(const Center, Radius: TPointF; const Opacity: Single);
var
  MajorAxis, MinorAxis, AxisSum, AxisSub, SubDivSumSq3: Single;
  StepSize, TentSegmentCount, SegInitDist: Single;
  CurScale: TPointF;
  PatternStepCount, TotalVertices, TotalIndices, StepIndex: Integer;
begin
  CurScale := GetMatrixScale();

  FThickness := FBrush.Thickness * (CurScale.X + CurScale.Y) * 0.5;
  FHalfThickness := FThickness * 0.5;
  FStrokeColor := PremultiplyAlpha(MakeColor(FBrush.Color, Opacity));
  FUndeterminedMode := False;

  FEllipseCenter := Center;
  FEllipseRadius := Radius;
  FEllipseTransfCenter := FMatrix.Transform(Center);

  if (Radius.X > Radius.Y) then
  begin
    MajorAxis := Radius.X * CurScale.X;
    MinorAxis := Radius.Y * CurScale.Y;
  end
  else
  begin
    MajorAxis := Radius.Y * CurScale.Y;
    MinorAxis := Radius.X * CurScale.X;
  end;

  AxisSum := MajorAxis + MinorAxis;
  AxisSub := MajorAxis - MinorAxis;

  if (AxisSum <= 0.0) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  SubDivSumSq3 := 3.0 * Sqr(AxisSub / AxisSum);

  FEllipseCircumf := Pi * AxisSum * (1.0 + (SubDivSumSq3 / (10.0 + Sqrt(4.0 - SubDivSumSq3))));

  PatternStepCount := GetPatternStepCount();
  if (PatternStepCount < 1) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  StepSize := FThickness * PatternStepCount;
  TentSegmentCount := FEllipseCircumf / StepSize;

  ComputeBuildEstimates(TentSegmentCount, TotalVertices, TotalIndices);
  if (FSegmentCount < 1) or (FEllipseCircumf < FThickness) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  InitArrays(TotalVertices, TotalIndices);

  SegInitDist := 0.0;

  for StepIndex := 0 to FSegmentCount - 1 do
  begin
    InsertEllipseSegment(SegInitDist, StepIndex = FSegmentCount - 1);
    SegInitDist := SegInitDist + StepSize;
  end;

  ArrayFillCheck();
end;

procedure TStrokeBuilder.BuildSolidEllipse(const Center, Radius: TPointF; const Opacity: Single);
var
  MajorAxis, MinorAxis, AxisSum, AxisSub, SubDivSumSq3: Single;
  StepSize, HalfStepSize, SegInitDist: Single;
  CurScale, SampleAt, SampleDirVec, ThickPerp: TPointF;
  TotalVertices, TotalIndices, StepIndex: Integer;
begin
  CurScale := GetMatrixScale();

  FThickness := FBrush.Thickness * (CurScale.X + CurScale.Y) * 0.5;
  FHalfThickness := FThickness * 0.5;
  FStrokeColor := PremultiplyAlpha(MakeColor(FBrush.Color, Opacity));
  FUndeterminedMode := False;

  FEllipseCenter := Center;
  FEllipseRadius := Radius;
  FEllipseTransfCenter := FMatrix.Transform(Center);

  if (Radius.X > Radius.Y) then
  begin
    MajorAxis := Radius.X * CurScale.X;
    MinorAxis := Radius.Y * CurScale.Y;
  end
  else
  begin
    MajorAxis := Radius.Y * CurScale.Y;
    MinorAxis := Radius.X * CurScale.X;
  end;

  AxisSum := MajorAxis + MinorAxis;
  AxisSub := MajorAxis - MinorAxis;

  if (AxisSum <= 0.0) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  SubDivSumSq3 := 3.0 * Sqr(AxisSub / AxisSum);

  FEllipseCircumf := Pi * AxisSum * (1.0 + (SubDivSumSq3 / (10.0 + Sqrt(4.0 - SubDivSumSq3))));

  StepSize := FEllipseCircumf / Max(Sqrt(FEllipseCircumf) * 2.0, 8);
  HalfStepSize := StepSize * 0.5;

  FSegmentCount := Round(FEllipseCircumf / StepSize);

  if (FSegmentCount < 1) or (FEllipseCircumf < FThickness) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  TotalVertices := FSegmentCount * 2;
  TotalIndices := FSegmentCount * 6;

  InitArrays(TotalVertices, TotalIndices);

  SegInitDist := 0.0;

  for StepIndex := 0 to FSegmentCount - 1 do
  begin
    SampleAt := GetEllipseTransfAt(SegInitDist);

    SampleDirVec := (GetEllipseTransfAt(SegInitDist + HalfStepSize) - GetEllipseTransfAt(SegInitDist - HalfStepSize)).Normalize();
    ThickPerp := PointF(-SampleDirVec.Y, SampleDirVec.X).Scale(FHalfThickness);

    InsertVertex(SampleAt - ThickPerp, FStrokeColor);
    InsertVertex(SampleAt + ThickPerp, FStrokeColor);

    InsertIndex((StepIndex * 2 + 3) mod TotalVertices);
    InsertIndex((StepIndex * 2 + 1) mod TotalVertices);
    InsertIndex(StepIndex * 2);

    InsertIndex(StepIndex * 2);
    InsertIndex((StepIndex * 2 + 2) mod TotalVertices);
    InsertIndex((StepIndex * 2 + 3) mod TotalVertices);

    SegInitDist := SegInitDist + StepSize;
  end;

  ArrayFillCheck();
end;

procedure TStrokeBuilder.BuildIntermPath(const Path: TPathData; const Opacity: Single);
var
  Polygon: TPolygon;
  StepSize, Distance: Single;
  CurScale, SrcPos, DestPos, PieceDirVec, ThickPerp: TPointF;
  SrcPosValid, DestPosValid: Boolean;
  PatternStepCount, CurIndex, TempVertexCount, TempIndexCount: Integer;
begin
  Path.FlattenToPolygon(Polygon, 1.0);
  if (Length(Polygon) < 2) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  CurScale := GetMatrixScale();

  FThickness := FBrush.Thickness * (CurScale.X + CurScale.Y) * 0.5;
  FHalfThickness := FThickness * 0.5;
  FStrokeColor := PremultiplyAlpha(MakeColor(FBrush.Color, Opacity));

  FUndeterminedMode := True;
  InitArrayPointers();

  PatternStepCount := GetPatternStepCount();
  if (PatternStepCount < 1) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  StepSize := FThickness * PatternStepCount;

  CurIndex := 0;

  SrcPosValid := False;
  DestPosValid := False;

  while (CurIndex < Length(Polygon)) do
  begin
    if (CurIndex >= Length(Polygon) - 1) and (Path.Count > 0) and (Path[Path.Count - 1].Kind <> TPathPointKind.ppClose) then
      Break;

    if (not SrcPosValid) then
    begin
      SrcPos := Polygon[CurIndex];

      if (SrcPos.X >= $FFFF) or (SrcPos.Y >= $FFFF) then
      begin
        DestPosValid := False;
        Inc(CurIndex);
        Continue;
      end;

      SrcPos := FMatrix.Transform(SrcPos);
    end
    else
      SrcPosValid := False;

    if (not DestPosValid) then
    begin
      DestPos := Polygon[(CurIndex + 1) mod Length(Polygon)];

      if (DestPos.X >= $FFFF) or (DestPos.Y >= $FFFF) then
      begin
        DestPos := Polygon[CurIndex];
        if (DestPos.X >= $FFFF) or (DestPos.Y >= $FFFF) then
        begin
          Inc(CurIndex);
          Continue;
        end;

        DestPos := FMatrix.Transform(DestPos);
      end
      else
        DestPos := FMatrix.Transform(DestPos);
    end
    else
      DestPosValid := False;

    Distance := DestPos.Distance(SrcPos);

    if (Distance >= StepSize) then
    begin
      PieceDirVec := (DestPos - SrcPos).Normalize();
      ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FHalfThickness);

      InsertSegment(SrcPos, PieceDirVec, ThickPerp, DestPos, False);

      SrcPos := SrcPos + PieceDirVec.Scale(StepSize);

      SrcPosValid := True;
      DestPosValid := True;
      Continue;
    end;

    if (CurIndex = Length(Polygon) - 1) or (Polygon[CurIndex + 1].X >= $FFFF) or (Polygon[CurIndex + 1].Y >= $FFFF) or
      ((CurIndex < Length(Polygon) - 2) and (Polygon[CurIndex + 1].X < $FFFF) and (Polygon[CurIndex + 1].Y < $FFFF) and
      (Polygon[CurIndex + 2].X < $FFFF) and (Polygon[CurIndex + 2].Y < $FFFF) and
      (Polygon[CurIndex + 1].Distance(Polygon[CurIndex + 2]) > StepSize)) then
    begin
      ComputeBuildEstimates(1.0 + Distance / StepSize, TempVertexCount, TempIndexCount);

      if (FSegmentCount > 1) then
      begin
        PieceDirVec := (DestPos - SrcPos).Normalize();
        ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FHalfThickness);

        InsertSegment(SrcPos, PieceDirVec, ThickPerp, DestPos, True);
      end;

      if (CurIndex < Length(Polygon) - 1) then
      begin
        Inc(CurIndex);
        Continue;
      end
      else
        Break;
    end;

    SrcPosValid := True;
    Inc(CurIndex);
  end;

  FinalizeArrays();
end;

procedure TStrokeBuilder.BuildSolidPath(const Path: TPathData; const Opacity: Single);
var
  Polygon: TPolygon;
  StepSize, Distance: Single;
  CurScale, SrcPos, DestPos, PieceDirVec, ThickPerp: TPointF;
  SrcPosValid, DestPosValid, PrevVerticesPlaced: Boolean;
  CurIndex: Integer;
begin
  Path.FlattenToPolygon(Polygon, 1.0);
  if (Length(Polygon) < 2) then
  begin
    InitArrays(0, 0);
    Exit;
  end;

  CurScale := GetMatrixScale();

  FThickness := FBrush.Thickness * (CurScale.X + CurScale.Y) * 0.5;
  FHalfThickness := FThickness * 0.5;
  FStrokeColor := PremultiplyAlpha(MakeColor(FBrush.Color, Opacity));

  FUndeterminedMode := True;
  InitArrayPointers();

  StepSize := FThickness;
  if (StepSize < 2.0) then
    StepSize := 2.0;

  CurIndex := 0;

  SrcPosValid := False;
  DestPosValid := False;
  PrevVerticesPlaced := False;

  while (CurIndex < Length(Polygon)) do
  begin
    if (CurIndex >= Length(Polygon) - 1) and (Path.Count > 0) and (Path[Path.Count - 1].Kind <> TPathPointKind.ppClose) then
      Break;

    if (not SrcPosValid) then
    begin
      SrcPos := Polygon[CurIndex];

      if (SrcPos.X >= $FFFF) or (SrcPos.Y >= $FFFF) then
      begin
        DestPosValid := False;
        PrevVerticesPlaced := False;
        Inc(CurIndex);
        Continue;
      end;

      SrcPos := FMatrix.Transform(SrcPos);
    end
    else
      SrcPosValid := False;

    if (not DestPosValid) then
    begin
      DestPos := Polygon[(CurIndex + 1) mod Length(Polygon)];

      if (DestPos.X >= $FFFF) or (DestPos.Y >= $FFFF) then
      begin
        DestPos := Polygon[CurIndex];
        if (DestPos.X >= $FFFF) or (DestPos.Y >= $FFFF) then
        begin
          PrevVerticesPlaced := False;
          Inc(CurIndex);
          Continue;
        end;

        DestPos := FMatrix.Transform(DestPos);
      end
      else
        DestPos := FMatrix.Transform(DestPos);
    end
    else
      DestPosValid := False;

    Distance := DestPos.Distance(SrcPos);

    if (Distance >= StepSize) then
    begin
      PieceDirVec := (DestPos - SrcPos).Normalize();
      ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FHalfThickness);

      InsertVertex(SrcPos - ThickPerp, FStrokeColor);
      InsertVertex(SrcPos + ThickPerp, FStrokeColor);

      if (PrevVerticesPlaced) then
      begin
        InsertIndex(FCurrentVertex - 3);
        InsertIndex(FCurrentVertex - 1);
        InsertIndex(FCurrentVertex - 2);

        InsertIndex(FCurrentVertex - 2);
        InsertIndex(FCurrentVertex - 4);
        InsertIndex(FCurrentVertex - 3);
      end;

      PrevVerticesPlaced := True;

      SrcPos := SrcPos + PieceDirVec.Scale(StepSize);

      SrcPosValid := True;
      DestPosValid := True;
      Continue;
    end;

    if ((CurIndex < Length(Polygon) - 2) and (Polygon[CurIndex + 1].X < $FFFF) and (Polygon[CurIndex + 1].Y < $FFFF) and
      (Polygon[CurIndex + 2].X < $FFFF) and (Polygon[CurIndex + 2].Y < $FFFF) and
      (Polygon[CurIndex + 1].Distance(Polygon[CurIndex + 2]) > StepSize)) then
    begin
      PieceDirVec := (DestPos - SrcPos).Normalize();
      ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FHalfThickness);

      InsertVertex(DestPos - ThickPerp, FStrokeColor);
      InsertVertex(DestPos + ThickPerp, FStrokeColor);

      if (PrevVerticesPlaced) then
      begin
        InsertIndex(FCurrentVertex - 3);
        InsertIndex(FCurrentVertex - 1);
        InsertIndex(FCurrentVertex - 2);

        InsertIndex(FCurrentVertex - 2);
        InsertIndex(FCurrentVertex - 4);
        InsertIndex(FCurrentVertex - 3);
      end;

      if (CurIndex < Length(Polygon) - 1) then
      begin
        Inc(CurIndex);
        Continue;
      end
      else
        Break;
    end;

    if (CurIndex = Length(Polygon) - 1) or (Polygon[CurIndex + 1].X >= $FFFF) or (Polygon[CurIndex + 1].Y >= $FFFF) then
    begin
      PieceDirVec := (DestPos - SrcPos).Normalize();
      ThickPerp := PointF(-PieceDirVec.Y, PieceDirVec.X).Scale(FHalfThickness);

      InsertVertex(DestPos - ThickPerp, FStrokeColor);
      InsertVertex(DestPos + ThickPerp, FStrokeColor);

      if (PrevVerticesPlaced) then
      begin
        InsertIndex(FCurrentVertex - 3);
        InsertIndex(FCurrentVertex - 1);
        InsertIndex(FCurrentVertex - 2);

        InsertIndex(FCurrentVertex - 2);
        InsertIndex(FCurrentVertex - 4);
        InsertIndex(FCurrentVertex - 3);
      end;

      PrevVerticesPlaced := False;

      if (CurIndex < Length(Polygon) - 1) then
      begin
        Inc(CurIndex);
        Continue;
      end
      else
        Break;
    end;

    SrcPosValid := True;
    Inc(CurIndex);
  end;

  FinalizeArrays();
end;

{$ENDREGION}

end.
