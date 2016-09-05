unit evHAFPainter;

// Модуль: "w:\common\components\gui\Garant\Everest\evHAFPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHAFPainter" MUID: (4C22178C0102)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3InternalInterfaces
 , l3Interfaces
 , l3Variant
;

type
 TevHAFPainter = class(Tl3ProtoObject, Il3HAFPainter)
  private
   f_PagesCount: Integer;
   f_MacroReplacer: Il3HAFMacroReplacer;
  protected
   function pm_GetMacroReplacer: Il3HAFMacroReplacer;
   function MacroDocCurrentPage(const aCanvas: Il3Canvas): Il3CString;
   function MacroDocPagesCount: Il3CString;
   function DoNeedPagesCount: Boolean; virtual;
   function DocumentName: Il3CString;
   function NeedPagesCount: Boolean;
   procedure SetPagesCount(aValue: Integer);
   procedure StartPage(const CN: Il3Canvas;
    aTop: Boolean);
   function Get_MacroReplacer: Il3HAFMacroReplacer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aMacroReplacer: Il3HAFMacroReplacer); reintroduce; virtual;
   class function Make(const aMacroReplacer: Il3HAFMacroReplacer): Il3HAFPainter; reintroduce;
   procedure TuneHeader(const aCanvas: Il3Canvas;
    aHeader: Tl3Variant;
    aTop: Boolean); virtual; abstract;
  public
   property PagesCount: Integer
    read f_PagesCount
    write f_PagesCount;
   property MacroReplacer: Il3HAFMacroReplacer
    read pm_GetMacroReplacer;
 end;//TevHAFPainter

implementation

uses
 l3ImplUses
 , l3String
 , evHAFPainterMacros
 , nevRealTools
 , l3Units
 , nevTools
 , Graphics
 , Windows
 , evConst
 , evDef
 , Document_Const
 , SBS_Const
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evSBSPar
 {$IfEnd} // Defined(k2ForEditor)
 , evdTypes
 , nevHAFPainterView
 , l3Base
 //#UC START# *4C22178C0102impl_uses*
 //#UC END# *4C22178C0102impl_uses*
;

function TevHAFPainter.pm_GetMacroReplacer: Il3HAFMacroReplacer;
//#UC START# *5243CB3A0332_4C22178C0102get_var*
//#UC END# *5243CB3A0332_4C22178C0102get_var*
begin
//#UC START# *5243CB3A0332_4C22178C0102get_impl*
 Result := f_MacroReplacer;
//#UC END# *5243CB3A0332_4C22178C0102get_impl*
end;//TevHAFPainter.pm_GetMacroReplacer

function TevHAFPainter.MacroDocCurrentPage(const aCanvas: Il3Canvas): Il3CString;
//#UC START# *5243CC9F00C7_4C22178C0102_var*
//#UC END# *5243CC9F00C7_4C22178C0102_var*
begin
//#UC START# *5243CC9F00C7_4C22178C0102_impl*
 if (aCanvas.PageWidthNumber = 0) then
  Result := l3Fmt('%d', [aCanvas.PageNumber])
 else
  Result := l3Fmt('%d.%d', [aCanvas.PageNumber, aCanvas.PageWidthNumber]);
//#UC END# *5243CC9F00C7_4C22178C0102_impl*
end;//TevHAFPainter.MacroDocCurrentPage

function TevHAFPainter.MacroDocPagesCount: Il3CString;
//#UC START# *5243CCBB0100_4C22178C0102_var*
//#UC END# *5243CCBB0100_4C22178C0102_var*
begin
//#UC START# *5243CCBB0100_4C22178C0102_impl*
 Result := l3Fmt('%d', [PagesCount]);
//#UC END# *5243CCBB0100_4C22178C0102_impl*
end;//TevHAFPainter.MacroDocPagesCount

constructor TevHAFPainter.Create(const aMacroReplacer: Il3HAFMacroReplacer);
//#UC START# *5243CCEE0271_4C22178C0102_var*
//#UC END# *5243CCEE0271_4C22178C0102_var*
begin
//#UC START# *5243CCEE0271_4C22178C0102_impl*
 inherited Create;
 f_MacroReplacer := aMacroReplacer;
 PagesCount := 0;
//#UC END# *5243CCEE0271_4C22178C0102_impl*
end;//TevHAFPainter.Create

class function TevHAFPainter.Make(const aMacroReplacer: Il3HAFMacroReplacer): Il3HAFPainter;
var
 l_Inst : TevHAFPainter;
begin
 l_Inst := Create(aMacroReplacer);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevHAFPainter.Make

function TevHAFPainter.DoNeedPagesCount: Boolean;
//#UC START# *5243DA2102ED_4C22178C0102_var*
//#UC END# *5243DA2102ED_4C22178C0102_var*
begin
//#UC START# *5243DA2102ED_4C22178C0102_impl*
 Result := False;
//#UC END# *5243DA2102ED_4C22178C0102_impl*
end;//TevHAFPainter.DoNeedPagesCount

function TevHAFPainter.DocumentName: Il3CString;
//#UC START# *4728C10B0096_4C22178C0102_var*
//#UC END# *4728C10B0096_4C22178C0102_var*
begin
//#UC START# *4728C10B0096_4C22178C0102_impl*
 if Assigned(MacroReplacer) then
  Result := MacroReplacer.UnfoldOne(l3CStr(SDocName))
 else
  Result := nil;
//#UC END# *4728C10B0096_4C22178C0102_impl*
end;//TevHAFPainter.DocumentName

function TevHAFPainter.NeedPagesCount: Boolean;
//#UC START# *4728C12F0048_4C22178C0102_var*
//#UC END# *4728C12F0048_4C22178C0102_var*
begin
//#UC START# *4728C12F0048_4C22178C0102_impl*
 Result := DoNeedPagesCount;
//#UC END# *4728C12F0048_4C22178C0102_impl*
end;//TevHAFPainter.NeedPagesCount

procedure TevHAFPainter.SetPagesCount(aValue: Integer);
//#UC START# *4728C140024B_4C22178C0102_var*
//#UC END# *4728C140024B_4C22178C0102_var*
begin
//#UC START# *4728C140024B_4C22178C0102_impl*
 f_PagesCount := aValue;
//#UC END# *4728C140024B_4C22178C0102_impl*
end;//TevHAFPainter.SetPagesCount

procedure TevHAFPainter.StartPage(const CN: Il3Canvas;
 aTop: Boolean);
//#UC START# *4728C1490398_4C22178C0102_var*
var
 l_Header: Tl3Variant;
 l_Pnt: IevPainter;
 l_WO: Tl3Point;
 l_Delta: LongInt;
 l_Info: TnevShapeInfo;
 l_View: InevView;
 l_PrintableMargins: Tl3_Rect;
 l_Margins: Tl3_Rect;
 l_Points: TnevShapePoints;
 l_Area: TnevShapeAreaEx;
 l_Doc: Tl3Variant;
 l_S: InevObject;
//#UC END# *4728C1490398_4C22178C0102_var*
begin
//#UC START# *4728C1490398_4C22178C0102_impl*
 with CN do
 begin
  l_PrintableMargins := PageSetup.{Printable}Margins;
  l_WO := WindowOrg;
  Canvas.Pen.Color := clBlack;

  l_PrintableMargins.Right := DeviceCaps(PHYSICALOFFSETX);
  if not aTop then
  begin
   BackColor := clBlack;
   FillRect(l3Rect(l3PointX(l_PrintableMargins.Left),
                   l3Point(PageSetup.Width - l_PrintableMargins.Right,
                           DP2LP(PointY(PenWidth)).Y)));
   Line(l3PointX(l_PrintableMargins.Left),
        l3PointX(PageSetup.Width - l_PrintableMargins.Right));
   MoveWindowOrg(DP2LP(PointY(PenWidth)).e_Y);
   MoveWindowOrg(l3PointY(-evInchMul div 16));
  end;//not aTop

  with Font do
  begin
   Name := def_FontName;
   Size := 6;
   BackColor := clWhite;
  end;//with Font

  l_Doc := k2_typDocument.MakeTag.AsObject;
  try
   l_Header := k2_typSBS.MakeTag.AsObject;
   try
    l_Margins := PageSetup.Margins;
    l_Doc.IntA[k2_tiLeftIndent] := l_Margins.Left;
    l_Doc.IntA[k2_tiRightIndent] := l_Margins.Right;
    l_Doc.IntA[k2_tiWidth] := PageSetup.PaperWidth;
    evSBS_Init(l_Header, l_Doc.IntA[k2_tiWidth]);
    evSBS_LeftColumn(l_Header).IntA[k2_tiVerticalAligment] := Ord(ev_valTop);
    evSBS_RightColumn(l_Header).IntA[k2_tiVerticalAligment] := Ord(ev_valTop);
    l_Doc.AddChild(l_Header.AsObject);
    if not l_Doc.QT(InevObject, l_S) then
     Assert(false);

    if not (Assigned(CN.AbortChecker) and CN.AbortChecker.IsAborted) then
    begin
     l_View := TnevHAFPainterView.Make(l_S.ToList, CN);
     try
      TuneHeader(CN, l_Header, aTop);
      //l_Doc.QT(IevPainter, l_Pnt, nil);
      l_Header.QT(IevPainter, l_Pnt, nil);
      try
       MoveWindowOrg(l3PointX(-l_PrintableMargins.Left));
       l_Points.rTop := nil;
       l_Points.rCaret := nil;
       l_Points.rSelection := nil;
       l_Points.rPrevHeight := 0;
       l_Points.rRealTop := nil;
       l_Points.rFake := False;
       l_Points.rCheckCaret := nil;
       l_Points.rCheckSelection := nil;
       l_Area.Init(l_View, CN, false);
       try
        //l_Area.rLimitWidth := PageSetup.Width - (l_PrintableMargins.Left + l_PrintableMargins.Right);
        // - на это надо внимательнее посмотреть
        //   убрано в http://mdp.garant.ru/pages/viewpage.action?pageId=90441024
        l_Pnt.Draw(l_Area{$IfDef XE4}.rTnevShapeArea{$EndIf}, l_Points, l_Info);
       finally
        l_Area.Free;
       end;//try..finally
       MoveWindowOrg(l3PointX(l_PrintableMargins.Left));
       WindowOrg := l3Point(WindowOrg.X, -l_Info.rMap.Bounds.Bottom);
      finally
       l_Pnt := nil;
      end;//try..finally
     finally
      l_View := nil;
     end;//try..finally
    end;
   finally
    l_Header := nil;
   end;//try..finally
  finally
   l_Doc := nil;
  end;//try..finally

  if aTop then
  begin
   l_Delta := -(WindowOrg.Y - l_WO.Y);
   if (l_Delta < l_PrintableMargins.Top) then
    MoveWindowOrg(l3PointY(l_PrintableMargins.Top - l_Delta).Neg);
   Line(l3PointX(l_PrintableMargins.Left),
        l3PointX(PageSetup.Width - l_PrintableMargins.Right));
   MoveWindowOrg(DP2LP(PointY(PenWidth)).e_Y);
   MoveWindowOrg(l3PointY(-evInchMul div 16));
  end;//aTop
 end;//with CN
//#UC END# *4728C1490398_4C22178C0102_impl*
end;//TevHAFPainter.StartPage

function TevHAFPainter.Get_MacroReplacer: Il3HAFMacroReplacer;
//#UC START# *49539D77008C_4C22178C0102get_var*
//#UC END# *49539D77008C_4C22178C0102get_var*
begin
//#UC START# *49539D77008C_4C22178C0102get_impl*
 Result := pm_GetMacroReplacer;
//#UC END# *49539D77008C_4C22178C0102get_impl*
end;//TevHAFPainter.Get_MacroReplacer

procedure TevHAFPainter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C22178C0102_var*
//#UC END# *479731C50290_4C22178C0102_var*
begin
//#UC START# *479731C50290_4C22178C0102_impl*
 f_MacroReplacer := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4C22178C0102_impl*
end;//TevHAFPainter.Cleanup

procedure TevHAFPainter.ClearFields;
begin
 f_MacroReplacer := nil;
 inherited;
end;//TevHAFPainter.ClearFields

end.
