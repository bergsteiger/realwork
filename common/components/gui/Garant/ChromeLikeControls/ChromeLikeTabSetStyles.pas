unit ChromeLikeTabSetStyles;

interface
uses
  GDIPAPI,
  GDIPOBJ,
  Types,

  ChromeLikeTabSetTypes;

type
  TChromeLikeTabSetStyles = class
  public
    class function MakeBrush(aElement: TChromeLikeTabSetStyleElement;
                             aState: TChromeLikeTabSetElementState): TGPBrush;
    class function MakePen(aElement: TChromeLikeTabSetStyleElement;
                           aState: TChromeLikeTabSetElementState): TGPPen;
    class function MakeFont(aElement: TChromeLikeTabSetStyleElement;
                            aState: TChromeLikeTabSetElementState): TGPFont;
  end;


implementation
uses
 SysUtils,
 Windows,
 Graphics,

 l3Base,

 ChromeLikeTabSetUtils;

var
 g_ChromeLikeTabSetStyles: TChromeLikeTabSetStyles = nil;

const
  // General

  // Tab text font
  cTabTextFontName           : WideString = 'Tahoma';
  cTabTextFontSize           : Integer    = 11;
  cTabTextFontUnits          : GDIPAPI.TUnit      = GDIPAPI.UnitPixel;
  cTabTextFontStyle          : GDIPAPI.TFontStyle = GDIPAPI.FontStyleRegular;

  // Tab edge
  cTabEdgeWidth              : Single     = 1.0;

  // Close button cross
  cCloseButtonCrossWidth     : Single     = 1.0;

  // Normal
  cTabColor                  : TGPColor = $99FAF8F7;
  cTabLeftEdgeColor          : TGPColor = $99FFFFFF;
  cTabRightEdgeColor         : TGPColor = $99919191;
  cTabBottomEdgeColor        : TGPColor = $FFB2B2B2;

  // Selected
  cSelectedTabColor          : TGPColor = $FFFAF8F9;
  cSelectedTabLeftEdgeColor  : TGPColor = $FFFAF8F9;
  cSelectedTabRightEdgeColor : TGPColor = $FF919191;
  cSelectedTabBottomEdgeColor: TGPColor = $FFFAF8F9;

{ TChromeLikeTabSetStyles }


class function TChromeLikeTabSetStyles.MakeBrush(aElement: TChromeLikeTabSetStyleElement;
                                                 aState: TChromeLikeTabSetElementState): TGPBrush;
var
 l_Color: TGPColor;
begin
 l_Color := aclTransparent;
 case aElement of
  tsseTabBackground:
   if (aState = tsesNormal) then
    l_Color := cTabColor
   else
   if (aState = tsesActive) then
    l_Color := cSelectedTabColor;
  tsseNewTabButtonBackground:
   if (aState = tsesNormal) then
    l_Color := aclTransparent
   else
   if (aState = tsesHot) then
    l_Color := MakeGDIPcolor(RGB(0, 0, 0), 38);
  tsseNewTabButtonPlusSignBody:
   l_Color := MakeGDIPColor(RGB(0, 0, 0), 77);
 end;
 Result := TGPSolidBrush.Create(l_Color);
end;

class function TChromeLikeTabSetStyles.MakePen(aElement: TChromeLikeTabSetStyleElement;
                                               aState: TChromeLikeTabSetElementState): TGPPen;
var
 l_Width: Single;
 l_Color: TGPColor;
begin
 l_Color := aclTransparent;
 l_Width := cTabEdgeWidth;
 case aElement of
  tsseTabBorderLeft:
   if (aState = tsesActive) then
    l_Color := cSelectedTabLeftEdgeColor
   else
    l_Color := cTabLeftEdgeColor;
  tsseTabBorderRight:
   if (aState = tsesActive) then
    l_Color := cSelectedTabRightEdgeColor
   else
    l_Color := cTabLeftEdgeColor;
  tsseTabBorderBottom:
   if (aState = tsesActive) then
    l_Color := cSelectedTabBottomEdgeColor
   else
    l_Color := cSelectedTabBottomEdgeColor;
  tsseTabCloseButtonCross:
   begin
    if (aState = tsesHot) then
     l_Color := MakeGDIPColor(RGB(106, 106, 106))
    else
     l_Color := MakeGDIPColor(RGB(148, 148, 148));
    l_Width := cCloseButtonCrossWidth;
   end;
  tsseNewTabButtonPlusSignOutline:
   l_Color := MakeGDIPColor(RGB(255, 255, 255), 166);   
 end;
 Result := TGPPen.Create(l_Color, l_Width);
end;

class function TChromeLikeTabSetStyles.MakeFont(aElement: TChromeLikeTabSetStyleElement;
                                                aState: TChromeLikeTabSetElementState): TGPFont;
begin
 case aElement of
  tsseTabText:
   Result := TGPFont.Create(cTabTextFontName,
    cTabTextFontSize, cTabTextFontStyle, cTabTextFontUnits);
 end;
end;

end.
