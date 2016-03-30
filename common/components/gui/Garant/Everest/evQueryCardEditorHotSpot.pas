unit evQueryCardEditorHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\evQueryCardEditorHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevQueryCardEditorHotSpot" MUID: (48E2366202B9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditorWindowHotSpot
 , nevTools
 , nevBase
;

type
 TevQueryCardEditorHotSpot = class(TevEditorWindowHotSpot)
  private
   f_CursorPoint: InevBasePoint;
    {* Позиция курсора до начала выделения }
  protected
   procedure DoBeforeSelection(const aView: InevControlView); override;
    {* Запоминает точку начала выделения }
   function NeedSelectCursor(const aView: InevControlView;
    const aPt: TnevPoint): Boolean; override;
    {* Проверяет корректность выделения при движении мыши и, если
             выделение заканчивается за пределами параграфа-виджета, то
             возвращаемся к запомненной в DoBeforeSelection точке }
   function CheckCursorPos(const aView: InevView): Boolean; override;
    {* Вызывается для проверки позиционирования курсора и/или окончания
             выделения. Срабатывает после отпускания кнопки мыши, если
             управление не было перехвачено самим виджетом }
   function DoLButtonDoubleClick(const aView: InevControlView;
    const Keys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; override;
   function DoLButtonDown(const aView: InevControlView;
    const aKeys: TevMouseState;
    var Effect: TevMouseEffect): Boolean; override;
 end;//TevQueryCardEditorHotSpot

implementation

uses
 l3ImplUses
 , k2Tags
 , evControlParaConst
 , SysUtils
 , evQueryCardInt
 , evdTypes
 , evQueryCardEditor
 , l3Interfaces
;

procedure TevQueryCardEditorHotSpot.DoBeforeSelection(const aView: InevControlView);
 {* Запоминает точку начала выделения }
//#UC START# *48E4A900029B_48E2366202B9_var*
//#UC END# *48E4A900029B_48E2366202B9_var*
begin
//#UC START# *48E4A900029B_48E2366202B9_impl*
 f_CursorPoint := (Owner As TevQueryCardEditor).Selection.Cursor.ClonePoint(aView);
//#UC END# *48E4A900029B_48E2366202B9_impl*
end;//TevQueryCardEditorHotSpot.DoBeforeSelection

function TevQueryCardEditorHotSpot.NeedSelectCursor(const aView: InevControlView;
 const aPt: TnevPoint): Boolean;
 {* Проверяет корректность выделения при движении мыши и, если
             выделение заканчивается за пределами параграфа-виджета, то
             возвращаемся к запомненной в DoBeforeSelection точке }
//#UC START# *48E4A93300A9_48E2366202B9_var*
var
 l_Point: InevBasePoint;
//#UC END# *48E4A93300A9_48E2366202B9_var*
begin
//#UC START# *48E4A93300A9_48E2366202B9_impl*
 with (Owner As TevQueryCardEditor), Selection do
 begin
   l_Point := Cursor.ClonePoint(aView);
   inherited NeedSelectCursor(aView, aPt);
   Result := TevControlType(Cursor.MostInner.Obj.AsObject.IntA[k2_tiType]) in evEditControls;
   if not Result then
    InevSelection(Selection).SelectPoint(l_Point, False);
 end;//with (Owner As TevQueryCardEditor).Selection do
//#UC END# *48E4A93300A9_48E2366202B9_impl*
end;//TevQueryCardEditorHotSpot.NeedSelectCursor

function TevQueryCardEditorHotSpot.CheckCursorPos(const aView: InevView): Boolean;
 {* Вызывается для проверки позиционирования курсора и/или окончания
             выделения. Срабатывает после отпускания кнопки мыши, если
             управление не было перехвачено самим виджетом }
//#UC START# *48E4A96000D4_48E2366202B9_var*
var
 l_CursorTag: PInevObject;
 l_ParaType: TevControlType;
 l_Para: IevControlFriend;
 l_Field : IevEditorControlField;
 l_Cal: IevEditorCalendarField;
//#UC END# *48E4A96000D4_48E2366202B9_var*
begin
//#UC START# *48E4A96000D4_48E2366202B9_impl*
 try
  with (Owner As TevQueryCardEditor) do
  begin
   l_CursorTag := Selection.Cursor.MostInner.Obj;
   l_ParaType := TevControlType(l_CursorTag.AsObject.IntA[k2_tiType]);
   if (f_CursorPoint <> nil) and
    not (l_ParaType in evEditControls) then
   begin
    InevSelection(Selection).SelectPoint(f_CursorPoint, False);
    //SetFlag(ev_uwfCursor);
    Update;
    Result := False;
   end
   else
   if Assigned(f_CursorPoint) and not l_CursorTag.AsObject.IsSame(f_CursorPoint.MostInner.Obj^.AsObject) and
    l_CursorTag.AsObject.QT(IevControlFriend, l_Para, Processor) and Assigned(l_Para) and
    Supports(l_Para.GetControl, IevEditorControlField, l_Field) and l_Field.SelectAllOnFocus then
   begin
    InevSelection(Selection).SelectPoint(l_Para.MakePoint, False);
    InevSelection(Selection).Unselect;
    if (l_ParaType <> ev_ctCalEdit) or (Supports(l_Field, IevEditorCalendarField, l_Cal) and not l_Cal.IsBlank) then
    begin
     InevSelection(Selection).Select(l_Para.SubRange(aView, 0, MaxInt), false);
    end;
     Result := False;
    end
   else Result := True;
  end;
 finally
  f_CursorPoint := nil;
 end;
//#UC END# *48E4A96000D4_48E2366202B9_impl*
end;//TevQueryCardEditorHotSpot.CheckCursorPos

function TevQueryCardEditorHotSpot.DoLButtonDoubleClick(const aView: InevControlView;
 const Keys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *48E4A976007D_48E2366202B9_var*
//#UC END# *48E4A976007D_48E2366202B9_var*
begin
//#UC START# *48E4A976007D_48E2366202B9_impl*
 Result := inherited DoLButtonDoubleClick(aView, Keys, Effect);
 Effect.rNeedAsyncLoop := False; //Не нужно, т.к. появляется эффект щелканья по ссылкам
 //и кнопкам после двойного щелчка по пустому пространству и быстрому
 //передвижению мышью.
 // !!! LAW уж не заплатка ли это к тому, что я уже починил - когда брались неверные координаты начала выделения?
//#UC END# *48E4A976007D_48E2366202B9_impl*
end;//TevQueryCardEditorHotSpot.DoLButtonDoubleClick

function TevQueryCardEditorHotSpot.DoLButtonDown(const aView: InevControlView;
 const aKeys: TevMouseState;
 var Effect: TevMouseEffect): Boolean;
//#UC START# *48E4A99D02A2_48E2366202B9_var*
var
 l_QueryEditor: IevQueryCardEditor;
//#UC END# *48E4A99D02A2_48E2366202B9_var*
begin
//#UC START# *48E4A99D02A2_48E2366202B9_impl*
 if Supports(Il3ToolOwner(f_Owner), IevQueryCardEditor, l_QueryEditor) then
  l_QueryEditor.NotifyEmptySpace;
 Result := inherited DoLButtonDown(aView, aKeys, Effect);
//#UC END# *48E4A99D02A2_48E2366202B9_impl*
end;//TevQueryCardEditorHotSpot.DoLButtonDown

end.
