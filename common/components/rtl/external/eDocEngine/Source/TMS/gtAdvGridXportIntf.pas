{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

unit gtAdvGridXportIntf;

interface

uses
  Windows, Classes, Graphics, gtXportIntf, gtCstDocEng, Grids, AdvGrid;

type

  TgtPrintOrder = (poHorizontal, poVertical);

  TgtCellRange = (crAll, crVisible, crSelected);

  TgtHackAdvStringGrid = class(TAdvStringGrid)
  public
    procedure DrawGridCell(Canvas:TCanvas; ACol, ARow: Longint; ARect:TRect;
      AState: TGridDrawState); override;
  end;

  TgtExportOptions = class(TPersistent)
  Private
    FMaxRowsPerPage: Integer;
    FMaxColsPerPage: Integer;
    FPrintOrder: TgtPrintOrder;
    FRepeatRowHeader: Boolean;
    FRepeatColHeader: Boolean;
    FExportColHeader: Boolean;
    FExportRowHeader: Boolean;
    FRowRange: TgtCellRange;
    FColRange: TgtCellRange;
    FDrawGridLines: Boolean;
    procedure SetMaxRowsPerPage(const Value: Integer);
    procedure SetPrintOrder(const Value: TgtPrintOrder);
    procedure SetColRange(const Value: TgtCellRange);
    procedure SetExportColHeader(const Value: Boolean);
    procedure SetExportRowHeader(const Value: Boolean);
    procedure SetRepeatColHeader(const Value: Boolean);
    procedure SetRepeatRowHeader(const Value: Boolean);
    procedure SetRowRange(const Value: TgtCellRange);
    procedure SetMaxColsPerPage(const Value: Integer);
    procedure SetDrawGridLines(const Value: Boolean);
  public
     constructor Create;
  published
    property MaxRowsPerPage: Integer read FMaxRowsPerPage
      write SetMaxRowsPerPage default 0;
    property MaxColsPerPage: Integer read FMaxColsPerPage
      write SetMaxColsPerPage default 0;
    property PrintOrder: TgtPrintOrder read FPrintOrder write SetPrintOrder
      default poHorizontal;
    property ExportColHeader: Boolean read FExportColHeader
      write SetExportColHeader default True;
    property ExportRowHeader: Boolean read FExportRowHeader
      write SetExportRowHeader default True;
    property RepeatColHeader: Boolean read FRepeatColHeader
      write SetRepeatColHeader default True;
    property RepeatRowHeader: Boolean read FRepeatRowHeader
      write SetRepeatRowHeader default True;
    property RowRange: TgtCellRange read FRowRange write SetRowRange
      default crAll;
    property ColRange: TgtCellRange read FColRange write SetColRange
      default crAll;
    property DrawGridLines: Boolean read FDrawGridLines write SetDrawGridLines
      default True;
  end;

	TgtAdvGridExportInterface = class(TgtExportInterface)
  private
    FExportOptions: TgtExportOptions;
    FGrid: TAdvStringGrid;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
    procedure SetVisible(const Value: Boolean);
    procedure SetExportOptions(const Value: TgtExportOptions);
    procedure SetGrid(const Value: TAdvStringGrid);
  public
  	constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RenderDocument(AFileName: String);
    procedure PrintRowHeader(StartRow: Integer; EndRow: Integer; IsCol: Boolean);
    procedure PrintColHeader(StartCol: Integer; EndCol: Integer; IsRow: Boolean);
    procedure PrintValues(StartRow: Integer; EndRow: Integer;StartCol: Integer;
      EndCol: Integer; ExportRow, ExportCol: Boolean);
  published
  	property Engine write SetEngine;
    property Visible write SetVisible;
    property Grid: TAdvStringGrid read FGrid write SetGrid;
    property ExportOptions: TgtExportOptions read FExportOptions
      write SetExportOptions;
  end;

procedure Register;

implementation

type
  TgtIntegerArray = array of Integer;

{ TgtAdvGridExportInterface }

constructor TgtAdvGridExportInterface.Create(AOwner: TComponent);
begin
  inherited;
  FExportOptions := TgtExportOptions.Create;
end;

destructor TgtAdvGridExportInterface.Destroy;
begin
  FExportOptions.Free;
  inherited;
end;

procedure TgtAdvGridExportInterface.RenderDocument(AFileName: String);
var
  I, J: Integer;
  ColumnCount, RowCount, StartCol, StartRow, EndCol, EndRow :Integer;
  ColStart, ColEnd, RowStart, RowEnd: TgtIntegerArray;
  ExportRow, ExportCol, RepeatCol, RepeatRow: Boolean;
  LUnits: TgtUnitType;

  procedure StorePageLimits(AStart, AEnd: Integer; AMaxValue: Double;
    var AStartArr, AEndArr: TgtIntegerArray; AIsRow: Boolean);
  var
    Sum: Double;
    SR, ER, SumFlag, Count: Integer;
    LI, RCCount, RowColCount: Integer;
  begin
    RCCount := 0;
    Sum := 0;
    RowColCount := FExportOptions.MaxColsPerPage;
    if(FExportOptions.ExportRowHeader and FExportOptions.ExportColHeader) then
    if (AIsRow = True) then
      Sum := Grid.RowHeights[0]
    else
      Sum := Grid.ColWidths[0];

    if (AIsRow = True) then
    begin
      RowColCount := FExportOptions.MaxRowsPerPage;
    end;
    if (RowColCount = 0) then
    begin
      SR := AStart;
      ER := AEnd;
      SumFlag := 0;
      Count := -1;
      for LI := AStart to AEnd do
      begin
        if (AIsRow = True) then
          Sum :=Sum + Grid.RowHeights[LI]
        else
          Sum := Sum + Grid.ColWidths[LI];
        if (Sum > AMaxValue) then
        begin
          Inc(Count);
          SetLength(AStartArr, Count + 1);
          SetLength(AEndArr, Count + 1);
          SumFlag := 1;
          if (AIsRow = True) then
            Sum := Grid.RowHeights[LI]
          else
            Sum :=  Grid.ColWidths[LI];
          if (FExportOptions.ExportRowHeader and
              FExportOptions.ExportColHeader) then
            if (FExportOptions.RepeatRowHeader
                and FExportOptions.RepeatColHeader) then
              if (AIsRow = True) then
                Sum := Sum + Grid.RowHeights[0]
              else
                Sum := Sum + Grid.ColWidths[0];

          AStartArr[Count] := SR;
          ER := LI - 1;
          AEndArr[Count] := ER;
          SR := ER + 1;
        end;
      end;
      if (ER <> AEnd) then
      begin
        Inc(Count);
        SetLength(AStartArr, Count + 1);
        SetLength(AEndArr, Count + 1);
        AStartArr[Count] := SR;
        AEndArr[Count] := AEnd;
      end;
      if (SumFlag = 0) then
      begin
        Inc(Count);
        SetLength(AStartArr, Count + 1);
        SetLength(AEndArr, Count + 1);
        AStartArr[Count] := AStart;
        AEndArr[Count] := AEnd;
      end;
    end
    else
    begin
      SR := AStart;
      ER := AEnd;
      SumFlag := 0;
      Count := -1;
      for LI := AStart to AEnd do
      begin
        Inc(RCCount);
        if (AIsRow = True) then
          Sum :=Sum + Grid.RowHeights[LI]
        else
          Sum := Sum + Grid.ColWidths[LI];
        if ((Sum > AMaxValue) or (RCCount > RowColCount)) then
        begin
          RCCount := 1;
          Inc(Count);
          SetLength(AStartArr, Count + 1);
          SetLength(AEndArr, Count + 1);
          SumFlag := 1;
          if (AIsRow = True) then
            Sum := Grid.RowHeights[LI]
          else
            Sum :=  Grid.ColWidths[LI];
          if (FExportOptions.ExportRowHeader
              and FExportOptions.ExportColHeader) then
            if (FExportOptions.RepeatRowHeader
                and FExportOptions.RepeatColHeader) then
              if (AIsRow = True) then
                Sum := Sum + Grid.RowHeights[0]
              else
                Sum := Sum + Grid.ColWidths[0];

          AStartArr[Count] := SR;
          ER := LI - 1;
          AEndArr[Count] := ER;
          SR := ER + 1;
        end;
      end;
      if (ER <> AEnd) then
      begin
        Inc(Count);
        SetLength(AStartArr, Count + 1);
        SetLength(AEndArr, Count + 1);
        AStartArr[Count] := SR;
        AEndArr[Count] := AEnd;
      end;
      if (SumFlag = 0) then
      begin
        Inc(Count);
        SetLength(AStartArr, Count + 1);
        SetLength(AEndArr, Count + 1);
        AStartArr[Count] := AStart;
        AEndArr[Count] := AEnd;
      end;
    end;
  end;

begin
  if (not Visible) then Exit;
  if (Engine = nil) then Exit;
  if (Grid = nil) then Exit;
  LUnits := Engine.MeasurementUnit;
  Engine.MeasurementUnit := muPixels;

  ExportCol := FExportOptions.ExportColHeader;
  ExportRow := FExportOptions.ExportRowHeader;
  RepeatCol := FExportOptions.RepeatColHeader;
  RepeatRow := FExportOptions.RepeatRowHeader;

  if (not FExportOptions.ExportColHeader) then
  begin
    ExportCol := False;
    RepeatCol := False;
  end;
  if (not FExportOptions.ExportRowHeader) then
  begin
    ExportRow := False;
    RepeatRow := False;
  end;
  StartCol := 0;
  StartRow := 0;
  EndCol := 0;
  EndRow := 0;

  if (FExportOptions.ColRange = crAll) then
  begin
    ColumnCount := Grid.ColCount - 1;
    EndCol := ColumnCount;
  end
  else if (FExportOptions.ColRange = crVisible) then
  begin
    ColumnCount := Grid.VisibleColCount;
    StartCol := Grid.RealCol;
    EndCol := StartCol + ColumnCount - 1;
    if ((StartCol + ColumnCount) >= Grid.ColCount - 1) then
      EndCol := Grid.ColCount - 1;
  end
  else if (FExportOptions.ColRange = crSelected) then
  begin
    ColumnCount := Grid.Selection.Right - Grid.Selection.Left;
    StartCol := Grid.Selection.Left;
    EndCol := Grid.Selection.Right;
    if ((StartCol + ColumnCount) >= Grid.ColCount - 1) then
      EndCol := Grid.ColCount - 1;
  end;

  if (FExportOptions.RowRange = crAll) then
  begin
    RowCount := Grid.RowCount - 1;
    EndRow := RowCount;
  end
  else if (FExportOptions.RowRange = crVisible) then
  begin
    StartRow := Grid.RealRow;
    RowCount := Grid.VisibleRowCount;
    EndRow :=StartRow + RowCount - 1;
    if ((StartRow + RowCount) > Grid.RowCount - 1) then
      EndRow := Grid.RowCount - 1;
  end
  else if (FExportOptions.RowRange = crSelected) then
  begin
    RowCount := Grid.Selection.Bottom - Grid.Selection.Top;
    StartRow := Grid.Selection.Top;
    EndRow := Grid.Selection.Bottom;
    if ((StartRow + RowCount) > Grid.RowCount - 1) then
      EndRow := Grid.RowCount - 1;
  end;

  with IgtDocumentEngine(Engine) do
  begin
    FileName := AFileName;
    StartDocument;
    if (Engine.EngineStatus = esCancelled) then
      Exit;
    if (StartCol = 0) then
      StartCol := StartCol + 1;
    if (StartRow = 0) then
      StartRow := StartRow + 1;
    with Page do
    begin
      StorePageLimits(StartRow, EndRow, Height - TopMargin - BottomMargin,
        RowStart, RowEnd, True);
      StorePageLimits(StartCol, EndCol, Width - LeftMargin - RightMargin,
        ColStart, ColEnd, False);
    end;

    if (FExportOptions.PrintOrder = poVertical) then
    begin
      for I := 0 to High(ColStart) do
      begin
        for J := 0 to High(RowStart) do
        begin
          if (FExportOptions.ExportRowHeader
            and FExportOptions.ExportColHeader) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, 0,
                Rect(0, 0, Grid.ColWidths[0], Grid.RowHeights[0]), [gdFocused]);
              PrintRowHeader(RowStart[J], RowEnd[J], True);
              PrintColHeader(ColStart[I], ColEnd[I], True);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I], True, True);
            end
            else
            begin
              NewPage;
              if (RepeatCol and RepeatRow) then
              begin
                TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, 0,
                  Rect(0, 0, Grid.ColWidths[0], Grid.RowHeights[0]), [gdFocused]);
                PrintRowHeader(RowStart[J], RowEnd[J], RepeatCol);
                PrintColHeader(ColStart[I], ColEnd[I], RepeatRow);
              end
              else
              begin
              if (RepeatRow) then
                PrintRowHeader(RowStart[J], RowEnd[J], RepeatCol)
              else if (RepeatCol) then
                PrintColHeader(ColStart[I], ColEnd[I], RepeatRow);
              end;
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end

          else if ((not FExportOptions.ExportRowHeader)
            and (not FExportOptions.ExportColHeader)) then
          begin
            if ((I > 0) or (J > 0)) then
              NewPage;
            PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
              RepeatRow, RepeatCol);
          end

          else if ((FExportOptions.ExportRowHeader) and
            (not FExportOptions.ExportColHeader)) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              PrintRowHeader(RowStart[J], RowEnd[J], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                ExportRow, ExportCol);
            end
            else if ((I > 0) or (J > 0)) then
            begin
              NewPage;
              if (RepeatRow) then
                PrintRowHeader(RowStart[J], RowEnd[J], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end

          else if ((not FExportOptions.ExportRowHeader) and
            (FExportOptions.ExportColHeader)) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              PrintColHeader(ColStart[I], ColEnd[I], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                ExportRow, ExportCol);
            end
            else if ((I > 0) or (J > 0)) then
            begin
              NewPage;
              if (RepeatCol) then
                PrintColHeader(ColStart[I], ColEnd[I], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end;
        end;
      end;
    end
    else
    begin
      for J := 0 to High(RowStart) do
      begin
        for I := 0 to High(ColStart) do
        begin
          if (FExportOptions.ExportRowHeader
            and FExportOptions.ExportColHeader) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, 0,
                Rect(0, 0, Grid.ColWidths[0], Grid.RowHeights[0]), [gdFocused]);
              PrintRowHeader(RowStart[J], RowEnd[J], True);
              PrintColHeader(ColStart[I], ColEnd[I], True);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I], True, True);
            end
            else
            begin
              NewPage;
              if (RepeatCol and RepeatRow) then
              begin
                TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, 0,
                  Rect(0, 0, Grid.ColWidths[0], Grid.RowHeights[0]), [gdFocused]);
                PrintRowHeader(RowStart[J], RowEnd[J], RepeatCol);
                PrintColHeader(ColStart[I], ColEnd[I], RepeatRow);
              end
              else
              begin
                if (RepeatRow) then
                  PrintRowHeader(RowStart[J], RowEnd[J], RepeatCol)
                else if (RepeatCol) then
                PrintColHeader(ColStart[I], ColEnd[I], RepeatRow);
              end;
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end

          else if (not (FExportOptions.ExportRowHeader) and
            not(FExportOptions.ExportColHeader)) then
          begin
            if ((I > 0) or (J > 0)) then
              NewPage;
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
          end

          else if ((FExportOptions.ExportRowHeader) and
            (not FExportOptions.ExportColHeader)) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              PrintRowHeader(RowStart[J], RowEnd[J], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                ExportRow, ExportCol);
            end
            else if ((I > 0) or (J > 0)) then
            begin
              NewPage;
              if (RepeatRow) then
                PrintRowHeader(RowStart[J], RowEnd[J], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end

          else if ((not FExportOptions.ExportRowHeader) and
            (FExportOptions.ExportColHeader)) then
          begin
            if ((I = 0) and (J = 0)) then
            begin
              PrintColHeader(ColStart[I], ColEnd[I], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                ExportRow, ExportCol);
            end
            else if ((I > 0) or (J > 0)) then
            begin
              NewPage;
              if (RepeatCol) then
                PrintColHeader(ColStart[I], ColEnd[I], False);
              PrintValues(RowStart[J], RowEnd[J], ColStart[I], ColEnd[I],
                RepeatRow, RepeatCol);
            end;
          end;
        end;
      end;
    end;
    EndDocument;
  end;
  Engine.MeasurementUnit := LUnits;
end;



procedure TgtAdvGridExportInterface.PrintColHeader(StartCol: Integer;
  EndCol: Integer; IsRow: Boolean);
var
  LTop, LBottom, LLeft, LRight: Integer;
  I, CC:Integer;
begin
  if (IsRow) then
    LRight := Grid.ColWidths[0]
  else
    LRight := 0;
  for I := StartCol to EndCol do
  begin;
    if (IsRow) then
    begin
      LTop := 0;
      LBottom := Grid.RowHeights[0];
      LLeft := LRight;
      LRight := Grid.ColWidths[0];
      for CC:=StartCol to I do
        LRight := LRight+ Grid.ColWidths[CC];
      TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, I, 0,
        Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
    end
    else
    begin
      LTop := 0;
      LBottom := Grid.RowHeights[0];
      LLeft := LRight;
      LRight := 0;
      for CC:=StartCol to I do
        LRight := LRight+ Grid.ColWidths[CC];
      TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, I, 0,
        Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
    end
  end;
end;

procedure TgtAdvGridExportInterface.PrintRowHeader(StartRow: Integer;
  EndRow: Integer; IsCol: Boolean);
var
  LTop, LBottom, LLeft, LRight: Integer;
  I, RC:Integer;
begin
  if (IsCol) then
    LBottom := Grid.RowHeights[0]
  else
    LBottom := 0;
  for I := StartRow to EndRow do
  begin;
    if (IsCol) then
    begin
      LLeft := 0;
      LRight := Grid.ColWidths[0];
      LTop := LBottom;
      LBottom := Grid.RowHeights[0];
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, I,
        Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
    end
    else
    begin
      LLeft := 0;
      LRight := Grid.ColWidths[0];
      LTop := LBottom;
      LBottom := 0;
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, 0, I,
        Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
    end;
  end;
end;

procedure TgtAdvGridExportInterface.PrintValues(StartRow: Integer;
  EndRow: Integer; StartCol: Integer; EndCol: Integer;
  ExportRow, ExportCol: Boolean);
var
  LTop, LBottom, LLeft, LRight: Integer;
  I, J,RC, CC:Integer;
begin
  LBottom := Grid.RowHeights[0];
  if (ExportRow and ExportCol) then
  begin
    for I := StartRow to EndRow do
    begin
      LTop := LBottom;
      LBottom := Grid.RowHeights[0];
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      LRight := Grid.ColWidths[0];
      for J := StartCol to EndCol do
      begin
        LLeft := LRight;
        LRight := Grid.ColWidths[0];
        for CC := StartCol to J do
          LRight := LRight + Grid.ColWidths[CC];
        if (FExportOptions.DrawGridLines) then
        begin
          IgtDocumentEngine(engine).Brush.Color := Grid.Color;
          IgtDocumentEngine(engine).Pen.Color := Grid.GridLineColor;
          IgtDocumentEngine(engine).Pen.Width := Grid.GridLineWidth;
          if Grid.Color = clWhite then
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, False)
          else
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, True);
        end;
        TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, J, I,
          Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
      end;
    end;
  end
  else if (not (ExportRow) and not(ExportCol)) then
  begin
    LBottom := 0;
    for I := StartRow to EndRow do
    begin
      LTop := LBottom;
      LBottom := 0;
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      LRight := 0;
      for J := StartCol to EndCol do
      begin
        LLeft := LRight;
        LRight := 0;
        for CC := StartCol to J do
          LRight := LRight + Grid.ColWidths[CC];
        if (FExportOptions.DrawGridLines) then
        begin
          IgtDocumentEngine(engine).Brush.Color := Grid.Color;
          IgtDocumentEngine(engine).Pen.Color := Grid.GridLineColor;
          IgtDocumentEngine(engine).Pen.Width := Grid.GridLineWidth;
          if Grid.Color = clWhite then
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, False)
          else
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, True);
        end;

        TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, J, I,
          Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
      end;
    end;
  end

 else if ((ExportRow) and not (ExportCol)) then
  begin
    LBottom := 0;
    for I := StartRow to EndRow do
    begin
      LTop := LBottom;
      LBottom := 0;
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      LRight := Grid.ColWidths[0];
      for J := StartCol to EndCol do
      begin
        LLeft := LRight;
        LRight := Grid.ColWidths[0];
        for CC := StartCol to J do
          LRight := LRight + Grid.ColWidths[CC];
        if (FExportOptions.DrawGridLines) then
        begin
          IgtDocumentEngine(engine).Brush.Color := Grid.Color;
          IgtDocumentEngine(engine).Pen.Color := Grid.GridLineColor;
          IgtDocumentEngine(engine).Pen.Width := Grid.GridLineWidth;
          if Grid.Color = clWhite then
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, False)
          else
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, True);
        end;

        TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, J, I,
          Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
      end;
    end;
  end

 else if (not (ExportRow) and  (ExportCol)) then
  begin
    LBottom := Grid.RowHeights[0];
    for I := StartRow to EndRow do
    begin
      LTop := LBottom;
      LBottom := Grid.RowHeights[0];
      for RC := StartRow to I do
        LBottom := LBottom + Grid.RowHeights[RC];
      LRight := 0;
      for J := StartCol to EndCol do
      begin
        LLeft := LRight;
        LRight := 0;
        for CC := StartCol to J do
          LRight := LRight + Grid.ColWidths[CC];
        if (FExportOptions.DrawGridLines) then
        begin
          IgtDocumentEngine(engine).Brush.Color := Grid.Color;
          IgtDocumentEngine(engine).Pen.Color := Grid.GridLineColor;
          IgtDocumentEngine(engine).Pen.Width := Grid.GridLineWidth;
          if Grid.Color = clWhite then
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, False)
          else
            IgtDocumentEngine(engine).Rectangle(LLeft, LTop, LRight, LBottom, True);
        end;
        TgtHackAdvStringGrid(Grid).DrawGridCell(Engine.Canvas, J, I,
          Rect(LLeft, LTop, LRight, LBottom), [gdFocused]);
      end;
    end;
  end
end;


procedure TgtAdvGridExportInterface.SetEngine(
  const Value: TgtCustomDocumentEngine);
begin
  inherited Engine := Value;
end;

procedure TgtAdvGridExportInterface.SetExportOptions(
  const Value: TgtExportOptions);
begin
  FExportOptions := Value;
end;

procedure TgtAdvGridExportInterface.SetGrid(const Value: TAdvStringGrid);
begin
  FGrid := Value;
end;

procedure TgtAdvGridExportInterface.SetVisible(const Value: Boolean);
begin
  inherited Visible := Value;
end;


{ Registeration procedure }

procedure Register;
begin
	RegisterComponents('Gnostice Interface', [TgtAdvGridExportInterface]);
end;

{ TgtExportOptions }

constructor TgtExportOptions.Create;
begin
  inherited Create;
  DrawGridLines := True;
  ExportColHeader := True;
  ExportRowHeader := True;
  RepeatColHeader := True;
  RepeatRowHeader := True;
  RowRange := crAll;
  ColRange := crAll;
  MaxColsPerPage := 0;
  MaxRowsPerPage := 0;
  PrintOrder := poHorizontal;
end;

procedure TgtExportOptions.SetColRange(const Value: TgtCellRange);
begin
  FColRange := Value;
end;

procedure TgtExportOptions.SetDrawGridLines(const Value: Boolean);
begin
  FDrawGridLines := Value;
end;

procedure TgtExportOptions.SetExportColHeader(const Value: Boolean);
begin
  FExportColHeader := Value;
end;

procedure TgtExportOptions.SetExportRowHeader(const Value: Boolean);
begin
  FExportRowHeader := Value;
end;


procedure TgtExportOptions.SetMaxColsPerPage(const Value: Integer);
begin
  FMaxColsPerPage := Value;
end;

procedure TgtExportOptions.SetMaxRowsPerPage(const Value: Integer);
begin
  FMaxRowsPerPage := Value;
end;

procedure TgtExportOptions.SetPrintOrder(const Value: TgtPrintOrder);
begin
  FPrintOrder := Value;
end;

procedure TgtExportOptions.SetRepeatColHeader(const Value: Boolean);
begin
  FRepeatColHeader := Value;
end;

procedure TgtExportOptions.SetRepeatRowHeader(const Value: Boolean);
begin
  FRepeatRowHeader := Value;
end;

procedure TgtExportOptions.SetRowRange(const Value: TgtCellRange);
begin
  FRowRange := Value;
end;

{ TgtHackAdvStringGrid }

procedure TgtHackAdvStringGrid.DrawGridCell(Canvas: TCanvas; ACol,
  ARow: Integer; ARect: TRect; AState: TGridDrawState);
begin
  inherited;

end;

end.
