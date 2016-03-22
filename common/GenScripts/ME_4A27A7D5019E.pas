unit evControlParaHotSpot;
 {* Реализация "горячей точки" для параграфа, представляющего контрол ввода }

// Модуль: "w:\common\components\gui\Garant\Everest\evControlParaHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlParaHotSpot" MUID: (4A27A7D5019E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , k2TagTool
 , nevGUIInterfaces
 , nevTools
 , evQueryCardInt
 , l3Variant
 , afwInterfaces
 , l3Units
;

type
 _X_ = InevTextPara;
 _nevParaXTool_Parent_ = Tk2TagTool;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}
 TevControlParaHotSpot = class(_nevParaXTool_, IevMouseMoveHandler, IevHotSpot)
  {* Реализация "горячей точки" для параграфа, представляющего контрол ввода }
  private
   thisMap: InevMap;
   f_OldChecked: Boolean;
   f_ControlFriend: IevControlFriend;
    {* Поле для свойства ControlFriend }
  private
   function PtInButton(const aPt: TafwPoint): Boolean;
    {* Щелчок по кнопке редактора }
   function PtInCtrButton(const aPt: Tl3Point): Boolean;
    {* Щелчок по кнопке-параграфу }
   function PtInPara(const aPt: TafwPoint): Boolean;
   function PtToPara(const aPt: TafwPoint): Tl3Point;
    {* переводит из глобальных координат в координаты параграфа }
   procedure TrySendToGroup(aTag: Tl3Variant);
  protected
   function pm_GetControlFriend: IevControlFriend;
   function pm_GetVisible: Boolean; virtual;
   procedure CheckMapValid(const aView: InevControlView);
   function TransMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState;
    out theActiveElement: InevActiveElement): Boolean;
    {* Собственно реальный MouseMove, передаваемый редактору }
   function MouseMove(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает перемещение мыши }
   function LButtonDown(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
    {* Обрабатывает нажатие левой кнопки мыши }
   function LButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает отпускание левой кнопки мыши }
   function LButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
    {* Обрабатывает двойное нажатие левой кнопки мыши }
   function RButtonDown(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает нажатие правой кнопки мыши }
   function RButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает отпускание правой конопки мыши }
   function MButtonDown(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает нажатие колеса мыши }
   function MButtonUp(const aView: InevControlView;
    const Keys: TevMouseState): Boolean;
    {* Обрабатывает отпускание колеса мыши }
   function CanDrag: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aMap: InevMap;
    aTagWrap: Tl3Variant); reintroduce;
   class function Make(const aMap: InevMap;
    aTagWrap: Tl3Variant): IevHotSpot; reintroduce;
    {* Фабричный метод }
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
  private
   property Visible: Boolean
    read pm_GetVisible;
    {* Видимость контрола }
  protected
   property ControlFriend: IevControlFriend
    read pm_GetControlFriend;
 end;//TevControlParaHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , evdTypes
 , SysUtils
 , evControlParaConst
 , evMsgCode
 , k2Tags
 , ControlsBlock_Const
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
;

type _Instance_R_ = TevControlParaHotSpot;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaXTool.imp.pas}

function TevControlParaHotSpot.pm_GetControlFriend: IevControlFriend;
//#UC START# *4A27AC32013C_4A27A7D5019Eget_var*
//#UC END# *4A27AC32013C_4A27A7D5019Eget_var*
begin
//#UC START# *4A27AC32013C_4A27A7D5019Eget_impl*
 if (f_ControlFriend = nil) then
  Supports(ParaX, IevControlFriend, f_ControlFriend);
 Result := f_ControlFriend;
//#UC END# *4A27AC32013C_4A27A7D5019Eget_impl*
end;//TevControlParaHotSpot.pm_GetControlFriend

function TevControlParaHotSpot.pm_GetVisible: Boolean;
//#UC START# *4A27AC74011B_4A27A7D5019Eget_var*
//#UC END# *4A27AC74011B_4A27A7D5019Eget_var*
begin
//#UC START# *4A27AC74011B_4A27A7D5019Eget_impl*
 Result := GetRedirect.BoolA[k2_tiVisible];
//#UC END# *4A27AC74011B_4A27A7D5019Eget_impl*
end;//TevControlParaHotSpot.pm_GetVisible

function TevControlParaHotSpot.PtInButton(const aPt: TafwPoint): Boolean;
 {* Щелчок по кнопке редактора }
//#UC START# *4A27AD7103E7_4A27A7D5019E_var*
var
 l_ButtonLeft  : Integer;
 l_ButtonWidth : Integer;
//#UC END# *4A27AD7103E7_4A27A7D5019E_var*
begin
//#UC START# *4A27AD7103E7_4A27A7D5019E_impl*
 if not (Assigned(thisMap) and Assigned(thisMap.FI)) then
 begin
  Result := False;
  Exit;
 end//FI^ = nil
 else
  l_ButtonLeft := thisMap.Bounds.Left + thisMap.FI.Width;
 l_ButtonWidth := GetRedirect.IntA[k2_tiRightIndent];
 Result := (aPt.X > l_ButtonLeft) and (aPt.X < l_ButtonLeft + l_ButtonWidth);
//#UC END# *4A27AD7103E7_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.PtInButton

function TevControlParaHotSpot.PtInCtrButton(const aPt: Tl3Point): Boolean;
 {* Щелчок по кнопке-параграфу }
//#UC START# *4A27AD97018A_4A27A7D5019E_var*
var
 l_ButtonLeft  : Integer;
 l_ButtonWidth : Integer;
 l_ButtonUp    : Integer;
 l_ButtonDown  : Integer;
//#UC END# *4A27AD97018A_4A27A7D5019E_var*
begin
//#UC START# *4A27AD97018A_4A27A7D5019E_impl*
 l_ButtonLeft := GetRedirect.IntA[k2_tiLeftIndent];
 l_ButtonWidth := thisMap.FI.Width;
 l_ButtonUp := GetRedirect.IntA[k2_tiSpaceBefore] div 2;
 l_ButtonDown := thisMap.FI.Height - GetRedirect.IntA[k2_tiSpaceAfter] div 2;
 Result := (aPt.X > l_ButtonLeft) and (aPt.X < l_ButtonWidth) and
   (aPt.Y > l_ButtonUp) and (aPt.Y < l_ButtonDown);
//#UC END# *4A27AD97018A_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.PtInCtrButton

function TevControlParaHotSpot.PtInPara(const aPt: TafwPoint): Boolean;
//#UC START# *4A27ADBA0100_4A27A7D5019E_var*
//#UC END# *4A27ADBA0100_4A27A7D5019E_var*
begin
//#UC START# *4A27ADBA0100_4A27A7D5019E_impl*
 Result := Tl3Rect(thisMap.Bounds).ContainsPt(aPt);
//#UC END# *4A27ADBA0100_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.PtInPara

function TevControlParaHotSpot.PtToPara(const aPt: TafwPoint): Tl3Point;
 {* переводит из глобальных координат в координаты параграфа }
//#UC START# *4A27ADCF011E_4A27A7D5019E_var*
//#UC END# *4A27ADCF011E_4A27A7D5019E_var*
begin
//#UC START# *4A27ADCF011E_4A27A7D5019E_impl*
 Result := Tl3Point(aPt).Sub(Tl3Rect(thisMap.Bounds).TopLeft);
//#UC END# *4A27ADCF011E_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.PtToPara

procedure TevControlParaHotSpot.TrySendToGroup(aTag: Tl3Variant);
var l_Tag: Tl3Tag;
var l_Group: IevQueryGroup;
//#UC START# *4A27ADED0094_4A27A7D5019E_var*
//#UC END# *4A27ADED0094_4A27A7D5019E_var*
begin
//#UC START# *4A27ADED0094_4A27A7D5019E_impl*
 if evInPara(aTag, k2_typControlsBlock, l_Tag) then
 begin
  if l_Tag.QT(IevQueryGroup, l_Group) then
   try
    l_Group.ClickOnDisabledLabel;
   finally
    l_Group := nil;
   end;//try..finally
 end;//evInPara(aTag, k2_idControlsBlock, l_Tag)
//#UC END# *4A27ADED0094_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.TrySendToGroup

procedure TevControlParaHotSpot.CheckMapValid(const aView: InevControlView);
//#UC START# *52FC8C800193_4A27A7D5019E_var*
//#UC END# *52FC8C800193_4A27A7D5019E_var*
begin
//#UC START# *52FC8C800193_4A27A7D5019E_impl*
 if Assigned(thisMap) and not thisMap.IsMapValid then
  thisMap := aView.MapByPoint(ParaX.MakePoint);
//#UC END# *52FC8C800193_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.CheckMapValid

constructor TevControlParaHotSpot.Create(const aMap: InevMap;
 aTagWrap: Tl3Variant);
//#UC START# *4A27AE0B0219_4A27A7D5019E_var*
//#UC END# *4A27AE0B0219_4A27A7D5019E_var*
begin
//#UC START# *4A27AE0B0219_4A27A7D5019E_impl*
 inherited Create(aTagWrap);
 thisMap := aMap;
//#UC END# *4A27AE0B0219_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.Create

class function TevControlParaHotSpot.Make(const aMap: InevMap;
 aTagWrap: Tl3Variant): IevHotSpot;
 {* Фабричный метод }
var
 l_Inst : TevControlParaHotSpot;
begin
 l_Inst := Create(aMap, aTagWrap);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevControlParaHotSpot.Make

procedure TevControlParaHotSpot.HitTest(const aView: InevControlView;
 const aState: TafwCursorState;
 var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_4A27A7D5019E_var*
var
 l_Control : IevEditorControl;
//#UC END# *48E2622A03C4_4A27A7D5019E_var*
begin
//#UC START# *48E2622A03C4_4A27A7D5019E_impl*
 inherited;
 if Visible then
 begin
  CheckMapValid(aView);
  if (ControlFriend.ControlType = ev_ctLabel) then
   theInfo.rCursor := ev_csArrow
  else
  if (ControlFriend.ControlType in evButtonStyleControls) then
   theInfo.rCursor := ev_csArrow
  else
  if (ControlFriend.ControlType in evControlsWithButtons) then
  begin
   if PtInButton(aState.rPoint) then
    theInfo.rCursor := ev_csArrow
   else
    theInfo.rCursor := ev_csIBeam;
  end//ControlType in evControlsWithButtons
  else
  if (ControlFriend.ControlType in evSimpleEditors) then
   theInfo.rCursor := ev_csIBeam;
  l_Control := ControlFriend.GetControl;
  if (l_Control <> nil) then
   try
    if l_Control.GetHint(theInfo.rHint) then
     Exit;
   finally
    l_Control := nil;
   end;//try..finally
 end;//Visible
 theInfo.rHint := nil;
//#UC END# *48E2622A03C4_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.HitTest

function TevControlParaHotSpot.TransMouseMove(const aView: InevControlView;
 const aKeys: TevMouseState;
 out theActiveElement: InevActiveElement): Boolean;
 {* Собственно реальный MouseMove, передаваемый редактору }
//#UC START# *48E2638F0358_4A27A7D5019E_var*
var
 l_Pt      : Tl3Point;
 l_Control : IevEditorControl;
 l_Upper   : Boolean;
//#UC END# *48E2638F0358_4A27A7D5019E_var*
begin
//#UC START# *48E2638F0358_4A27A7D5019E_impl*
 Result := True;
 with ControlFriend do
  if (ControlType in evFlatBTNControls) and Visible and Enabled then
  begin
   CheckMapValid(aView);
   l_Pt := PtToPara(aKeys.rPoint);
   l_Upper := PtInCtrButton(l_Pt);
   if (l_Upper <> Upper) then
   begin
    l_Control := ControlFriend.GetControl;
    if (l_Control <> nil) then
    begin
     l_Control.Upper := l_Upper;
     if l_Upper then
      l_Control.UpperChange;
    end;//l_Control <> nil
   end;//l_Upper <> Upper
  end;//ControlType in evFlatBTNControls..
//#UC END# *48E2638F0358_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.TransMouseMove

function TevControlParaHotSpot.MouseMove(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает перемещение мыши }
//#UC START# *48E266730188_4A27A7D5019E_var*
//#UC END# *48E266730188_4A27A7D5019E_var*
begin
//#UC START# *48E266730188_4A27A7D5019E_impl*
 Result := False;
 if not ControlFriend.Enabled then
  Exit;
 CheckMapValid(aView);
 with ControlFriend do
  case ControlType of
   ev_ctButton, ev_ctStateButton:
   begin
    Result := True;
    if not PtInPara(Keys.rPoint) then
     // - отпускаем кнопку
    begin
     Checked := False;
     Upper := False;
    end//if not PtInPara(Keys.rPoint) then
    else
     Checked := True;
     // - возвращаем в нажатое состояние
   end;//ev_ctButton
   ev_ctCheckEdit, ev_ctRadioEdit:
   begin
    if not PtInPara(Keys.rPoint) then
     Checked := f_OldChecked
     // - восстанавливаем старое значение
    else
     Checked := not f_OldChecked;
     // - восстанавливаем новое значение
    Result := True;
   end;//ev_ctCheckEdit, ev_ctRadioEdit
   else
    ;
  end;//Case ControlType
//#UC END# *48E266730188_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.MouseMove

function TevControlParaHotSpot.LButtonDown(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
 {* Обрабатывает нажатие левой кнопки мыши }
//#UC START# *48E266AA00A4_4A27A7D5019E_var*
var
 l_Pt       : Tl3Point;
 l_Control  : IevEditorControl;
//#UC END# *48E266AA00A4_4A27A7D5019E_var*
begin
//#UC START# *48E266AA00A4_4A27A7D5019E_impl*
 Result := False;
 if not ControlFriend.Enabled then
 begin
  Result := true;
  Effect.rNeedAsyncLoop := false;
  Exit;
 end;//not ControlFriend.Enabled
 CheckMapValid(aView);
 l_Pt := PtToPara(Keys.rPoint);
 // - переводим из глобальных координат в координаты параграфа
 with ControlFriend do
  case ControlType of
   ev_ctButton, ev_ctStateButton, ev_ctLabel, ev_ctPictureLabel:
   begin
    l_Control := ControlFriend.GetControl;
    if (l_Control <> nil) then
     try
      Result := l_Control.LMouseBtnDown(aView, ParaX, l_Pt, Keys, PtInPara(Keys.rPoint), thisMap);
      Checked := True;
      //Result := True;
     finally
      l_Control := nil;
     end
    else //Если какой-то из этих контролов не имеет отображения в модели, то и нечего ему фокус ловить.
    begin
     TrySendToGroup(GetRedirect);
     //Result := True;
    end;
   end;//ev_ctButton
   ev_ctCheckEdit, ev_ctRadioEdit:
   begin
    aView.Control.Selection.SelectPt(Keys.rPoint, True);
    // - переводим фокус на контрол
    f_OldChecked := Checked;
    if PtInPara(Keys.rPoint) then
     Checked := not f_OldChecked;
    // - инвертируем значение
    Result := True;
   end;//ev_ctCheckEdit, ev_ctRadioEdit
   ev_ctEllipsesEdit, ev_ctSpinedit, ev_ctEdit, ev_ctCombo, ev_ctCalEdit, ev_ctEmailEdit:
   begin
    l_Control := ControlFriend.GetControl;
    if (l_Control <> nil) then
     try
      Result := l_Control.LMouseBtnDown(aView, ParaX, l_Pt, Keys, True, thisMap);
      if Result then
      begin
       aView.Control.Selection.SelectPt(Keys.rPoint, True);
       Checked := True;
      end;
      //Result := True;
     finally
      l_Control := nil;
     end;
   end;//ev_ctEllipsesEdit, ev_ctSpinedit, ev_ctCombo, ev_ctCalEdit
  end;//Case ControlType
//#UC END# *48E266AA00A4_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.LButtonDown

function TevControlParaHotSpot.LButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание левой кнопки мыши }
//#UC START# *48E266C70128_4A27A7D5019E_var*
var
 l_Pt      : Tl3Point;
 l_Control : IevEditorControl;
//#UC END# *48E266C70128_4A27A7D5019E_var*
begin
//#UC START# *48E266C70128_4A27A7D5019E_impl*
 Result := False;
 if not ControlFriend.Enabled then
 begin
  Result := true;
  Exit;
 end;//not ControlFriend.Enabled
 CheckMapValid(aView);
 l_Pt := PtToPara(Keys.rPoint);
 // - переводим из глобальных координат в координаты параграфа
 with ControlFriend do
  case ControlType of
   ev_ctButton, ev_ctStateButton:
   begin
    Checked := False;
    Upper := False;
    l_Control := ControlFriend.GetControl;
    if (l_Control <> nil) then
     try
      Result := l_Control.LMouseBtnUp(aView, ParaX, l_Pt, Keys, PtInPara(Keys.rPoint));
     finally
      l_Control := nil;
     end;
   end;//ev_ctButton
   ev_ctCheckEdit, ev_ctRadioEdit:
   begin
    if not PtInPara(Keys.rPoint) then
     Checked := f_OldChecked
     // - восстанавливаем старое значение
    else
     Checked := not f_OldChecked;
     // - восстанавливаем новое значение
    Result := True;
   end;//ev_ctCheckEdit, ev_ctRadioEdit
   ev_ctEllipsesEdit, ev_ctSpinedit, ev_ctEdit, ev_ctCombo, ev_ctCalEdit, ev_ctEmailEdit:
   begin
    Checked := False;
    Result := True;
   end;
  end;//Case ControlType
//#UC END# *48E266C70128_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.LButtonUp

function TevControlParaHotSpot.LButtonDoubleClick(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
 {* Обрабатывает двойное нажатие левой кнопки мыши }
//#UC START# *48E266DE026B_4A27A7D5019E_var*
//#UC END# *48E266DE026B_4A27A7D5019E_var*
begin
//#UC START# *48E266DE026B_4A27A7D5019E_impl*
 CheckMapValid(aView);
 Result := (ControlFriend.ControlType in evNotEditableControls) or
   ((ControlFriend.ControlType in evControlsWithButtons) and PtInButton(Keys.rPoint));
//#UC END# *48E266DE026B_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.LButtonDoubleClick

function TevControlParaHotSpot.RButtonDown(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает нажатие правой кнопки мыши }
//#UC START# *48E266FB01FC_4A27A7D5019E_var*
var
 l_Control: IevEditorControl;
 l_Point: InevPoint;
 l_op: InevOp;
//#UC END# *48E266FB01FC_4A27A7D5019E_var*
begin
//#UC START# *48E266FB01FC_4A27A7D5019E_impl*
 CheckMapValid(aView);
 Result := False;
 l_Control := ControlFriend.GetControl;
 if (l_Control <> nil) then
  try
   if (l_Control.ControlType in evEditControls) and
      Supports(aView.PointByPt(Keys.rPoint), InevPoint, l_Point) then
    with aView.Control.Selection do
     if not Contains(l_Point) then
   begin
    l_Op := aView.Control.Processor.StartOp(ev_msgMove);
    try
     // !STUB! По хорошему это дело редактора, но до введение понятия "невыбираемых
     // параграфов жить будет здесь
     SelectPoint(l_Point, False);
     l_Control.Req.QueryCard.RememberFocusControl(l_Control);
     l_Control.RememberState;
    finally
     l_op := nil;
    end;
   end;
  finally
   l_Control := nil;
  end;
//#UC END# *48E266FB01FC_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.RButtonDown

function TevControlParaHotSpot.RButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание правой конопки мыши }
//#UC START# *48E267150266_4A27A7D5019E_var*
//#UC END# *48E267150266_4A27A7D5019E_var*
begin
//#UC START# *48E267150266_4A27A7D5019E_impl*
 Result := false;
//#UC END# *48E267150266_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.RButtonUp

function TevControlParaHotSpot.MButtonDown(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает нажатие колеса мыши }
//#UC START# *49DB4675025E_4A27A7D5019E_var*
//#UC END# *49DB4675025E_4A27A7D5019E_var*
begin
//#UC START# *49DB4675025E_4A27A7D5019E_impl*
 Result := False;
//#UC END# *49DB4675025E_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.MButtonDown

function TevControlParaHotSpot.MButtonUp(const aView: InevControlView;
 const Keys: TevMouseState): Boolean;
 {* Обрабатывает отпускание колеса мыши }
//#UC START# *49DB468302A5_4A27A7D5019E_var*
//#UC END# *49DB468302A5_4A27A7D5019E_var*
begin
//#UC START# *49DB468302A5_4A27A7D5019E_impl*
 Result := False;
//#UC END# *49DB468302A5_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.MButtonUp

function TevControlParaHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_4A27A7D5019E_var*
//#UC END# *4ECCD6840014_4A27A7D5019E_var*
begin
//#UC START# *4ECCD6840014_4A27A7D5019E_impl*
 Result := True;
//#UC END# *4ECCD6840014_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.CanDrag

procedure TevControlParaHotSpot.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A27A7D5019E_var*
//#UC END# *479731C50290_4A27A7D5019E_var*
begin
//#UC START# *479731C50290_4A27A7D5019E_impl*
 f_ControlFriend := nil;
 thisMap := nil;
 inherited;
//#UC END# *479731C50290_4A27A7D5019E_impl*
end;//TevControlParaHotSpot.Cleanup

procedure TevControlParaHotSpot.ClearFields;
begin
 f_ControlFriend := nil;
 inherited;
end;//TevControlParaHotSpot.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
