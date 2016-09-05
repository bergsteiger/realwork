unit evControlContainerEX;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evControlContainerEX.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlContainerEX" MUID: (47D01F9801D8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evControlContainer
 , evQueryCardDropControlsInt
 , evDropCalendar
 , evDropTree
 , l3Core
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , nevBase
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , nevTools
 , Types
 , l3Variant
 , Messages
;

type
 TevControlContainerEX = class(TevControlContainer, IevDropContainer)
  private
   f_DateFormat: AnsiString;
    {* Формат даты. }
   f_EditMask: AnsiString;
    {* Шаблон календаря. }
   f_StartSize: Boolean;
   f_DropTree: IevDropControl;
    {* Дерево или календарь - выпадающий контрол, который должен быть только 
         один. }
   f_ESCPressed: Boolean;
    {* Обработка нажатия ESC при видимом выпадающем контроле. }
   f_Calendar: TevDropCalendar;
    {* Обработка нажатия ESC при видимом выпадающем контроле. }
   f_SubTree: TevDropTree;
    {* Выпадающая панель с деревом. }
  private
   procedure UpdateMask;
    {* Обновляет маску. }
   function FormatSettingsChange(var Message: TMessage): Boolean;
    {* Обработчик изменения формата даты. }
   procedure UpdateFormat;
    {* Обновляет формат даты. }
   procedure NeedCloseTree(Sender: TObject);
   procedure CancelDate(Sender: TObject);
    {* Обработчик отказа от выбора даты. }
   function DoGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure ChooseNode(Sender: TObject;
    const Value: InevSimpleNode);
   procedure StartSize(Sender: TObject);
   procedure EndSize(Sender: TObject);
   function OwnerAssigned: Boolean;
   procedure TreeCurrentChanged(Sender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
  protected
   function EditMask: AnsiString;
    {* Шаблон маски. }
   function DateFormat: AnsiString;
    {* Формат даты. }
   procedure SetDropTree(const ATreeDrop: IevDropControl;
    const ATagWrap: InevPara);
    {* Показывает/закрывает выпадающее дерево. }
   function IsDropTreeVisible: Boolean;
    {* Проверяет отображается ли окно календаря или дерева. }
   procedure ApplyDate(Value: TDateTime);
    {* Передаёт выбранную дату в календарь. }
   procedure ChooseDate(Sender: TObject);
    {* Обработчик выбора текущей даты. }
   procedure DoDrop(const aPoint: TPoint;
    AInvert: Boolean;
    AWidth: Integer;
    ByUser: Boolean);
    {* Вываливает выпадающий контрол по указанным координатам. }
   procedure ShowControl(const aPoint: TPoint;
    AInvert: Boolean;
    AWnd: hWnd;
    AWidth: Integer;
    AHeight: Integer);
    {* Вывод контрола на экран. }
   function DropControlHeigth: Integer;
    {* Высота выпадающего контрола. }
   procedure HideControl(NeedFocus: Boolean);
    {* Прячет выпадающий котрол. }
   function GetDropTreeNode(anIndex: Integer): InevSimpleNode;
   function CheckControl(const aDropControl: IevDropControl): Boolean;
   function GetControl: TControl;
    {* Возвращает контрол. }
   function Get_Tree: InevSimpleTree;
   procedure Set_Tree(const aValue: InevSimpleTree);
   procedure Set_Current(aValue: Integer);
   function IsSameTreeRoot(const aRoot: InevNode): Boolean;
   procedure DropControlChanging;
   procedure DropControlChanged;
   function GetCurrentNode: InevSimpleNode;
   function IsSimpleTree: Boolean;
   function Get_ESCPressed: Boolean;
   procedure Set_ESCPressed(aValue: Boolean);
   procedure DoHideDroppedControl(CanSetFocus: Boolean); override;
   function DoMouseWheel(aDown: Boolean): Boolean; override;
   function Get_DropTextStyle: Tl3StyleId;
   procedure Set_DropTextStyle(aValue: Tl3StyleId);
   function Get_AllowEmptyCurrent: Boolean;
   procedure Set_AllowEmptyCurrent(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetNode(anIndex: Integer): InevSimpleNode; override;
   procedure DoDeleteOnUndo(aTag: Tl3Tag); override;
   procedure DoChangePara(const aCurPara: InevPara); override;
   function DoKeyDown(const aView: InevView;
    var Msg: TWMKeyDown;
    aCurPara: Tl3Tag): Boolean; override;
    {* Посылка сообщений о нажатии клавиш. }
  public
   constructor Create; override;
 end;//TevControlContainerEX

implementation

uses
 l3ImplUses
 , l3Date
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3ImageList
 , evQueryCardInt
 , l3Base
 , l3ControlsTypes
 , k2Tags
 , Classes
 , evdTypes
 , Windows
 , l3String
 , LeafPara_Const
 , l3Defaults
 , Graphics
 //#UC START# *47D01F9801D8impl_uses*
 //#UC END# *47D01F9801D8impl_uses*
;

procedure TevControlContainerEX.UpdateMask;
 {* Обновляет маску. }
//#UC START# *47D027090375_47D01F9801D8_var*
//#UC END# *47D027090375_47D01F9801D8_var*
begin
//#UC START# *47D027090375_47D01F9801D8_impl*
 f_EditMask := DefDateMask(' ', l3Date.FourDigitYear);
//#UC END# *47D027090375_47D01F9801D8_impl*
end;//TevControlContainerEX.UpdateMask

function TevControlContainerEX.FormatSettingsChange(var Message: TMessage): Boolean;
 {* Обработчик изменения формата даты. }
//#UC START# *47D027C2002A_47D01F9801D8_var*
//#UC END# *47D027C2002A_47D01F9801D8_var*
begin
//#UC START# *47D027C2002A_47D01F9801D8_impl*
 Result := False;
 if (Message.Msg = WM_WININICHANGE)
   {$IFDEF WIN32} and Application.UpdateFormatSettings {$ENDIF} then
 begin
  UpdateFormat;
  UpdateMask;
  //!!!Stub ниже должно стоять обновление всех полей с датами.
 end;//if (Message.Msg = WM_WININICHANGE)...
//#UC END# *47D027C2002A_47D01F9801D8_impl*
end;//TevControlContainerEX.FormatSettingsChange

procedure TevControlContainerEX.UpdateFormat;
 {* Обновляет формат даты. }
//#UC START# *47D028510174_47D01F9801D8_var*
//#UC END# *47D028510174_47D01F9801D8_var*
begin
//#UC START# *47D028510174_47D01F9801D8_impl*
 f_DateFormat := DefDateFormat(FourDigitYear);
//#UC END# *47D028510174_47D01F9801D8_impl*
end;//TevControlContainerEX.UpdateFormat

procedure TevControlContainerEX.NeedCloseTree(Sender: TObject);
//#UC START# *47D02C5A0219_47D01F9801D8_var*
//#UC END# *47D02C5A0219_47D01F9801D8_var*
begin
//#UC START# *47D02C5A0219_47D01F9801D8_impl*
 if f_DropTree <> nil then 
  f_DropTree.CloseTree;
//#UC END# *47D02C5A0219_47D01F9801D8_impl*
end;//TevControlContainerEX.NeedCloseTree

procedure TevControlContainerEX.CancelDate(Sender: TObject);
 {* Обработчик отказа от выбора даты. }
//#UC START# *47D02C810118_47D01F9801D8_var*
//#UC END# *47D02C810118_47D01F9801D8_var*
begin
//#UC START# *47D02C810118_47D01F9801D8_impl*
 if f_DropTree <> nil then 
  HideControl(true);
//#UC END# *47D02C810118_47D01F9801D8_impl*
end;//TevControlContainerEX.CancelDate

function TevControlContainerEX.DoGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *47D02C970149_47D01F9801D8_var*
var
 l_List : InevImageList;
 l_EditControl : IevEditorControl;
//#UC END# *47D02C970149_47D01F9801D8_var*
begin
//#UC START# *47D02C970149_47D01F9801D8_impl*
 l_List := Tl3ImageList.Make(aImages);
 Result := -1;
 if (f_DropTree <> nil) then
  if Supports(f_DropTree, IevEditorControl, l_EditControl) then
   try
    Result := l_EditControl.Req.GetItemImage(Index, l_List);
   finally
    l_EditControl := nil;
   end;//try..finally
 if (l_List = nil) then
  aImages := nil
 else
  aImages := l_List.Hack;
//#UC END# *47D02C970149_47D01F9801D8_impl*
end;//TevControlContainerEX.DoGetItemImage

procedure TevControlContainerEX.ChooseNode(Sender: TObject;
 const Value: InevSimpleNode);
//#UC START# *47D02CC80102_47D01F9801D8_var*
var
 l_Combo : IevDropCombo;
//#UC END# *47D02CC80102_47D01F9801D8_var*
begin
//#UC START# *47D02CC80102_47D01F9801D8_impl*
 pm_GetEditor.Selection.Unselect;
 if Supports(f_DropTree, IevDropCombo, l_Combo) then
 try
  l_Combo.ChooseNode(Value);
 finally
  l_Combo := nil;
 end; 
//#UC END# *47D02CC80102_47D01F9801D8_impl*
end;//TevControlContainerEX.ChooseNode

procedure TevControlContainerEX.StartSize(Sender: TObject);
//#UC START# *47D02D2500CF_47D01F9801D8_var*
//#UC END# *47D02D2500CF_47D01F9801D8_var*
begin
//#UC START# *47D02D2500CF_47D01F9801D8_impl*
 f_StartSize := True;
//#UC END# *47D02D2500CF_47D01F9801D8_impl*
end;//TevControlContainerEX.StartSize

procedure TevControlContainerEX.EndSize(Sender: TObject);
//#UC START# *47D02D2E0026_47D01F9801D8_var*
//#UC END# *47D02D2E0026_47D01F9801D8_var*
begin
//#UC START# *47D02D2E0026_47D01F9801D8_impl*
 f_StartSize := False;
//#UC END# *47D02D2E0026_47D01F9801D8_impl*
end;//TevControlContainerEX.EndSize

function TevControlContainerEX.OwnerAssigned: Boolean;
//#UC START# *47D02D4C037A_47D01F9801D8_var*
//#UC END# *47D02D4C037A_47D01F9801D8_var*
begin
//#UC START# *47D02D4C037A_47D01F9801D8_impl*
 Result := f_DropTree <> nil;
//#UC END# *47D02D4C037A_47D01F9801D8_impl*
end;//TevControlContainerEX.OwnerAssigned

procedure TevControlContainerEX.TreeCurrentChanged(Sender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *4885BCF00275_47D01F9801D8_var*
//#UC END# *4885BCF00275_47D01F9801D8_var*
begin
//#UC START# *4885BCF00275_47D01F9801D8_impl*
 if Assigned(f_DropTree) then
 begin
  if aNewCurrent = -1 then
   f_DropTree.DropDownCurrentChanged(nil)
  else
   f_DropTree.DropDownCurrentChanged(GetDropTreeNode(aNewCurrent));
 end;
//#UC END# *4885BCF00275_47D01F9801D8_impl*
end;//TevControlContainerEX.TreeCurrentChanged

function TevControlContainerEX.EditMask: AnsiString;
 {* Шаблон маски. }
//#UC START# *47CEA1CB02E7_47D01F9801D8_var*
//#UC END# *47CEA1CB02E7_47D01F9801D8_var*
begin
//#UC START# *47CEA1CB02E7_47D01F9801D8_impl*
 if f_EditMask = '' then 
  UpdateMask;
 Result := f_EditMask;
//#UC END# *47CEA1CB02E7_47D01F9801D8_impl*
end;//TevControlContainerEX.EditMask

function TevControlContainerEX.DateFormat: AnsiString;
 {* Формат даты. }
//#UC START# *47CEA1DF0057_47D01F9801D8_var*
//#UC END# *47CEA1DF0057_47D01F9801D8_var*
begin
//#UC START# *47CEA1DF0057_47D01F9801D8_impl*
 if f_DateFormat = '' then
  UpdateFormat;
 Result := f_DateFormat;
//#UC END# *47CEA1DF0057_47D01F9801D8_impl*
end;//TevControlContainerEX.DateFormat

procedure TevControlContainerEX.SetDropTree(const ATreeDrop: IevDropControl;
 const ATagWrap: InevPara);
 {* Показывает/закрывает выпадающее дерево. }
//#UC START# *47CEA2040056_47D01F9801D8_var*
var
 l_DropCal : IevDropCalendar;                                       
//#UC END# *47CEA2040056_47D01F9801D8_var*
begin
//#UC START# *47CEA2040056_47D01F9801D8_impl*
 if f_DropTree <> nil then
  HideControl(true)
 else
  if (ATreeDrop <> nil) then
  begin
   f_DropTree := ATreeDrop;
   if Supports(ATreeDrop, IevDropCalendar, l_DropCal) then 
   begin
    try     
     f_Calendar.OnNeedCloseTree := NeedCloseTree;
     f_Calendar.OnChooseDate := ChooseDate;
     f_Calendar.OnCancelDate := CancelDate;
    finally
     l_DropCal := nil;
    end;
   end//if l3IOk(ATreeDrop.QueryInterface...
   else
    begin
     f_SubTree.OnGetItemImage := DoGetItemImage;
     f_SubTree.OnNeedCloseTree := NeedCloseTree;
     f_SubTree.OnChooseItem := ChooseNode;
     f_SubTree.OnStartResize := StartSize;
     f_SubTree.OnOwnerAssigned := OwnerAssigned;
     f_SubTree.OnEndResize := EndSize;
     f_SubTree.OnCurrentChanged := TreeCurrentChanged;
    end;//else
   f_CurrPara := ATagWrap;
  end;//ATreeDrop <> nil
//#UC END# *47CEA2040056_47D01F9801D8_impl*
end;//TevControlContainerEX.SetDropTree

function TevControlContainerEX.IsDropTreeVisible: Boolean;
 {* Проверяет отображается ли окно календаря или дерева. }
//#UC START# *47CEA2170217_47D01F9801D8_var*
//#UC END# *47CEA2170217_47D01F9801D8_var*
begin
//#UC START# *47CEA2170217_47D01F9801D8_impl*
 Result := f_DropTree <> nil;
//#UC END# *47CEA2170217_47D01F9801D8_impl*
end;//TevControlContainerEX.IsDropTreeVisible

procedure TevControlContainerEX.ApplyDate(Value: TDateTime);
 {* Передаёт выбранную дату в календарь. }
//#UC START# *47CEA22403D8_47D01F9801D8_var*
var
 l_DtStr       : string;
 l_EditControl : IevEditorControlField;
//#UC END# *47CEA22403D8_47D01F9801D8_var*
begin
//#UC START# *47CEA22403D8_47D01F9801D8_impl*
 l_DtStr := DateToStr(f_Calendar.Date);
 if Supports(f_DropTree, IevEditorControlField, l_EditControl) then 
 try
  l_EditControl.Text := l3CStr(l_DtStr);
 finally
  l_EditControl := nil;
 end; 
 f_Calendar.Date := Value; 
//#UC END# *47CEA22403D8_47D01F9801D8_impl*
end;//TevControlContainerEX.ApplyDate

procedure TevControlContainerEX.ChooseDate(Sender: TObject);
 {* Обработчик выбора текущей даты. }
//#UC START# *47CEA2330343_47D01F9801D8_var*
var
 l_DtStr       : string;
 l_EditControl : IevEditorControlField;
 l_Op          : InevOp;
//#UC END# *47CEA2330343_47D01F9801D8_var*
begin
//#UC START# *47CEA2330343_47D01F9801D8_impl*
 l_Op := GetDocumentContainer.Processor.StartOp;
 try
  l_DtStr := DateToStr(f_Calendar.Date);
  if Supports(f_DropTree, IevEditorControlField, l_EditControl) then 
   try
    l_EditControl.Text := l3CStr(l_DtStr);
    RememberState(l_EditControl);
   finally
    l_EditControl := nil;
   end; 
  HideControl(true);
 finally
  l_Op := nil;
 end;  
//#UC END# *47CEA2330343_47D01F9801D8_impl*
end;//TevControlContainerEX.ChooseDate

procedure TevControlContainerEX.DoDrop(const aPoint: TPoint;
 AInvert: Boolean;
 AWidth: Integer;
 ByUser: Boolean);
 {* Вываливает выпадающий контрол по указанным координатам. }
//#UC START# *47CEA244025F_47D01F9801D8_var*
var                                                                  
 l_Calendar : IevDropCalendar;
 l_Combo    : IevDropCombo; 
 l_Control  : IevEditorFieldWithTree;
 l_DropCtrl : IevDropControl;
//#UC END# *47CEA244025F_47D01F9801D8_var*
begin
//#UC START# *47CEA244025F_47D01F9801D8_impl*
 l_DropCtrl := f_DropTree;
 if Supports(l_DropCtrl, IevDropCalendar, l_Calendar) then  
  try
   f_Calendar.Date := l_Calendar.aDate;
   Windows.SetParent(f_Calendar.Handle, 0);   
   ShowControl(aPoint, AInvert, f_Calendar.Handle, 0, f_Calendar.Height);
   Assert(pm_GetEditor <> nil, 'Не получаем контрол редактора для календаря!');   
   f_Calendar.Parent := pm_GetEditor.GetDelphiControl as TWinControl;
  finally
   l_Calendar := nil;
  end//try..finally
 else 
 if Supports(l_DropCtrl, IevDropCombo, l_Combo) then    
  try
   f_SubTree.ParentWindow := 0;
   if Supports(l_DropCtrl, IevEditorFieldWithTree, l_Control) then
   try     
    //!!! Собственно здесь и получаем дерево !!!    
    f_CurrPara := l_Control.Para;
    f_SubTree.TreeStruct := l_Control.SourceTree;
    if l_Control.ComboStyle = ev_cbFilterable then     
     f_SubTree.ViewOptions := f_SubTree.ViewOptions + [voShowLines, voShowIcons] 
    else
     f_SubTree.ViewOptions := f_SubTree.ViewOptions - [voShowLines, voShowIcons]; 
   finally
    l_Control := nil;
   end;
   f_SubTree.SelectColor.TextColor := clWhite;
   f_SubTree.SelectColor.BackColor := cGarant2011SelectionColor;
   f_SubTree.SelectNonFocusColor.TextColor := clWhite;
   f_SubTree.SelectNonFocusColor.BackColor := cGarant2011SelectionColor;
   f_SubTree.ViewOptions := f_SubTree.ViewOptions + [voShowSelectAsArrow];
   f_SubTree.Options := f_SubTree.Options + [vlMouseTrack];
   f_SubTree.ActionElementMode := l3_amSingleClick;
   f_SubTree.Init(AInvert, l_Combo.IsList, AWidth);
   ShowControl(aPoint, AInvert, f_SubTree.Handle, AWidth, f_SubTree.Height);
   Assert(pm_GetEditor <> nil, 'Не получаем контрол редактора для дерева!');   
   f_SubTree.Parent := pm_GetEditor.GetDelphiControl as TWinControl;
  finally
   l_Combo := nil;
  end;//try..finally
//#UC END# *47CEA244025F_47D01F9801D8_impl*
end;//TevControlContainerEX.DoDrop

procedure TevControlContainerEX.ShowControl(const aPoint: TPoint;
 AInvert: Boolean;
 AWnd: hWnd;
 AWidth: Integer;
 AHeight: Integer);
 {* Вывод контрола на экран. }
//#UC START# *47CEA2640232_47D01F9801D8_var*
const 
 cDropControlFlags : array [Boolean] of Integer = 
   (SWP_NOACTIVATE or SWP_SHOWWINDOW or SWP_FRAMECHANGED, 
   SWP_SHOWWINDOW or SWP_NOSIZE);
 
var
 l_Y        : Integer;
 l_Calendar : Boolean;
//#UC END# *47CEA2640232_47D01F9801D8_var*
begin
//#UC START# *47CEA2640232_47D01F9801D8_impl*
 if AInvert then
  l_Y := aPoint.Y - AHeight
 else
  l_Y := aPoint.Y;
 Assert(AWnd <> 0, 'Неизвестный выпадающий контрол. ');
 l_Calendar := (AWnd = f_Calendar.Handle);
 SetWindowPos(AWnd, HWND_TOPMOST, aPoint.X, l_Y, AWidth, AHeight,
   cDropControlFlags[l_Calendar]);
//#UC END# *47CEA2640232_47D01F9801D8_impl*
end;//TevControlContainerEX.ShowControl

function TevControlContainerEX.DropControlHeigth: Integer;
 {* Высота выпадающего контрола. }
//#UC START# *47CEA29002BE_47D01F9801D8_var*
var
 l_Calendar : IevDropCalendar;
//#UC END# *47CEA29002BE_47D01F9801D8_var*
begin
//#UC START# *47CEA29002BE_47D01F9801D8_impl*
 if f_DropTree <> nil then
  if Supports(f_DropTree, IevDropCalendar, l_Calendar) then
   try
    Result := f_Calendar.Height
   finally
    l_Calendar := nil;
   end 
  else 
   Result := f_SubTree.Height
 else 
  Result := 0;  
//#UC END# *47CEA29002BE_47D01F9801D8_impl*
end;//TevControlContainerEX.DropControlHeigth

procedure TevControlContainerEX.HideControl(NeedFocus: Boolean);
 {* Прячет выпадающий котрол. }
//#UC START# *47CEA2A102E2_47D01F9801D8_var*
var
 l_Calendar : IevDropCalendar;
 l_Control  : TWinControl;
 l_Handle   : HWND;
//#UC END# *47CEA2A102E2_47D01F9801D8_var*
begin
//#UC START# *47CEA2A102E2_47D01F9801D8_impl*
 if f_DropTree <> nil then
 begin  
  f_DropTree.Down  := False;
  Assert(pm_GetEditor <> nil, 'Не получаем контрол редактора');
  l_Control := (pm_GetEditor.GetDelphiControl as TWinControl);
  Supports(f_DropTree, IevDropCalendar, l_Calendar);
  if l_Calendar = nil then
  begin
   l_Handle := f_SubTree.Handle;
   {$IfDef Nemesis}
   f_SubTree.Visible := False;
   {$EndIf Nemesis}
  end
  else
   l_Handle := f_Calendar.Handle;
  if f_ESCPressed then
  begin                       
   if l_Calendar = nil then
    f_DropTree.EscPressed
  end
  else
   f_DropTree.AfterHideControl;
  f_DropTree := nil;            
  if NeedFocus and l_Control.CanFocus then
   l_Control.SetFocus;
  SetWindowPos(l_Handle, HWND_NOTOPMOST, 0, 0, 0, 0,
   SWP_NOMOVE or SWP_NOSIZE or SWP_HIDEWINDOW or SWP_NOACTIVATE);
 end; //if f_DropTree <> nil then
//#UC END# *47CEA2A102E2_47D01F9801D8_impl*
end;//TevControlContainerEX.HideControl

function TevControlContainerEX.GetDropTreeNode(anIndex: Integer): InevSimpleNode;
//#UC START# *47CEA2B20111_47D01F9801D8_var*
//#UC END# *47CEA2B20111_47D01F9801D8_var*
begin
//#UC START# *47CEA2B20111_47D01F9801D8_impl*
 Result := f_SubTree.GetNode(anIndex);
//#UC END# *47CEA2B20111_47D01F9801D8_impl*
end;//TevControlContainerEX.GetDropTreeNode

function TevControlContainerEX.CheckControl(const aDropControl: IevDropControl): Boolean;
//#UC START# *47CEA2C30018_47D01F9801D8_var*
//#UC END# *47CEA2C30018_47D01F9801D8_var*
begin
//#UC START# *47CEA2C30018_47D01F9801D8_impl*
 Result := IevDropControl(f_StateControl) = aDropControl;
//#UC END# *47CEA2C30018_47D01F9801D8_impl*
end;//TevControlContainerEX.CheckControl

function TevControlContainerEX.GetControl: TControl;
 {* Возвращает контрол. }
//#UC START# *47CEA2D50381_47D01F9801D8_var*
var
 l_Calendar : IevDropCalendar;
//#UC END# *47CEA2D50381_47D01F9801D8_var*
begin
//#UC START# *47CEA2D50381_47D01F9801D8_impl*
 if (f_DropTree <> nil) then
 begin
  if Supports(f_DropTree, IevDropCalendar, l_Calendar) then
   try
    Result := f_Calendar;
   finally
    l_Calendar := nil;
   end//try..finally
  else
   Result := f_SubTree;
 end//f_DropTree <> nil
 else 
  Result := nil;  
//#UC END# *47CEA2D50381_47D01F9801D8_impl*
end;//TevControlContainerEX.GetControl

function TevControlContainerEX.Get_Tree: InevSimpleTree;
//#UC START# *47CEA320015D_47D01F9801D8get_var*
//#UC END# *47CEA320015D_47D01F9801D8get_var*
begin
//#UC START# *47CEA320015D_47D01F9801D8get_impl*
 Result := f_SubTree.TreeStruct;
//#UC END# *47CEA320015D_47D01F9801D8get_impl*
end;//TevControlContainerEX.Get_Tree

procedure TevControlContainerEX.Set_Tree(const aValue: InevSimpleTree);
//#UC START# *47CEA320015D_47D01F9801D8set_var*
//#UC END# *47CEA320015D_47D01F9801D8set_var*
begin
//#UC START# *47CEA320015D_47D01F9801D8set_impl*
 f_SubTree.TreeStruct := aValue; 
//#UC END# *47CEA320015D_47D01F9801D8set_impl*
end;//TevControlContainerEX.Set_Tree

procedure TevControlContainerEX.Set_Current(aValue: Integer);
//#UC START# *47CEA337008E_47D01F9801D8set_var*
//#UC END# *47CEA337008E_47D01F9801D8set_var*
begin
//#UC START# *47CEA337008E_47D01F9801D8set_impl*
 f_SubTree.Current := aValue;
//#UC END# *47CEA337008E_47D01F9801D8set_impl*
end;//TevControlContainerEX.Set_Current

function TevControlContainerEX.IsSameTreeRoot(const aRoot: InevNode): Boolean;
//#UC START# *47CEA34501A1_47D01F9801D8_var*
//#UC END# *47CEA34501A1_47D01F9801D8_var*
begin
//#UC START# *47CEA34501A1_47D01F9801D8_impl*
 Result := f_SubTree.TreeStruct.RootNode.IsSame(aRoot)
//#UC END# *47CEA34501A1_47D01F9801D8_impl*
end;//TevControlContainerEX.IsSameTreeRoot

procedure TevControlContainerEX.DropControlChanging;
//#UC START# *47CEA381035A_47D01F9801D8_var*
//#UC END# *47CEA381035A_47D01F9801D8_var*
begin
//#UC START# *47CEA381035A_47D01F9801D8_impl*
 f_SubTree.Changing;
//#UC END# *47CEA381035A_47D01F9801D8_impl*
end;//TevControlContainerEX.DropControlChanging

procedure TevControlContainerEX.DropControlChanged;
//#UC START# *47CEA38803AE_47D01F9801D8_var*
//#UC END# *47CEA38803AE_47D01F9801D8_var*
begin
//#UC START# *47CEA38803AE_47D01F9801D8_impl*
 f_SubTree.Changed;
//#UC END# *47CEA38803AE_47D01F9801D8_impl*
end;//TevControlContainerEX.DropControlChanged

function TevControlContainerEX.GetCurrentNode: InevSimpleNode;
//#UC START# *47CEA39402F8_47D01F9801D8_var*
//#UC END# *47CEA39402F8_47D01F9801D8_var*
begin
//#UC START# *47CEA39402F8_47D01F9801D8_impl*
 Result := f_SubTree.GetCurrentNode;
//#UC END# *47CEA39402F8_47D01F9801D8_impl*
end;//TevControlContainerEX.GetCurrentNode

function TevControlContainerEX.IsSimpleTree: Boolean;
//#UC START# *47CEA3A2030D_47D01F9801D8_var*
var
 l_Tree : InevTree;
//#UC END# *47CEA3A2030D_47D01F9801D8_var*
begin
//#UC START# *47CEA3A2030D_47D01F9801D8_impl*
 try 
  Result := (f_SubTree = nil) or 
   Supports(f_SubTree.TreeStruct, InevTree, l_Tree);
 finally
  l_Tree := nil;
 end;//try..finally
//#UC END# *47CEA3A2030D_47D01F9801D8_impl*
end;//TevControlContainerEX.IsSimpleTree

function TevControlContainerEX.Get_ESCPressed: Boolean;
//#UC START# *47CEA3AC032E_47D01F9801D8get_var*
//#UC END# *47CEA3AC032E_47D01F9801D8get_var*
begin
//#UC START# *47CEA3AC032E_47D01F9801D8get_impl*
 Result := f_ESCPressed;
//#UC END# *47CEA3AC032E_47D01F9801D8get_impl*
end;//TevControlContainerEX.Get_ESCPressed

procedure TevControlContainerEX.Set_ESCPressed(aValue: Boolean);
//#UC START# *47CEA3AC032E_47D01F9801D8set_var*
//#UC END# *47CEA3AC032E_47D01F9801D8set_var*
begin
//#UC START# *47CEA3AC032E_47D01F9801D8set_impl*
 f_ESCPressed := aValue;
//#UC END# *47CEA3AC032E_47D01F9801D8set_impl*
end;//TevControlContainerEX.Set_ESCPressed

procedure TevControlContainerEX.DoHideDroppedControl(CanSetFocus: Boolean);
//#UC START# *47CFF38902E1_47D01F9801D8_var*
//#UC END# *47CFF38902E1_47D01F9801D8_var*
begin
//#UC START# *47CFF38902E1_47D01F9801D8_impl*
 if CanSetFocus then
 begin
  if f_DropTree <> nil then
   HideControl(true);
 end  
 else  
  if not f_StartSize then
  begin
   if f_DropTree <> nil then
    HideControl(False);
  end;  
//#UC END# *47CFF38902E1_47D01F9801D8_impl*
end;//TevControlContainerEX.DoHideDroppedControl

function TevControlContainerEX.DoMouseWheel(aDown: Boolean): Boolean;
//#UC START# *47CFF3B803B0_47D01F9801D8_var*
//#UC END# *47CFF3B803B0_47D01F9801D8_var*
begin
//#UC START# *47CFF3B803B0_47D01F9801D8_impl*
 //Событие передается и календарю (ему оно не нужно) и выпадающему дереву.
 Result := IsDropTreeVisible;
 if Result then
  f_DropTree.MouseWheel(aDown);
//#UC END# *47CFF3B803B0_47D01F9801D8_impl*
end;//TevControlContainerEX.DoMouseWheel

function TevControlContainerEX.Get_DropTextStyle: Tl3StyleId;
//#UC START# *486CAA020214_47D01F9801D8get_var*
//#UC END# *486CAA020214_47D01F9801D8get_var*
begin
//#UC START# *486CAA020214_47D01F9801D8get_impl*
 Result := f_SubTree.StyleId;
//#UC END# *486CAA020214_47D01F9801D8get_impl*
end;//TevControlContainerEX.Get_DropTextStyle

procedure TevControlContainerEX.Set_DropTextStyle(aValue: Tl3StyleId);
//#UC START# *486CAA020214_47D01F9801D8set_var*
//#UC END# *486CAA020214_47D01F9801D8set_var*
begin
//#UC START# *486CAA020214_47D01F9801D8set_impl*
 f_SubTree.StyleId := aValue;
//#UC END# *486CAA020214_47D01F9801D8set_impl*
end;//TevControlContainerEX.Set_DropTextStyle

function TevControlContainerEX.Get_AllowEmptyCurrent: Boolean;
//#UC START# *4884573F021D_47D01F9801D8get_var*
//#UC END# *4884573F021D_47D01F9801D8get_var*
begin
//#UC START# *4884573F021D_47D01F9801D8get_impl*
 Result := f_SubTree.AllowWithoutCurrent;
//#UC END# *4884573F021D_47D01F9801D8get_impl*
end;//TevControlContainerEX.Get_AllowEmptyCurrent

procedure TevControlContainerEX.Set_AllowEmptyCurrent(aValue: Boolean);
//#UC START# *4884573F021D_47D01F9801D8set_var*
//#UC END# *4884573F021D_47D01F9801D8set_var*
begin
//#UC START# *4884573F021D_47D01F9801D8set_impl*
 f_SubTree.AllowWithoutCurrent := aValue;
//#UC END# *4884573F021D_47D01F9801D8set_impl*
end;//TevControlContainerEX.Set_AllowEmptyCurrent

procedure TevControlContainerEX.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47D01F9801D8_var*
//#UC END# *479731C50290_47D01F9801D8_var*
begin
//#UC START# *479731C50290_47D01F9801D8_impl*
 Application.UnhookMainWindow(FormatSettingsChange);
 f_DropTree := nil;
 if f_Calendar <> nil then
  f_Calendar.Parent := nil;
 l3Free(f_Calendar); 
 if f_SubTree <> nil then
 begin
  f_SubTree.OnGetItemImage := nil;
  f_SubTree.OnNeedCloseTree := nil;
  f_SubTree.OnChooseItem := nil;
  f_SubTree.OnStartResize := nil;
  f_SubTree.OnOwnerAssigned := nil;
  f_SubTree.OnEndResize := nil;
  f_SubTree.OnCurrentChanged := nil;
  f_SubTree.Parent := nil;
 end;//f_SubTree <> nil
 l3Free(f_SubTree);
 inherited;
//#UC END# *479731C50290_47D01F9801D8_impl*
end;//TevControlContainerEX.Cleanup

constructor TevControlContainerEX.Create;
//#UC START# *47CFF63F02B6_47D01F9801D8_var*
//#UC END# *47CFF63F02B6_47D01F9801D8_var*
begin
//#UC START# *47CFF63F02B6_47D01F9801D8_impl*
 inherited;
 f_Calendar := TevDropCalendar.Create(nil);
 f_SubTree := TevDropTree.Create(nil);
 f_SubTree.UseStyleTable := True;
 f_ESCPressed := False;
 Application.HookMainWindow(FormatSettingsChange);
//#UC END# *47CFF63F02B6_47D01F9801D8_impl*
end;//TevControlContainerEX.Create

function TevControlContainerEX.DoGetNode(anIndex: Integer): InevSimpleNode;
//#UC START# *47D010D10193_47D01F9801D8_var*
var
 l_Combo : IevDropCombo;
//#UC END# *47D010D10193_47D01F9801D8_var*
begin
//#UC START# *47D010D10193_47D01F9801D8_impl*
 if (f_DropTree <> nil) and 
   (Supports(f_DropTree, IevDropCombo, l_Combo)) then
  try
   Result := l_Combo.GetNode(anIndex)
  finally
   l_Combo := nil;
  end 
 else 
  Result := nil; 
//#UC END# *47D010D10193_47D01F9801D8_impl*
end;//TevControlContainerEX.DoGetNode

procedure TevControlContainerEX.DoDeleteOnUndo(aTag: Tl3Tag);
//#UC START# *47D0111400DC_47D01F9801D8_var*
//#UC END# *47D0111400DC_47D01F9801D8_var*
begin
//#UC START# *47D0111400DC_47D01F9801D8_impl*
 f_ESCPressed := True;
 HideControl(true); 
 f_ESCPressed := False;
 inherited;
//#UC END# *47D0111400DC_47D01F9801D8_impl*
end;//TevControlContainerEX.DoDeleteOnUndo

procedure TevControlContainerEX.DoChangePara(const aCurPara: InevPara);
//#UC START# *47D011870105_47D01F9801D8_var*
var
 l_CalEdit    : IevEditorCalendarField;
 l_OldControl : IevEditorControl;
 l_NewControl : IevEditorControl;
//#UC END# *47D011870105_47D01F9801D8_var*
begin
//#UC START# *47D011870105_47D01F9801D8_impl*
 if (f_CurrPara <> nil) then
  f_CurrPara.AsObject.QT(IevEditorControl, l_OldControl);
 if (aCurPara <> nil) then
  aCurPara.AsObject.QT(IevEditorControl, l_NewControl);
 if Assigned(l_NewControl) and Assigned(l_OldControl) and Supports(l_NewControl, IevEditorPhoneField) then
  l_OldControl.Para.OwnerPara.Invalidate([]);
 if (l_OldControl <> nil) and
   Supports(l_OldControl, IevEditorCalendarField, l_CalEdit) then
  if not l_CalEdit.IsFieldEmpty then 
   l_CalEdit.aDate := l_CalEdit.aDate//"Расширение" года - делаем год 4-х значным!
  else  
   l_CalEdit.AnalyzeText;//"Расширение" года, если введены только день и месяц!
 if (l_NewControl <> nil) then
   if Supports(l_NewControl, IevEditorCalendarField, l_CalEdit) then
  begin 
   if not l_CalEdit.IsStart and l_CalEdit.IsFieldEmpty and not l_CalEdit.GetOtherField.IsFieldEmpty then 
    l_CalEdit.aDate := l_CalEdit.GetOtherField.aDate;
  end;
 if (f_DropTree <> nil) and (f_CurrPara <> nil) then
  if aCurPara.AsObject.IsKindOf(k2_typLeafPara) then
   if not f_CurrPara.AsObject.IsSame(aCurPara.AsObject) then
    HideControl(true);
 inherited;  
//#UC END# *47D011870105_47D01F9801D8_impl*
end;//TevControlContainerEX.DoChangePara

function TevControlContainerEX.DoKeyDown(const aView: InevView;
 var Msg: TWMKeyDown;
 aCurPara: Tl3Tag): Boolean;
 {* Посылка сообщений о нажатии клавиш. }
//#UC START# *47D0135901AC_47D01F9801D8_var*
var
 l_Calendar    : IevDropCalendar;
 l_Combo       : IevDropCombo;
 l_SS          : TShiftState;
 l_CurrentNode : InevSimpleNode;
 l_Control     : IevEditorFieldWithTree;
 l_Focused     : IevEditorControl;
 l_Idx: Integer;
 l_BTNControl : IevEditorControlButton;
 l_FocusedField: IevEditorControlField;
//#UC END# *47D0135901AC_47D01F9801D8_var*
begin
//#UC START# *47D0135901AC_47D01F9801D8_impl*
 Result := inherited DoKeyDown(aView, Msg, aCurPara);
 if (Msg.CharCode = VK_RETURN) and l3System.Keyboard.Key[VK_CONTROL].Down and
   l3System.Keyboard.Key[VK_MENU].Down then
 begin
  Msg.CharCode := 0;
  Msg.Result := 1;
  Result := True;
  Exit;
 end;
 if (Msg.CharCode = VK_RETURN) and l3System.Keyboard.Key[VK_SHIFT].Down then
 begin
  l_Focused := GetFocusedControl(aCurPara);
  if (l_Focused <> nil) and (l_Focused.ControlType = ev_ctCombo) and
    not IsDropTreeVisible and Supports(l_Focused, IevEditorControlField, l_FocusedField) then
  with l_FocusedField do
   for l_Idx := ChildList.Count-1 downto 0 do
    if Supports(ChildList[l_Idx], IevEditorControlButton, l_BTNControl) and
       (l_BTNControl.GetButtonType = ev_btAdd) then
  begin
   if l_BTNControl.Visible then
   begin
    l_Focused.InsertRow(aView);
    Result := True;
   end;
   Break;
  end;
 end
 else 
  if not Result then 
  begin
   Result := IsDropTreeVisible;
   if Result then
   begin
    if Supports(f_DropTree, IevDropCalendar, l_Calendar) then
     try 
      Result := False;//А зачем нам говорить, что клавиша обработана, если 
       //это может быть не так?
      l_SS := KeyDataToShiftState(Msg.KeyData);
      if l_SS = [] then
       if (Msg.CharCode = VK_UP) or (Msg.CharCode = VK_DOWN) or
          (Msg.CharCode = VK_PRIOR) or (Msg.CharCode = VK_NEXT) or
          (Msg.CharCode = VK_END) or (Msg.CharCode = VK_LEFT) or
          (Msg.CharCode = VK_RIGHT) or (Msg.CharCode = VK_HOME) then 
       begin
        f_Calendar.DoKeyDown(Msg.CharCode, l_SS);
        Msg.CharCode := 0;
        Msg.Result := 0;
        Result := True;
       end;
      if (Msg.CharCode = VK_ADD) then 
      begin
       l_Calendar.ApplyDate(f_Calendar.Date + 1);
       Msg.CharCode := 0;
       Msg.Result := 1;
       Result := True;
      end;
      if (Msg.CharCode = VK_SUBTRACT) then 
      begin
        l_Calendar.ApplyDate(f_Calendar.Date - 1);
        Msg.CharCode := 0;
        Msg.Result := 1;
        Result := True;
      end;
      if (Msg.CharCode = Ord('t')) or (Msg.CharCode = Ord('T'))
       or (Msg.CharCode = Ord('e')) or (Msg.CharCode = Ord('E')) then 
      begin
       l_Calendar.ApplyDate(Trunc(Now));
       Msg.CharCode := 0;
       Msg.Result := 1;
       Result := True;
      end;
      if (Msg.CharCode = VK_ESCAPE) then
      begin
       l_Calendar.CancelDate(f_Calendar);
       Result := True;
      end;
      if (Msg.CharCode = VK_RETURN) then
      begin
       l_Calendar.ChooseDate(f_Calendar);
       Result := True;
      end;
     finally 
      l_Calendar := nil;
     end
     else
      if Supports(f_DropTree, IevDropCombo, l_Combo) then
      try 
       Result := False;//А зачем нам говорить, что клавиша обработана, если 
       //это может быть не так?
       l_SS := KeyDataToShiftState(Msg.KeyData);
       if l_SS = [] then
        if ((Msg.CharCode = VK_UP) or (Msg.CharCode = VK_DOWN) or
         (Msg.CharCode = VK_PRIOR) or (Msg.CharCode = VK_NEXT) or
         (Msg.CharCode = VK_RETURN)) then
        begin
         if Msg.CharCode = VK_RETURN then
          l_Combo.ChooseNode(f_SubTree.GetCurrentNode);
         Msg.Msg := CN_KEYDOWN;
         f_SubTree.WindowProc(TMessage(Msg));
         Result := True;
        end//if ((Msg.CharCode = VK_UP)...
        else
         if (Msg.CharCode = VK_ESCAPE) then
         begin
          f_ESCPressed := True;
          HideControl(true);
          f_ESCPressed := False;
          if Supports(l_Combo, IevEditorFieldWithTree, l_Control) then
           if not l_Control.Valid or l_Control.NeedClearOnEscape then
           begin
            l_Control.SetFocus;
            l_Control.Text := nil;
           end;
          Result := True;
         end
         else
          if not l_Combo.IsList and ((Msg.CharCode = VK_ADD) 
           or (Msg.CharCode = VK_SUBTRACT)) then
          begin
           Result := True;
           if (f_SubTree.GetCurrentNode <> nil) then 
           begin
            if Msg.CharCode = VK_ADD then
             { нажали "+" }
             f_SubTree.ExpandNode(f_SubTree.GetCurrentNode, true)
            else 
            begin
             { нажали "-" }
             if f_SubTree.GetCurrentNode.HasChild then
              f_SubTree.ExpandNode(f_SubTree.GetCurrentNode, false)
             else 
             begin
              l_CurrentNode := f_SubTree.GetCurrentNode;
              try
               if Assigned(l_CurrentNode) and Assigned(l_CurrentNode.Parent) and
                 not l_CurrentNode.Parent.IsSame(f_SubTree.TreeStruct.RootNode) then
                begin
                 f_SubTree.ExpandNode(l_CurrentNode.Parent, False);
                 f_SubTree.GotoOnNode(l_CurrentNode);
                end;
              finally
               l_CurrentNode := nil;
              end;
             end;//if f_SubTree.GetCurrentNode.HasChild then ... else
            end;//if (f_SubTree.GetCurrentNode <> nil) then ... else 
           end;//if (f_SubTree.GetCurrentNode <> nil) then 
           Msg.CharCode := 0;
           Msg.Result := 1;
          end;//if not IsList and ((Msg.CharCode = VK_ADD)...
      finally 
       l_Combo := nil;
      end;
   end;//if Result then 
  end;// if not Result 
//#UC END# *47D0135901AC_47D01F9801D8_impl*
end;//TevControlContainerEX.DoKeyDown

end.
