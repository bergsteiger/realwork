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
{*                  OVCTCSTR.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCStr;
  {-Orpheus Table Cell - base string type}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils,
  Messages,
  Graphics, Classes, Controls, Forms, StdCtrls, Menus,
  OvcData, OvcConst, OvcBase,
  OvcTCmmn, OvcTCell, OvcTGRes{, OvcTable};

type
  TOvcTCBaseString = class(TOvcBaseTableCell)
    protected {private}
      {.Z+}
      FUseASCIIZStrings : boolean;
      FUseWordWrap      : boolean;

      FOnChange    : TNotifyEvent;
      {.Z-}

    protected
      {.Z+}
      procedure SetUseASCIIZStrings(AZS : boolean);
      procedure SetUseWordWrap(WW : boolean);

      procedure tcPaint(TableCanvas : TCanvas;
                  const CellRect    : TRect;
                        RowNum      : TRowNum;
                        ColNum      : TColNum;
                  const CellAttr    : TOvcCellAttributes;
                        Data        : pointer); override;
      procedure tcPaintStrZ(TblCanvas : TCanvas;
                      const CellRect  : TRect;
                      const CellAttr  : TOvcCellAttributes;
                            StZ       : PAnsiChar);
      {.Z-}

      {properties}
      property UseASCIIZStrings : boolean
         read FUseASCIIZStrings write SetUseASCIIZStrings;

      property UseWordWrap : boolean
         read FUseWordWrap write SetUseWordWrap;

      {events}
      property OnChange : TNotifyEvent
         read FOnChange write FOnChange;
    public
      constructor Create(AOwner : TComponent); override;
  end;


implementation


{===TOvcTCBaseString==========================================}
constructor TOvcTCBaseString.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
  end;

procedure TOvcTCBaseString.tcPaint(TableCanvas : TCanvas;
                             const CellRect    : TRect;
                                   RowNum      : TRowNum;
                                   ColNum      : TColNum;
                             const CellAttr    : TOvcCellAttributes;
                                   Data        : pointer);
  var
    S : POvcShortString absolute Data;
    SZ: PAnsiChar absolute Data;
    StZ           : PAnsiChar;
    SAsPChar      : array [0..255] of AnsiChar;
    StZAllocated  : boolean;
    IsEmptyString : boolean;

  begin
    {blank out the cell}
    inherited tcPaint(TableCanvas, CellRect, RowNum, ColNum, CellAttr, Data);
    {if the cell is invisible or the passed data is nil and we're not
     designing, all's done}
    if (CellAttr.caAccess = otxInvisible) or
       ((Data = nil) and not (csDesigning in ComponentState)) then
      Exit;
    {prepare to paint the string}
    StZAllocated := false;
    {for a null string, output the row:column in that format}
    if (Data = nil) then
      begin
        StZ := {$ifDef XE}AnsiStrAlloc{$Else}StrAlloc{$EndIf}(32); {should be ample}
        StZAllocated := true;
        StrFmt(StZ, '%d:%d', [RowNum, ColNum]);
      end
    {for an ASCIIZ string, just go paint it}
    else if UseASCIIZStrings then
      StZ := SZ
    {for a Pascal shortstring, convert to an ASCIIZ version}
    else
      StZ := StrPCopy(SAsPChar, S^);
    IsEmptyString := (StZ[0] = #0);
    {now paint the ASCIIZ string}
    try
      if not IsEmptyString then
        tcPaintStrZ(TableCanvas, CellRect, CellAttr, StZ);
    finally
      if StZAllocated then
        StrDispose(StZ);
    end;
  end;
{--------}
procedure TOvcTCBaseString.tcPaintStrZ(TblCanvas : TCanvas;
                               const CellRect  : TRect;
                               const CellAttr  : TOvcCellAttributes;
                                     StZ       : PAnsiChar);
  {$IFDEF Win32}
  var
    Size   : TSize;
  {$ELSE}
  type
    LH = record L, H : word; end;
  var
    HtWd   : LongInt;
  {$ENDIF}
  var
    Wd     : integer;
    LenStZ : integer;
    DTOpts : Cardinal;
    R      : TRect;
    OurAdjust : TOvcTblAdjust;
  begin
    TblCanvas.Font := CellAttr.caFont;
    TblCanvas.Font.Color := CellAttr.caFontColor;

    LenStZ := StrLen(StZ);

    R := CellRect;
    InflateRect(R, -Margin div 2, -Margin div 2);

    if FUseWordWrap then
      begin
        DTOpts:= DT_NOPREFIX or DT_WORDBREAK;
        case CellAttr.caAdjust of
          otaTopLeft, otaCenterLeft, otaBottomLeft    :
             DTOpts := DTOpts or DT_LEFT;
          otaTopRight, otaCenterRight, otaBottomRight :
             DTOpts := DTOpts or DT_RIGHT;
        else
          DTOpts := DTOpts or DT_CENTER;
        end;{case}
      end
    else
      begin
        DTOpts:= DT_NOPREFIX or DT_SINGLELINE;

        {make sure that if the string doesn't fit, we at least see
         the first few characters}
        {$IFDEF Win32}
        GetTextExtentPoint32(TblCanvas.Handle, StZ, LenStZ, Size);
        Wd := Size.cX;
        {$ELSE}
        HtWd := GetTextExtent(TblCanvas.Handle, StZ, LenStZ);
        Wd := LH(HtWd).L;
        {$ENDIF}
        OurAdjust := CellAttr.caAdjust;
        if Wd > (R.Right - R.Left) then
          case CellAttr.caAdjust of
            otaTopCenter, otaTopRight : OurAdjust := otaTopLeft;
            otaCenter, otaCenterRight : OurAdjust := otaCenterLeft;
            otaBottomCenter, otaBottomRight : OurAdjust := otaBottomLeft;
          end;

        case OurAdjust of
          otaTopLeft, otaCenterLeft, otaBottomLeft    :
             DTOpts := DTOpts or DT_LEFT;
          otaTopRight, otaCenterRight, otaBottomRight :
             DTOpts := DTOpts or DT_RIGHT;
        else
          DTOpts := DTOpts or DT_CENTER;
        end;{case}
        case OurAdjust of
          otaTopLeft, otaTopCenter, otaTopRight :
             DTOpts := DTOpts or DT_TOP;
          otaBottomLeft, otaBottomCenter, otaBottomRight :
             DTOpts := DTOpts or DT_BOTTOM;
        else
          DTOpts := DTOpts or DT_VCENTER;
        end;{case}
      end;

    case CellAttr.caTextStyle of
      tsFlat :
        DrawText(TblCanvas.Handle, StZ, LenStZ, R, DTOpts);
      tsRaised :
        begin
          OffsetRect(R, -1, -1);
          TblCanvas.Font.Color := CellAttr.caFontHiColor;
          DrawText(TblCanvas.Handle, StZ, LenStZ, R, DTOpts);
          OffsetRect(R, 1, 1);
          TblCanvas.Font.Color := CellAttr.caFontColor;
          TblCanvas.Brush.Style := bsClear;
          DrawText(TblCanvas.Handle, StZ, LenStZ, R, DTOpts);
          TblCanvas.Brush.Style := bsSolid;
        end;
      tsLowered :
        begin
          OffsetRect(R, 1, 1);
          TblCanvas.Font.Color := CellAttr.caFontHiColor;
          DrawText(TblCanvas.Handle, StZ, LenStZ, R, DTOpts);
          OffsetRect(R, -1, -1);
          TblCanvas.Font.Color := CellAttr.caFontColor;
          TblCanvas.Brush.Style := bsClear;
          DrawText(TblCanvas.Handle, StZ, LenStZ, R, DTOpts);
          TblCanvas.Brush.Style := bsSolid;
        end;
      end;
  end;
{--------}
procedure TOvcTCBaseString.SetUseASCIIZStrings(AZS : boolean);
  begin
    if (AZS <> FUseASCIIZStrings) then
      begin
        FUseASCIIZStrings := AZS;
        tcDoCfgChanged;
      end;
  end;
{--------}
procedure TOvcTCBaseString.SetUseWordWrap(WW : boolean);
  begin
    if (WW <> FUseWordWrap) then
      begin
        FUseWordWrap := WW;
        tcDoCfgChanged;
      end;
  end;
{====================================================================}


end.
