function TmsmDrawingView.ElementRect(const anElement: ImsmModelElement): Tl3SRect;
var
 l_X : Integer;
 l_Y : Integer;
 l_W : Integer;
 l_H : Integer;
 l_From : ImsmModelElement;
 l_To : ImsmModelElement;
 l_ToR : Tl3SRect;
 l_FromR : Tl3SRect;
 l_FromP : Tl3SPoint;
 l_ToP : Tl3SPoint;
 l_Line : TmsLineF;
begin
 if anElement.IsView then
 begin
  l_X := anElement.IntProp['msm:View:X'];
  l_Y := anElement.IntProp['msm:View:Y'];
  l_W := anElement.IntProp['msm:View:Width'];
  l_H := anElement.IntProp['msm:View:Height'];
  Result := l3SBounds(l_X, l_Y, l_W, l_H);
  Result.Inflate1(-10);
  Result := Result.SubPt(f_Origin);
 end//anElement.IsView
 else
 if anElement.IsViewLink then
 begin
  l_From := anElement.ElementProp['msm:View:From'];
  l_To := anElement.ElementProp['msm:View:To'];
  if (l_From <> nil) AND (l_To <> nil) then
  begin
   l_FromR := ElementRect(l_From);
   l_ToR := ElementRect(l_To);
   l_FromP.X := (l_FromR.Left + l_FromR.Right) div 2;
   l_FromP.Y := (l_FromR.Top + l_FromR.Bottom) div 2;
   l_ToP.X := (l_ToR.Left + l_ToR.Right) div 2;
   l_ToP.Y := (l_ToR.Top + l_ToR.Bottom) div 2;

   l_Line := TmsLineF_Create(l_FromP, l_ToP);
   TmsRectF_Create(l_FromR).Cross(l_Line, l_FromP);
   TmsRectF_Create(l_ToR).Cross(l_Line, l_ToP);
   Result := l3SRect(l_FromP, l_ToP);
  end//(l_From <> nil) AND (l_To <> nil)
  else
   Result := l3SRect(0, 0, 0, 0);
 end;//anElement.IsView
end;
