unit nevMeasureView;
 {* Область вывода для измерений. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevMeasureView.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevMeasureView" MUID: (481201700007)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevVirtualView
 , nevTools
 , afwInterfaces
 , nevBase
;

type
 TnevMeasureView = class(TnevVirtualView, InevMeasureView)
  {* Область вывода для измерений. }
  private
   f_CaretPoint: InevBasePoint;
   f_Caret: IafwScrollCaret;
  protected
   function IsCaretInited: Boolean;
   function IsCaretVisible: Boolean;
   procedure CheckShapes;
   procedure MakePointVisible(const aTop: InevAnchor;
    const aPoint: InevBasePoint;
    var thePos: Integer);
    {* Делает так, чтобы курсор был видим на заданном экране }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoSignalScroll(aTopDiff: Integer;
    aDeltaY: Integer); override;
   function GetCanvas(const anExtent: TnevPoint): InevCanvas; override;
   function CaretCursor: InevBasePoint; override;
   procedure LinkControl(const aControl: InevControl); override;
   procedure DoUnlinkControl(const aControl: InevControl); override;
  public
   constructor Create(const aControl: InevControl); reintroduce;
   class function Make(const aControl: InevControl): InevMeasureView; reintroduce;
 end;//TnevMeasureView

implementation

uses
 l3ImplUses
 , afwMeasureCanvas
 , SysUtils
 , nevFacade
 , afwVirtualCaret
 , l3MinMax
 , l3Units
 //#UC START# *481201700007impl_uses*
 //#UC END# *481201700007impl_uses*
;

constructor TnevMeasureView.Create(const aControl: InevControl);
//#UC START# *4CB5C07B03E3_481201700007_var*
//#UC END# *4CB5C07B03E3_481201700007_var*
begin
//#UC START# *4CB5C07B03E3_481201700007_impl*
 inherited Create;
 LinkControl(aControl);
//#UC END# *4CB5C07B03E3_481201700007_impl*
end;//TnevMeasureView.Create

class function TnevMeasureView.Make(const aControl: InevControl): InevMeasureView;
var
 l_Inst : TnevMeasureView;
begin
 l_Inst := Create(aControl);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevMeasureView.Make

function TnevMeasureView.IsCaretInited: Boolean;
//#UC START# *481203AD0062_481201700007_var*
//#UC END# *481203AD0062_481201700007_var*
begin
//#UC START# *481203AD0062_481201700007_impl*
 if (f_Caret = nil) then
  Result := false
 else
 begin
  CheckShapes;
  Result := f_Caret.IsInited;
 end;//f_Caret = nil
//#UC END# *481203AD0062_481201700007_impl*
end;//TnevMeasureView.IsCaretInited

function TnevMeasureView.IsCaretVisible: Boolean;
//#UC START# *481203CD0044_481201700007_var*
//#UC END# *481203CD0044_481201700007_var*
begin
//#UC START# *481203CD0044_481201700007_impl*
 if (f_Caret = nil) then
  Result := true
 else
 begin
  CheckShapes;
  if not f_Caret.IsInited then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=268339552
   Result := false
  else
   Result := f_Caret.IsOnScreen;
 end;//f_Caret = nil
//#UC END# *481203CD0044_481201700007_impl*
end;//TnevMeasureView.IsCaretVisible

procedure TnevMeasureView.CheckShapes;
//#UC START# *481203E001FE_481201700007_var*
var
 l_Ex : InevMap;
//#UC END# *481203E001FE_481201700007_var*
begin
//#UC START# *481203E001FE_481201700007_impl*
 if (ShapesPainted = nil) OR ShapesPainted.Empty then
 begin
  f_Caret.Reset;
  Draw(nil, l_Ex);
 end;//ShapesPainted = nil
//#UC END# *481203E001FE_481201700007_impl*
end;//TnevMeasureView.CheckShapes

procedure TnevMeasureView.MakePointVisible(const aTop: InevAnchor;
 const aPoint: InevBasePoint;
 var thePos: Integer);
 {* Делает так, чтобы курсор был видим на заданном экране }
//#UC START# *47C7D0950051_481201700007_var*
const
 l_D = 1;
var
 l_Page  : Integer;
 l_Line  : Integer;
 l_Index : Integer;
 l_View  : IafwScrollListener;
 l_WasInited : Boolean;
 l_LoopCount: Integer;
//#UC END# *47C7D0950051_481201700007_var*
begin
//#UC START# *47C7D0950051_481201700007_impl*
 Top := aTop;
 try
  f_CaretPoint := aPoint;
  try
   l_View := aTop.LinkListener(Self);
   try
    l_WasInited := false;
    for l_Index := 0 to 30 do
    begin
     l_Line := l_D;
     CheckShapes;
     // CheckShapes - это здесь обязательно надо! иначе карта форматирования ПУСТАЯ.
     // Последующий вызов IncLine может неправильно отработать - если на
     // экран влезает ТОЛЬКО один параграф, который в данном View еще не
     // сформатирован. В результате - прыгаем на следующий большой параграф
     // и выходим из for по-условию if not IsCaretInited
     // а код:
     // <code>
     // aTop.M.AssignPoint(aPoint);
     // l_Line := -l_Page;
     // aTop.IncLine(Self, l_Line, true);
     // <code>
     // - переставляет обратно. И начинаются бесконечные "качели".
     // Например при контекстном поиске. CQ 27042.
     Inc(thePos, aTop.IncLine(Self, l_Line, true));
     if not IsCaretInited then
     begin
      if l_WasInited then
      // - проверяем, что каретка была уже показана, но убежала за верх экрана - http://mdp.garant.ru/pages/viewpage.action?pageId=121143369
      begin
       l_Line := -1;
       Inc(thePos, aTop.IncLine(Self, l_Line, true));
       Exit;
      end;//l_WasInited
      break;
     end//not IsCaretInited
     else
      l_WasInited := true;
     if IsCaretVisible then
      Exit;
     if (l_Line = l_D) then
      break;
    end;//for l_Index
    thePos := -1;
    l_Page := ShapesPainted.SubShapesCount;
    if (l_Page <= 0) then
     l_Page := (ViewExtent.Y div nev.LineScrollDelta.Y);
    while (l_Page > 0) do
    begin
     aTop.AssignPoint(Self, aPoint);
     l_Line := -l_Page;
     aTop.IncLine(Self, l_Line, true);
     if (l_Line = -l_Page) then
      break;
     if IsCaretInited then
      break;
     l_Page := l_Page - Max(1, (l_Page div 4));
    end;//while (l_Page > 0)
    if not IsCaretInited then
     // Если каретку так и не прорисовывали - ставим ее вверх экрана
     aTop.AssignPoint(Self, aPoint)
     // Revision 1.18.2.4.2.4  2006/11/13 11:58:09  oman
     // - fix: Если не удалось сойтись к каретке - показываем ее верху
     //  экрана - иначе срабатывал Assert (cq23605)
     //
    else
    begin
     l_LoopCount := 0;
     // Пытаемся спозиционироваться
     while not IsCaretVisible do
     begin
      l_Line := l_D;
      aTop.IncLine(Self, l_Line, true);
      if (l_Line = l_D) then
       break;

      Inc(l_LoopCount);
      if l_LoopCount >= 100 then // http://mdp.garant.ru/pages/viewpage.action?pageId=271190964
      begin
       aTop.AssignPoint(Self, aPoint);
       // здесь бы еще надо промотать вниз чуть меньше чем на экран,
       // чтоб найденное слово оказалось внизу
       Exit;
      end;
     end;//while not IsCaretVisible
    end;
   finally
    aTop.LinkListener(l_View);
   end;//try..finally
  finally
   f_CaretPoint := nil;
  end;//try..finally
 finally
  Top := nil;
  UnlinkControl(pm_GetControl);
 end;//try..finally
//#UC END# *47C7D0950051_481201700007_impl*
end;//TnevMeasureView.MakePointVisible

procedure TnevMeasureView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_481201700007_var*
//#UC END# *479731C50290_481201700007_var*
begin
//#UC START# *479731C50290_481201700007_impl*
 f_CaretPoint := nil;
 f_Caret := nil;
 inherited;
//#UC END# *479731C50290_481201700007_impl*
end;//TnevMeasureView.Cleanup

procedure TnevMeasureView.DoSignalScroll(aTopDiff: Integer;
 aDeltaY: Integer);
//#UC START# *4811EAEB030F_481201700007_var*
//#UC END# *4811EAEB030F_481201700007_var*
begin
//#UC START# *4811EAEB030F_481201700007_impl*
 inherited;
 if (aDeltaY <> 0) AND (f_Caret <> nil) then
  f_Caret.Scroll(pm_GetInfoCanvas.LP2DP(l3PointY(aDeltaY)))
//#UC END# *4811EAEB030F_481201700007_impl*
end;//TnevMeasureView.DoSignalScroll

function TnevMeasureView.GetCanvas(const anExtent: TnevPoint): InevCanvas;
//#UC START# *4811F0AC0140_481201700007_var*
//#UC END# *4811F0AC0140_481201700007_var*
begin
//#UC START# *4811F0AC0140_481201700007_impl*
 Result := TafwMeasureCanvas.Make(anExtent, f_Caret);
//#UC END# *4811F0AC0140_481201700007_impl*
end;//TnevMeasureView.GetCanvas

function TnevMeasureView.CaretCursor: InevBasePoint;
//#UC START# *4811F158015E_481201700007_var*
//#UC END# *4811F158015E_481201700007_var*
begin
//#UC START# *4811F158015E_481201700007_impl*
 Result := f_CaretPoint;
//#UC END# *4811F158015E_481201700007_impl*
end;//TnevMeasureView.CaretCursor

procedure TnevMeasureView.LinkControl(const aControl: InevControl);
//#UC START# *4811F4A502F6_481201700007_var*
//#UC END# *4811F4A502F6_481201700007_var*
begin
//#UC START# *4811F4A502F6_481201700007_impl*
 inherited;
 if (aControl = nil) then
  f_Caret := nil
 else
  f_Caret := TafwVirtualCaret.Make(aControl.WindowExtent);
//#UC END# *4811F4A502F6_481201700007_impl*
end;//TnevMeasureView.LinkControl

procedure TnevMeasureView.DoUnlinkControl(const aControl: InevControl);
//#UC START# *4811F4B801DC_481201700007_var*
//#UC END# *4811F4B801DC_481201700007_var*
begin
//#UC START# *4811F4B801DC_481201700007_impl*
 inherited;
 f_Caret := nil;
//#UC END# *4811F4B801DC_481201700007_impl*
end;//TnevMeasureView.DoUnlinkControl

end.
