{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTCHDR.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCHdr;
  {Orpheus Table Cell - Headers for columns and rows}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase,
  OvcTCmmn, OvcTCell, OvcTCStr;

type
  TOvcTCColHead = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      FHeadings      : TStringList;
      FShowActiveCol : boolean;
      FShowLetters   : boolean;
      {.Z-}

    protected
      {.Z+}
      procedure SetHeadings(H : TStringList);
      procedure SetShowActiveCol(SAC : boolean);
      procedure SetShowLetters(SL : boolean);

      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}

     public {protected}
      {.Z+}
      procedure chColumnsChanged(ColNum1, ColNum2 : TColNum; Action : TOvcTblActions);
      {.Z-}

    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;

    published
      property Headings : TStringList
         read FHeadings write SetHeadings;

      property ShowActiveCol : boolean
         read FShowActiveCol write SetShowActiveCol;

      property ShowLetters : boolean
         read FShowLetters write SetShowLetters
         default true;

      {properties inherited from custom ancestor}
      property Adjust;
      property Color;
      property Font;
      property Margin;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextStyle;
      property UseWordWrap;
      property Version;                                                {!!.13}

      {events inherited from custom ancestor}
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
  end;

  TOvcTCRowHead = class(TOvcTCBaseString)
    protected {private}
      {.Z+}
      FShowActiveRow : boolean;
      FShowNumbers   : boolean;
      {.Z-}

    protected
      {.Z+}
      procedure SetShowActiveRow(SAR : boolean);
      procedure SetShowNumbers(SN : boolean);
      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      {.Z-}

    public
      constructor Create(AOwner : TComponent); override;

    published
      property ShowActiveRow : boolean
         read FShowActiveRow write SetShowActiveRow;

      property ShowNumbers : boolean
         read FShowNumbers write SetShowNumbers
         default true;

      {properties inherited from custom ancestor}
      property Adjust;
      property Color;
      property Font;
      property Margin;
      property Table;
      property TableColor;
      property TableFont;
      property TextHiColor;
      property TextStyle;
      property Version;                                                {!!.13}

      {events inherited from custom ancestor}
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnOwnerDraw;
  end;

implementation



{===TOvcTCColHead====================================================}
constructor TOvcTCColHead.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    FHeadings := TStringList.Create;
    Access := otxReadOnly;
    UseASCIIZStrings := false;
    {UseWordWrap := false;}
    ShowLetters := true;
  end;
{--------}
destructor TOvcTCColHead.Destroy;
  begin
    FHeadings.Free;
    inherited Destroy;
  end;
{--------}
procedure TOvcTCColHead.chColumnsChanged(ColNum1, ColNum2 : TColNum;
                                         Action : TOvcTblActions);
  var
    MaxColNum : TColNum;
    ColNum    : TColNum;
    Temp : string;
  begin
    case Action of
      taInsert :
        if (0 <= ColNum1) and (ColNum1 < FHeadings.Count) then
          FHeadings.Insert(ColNum1, '')
        else if (ColNum1 = FHeadings.Count) then
          FHeadings.Add('');
      taDelete :
        if (0 <= ColNum1) and (ColNum1 < FHeadings.Count) then
          FHeadings.Delete(ColNum1);
      taExchange :
        begin
          MaxColNum := MaxL(ColNum1, ColNum2);
          if (MaxColNum >= FHeadings.Count) and (FHeadings.Count > 0) then
            for ColNum := FHeadings.Count to MaxColNum do
              FHeadings.Add('');
          if (0 <= ColNum1) and (0 <= ColNum2) and
             (FHeadings.Count > 0) then                         {!!.01}
            begin
              Temp := FHeadings[ColNum1];
              FHeadings[ColNum1] := FHeadings[ColNum2];
              FHeadings[ColNum2] := Temp;
            end;
        end;
    end;
  end;
{--------}
procedure TOvcTCColHead.tcPaint(TableCanvas : TCanvas;
                          const CellRect    : TRect;
                                RowNum      : TRowNum;
                                ColNum      : TColNum;
                          const CellAttr    : TOvcCellAttributes;
                                Data        : pointer);
  {------}
  procedure PaintAnArrow;
    var
      ArrowDim : Integer;
      X, Y     : Integer;
      LeftPoint, RightPoint, BottomPoint : TPoint;
      CellWidth  : integer;
      CellHeight : integer;
    begin
      CellWidth := CellRect.Right - CellRect.Left;
      CellHeight := CellRect.Bottom - CellRect.Top;
      with TableCanvas do
        begin
          Pen.Color := CellAttr.caFont.Color;
          Brush.Color := Pen.Color;
          ArrowDim := MinI(CellWidth, CellHeight) div 3;
          case CellAttr.caAdjust of
            otaTopLeft, otaCenterLeft, otaBottomLeft    : X := Margin;
            otaTopRight, otaCenterRight, otaBottomRight : X := CellWidth-Margin-ArrowDim;
          else
            X := (CellWidth - ArrowDim) div 2;
          end;{case}
          inc(X, CellRect.Left);
          case CellAttr.caAdjust of
            otaTopLeft, otaTopCenter, otaTopRight          : Y := Margin;
            otaBottomLeft, otaBottomCenter, otaBottomRight : Y := CellHeight-Margin-ArrowDim;
          else
            Y := (CellHeight - ArrowDim) div 2;
          end;{case}
          inc(Y, CellRect.Top);
          LeftPoint := Point(X, Y);
          RightPoint := Point(X+ArrowDim, Y);
          BottomPoint := Point(X+(ArrowDim div 2), Y+ArrowDim);
          Polygon([LeftPoint, RightPoint, BottomPoint]);
        end;
    end;
  {------}
  var
    DataSt    : POvcShortString absolute Data;
    LockedCols: TColNum;
    ActiveCol : TColNum;
    WorkCol   : TColNum;
    C         : string[1];
    HeadSt    : ShortString;
  begin
    if Assigned(FTable) then
      begin
        LockedCols := tcRetrieveTableLockedCols;
        ActiveCol := tcRetrieveTableActiveCol;
      end
    else
      begin
        LockedCols := 0;
        ActiveCol := -1;
      end;
    HeadSt := '';
    {if required show a down arrow for the active column}
    if ShowActiveCol and (ColNum = ActiveCol) then
      begin
        {this call to inherited tcPaint blanks out the cell}
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @HeadSt);
        PaintAnArrow;
      end
    else if ShowLetters then
      begin
        {convert the column number to the spreadsheet-style letters}
        WorkCol := ColNum - LockedCols + 1;
        HeadSt := '.';
        while (WorkCol > 0) do
          begin
            C := AnsiChar(pred(WorkCol) mod 26 + ord('A'));
            System.Insert(C, HeadSt, 1);
            WorkCol := pred(WorkCol) div 26;
          end;
        Delete(HeadSt, length(HeadSt), 1);
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @HeadSt);
      end
    else {Data points to a column heading}
      begin
        if Assigned(Data) then
          HeadSt := DataSt^
        else if (0 <= ColNum) and (ColNum < Headings.Count) then
          HeadSt := Headings[ColNum];
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @HeadSt);
      end;
  end;
{--------}
procedure TOvcTCColHead.SetHeadings(H : TStringList);
  begin
    FHeadings.Assign(H);
    tcDoCfgChanged;
  end;
{--------}
procedure TOvcTCColHead.SetShowActiveCol(SAC : boolean);
  begin
    if (SAC <> ShowActiveCol) then
      begin
        FShowActiveCol := SAC;
        tcDoCfgChanged;
      end;
  end;
{--------}
procedure TOvcTCColHead.SetShowLetters(SL : boolean);
  begin
    if (SL <> ShowLetters) then
      begin
        FShowLetters := SL;
        tcDoCfgChanged;
      end;
  end;
{====================================================================}

{===TOvcTCRowHead====================================================}
constructor TOvcTCRowHead.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    Access := otxReadOnly;
    UseASCIIZStrings := false;
    UseWordWrap := false;
    ShowNumbers := true;
  end;
{--------}
procedure TOvcTCRowHead.tcPaint(TableCanvas : TCanvas;
                          const CellRect    : TRect;
                                RowNum      : TRowNum;
                                ColNum      : TColNum;
                          const CellAttr    : TOvcCellAttributes;
                                Data        : pointer);
  {------}
  procedure PaintAnArrow;
    var
      ArrowDim : Integer;
      X, Y     : Integer;
      TopPoint, BottomPoint, RightPoint : TPoint;
      CellWidth  : integer;
      CellHeight : integer;
    begin
      CellWidth := CellRect.Right - CellRect.Left;
      CellHeight := CellRect.Bottom - CellRect.Top;
      with TableCanvas do
        begin
          Pen.Color := CellAttr.caFont.Color;
          Brush.Color := Pen.Color;
          ArrowDim := MinI(CellWidth-8, CellHeight div 3);
          case CellAttr.caAdjust of
            otaTopLeft, otaCenterLeft, otaBottomLeft    : X := Margin;
            otaTopRight, otaCenterRight, otaBottomRight : X := CellWidth-Margin-ArrowDim;
          else
            X := (CellWidth - ArrowDim) div 2;
          end;{case}
          inc(X, CellRect.Left);
          case CellAttr.caAdjust of
            otaTopLeft, otaTopCenter, otaTopRight          : Y := Margin;
            otaBottomLeft, otaBottomCenter, otaBottomRight : Y := CellHeight-Margin-ArrowDim;
          else
            Y := (CellHeight - ArrowDim) div 2;
          end;{case}
          inc(Y, CellRect.Top);
          TopPoint := Point(X, Y);
          BottomPoint := Point(X, Y+ArrowDim);
          RightPoint := Point(X+ArrowDim, Y+(ArrowDim div 2));
          Polygon([RightPoint, TopPoint, BottomPoint]);
        end;
    end;
  {------}
  var
    HeadSt : ShortString;
    ActiveRow  : TRowNum;
    LockedRows : TRowNum;
    WorkRow    : TRowNum;
  begin
    if Assigned(FTable) then
      begin
        LockedRows := tcRetrieveTableLockedRows;
        ActiveRow := tcRetrieveTableActiveRow;
      end
    else
      begin
        LockedRows := 0;
        ActiveRow := -1;
      end;
    {display the row number, etc}
    HeadSt := '';
    if (ShowActiveRow and (RowNum = ActiveRow)) then
      begin
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @HeadSt);
        PaintAnArrow;
      end
    else
      begin
        if ShowNumbers then
          begin
            WorkRow := (RowNum + 1) - LockedRows;
            HeadSt := Format('%d', [WorkRow]);
          end;
        inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, @HeadSt);
      end;
  end;
{--------}
procedure TOvcTCRowHead.SetShowActiveRow(SAR : boolean);
  begin
    if (SAR <> ShowActiveRow) then
      begin
        FShowActiveRow := SAR;
        tcDoCfgChanged;
      end;
  end;
{--------}
procedure TOvcTCRowHead.SetShowNumbers(SN : boolean);
  begin
    if (SN <> ShowNumbers) then
      begin
        FShowNumbers := SN;
        tcDoCfgChanged;
      end;
  end;
{====================================================================}


end.
