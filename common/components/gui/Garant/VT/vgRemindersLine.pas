unit vgRemindersLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3Interfaces,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  Types,
  l3InterfacedComponent,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  Windows
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3ProtoDataContainer
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  vg_objects,
  vgTypes
  {$If not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vtPopupFormModelPart
  {$IfEnd} //not NoVCM AND not NoVGScene
  ,
  afwDockingInterfaces,
  NewRemindersInterfaces,
  vgRemindersLineForm,
  l3TabbedContainersDispatcher,
  l3Types,
  l3Memory,
  l3Core,
  l3Except
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgReminder = class(Tl3InterfacedComponent {$If not defined(NoVCM)}, IvcmDatasourceChangeListener{$IfEnd} //not NoVCM
 , IvgReminder)
 private
 // private fields
   f_FlashTimer : TTimer;
   f_vgText : TvgText;
   f_TextRectColor : AnsiString;
   f_PopupForm : TvtPopupFormModelPart;
    {* Поле для свойства PopupForm}
   f_ImageIndex : TImageIndex;
    {* Поле для свойства ImageIndex}
   f_Caption : Il3CString;
    {* Поле для свойства Caption}
   f_Hint : Il3CString;
    {* Поле для свойства Hint}
   f_IsFlash : Boolean;
    {* Поле для свойства IsFlash}
   f_vgTextRect : TvgRectangle;
    {* Поле для свойства vgTextRect}
   f_vgImage : TvgImage;
    {* Поле для свойства vgImage}
   f_Visible : Boolean;
    {* Поле для свойства Visible}
   f_PopupFormBounds : TPopupFormBoundsRects;
    {* Поле для свойства PopupFormBounds}
   f_UserType : TvcmUserType;
    {* Поле для свойства UserType}
   f_PopupFormControl : TControl;
    {* Поле для свойства PopupFormControl}
   f_OnPopupFormShow : TNotifyEvent;
    {* Поле для свойства OnPopupFormShow}
   f_OnPopupFormHide : TNotifyEvent;
    {* Поле для свойства OnPopupFormHide}
   f_OnShow : TNotifyEvent;
    {* Поле для свойства OnShow}
   f_OnHide : TNotifyEvent;
    {* Поле для свойства OnHide}
   f_PopupMenu : TPopupMenu;
    {* Поле для свойства PopupMenu}
   f_SortIndex : Integer;
    {* Поле для свойства SortIndex}
 private
 // private methods
   procedure FlashTimer(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DoChange;
     {* Сигнатура метода DoChange }
   procedure ImageClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure MouseDown(Sender: TObject;
     Button: TMouseButton;
     Shift: TShiftState;
     X: Single;
     Y: Single);
   procedure MouseUp(Sender: TObject;
     Button: TMouseButton;
     Shift: TShiftState;
     X: Single;
     Y: Single);
   procedure AfterBaloonHidden(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure UpdateTextRectColor;
     {* Сигнатура метода UpdateTextRectColor }
 protected
 // property methods
   procedure pm_SetImageIndex(aValue: TImageIndex);
   procedure pm_SetCaption(const aValue: Il3CString);
   procedure pm_SetHint(const aValue: Il3CString);
   procedure pm_SetVisible(aValue: Boolean);
   procedure pm_SetPopupFormControl(aValue: TControl);
   function pm_GetFlashInterval: Integer;
   procedure pm_SetFlashInterval(aValue: Integer);
   function pm_GetFlash: Boolean;
   procedure pm_SetFlash(aValue: Boolean);
   function pm_GetShowHint: Boolean;
   procedure pm_SetShowHint(aValue: Boolean);
   procedure pm_SetSortIndex(aValue: Integer);
 protected
 // realized methods
  {$If not defined(NoVCM)}
   procedure DataSourceChanged(aControl: TControl);
  {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure DoClick(out aHandled: Boolean); virtual;
   procedure UpdateAction; virtual;
     {* Сигнатура метода UpdateAction }
   procedure DoPopupFormVisibleChanged(aVisible: Boolean);
   procedure DoVisibleChanged(aVisible: Boolean);
   procedure UpdateImage;
     {* Сигнатура метода UpdateImage }
   procedure ReleaseResources;
     {* Сигнатура метода ReleaseResources }
 public
 // public methods
   procedure UpdateControls;
     {* Пересчитать размеры vgRect }
   procedure Click;
     {* Сигнатура метода Click }
 public
 // public properties
   property PopupForm: TvtPopupFormModelPart
     read f_PopupForm;
   property ImageIndex: TImageIndex
     read f_ImageIndex
     write pm_SetImageIndex;
   property Caption: Il3CString
     read f_Caption
     write pm_SetCaption;
   property Hint: Il3CString
     read f_Hint
     write pm_SetHint;
   property IsFlash: Boolean
     read f_IsFlash;
     {* Состояние медали при мигании }
   property vgTextRect: TvgRectangle
     read f_vgTextRect;
   property vgImage: TvgImage
     read f_vgImage;
   property Visible: Boolean
     read f_Visible
     write pm_SetVisible;
   property PopupFormBounds: TPopupFormBoundsRects
     read f_PopupFormBounds
     write f_PopupFormBounds;
   property UserType: TvcmUserType
     read f_UserType
     write f_UserType;
   property PopupFormControl: TControl
     read f_PopupFormControl
     write pm_SetPopupFormControl;
   property FlashInterval: Integer
     read pm_GetFlashInterval
     write pm_SetFlashInterval;
   property Flash: Boolean
     read pm_GetFlash
     write pm_SetFlash;
   property OnPopupFormShow: TNotifyEvent
     read f_OnPopupFormShow
     write f_OnPopupFormShow;
   property OnPopupFormHide: TNotifyEvent
     read f_OnPopupFormHide
     write f_OnPopupFormHide;
   property OnShow: TNotifyEvent
     read f_OnShow
     write f_OnShow;
   property OnHide: TNotifyEvent
     read f_OnHide
     write f_OnHide;
   property PopupMenu: TPopupMenu
     read f_PopupMenu
     write f_PopupMenu;
   property ShowHint: Boolean
     read pm_GetShowHint
     write pm_SetShowHint;
   property SortIndex: Integer
     read f_SortIndex
     write pm_SetSortIndex;
 end;//TvgReminder

 _ItemType_ = TvgReminder;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TvgRemindersList = class(_l3UncomparabeObjectRefList_)
 end;//TvgRemindersList

 TvgRemindersLine = class(Tl3InterfacedComponent, Il3WndProcListener, IafwTabSheetControl, IafwControlDock, Il3WndProcRetListener, IvgRemindersLine {$If not defined(NoVCM)}, IvcmComponentContainer{$IfEnd} //not NoVCM
  {$If not defined(NoVCM)}, IvcmResourceHolder{$IfEnd} //not NoVCM
  {$If not defined(NoVCM)}, IvcmMainFormDependent{$IfEnd} //not NoVCM
 , Il3SelectedTabDependent)
 private
 // private fields
   f_UpdateCount : Integer;
   f_NeedCallChanged : Boolean;
    {* Внутри скобок BeginUpdate/EndUpdate вызывали Changed}
   f_RemindersList : TvgRemindersList;
   f_OldLeft : Integer;
    {* Сохраняем координаты, чтобы определить, перемещал пользователь линию, или кликал по медали}
   f_OldTop : Integer;
    {* Сохраняем координаты, чтобы определить, перемещал пользователь линию, или кликал по медали}
   f_MainForm : TWinControl;
   f_PageIsHidden : Boolean;
   f_SyncPosSent : Boolean;
   f_InMenu : Boolean;
   f_RestoreWindowTimer : TTimer;
   f_ActivateProcessingLockCount : Integer;
   f_Parent : TWinControl;
    {* Поле для свойства Parent}
   f_HorzPos : single;
    {* Поле для свойства HorzPos}
   f_VertPos : single;
    {* Поле для свойства VertPos}
   f_Form : TvgRemindersLineForm;
    {* Поле для свойства Form}
   f_Visible : Boolean;
    {* Поле для свойства Visible}
   f_Images : TCustomImageList;
    {* Поле для свойства Images}
   f_Sorted : Boolean;
    {* Поле для свойства Sorted}
 private
 // private methods
   procedure UpdateReminders;
     {* Сигнатура метода UpdateReminders }
   procedure UpdateReminder(aIndex: Integer);
     {* Обновить картинку, размеры и положение контролов медали }
   function ReminderBounds(aIndex: Integer;
     anImageOnly: Boolean): TRect; overload; 
   function ReminderBounds(aReminder: TvgReminder;
     anImageOnly: Boolean): TRect; overload; 
   function PrevVisibleReminder(aReminder: TvgReminder): TvgReminder; overload; 
   procedure DoChanged;
     {* Сигнатура метода DoChanged }
   procedure CalcPopupFormBounds(aReminder: TvgReminder);
     {* Посчитать расположение баллона относительно медали }
   procedure AdjustPopupFormPosition(aReminder: TvgReminder;
     aTailLocked: Boolean;
     aCanMoveLine: Boolean); overload; 
     {* Двигает форму к своей медали. Если надо, меняет её "хвост". }
   function PrevVisibleReminder(aIndex: Integer): TvgReminder; overload; 
   procedure ReminderMouseDown(Sender: TvgReminder;
     Button: TMouseButton);
   procedure ReminderMouseUp(Sender: TvgReminder;
     Button: TMouseButton);
   procedure BringPopupFormToFront;
     {* Сигнатура метода BringPopupFormToFront }
   procedure ReminderClick(aReminder: TvgReminder);
   function MainFormHandle: HWND;
   function VisiblePopupForm: TvtPopupFormModelPart;
   procedure SendSyncPosition;
     {* Сигнатура метода SendSyncPosition }
   procedure RestoreWindowTimerProc(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure AdjustPopupFormPosition(aTailLocked: Boolean;
     aCanMoveLine: Boolean); overload; 
 protected
 // property methods
   procedure pm_SetParent(aValue: TWinControl);
   procedure pm_SetHorzPos(aValue: single);
   procedure pm_SetVertPos(aValue: single);
   function pm_GetCount: Integer;
   function pm_GetVisible: Boolean;
   procedure pm_SetVisible(aValue: Boolean);
   procedure pm_SetImages(aValue: TCustomImageList);
   function pm_GetReminder(aIndex: Integer): TvgReminder;
   function pm_GetLeft: Integer;
   function pm_GetTop: Integer;
   function pm_GetAbsLeft: Integer;
   function pm_GetAbsTop: Integer;
   function pm_GetWidth: Integer;
   function pm_GetHeight: Integer;
   procedure pm_SetSorted(aValue: Boolean);
   function pm_GetIsActivateProcessingLocked: Boolean;
 protected
 // realized methods
   procedure PageInactive;
     {* активная закладка стала не активной. }
   procedure PageActive;
     {* закладка стала активной. }
   function pm_GetWeight: Integer;
   function GetDockControl(const aDockable: IafwDockableControl): TWinControl;
   procedure WndProcListenerNotify(Msg: PCWPStruct;
     var theResult: Tl3HookProcResult);
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
     var theResult: Tl3HookProcResult);
   procedure ControlDropped(aControl: TControl);
   procedure RemindersLineFormDestroyed;
     {* Сигнатура метода RemindersLineFormDestroyed }
   function IsInMove: Boolean;
     {* Линию двигают }
   procedure CorrectBounds(var aLeft: Integer;
     var aTop: Integer;
     var aWidth: Integer;
     var aHeight: Integer);
   procedure UpdateActions;
     {* Сигнатура метода UpdateActions }
   {$If not defined(NoVCM)}
   function Get_Count: Integer;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function Get_OwnedComponent(aIndex: Integer): TComponent;
   {$IfEnd} //not NoVCM
   procedure SyncPosition;
     {* Сигнатура метода SyncPosition }
    {$If not defined(NoVCM)}
   procedure ReleaseResources;
     {* Сигнатура метода ReleaseResources }
    {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure MainFormChanged(aForm: TControl);
     {* Вызывается при измении главной формы }
   {$IfEnd} //not NoVCM
   procedure TabBecomeActive;
   procedure TabBecomeInactive;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure BoundsChanged(aLeft: Integer;
     aTop: Integer;
     aWidth: Integer;
     aHeight: Integer); virtual;
   procedure FixPosition;
     {* Посчитать f_HorzPos и f_VertPos }
 public
 // public methods
   procedure BeginUpdate;
     {* Сигнатура метода BeginUpdate }
   procedure EndUpdate;
     {* Сигнатура метода EndUpdate }
   procedure ClosePopupForm;
     {* Сигнатура метода ClosePopupForm }
   procedure OffsetLine(aShiftX: Integer;
     aShiftY: Integer);
   procedure CheckZOrder;
     {* Сигнатура метода CheckZOrder }
   procedure LockActivateProcessing;
     {* Сигнатура метода LockActivateProcessing }
   procedure UnlockActivateProcessing;
     {* Сигнатура метода UnlockActivateProcessing }
 private
 // private properties
   property IsActivateProcessingLocked: Boolean
     read pm_GetIsActivateProcessingLocked;
 protected
 // protected properties
   property Form: TvgRemindersLineForm
     read f_Form;
 public
 // public properties
   property Parent: TWinControl
     read f_Parent
     write pm_SetParent;
     {* Контрол, "внутри" которого должны лежать медали }
   property HorzPos: single
     read f_HorzPos
     write pm_SetHorzPos;
   property VertPos: single
     read f_VertPos
     write pm_SetVertPos;
   property Count: Integer
     read pm_GetCount;
   property Visible: Boolean
     read pm_GetVisible
     write pm_SetVisible;
   property Images: TCustomImageList
     read f_Images
     write pm_SetImages;
   property Reminder[aIndex: Integer]: TvgReminder
     read pm_GetReminder;
   property Left: Integer
     read pm_GetLeft;
   property Top: Integer
     read pm_GetTop;
   property AbsLeft: Integer
     read pm_GetAbsLeft;
   property AbsTop: Integer
     read pm_GetAbsTop;
   property Width: Integer
     read pm_GetWidth;
   property Height: Integer
     read pm_GetHeight;
   property Sorted: Boolean
     read f_Sorted
     write pm_SetSorted;
 end;//TvgRemindersLine
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ReminderWordsPack
  {$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
  ,
  l3Base,
  l3MinMax,
  RTLConsts,
  vtPngImgList,
  vtInterfaces,
  l3ListenersManager,
  Messages,
  l3String,
  Math,
  vg_controls,
  vg_scene,
  vtPopupForm,
  l3Defaults,
  vgReminderConsts
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  afwFacade,
  vgReminderWithAction,
  vgRemindersLineManager,
  l3ByteList,
  vgRemindersLineNotificationProxy,
  l3DwmApi,
  vgRemindersLineTabbedContainerNotificationProxy
  {$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  RemindersLineWordsPack
  {$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgRemindersLine

procedure TvgRemindersLine.UpdateReminders;
//#UC START# *5326D8A303AD_532322D901A3_var*
var
 I: Integer;
 l_Rem: TvgReminder;
//#UC END# *5326D8A303AD_532322D901A3_var*
begin
//#UC START# *5326D8A303AD_532322D901A3_impl*
 if Count > 0 then
 begin
  f_Form.Height := 1; // http://mdp.garant.ru/pages/viewpage.action?pageId=531986234
  for I := 0 to Count - 1 do
  begin
   UpdateReminder(I);
   if Reminder[I].Visible then
    with ReminderBounds(I, False) do
     f_Form.Height := Max(f_Form.Height, Bottom - Top);
  end;
  l_Rem := PrevVisibleReminder(Count);
  if Assigned(l_Rem)
   then f_Form.Width := ReminderBounds(l_Rem, False).Right
   else f_Form.Width := 1; // http://mdp.garant.ru/pages/viewpage.action?pageId=531986234
  SyncPosition;
 end;
//#UC END# *5326D8A303AD_532322D901A3_impl*
end;//TvgRemindersLine.UpdateReminders

procedure TvgRemindersLine.UpdateReminder(aIndex: Integer);
//#UC START# *5329FD1E00AB_532322D901A3_var*
var
 l_Reminder: TvgReminder;
 l_PrevReminder: TvgReminder;
 l_Image: TvgImage;
//#UC END# *5329FD1E00AB_532322D901A3_var*
begin
//#UC START# *5329FD1E00AB_532322D901A3_impl*
 Assert((aIndex >= 0) and (aIndex < Count));

 l_Reminder := f_RemindersList[aIndex];
 if not l_Reminder.Visible then
  Exit;
 l_Reminder.UpdateControls;
 l_Image := l_Reminder.vgImage;
 l_PrevReminder := PrevVisibleReminder(aIndex);
 if Assigned(l_PrevReminder)
  then l_Image.Position.X := ReminderBounds(l_PrevReminder, False).Right + c_ReminderDistance
  else l_Image.Position.X := 0;
 l_Image.Position.Y := 0;

 with l_Reminder.vgTextRect do
  if Visible then
  begin
   Position.Y := l_Image.Position.Y + l_Image.Height + c_ReminderDistance;
   if Width > l_Image.Width then
   begin
    Position.X := l_Image.Position.X;
    l_Image.Position.X := Position.X + (Width - l_Image.Width) / 2;
   end
   else
    Position.X := l_Image.Position.X;
  end;
//#UC END# *5329FD1E00AB_532322D901A3_impl*
end;//TvgRemindersLine.UpdateReminder

function TvgRemindersLine.ReminderBounds(aIndex: Integer;
  anImageOnly: Boolean): TRect;
//#UC START# *532AE1590008_532322D901A3_var*
//#UC END# *532AE1590008_532322D901A3_var*
begin
//#UC START# *532AE1590008_532322D901A3_impl*
 Result := ReminderBounds(f_RemindersList[aIndex], anImageOnly);
//#UC END# *532AE1590008_532322D901A3_impl*
end;//TvgRemindersLine.ReminderBounds

function TvgRemindersLine.ReminderBounds(aReminder: TvgReminder;
  anImageOnly: Boolean): TRect;
//#UC START# *533021ED0125_532322D901A3_var*
//#UC END# *533021ED0125_532322D901A3_var*
begin
//#UC START# *533021ED0125_532322D901A3_impl*
 with aReminder do
 if anImageOnly or not vgTextRect.Visible then
 begin
  Result.Left := Round(vgImage.Position.X);
  Result.Top := Round(vgImage.Position.Y);
  Result.Right := Result.Left + Round(vgImage.Width);
  Result.Bottom := Round(vgImage.Height);
 end else
 begin
  Result.Left := Round(Math.Min(vgImage.Position.X, vgTextRect.Position.X));
  Result.Top := Round(vgImage.Position.Y);
  Result.Right := Result.Left + Round(Math.Max(vgImage.Width, vgTextRect.Width));
  Result.Bottom := Round(vgTextRect.Position.Y + vgTextRect.Height);
 end;
//#UC END# *533021ED0125_532322D901A3_impl*
end;//TvgRemindersLine.ReminderBounds

function TvgRemindersLine.PrevVisibleReminder(aReminder: TvgReminder): TvgReminder;
//#UC START# *5330221B0241_532322D901A3_var*
//#UC END# *5330221B0241_532322D901A3_var*
begin
//#UC START# *5330221B0241_532322D901A3_impl*
 Assert(f_RemindersList.IndexOf(aReminder) >= 0);
 Result := PrevVisibleReminder(f_RemindersList.IndexOf(aReminder));
//#UC END# *5330221B0241_532322D901A3_impl*
end;//TvgRemindersLine.PrevVisibleReminder

procedure TvgRemindersLine.DoChanged;
//#UC START# *5330270F0006_532322D901A3_var*
//#UC END# *5330270F0006_532322D901A3_var*
begin
//#UC START# *5330270F0006_532322D901A3_impl*
 if f_UpdateCount = 0 then
  UpdateReminders
 else
  f_NeedCallChanged := True;
//#UC END# *5330270F0006_532322D901A3_impl*
end;//TvgRemindersLine.DoChanged

procedure TvgRemindersLine.CalcPopupFormBounds(aReminder: TvgReminder);
//#UC START# *53316A4601CB_532322D901A3_var*
var
 l_PopupFormBoundsRects: TPopupFormBoundsRects;
 l_Width: Integer;
 l_Height: Integer;
 l_WidthNew: Integer;
 l_HeightNew: Integer;
 l_ImageHeight: Integer;
 l_V: IafwFormView;
 l_Control: TControl;
 l_ReminderRect: TRect;
//#UC END# *53316A4601CB_532322D901A3_var*
begin
//#UC START# *53316A4601CB_532322D901A3_impl*
 l3FillChar(l_PopupFormBoundsRects, SizeOf(l_PopupFormBoundsRects));
 try
  l_Width := 450;
  l_Height := Max(f_Form.Height, 100);
  l_PopupFormBoundsRects.rInited := False;
  l_Control := aReminder.PopupFormControl;
  if Supports(l_Control, IafwFormView, l_V) then
  try
   l_Height := l_V.CalculateHeightByWidth(l_Width, {aForce}True);
   l_PopupFormBoundsRects.rInited := l_Height <> 0;
   if not l_PopupFormBoundsRects.rInited then
    Exit;
   Inc(l_Height, 2);
   l_V.SetBackColor(cWarningMessageColor); // очень круто устанавливать цвет окна в процедуре подсчёта размеров формы
  finally
   l_V := nil;
  end else
   Exit;

  l_ImageHeight := f_Images.Height;
  l_ReminderRect := ReminderBounds(aReminder, True);
  TvtPopupForm.AdjustBalloonSize(vtTailLeft, Abs(f_Form.Font.Size), l_Width, l_Height, l_WidthNew, l_HeightNew);
  l_PopupFormBoundsRects.rV[vtTailLeft] := Rect(l_ReminderRect.Right - l_ReminderRect.Left,
                                                -((l_HeightNew - l_ImageHeight) div 2),
                                                l_ReminderRect.Right - l_ReminderRect.Left + l_WidthNew,
                                                -((l_HeightNew - l_ImageHeight) div 2) + l_HeightNew);

  TvtPopupForm.AdjustBalloonSize(vtTailRight, Abs(f_Form.Font.Size), l_Width, l_Height, l_WidthNew, l_HeightNew);
  l_PopupFormBoundsRects.rV[vtTailRight] := Rect(-l_WidthNew,
                                                 -((l_HeightNew - l_ImageHeight) div 2),
                                                 0,
                                                 -((l_HeightNew - l_ImageHeight) div 2) + l_HeightNew);

  TvtPopupForm.AdjustBalloonSize(vtTailTop, Abs(f_Form.Font.Size), l_Width, l_Height, l_WidthNew, l_HeightNew);
  l_PopupFormBoundsRects.rV[vtTailTop] := Rect(-((l_WidthNew - (l_ReminderRect.Right - l_ReminderRect.Left)) div 2),
                                               f_Form.Height,
                                               -((l_WidthNew - (l_ReminderRect.Right - l_ReminderRect.Left)) div 2) + l_WidthNew,
                                               f_Form.Height + l_HeightNew);

  TvtPopupForm.AdjustBalloonSize(vtTailBottom, Abs(f_Form.Font.Size), l_Width, l_Height, l_WidthNew, l_HeightNew);
  l_PopupFormBoundsRects.rV[vtTailBottom] := Rect(-((l_WidthNew - (l_ReminderRect.Right - l_ReminderRect.Left)) div 2),
                                                  -l_HeightNew,
                                                  -((l_WidthNew - (l_ReminderRect.Right - l_ReminderRect.Left)) div 2) + l_WidthNew,
                                                  0);
  l_PopupFormBoundsRects.rInited := True;
 finally
  aReminder.PopupFormBounds := l_PopupFormBoundsRects;
 end;
//#UC END# *53316A4601CB_532322D901A3_impl*
end;//TvgRemindersLine.CalcPopupFormBounds

procedure TvgRemindersLine.AdjustPopupFormPosition(aReminder: TvgReminder;
  aTailLocked: Boolean;
  aCanMoveLine: Boolean);
//#UC START# *5332CD6C02A4_532322D901A3_var*
  function BaloonShift(aBalloonRect, aDesktopRect: TRect; aOrigin: TPoint): TPoint;
  var
   l_ShiftX : Integer;
   l_ShiftY : Integer;
  begin
   OffsetRect(aBalloonRect, aOrigin.X, aOrigin.Y);
   l_ShiftX := Max(0, aBalloonRect.Right - aDesktopRect.Right);
   if (l_ShiftX = 0) then
    l_ShiftX := Min(0, aBalloonRect.Left - aDesktopRect.Left);
   l_ShiftY := Max(0, aBalloonRect.Bottom - aDesktopRect.Bottom);
   if (l_ShiftY = 0) then
    l_ShiftY := Min(0, aBalloonRect.Top - aDesktopRect.Top);
   Result := Point(l_ShiftX, l_ShiftY);
  end;

  function l_Measure(aVector: TPoint): Integer;
  begin
   Result := Abs(aVector.X) + Abs(aVector.Y);
  end;

var
 l_Origin: TPoint;
 l_DesktopRect: TRect;
 l_Bounds: TPopupFormBoundsRects;
 l_ShortestShift: TPoint;
 l_Shift: TPoint;
 l_TP: TvtTailPosition;
 l_ShortestShiftTP: TvtTailPosition;
//#UC END# *5332CD6C02A4_532322D901A3_var*
begin
//#UC START# *5332CD6C02A4_532322D901A3_impl*
 if not aReminder.PopupFormBounds.rInited then
  Exit;
 l_TP := aReminder.PopupForm.TailPosition;
 l_Bounds := aReminder.PopupFormBounds;
 l_Origin := f_Form.ClientOrigin;
 Inc(l_Origin.X, ReminderBounds(aReminder, True).Left);

 if not aTailLocked then
 begin
  l_DesktopRect := Screen.MonitorFromWindow(f_Form.Handle).WorkareaRect;
  l_ShortestShift := BaloonShift(l_Bounds.rV[vtTailLeft], l_DesktopRect, l_Origin);
  l_ShortestShiftTP := vtTailLeft;
  if (l_Measure(l_ShortestShift) <> 0) then
   for l_TP := Low(TvtTailPosition) to High(TvtTailPosition) do
   begin
    l_Shift := BaloonShift(l_Bounds.rV[l_TP], l_DesktopRect, l_Origin);
    if (l_Measure(l_ShortestShift) > l_Measure(l_Shift)) then
    begin
     l_ShortestShift := l_Shift;
     l_ShortestShiftTP := l_TP;
    end;//l_ShortestShift > l_Shift
    if l_Measure(l_ShortestShift) = 0 then
     Break;
   end;//for l_TP

  l_TP := l_ShortestShiftTP;
  if aCanMoveLine then
  begin
   OffsetLine(-l_ShortestShift.X, -l_ShortestShift.Y);
   OffsetRect(l_Bounds.rV[l_TP], -l_ShortestShift.X, -l_ShortestShift.Y);
  end;
 end;
 OffsetRect(l_Bounds.rV[l_TP], l_Origin.X, l_Origin.Y);
 aReminder.PopupForm.TailPosition := l_TP;
 aReminder.PopupForm.BoundsRect := l_Bounds.rV[l_TP];
 if aCanMoveLine then
  AdjustPopupFormPosition(aReminder, True, False)
 else
 if aReminder.PopupForm.Visible then
  aReminder.PopupForm.BringToFront;
//#UC END# *5332CD6C02A4_532322D901A3_impl*
end;//TvgRemindersLine.AdjustPopupFormPosition

function TvgRemindersLine.PrevVisibleReminder(aIndex: Integer): TvgReminder;
//#UC START# *53301C100054_532322D901A3_var*
//#UC END# *53301C100054_532322D901A3_var*
begin
//#UC START# *53301C100054_532322D901A3_impl*
 Result := nil;
 while aIndex > 0 do
 begin
  Dec(aIndex);
  if f_RemindersList[aIndex].Visible then
  begin
   Result := f_RemindersList[aIndex];
   Break;
  end;
 end;
//#UC END# *53301C100054_532322D901A3_impl*
end;//TvgRemindersLine.PrevVisibleReminder

procedure TvgRemindersLine.ReminderMouseDown(Sender: TvgReminder;
  Button: TMouseButton);
//#UC START# *533587700028_532322D901A3_var*
var
 l_Process: DWORD;
//#UC END# *533587700028_532322D901A3_var*
begin
//#UC START# *533587700028_532322D901A3_impl*
 GetWindowThreadProcessId(GetForegroundWindow, l_Process);
 if (GetCurrentProcessId <> l_Process) then
  SetForegroundWindow(MainFormHandle);
 if Button = mbLeft then
 begin
  f_OldLeft := f_Form.Left;
  f_OldTop := f_Form.Top;
  f_Form.Scene.BeginDrag;
 end;
//#UC END# *533587700028_532322D901A3_impl*
end;//TvgRemindersLine.ReminderMouseDown

procedure TvgRemindersLine.ReminderMouseUp(Sender: TvgReminder;
  Button: TMouseButton);
//#UC START# *5335879E0084_532322D901A3_var*
var
 I: Integer;
//#UC END# *5335879E0084_532322D901A3_var*
begin
//#UC START# *5335879E0084_532322D901A3_impl*
 case Button of
  mbLeft:
   begin
    FixPosition;
    SetActiveWindow(MainFormHandle);
    AdjustPopupFormPosition(True, False);
   end;
  mbRight:
   begin
    f_InMenu := True;
    Sender.PopupMenu.PopupComponent := Sender;
    with Mouse.CursorPos do
     Sender.PopupMenu.Popup(X, Y);
   end;
 end;
//#UC END# *5335879E0084_532322D901A3_impl*
end;//TvgRemindersLine.ReminderMouseUp

procedure TvgRemindersLine.BringPopupFormToFront;
//#UC START# *5335ADA00135_532322D901A3_var*
var
 I: Integer;
//#UC END# *5335ADA00135_532322D901A3_var*
begin
//#UC START# *5335ADA00135_532322D901A3_impl*
 for I := 0 to Count - 1 do
  if Assigned(Reminder[I].PopupForm) then
   if Reminder[I].PopupForm.Visible then
   begin
    Reminder[I].PopupForm.BringToFront;
    Break;
   end;
//#UC END# *5335ADA00135_532322D901A3_impl*
end;//TvgRemindersLine.BringPopupFormToFront

procedure TvgRemindersLine.ReminderClick(aReminder: TvgReminder);
//#UC START# *5335BB34024D_532322D901A3_var*
var
 l_Handled: Boolean;
//#UC END# *5335BB34024D_532322D901A3_var*
begin
//#UC START# *5335BB34024D_532322D901A3_impl*
 if not IsInMove then
 begin
  aReminder.DoClick(l_Handled);
  if not l_Handled then
   if Assigned(aReminder.PopupForm) then
   begin
    if not aReminder.PopupFormBounds.rInited then
     CalcPopupFormBounds(aReminder);
    AdjustPopupFormPosition(aReminder, False, True);
    if not aReminder.PopupForm.Visible then
    begin
     TvgRemindersLineManager.ClosePopupForms;
     aReminder.PopupForm.Show;
     aReminder.DoPopupFormVisibleChanged(True);
     SetActiveWindow(MainFormHandle);
    end;
   end;
 end;
//#UC END# *5335BB34024D_532322D901A3_impl*
end;//TvgRemindersLine.ReminderClick

function TvgRemindersLine.MainFormHandle: HWND;
//#UC START# *533AE54B0126_532322D901A3_var*
var
 l_Container: IafwMainFormContainer;
 l_Form: TWinControl;
//#UC END# *533AE54B0126_532322D901A3_var*
begin
//#UC START# *533AE54B0126_532322D901A3_impl*
 Result := 0;
 if Assigned(f_MainForm) and Assigned(f_MainForm.Parent) then
  f_MainForm := nil; // нам нужна самая верхняя форма
 if not Assigned(f_MainForm) then
 begin
  f_MainForm := f_Parent;
  while Assigned(f_MainForm.Parent) do
   f_MainForm := f_MainForm.Parent;
 end;
 if Assigned(f_MainForm) then
 begin
  l_Form := f_MainForm;
  if not (csDestroying in l_Form.ComponentState) then
   if l_Form.HandleAllocated then
    Result := l_Form.Handle;
 end;
//#UC END# *533AE54B0126_532322D901A3_impl*
end;//TvgRemindersLine.MainFormHandle

function TvgRemindersLine.VisiblePopupForm: TvtPopupFormModelPart;
//#UC START# *533BEC540172_532322D901A3_var*
var
 I: Integer;
//#UC END# *533BEC540172_532322D901A3_var*
begin
//#UC START# *533BEC540172_532322D901A3_impl*
 Result := nil;
 for I := 0 to Count - 1 do
  if Assigned(Reminder[I].PopupForm) and Reminder[I].PopupForm.Visible then
  begin
   Result := Reminder[I].PopupForm;
   Break;
  end;
//#UC END# *533BEC540172_532322D901A3_impl*
end;//TvgRemindersLine.VisiblePopupForm

procedure TvgRemindersLine.SendSyncPosition;
//#UC START# *533E9BF303B3_532322D901A3_var*
//#UC END# *533E9BF303B3_532322D901A3_var*
begin
//#UC START# *533E9BF303B3_532322D901A3_impl*
 if Assigned(f_Form) and f_Form.HandleAllocated and not f_SyncPosSent then
 begin
  f_SyncPosSent := True;
  PostMessage(f_Form.Handle, WM_SYNCPOS, 0, 0);
 end;
//#UC END# *533E9BF303B3_532322D901A3_impl*
end;//TvgRemindersLine.SendSyncPosition

procedure TvgRemindersLine.RestoreWindowTimerProc(Sender: TObject);
//#UC START# *53E38F25001A_532322D901A3_var*
//#UC END# *53E38F25001A_532322D901A3_var*
begin
//#UC START# *53E38F25001A_532322D901A3_impl*
 f_Form.Visible := f_Visible;
 CheckZOrder;
 f_RestoreWindowTimer.Enabled := False;
//#UC END# *53E38F25001A_532322D901A3_impl*
end;//TvgRemindersLine.RestoreWindowTimerProc

procedure TvgRemindersLine.AdjustPopupFormPosition(aTailLocked: Boolean;
  aCanMoveLine: Boolean);
//#UC START# *5459E092015E_532322D901A3_var*
var
 I: Integer;
//#UC END# *5459E092015E_532322D901A3_var*
begin
//#UC START# *5459E092015E_532322D901A3_impl*
 for I := 0 to Count - 1 do
  if Assigned(Reminder[I].PopupForm) then
   if Reminder[I].PopupForm.Visible then
    AdjustPopupFormPosition(Reminder[I], aTailLocked, aCanMoveLine);
//#UC END# *5459E092015E_532322D901A3_impl*
end;//TvgRemindersLine.AdjustPopupFormPosition

procedure TvgRemindersLine.BeginUpdate;
//#UC START# *533026850138_532322D901A3_var*
//#UC END# *533026850138_532322D901A3_var*
begin
//#UC START# *533026850138_532322D901A3_impl*
 Inc(f_UpdateCount);
//#UC END# *533026850138_532322D901A3_impl*
end;//TvgRemindersLine.BeginUpdate

procedure TvgRemindersLine.EndUpdate;
//#UC START# *5330268C039A_532322D901A3_var*
//#UC END# *5330268C039A_532322D901A3_var*
begin
//#UC START# *5330268C039A_532322D901A3_impl*
 Assert(f_UpdateCount > 0);
 Dec(f_UpdateCount);
 if f_NeedCallChanged then
  DoChanged;
//#UC END# *5330268C039A_532322D901A3_impl*
end;//TvgRemindersLine.EndUpdate

procedure TvgRemindersLine.ClosePopupForm;
//#UC START# *5335AD880107_532322D901A3_var*
var
 I: Integer;
//#UC END# *5335AD880107_532322D901A3_var*
begin
//#UC START# *5335AD880107_532322D901A3_impl*
 for I := 0 to Count - 1 do
  if Assigned(Reminder[I].PopupForm) and (not (fsShowing in Reminder[I].PopupForm.FormState)) then
   Reminder[I].PopupForm.Visible := False;
//#UC END# *5335AD880107_532322D901A3_impl*
end;//TvgRemindersLine.ClosePopupForm

procedure TvgRemindersLine.BoundsChanged(aLeft: Integer;
  aTop: Integer;
  aWidth: Integer;
  aHeight: Integer);
//#UC START# *533D31F800DD_532322D901A3_var*
//#UC END# *533D31F800DD_532322D901A3_var*
begin
//#UC START# *533D31F800DD_532322D901A3_impl*
//#UC END# *533D31F800DD_532322D901A3_impl*
end;//TvgRemindersLine.BoundsChanged

procedure TvgRemindersLine.OffsetLine(aShiftX: Integer;
  aShiftY: Integer);
//#UC START# *53590889034B_532322D901A3_var*
//#UC END# *53590889034B_532322D901A3_var*
begin
//#UC START# *53590889034B_532322D901A3_impl*
 with f_Form do
  SetBounds(Left + aShiftX, Top + aShiftY, Width, Height);
 FixPosition;
//#UC END# *53590889034B_532322D901A3_impl*
end;//TvgRemindersLine.OffsetLine

procedure TvgRemindersLine.FixPosition;
//#UC START# *535A276E0057_532322D901A3_var*
var
 l_TopLeft: TPoint;
//#UC END# *535A276E0057_532322D901A3_var*
begin
//#UC START# *535A276E0057_532322D901A3_impl*
 l_TopLeft := f_Parent.ScreenToClient(Point(f_Form.Left, f_Form.Top));
 f_HorzPos := l_TopLeft.X / (f_Parent.ClientWidth - f_Form.Width);
 f_VertPos := l_TopLeft.Y / (f_Parent.ClientHeight - f_Form.Height);
//#UC END# *535A276E0057_532322D901A3_impl*
end;//TvgRemindersLine.FixPosition

procedure TvgRemindersLine.CheckZOrder;
//#UC START# *5368D3FD03CD_532322D901A3_var*
var
 l_NextWindow: THandle;
//#UC END# *5368D3FD03CD_532322D901A3_var*
begin
//#UC START# *5368D3FD03CD_532322D901A3_impl*
 if f_Form.Visible then
 begin
  l_NextWindow := GetNextWindow(MainFormHandle, GW_HWNDPREV);
  if IsWindow(l_NextWindow) then
   SetWindowPos(f_Form.Handle, l_NextWindow, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING)
  else
   SetWindowPos(f_Form.Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOOWNERZORDER or SWP_NOSENDCHANGING);
 end;
//#UC END# *5368D3FD03CD_532322D901A3_impl*
end;//TvgRemindersLine.CheckZOrder

procedure TvgRemindersLine.LockActivateProcessing;
//#UC START# *54100F460175_532322D901A3_var*
//#UC END# *54100F460175_532322D901A3_var*
begin
//#UC START# *54100F460175_532322D901A3_impl*
 Inc(f_ActivateProcessingLockCount);
 if (f_Form <> nil) then
  f_Form.LockActivateProcessing;
//#UC END# *54100F460175_532322D901A3_impl*
end;//TvgRemindersLine.LockActivateProcessing

procedure TvgRemindersLine.UnlockActivateProcessing;
//#UC START# *54100F6E012F_532322D901A3_var*
//#UC END# *54100F6E012F_532322D901A3_var*
begin
//#UC START# *54100F6E012F_532322D901A3_impl*
 Dec(f_ActivateProcessingLockCount);
 if (f_Form <> nil) then
  f_Form.UnlockActivateProcessing;
 if (f_ActivateProcessingLockCount = 0) then
  CheckZOrder;
//#UC END# *54100F6E012F_532322D901A3_impl*
end;//TvgRemindersLine.UnlockActivateProcessing
// start class TvgReminder

procedure TvgReminder.FlashTimer(Sender: TObject);
//#UC START# *53297F2C0176_532973740186_var*
//#UC END# *53297F2C0176_532973740186_var*
begin
//#UC START# *53297F2C0176_532973740186_impl*
 f_IsFlash := not f_IsFlash;
 if f_IsFlash
  then f_vgImage.Opacity := c_FlashingReminderOpacity
  else f_vgImage.Opacity := c_DefaultReminderOpacity;
//#UC END# *53297F2C0176_532973740186_impl*
end;//TvgReminder.FlashTimer

procedure TvgReminder.DoChange;
//#UC START# *532ADFDF03BF_532973740186_var*
//#UC END# *532ADFDF03BF_532973740186_var*
begin
//#UC START# *532ADFDF03BF_532973740186_impl*
 if Assigned(Owner) then
  (Owner as TvgRemindersLine).DoChanged;
//#UC END# *532ADFDF03BF_532973740186_impl*
end;//TvgReminder.DoChange

procedure TvgReminder.ImageClick(Sender: TObject);
//#UC START# *532B2EA001B6_532973740186_var*
//#UC END# *532B2EA001B6_532973740186_var*
begin
//#UC START# *532B2EA001B6_532973740186_impl*
 Click;
//#UC END# *532B2EA001B6_532973740186_impl*
end;//TvgReminder.ImageClick

procedure TvgReminder.MouseDown(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X: Single;
  Y: Single);
//#UC START# *532C2703003A_532973740186_var*
//#UC END# *532C2703003A_532973740186_var*
begin
//#UC START# *532C2703003A_532973740186_impl*
 (Owner as TvgRemindersLine).ReminderMouseDown(Self, Button);
//#UC END# *532C2703003A_532973740186_impl*
end;//TvgReminder.MouseDown

procedure TvgReminder.MouseUp(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X: Single;
  Y: Single);
//#UC START# *532C271300BC_532973740186_var*
//#UC END# *532C271300BC_532973740186_var*
begin
//#UC START# *532C271300BC_532973740186_impl*
 (Owner as TvgRemindersLine).ReminderMouseUp(Self, Button);
//#UC END# *532C271300BC_532973740186_impl*
end;//TvgReminder.MouseUp

procedure TvgReminder.AfterBaloonHidden(Sender: TObject);
//#UC START# *533ACE04018B_532973740186_var*
//#UC END# *533ACE04018B_532973740186_var*
begin
//#UC START# *533ACE04018B_532973740186_impl*
 DoPopupFormVisibleChanged(False);
//#UC END# *533ACE04018B_532973740186_impl*
end;//TvgReminder.AfterBaloonHidden

procedure TvgReminder.UpdateTextRectColor;
//#UC START# *533D91EA013F_532973740186_var*
var
 I, J: Integer;
 RR, GG, BB: Extended;
//#UC END# *533D91EA013F_532973740186_var*
begin
//#UC START# *533D91EA013F_532973740186_impl*
 if f_ImageIndex < 0 then
  Exit;
 Assert((f_vgImage.Bitmap.Width > 0) and (f_vgImage.Bitmap.Height > 0));
 if f_vgTextRect.Visible then
  if (f_TextRectColor = '') then
   with f_vgImage.Bitmap do
   begin
    RR := 0;
    GG := 0;
    BB := 0;
    for I := 0 to Width - 1 do
    for J := 0 to Height - 1 do
     with TvgColorRec(Pixels[I, J]) do
     begin
      RR := RR + R;
      GG := GG + G;
      BB := BB + B;
     end;
    RR := RR / (Width * Height);
    GG := GG / (Width * Height);
    BB := BB / (Width * Height);
    f_TextRectColor := vgColorToStr(vgColor(Round(RR), Round(GG), Round(BB)));
   end;

 if (f_TextRectColor <> '') then
  f_vgTextRect.Fill.Color := f_TextRectColor;
//#UC END# *533D91EA013F_532973740186_impl*
end;//TvgReminder.UpdateTextRectColor

procedure TvgReminder.UpdateControls;
//#UC START# *53306F3F0177_532973740186_var*
//#UC END# *53306F3F0177_532973740186_var*
begin
//#UC START# *53306F3F0177_532973740186_impl*
 with f_vgText do
  if Assigned(Canvas) then
  begin
   TvgCanvas(Canvas).Font.Assign(Font);
   Height := TvgCanvas(Canvas).TextHeight(Text);
   AdjustSize;
   f_vgTextRect.Width := Width + c_ReminderTextHIndent * 2;
   f_vgTextRect.Height := Height + c_ReminderTextVIndent * 2;
  end;
 f_vgTextRect.Visible := f_Visible and not l3IsNil(f_Caption);
 UpdateTextRectColor;
//#UC END# *53306F3F0177_532973740186_impl*
end;//TvgReminder.UpdateControls

procedure TvgReminder.DoClick(out aHandled: Boolean);
//#UC START# *533949D40354_532973740186_var*
//#UC END# *533949D40354_532973740186_var*
begin
//#UC START# *533949D40354_532973740186_impl*
 aHandled := False;
//#UC END# *533949D40354_532973740186_impl*
end;//TvgReminder.DoClick

procedure TvgReminder.UpdateAction;
//#UC START# *533AA4E9016A_532973740186_var*
//#UC END# *533AA4E9016A_532973740186_var*
begin
//#UC START# *533AA4E9016A_532973740186_impl*
//#UC END# *533AA4E9016A_532973740186_impl*
end;//TvgReminder.UpdateAction

procedure TvgReminder.DoPopupFormVisibleChanged(aVisible: Boolean);
//#UC START# *533AC93C039F_532973740186_var*
//#UC END# *533AC93C039F_532973740186_var*
begin
//#UC START# *533AC93C039F_532973740186_impl*
 if aVisible then 
 begin
  if Assigned(f_OnPopupFormShow) then
   f_OnPopupFormShow(Self);
 end else
 if Assigned(f_OnPopupFormHide) then
  f_OnPopupFormHide(Self);
//#UC END# *533AC93C039F_532973740186_impl*
end;//TvgReminder.DoPopupFormVisibleChanged

procedure TvgReminder.DoVisibleChanged(aVisible: Boolean);
//#UC START# *533AC95101DF_532973740186_var*
//#UC END# *533AC95101DF_532973740186_var*
begin
//#UC START# *533AC95101DF_532973740186_impl*
 if aVisible then
 begin
  if Assigned(f_OnShow) then
   f_OnShow(Self);
 end else
 if Assigned(f_OnHide) then
  f_OnHide(Self);
//#UC END# *533AC95101DF_532973740186_impl*
end;//TvgReminder.DoVisibleChanged

procedure TvgReminder.Click;
//#UC START# *534FD32400F7_532973740186_var*
//#UC END# *534FD32400F7_532973740186_var*
begin
//#UC START# *534FD32400F7_532973740186_impl*
 (Owner as TvgRemindersLine).ReminderClick(Self);
//#UC END# *534FD32400F7_532973740186_impl*
end;//TvgReminder.Click

procedure TvgReminder.UpdateImage;
//#UC START# *535A344900DA_532973740186_var*
var
 l_Images: IvtFlashImageList;
 l_Graph: TBitmap;
 l_Bitmap: TvgBitmap;
 l_Stream: Tl3MemoryStream;
//#UC END# *535A344900DA_532973740186_var*
begin
//#UC START# *535A344900DA_532973740186_impl*
 if not Assigned((Owner as TvgRemindersLine).Images) then
  Exit;
 if f_ImageIndex < 0 then
  Exit;
 if Supports((Owner as TvgRemindersLine).Images, IvtFlashImageList, l_Images) then
 begin
  l_Stream := Tl3MemoryStream.Create;
  try
   l_Images.SaveImageToStream(l_Stream, f_ImageIndex, bpp24);
   l_Stream.Position := 0;
   l_Bitmap := TvgBitmap.Create(1, 1);
   try
    l_Bitmap.LoadFromStream(l_Stream);
    f_vgImage.Bitmap := l_Bitmap;
   finally
    FreeAndNil(l_Bitmap);
   end;
  finally
   FreeAndNil(l_Stream);
  end;
 end else
  Assert(False, 'По-другому не умеем.');
 UpdateControls;
//#UC END# *535A344900DA_532973740186_impl*
end;//TvgReminder.UpdateImage

procedure TvgReminder.ReleaseResources;
//#UC START# *538F0D4F00CD_532973740186_var*
//#UC END# *538F0D4F00CD_532973740186_var*
begin
//#UC START# *538F0D4F00CD_532973740186_impl*
 if Assigned(f_PopupForm) then
 begin
  if f_PopupForm.Panel.ControlCount > 0 then
   with f_PopupForm.Panel.Controls[0] do
   begin
    Visible := False;
    Parent := nil;
   end;
  f_PopupFormControl := nil;
 end;
 FreeAndNil(f_PopupForm);
 FreeAndNil(f_FlashTimer);
 FreeAndNil(f_vgText);
 FreeAndNil(f_vgTextRect);
 FreeAndNil(f_vgImage);
//#UC END# *538F0D4F00CD_532973740186_impl*
end;//TvgReminder.ReleaseResources

procedure TvgReminder.pm_SetImageIndex(aValue: TImageIndex);
//#UC START# *53297AA10243_532973740186set_var*
//#UC END# *53297AA10243_532973740186set_var*
begin
//#UC START# *53297AA10243_532973740186set_impl*
 if f_ImageIndex <> aValue then
 begin
  f_ImageIndex := aValue;
  UpdateImage;
  DoChange;
  f_TextRectColor := '';
 end;
//#UC END# *53297AA10243_532973740186set_impl*
end;//TvgReminder.pm_SetImageIndex

procedure TvgReminder.pm_SetCaption(const aValue: Il3CString);
//#UC START# *5329FC41036F_532973740186set_var*
//#UC END# *5329FC41036F_532973740186set_var*
begin
//#UC START# *5329FC41036F_532973740186set_impl*
 if not l3Same(f_Caption, aValue) then
 begin
  f_Caption := aValue;
  f_vgText.Text := l3WideString(aValue);
  UpdateControls;
  DoChange;
 end;
//#UC END# *5329FC41036F_532973740186set_impl*
end;//TvgReminder.pm_SetCaption

procedure TvgReminder.pm_SetHint(const aValue: Il3CString);
//#UC START# *5329FC4800FE_532973740186set_var*
//#UC END# *5329FC4800FE_532973740186set_var*
begin
//#UC START# *5329FC4800FE_532973740186set_impl*
 if not l3Same(f_Hint, aValue) then
 begin
  f_Hint := aValue;
  f_vgImage.Hint := l3WideString(f_Hint);
  ShowHint := True;
 end;
//#UC END# *5329FC4800FE_532973740186set_impl*
end;//TvgReminder.pm_SetHint

procedure TvgReminder.pm_SetVisible(aValue: Boolean);
//#UC START# *5330725303AD_532973740186set_var*
//#UC END# *5330725303AD_532973740186set_var*
begin
//#UC START# *5330725303AD_532973740186set_impl*
 if f_Visible <> aValue then
 begin
  f_Visible := aValue;
  f_vgImage.Visible := f_Visible;
  UpdateControls;
  DoChange;
  DoVisibleChanged(f_Visible);
  if not f_Visible then
   if Assigned(f_PopupForm) then
    f_PopupForm.Visible := False;
 end;
//#UC END# *5330725303AD_532973740186set_impl*
end;//TvgReminder.pm_SetVisible

procedure TvgReminder.pm_SetPopupFormControl(aValue: TControl);
//#UC START# *53343BDE0169_532973740186set_var*
//#UC END# *53343BDE0169_532973740186set_var*
begin
//#UC START# *53343BDE0169_532973740186set_impl*
 f_PopupFormControl := aValue;
 if not Assigned(f_PopupForm) then
 begin
  f_PopupForm := TvtPopupFormModelPart.CreateNew(Self);
  f_PopupForm.AfterBaloonHidden := AfterBaloonHidden;
 end;
 //f_PopupFormControl.ManualDock(f_PopupForm.Panel);
 if f_PopupFormControl is TCustomForm then
  TCustomForm(f_PopupFormControl).BorderStyle := bsNone;
 f_PopupFormControl.Parent := f_PopupForm.Panel;
 f_PopupFormControl.Align := alClient;
 if (f_PopupFormControl is TCustomForm) then
  TCustomForm(f_PopupFormControl).Visible := True;
//#UC END# *53343BDE0169_532973740186set_impl*
end;//TvgReminder.pm_SetPopupFormControl

function TvgReminder.pm_GetFlashInterval: Integer;
//#UC START# *5334668302F1_532973740186get_var*
//#UC END# *5334668302F1_532973740186get_var*
begin
//#UC START# *5334668302F1_532973740186get_impl*
 Result := f_FlashTimer.Interval;
//#UC END# *5334668302F1_532973740186get_impl*
end;//TvgReminder.pm_GetFlashInterval

procedure TvgReminder.pm_SetFlashInterval(aValue: Integer);
//#UC START# *5334668302F1_532973740186set_var*
//#UC END# *5334668302F1_532973740186set_var*
begin
//#UC START# *5334668302F1_532973740186set_impl*
 f_FlashTimer.Interval := aValue;
//#UC END# *5334668302F1_532973740186set_impl*
end;//TvgReminder.pm_SetFlashInterval

function TvgReminder.pm_GetFlash: Boolean;
//#UC START# *53358CCD035C_532973740186get_var*
//#UC END# *53358CCD035C_532973740186get_var*
begin
//#UC START# *53358CCD035C_532973740186get_impl*
 Result := f_FlashTimer.Enabled;
//#UC END# *53358CCD035C_532973740186get_impl*
end;//TvgReminder.pm_GetFlash

procedure TvgReminder.pm_SetFlash(aValue: Boolean);
//#UC START# *53358CCD035C_532973740186set_var*
//#UC END# *53358CCD035C_532973740186set_var*
begin
//#UC START# *53358CCD035C_532973740186set_impl*
 f_FlashTimer.Enabled := aValue;
//#UC END# *53358CCD035C_532973740186set_impl*
end;//TvgReminder.pm_SetFlash

function TvgReminder.pm_GetShowHint: Boolean;
//#UC START# *5369E12D02A2_532973740186get_var*
//#UC END# *5369E12D02A2_532973740186get_var*
begin
//#UC START# *5369E12D02A2_532973740186get_impl*
 Result := f_vgImage.ShowHint;
//#UC END# *5369E12D02A2_532973740186get_impl*
end;//TvgReminder.pm_GetShowHint

procedure TvgReminder.pm_SetShowHint(aValue: Boolean);
//#UC START# *5369E12D02A2_532973740186set_var*
//#UC END# *5369E12D02A2_532973740186set_var*
begin
//#UC START# *5369E12D02A2_532973740186set_impl*
 f_vgImage.ShowHint := aValue;
//#UC END# *5369E12D02A2_532973740186set_impl*
end;//TvgReminder.pm_SetShowHint

procedure TvgReminder.pm_SetSortIndex(aValue: Integer);
//#UC START# *536A136401F9_532973740186set_var*
//#UC END# *536A136401F9_532973740186set_var*
begin
//#UC START# *536A136401F9_532973740186set_impl*
 f_SortIndex := aValue;
 if (Owner as TvgRemindersLine).Sorted then
  DoChange;
//#UC END# *536A136401F9_532973740186set_impl*
end;//TvgReminder.pm_SetSortIndex

{$If not defined(NoVCM)}
procedure TvgReminder.DataSourceChanged(aControl: TControl);
//#UC START# *4D905A2A00D6_532973740186_var*
//#UC END# *4D905A2A00D6_532973740186_var*
begin
//#UC START# *4D905A2A00D6_532973740186_impl*
 PopupForm.Visible := False;
 f_PopupFormBounds.rInited := False;
//#UC END# *4D905A2A00D6_532973740186_impl*
end;//TvgReminder.DataSourceChanged
{$IfEnd} //not NoVCM

procedure TvgReminder.Cleanup;
//#UC START# *479731C50290_532973740186_var*
//#UC END# *479731C50290_532973740186_var*
begin
//#UC START# *479731C50290_532973740186_impl*
 f_Hint := nil;
 f_Caption := nil;
 ReleaseResources;
 inherited;
//#UC END# *479731C50290_532973740186_impl*
end;//TvgReminder.Cleanup

constructor TvgReminder.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_532973740186_var*
//#UC END# *47D1602000C6_532973740186_var*
begin
//#UC START# *47D1602000C6_532973740186_impl*
 Assert(aOwner is TvgRemindersLine);
 inherited;
 f_SortIndex := 0;
 f_ImageIndex := -1;
 f_TextRectColor := '';
 f_Visible := True;
 f_IsFlash := False;
 f_FlashTimer := TTimer.Create((aOwner as TvgRemindersLine).Form);
 l3FillChar(f_PopupFormBounds, SizeOf(f_PopupFormBounds));
 with f_FlashTimer do
 begin
  Enabled := False;
  Interval := c_FlashInterval;
  OnTimer := FlashTimer;
 end;
 f_vgImage := TvgImage.Create(Self);
 with f_vgImage do
 begin
  Parent := (aOwner as TvgRemindersLine).Form.Background;
  OnClick := ImageClick;
  OnMouseDown := MouseDown;
  OnMouseUp := MouseUp;
  Opacity := c_DefaultReminderOpacity;
 end;
 f_vgTextRect := TvgBlurRectangle.Create(Self);
 with f_vgTextRect do
 begin
  Parent := (aOwner as TvgRemindersLine).Form.Background;
  HitTest := True;
  Fill.Color := '#FF3333AA';
  Stroke.Color := '#FF000099';
  StrokeThickness := 1;
  OnMouseDown := MouseDown;
  OnMouseUp := MouseUp;
  xRadius := c_ReminderTextHIndent;
  yRadius := c_ReminderTextVIndent;
  CornerType := vgCornerRound;
  //Opacity := c_DefaultReminderOpacity;
 end;
 f_vgText := TvgText.Create(Self);
 with f_vgText do
 begin
  Parent := f_vgTextRect;
  Position.X := c_ReminderTextHIndent;
  Position.Y := c_ReminderTextVIndent;
  AutoSize := True;
  Font.Size := 11;
  Font.Style := vgFontBold;
  Fill.Color := '#FFFFFFFF';
  WordWrap := False;
  HitTest := False;
 end;
 TvgRemindersLine(aOwner).f_RemindersList.Add(Self);
//#UC END# *47D1602000C6_532973740186_impl*
end;//TvgReminder.Create

procedure TvgReminder.ClearFields;
 {-}
begin
 {$If not defined(NoVGScene)}
 Caption := nil;
 {$IfEnd} //not NoVGScene
 {$If not defined(NoVGScene)}
 Hint := nil;
 {$IfEnd} //not NoVGScene
 Finalize(f_PopupFormBounds);
 inherited;
end;//TvgReminder.ClearFields
// start class TvgRemindersList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5329742E00C8_var*
//#UC END# *47B2C42A0163_5329742E00C8_var*
begin
//#UC START# *47B2C42A0163_5329742E00C8_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5329742E00C8_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5329742E00C8_var*
//#UC END# *47B99D4503A2_5329742E00C8_var*
begin
//#UC START# *47B99D4503A2_5329742E00C8_impl*
 Result := CI.rA.SortIndex - CI.rB.SortIndex;
//#UC END# *47B99D4503A2_5329742E00C8_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgRemindersList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class TvgRemindersLine

procedure TvgRemindersLine.pm_SetParent(aValue: TWinControl);
//#UC START# *532888BC0156_532322D901A3set_var*
//#UC END# *532888BC0156_532322D901A3set_var*
begin
//#UC START# *532888BC0156_532322D901A3set_impl*
 f_Parent := aValue;
 f_Form.ParentControl := f_Parent;
//#UC END# *532888BC0156_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetParent

procedure TvgRemindersLine.pm_SetHorzPos(aValue: single);
//#UC START# *532B391602B6_532322D901A3set_var*
//#UC END# *532B391602B6_532322D901A3set_var*
begin
//#UC START# *532B391602B6_532322D901A3set_impl*
 f_HorzPos := aValue;
 SyncPosition;
//#UC END# *532B391602B6_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetHorzPos

procedure TvgRemindersLine.pm_SetVertPos(aValue: single);
//#UC START# *532B391F02EB_532322D901A3set_var*
//#UC END# *532B391F02EB_532322D901A3set_var*
begin
//#UC START# *532B391F02EB_532322D901A3set_impl*
 f_VertPos := aValue;
 SyncPosition;
//#UC END# *532B391F02EB_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetVertPos

function TvgRemindersLine.pm_GetCount: Integer;
//#UC START# *5332A94303C2_532322D901A3get_var*
//#UC END# *5332A94303C2_532322D901A3get_var*
begin
//#UC START# *5332A94303C2_532322D901A3get_impl*
 if Assigned(f_RemindersList) then
  Result := f_RemindersList.Count
 else
  Result := 0;
//#UC END# *5332A94303C2_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetCount

function TvgRemindersLine.pm_GetVisible: Boolean;
//#UC START# *5332A9A1005A_532322D901A3get_var*
//#UC END# *5332A9A1005A_532322D901A3get_var*
begin
//#UC START# *5332A9A1005A_532322D901A3get_impl*
 Result := f_Visible;
//#UC END# *5332A9A1005A_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetVisible

procedure TvgRemindersLine.pm_SetVisible(aValue: Boolean);
//#UC START# *5332A9A1005A_532322D901A3set_var*
//#UC END# *5332A9A1005A_532322D901A3set_var*
begin
//#UC START# *5332A9A1005A_532322D901A3set_impl*
 f_Visible := aValue;
 if Assigned(f_Form) then
  if f_Form.Visible <> f_Visible then
   f_Form.Visible := f_Visible;
 if not f_Visible then
  ClosePopupForm
 else
 begin
  CheckZOrder;
  SyncPosition;
  FixPosition;
 end;
//#UC END# *5332A9A1005A_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetVisible

procedure TvgRemindersLine.pm_SetImages(aValue: TCustomImageList);
//#UC START# *5332A9BF030B_532322D901A3set_var*
var
 I: Integer;
//#UC END# *5332A9BF030B_532322D901A3set_var*
begin
//#UC START# *5332A9BF030B_532322D901A3set_impl*
 f_Images := aValue;
 for I := 0 to Count - 1 do
 begin
  Reminder[I].f_TextRectColor := '';
  Reminder[I].UpdateImage;
 end;
 DoChanged;
//#UC END# *5332A9BF030B_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetImages

function TvgRemindersLine.pm_GetReminder(aIndex: Integer): TvgReminder;
//#UC START# *5332A9FC01F0_532322D901A3get_var*
//#UC END# *5332A9FC01F0_532322D901A3get_var*
begin
//#UC START# *5332A9FC01F0_532322D901A3get_impl*
 Result := f_RemindersList[aIndex];
//#UC END# *5332A9FC01F0_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetReminder

function TvgRemindersLine.pm_GetLeft: Integer;
//#UC START# *534FAF870137_532322D901A3get_var*
var
 l_TopLeft: TPoint;
//#UC END# *534FAF870137_532322D901A3get_var*
begin
//#UC START# *534FAF870137_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Assert(Assigned(f_Parent));
 l_TopLeft := f_Parent.ClientToScreen(Point(0, 0));
 Result := f_Form.Left - l_TopLeft.X;
//#UC END# *534FAF870137_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetLeft

function TvgRemindersLine.pm_GetTop: Integer;
//#UC START# *534FAF9703B0_532322D901A3get_var*
var
 l_TopLeft: TPoint;
//#UC END# *534FAF9703B0_532322D901A3get_var*
begin
//#UC START# *534FAF9703B0_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Assert(Assigned(f_Parent));
 l_TopLeft := f_Parent.ClientToScreen(Point(0, 0));
 Result := f_Form.Top - l_TopLeft.Y;
//#UC END# *534FAF9703B0_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetTop

function TvgRemindersLine.pm_GetAbsLeft: Integer;
//#UC START# *534FAFA6036F_532322D901A3get_var*
//#UC END# *534FAFA6036F_532322D901A3get_var*
begin
//#UC START# *534FAFA6036F_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Result := f_Form.Left;
//#UC END# *534FAFA6036F_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetAbsLeft

function TvgRemindersLine.pm_GetAbsTop: Integer;
//#UC START# *534FAFB80059_532322D901A3get_var*
//#UC END# *534FAFB80059_532322D901A3get_var*
begin
//#UC START# *534FAFB80059_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Result := f_Form.Top;
//#UC END# *534FAFB80059_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetAbsTop

function TvgRemindersLine.pm_GetWidth: Integer;
//#UC START# *534FB02800E7_532322D901A3get_var*
//#UC END# *534FB02800E7_532322D901A3get_var*
begin
//#UC START# *534FB02800E7_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Result := f_Form.Width;
//#UC END# *534FB02800E7_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetWidth

function TvgRemindersLine.pm_GetHeight: Integer;
//#UC START# *534FB03B0379_532322D901A3get_var*
//#UC END# *534FB03B0379_532322D901A3get_var*
begin
//#UC START# *534FB03B0379_532322D901A3get_impl*
 Assert(Assigned(f_Form));
 Result := f_Form.Height;
//#UC END# *534FB03B0379_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetHeight

procedure TvgRemindersLine.pm_SetSorted(aValue: Boolean);
//#UC START# *536A131E02BA_532322D901A3set_var*
//#UC END# *536A131E02BA_532322D901A3set_var*
begin
//#UC START# *536A131E02BA_532322D901A3set_impl*
 f_Sorted := aValue;
 if f_Sorted then
  f_RemindersList.Sort;
 UpdateReminders;
//#UC END# *536A131E02BA_532322D901A3set_impl*
end;//TvgRemindersLine.pm_SetSorted

function TvgRemindersLine.pm_GetIsActivateProcessingLocked: Boolean;
//#UC START# *5410142F02C5_532322D901A3get_var*
//#UC END# *5410142F02C5_532322D901A3get_var*
begin
//#UC START# *5410142F02C5_532322D901A3get_impl*
 Result := (f_ActivateProcessingLockCount > 0);
//#UC END# *5410142F02C5_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetIsActivateProcessingLocked

procedure TvgRemindersLine.PageInactive;
//#UC START# *473DB05D033A_532322D901A3_var*
//#UC END# *473DB05D033A_532322D901A3_var*
begin
//#UC START# *473DB05D033A_532322D901A3_impl*
 f_PageIsHidden := True;
 Visible := False;
//#UC END# *473DB05D033A_532322D901A3_impl*
end;//TvgRemindersLine.PageInactive

procedure TvgRemindersLine.PageActive;
//#UC START# *473DB06A01A8_532322D901A3_var*
//#UC END# *473DB06A01A8_532322D901A3_var*
begin
//#UC START# *473DB06A01A8_532322D901A3_impl*
 f_PageIsHidden := False;
 SyncPosition;
 Visible := True;
//#UC END# *473DB06A01A8_532322D901A3_impl*
end;//TvgRemindersLine.PageActive

function TvgRemindersLine.pm_GetWeight: Integer;
//#UC START# *473DB083030D_532322D901A3get_var*
//#UC END# *473DB083030D_532322D901A3get_var*
begin
//#UC START# *473DB083030D_532322D901A3get_impl*
 Result := 0;
//#UC END# *473DB083030D_532322D901A3get_impl*
end;//TvgRemindersLine.pm_GetWeight

function TvgRemindersLine.GetDockControl(const aDockable: IafwDockableControl): TWinControl;
//#UC START# *4DA835AB02CC_532322D901A3_var*
//#UC END# *4DA835AB02CC_532322D901A3_var*
begin
//#UC START# *4DA835AB02CC_532322D901A3_impl*
 Result := f_Form;
//#UC END# *4DA835AB02CC_532322D901A3_impl*
end;//TvgRemindersLine.GetDockControl

procedure TvgRemindersLine.WndProcListenerNotify(Msg: PCWPStruct;
  var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_532322D901A3_var*
 function IsParentControlMessage(aWithParents: Boolean): Boolean;
 var
  l_Control: TWinControl;
 begin
  Result := False;
  l_Control := f_Parent;
  while Assigned(l_Control) and not Result do
  begin
   if l_Control.HandleAllocated then
    Result := l_Control.Handle = Msg.hwnd
   else
    Break;
   if not aWithParents then
    Break;
   l_Control := l_Control.Parent; 
  end;
 end;

var
 l_HandleFocusLost,
 l_HandleFocusAccepted: THandle;

 l_VisiblePopupForm: TvtPopupFormModelPart;
 l_ControlLostFocus: TWinControl;

 l_WndCtrl: TWinControl;
 l_WndPos: PWindowPos;
//#UC END# *4F79CF3400BB_532322D901A3_var*
begin
//#UC START# *4F79CF3400BB_532322D901A3_impl*
 if not Assigned(f_Form) then
  Exit;

 if not f_Form.HandleAllocated then
  Exit;

 if f_InMenu then
  if Msg.message = WM_EXITMENULOOP then
  begin
   f_InMenu := False;
   SetActiveWindow(MainFormHandle);
   Exit;
  end;

 if f_InMenu then
  Exit;

 if (Msg.message = WM_WINDOWPOSCHANGED) then
 begin
  l_WndPos := Pointer(Msg.LParam);
  if l_WndPos.Flags and SWP_SHOWWINDOW = 0 then
   Exit;
  l_WndCtrl := FindControl(Msg.hwnd);
  if Assigned(l_WndCtrl) then
  begin
   if not ((l_WndCtrl is TvtPopupForm) or (l_WndCtrl is THintWindow)) then
    if GetWindowLong(Msg.hwnd, GWL_EXSTYLE) and WS_EX_TOOLWINDOW > 0 then
    begin
     ClosePopupForm; // скрываем баллон при появлении выпадающего списка
     Exit;
    end;
   if (l_WndCtrl is TCustomForm) and
      (l_WndCtrl.Parent = nil) and
      not (l_WndCtrl is TvtPopupForm) then
   begin
    ClosePopupForm; // скрываем баллон при появлении "левого" окна. Например, диалога.
    Exit;
   end;
  end;
 end;

 if (Msg.message = WM_MOVE) or (Msg.message = WM_SIZE) then
  if f_Parent.Visible then
   if IsParentControlMessage(True) then
    SendSyncPosition;

 if Msg.hwnd = MainFormHandle then
  if ((Msg.Message = WM_SYSCOMMAND) and (Msg.WParam = SC_MINIMIZE)) or
     ((Msg.Message = WM_SIZE) and (Msg.wParam = SIZE_MINIMIZED)) then
  begin // один вариант для сворачивания через кнопку на таскбаре, второй - через кнопку в окне
   f_Form.Visible := False;
   ClosePopupForm;
  end;
//#UC END# *4F79CF3400BB_532322D901A3_impl*
end;//TvgRemindersLine.WndProcListenerNotify

procedure TvgRemindersLine.WndProcRetListenerNotify(Msg: PCWPRetStruct;
  var theResult: Tl3HookProcResult);
//#UC START# *4F79CF9200A0_532322D901A3_var*
var
 l_Active: TWinControl;
//#UC END# *4F79CF9200A0_532322D901A3_var*
begin
//#UC START# *4F79CF9200A0_532322D901A3_impl*
 if (Msg.hwnd = MainFormHandle) then
 case Msg.Message of
  WM_SIZE, WM_SYSCOMMAND: // один вариант для разворачивания через кнопку на таскбаре, второй - через кнопку в окне
   if ((Msg.Message = WM_SIZE) and ((Msg.wParam = SIZE_RESTORED) or (Msg.wParam = SIZE_MAXIMIZED))) or
      ((Msg.Message = WM_SYSCOMMAND) and (Msg.wParam = SC_MAXIMIZE)) then
    if Assigned(f_RestoreWindowTimer) and DwmCompositionEnabled then
     f_RestoreWindowTimer.Enabled := True
    else
     f_Form.Visible := f_Visible;
  WM_ACTIVATEAPP, WM_WINDOWPOSCHANGED:
   begin
    if (Msg.Message = WM_ACTIVATEAPP) and (Msg.wParam = WA_INACTIVE) then
    begin
     ClosePopupForm;
     Exit;
    end;
    Assert(Assigned(f_MainForm));
    if not (TCustomForm(f_MainForm).WindowState = wsMinimized) then
     if f_Parent.Visible then
      CheckZOrder;
   end;
 end else
 if (Msg.Message = WM_ACTIVATE) then
 begin
  l_Active := FindControl(GetActiveWindow);
  if not Assigned(l_Active) // фокус ушел из приложения: закроем баллон
    or ((l_Active.Handle <> MainFormHandle) and
        (l_Active.Handle <> f_Form.Handle) and
        not (l_Active is TvtPopupForm)) then // фокус ушел из нашего главного окна
   ClosePopupForm;
 end; 
//#UC END# *4F79CF9200A0_532322D901A3_impl*
end;//TvgRemindersLine.WndProcRetListenerNotify

procedure TvgRemindersLine.ControlDropped(aControl: TControl);
//#UC START# *5332C183032A_532322D901A3_var*
var
 I: Integer;
 l_Form: IvcmEntityForm;
//#UC END# *5332C183032A_532322D901A3_var*
begin
//#UC START# *5332C183032A_532322D901A3_impl*
 if not Supports(aControl, IvcmEntityForm, l_Form) then
  Exit;

 for I := 0 to Count - 1 do
  if f_RemindersList[I].UserType = l_Form.UserType then
  begin
   f_RemindersList[I].PopupFormControl := aControl;
   Break;
  end;
//#UC END# *5332C183032A_532322D901A3_impl*
end;//TvgRemindersLine.ControlDropped

procedure TvgRemindersLine.RemindersLineFormDestroyed;
//#UC START# *5333FE7101AE_532322D901A3_var*
//#UC END# *5333FE7101AE_532322D901A3_var*
begin
//#UC START# *5333FE7101AE_532322D901A3_impl*
 f_Form := nil;
 ReleaseResources;
//#UC END# *5333FE7101AE_532322D901A3_impl*
end;//TvgRemindersLine.RemindersLineFormDestroyed

function TvgRemindersLine.IsInMove: Boolean;
//#UC START# *5334688E024C_532322D901A3_var*
//#UC END# *5334688E024C_532322D901A3_var*
begin
//#UC START# *5334688E024C_532322D901A3_impl*
 Result := (f_OldLeft <> f_Form.Left) or (f_OldTop <> f_Form.Top);
//#UC END# *5334688E024C_532322D901A3_impl*
end;//TvgRemindersLine.IsInMove

procedure TvgRemindersLine.CorrectBounds(var aLeft: Integer;
  var aTop: Integer;
  var aWidth: Integer;
  var aHeight: Integer);
//#UC START# *5335BBE60398_532322D901A3_var*
var
 l_TopLeft: TPoint;
//#UC END# *5335BBE60398_532322D901A3_var*
begin
//#UC START# *5335BBE60398_532322D901A3_impl*
 if Assigned(f_Parent) then
  if Visible and f_Parent.Visible then
  begin
   AdjustPopupFormPosition(True, False);

   l_TopLeft := f_Parent.ClientToScreen(Point(0, 0));
   if aLeft < l_TopLeft.X then
    aLeft := l_TopLeft.X
   else
   if aLeft + f_Form.Width > l_TopLeft.X + f_Parent.ClientWidth then
    aLeft := Max(l_TopLeft.X + f_Parent.ClientWidth - f_Form.Width, l_TopLeft.X);

   if aTop < l_TopLeft.Y then
    aTop := l_TopLeft.Y
   else
   if aTop + f_Form.Height > l_TopLeft.Y + f_Parent.ClientHeight then
    aTop := Max(l_TopLeft.Y + f_Parent.ClientHeight - f_Form.Height, l_TopLeft.Y);
  end;
 BoundsChanged(aLeft, aTop, aWidth, aHeight);
//#UC END# *5335BBE60398_532322D901A3_impl*
end;//TvgRemindersLine.CorrectBounds

procedure TvgRemindersLine.UpdateActions;
//#UC START# *533AA46501AF_532322D901A3_var*
 function IsFullyVisible(aControl: TControl): Boolean;
 begin
  while Assigned(aControl) do
  begin
   if not aControl.Visible then
   begin
    Result := False;
    Exit;
   end;
   aControl := aControl.Parent;
  end;
  Result := True;
 end;
var
 I: Integer;
//#UC END# *533AA46501AF_532322D901A3_var*
begin
//#UC START# *533AA46501AF_532322D901A3_impl*
 if not IsFullyVisible(Parent) then
  Visible := False; // запил на случай, если медали лежат на вкладке PageControl-а, но PageInactive не пришёл
 for I := 0 to Count - 1 do
  Reminder[I].UpdateAction;
//#UC END# *533AA46501AF_532322D901A3_impl*
end;//TvgRemindersLine.UpdateActions

{$If not defined(NoVCM)}
function TvgRemindersLine.Get_Count: Integer;
//#UC START# *53513BDF02CD_532322D901A3get_var*
//#UC END# *53513BDF02CD_532322D901A3get_var*
begin
//#UC START# *53513BDF02CD_532322D901A3get_impl*
 Result := pm_GetCount;
//#UC END# *53513BDF02CD_532322D901A3get_impl*
end;//TvgRemindersLine.Get_Count
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvgRemindersLine.Get_OwnedComponent(aIndex: Integer): TComponent;
//#UC START# *53513C1400CC_532322D901A3get_var*
//#UC END# *53513C1400CC_532322D901A3get_var*
begin
//#UC START# *53513C1400CC_532322D901A3get_impl*
 Result := Reminder[aIndex];
//#UC END# *53513C1400CC_532322D901A3get_impl*
end;//TvgRemindersLine.Get_OwnedComponent
{$IfEnd} //not NoVCM

procedure TvgRemindersLine.SyncPosition;
//#UC START# *535E4BA10317_532322D901A3_var*
var
 l_TopLeft: TPoint;
//#UC END# *535E4BA10317_532322D901A3_var*
begin
//#UC START# *535E4BA10317_532322D901A3_impl*
 if not Assigned(f_Form) then
  Exit;

 if f_HorzPos < 0 then
  f_HorzPos := 0
 else
 if f_HorzPos > 1 then
  f_HorzPos := 1;

 if f_VertPos < 0 then
  f_VertPos := 0
 else
 if f_VertPos > 1 then
  f_VertPos := 1;

 if not f_PageIsHidden then
 begin
  l_TopLeft := f_Parent.ClientToScreen(Point(0, 0));
  f_Form.Left := l_TopLeft.X + Trunc((f_Parent.ClientWidth - f_Form.Width) * f_HorzPos);
  f_Form.Top := l_TopLeft.Y + Trunc((f_Parent.ClientHeight - f_Form.Height) * f_VertPos);
 end;

 AdjustPopupFormPosition(True, False);

 f_SyncPosSent := False;
 f_OldLeft := f_Form.Left;
 f_OldTop := f_Form.Top;
//#UC END# *535E4BA10317_532322D901A3_impl*
end;//TvgRemindersLine.SyncPosition

{$If not defined(NoVCM)}
procedure TvgRemindersLine.ReleaseResources;
//#UC START# *538B1756012F_532322D901A3_var*
var
 I: Integer;
//#UC END# *538B1756012F_532322D901A3_var*
begin
//#UC START# *538B1756012F_532322D901A3_impl*
 FreeAndNil(f_RestoreWindowTimer);
 if Assigned(f_RemindersList) then
  for I := f_RemindersList.Count - 1 downto 0 do
   f_RemindersList[I].ReleaseResources;
//#UC END# *538B1756012F_532322D901A3_impl*
end;//TvgRemindersLine.ReleaseResources
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TvgRemindersLine.MainFormChanged(aForm: TControl);
//#UC START# *53CF7DD00066_532322D901A3_var*
//#UC END# *53CF7DD00066_532322D901A3_var*
begin
//#UC START# *53CF7DD00066_532322D901A3_impl*
 f_MainForm := nil;
//#UC END# *53CF7DD00066_532322D901A3_impl*
end;//TvgRemindersLine.MainFormChanged
{$IfEnd} //not NoVCM

procedure TvgRemindersLine.TabBecomeActive;
//#UC START# *54868B67034A_532322D901A3_var*
//#UC END# *54868B67034A_532322D901A3_var*
begin
//#UC START# *54868B67034A_532322D901A3_impl*
 PageActive;
//#UC END# *54868B67034A_532322D901A3_impl*
end;//TvgRemindersLine.TabBecomeActive

procedure TvgRemindersLine.TabBecomeInactive;
//#UC START# *54868B84029F_532322D901A3_var*
//#UC END# *54868B84029F_532322D901A3_var*
begin
//#UC START# *54868B84029F_532322D901A3_impl*
 PageInactive;
//#UC END# *54868B84029F_532322D901A3_impl*
end;//TvgRemindersLine.TabBecomeInactive

procedure TvgRemindersLine.Cleanup;
//#UC START# *479731C50290_532322D901A3_var*
var
 I: Integer;
//#UC END# *479731C50290_532322D901A3_var*
begin
//#UC START# *479731C50290_532322D901A3_impl*
 TvgRemindersLineManager.RemoveLine(Self);
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveWndProcRetListener(Self);
 ReleaseResources;
 if Assigned(f_RemindersList) then
 begin
  for I := f_RemindersList.Count - 1 downto 0 do
   f_RemindersList[I].Free;
  f_RemindersList.Clear;
  FreeAndNil(f_RemindersList);
 end;
 if Assigned(f_Form) then
  f_Form.RemindersLine := nil;
 FreeAndNil(f_Form);
 inherited;
//#UC END# *479731C50290_532322D901A3_impl*
end;//TvgRemindersLine.Cleanup

constructor TvgRemindersLine.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_532322D901A3_var*
//#UC END# *47D1602000C6_532322D901A3_var*
begin
//#UC START# *47D1602000C6_532322D901A3_impl*
 inherited;
 if (Win32MajorVersion >= 6) then
 begin
  f_RestoreWindowTimer := TTimer.Create(aOwner);
  with f_RestoreWindowTimer do
  begin
   Enabled := False;
   OnTimer := RestoreWindowTimerProc;
   Interval := 260;
  end;
 end
 else
  f_RestoreWindowTimer := nil;
 f_Sorted := False;
 f_PageIsHidden := False;
 f_MainForm := nil;
 f_Form := TvgRemindersLineForm.CreateNew(aOwner);
 f_Form.Name := aOwner.Name + '_RemindersLineForm';
 f_Form.RemindersLine := Pointer(Self as IvgRemindersLine);
 f_Form.Visible := False;
 f_Visible := False;
 f_InMenu := False;
 f_UpdateCount := 0;
 f_NeedCallChanged := False;
 f_RemindersList := TvgRemindersList.Create;
 f_SyncPosSent := False;
 Tl3ListenersManager.AddWndProcListener(Self);
 Tl3ListenersManager.AddWndProcRetListener(Self);
 TvgRemindersLineManager.AddLine(Self);
//#UC END# *47D1602000C6_532322D901A3_impl*
end;//TvgRemindersLine.Create

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgReminder
 TtfwClassRef.Register(TvgReminder);
{$IfEnd} //not NoScripts AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgRemindersLine
 TtfwClassRef.Register(TvgRemindersLine);
{$IfEnd} //not NoScripts AND not NoVGScene

end.