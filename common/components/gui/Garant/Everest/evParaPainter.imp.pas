{$IfNDef evParaPainter_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evParaPainter.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "evParaPainter" MUID: (4804A2C101A5)
// Имя типа: "_evParaPainter_"

{$Define evParaPainter_imp}

{$If Defined(evNeedPainters)}
 {$Include w:\common\components\gui\Garant\Everest\new\nevTinyParaXTool.imp.pas}
 _evParaPainter_ = class(_nevTinyParaXTool_, Il3FrameTextPainter, InevDrawingShape, IevPainter, InevK235870994Hacker)
  {* Базовая реализация инструмента для рисования параграфа. }
  private
   f_Hidden: Boolean;
   f_NeedsHackK235870994: Boolean;
   f_Collapsed: Boolean;
   f_DrawingTopmostChild: Boolean;
    {* Рисуется самый верхний ребенок? }
   f_DrawingLastChild: Boolean;
    {* Рисуется самый последний ребенок? }
   f_DrawCompleted: Boolean;
   f_PrevHeight: Integer;
    {* Рассчитанная на предыдущей странице высота }
   f_WasInit: Boolean;
    {* TopAcnhor пришло "сверху". }
   f_RealTopAnchor: InevBasePoint;
   f_Fake: Boolean;
   f_CheckCaret: InevBasePoint;
   f_CheckSelRange: InevRange;
   f_BottomAnchor: InevBasePoint;
   f_ParentPainter: IevPainter;
    {* Инструмент для рисования объекта более верхнего уровня. }
   f_ParaMarkStyle: TevParaMarkStyle;
    {* Стиль рисования конца параграфа. }
   f_Area: PnevShapeArea;
    {* Область вывода }
   f_SmartCanvas: Il3SmartCanvas;
   f_Caret: InevBasePoint;
   f_TopAnchor: InevBasePoint;
   f_SelRange: InevRange;
   f_Map: InevMap;
   f_FormatInfo: TInevFormatInfoRet;
   f_Spaces: TnevRect;
    {* Отступы параграфа }
   f_ViewMetrics: InevViewMetrics;
  protected
   f_ForceFocusRect: Boolean;
   f_HeaderHeight: Integer;
  private
   procedure DrawBlockSub;
  protected
   function pm_GetVerticalAlignmentMargin: Integer; virtual;
   function pm_GetInvisibleFrameColor: TnevColor; virtual;
   function pm_GetSmartCanvas: Il3SmartCanvas;
   function NeedsHackK235870994: Boolean; virtual;
   function ControlInfo: TnevControlInfo;
   procedure FillUnfilled(const aRect: Tl3Rect); virtual;
    {* Заливает область параграфа, которая не была залита }
   procedure DrawDecorObject(aDecorObj: Tl3Variant;
    aCollapsed: Boolean;
    aDecorType: TnevDecorType); overload;
    {* Рисует декроативный элемент параграфа }
   procedure DrawDecorObject(aCollapsed: Boolean;
    aTop: Boolean); overload;
   function HackMargin: Integer; virtual;
    {* Отступ, который не надо заливать цетом родителя }
   procedure CheckFormatInfo;
   function GetBackColor: TnevColor; virtual;
   function BeginDraw: Boolean;
   procedure EndDraw;
   procedure Push;
   procedure Pop;
   procedure DoInitAlignObjects; virtual;
    {* Инициализация выравнивания объекта. }
   procedure DoFinisAlignObjects; virtual;
    {* Окончательное выравнивание рамок. }
   procedure PushWO;
   procedure PopWO;
   procedure PushFC;
   procedure PopFC;
   procedure PushBC;
   procedure PopBC;
   function TopBC: TnevColor;
   procedure DrawFrame; virtual;
    {* Процедура рисования видимой рамки вокруг параграфа. }
   procedure DrawFramePrim;
    {* Нарисовать рамку. }
   function InfiniteFrame: Boolean; virtual;
   procedure DoFillSelection; virtual;
   procedure CheckAlignment(var aFrame: Tl3Frame); virtual;
   procedure SetDrawnBottom;
   procedure DoDrawLines; virtual;
   procedure GetFramePart(aFrame: Tl3Variant;
    anIndex: Tl3FramePartIndex;
    var thePart: TnevFramePart);
   procedure GetFramePartPrim(aFrame: Tl3Variant;
    anIndex: Tl3FramePartIndex;
    var thePart: TnevFramePart); virtual;
   function DoDraw: Boolean; virtual;
    {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
   procedure DrawSubs;
   procedure evDrawSub(aLayerID: Integer;
    aSub: Tl3Variant;
    const aPara: InevPara);
   procedure InitBottom(var theBottom: InevBasePoint;
    var theCellBottom: InevBasePoint); virtual;
   procedure FocusRect(const aRect: Tl3SRect);
   procedure DoDrawFrameText(aTop: Boolean); virtual;
   procedure DoDrawFramePrim(const aFrame: Tl3Frame); virtual;
   function GetPaintersHolder: InevPaintersHolder; virtual;
   function GetTablePainter: IevTablePainter; virtual;
   function GetTableRowPainter: IevTableRowPainter; virtual;
   function IsTopAnchorAtStart: Boolean; virtual;
   procedure DrawFrameText(aTop: Boolean);
    {* Рисует текст рамки. }
   function Draw(const anArea: TnevShapeArea;
    const aPoints: TnevShapePoints;
    out theInfo: TnevShapeInfo): Boolean;
   function pm_GetParentPainter: IevPainter;
   procedure pm_SetParentPainter(const aValue: IevPainter);
   function pm_GetCurrentBlock: InevRange;
   function pm_GetDrawingTopmostChild: Boolean;
   function pm_GetDrawingLastChild: Boolean;
   function pm_GetParaMarkStyle: TevParaMarkStyle;
   procedure pm_SetParaMarkStyle(aValue: TevParaMarkStyle);
   function Get_PaintersHolder: InevPaintersHolder;
   function Get_TablePainter: IevTablePainter;
   function Get_TableRowPainter: IevTableRowPainter;
   function HackK235870994(const aMap: InevMap): Boolean;
   function Get_Obj: InevObjectPrim;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   class function Make(aTag: Tl3Variant): IevPainter; reintroduce;
  protected
   property Collapsed: Boolean
    read f_Collapsed;
   property DrawingTopmostChild: Boolean
    read f_DrawingTopmostChild
    write f_DrawingTopmostChild;
    {* Рисуется самый верхний ребенок? }
   property DrawingLastChild: Boolean
    read f_DrawingLastChild
    write f_DrawingLastChild;
    {* Рисуется самый последний ребенок? }
   property DrawCompleted: Boolean
    read f_DrawCompleted;
   property VerticalAlignmentMargin: Integer
    read pm_GetVerticalAlignmentMargin;
   property WasInit: Boolean
    read f_WasInit;
    {* TopAcnhor пришло "сверху". }
   property BottomAnchor: InevBasePoint
    read f_BottomAnchor;
   property ParentPainter: IevPainter
    read f_ParentPainter;
    {* Инструмент для рисования объекта более верхнего уровня. }
   property ParaMarkStyle: TevParaMarkStyle
    read f_ParaMarkStyle
    write f_ParaMarkStyle;
    {* Стиль рисования конца параграфа. }
   property InvisibleFrameColor: TnevColor
    read pm_GetInvisibleFrameColor;
   property Area: PnevShapeArea
    read f_Area;
    {* Область вывода }
   property SmartCanvas: Il3SmartCanvas
    read pm_GetSmartCanvas;
   property Caret: InevBasePoint
    read f_Caret;
   property TopAnchor: InevBasePoint
    read f_TopAnchor;
   property SelRange: InevRange
    read f_SelRange;
   property Map: InevMap
    read f_Map;
   property FormatInfo: TInevFormatInfoRet
    read f_FormatInfo;
   property Spaces: TnevRect
    read f_Spaces;
    {* Отступы параграфа }
   property ViewMetrics: InevViewMetrics
    read f_ViewMetrics;
  public
   property PrevHeight: Integer
    read f_PrevHeight
    write f_PrevHeight;
    {* Рассчитанная на предыдущей странице высота }
   property RealTopAnchor: InevBasePoint
    read f_RealTopAnchor;
   property Fake: Boolean
    read f_Fake;
   property CheckCaret: InevBasePoint
    read f_CheckCaret;
   property CheckSelRange: InevRange
    read f_CheckSelRange;
 end;//_evParaPainter_

{$Else Defined(evNeedPainters)}

{$Include w:\common\components\gui\Garant\Everest\new\nevTinyParaXTool.imp.pas}
_evParaPainter_ = _nevTinyParaXTool_;

{$IfEnd} // Defined(evNeedPainters)
{$Else evParaPainter_imp}

{$IfNDef evParaPainter_imp_impl}

{$Define evParaPainter_imp_impl}

{$If Defined(evNeedPainters)}
{$Include w:\common\components\gui\Garant\Everest\new\nevTinyParaXTool.imp.pas}

function _evParaPainter_.pm_GetVerticalAlignmentMargin: Integer;
//#UC START# *4804AA7A003A_4804A2C101A5get_var*
//#UC END# *4804AA7A003A_4804A2C101A5get_var*
begin
//#UC START# *4804AA7A003A_4804A2C101A5get_impl*
 Result := 0;
//#UC END# *4804AA7A003A_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetVerticalAlignmentMargin

function _evParaPainter_.pm_GetInvisibleFrameColor: TnevColor;
//#UC START# *4804A83F030B_4804A2C101A5get_var*
//#UC END# *4804A83F030B_4804A2C101A5get_var*
begin
//#UC START# *4804A83F030B_4804A2C101A5get_impl*
 Result := clGray;
//#UC END# *4804A83F030B_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetInvisibleFrameColor

function _evParaPainter_.pm_GetSmartCanvas: Il3SmartCanvas;
//#UC START# *4804A98600F2_4804A2C101A5get_var*
//#UC END# *4804A98600F2_4804A2C101A5get_var*
begin
//#UC START# *4804A98600F2_4804A2C101A5get_impl*
 if (f_SmartCanvas = nil) then
  f_SmartCanvas := Tl3SmartCanvas.Make(Area.rCanvas.As_Il3Canvas);
 Result := f_SmartCanvas;
//#UC END# *4804A98600F2_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetSmartCanvas

function _evParaPainter_.NeedsHackK235870994: Boolean;
//#UC START# *4CAF3D530327_4804A2C101A5_var*
//#UC END# *4CAF3D530327_4804A2C101A5_var*
begin
//#UC START# *4CAF3D530327_4804A2C101A5_impl*
 Result := false;
//#UC END# *4CAF3D530327_4804A2C101A5_impl*
end;//_evParaPainter_.NeedsHackK235870994

function _evParaPainter_.ControlInfo: TnevControlInfo;
//#UC START# *4E26AF7C0183_4804A2C101A5_var*
//#UC END# *4E26AF7C0183_4804A2C101A5_var*
begin
//#UC START# *4E26AF7C0183_4804A2C101A5_impl*
 Result := TnevControlInfo_C(ParaX, FormatInfo, Area.rView.Metrics);
//#UC END# *4E26AF7C0183_4804A2C101A5_impl*
end;//_evParaPainter_.ControlInfo

procedure _evParaPainter_.FillUnfilled(const aRect: Tl3Rect);
 {* Заливает область параграфа, которая не была залита }
//#UC START# *4E2702FE01EA_4804A2C101A5_var*
//#UC END# *4E2702FE01EA_4804A2C101A5_var*
begin
//#UC START# *4E2702FE01EA_4804A2C101A5_impl*
 Area.rCanvas.FillEmptyRect(aRect);
//#UC END# *4E2702FE01EA_4804A2C101A5_impl*
end;//_evParaPainter_.FillUnfilled

procedure _evParaPainter_.DrawBlockSub;
//#UC START# *4E4E5405011F_4804A2C101A5_var*
{$IfDef ParaPainter_IsParaListPainter}
{$IfDef Nemesis}
var
 l_MI   : InevBasePoint;
 l_Para : InevPara;
{$EndIf Nemesis}
{$EndIf ParaPainter_IsParaListPainter}
//#UC END# *4E4E5405011F_4804A2C101A5_var*
begin
//#UC START# *4E4E5405011F_4804A2C101A5_impl*
{$IfDef ParaPainter_IsParaListPainter}
 {$IF Defined(Archi) or Defined(EverestLite)}
 if f_TopAnchor.AtStart then
  evDrawSub(ParaX.IntA[k2_tiLayerID], ParaX.AsObject, ParaX)
 {$ELSE}
 if (f_TopAnchor.VertPosition(Area.rView.As_InevView, FormatInfo) <= 0) then
  evDrawSub(ParaX.AsObject.IntA[k2_tiLayerID], ParaX.AsObject, ParaX)
 {$IFEND}
 else
 begin
  {$IfDef Nemesis}
  l_MI := f_TopAnchor.MostInner;
  if (l_MI <> nil) then
  begin
   l_Para := l_MI.Obj.AsPara.Prev;
   if (l_Para <> nil) AND l_Para.AsObject.IsValid then
    if (l_Para.PID < 10) then
     if l_Para.AsObject.Owner.IsSame(ParaX.AsObject) then
     begin
      if (l_MI.VertPosition(Area.rView.As_InevView, nil) <= 0) then
       while (l_Para <> nil) AND l_Para.AsObject.IsValid AND not l_Para.IsList do
       begin
        if Area.rView.FormatInfoByPara(l_Para).IsHidden(false, false) then
        begin
         if (l_Para.PID = 0) then
         begin
          evDrawSub(ParaX.AsObject.IntA[k2_tiLayerID], ParaX.AsObject, ParaX);
          break;
         end;//if (l_Para.PID = 0
        end//l_Para.IsHidden(ViewMetrics,
        else
         break;
        l_Para := l_Para.Prev;
       end;//while (l_Para <> nil) AND l_Para.IsValid
     end;//l_Para.PID < 10
  end;//l_MI <> nil
  {$EndIf Nemesis}
  // - открутил Люлин А.В. ибо - http://mdp.garant.ru/pages/viewpage.action?pageId=154075236&focusedCommentId=172359849#comment-172359849
 end;//f_TopAnchor.VertPosition(Area.rView.As_InevView, FormatInfo^) <= 0
{$EndIf ParaPainter_IsParaListPainter}
//#UC END# *4E4E5405011F_4804A2C101A5_impl*
end;//_evParaPainter_.DrawBlockSub

procedure _evParaPainter_.DrawDecorObject(aDecorObj: Tl3Variant;
 aCollapsed: Boolean;
 aDecorType: TnevDecorType);
 {* Рисует декроативный элемент параграфа }
//#UC START# *4E6DC0D1005C_4804A2C101A5_var*
var
 //l_Obj    : InevObject;
 l_SegInf : TnevShapeInfo;
 l_Points : TnevShapePoints;
 //l_Point  : InevPoint;
 l_Pnt    : IevPainter;
 l_BC     : TColor;
 l_NCR    : Tl3Rect;
 l_Margin : Integer;
 l_Printing : Boolean;
 l_Cont : InevObjectHolder;
//#UC END# *4E6DC0D1005C_4804A2C101A5_var*
begin
//#UC START# *4E6DC0D1005C_4804A2C101A5_impl*
 if aDecorObj.IsValid AND aDecorObj.QT(IevPainter, l_Pnt) then
 begin
  l_Cont := ParaX.Holder;
  if (l_Cont <> nil) then
   if not l_Cont.AllowsThisDecor(FormatInfo.DecorFormatInfo(aDecorType), aDecorType) then
   // - не показываем декорации, которые нам контейнер запретил
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011
    Exit
   else
   if not Area.rView.Metrics.AllowsThisDecor(FormatInfo.DecorFormatInfo(aDecorType), aDecorType) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=321986755
    Exit;
  if not aCollapsed OR (aDecorType = nev_dtHeader) then
  begin
   l_Pnt.ParentPainter := Self;
   with Area.rCanvas do
   begin
    l_NCR := PushClipRect;
    try
     PushWO;
     try
      l_BC := aDecorObj.IntA[k2_tiBackColor];
      l_Margin := HackMargin;
      l_NCR.Right := Min(l_NCR.Right, FormatInfo.rLimitWidth - l_Margin);
      if (l_BC <> clDefault) then
       l_NCR.Right := l_NCR.Right + 2 * l_Margin;
      ClipRect := l_NCR;
      l3FillChar(l_Points, SizeOf(l_Points));
      l_Points.rTop := nil;
      l_Points.rCaret := nil;
      l_Points.rSelection := nil;
      l_Points.rPrevHeight := 0;
      l_Points.rRealTop := nil;
      l_Points.rFake := False;
      l_Points.rCheckCaret := nil;
      l_Points.rCheckSelection := nil;
      l_Printing := Printing;
      if l_Printing then
       BeginInvert;
      try
       l_Pnt.Draw(Area^, l_Points, l_SegInf);
      finally
       if l_Printing then
        EndInvert;
      end;//try..finally
     finally
      PopWO;
     end;//try..finally
     f_HeaderHeight := l_SegInf.rMap.FI.Height;
     if (l_BC <> clDefault) then
     // - тут затираем правый "хвостик" неправильного цвета, который нам зальёт
     //   добрый родитель.
     begin
      PushBC;
      try
       BackColor := l_BC;
       FillRect(l3Rect(l_NCR.Right - l_Margin, 0, l_NCR.Right, f_HeaderHeight));
      finally
       PopBC;
      end;//try..finally
     end;//l_BC <> clDefault
     MoveWindowOrg(l3PointY(-f_HeaderHeight));
    finally
     PopClipRect;
    end;//try..finally
   end;//with Area.rCanvas
  end;//not aCollapsed..
 end;//nObj.IsValid
//#UC END# *4E6DC0D1005C_4804A2C101A5_impl*
end;//_evParaPainter_.DrawDecorObject

procedure _evParaPainter_.DrawDecorObject(aCollapsed: Boolean;
 aTop: Boolean);
//#UC START# *4E6F27EE0065_4804A2C101A5_var*
var
 l_DT : TnevDecorType;
//#UC END# *4E6F27EE0065_4804A2C101A5_var*
begin
//#UC START# *4E6F27EE0065_4804A2C101A5_impl*
 if aTop then
  l_DT := nev_dtHeader
 else
  l_DT := nev_dtFooter;
 DrawDecorObject(FormatInfo.DecorObj(l_DT), false, l_DT);
//#UC END# *4E6F27EE0065_4804A2C101A5_impl*
end;//_evParaPainter_.DrawDecorObject

function _evParaPainter_.HackMargin: Integer;
 {* Отступ, который не надо заливать цетом родителя }
//#UC START# *4E6F459F0278_4804A2C101A5_var*
//#UC END# *4E6F459F0278_4804A2C101A5_var*
begin
//#UC START# *4E6F459F0278_4804A2C101A5_impl*
 Result := 0;
//#UC END# *4E6F459F0278_4804A2C101A5_impl*
end;//_evParaPainter_.HackMargin

procedure _evParaPainter_.CheckFormatInfo;
//#UC START# *50B6FE9F01F8_4804A2C101A5_var*
//#UC END# *50B6FE9F01F8_4804A2C101A5_var*
begin
//#UC START# *50B6FE9F01F8_4804A2C101A5_impl*
 if (f_FormatInfo <> nil) and (f_FormatInfo.Obj = nil) and (Map <> nil) and (Map.FI <> nil) then
  f_FormatInfo := Map.FI;
//#UC END# *50B6FE9F01F8_4804A2C101A5_impl*
end;//_evParaPainter_.CheckFormatInfo

function _evParaPainter_.GetBackColor: TnevColor;
//#UC START# *55CC33A10342_4804A2C101A5_var*
//#UC END# *55CC33A10342_4804A2C101A5_var*
begin
//#UC START# *55CC33A10342_4804A2C101A5_impl*
 Result := ParaX.BackColor;
//#UC END# *55CC33A10342_4804A2C101A5_impl*
end;//_evParaPainter_.GetBackColor

class function _evParaPainter_.Make(aTag: Tl3Variant): IevPainter;
var
 l_Inst : _evParaPainter_;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_evParaPainter_.Make

function _evParaPainter_.BeginDraw: Boolean;
//#UC START# *4804B3D1001F_4804A2C101A5_var*
var
 l_BC      : TnevColor;
 l_NeedEnd : Boolean;
//#UC END# *4804B3D1001F_4804A2C101A5_var*
begin
//#UC START# *4804B3D1001F_4804A2C101A5_impl*
 f_ForceFocusRect := false;
 l_NeedEnd := false;
 try
  Push;
  Area.rCanvas.PushLineSpacing;
  Area.rCanvas.StartRegion;
  DoInitAlignObjects;
  f_NeedsHackK235870994 := false;
  if not Area.rView.IsValid then
  begin
   f_Spaces := nevRect0;
   Result := true;
   f_FormatInfo := nil;
  end//Area.rView. = nil
  else
  begin
   Area.rView.BeginDrawShape(ParaX, TopAnchor,
                             Area.rCanvas.WindowOrg.
                              //Sub(Area.rCanvas.InitialDCOffset).
                              //// http://mdp.garant.ru/pages/viewpage.action?pageId=265398068
                              //// учитываем смещение от DC
                              // убрано. Ошибка была в TnevControl.DP2LP
                              // http://mdp.garant.ru/pages/viewpage.action?pageId=296623811
                               Neg,
                             f_Map, f_Fake, Self);
   l_NeedEnd := true;
   f_FormatInfo := Map.CheckFormatInfo(ParaX);
   Assert(f_FormatInfo <> nil);
   Area.rCanvas.LineSpacing := f_FormatInfo.LineSpacing;
   f_Spaces := f_FormatInfo.Spacing;
   if f_NeedsHackK235870994 then
   begin
    //Area.rCanvas.WindowOrg := l3Point(Area.rCanvas.WindowOrg.X, -f_Map.Bounds.Bottom);
    Result := false;
   end//f_NeedsHackK235870994
   else
    Result := not FormatInfo.IsHidden(false, Area.rCanvas.Printing);
  end;//Area.rView = nil

  if (f_Map <> nil) then
   f_Map.AdjustTopByAnchor(Area.rView.As_InevView, TopAnchor);

  l_BC := GetBackColor;
  Area.rCanvas.BackColor := l_BC;
 except
  if l_NeedEnd then
   if Area.rView.IsValid then
    Area.rView.EndDrawShape;
    // - надо закрыть уже открытую скобку - чтобы соблюдать парность
  raise;  
 end;//try..except
//#UC END# *4804B3D1001F_4804A2C101A5_impl*
end;//_evParaPainter_.BeginDraw

procedure _evParaPainter_.EndDraw;
//#UC START# *4804B3E20013_4804A2C101A5_var*

 procedure l_FocusRect(const aRect: Tl3SRect);
 begin
  if not Caret.HasInner then
  begin
   Push;
   try
    with Area.rCanvas do
    begin
     BackColor := clBlack;
     FillForeRect(l3SRect(aRect.Left, aRect.Top, aRect.Right, aRect.Top + 1));
     FillForeRect(l3SRect(aRect.Left, aRect.Bottom - 1, aRect.Right, aRect.Bottom));
     FillForeRect(l3SRect(aRect.Left, aRect.Top, aRect.Left + 1, aRect.Bottom - 1));
     FillForeRect(l3SRect(aRect.Right, aRect.Top, aRect.Right + 1, aRect.Bottom{ - 1}));
    end;//with Area.rCanvas
   finally
    Pop;
   end;//try..finally
  end;//not Caret.HasInner
 end;//l_FocusRect

var
 l_DrawExtent    : Tl3Point;
 l_NotInPrinting : Boolean;
 l_NCR           : Tl3Rect;
 l_Delta         : Integer;
//#UC END# *4804B3E20013_4804A2C101A5_var*
begin
//#UC START# *4804B3E20013_4804A2C101A5_impl*
 if Area.rView.IsValid then
  Area.rView.EndDrawShape;
 DoFinisAlignObjects;

 if (Map <> nil) then
 begin
  PushWO;
  try
   with Tl3Rect(Map.Bounds) do
    l_DrawExtent := BottomRight.Sub(TopLeft);
   if not f_Hidden then // http://mdp.garant.ru/pages/viewpage.action?pageId=236719931
   begin
    l_NotInPrinting := (not Area.rCanvas.Printing OR (l_DrawExtent.Y > Spaces.Top));
    if l_NotInPrinting then
    begin
     DrawFrame;
     if f_Collapsed then
      SetDrawnBottom;
     DoDrawLines;
    end
    else
     DrawFrame;
   end;//not f_Hidden
   if f_ForceFocusRect then
   begin
    with Area.rCanvas do
    begin
     l_NCR := PushClipRect;
     try
      l_Delta := DP2LP(PointX(2)).X;
      l_NCR.Left := l_NCR.Left - l_Delta;
      // http://mdp.garant.ru/pages/viewpage.action?pageId=207004464
      // Сдвигаем область отсечения для рисования рамки в "запрещённой" области
      ClipRect := l_NCR;
      with Map, Tl3Rect(Bounds) do
       l_FocusRect(LR2DR(l3Rect(Left - l_Delta,
                                   //^ это запил для http://mdp.garant.ru/pages/viewpage.action?pageId=207004464
                                Top,
                                Right,
                                Top + FI.Height).
                                AddPt(WindowOrg)));
     finally
      PopClipRect;
     end;//try..finally
    end;//with Area.rCanvas
   end;//f_ForceFocusRect
  finally
   PopWO;
  end;//try..finally
  DoFillSelection;
 end;//Map <> nil
 Area.rCanvas.FinishRegion;
 Area.rCanvas.PopLineSpacing;
 Pop;
//#UC END# *4804B3E20013_4804A2C101A5_impl*
end;//_evParaPainter_.EndDraw

procedure _evParaPainter_.Push;
//#UC START# *4804B5E2025D_4804A2C101A5_var*
//#UC END# *4804B5E2025D_4804A2C101A5_var*
begin
//#UC START# *4804B5E2025D_4804A2C101A5_impl*
 PushBC;
 PushFC;
//#UC END# *4804B5E2025D_4804A2C101A5_impl*
end;//_evParaPainter_.Push

procedure _evParaPainter_.Pop;
//#UC START# *4804B5EC00C1_4804A2C101A5_var*
//#UC END# *4804B5EC00C1_4804A2C101A5_var*
begin
//#UC START# *4804B5EC00C1_4804A2C101A5_impl*
 PopFC;
 PopBC;
//#UC END# *4804B5EC00C1_4804A2C101A5_impl*
end;//_evParaPainter_.Pop

procedure _evParaPainter_.DoInitAlignObjects;
 {* Инициализация выравнивания объекта. }
//#UC START# *4804B5FC02A3_4804A2C101A5_var*
//#UC END# *4804B5FC02A3_4804A2C101A5_var*
begin
//#UC START# *4804B5FC02A3_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804B5FC02A3_4804A2C101A5_impl*
end;//_evParaPainter_.DoInitAlignObjects

procedure _evParaPainter_.DoFinisAlignObjects;
 {* Окончательное выравнивание рамок. }
//#UC START# *4804B60E033E_4804A2C101A5_var*
//#UC END# *4804B60E033E_4804A2C101A5_var*
begin
//#UC START# *4804B60E033E_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804B60E033E_4804A2C101A5_impl*
end;//_evParaPainter_.DoFinisAlignObjects

procedure _evParaPainter_.PushWO;
//#UC START# *4804B6290257_4804A2C101A5_var*
//#UC END# *4804B6290257_4804A2C101A5_var*
begin
//#UC START# *4804B6290257_4804A2C101A5_impl*
 Area.rCanvas.PushWO;
//#UC END# *4804B6290257_4804A2C101A5_impl*
end;//_evParaPainter_.PushWO

procedure _evParaPainter_.PopWO;
//#UC START# *4804B64001B5_4804A2C101A5_var*
//#UC END# *4804B64001B5_4804A2C101A5_var*
begin
//#UC START# *4804B64001B5_4804A2C101A5_impl*
 Area.rCanvas.PopWO;
//#UC END# *4804B64001B5_4804A2C101A5_impl*
end;//_evParaPainter_.PopWO

procedure _evParaPainter_.PushFC;
//#UC START# *4804B64C0196_4804A2C101A5_var*
//#UC END# *4804B64C0196_4804A2C101A5_var*
begin
//#UC START# *4804B64C0196_4804A2C101A5_impl*
 Area.rCanvas.PushFC;
//#UC END# *4804B64C0196_4804A2C101A5_impl*
end;//_evParaPainter_.PushFC

procedure _evParaPainter_.PopFC;
//#UC START# *4804B6560035_4804A2C101A5_var*
//#UC END# *4804B6560035_4804A2C101A5_var*
begin
//#UC START# *4804B6560035_4804A2C101A5_impl*
 Area.rCanvas.PopFC;
//#UC END# *4804B6560035_4804A2C101A5_impl*
end;//_evParaPainter_.PopFC

procedure _evParaPainter_.PushBC;
//#UC START# *4804B66003AB_4804A2C101A5_var*
//#UC END# *4804B66003AB_4804A2C101A5_var*
begin
//#UC START# *4804B66003AB_4804A2C101A5_impl*
 Area.rCanvas.PushBC;
//#UC END# *4804B66003AB_4804A2C101A5_impl*
end;//_evParaPainter_.PushBC

procedure _evParaPainter_.PopBC;
//#UC START# *4804B669016B_4804A2C101A5_var*
//#UC END# *4804B669016B_4804A2C101A5_var*
begin
//#UC START# *4804B669016B_4804A2C101A5_impl*
 Area.rCanvas.PopBC;
//#UC END# *4804B669016B_4804A2C101A5_impl*
end;//_evParaPainter_.PopBC

function _evParaPainter_.TopBC: TnevColor;
//#UC START# *4804B674039C_4804A2C101A5_var*
//#UC END# *4804B674039C_4804A2C101A5_var*
begin
//#UC START# *4804B674039C_4804A2C101A5_impl*
 Result := Area.rCanvas.TopBC;
//#UC END# *4804B674039C_4804A2C101A5_impl*
end;//_evParaPainter_.TopBC

procedure _evParaPainter_.DrawFrame;
 {* Процедура рисования видимой рамки вокруг параграфа. }
//#UC START# *4804B76803D5_4804A2C101A5_var*
//#UC END# *4804B76803D5_4804A2C101A5_var*
begin
//#UC START# *4804B76803D5_4804A2C101A5_impl*
 DrawFramePrim;
//#UC END# *4804B76803D5_4804A2C101A5_impl*
end;//_evParaPainter_.DrawFrame

procedure _evParaPainter_.DrawFramePrim;
 {* Нарисовать рамку. }
//#UC START# *4804B77A039C_4804A2C101A5_var*
var
 l_FrameTag : Tl3Variant;
 l_Bounds   : TnevRect;
 l_Frame    : Tl3Frame;
 l_Index    : Tl3FramePartIndex;
//#UC END# *4804B77A039C_4804A2C101A5_var*
begin
//#UC START# *4804B77A039C_4804A2C101A5_impl*
 l_FrameTag := ParaX.AsObject.Attr[k2_tiFrame];
 l_Bounds := Map.Bounds;
 l_Frame.rRect := l_Bounds;
 l_Frame.rInfinite := InfiniteFrame;
 for l_Index := Low(l_Index) to High(l_Index) do
  GetFramePart(l_FrameTag, l_Index, l_Frame.rP[l_Index]);
 CheckAlignment(l_Frame);
 DoDrawFramePrim(l_Frame);
//#UC END# *4804B77A039C_4804A2C101A5_impl*
end;//_evParaPainter_.DrawFramePrim

function _evParaPainter_.InfiniteFrame: Boolean;
//#UC START# *4804B78B0397_4804A2C101A5_var*
//#UC END# *4804B78B0397_4804A2C101A5_var*
begin
//#UC START# *4804B78B0397_4804A2C101A5_impl*
 Result := False;
//#UC END# *4804B78B0397_4804A2C101A5_impl*
end;//_evParaPainter_.InfiniteFrame

procedure _evParaPainter_.DoFillSelection;
//#UC START# *4804B86403BE_4804A2C101A5_var*
//#UC END# *4804B86403BE_4804A2C101A5_var*
begin
//#UC START# *4804B86403BE_4804A2C101A5_impl*
 with Tl3Rect(Map.Bounds) do
  with Area.rCanvas do
   FillUnfilled(l3RectBnd(Tl3Point(nevPt0), BottomRight.Add(WindowOrg)));
//#UC END# *4804B86403BE_4804A2C101A5_impl*
end;//_evParaPainter_.DoFillSelection

procedure _evParaPainter_.CheckAlignment(var aFrame: Tl3Frame);
//#UC START# *4804B8890228_4804A2C101A5_var*
//#UC END# *4804B8890228_4804A2C101A5_var*
begin
//#UC START# *4804B8890228_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804B8890228_4804A2C101A5_impl*
end;//_evParaPainter_.CheckAlignment

procedure _evParaPainter_.SetDrawnBottom;
//#UC START# *4804B95A02C8_4804A2C101A5_var*
var
 l_Bounds : TnevRect;
 l_Bottom : TnevPoint;
//#UC END# *4804B95A02C8_4804A2C101A5_var*
begin
//#UC START# *4804B95A02C8_4804A2C101A5_impl*
 if (Map <> nil) then
 begin
  l_Bounds := Map.Bounds;
  with Area.rCanvas do
  begin
   l_Bottom := RegionBottomRight;
   if not Printing then
   begin
    if not DrawEnabled then
     l_Bottom.Y := Max(l_Bottom.Y, l_Bounds.Bottom);
     // - не обрезаем параграф снизу, при рисовании курсора
   end;//not Printing
  end;//with Area.rCanvas
  Map.SetDrawnBottom(l_Bottom);
(*  if (FormatInfo.rHeight = 0) then
   FormatInfo.wHeight(l_Bottom.Y - l_Bounds.Top);*)
  //Assert(FormatInfo.rHeight > 0);
  // - это теперь не нужно, т.к. высода должна считаться по-требованию 
 end;//Map <> nil
//#UC END# *4804B95A02C8_4804A2C101A5_impl*
end;//_evParaPainter_.SetDrawnBottom

procedure _evParaPainter_.DoDrawLines;
//#UC START# *4804B96C002F_4804A2C101A5_var*
//#UC END# *4804B96C002F_4804A2C101A5_var*
begin
//#UC START# *4804B96C002F_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804B96C002F_4804A2C101A5_impl*
end;//_evParaPainter_.DoDrawLines

procedure _evParaPainter_.GetFramePart(aFrame: Tl3Variant;
 anIndex: Tl3FramePartIndex;
 var thePart: TnevFramePart);
//#UC START# *4804B982007C_4804A2C101A5_var*
//#UC END# *4804B982007C_4804A2C101A5_var*
begin
//#UC START# *4804B982007C_4804A2C101A5_impl*
 l3FillChar(thePart, SizeOf(thePart), 0);
 thePart.rDrawType := lpdHidden;
 Case anIndex of
  l3_fpiUp :
   if not Area.rCanvas.Printing then
   begin
    if not IsTopAnchorAtStart then
     Exit;
    if (Area.rCanvas.WindowOrg.Y > Map.Bounds.Top) then
    // - это актуально для ячеек таблиц
    // !!! ещё бы вспомнить - зачем
     if ParaX.AsObject.IsKindOf(k2_typTableCell) then
      Exit;
   end;//not Area.rCanvas.Printing
  l3_fpiDown :
   if not DrawCompleted AND not Area.rCanvas.Printing then
    Exit;
 end;//Case anIndex
 GetFramePartPrim(aFrame, anIndex, thePart);
//#UC END# *4804B982007C_4804A2C101A5_impl*
end;//_evParaPainter_.GetFramePart

procedure _evParaPainter_.GetFramePartPrim(aFrame: Tl3Variant;
 anIndex: Tl3FramePartIndex;
 var thePart: TnevFramePart);
//#UC START# *4804B9BB0383_4804A2C101A5_var*
//#UC END# *4804B9BB0383_4804A2C101A5_var*
begin
//#UC START# *4804B9BB0383_4804A2C101A5_impl*
 with aFrame do
  if IsValid then
  begin
   with Attr[k2_tiFrameUp + Ord(anIndex)] do
    if IsValid then
    begin
     thePart.rDrawType := lpdDraw;
     thePart.rWidth := Area.rCanvas.LP2DP(l3PointY(IntA[k2_tiWidth])).Y;
     thePart.rColor := IntA[k2_tiForeColor];
     thePart.rSpaceBefore := IntA[k2_tiSpaceBefore];
     thePart.rSpaceAfter := IntA[k2_tiSpaceAfter];
    end;//IsValid
  end;//IsValid
//#UC END# *4804B9BB0383_4804A2C101A5_impl*
end;//_evParaPainter_.GetFramePartPrim

function _evParaPainter_.DoDraw: Boolean;
 {* Собственно процедура рисования параграфа. Для перекрытия в потомках. }
//#UC START# *4804BC2401C2_4804A2C101A5_var*
//#UC END# *4804BC2401C2_4804A2C101A5_var*
begin
//#UC START# *4804BC2401C2_4804A2C101A5_impl*
 Result := True;
//#UC END# *4804BC2401C2_4804A2C101A5_impl*
end;//_evParaPainter_.DoDraw

procedure _evParaPainter_.DrawSubs;
//#UC START# *4804BC570301_4804A2C101A5_var*

var
 l_Prev : InevPara;

 function DrawSubLayer(aLayer: Tl3Variant; Index: Integer): Boolean;

  function l_DrawSub(aSub: Tl3Variant; Index: Integer): Boolean;
  begin//l_DrawSub
   Result := true;
   evDrawSub(aLayer.IntA[k2_tiHandle], aSub.AsObject, l_Prev);
  end;//l_DrawSub

 begin//DrawSubLayer
  aLayer.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@l_DrawSub));
  Result := true;
 end;//DrawSubLayer

//#UC END# *4804BC570301_4804A2C101A5_var*
begin
//#UC START# *4804BC570301_4804A2C101A5_impl*
 if Area.rCanvas.CanDrawSubs then
 begin
  l_Prev := ParaX;
  l_Prev.AsObject.Attr[k2_tiSubs].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DrawSubLayer));
  if (ViewMetrics.HiddenStyles <> []) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=232095992
   if not l_Prev.IsList then
   begin
    while true do
    begin
     l_Prev := EvPrevOverallPara(l_Prev);
     if (l_Prev <> nil) AND l_Prev.AsObject.IsValid then
     begin
      if Area.rView.FormatInfoByPara(l_Prev).IsHidden(false, false) then
      begin
       l_Prev.AsObject.Attr[k2_tiSubs].IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DrawSubLayer));
       continue;
      end;//l_Prev.IsHiddenPrim
     end;//l_Prev <> nil
     break;
    end;//while true
   end;//not l_Prev.IsList
 end;//Area.rCanvas.CanDrawSubs
//#UC END# *4804BC570301_4804A2C101A5_impl*
end;//_evParaPainter_.DrawSubs

procedure _evParaPainter_.evDrawSub(aLayerID: Integer;
 aSub: Tl3Variant;
 const aPara: InevPara);
//#UC START# *4804BC640021_4804A2C101A5_var*
var
 l_Rect          : Tl3Rect;
 {$If Defined(Nemesis)}
 l_PrevParaIndex : Integer;
 {$IfEnd}
 {$IfDef Nemesis}
 l_Handle        : Integer;
 {$EndIf Nemesis}
//#UC END# *4804BC640021_4804A2C101A5_var*
begin
//#UC START# *4804BC640021_4804A2C101A5_impl*
 assert(aSub <> nil);
 if aSub.IsKindOf(k2_typDocumentSub) then
  Exit;
 if not aSub.HasSubAtom(k2_tiHandle) then
  if not aSub.Attr[k2_tiHandle].IsValid then
  begin
   {$IfDef Nemesis}
   if aSub.IsKindOf(k2_typMark) then
   begin
    l_Handle := Integer(aPara.AsObject);
    if (l_Handle < 0) then
     l_Handle := -l_Handle;
    aSub.IntA[k2_tiHandle] := l_Handle;
   end//Atom.IsKindOf(k2_typMark)
   else
   if (aLayerID = Ord(ev_sbtBookMark)) then
   begin
   end//aLayerHandle = ev_sbtBookMark
   else
   {$EndIf Nemesis}
    Exit;
  end;//not aSub.Attr[k2_tiHandle].IsValid
 {$IfDef Nemesis}
 if (aLayerID = Ord(ev_sbtMark)) AND aPara.AsObject.IsKindOf(k2_typLeafPara) AND
    evInPara(aPara.AsObject, k2_typCommentPara) then
  // - не рисуем второго человечка
  Exit;
 {$EndIf Nemesis}
 with Area.rCanvas do
 begin
  l_Rect.R.TopLeft := WindowOrg.Neg;
  l_Rect.R.BottomRight := l_Rect.TopLeft.Add(l3Point1(AverageCharHeight));
 end;//with Area.rCanvas
 {$IfDef Nemesis}
 if f_Hidden AND
    (aLayerID = Ord(ev_sbtMark)) then
 begin
  if ((aSub.IntA[k2_tiFlags] = ev_cUserCommentFlags) OR
     (aPara.AsObject.rAtomEx([k2_tiSubs,
                 k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub)]).ChildrenCount = 0)) then
  begin
   // - поднимаем "человечка" на предыдущий параграф
   l_PrevParaIndex := Pred(aPara.PID);
   if (l_PrevParaIndex >= 0) then
   begin
    with aPara.OwnerPara[l_PrevParaIndex] do
    begin
     l_Rect.OffsetPt(l3PointY({-Shape.Height}0)); // <stub> - Height
     if aPara.AsObject.IsKindOf(k2_typLeafPara) then
     begin
      l_Rect.OffsetPt(l3PointY(-Spaces.Top));
      // - поднимаем "человечка" выше отступа текущего параграфа
     end;//Para.IsKindOf(k2_typLeafPara)
     Dec(l_PrevParaIndex);
     if (l_PrevParaIndex >= 0) AND
        (aSub.IntA[k2_tiFlags] <> ev_cUserCommentFlags) AND
        AsObject.IsKindOf(k2_typTextPara) AND IsEmpty then
     begin
      // - поднимаем "человечка" выше пустого параграфа
      with aPara.OwnerPara[l_PrevParaIndex] do
       l_Rect.OffsetPt(l3PointY({-Shape.Height}0)); // <stub> - Height
     end;//l_PrevParaIndex >= 0
    end;//with Para.OwnerPara[l_PrevParaIndex]
   end;//l_PrevParaIndex >= 0
  end//aSub.IntA[k2_tiFlags] = ev_UserCommentFlags..
  else
  begin
   l_PrevParaIndex := Succ(aPara.PID);
   if (l_PrevParaIndex < aPara.OwnerPara.ParaCount) then
   begin
    with aPara.OwnerPara[l_PrevParaIndex] do
     if AsObject.IsKindOf(k2_typTextPara) AND IsEmpty then
     begin
      // - опускаем "человечка" ниже пустого параграфа
      with aPara.OwnerPara[l_PrevParaIndex] do
       l_Rect.OffsetPt(l3PointY({Shape.Height}0)); // <stub> - Height
      Inc(l_PrevParaIndex);
     end;//l_PrevParaIndex >= 0
   end;//l_PrevParaIndex < Para.OwnerPara.ChildrenCount
   if (l_PrevParaIndex < aPara.OwnerPara.ParaCount) then
    // - опускаем "человечка" ниже отступа следующего параграфа
    with aPara.OwnerPara[l_PrevParaIndex] do
     l_Rect.OffsetPt(l3PointY(AsObject.IntA[k2_tiSpaceBefore]));
  end;//aSub.IntA[k2_tiFlags] = ev_UserCommentFlags
 end;//f_Hidden..
 {$EndIf Nemesis}
 {$IfDef ParaPainter_IsParaListPainter}
 if aSub.IsKindOf(k2_typBlock) then
  l_Rect.OffsetPt(l3PointY(aSub.IntA[k2_tiSpaceBefore]));
 {$EndIf ParaPainter_IsParaListPainter} 
 Area.rCanvas.DrawSub(aPara.AsObject, l_Rect, aLayerID, aSub);
//#UC END# *4804BC640021_4804A2C101A5_impl*
end;//_evParaPainter_.evDrawSub

procedure _evParaPainter_.InitBottom(var theBottom: InevBasePoint;
 var theCellBottom: InevBasePoint);
//#UC START# *4804BC800172_4804A2C101A5_var*
//#UC END# *4804BC800172_4804A2C101A5_var*
begin
//#UC START# *4804BC800172_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804BC800172_4804A2C101A5_impl*
end;//_evParaPainter_.InitBottom

procedure _evParaPainter_.FocusRect(const aRect: Tl3SRect);
//#UC START# *4804C28F0120_4804A2C101A5_var*
var
 l_R  : Tl3SRect;
 l_NC : Boolean;
//#UC END# *4804C28F0120_4804A2C101A5_var*
begin
//#UC START# *4804C28F0120_4804A2C101A5_impl*
 if (Caret <> nil) AND not Caret.HasInner then
 begin
  Push;
  try
   l_NC := Caret.NeedWindowsCaret;
   with Area.rCanvas do
   begin
    if ShowCursor OR not l_NC then
    begin
     l_R := aRect;
     l_R.Inflate1(-1);
(*     with Canvas do
     begin
      Pen.Color := clWindowFrame;
      Brush.Color := clBtnFace;
     end;//with Canvas*)
(*     SetTextColor(DC, Graphics.ColorToRGB(Font.ForeColor));
     SetBkColor(DC, Graphics.ColorToRGB(BackColor));
     SetBkMode(DC, OPAQUE);  {Transparent}*)
     Canvas.Brush.Color := ColorToRGB(Font.ForeColor) xor ColorToRGB(BackColor);
     //Font.ForeColor := Font.ForeColor;
     //Font.ForeColor := clBlack;
     DrawFocusRect(l_R);
     SetCaret(l3PointX(0), l3Point(AverageCharWidth, AverageCharHeight), not l_NC);
     ShowCursor := false;
    end;//ShowCursor
   end;//with Area.rCanvas
  finally
   Pop;
  end;//try..finally
 end;//Caret <> nil
//#UC END# *4804C28F0120_4804A2C101A5_impl*
end;//_evParaPainter_.FocusRect

procedure _evParaPainter_.DoDrawFrameText(aTop: Boolean);
//#UC START# *4804C35B00B2_4804A2C101A5_var*
//#UC END# *4804C35B00B2_4804A2C101A5_var*
begin
//#UC START# *4804C35B00B2_4804A2C101A5_impl*
 // ничего не делаем
//#UC END# *4804C35B00B2_4804A2C101A5_impl*
end;//_evParaPainter_.DoDrawFrameText

procedure _evParaPainter_.DoDrawFramePrim(const aFrame: Tl3Frame);
//#UC START# *49182FE60081_4804A2C101A5_var*
//#UC END# *49182FE60081_4804A2C101A5_var*
begin
//#UC START# *49182FE60081_4804A2C101A5_impl*
 with Area.rCanvas do
  FrameLines.DrawFrame(As_Il3Canvas, aFrame, Self);
//#UC END# *49182FE60081_4804A2C101A5_impl*
end;//_evParaPainter_.DoDrawFramePrim

function _evParaPainter_.GetPaintersHolder: InevPaintersHolder;
//#UC START# *49DB948303B9_4804A2C101A5_var*
//#UC END# *49DB948303B9_4804A2C101A5_var*
begin
//#UC START# *49DB948303B9_4804A2C101A5_impl*
 Result := nil;
//#UC END# *49DB948303B9_4804A2C101A5_impl*
end;//_evParaPainter_.GetPaintersHolder

function _evParaPainter_.GetTablePainter: IevTablePainter;
//#UC START# *49DCA7F3011C_4804A2C101A5_var*
//#UC END# *49DCA7F3011C_4804A2C101A5_var*
begin
//#UC START# *49DCA7F3011C_4804A2C101A5_impl*
 Result := nil;
//#UC END# *49DCA7F3011C_4804A2C101A5_impl*
end;//_evParaPainter_.GetTablePainter

function _evParaPainter_.GetTableRowPainter: IevTableRowPainter;
//#UC START# *4C77512E00AD_4804A2C101A5_var*
//#UC END# *4C77512E00AD_4804A2C101A5_var*
begin
//#UC START# *4C77512E00AD_4804A2C101A5_impl*
 Result := nil;
//#UC END# *4C77512E00AD_4804A2C101A5_impl*
end;//_evParaPainter_.GetTableRowPainter

function _evParaPainter_.IsTopAnchorAtStart: Boolean;
//#UC START# *4D9AF3680146_4804A2C101A5_var*
//#UC END# *4D9AF3680146_4804A2C101A5_var*
begin
//#UC START# *4D9AF3680146_4804A2C101A5_impl*
 Result := TopAnchor.AtStart;
//#UC END# *4D9AF3680146_4804A2C101A5_impl*
end;//_evParaPainter_.IsTopAnchorAtStart

procedure _evParaPainter_.DrawFrameText(aTop: Boolean);
 {* Рисует текст рамки. }
//#UC START# *467D21C003C2_4804A2C101A5_var*
//#UC END# *467D21C003C2_4804A2C101A5_var*
begin
//#UC START# *467D21C003C2_4804A2C101A5_impl*
 DoDrawFrameText(aTop);
//#UC END# *467D21C003C2_4804A2C101A5_impl*
end;//_evParaPainter_.DrawFrameText

function _evParaPainter_.Draw(const anArea: TnevShapeArea;
 const aPoints: TnevShapePoints;
 out theInfo: TnevShapeInfo): Boolean;
//#UC START# *47C6972A036C_4804A2C101A5_var*
var
 l_CellBottom : InevBasePoint;
//#UC END# *47C6972A036C_4804A2C101A5_var*
begin
//#UC START# *47C6972A036C_4804A2C101A5_impl*
 f_Area := @anArea;
 try
  f_ViewMetrics := f_Area.rView.Metrics;
  try
   f_Caret := aPoints.rCaret;
   try
    f_SelRange := aPoints.rSelection;
    try
     f_TopAnchor := aPoints.rTop;
     f_RealTopAnchor := aPoints.rRealTop;
     f_Fake := aPoints.rFake;
     f_CheckCaret := aPoints.rCheckCaret;
     f_CheckSelRange := aPoints.rCheckSelection;
     if (f_TopAnchor = nil) or f_TopAnchor.BeforeStart then
     begin
      f_TopAnchor := ParaX.MakeAnchor;
      f_WasInit := False;
     end
     else
      f_WasInit := True;
     try
      if anArea.rNeedBottom then
      begin
       f_BottomAnchor := ParaX.BaseLine4Print;
       f_PrevHeight := aPoints.rPrevHeight;
      end
      else
       f_PrevHeight := 0;
      f_Hidden := not BeginDraw;
      try
       f_Collapsed := ParaX.AsObject.BoolA[k2_tiCollapsed];
       evCheckCollapsed(ParaX.AsObject, f_Collapsed);
       if f_Hidden then
        Result := True
       else
        Result := DoDraw;
       if not f_NeedsHackK235870994 then
        SetDrawnBottom;
       f_DrawCompleted := Result;
       // Возможно здесь проблема в поведении метки в Арчи:
       // http://mdp.garant.ru/pages/viewpage.action?pageId=121168030&focusedCommentId=135597457#comment-135597457
       if (f_TopAnchor.VertPosition(Area.rView.As_InevView, FormatInfo) <= 0) then
        DrawSubs;
       {$IfDef ParaPainter_IsParaListPainter}
       if ParaX.AsObject.IsKindOf(k2_typBlock) then
        DrawBlockSub;
       {$EndIf ParaPainter_IsParaListPainter}
       if (Caret <> nil) then
       begin
        with Area.rCanvas do
        begin
         if ShowCursor AND not Caret.HasInner then
         begin
          SetCaret(l3Point0,
                   l3Point(AverageCharWidth, AverageCharHeight),
                   not Caret.NeedWindowsCaret);
          ShowCursor := False;
         end;//ShowCursor..
        end;//with Area.rCanvas
       end;//Caret <> nil
      finally
       EndDraw;
      end;//try..finally
      // - куда-то сюда надо вставить инициализацию для f_BottomAnchor (для листьевых)
      if anArea.rNeedBottom then
      begin
       InitBottom(f_BottomAnchor, l_CellBottom);
       theInfo.rBottom := f_BottomAnchor;
       theInfo.rCellBottom := l_CellBottom;
       theInfo.rCalculatedHeight := f_PrevHeight;
      end;//anArea.rNeedBottom
      theInfo.rMap := Map;
     finally
      f_TopAnchor := nil;
      f_RealTopAnchor := nil;
     end;//try..finally
    finally
     f_SelRange := nil;
    end;//try..finally
   finally
    f_Caret := nil;
    f_CheckCaret := nil;
    f_CheckSelRange := nil;
   end;//try..finally
  finally
   f_ViewMetrics := nil;
  end;//try..finally 
 finally
  f_Area := nil;
 end;//try..finally
//#UC END# *47C6972A036C_4804A2C101A5_impl*
end;//_evParaPainter_.Draw

function _evParaPainter_.pm_GetParentPainter: IevPainter;
//#UC START# *47C7DCB10302_4804A2C101A5get_var*
//#UC END# *47C7DCB10302_4804A2C101A5get_var*
begin
//#UC START# *47C7DCB10302_4804A2C101A5get_impl*
 Result := f_ParentPainter;
//#UC END# *47C7DCB10302_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetParentPainter

procedure _evParaPainter_.pm_SetParentPainter(const aValue: IevPainter);
//#UC START# *47C7DCB10302_4804A2C101A5set_var*
//#UC END# *47C7DCB10302_4804A2C101A5set_var*
begin
//#UC START# *47C7DCB10302_4804A2C101A5set_impl*
 f_ParentPainter := aValue;
//#UC END# *47C7DCB10302_4804A2C101A5set_impl*
end;//_evParaPainter_.pm_SetParentPainter

function _evParaPainter_.pm_GetCurrentBlock: InevRange;
//#UC START# *47C7DD07029E_4804A2C101A5get_var*
//#UC END# *47C7DD07029E_4804A2C101A5get_var*
begin
//#UC START# *47C7DD07029E_4804A2C101A5get_impl*
 Result := f_SelRange;
//#UC END# *47C7DD07029E_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetCurrentBlock

function _evParaPainter_.pm_GetDrawingTopmostChild: Boolean;
//#UC START# *47C7DD2E007F_4804A2C101A5get_var*
//#UC END# *47C7DD2E007F_4804A2C101A5get_var*
begin
//#UC START# *47C7DD2E007F_4804A2C101A5get_impl*
 Result := DrawingTopmostChild;
//#UC END# *47C7DD2E007F_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetDrawingTopmostChild

function _evParaPainter_.pm_GetDrawingLastChild: Boolean;
//#UC START# *47C7DD4500A5_4804A2C101A5get_var*
//#UC END# *47C7DD4500A5_4804A2C101A5get_var*
begin
//#UC START# *47C7DD4500A5_4804A2C101A5get_impl*
 Result := DrawingLastChild;
//#UC END# *47C7DD4500A5_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetDrawingLastChild

function _evParaPainter_.pm_GetParaMarkStyle: TevParaMarkStyle;
//#UC START# *47C7DDD702A7_4804A2C101A5get_var*
//#UC END# *47C7DDD702A7_4804A2C101A5get_var*
begin
//#UC START# *47C7DDD702A7_4804A2C101A5get_impl*
 Result := f_ParaMarkStyle;
//#UC END# *47C7DDD702A7_4804A2C101A5get_impl*
end;//_evParaPainter_.pm_GetParaMarkStyle

procedure _evParaPainter_.pm_SetParaMarkStyle(aValue: TevParaMarkStyle);
//#UC START# *47C7DDD702A7_4804A2C101A5set_var*
//#UC END# *47C7DDD702A7_4804A2C101A5set_var*
begin
//#UC START# *47C7DDD702A7_4804A2C101A5set_impl*
 f_ParaMarkStyle := aValue;
//#UC END# *47C7DDD702A7_4804A2C101A5set_impl*
end;//_evParaPainter_.pm_SetParaMarkStyle

function _evParaPainter_.Get_PaintersHolder: InevPaintersHolder;
//#UC START# *49DB945D01A4_4804A2C101A5get_var*
//#UC END# *49DB945D01A4_4804A2C101A5get_var*
begin
//#UC START# *49DB945D01A4_4804A2C101A5get_impl*
 Result := GetPaintersHolder;
//#UC END# *49DB945D01A4_4804A2C101A5get_impl*
end;//_evParaPainter_.Get_PaintersHolder

function _evParaPainter_.Get_TablePainter: IevTablePainter;
//#UC START# *49DCA7D10326_4804A2C101A5get_var*
//#UC END# *49DCA7D10326_4804A2C101A5get_var*
begin
//#UC START# *49DCA7D10326_4804A2C101A5get_impl*
 Result := GetTablePainter;
//#UC END# *49DCA7D10326_4804A2C101A5get_impl*
end;//_evParaPainter_.Get_TablePainter

function _evParaPainter_.Get_TableRowPainter: IevTableRowPainter;
//#UC START# *4C774ECF0308_4804A2C101A5get_var*
//#UC END# *4C774ECF0308_4804A2C101A5get_var*
begin
//#UC START# *4C774ECF0308_4804A2C101A5get_impl*
 Result := GetTableRowPainter;
//#UC END# *4C774ECF0308_4804A2C101A5get_impl*
end;//_evParaPainter_.Get_TableRowPainter

function _evParaPainter_.HackK235870994(const aMap: InevMap): Boolean;
//#UC START# *4CAF448203AD_4804A2C101A5_var*
var
 l_W : Integer;
//#UC END# *4CAF448203AD_4804A2C101A5_var*
begin
//#UC START# *4CAF448203AD_4804A2C101A5_impl*
 Result := false;
 if NeedsHackK235870994 then
  if Area.rCanvas.Printing AND (Area.rCanvas.PageWidthNumber > 0) then
  begin
   with aMap.FI do
   begin
    l_W := Width;
    if (l_W < Area.rCanvas.ClipRect.Left) then
    // заточка для http://mdp.garant.ru/pages/viewpage.action?pageId=235870994&focusedCommentId=235871524#comment-235871524
    begin
     // тут надо бы прыгнуть каким-то образом либо к концу таблицы, либо к концу страницы
     Result := true{(Area.rCanvas.PageWidthNumber > 0)};
     if Result then
      f_NeedsHackK235870994 := true;
    end;//l_W < Area.rCanvas.ClipRect.Left
   end;//with aMap.FI^
  end;//Area.rCanvas.Printing
//#UC END# *4CAF448203AD_4804A2C101A5_impl*
end;//_evParaPainter_.HackK235870994

function _evParaPainter_.Get_Obj: InevObjectPrim;
//#UC START# *4E25BC360220_4804A2C101A5get_var*
//#UC END# *4E25BC360220_4804A2C101A5get_var*
begin
//#UC START# *4E25BC360220_4804A2C101A5get_impl*
 Result := ParaX;
//#UC END# *4E25BC360220_4804A2C101A5get_impl*
end;//_evParaPainter_.Get_Obj

procedure _evParaPainter_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4804A2C101A5_var*
//#UC END# *479731C50290_4804A2C101A5_var*
begin
//#UC START# *479731C50290_4804A2C101A5_impl*
 f_FormatInfo := nil;
 f_Map := nil;
 f_SmartCanvas := nil;
 f_Area := nil;
 f_ParaMarkStyle := ev_pmUsial;
 f_SelRange := nil;
 f_ParentPainter := nil;
 f_BottomAnchor := nil;
 f_CheckCaret := nil;
 f_CheckSelRange := nil;
 inherited;
//#UC END# *479731C50290_4804A2C101A5_impl*
end;//_evParaPainter_.Cleanup

procedure _evParaPainter_.ClearFields;
begin
 f_RealTopAnchor := nil;
 f_CheckCaret := nil;
 f_CheckSelRange := nil;
 f_BottomAnchor := nil;
 f_ParentPainter := nil;
 f_SmartCanvas := nil;
 f_Caret := nil;
 f_TopAnchor := nil;
 f_SelRange := nil;
 f_Map := nil;
 Finalize(f_Spaces);
 f_ViewMetrics := nil;
 inherited;
end;//_evParaPainter_.ClearFields
{$IfEnd} // Defined(evNeedPainters)

{$EndIf evParaPainter_imp_impl}

{$EndIf evParaPainter_imp}

