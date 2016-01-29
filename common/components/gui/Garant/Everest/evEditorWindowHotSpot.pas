unit evEditorWindowHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evEditorWindowHotSpot.pas"
// Начат: 05.12.2005 07:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevEditorWindowHotSpot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  nevBase,
  l3Base,
  nevTools,
  l3Tool,
  nevGUIInterfaces,
  l3IID,
  afwInterfaces
  ;

type
 TevForeignHotSpotMode = (
   ev_fhsmNone
 , ev_fhsmDisabled
 , ev_fhsmEnabled
 );//TevForeignHotSpotMode

 TevEditorWindowHotSpot = class(Tl3Tool, IevAdvancedHotSpot, IevHotSpot)
 private
 // private fields
   fl_ForeignHotSpotMove : TevForeignHotSpotMode;
   f_ForeignHotSpot : IevHotSpot;
    {* Поле для свойства ForeignHotSpot}
   f_ClickCursor : InevBasePoint;
    {* Поле для свойства ClickCursor}
 protected
 // property methods
   function pm_GetStartMark: InevPoint;
   function pm_GetFinishMark: InevPoint;
   function pm_GetOwner: TObject;
 protected
 // realized methods
   function MouseAction(const aView: InevControlView;
    aButton: Tl3MouseButton;
    anAction: Tl3MouseAction;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean;
     {* обрабатывает событие от мыши. Возвращает true - если обработано, иначе - false }
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
 public
 // realized methods
   procedure HitTest(const aView: InevControlView;
    const aState: TafwCursorState;
    var theInfo: TafwCursorInfo);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure DoBeforeSelection(const aView: InevControlView); virtual;
     {* Запоминает точку начала выделения }
   function NeedSelectCursor(const aView: InevControlView;
    const aPt: TnevPoint): Boolean; virtual;
     {* Проверяет корректность выделения при движении мыши и, если
             выделение заканчивается за пределами параграфа-виджета, то
             возвращаемся к запомненной в DoBeforeSelection точке }
   function CheckCursorPos(const aView: InevView): Boolean; virtual;
     {* Вызывается для проверки позиционирования курсора и/или окончания
             выделения. Срабатывает после отпускания кнопки мыши, если
             управление не было перехвачено самим виджетом }
   function DoLButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; virtual;
   function DoLButtonDown(const aView: InevControlView;
    const aKeys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; virtual;
   function DoMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState): Boolean; virtual;
     {* Обрабатывает движение мыши, после нажатия левой кнопки }
   function TryDragDrop(const aKeys: TevMouseState): Boolean;
   procedure TranslatePt(const aView: InevControlView;
    const aKeys: TevMouseState);
     {* транслирует точку aPt в ClickCursor или StartMark.
             Если транслируется в StartMark, то FinishMark = ClickCursor }
   procedure AlignMarks(const aView: InevControlView;
    const aKeys: TevMouseState); virtual;
     {* "выравнивает" StartMark и FinishMark - например на границу слова }
   procedure ExtendBlock(const aView: InevControlView);
     {* устанавливает StartMark и FinishMark в выделение }
   procedure DoExtendBlock(const aView: InevControlView;
    const aSelection: InevSelection); virtual;
     {* устанавливает StartMark и FinishMark в выделение }
   function DoLButtonUp(const aView: InevControlView;
    const aKeys: TevMouseState;
    aNeedUnselect: Boolean): Boolean; virtual;
     {* обрабатывает отпускание левой кнопки мыши }
   function BeginMouseOp(const aView: InevControlView;
    out theSelection: Tl3Base): InevOp;
     {* начало операторных скобок. Для закрытия скобки надо освободить OpPack.
             theSelection - объект, содержащий выделение, его надо освобождать
             процедурой l3Free в секции finally }
 public
 // public methods
   constructor Create(const anOwner: Il3ToolOwner;
    const aForeignHotSpot: IevHotSpot); reintroduce;
   class function Make(const anOwner: Il3ToolOwner;
    const aForeignHotSpot: IevHotSpot = nil): IevHotSpot; reintroduce;
 protected
 // protected properties
   property ForeignHotSpot: IevHotSpot
     read f_ForeignHotSpot;
     {* "чужой" HotSpot - вся обработка сначала отдается ему }
   property ClickCursor: InevBasePoint
     read f_ClickCursor;
     {* курсор куда кликнули }
   property StartMark: InevPoint
     read pm_GetStartMark;
     {* курсор где сейчас мышь }
   property Owner: TObject
     read pm_GetOwner;
 public
 // public properties
   property FinishMark: InevPoint
     read pm_GetFinishMark;
     {* курсор куда кликнули - обычно = ClickCursor }
 end;//TevEditorWindowHotSpot

implementation

uses
  evCustomEditorWindow,
  evTypes,
  l3InternalInterfaces,
  evMsgCode,
  evDataObject,
  SysUtils,
  evOp,
  evExcept,
  Classes,
  l3Variant
  ;

// start class TevEditorWindowHotSpot

function TevEditorWindowHotSpot.pm_GetStartMark: InevPoint;
//#UC START# *48EF2EB0009F_48E229CC03DFget_var*
//#UC END# *48EF2EB0009F_48E229CC03DFget_var*
begin
//#UC START# *48EF2EB0009F_48E229CC03DFget_impl*
 Result := (Owner As TevCustomEditorWindow).Selection.StartMark;
//#UC END# *48EF2EB0009F_48E229CC03DFget_impl*
end;//TevEditorWindowHotSpot.pm_GetStartMark

function TevEditorWindowHotSpot.pm_GetFinishMark: InevPoint;
//#UC START# *48EF2EE00254_48E229CC03DFget_var*
//#UC END# *48EF2EE00254_48E229CC03DFget_var*
begin
//#UC START# *48EF2EE00254_48E229CC03DFget_impl*
 Result := (Owner As TevCustomEditorWindow).Selection.FinishMark;
//#UC END# *48EF2EE00254_48E229CC03DFget_impl*
end;//TevEditorWindowHotSpot.pm_GetFinishMark

function TevEditorWindowHotSpot.pm_GetOwner: TObject;
//#UC START# *4DD28E040057_48E229CC03DFget_var*
//#UC END# *4DD28E040057_48E229CC03DFget_var*
begin
//#UC START# *4DD28E040057_48E229CC03DFget_impl*
 if (f_Owner = nil) then
  Result := nil
 else
  Result := ((Il3Tool(f_Owner) As Il3ObjectWrap).GetObject As TPersistent);
//#UC END# *4DD28E040057_48E229CC03DFget_impl*
end;//TevEditorWindowHotSpot.pm_GetOwner

procedure TevEditorWindowHotSpot.DoBeforeSelection(const aView: InevControlView);
//#UC START# *48E4A900029B_48E229CC03DF_var*
//#UC END# *48E4A900029B_48E229CC03DF_var*
begin
//#UC START# *48E4A900029B_48E229CC03DF_impl*

//#UC END# *48E4A900029B_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoBeforeSelection

function TevEditorWindowHotSpot.NeedSelectCursor(const aView: InevControlView;
  const aPt: TnevPoint): Boolean;
//#UC START# *48E4A93300A9_48E229CC03DF_var*
//#UC END# *48E4A93300A9_48E229CC03DF_var*
begin
//#UC START# *48E4A93300A9_48E229CC03DF_impl*
 InevSelection((Owner As TevCustomEditorWindow).Selection).SelectPt(aPt, false);  
 Result := true;
//#UC END# *48E4A93300A9_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.NeedSelectCursor

function TevEditorWindowHotSpot.CheckCursorPos(const aView: InevView): Boolean;
//#UC START# *48E4A96000D4_48E229CC03DF_var*
//#UC END# *48E4A96000D4_48E229CC03DF_var*
begin
//#UC START# *48E4A96000D4_48E229CC03DF_impl*
 Result := True; //Для обычного редактора это не нужно!
//#UC END# *48E4A96000D4_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.CheckCursorPos

function TevEditorWindowHotSpot.DoLButtonDoubleClick(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E4A976007D_48E229CC03DF_var*
//#UC END# *48E4A976007D_48E229CC03DF_var*
begin
//#UC START# *48E4A976007D_48E229CC03DF_impl*
 Result := true;
 if (f_ForeignHotSpot = nil) OR
    ((ssShift in Keys.rKeys)) OR
    not f_ForeignHotSpot.LButtonDoubleClick(aView, Keys, Effect) then
  if Effect.rAllowAutoSelect then
  (Owner As TevCustomEditorWindow).Select(ev_stWord);
//#UC END# *48E4A976007D_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoLButtonDoubleClick

function TevEditorWindowHotSpot.DoLButtonDown(const aView: InevControlView;
  const aKeys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E4A99D02A2_48E229CC03DF_var*
var
 l_Pack : InevOp;
//#UC END# *48E4A99D02A2_48E229CC03DF_var*
begin
//#UC START# *48E4A99D02A2_48E229CC03DF_impl*
 Result := true;
 with (Owner As TevCustomEditorWindow) do
 begin
  l_Pack := StartOp(ev_msgMove);
  try
   if (Selection <> nil) then
    with Selection do
    begin
     DoBeforeSelection(aView);
     InevSelection(Selection).SelectPt(aKeys.rPoint, false);
     if (f_ClickCursor = nil) then
      f_ClickCursor := Cursor.ClonePoint(aView)
     else
      ClickCursor.AssignPoint(aView, Cursor);
     {if not !Double then StartMark.Assign(Cursor);}
    end;//with Selection
  finally
   l_Pack := nil;
  end;//try..finally
 end;//with (Owner As TevCustomEditorWindow)
//#UC END# *48E4A99D02A2_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoLButtonDown

constructor TevEditorWindowHotSpot.Create(const anOwner: Il3ToolOwner;
  const aForeignHotSpot: IevHotSpot);
//#UC START# *48EF2DAB031D_48E229CC03DF_var*
//#UC END# *48EF2DAB031D_48E229CC03DF_var*
begin
//#UC START# *48EF2DAB031D_48E229CC03DF_impl*
 inherited Create(anOwner);
 f_ForeignHotSpot := aForeignHotSpot;
//#UC END# *48EF2DAB031D_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.Create

class function TevEditorWindowHotSpot.Make(const anOwner: Il3ToolOwner;
  const aForeignHotSpot: IevHotSpot = nil): IevHotSpot;
var
 l_Inst : TevEditorWindowHotSpot;
begin
 l_Inst := Create(anOwner, aForeignHotSpot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevEditorWindowHotSpot.DoMouseMove(const aView: InevControlView;
  const aKeys: TevMouseState): Boolean;
//#UC START# *48EF36A30277_48E229CC03DF_var*
//#UC END# *48EF36A30277_48E229CC03DF_var*
begin
//#UC START# *48EF36A30277_48E229CC03DF_impl*
 Result := true;
 TranslatePt(aView, aKeys);
 AlignMarks(aView, aKeys);
 ExtendBlock(aView);
//#UC END# *48EF36A30277_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoMouseMove

function TevEditorWindowHotSpot.TryDragDrop(const aKeys: TevMouseState): Boolean;
//#UC START# *48EF36CC0039_48E229CC03DF_var*
var
 l_Pack       : InevOp;
 l_DataObject : TevDataObject;
 l_Block      : InevRange;
 l_OutEffect  : Integer;
 l_Formats    : Tl3ClipboardFormats;
//#UC END# *48EF36CC0039_48E229CC03DF_var*
begin
//#UC START# *48EF36CC0039_48E229CC03DF_impl*
 Result := false;
 if (aKeys.rInitialClick = afw_ckSingle) then
  with (Owner As TevCustomEditorWindow) do
  begin
   l_Pack := StartOp(ev_msgMove);
   try
    with Selection do
    begin
     // http://mdp.garant.ru/pages/viewpage.action?pageId=297714497
     if (ssCtrl in aKeys.rKeys) and (not DisableDragAndDropSupport) then
     begin
      if Supports(SaveBlock(Mouse), InevRange,  l_Block) then
       try
        if GetAvaliableFormats(l_Formats) then
         try
          l_DataObject := TevDataObject.Create(l_Block.Data, l_Formats, MakeExportFilters(false, false));
          try
           if (DoDragDrop(l_DataObject,
                          DROPEFFECT_Copy or DROPEFFECT_Move,
                          l_OutEffect) = DRAGDROP_S_DROP) then
           begin
           end;//DoDragDrop
           Result := true;
           Exit;
          finally
           l3Free(l_DataObject);
          end;//try..finally
         finally
          l_Formats := nil;
         end;//try..finally
       finally
        l_Block := nil;
       end;//try..finally
     end;//ssCtrl in aKeys.rKeys
    end;//with Selection
   finally
    l_Pack := nil;
   end;//try..finally
  end;//with (Owner As TevCustomEditorWindow)
//#UC END# *48EF36CC0039_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.TryDragDrop

procedure TevEditorWindowHotSpot.TranslatePt(const aView: InevControlView;
  const aKeys: TevMouseState);
//#UC START# *48EF37DF00C3_48E229CC03DF_var*
//#UC END# *48EF37DF00C3_48E229CC03DF_var*
begin
//#UC START# *48EF37DF00C3_48E229CC03DF_impl*
 with (Owner As TevCustomEditorWindow).Selection do
 begin
  if NeedSelectCursor(aView, aKeys.rPoint) then
  begin
   if aKeys.rInMove then
   begin
    if (ClickCursor = nil) then          
    begin
     {$IFDEF Archi}
     f_ClickCursor := Cursor.ClonePoint(aView);
     {$ELSE}
     f_ClickCursor := Start.ClonePoint(aView);
     {$ENDIF Archi}
     FinishMark.AssignPoint(aView, Finish);
    end//ClickCursor = nil
    else
     FinishMark.AssignPoint(aView, Cursor);
    StartMark.AssignPoint(aView, ClickCursor);
   end//aKeys.rInMove
   else
   begin
    if (ClickCursor = nil) then
     f_ClickCursor := Cursor.ClonePoint(aView)
    else
     ClickCursor.AssignPoint(aView, Cursor);
   end;//aKeys.rInMove
  end;//NeedSelectCursor(aPt) 
 end;//with (Owner As TevCustomEditorWindow)
//#UC END# *48EF37DF00C3_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.TranslatePt

procedure TevEditorWindowHotSpot.AlignMarks(const aView: InevControlView;
  const aKeys: TevMouseState);
//#UC START# *48EF380C026E_48E229CC03DF_var*
var
 l_S, l_F : Integer;  
//#UC END# *48EF380C026E_48E229CC03DF_var*
begin
//#UC START# *48EF380C026E_48E229CC03DF_impl*
 Case aKeys.rInitialClick of
  afw_ckSingle:
  begin
   if not (Owner As TevCustomEditorWindow).NeedAlignMarksOnSingleClick then
    Exit;
   l_S := ev_ocWordStart;
   l_F := ev_ocWordFinish;
  end;//afw_ckSingle, afw_ckDouble
  afw_ckDouble:
  begin
   l_S := ev_ocWordStart;
   l_F := ev_ocWordFinish;
  end;//afw_ckSingle, afw_ckDouble
  afw_ckTriple:
  begin
   l_S := ev_ocParaHome;
   l_F := ev_ocParaEnd;
  end;//afw_ckTriple
  else
   Exit;
 end;//Case aKeys.rInitialClick
 if (StartMark.Compare(FinishMark) < 0) then
 begin
  StartMark.Move(aView, l_S);
  FinishMark.Move(aView, l_F);
 end
 else
 begin
  StartMark.Move(aView, l_F);
  FinishMark.Move(aView, l_S);
 end;//StartMark.Compare(FinishMark) < 0
//#UC END# *48EF380C026E_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.AlignMarks

procedure TevEditorWindowHotSpot.ExtendBlock(const aView: InevControlView);
//#UC START# *48EF385503A8_48E229CC03DF_var*
//#UC END# *48EF385503A8_48E229CC03DF_var*
begin
//#UC START# *48EF385503A8_48E229CC03DF_impl*
 DoExtendBlock(aView, (Owner As TevCustomEditorWindow).Selection);
//#UC END# *48EF385503A8_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.ExtendBlock

procedure TevEditorWindowHotSpot.DoExtendBlock(const aView: InevControlView;
  const aSelection: InevSelection);
//#UC START# *48EF3A860139_48E229CC03DF_var*
//#UC END# *48EF3A860139_48E229CC03DF_var*
begin
//#UC START# *48EF3A860139_48E229CC03DF_impl*
 aSelection.AddBlock(StartMark, FinishMark);
//#UC END# *48EF3A860139_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoExtendBlock

function TevEditorWindowHotSpot.DoLButtonUp(const aView: InevControlView;
  const aKeys: TevMouseState;
  aNeedUnselect: Boolean): Boolean;
//#UC START# *48EF3C6E0276_48E229CC03DF_var*
var
 l_Editor : TevCustomEditorWindow;
//#UC END# *48EF3C6E0276_48E229CC03DF_var*
begin
//#UC START# *48EF3C6E0276_48E229CC03DF_impl*
 Result := true;
 l_Editor := Owner As TevCustomEditorWindow;
 with l_Editor do
 begin
  if not aKeys.rInMove AND
     aNeedUnselect AND (aKeys.rInitialClick = afw_ckSingle) AND
     (Selection <> nil) AND not Selection.Persistent then
   InevSelection(Selection).Unselect;
  DoUpdateBlock;
  DoParaChange;
 end;//with l_Editor
//#UC END# *48EF3C6E0276_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.DoLButtonUp

function TevEditorWindowHotSpot.BeginMouseOp(const aView: InevControlView;
  out theSelection: Tl3Base): InevOp;
//#UC START# *48EF3D680254_48E229CC03DF_var*
//#UC END# *48EF3D680254_48E229CC03DF_var*
begin
//#UC START# *48EF3D680254_48E229CC03DF_impl*
 with (Owner As TevCustomEditorWindow) do
 begin
  Result := StartOp(ev_msgMove);
  theSelection := Selection.Use;
 end;//with (Owner As TevCustomEditorWindow)
//#UC END# *48EF3D680254_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.BeginMouseOp

procedure TevEditorWindowHotSpot.HitTest(const aView: InevControlView;
  const aState: TafwCursorState;
  var theInfo: TafwCursorInfo);
//#UC START# *48E2622A03C4_48E229CC03DF_var*
//#UC END# *48E2622A03C4_48E229CC03DF_var*
begin
//#UC START# *48E2622A03C4_48E229CC03DF_impl*
 if (f_ForeignHotSpot <> nil) then
  f_ForeignHotSpot.HitTest(aView, aState, theInfo);
 with (Owner As TevCustomEditorWindow) do
  if (f_ForeignHotSpot = nil) then
   DoHitTest(Self, aState, theInfo)
  else
   DoHitTest(f_ForeignHotSpot, aState, theInfo);
//#UC END# *48E2622A03C4_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.HitTest

function TevEditorWindowHotSpot.MouseAction(const aView: InevControlView;
  aButton: Tl3MouseButton;
  anAction: Tl3MouseAction;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E263CD01BD_48E229CC03DF_var*
//#UC END# *48E263CD01BD_48E229CC03DF_var*
begin
//#UC START# *48E263CD01BD_48E229CC03DF_impl*
 Case aButton of
  l3_mbLeft:
  begin
   Case anAction of
    l3_maDown:
     Result := LButtonDown(aView, Keys, Effect);
    l3_maUp:
     Result := LButtonUp(aView, Keys);
    l3_maDouble:
     Result := LButtonDoubleClick(aView, Keys, Effect);
    else
     Result := false;
   end;//Case anAction
  end;//l3_mbLeft
  l3_mbRight:
  begin
   Case anAction of
    l3_maDown:
     Result := RButtonDown(aView, Keys);
    l3_maUp:
     Result := RButtonUp(aView, Keys);
    l3_maDouble:
     Result := false;
    else
     Result := false;
   end;//Case anAction
  end;//l3_mbRight
  l3_mbMiddle:
  begin
   Case anAction of
    l3_maDown:
     Result := MButtonDown(aView, Keys);
    l3_maUp:
     Result := MButtonUp(aView, Keys);
    l3_maDouble:
     Result := false;
    else
     Result := false;
   end;//Case anAction
  end;//l3_mbMiddle
  else
   Result := false;
 end;//Case aButton
//#UC END# *48E263CD01BD_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.MouseAction

function TevEditorWindowHotSpot.MouseMove(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266730188_48E229CC03DF_var*
//#UC END# *48E266730188_48E229CC03DF_var*
begin
//#UC START# *48E266730188_48E229CC03DF_impl*
 if (fl_ForeignHotSpotMove = ev_fhsmEnabled) then
  Result := f_ForeignHotSpot.MouseMove(aView, Keys)
 else
 begin 
  Result := DoMouseMove(aView, Keys);
  aView.Control.ViewArea.Update;
 end;//fl_ForeignHotSpotMove
//#UC END# *48E266730188_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.MouseMove

function TevEditorWindowHotSpot.LButtonDown(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266AA00A4_48E229CC03DF_var*
var
 l_CursorBefore : InevBasePoint;
 l_HS           : IevHotSpot;
//#UC END# *48E266AA00A4_48E229CC03DF_var*
begin
//#UC START# *48E266AA00A4_48E229CC03DF_impl*
 if (f_ForeignHotSpot = nil) or f_ForeignHotSpot.CanDrag then
  if TryDragDrop(Keys) then
  begin
   Result := false;
   Exit;
  end;//TryDragDrop(aKeys)
 Result := true;
 if (f_ForeignHotSpot = nil) then
  l_HS := Self
 else
  l_HS := f_ForeignHotSpot;
 with (Owner As TevCustomEditorWindow) do
  if Assigned(OnMouseAction) then
   if OnMouseAction(l_HS, l3_mbLeft, l3_maDown, Keys.rKeys, Effect.rNeedAsyncLoop) then
    Exit;
 if (f_ForeignHotSpot <> nil) AND
    f_ForeignHotSpot.LButtonDown(aView, Keys, Effect) then
  fl_ForeignHotSpotMove := ev_fhsmEnabled
 else
 begin
  fl_ForeignHotSpotMove := ev_fhsmDisabled;
  with (Owner As TevCustomEditorWindow).Selection do
   if Collapsed then
    l_CursorBefore := Cursor.ClonePoint(aView)
   else
    l_CursorBefore := StartMark.ClonePoint(aView);
  try
   Effect.rExtendingSelection := ([ssCtrl, ssShift, ssAlt] * Keys.rKeys) = [ssShift];
   Result := DoLButtonDown(aView, Keys, Effect);
   if Effect.rExtendingSelection then
    ClickCursor.AssignPoint(aView, l_CursorBefore);
  finally
   l_CursorBefore := nil;
  end;//try..finally 
 end;//f_ForeignHotSpot <> nil..
//#UC END# *48E266AA00A4_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.LButtonDown

function TevEditorWindowHotSpot.LButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266C70128_48E229CC03DF_var*
var
 l_Unselect : Boolean;  
 l_Editor : TevCustomEditorWindow;
//#UC END# *48E266C70128_48E229CC03DF_var*
begin
//#UC START# *48E266C70128_48E229CC03DF_impl*
 Result := true;
 if (fl_ForeignHotSpotMove <> ev_fhsmDisabled) AND
    (f_ForeignHotSpot <> nil) then
  try
   Result := f_ForeignHotSpot.LButtonUp(aView, Keys);
  except
   on EevReadOnly do;
  end//try..except
 else
 begin
  l_Unselect := true;
  if not Keys.rInMove then
  begin
   if (StartMark <> nil) then   
   begin
    if CheckCursorPos(aView) then
    begin
(*     l_Editor := Owner As TevCustomEditorWindow;
     if (l_Editor.Selection <> nil) AND
        not l_Editor.Selection.Persistent then*)
     // http://mdp.garant.ru/pages/viewpage.action?pageId=227478574
     // - закомментировано, ибо - http://mdp.garant.ru/pages/viewpage.action?pageId=296631959   
      StartMark.AssignPoint(aView, FinishMark);
    end//CheckCursorPos(aView)
    else
     l_Unselect := false;
   end;//StartMark <> nil
  end//not Keys.rInMove
  else
   CheckCursorPos(aView);   
  if not Keys.rInMove then
   if (Owner As TevCustomEditorWindow).CheckMouseUp(Self, Keys) then
    Exit;
  Result := DoLButtonUp(aView, Keys, l_Unselect);
  if not Keys.rInMove then
   with (Owner As TevCustomEditorWindow) do
    if (ev_uwfBlock in UpdateFlags) then
     Invalidate;
 end;//fl_ForeignHotSpotMove
//#UC END# *48E266C70128_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.LButtonUp

function TevEditorWindowHotSpot.LButtonDoubleClick(const aView: InevControlView;
  const Keys: TevMouseState;
  var Effect: TevMouseEffect): Boolean;
//#UC START# *48E266DE026B_48E229CC03DF_var*
var
 l_HS : IevHotSpot;
//#UC END# *48E266DE026B_48E229CC03DF_var*
begin
//#UC START# *48E266DE026B_48E229CC03DF_impl*
 if (f_ForeignHotSpot = nil) then
  l_HS := Self
 else
  l_HS := f_ForeignHotSpot;
 with (Owner As TevCustomEditorWindow) do
  if Assigned(OnMouseAction) then
   if OnMouseAction(l_HS, l3_mbLeft, l3_maDouble, Keys.rKeys, Effect.rNeedAsyncLoop) then
   begin
    Result := true; 
    Exit;
   end;//OnMouseAction..
 Result := DoLButtonDoubleClick(aView, Keys, Effect);
//#UC END# *48E266DE026B_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.LButtonDoubleClick

function TevEditorWindowHotSpot.RButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E266FB01FC_48E229CC03DF_var*
//#UC END# *48E266FB01FC_48E229CC03DF_var*
begin
//#UC START# *48E266FB01FC_48E229CC03DF_impl*
 Result := (f_ForeignHotSpot <> nil) AND
           f_ForeignHotSpot.RButtonDown(aView, Keys);
//#UC END# *48E266FB01FC_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.RButtonDown

function TevEditorWindowHotSpot.RButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *48E267150266_48E229CC03DF_var*
//#UC END# *48E267150266_48E229CC03DF_var*
begin
//#UC START# *48E267150266_48E229CC03DF_impl*
 Result := (f_ForeignHotSpot <> nil) AND
           f_ForeignHotSpot.RButtonUp(aView, Keys);
//#UC END# *48E267150266_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.RButtonUp

function TevEditorWindowHotSpot.MButtonDown(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB4675025E_48E229CC03DF_var*
//#UC END# *49DB4675025E_48E229CC03DF_var*
begin
//#UC START# *49DB4675025E_48E229CC03DF_impl*
 Result := (f_ForeignHotSpot <> nil) AND
           f_ForeignHotSpot.MButtonDown(aView, Keys);
//#UC END# *49DB4675025E_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.MButtonDown

function TevEditorWindowHotSpot.MButtonUp(const aView: InevControlView;
  const Keys: TevMouseState): Boolean;
//#UC START# *49DB468302A5_48E229CC03DF_var*
//#UC END# *49DB468302A5_48E229CC03DF_var*
begin
//#UC START# *49DB468302A5_48E229CC03DF_impl*
 Result := (f_ForeignHotSpot <> nil) AND
           f_ForeignHotSpot.MButtonUp(aView, Keys);
//#UC END# *49DB468302A5_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.MButtonUp

function TevEditorWindowHotSpot.CanDrag: Boolean;
//#UC START# *4ECCD6840014_48E229CC03DF_var*
//#UC END# *4ECCD6840014_48E229CC03DF_var*
begin
//#UC START# *4ECCD6840014_48E229CC03DF_impl*
 Result := True;
//#UC END# *4ECCD6840014_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.CanDrag

procedure TevEditorWindowHotSpot.Cleanup;
//#UC START# *479731C50290_48E229CC03DF_var*
//#UC END# *479731C50290_48E229CC03DF_var*
begin
//#UC START# *479731C50290_48E229CC03DF_impl*
 fl_ForeignHotSpotMove := ev_fhsmNone;
 f_ClickCursor := nil;
 f_ForeignHotSpot := nil;
 inherited;
//#UC END# *479731C50290_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.Cleanup

function TevEditorWindowHotSpot.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_48E229CC03DF_var*
//#UC END# *4A60B23E00C3_48E229CC03DF_var*
begin
//#UC START# *4A60B23E00C3_48E229CC03DF_impl*
 if IID.EQ(Il3TagRef) then
  Result.SetNoInterface
 else
  Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail AND (f_ForeignHotSpot <> nil) then
  Result := Tl3HResult_C(f_ForeignHotSpot.QueryInterface(IID.IID, Obj));
//#UC END# *4A60B23E00C3_48E229CC03DF_impl*
end;//TevEditorWindowHotSpot.COMQueryInterface

procedure TevEditorWindowHotSpot.ClearFields;
 {-}
begin
 f_ForeignHotSpot := nil;
 f_ClickCursor := nil;
 inherited;
end;//TevEditorWindowHotSpot.ClearFields

end.