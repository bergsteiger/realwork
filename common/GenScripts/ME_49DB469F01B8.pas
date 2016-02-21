unit evControlsBlockPainter;
 {* Рисователь группы контролов }

// Модуль: "w:\common\components\gui\Garant\Everest\evControlsBlockPainter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evDocumentPartPainter
 , l3Variant
 , l3Interfaces
 , nevBase
;

type
 TevControlsBlockPainter = class(TevDocumentPartPainter)
  {* Рисователь группы контролов }
  protected
   function InfiniteFrame: Boolean; override;
   procedure GetFramePartPrim(aFrame: Tl3Variant;
    anIndex: Tl3FramePartIndex;
    var thePart: TnevFramePart); override;
   procedure DoDrawFrameText(aTop: Boolean); override;
   function NeedCheckTopAnchor: Boolean; override;
   procedure DrawFrameName; override;
    {* Рисует имя блока в области рамки }
   function IsTopAnchorAtStart: Boolean; override;
 end;//TevControlsBlockPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 , l3CustomString
 , l3InternalInterfaces
 , l3Units
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , TextPara_Const
 , evdStyles
 , k2Tags
 , k2Base
 , evControlsBlockConst
 , evControlParaTools
 , evdTypes
 , l3Defaults
 , Graphics
 , Cloak_Const
 , l3Math
 , l3Const
 , l3Types
 , l3String
 , NodeGroup_Const
 , ControlsBlock_Const
;

function TevControlsBlockPainter.InfiniteFrame: Boolean;
//#UC START# *4804B78B0397_49DB469F01B8_var*
//#UC END# *4804B78B0397_49DB469F01B8_var*
begin
//#UC START# *4804B78B0397_49DB469F01B8_impl*
 Result := False;
//#UC END# *4804B78B0397_49DB469F01B8_impl*
end;//TevControlsBlockPainter.InfiniteFrame

procedure TevControlsBlockPainter.GetFramePartPrim(aFrame: Tl3Variant;
 anIndex: Tl3FramePartIndex;
 var thePart: TnevFramePart);
//#UC START# *4804B9BB0383_49DB469F01B8_var*
//#UC END# *4804B9BB0383_49DB469F01B8_var*
begin
//#UC START# *4804B9BB0383_49DB469F01B8_impl*
 thePart.rDrawType := lpdHidden;
 if (anIndex = l3_fpiUp) AND
    l3IsNil(ParaX.AsObject.PCharLenA[k2_tiShortName]) then
  Exit;
 if (anIndex = l3_fpiUp) OR (anIndex = l3_fpiLeft) then
  thePart.rSpaceBefore := evDocumentPartMargin div 2;
//#UC END# *4804B9BB0383_49DB469F01B8_impl*
end;//TevControlsBlockPainter.GetFramePartPrim

procedure TevControlsBlockPainter.DoDrawFrameText(aTop: Boolean);
//#UC START# *4804C35B00B2_49DB469F01B8_var*

var
 l_InvertCount : Integer;

 procedure DropInvert;
 begin//DropInvert
  l_InvertCount := 0;
  while Area.rCanvas.Invert do
  begin
   Area.rCanvas.EndInvert;
   Inc(l_InvertCount);
  end;//while Area.rCanvas.Invert
 end;//DropInvert

 procedure RestoreInvert;
 begin//RestoreInvert
  while (l_InvertCount > 0) do
  begin
   Area.rCanvas.BeginInvert;
   Dec(l_InvertCount);
  end;//while Area.rCanvas.Invert
 end;//RestoreInvert

var
 l_Rect    : Tl3SRect;
 l_LeftS   : Tl3SPoint;
 l_Left    : Tl3Point;
 l_Extent  : Tl3Point;
 l_ExtentS  : Tl3SPoint;
 l_Name    : Tl3PCharLen{Tl3CustomString};
 l_BackColor : TColor;
 l_ImageInfo : TnevControlImageInfo;
 l_Y         : Integer;
 l_ImageList : Il3ImageList;
 l_IsCloak   : Boolean;
 l_IsNodeGroup   : Boolean;
 l_WO            : Tl3Point;
const
 cImageShift = l3Inch div 16;
 cGap = 4;
//#UC END# *4804C35B00B2_49DB469F01B8_var*
begin
//#UC START# *4804C35B00B2_49DB469F01B8_impl*
 if not aTop then
  Exit;
 l_Name := ParaX.AsObject.PCharLenA[k2_tiShortName]{evGetBlockName(ParaX)};
 if l3IsNil(l_Name) then
  Exit;
 Push;
 try
  PushWO;
  try
   l_IsCloak := ParaX.AsObject.IsKindOf(k2_typCloak);
   l_IsNodeGroup := ParaX.AsObject.IsKindOf(k2_typNodeGroup);
   if l_IsNodeGroup then
    DropInvert;
   try 
    if l_IsCloak then
     Area.rCanvas.MoveWindowOrg(l3Point(l3MulDiv(evDocumentPartMargin, 3, 4),
                                        evDocumentPartMargin div 2))
    else
     Area.rCanvas.MoveWindowOrg(l3Point1(evDocumentPartMargin div 2));
    if l_IsNodeGroup then
    begin
     l_WO := Area.rCanvas.WindowOrg.Neg;
     Area.rCanvas.MoveWindowOrg(l_WO.eX);
    end;//l_IsNodeGroup
    if l_IsNodeGroup then
     l_Left := l3Point(Spaces.Left{ + evControlBlockLeft}, evControlBlockTop)
    else
     l_Left := l3Point(Spaces.Left + evControlBlockLeft, evControlBlockTop);
    l_Extent.X := FormatInfo.rLimitWidth;
    if (l_Extent.X <= 0) then
     l_Extent.X := ParaX.AsObject.IntA[k2_tiWidth];
    l_Extent := l3Point(l_Extent.X - Spaces.Right, evControlBlockBefore - evControlBlockTop);
    if l_IsNodeGroup then
    begin
     l_Extent.X := l_Extent.X + l_WO.X;
     l_Extent.X := l_Extent.X + Area.rCanvas.DP2LP(PointX(2)).X;
    end;//l_IsNodeGroup
    evGetCustomImageList(ControlInfo, l_ImageInfo, ev_ctCollapsedPanel);
    if l_IsCloak then
    begin
     l_ImageList := nil;
     l_ImageInfo.rFirstIndex := -1;
     l_BackColor := cGarant2011BackColor;
    end//l_IsCloak
    else
    begin
     l_ImageList := l_ImageInfo.rImageList;
     if l_IsNodeGroup then
      l_BackColor := cGarant2011GradientStartColor
     else
      l_BackColor := cGarant2011CollapsedPanelColor{cGarant2011GradientStartColor}{c_MainMenuColor};
    end;//l_IsCloak
    Area.rCanvas.BackColor := l_BackColor;
    if l_IsNodeGroup then
     Area.rCanvas.FillRect(l3Rect(0{Area.rCanvas.DP2LP(PointX(10)).X},
                                  0,
                                  l_Extent.X,
                                  l_Extent.Y))
    else
     Area.rCanvas.FillRect(l3Rect(Area.rCanvas.DP2LP(PointX(10)).X,
                                  0,
                                  l_Extent.X,
                                  l_Extent.Y));
    l_LeftS := Area.rCanvas.LP2DP(l_Left);
    l_ExtentS := Area.rCanvas.LP2DP(l_Extent);
    with l_ExtentS do
     if l_IsCloak then
     begin
      if (l_ImageInfo.rImageList = nil) then
       l_Rect := l3SRect(0{l_LeftS.X{ + 20}, l_LeftS.Y, X, Y)
      else
       l_Rect := l3SRect(l_ImageInfo.rImageList.Width +
                         Area.rCanvas.LP2DP(l3PointX(cImageShift)).X + 6,
                         l_LeftS.Y - 2, X, Y);
     end//l_IsCloak
     else
     if l_IsNodeGroup then
      l_Rect := l3SRect(l_LeftS.X + 5{ + 20}, l_LeftS.Y, X, Y)
     else
      l_Rect := l3SRect(l_LeftS.X + 20, l_LeftS.Y, X, Y);
    if l_IsNodeGroup AND (l_InvertCount > 0) then
    begin
     Push;
     try
      Area.rCanvas.BackColor := clWhite;
      Area.rCanvas.FillRect(l3SRectBnd(l3SPoint(0,
                                       -cGap),
                                       l3SPoint(l_ExtentS.X{ + 2},
                                       cGap)));
      Area.rCanvas.FillRect(l3SRectBnd(l3SPoint(0,
                                       l_ExtentS.Y{ + 1}),
                                       l3SPoint(l_ExtentS.X{ + 2},
                                       2)));
(*      Area.rCanvas.FillRect(l3SRectBnd(l3SPoint(l_ExtentS.X,
                                       0),
                                       l3SPoint(2,
                                       l_ExtentS.Y)));*)
     finally
      Pop;
     end;//try..finally
(*      Area.rCanvas.FillRect(l3SRectBnd(l3SPoint(l_ExtentS.X,
                                       0),
                                       l3SPoint(2,
                                       l_ExtentS.Y)));*)
    end;//l_IsNodeGroup
    Area.rCanvas.Font := FormatInfo.FrameTextFont;
    if not l3IsNil(l_Name) then
     SmartCanvas.DrawCollapsedPanel(l_Name{.AsPCharLen},
                                    l_Rect,
                                    ParaX.AsObject.BoolA[k2_tiEnabled],
                                    Collapsed,
                                    ParaX.AsObject.BoolA[k2_tiUpper],
                                    ParaX.AsObject.BoolA[k2_tiChecked],
                                    ParaX.AsObject.BoolA[k2_tiFlat],
                                    l_BackColor,
                                    l3_taLeftJustify,
                                    l_ImageList,
                                    not l_IsNodeGroup);
    if l_IsCloak then
    begin
     if (l_ImageInfo.rLastIndex >= 0) then
      with Area.rCanvas do
      begin
       BackColor := l_BackColor;
       with LP2DP(l3Point(cImageShift, l_Extent.Y)) do
       begin
        l_Y := ((Y - l_ImageInfo.rImageList.Height) div 2);
        FillRect(l3SRect(X, l_Y,
                         X + l_ImageInfo.rImageList.Width,
                         l_Y + l_ImageInfo.rImageList.Height));
        l_ImageInfo.rImageList.Draw(As_Il3Canvas,
                                    X, l_Y,
                                    l_ImageInfo.rLastIndex,
                                    l3_dsTransparent,
                                    l3_itImage);
       end;//with LP2DP(l3Point(0, l_Extent.Y))
      end;//with Area.rCanvas
    end//l_IsCloak
    else
    if l_IsNodeGroup then
    begin
     // - ничего пока не делаем
    end//l_IsNodeGroup
    else
    begin
     Area.rCanvas.BackColor := l_BackColor;
     Area.rCanvas.Font.BackColor := l_BackColor;
     Area.rCanvas.Font.ForeColor := clBlack{clWhite};
     FocusRect(Tl3SRect(l_Rect));
    end;//not l_IsCloak
   finally
    if l_IsNodeGroup then
     RestoreInvert;
   end;//try..finally
  finally
   PopWO;
  end;//try..finally
 finally
  Pop;
 end;//try..finally
//#UC END# *4804C35B00B2_49DB469F01B8_impl*
end;//TevControlsBlockPainter.DoDrawFrameText

function TevControlsBlockPainter.NeedCheckTopAnchor: Boolean;
//#UC START# *481D6CCF016D_49DB469F01B8_var*
//#UC END# *481D6CCF016D_49DB469F01B8_var*
begin
//#UC START# *481D6CCF016D_49DB469F01B8_impl*
 Result := False;
//#UC END# *481D6CCF016D_49DB469F01B8_impl*
end;//TevControlsBlockPainter.NeedCheckTopAnchor

procedure TevControlsBlockPainter.DrawFrameName;
 {* Рисует имя блока в области рамки }
//#UC START# *49DB1B9E0191_49DB469F01B8_var*
//#UC END# *49DB1B9E0191_49DB469F01B8_var*
begin
//#UC START# *49DB1B9E0191_49DB469F01B8_impl*
//#UC END# *49DB1B9E0191_49DB469F01B8_impl*
end;//TevControlsBlockPainter.DrawFrameName

function TevControlsBlockPainter.IsTopAnchorAtStart: Boolean;
//#UC START# *4D9AF3680146_49DB469F01B8_var*
//#UC END# *4D9AF3680146_49DB469F01B8_var*
begin
//#UC START# *4D9AF3680146_49DB469F01B8_impl*
 Result := True;
//#UC END# *4D9AF3680146_49DB469F01B8_impl*
end;//TevControlsBlockPainter.IsTopAnchorAtStart
{$IfEnd} // Defined(evNeedPainters)

end.
