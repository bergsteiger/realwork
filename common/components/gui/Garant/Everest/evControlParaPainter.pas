unit evControlParaPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evControlParaPainter.pas"
// Начат: 02.11.2004 15:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::LeafPara Painters::TevControlParaPainter
//
// Инструмент для рисования параграфов типа Control.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  nevBase,
  evdTypes,
  l3Units,
  evTextParaPainterEx,
  l3Variant
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevControlParaPainter = class(TevTextParaPainterEx)
  {* Инструмент для рисования параграфов типа Control. }
 private
 // private methods
   procedure DrawImgListComponent(const aEditRect: Tl3SRect;
     aType: TevControlType;
     aPartialDraw: Boolean;
     aBtnWidth: Integer);
     {* Отрисовывает комопоненты с иконками }
 protected
 // overridden protected methods
   procedure DrawFrame; override;
     {* Процедура рисования видимой рамки вокруг параграфа. }
   function DrawLeaf: Boolean; override;
   procedure ValidateSegFont(aSeg: Tl3Variant); override;
   procedure ValidateParaFont; override;
 end;//TevControlParaPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}
uses
  k2Tags,
  l3InternalInterfaces,
  evControlParaTools,
  evControlParaConst,
  nevTools,
  Graphics,
  l3Interfaces,
  l3MinMax,
  TableCell_Const,
  HyperLink_Const,
  l3String,
  l3Defaults,
  Types
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}

// start class TevControlParaPainter

procedure TevControlParaPainter.DrawImgListComponent(const aEditRect: Tl3SRect;
  aType: TevControlType;
  aPartialDraw: Boolean;
  aBtnWidth: Integer);
//#UC START# *49DB2E950297_4804CDA403CE_var*
//#UC END# *49DB2E950297_4804CDA403CE_var*
var
 l_ImageInfo : TnevControlImageInfo;
begin
//#UC START# *49DB2E950297_4804CDA403CE_impl*
 evGetCustomImageList(ControlInfo, l_ImageInfo, aType);
 case aType of
  ev_ctButton, ev_ctStateButton:
   begin
    SmartCanvas.DrawPictureButton(aEditRect, ParaX.AsObject.BoolA[k2_tiUpper],
      ParaX.AsObject.BoolA[k2_tiEnabled], evChecked2State(ParaX.AsObject), TopBC,
      l_ImageInfo.rImageList, l_ImageInfo.rFirstIndex);
   end;//ev_ctButton, ev_ctStateButton
  ev_ctPictureLabel:
   begin
    SmartCanvas.DrawHelpControl(aEditRect, TopBC,
                                l_ImageInfo.rImageList, l_ImageInfo.rFirstIndex);
   end;//ev_ctPictureLabel
  ev_ctEllipsesEdit, ev_ctCalEdit:
    SmartCanvas.DrawElipsisEdit(aEditRect, aBtnWidth, ParaX.AsObject.BoolA[k2_tiEnabled],
      Caret <> nil, false, not ParaX.AsObject.BoolA[k2_tiFlat], aPartialDraw,
      l_ImageInfo.rImageList,
      l_ImageInfo.rFirstIndex);
 end;//case aType
//#UC END# *49DB2E950297_4804CDA403CE_impl*
end;//TevControlParaPainter.DrawImgListComponent

procedure TevControlParaPainter.DrawFrame;
//#UC START# *4804B76803D5_4804CDA403CE_var*
const
 lc_State: array [Boolean] of Tl3CheckBoxState = (l3_cbUnchecked, l3_cbChecked);
var
 l_Type        : TevControlType;
 l_EditRectL   : Tl3Rect;
 l_Enabled     : Boolean;
 l_BorderWidth : Integer;
 l_ButtonWidth : Integer;
 l_EditRect    : Tl3SRect;
 l_FirstIndent : Integer;
 l_Height      : Integer;
 //l_OuterMap    : TnevFormatInfoPrim;
 l_NCR  : Tl3Rect;
//#UC END# *4804B76803D5_4804CDA403CE_var*
begin
//#UC START# *4804B76803D5_4804CDA403CE_impl*
 if ParaX.AsObject.BoolA[k2_tiVisible] and
    Area.rCanvas.DrawEnabled and not Area.rCanvas.IsVirtual then
    // - рисуем элементы оформления только если честное рисование и канва не виртуальная
 begin
  l_EditRectL := Tl3Rect(Map.Bounds);
  l_Type := TevControlType(ParaX.AsObject.IntA[k2_tiType]);
  l_Height := 0;
(*  if (l_Type = ev_ctPictureLabel) then
   if ParaX.Owner.IsKindOf(k2_typTableCell) then
   begin
    l_OuterMap := FormatInfo.ParentInfo;
    if (l_OuterMap <> nil) then
    begin
     l_OuterMap := l_OuterMap.ParentInfo;
     if (l_OuterMap <> nil) then
     begin
      l_Height := l_OuterMap.DeltaHeight - FormatInfo.Height;*)
(*      if (l_Height > 0) then
       l_EditRectL.Bottom := l_EditRectL.Bottom + l_Height;*)
      // - здесь правильно, что ничего не увеличивается,
(*      //   т.к. УЖЕ увеличили при расчёте Map.Bounds в DrawLeaf см. l_FillParent
     end;//l_OuterMap <> nil
    end;//l_OuterMap <> nil
   end;//ParaX.Owner.IsKindOf(k2_typTableCell)*)
  Area.rCanvas.PushWO;
  try
   Area.rCanvas.WindowOrg := l3Point(l_EditRectL.Left, l_EditRectL.Top).Neg;
   l_EditRectL := l_EditRectL.SubPt(l_EditRectL.TopLeft);
   l_EditRect := Area.rCanvas.WO(l_EditRectL);
   if (Caret <> nil) then
   begin
(*    Dec(l_EditRect.R.Right, 2);
    Dec(l_EditRect.R.Bottom, 2);*)
   end;//Caret <> nil

   l_Enabled := ParaX.AsObject.BoolA[k2_tiEnabled];
   l_ButtonWidth := Area.rCanvas.LP2DP(Tl3Rect(Spaces).BottomRight).X;

   case l_Type of
    ev_ctEdit, ev_ctEmailEdit, ev_ctPhoneEdit:
     SmartCanvas.DrawEdit(l_EditRect, l_Enabled, (Caret <> nil), false,
       not ParaX.AsObject.BoolA[k2_tiFlat], false, l_BorderWidth);
    ev_ctMemoEdit:
    begin
     l_EditRect.Left := l_EditRect.Left +
                        Area.rCanvas.LP2DP(l3PointX(ParaX.AsObject.IntA[k2_tiFirstIndent])).X - 2;
     SmartCanvas.DrawEdit(l_EditRect, l_Enabled, (Caret <> nil), false,
       not ParaX.AsObject.BoolA[k2_tiFlat], false, l_BorderWidth);
    end;//ev_ctMemoEdit
    ev_ctCombo:
     SmartCanvas.DrawComboBox(l_EditRect, l_ButtonWidth, l_Enabled,
       Caret <> nil, False, not ParaX.AsObject.BoolA[k2_tiFlat], false,
       ParaX.AsObject.BoolA[k2_tiChecked]);
    ev_ctButton,
    ev_ctPictureLabel,
    ev_ctStateButton,
    ev_ctEllipsesEdit,
    ev_ctCalEdit:
    begin
     case l_Type of
      ev_ctButton,
      ev_ctStateButton:
       l_EditRect.Bottom := l_EditRect.Bottom - 2;
      ev_ctPictureLabel:
      begin
       if (l_Height > 0) then
        l_EditRect.Bottom := l_EditRect.Bottom - 2;
       l_EditRect.Right := l_EditRect.Right - 4;
      end;//ev_ctPictureLabel 
     end;//case l_Type
     DrawImgListComponent(l_EditRect, l_Type, false, l_ButtonWidth);
    end;//ev_ctButton..
    ev_ctSpinedit:
      SmartCanvas.DrawSpinEditBox(l_EditRect, l_ButtonWidth, l_Enabled,
        Caret <> nil, false, false, not ParaX.AsObject.BoolA[k2_tiFlat]);
    ev_ctLabel:
     if l_Enabled then
      l_EditRect.Inflate1(1);
    ev_ctCheckEdit, ev_ctRadioEdit:
    begin
     l_FirstIndent := Area.rCanvas.LP2DP(l3PointX(ParaX.AsObject.IntA[k2_tiFirstIndent])).X;
     SmartCanvas.DrawCheckOrRadio(l_Type = ev_ctCheckEdit,
                     l3SRect(l_EditRect.Left + 1,
                             l_EditRect.Top + 2,
                             l_EditRect.Left + l_FirstIndent - 2,
                             l_EditRect.Bottom),
                             lc_State[ParaX.AsObject.BoolA[k2_tiChecked]],
                             l_Enabled,
                             ParaX.AsObject.BoolA[k2_tiFlat]);
     l_EditRect.Left := l_EditRect.Left + l_FirstIndent - 3;
    end;//ev_ctCheckEdit, ev_ctRadioEdit
   end;//Case l_Type
   if (l_Type in evEditControls) then
   begin
    if (Caret <> nil) then
    begin
     PushBC;
     try
      with Area.rCanvas do
      begin
       Area.rCanvas.PushClipRect;
       try
        l_EditRect.Inflate(2, 2);
        l_NCR := Area.rCanvas.DR2LR(l_EditRect);
        Area.rCanvas.ClipRect := l_NCR;
        Area.rCanvas.FillEmptyRect(l_EditRect);
        l_EditRect.Inflate(-2, -2);

        Canvas.Brush.Color := cGarant2011KZInnerBorderColor;
        Canvas.FrameRect(TRect(l_EditRect));
        Canvas.Brush.Color := cGarant2011KZBorderColor;
        l_EditRect.Inflate(1, 1);
        Canvas.FrameRect(TRect(l_EditRect));
        l_EditRect.Inflate(1, 1);
        Canvas.FrameRect(TRect(l_EditRect));
       finally
        Area.rCanvas.PopClipRect;
       end;//try..finally
      end;//with Area.rCanvas
     finally
      PopBC;
     end;//try..finally
    end;//Caret <> nil
   end;//l_Type in evEditControls
  finally
   Area.rCanvas.PopWO;
  end;//try..finally
 end;//ParaX.BoolA[k2_tiVisible] and Area.rCanvas.DrawEnabled and not Area.rCanvas.IsVirtual
//#UC END# *4804B76803D5_4804CDA403CE_impl*
end;//TevControlParaPainter.DrawFrame

function TevControlParaPainter.DrawLeaf: Boolean;
//#UC START# *4804C81000B9_4804CDA403CE_var*
var
 l_Type        : TevControlType;
 l_ExtendX     : Integer;
 l_Spaces      : TnevRect;
 l_EditRect    : Tl3SRect;
 l_EditRectL   : TnevRect;
 l_Visible     : Boolean;
 l_Enabled     : Boolean;
 l_H           : Integer;
 l_WO          : Tl3Point;
 l_NeedDrawRect: Boolean;
 l_Height      : Integer;
// l_OuterMap    : TnevFormatInfoPrim;
 l_FillParent  : Boolean;
 l_FullRect    : Tl3Rect;
//#UC END# *4804C81000B9_4804CDA403CE_var*
begin
//#UC START# *4804C81000B9_4804CDA403CE_impl*
 l_WO := Area.rCanvas.WindowOrg;
 l_NeedDrawRect := Area.rCanvas.ShowCursor and
                   Assigned(Caret) and
                   not Caret.HasInner and
                   not Caret.NeedWindowsCaret;
 l_Visible := ParaX.AsObject.BoolA[k2_tiVisible];
 l_Type := TevControlType(ParaX.AsObject.IntA[k2_tiType]);
 l_Spaces := Spaces;
 l_ExtendX := FormatInfo.Width;
 if not (l_Type in evCheckableControls) then
 begin
  l_Spaces.Top := l_Spaces.Top div 2;
  l_Spaces.Bottom := l_Spaces.Bottom div 2;
 end;//not (l_Type in evCheckableControls)
 l_EditRectL.Left := l_Spaces.Left;
 l_EditRectL.Top := l_Spaces.Top;
 if not (l_Type in evSimpleEditors) then
  l_EditRectL.Right := l_ExtendX + l_Spaces.Right
 else
  l_EditRectL.Right := l_ExtendX;
 l_Height := FormatInfo.Height;
 l_FillParent := false;
(* if (l_Type = ev_ctPictureLabel) then
  if ParaX.Owner.IsKindOf(k2_typTableCell) then
  begin
   l_OuterMap := FormatInfo.ParentInfo;
   if (l_OuterMap <> nil) then
   begin
    l_OuterMap := l_OuterMap.ParentInfo;
    if (l_OuterMap <> nil) then
    begin
     l_FillParent := true;
     l_Height := l_OuterMap.DeltaHeight;
    end;//l_OuterMap <> nil
   end;//l_OuterMap <> nil
  end;//ParaX.Owner.IsKindOf(k2_typTableCell)*)
 l_EditRectL.Bottom := l_Height - TopAnchor.AsLeaf.PaintOffsetY(Area.rView.As_InevView, FormatInfo) - l_Spaces.Bottom;
 l_Enabled := ParaX.AsObject.BoolA[k2_tiEnabled];
 PushBC;
 try
  l_H := l_EditRectL.Bottom;
  if l_Visible and (l_Type in evTextControls) then
  begin
   PushFC;
   try
    if (l_Type in evEditControls) then
    begin
     l_EditRectL.Left := l_EditRectL.Left - Area.rCanvas.DP2LP(PointX(3)).X;
     if l_Enabled then
      Area.rCanvas.BackColor := clWindow;
     if not ParaX.AsObject.BoolA[k2_tiValid] then
      Area.rCanvas.Font.ForeColor := evErrorColor;
    end;//l_Type in evEditControls
    Result := inherited DrawLeaf;
    l_H := Area.rCanvas.RegionBottomRight.Y + Area.rCanvas.WindowOrg.Y;
    if l_FillParent then
     l_H := Max(l_H, l_EditRectL.Bottom);
    if (l_Type = ev_ctMemoEdit) then
     Inc(l_H, Max(0, (evMemoLineCount * Area.rCanvas.AverageCharHeight - l_Height)));
    if (l_Type in evEditControls + [ev_ctPictureLabel]) then
     Inc(l_H, Area.rCanvas.DP2LP(PointY(4)).Y);
    l_EditRectL.Bottom := l_H - l_Spaces.Bottom;
    if (l_Type in evEditControls) then
    begin
     if l_Enabled then
     begin
      Area.rCanvas.BackColor := clWindow;
      Area.rCanvas.FillEmptyRect(Tl3Rect(l_EditRectL));
     end;//l_Enabled
    end;//l_Type in evEditControls
    Area.rCanvas.BackColor := TopBC;
   finally
    PopFC;
   end;//try..finally
  end//l_Visible
  else
   Result := true;
  l_FullRect := l3Rect(0, 0, l_ExtendX + l_Spaces.Right, l_H);
  Area.rCanvas.FillEmptyRect(l_FullRect);
  // - заливаем то, что предок недозалил
  if l_Visible and Area.rCanvas.DrawEnabled and not Area.rCanvas.IsVirtual {and l_NeedDrawRect} then
  // - рисуем элементы оформления только если честное рисование и канва не виртуальная
  begin
   l_EditRect := Area.rCanvas.WO(Tl3Rect(l_EditRectL));
   case l_Type of
    ev_ctButton, ev_ctStateButton:
    begin
     l_EditRect := l_EditRect.SubPt(l3SPoint(1,1));
     l_EditRect.Bottom := l_EditRect.Bottom - 2;
    end;
    ev_ctPictureLabel:
     l_EditRect.Right := l_EditRect.Right - 2;
    ev_ctLabel:
     if l_Enabled then
      l_EditRect.Inflate1(1);
    ev_ctCheckEdit, ev_ctRadioEdit:
     l_EditRect.Left := l_EditRect.Left + Area.rCanvas.LP2DP(l3PointX(ParaX.AsObject.IntA[k2_tiFirstIndent])).X - 3;
   end;//case l_Type
   if l_NeedDrawRect then
   begin
    FocusRect(l_EditRect);
    Area.rCanvas.ShowCursor := False;
   end;//l_NeedDrawRect
  end;//if l_Visible
  Dec(l_WO.P.Y, l_H);
  Area.rCanvas.WindowOrg := l_WO;
  // - fix: Неправильное формирование Map.rBounds. Залечено
  //  шаманством. Потом надо рефакторить КЗ по полной
  //  (cq22945, 22952, 22867, 22937, 22939, 22981, ...)
 finally
  PopBC;
 end;//try..finally
//#UC END# *4804C81000B9_4804CDA403CE_impl*
end;//TevControlParaPainter.DrawLeaf

procedure TevControlParaPainter.ValidateSegFont(aSeg: Tl3Variant);
//#UC START# *4D664903006E_4804CDA403CE_var*
//#UC END# *4D664903006E_4804CDA403CE_var*
begin
//#UC START# *4D664903006E_4804CDA403CE_impl*
 inherited;
 if aSeg.IsKindOf(k2_typHyperlink) then
  if not ParaX.AsObject.BoolA[k2_tiEnabled] then
   Area.rCanvas.Font.ForeColor := clSilver;
//#UC END# *4D664903006E_4804CDA403CE_impl*
end;//TevControlParaPainter.ValidateSegFont

procedure TevControlParaPainter.ValidateParaFont;
//#UC START# *4D725A550218_4804CDA403CE_var*
//#UC END# *4D725A550218_4804CDA403CE_var*
begin
//#UC START# *4D725A550218_4804CDA403CE_impl*
 inherited;
 if l3IsNil(ParaX.AsObject.PCharlenA[k2_tiText]) then
  if (ParaX.AsObject.IntA[k2_tiType] = Ord(ev_ctMemoEdit)) then
   Area.rCanvas.Font.ForeColor := clSilver;
//#UC END# *4D725A550218_4804CDA403CE_impl*
end;//TevControlParaPainter.ValidateParaFont

{$IfEnd} //evNeedPainters

end.