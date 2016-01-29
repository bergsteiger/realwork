unit vcmUtils;

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmUtils -      }
{ Начат: 24.11.2003 16:35 }
{ $Id: vcmUtils.pas,v 1.48 2015/10/19 13:53:56 kostitsin Exp $ }

// $Log: vcmUtils.pas,v $
// Revision 1.48  2015/10/19 13:53:56  kostitsin
// рисуем TvcmBaseOperationsCollectionItem
//
// Revision 1.47  2014/04/01 12:28:10  kostitsin
// {requestlink: 259894118 }
//
// Revision 1.46  2014/02/18 17:31:10  lulin
// - подготавливаемся к обобщению словарей.
//
// Revision 1.45  2013/10/14 14:20:44  kostitsin
// [$377169452] - Registration
//
// Revision 1.44  2012/07/11 18:25:09  lulin
// {RequestLink:237994598}
//
// Revision 1.43  2012/06/07 10:34:51  kostitsin
// vcmMakeControlAction
//
// Revision 1.42  2012/04/09 08:38:54  lulin
// {RequestLink:237994598}
// - думаем о VGScene.
//
// Revision 1.41  2012/04/06 13:19:58  lulin
// {RequestLink:237994598}
//
// Revision 1.40  2012/04/05 19:44:24  lulin
// {RequestLink:237994598}
//
// Revision 1.39  2010/03/05 06:24:15  oman
// Убираем Magic Const
//
// Revision 1.38  2009/10/20 13:05:39  oman
// - fix: {RequestLink:167346473}
//
// Revision 1.37  2009/09/24 12:20:07  lulin
// - модуль Установки полностью перенесён на модель.
//
// Revision 1.36  2009/08/20 17:19:02  lulin
// {RequestLink:159360595}.
//
// Revision 1.35  2009/07/29 06:56:41  oman
// - new: {RequestLink:158336069}
//
// Revision 1.34  2009/02/20 17:29:18  lulin
// - чистка комментариев.
//
// Revision 1.33  2009/02/20 15:18:56  lulin
// - <K>: 136941122.
//
// Revision 1.32  2009/02/20 13:07:04  lulin
// - <K>: 136941122.
//
// Revision 1.31  2009/01/30 07:59:24  lulin
// - <K>: 122674504.
//
// Revision 1.30  2007/06/27 12:15:49  mmorozov
// - format code;
//
// Revision 1.29  2007/05/25 14:52:16  mmorozov
// - change: изменения связанные с использованием операции типа дата (vcm_otDate) в панели задач (CQ: OIT5-25342);
//
// Revision 1.28  2007/04/10 13:20:08  lulin
// - используем строки с кодировкой.
//
// Revision 1.27  2007/03/16 14:47:23  lulin
// - cleanup.
//
// Revision 1.26  2007/01/20 18:45:51  lulin
// - запрещаем модифицировать код операции.
//
// Revision 1.25  2007/01/20 15:31:07  lulin
// - разделяем параметры операции для выполнения и для тестирования.
//
// Revision 1.24  2007/01/19 11:53:20  lulin
// - данные переехали с общих параметров на более специализированные.
//
// Revision 1.23  2006/07/19 13:41:26  mmorozov
// - new behaviour: если пользователь закрыл любую форму при количестве форм больше одной, то новые формы будут складываться ровно в это место (не каскадом), т.е. они будут прятаться одна за другой (CQ: OIT500021545);
//
// Revision 1.22  2006/07/06 11:52:37  mmorozov
// - _format code;
//
// Revision 1.21  2006/05/23 11:55:11  oman
// - fix: При вызове хелпа для модульных операциях искали их среди сущностных (cq21033)
//
// Revision 1.20  2006/04/06 12:05:16  mmorozov
// - bugfix: при определении монитора вместо положения курсора используем положение активной главной формы (CQ: 20342);
//
// Revision 1.19  2006/03/29 12:03:41  lulin
// - вычищены "причины".
//
// Revision 1.18  2006/03/10 08:01:57  mmorozov
// - new behaviour: установленность событий у элемента коллекции определяем с помощь RTTI;
//
// Revision 1.17  2006/01/20 11:33:08  mmorozov
// 1. Нельзя было на панель инструментов положить неколько операций из разных сущностей с одинаковыми именами;
// 2. Если в панели инструментов встречаются операции с одинаковыми названиями, то им автоматически добавляется суффикс в виде названия сущности;
// 3. Появилась возможность указать, что контекстные операции сущности должны показываться в отдельном пункте меню;
// 3.
//
// Revision 1.16  2005/10/21 14:23:42  mmorozov
// change: переименована функция;
//
// Revision 1.15  2005/10/17 13:50:00  mmorozov
// bugfix: vcmIsFormSet для случаев когда у бизнес объекта формы нет БОС;
//
// Revision 1.14  2005/09/22 11:06:00  mmorozov
// - работа с историей в контексте сборок;
//
// Revision 1.13  2005/08/25 12:52:29  lulin
// - new behavior: по возможности используем не имена, а индексы форм.
//
// Revision 1.12  2005/08/25 09:15:42  mmorozov
// new: function vcmIsUnknownReason;
//
// Revision 1.11  2005/08/09 10:45:56  mmorozov
// new: операции сравнения;
//
// Revision 1.10  2005/07/14 16:39:42  lulin
// - new behavior: в run-time получаем ID сущности и модуля по их имени из информации, содержащейся в MenuManager'е.
//
// Revision 1.9  2005/06/27 06:58:23  mmorozov
// change: сигнатура _vcmMakeControlAction;
//
// Revision 1.8  2005/06/22 06:33:29  mmorozov
// new: global procedure _vcmMakeControlAction;
//
// Revision 1.7  2004/11/23 10:27:21  am
// new function: _vcmGetHelpKeyword - перетащил из vcmEntityForm
//
// Revision 1.6  2004/11/18 17:33:58  lulin
// - new interface: IvcmParamsPrim.
//
// Revision 1.5  2004/11/16 14:48:57  mmorozov
// new: global procedure vcmCorrectWindowBounds;
//
// Revision 1.4  2004/10/07 14:16:58  lulin
// - new: теперь у _IvcmParams можно присваивать только свойство DoneStatus - код завершения. На основе этого "по-хитрому" обрабатываем ShortCut'ы для запрещенных операций (CQ OIT5-10123).
//
// Revision 1.3  2004/09/22 09:34:29  lulin
// - оптимизщация - кешируем результат преобразования Name -> ID при посылке операций.
//
// Revision 1.2  2004/06/29 10:47:53  mmorozov
// new: global function vcmCheckWindowBounds;
//
// Revision 1.1  2003/11/24 14:14:08  law
// - new unit: vcmUtils.
// - new prop: _vcmToAggregate.
//

{$Include vcmDefine.inc }

interface

uses
  Types,
  Messages,
  Menus,
  Controls,
  Windows,
  Classes,
  Forms,

  l3Interfaces,

  vcmUserControls,
  vcmExternalInterfaces,
  vcmInterfaces,
  vcmEntityForm
  ;

{--- Общие --------------------------------------------------------------------}
function vcmHasSetEvent(const aInstance: TObject): Boolean;
  {* - определяет установлено ли у компонента хотя бы одно событие. }
function vcmSelectDate(const aDialogCaption : Il3CString;
                       const aDate          : Il3CString): Il3CString;
  {* - функция показывает диалог выбора даты. Результат создаётся всегда, если
       пользователь отказался от выбора даты после показа диалога строка
       содержит пустое значение. }

{--- Операции -----------------------------------------------------------------}
procedure vcmMakeControlAction(aControl             : TWinControl;
                               const aEntityName    : String;
                               const aOperationName : String); overload;
  {* - связывает компонент с Action. }
procedure vcmMakeControlAction(const aControl       : IvcmComponentWithAction;
                               const aEntityName    : String;
                               const aOperationName : String); overload;
  {* - связывает компонент с Action. }
function vcmMakeCaption(const anEntityDef : IvcmEntityDef;
                        const anOpDef     : IvcmOperationDef): IvcmCString;
  {* - получить название операции. }

{--- Сборки -------------------------------------------------------------------}
function vcmInFormSet(const aDataSource : IvcmFormDataSource;
                      const theFormSet  : PIvcmFormSet = nil): Boolean;
  {* - определяет есть ли объекта сборка, если есть. то возвращает. }

{-- Окна ----------------------------------------------------------------------}
function vcmCheckWindowBounds(const aBounds : TRect) : TRect;
  {* - проверяет, что границы aBounds не выходят за пределы экрана и
       корректирует их при необходимости. }
procedure vcmCorrectWindowBounds(aForm: TvcmEntityForm);
  {* - корректирует размер формы, если он больше экрана. }
procedure vcmDropConstraints(const aForm : TCustomForm);
  {* - нормализует окно, снимает Constraints. }

{--- Система справки ----------------------------------------------------------}
function vcmGetHelpKeyword(HelpInfo: PHelpInfo; aMenu, aPopupMenu: TMenu): String;
  {-}
function vcmByteShift(aShift: TShiftState): Byte;

implementation

uses
  SysUtils,
  ActnList,
  TypInfo,

  vcmBase,
  vcmAction,
  vcmRepositoryEx,
  vcmEntityAction,
  vcmEntitiesCollectionItem,
  vcmOperationsCollectionItem,
  vcmCalendarForm,
  vcmInternalConst,

  vcmOVCCommands,
  OvcCmd
  ;

function vcmSelectDate(const aDialogCaption : Il3CString;
                       const aDate          : Il3CString): Il3CString;
  {* - функция показывает диалог выбора даты. Результат создаётся всегда, если
       пользователь отказался от выбора даты после показа диалога строка
       содержит пустое значение. }
var
 l_Form : TvcmCalendarForm;

 procedure lp_SetFormPos;
 var
  l_Height : Integer;
  l_Delta  : Integer;
 begin
  l_Height := GetSystemMetrics(SM_CYCAPTION);
  l_Delta := l_Height div 2;
  // Установим форму там где находится курсор:
  with l_Form do
   SetBounds(Mouse.CursorPos.X - l_Delta,
             Mouse.CursorPos.Y - l_Delta,
             Width,
             Height);
 end;//lp_SetFormPos

 function lp_MakeOwner: TComponent;
 begin
  if (g_Dispatcher <> nil) and
     (g_Dispatcher.FormDispatcher <> nil) and
     (g_Dispatcher.FormDispatcher.CurrentMainForm <> nil) then
   Result := g_Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl
  else
   Result := nil;
 end;//lp_HasCurrentMainForm

begin
 l_Form := TvcmCalendarForm.CreateNew(lp_MakeOwner);
 try
  lp_SetFormPos;
  with l_Form do
  begin
   Caption := vcmStr(aDialogCaption);
   DateText := vcmStr(aDate);
   if ShowModal = mrOk then
    Result := vcmCStr(l_Form.DateText)
   else
    Result := vcmCStr('');
  end;//with l_Form do
 finally
  FreeAndNil(l_Form);
 end;//try..finally
end;//vcmSelectDate

function vcmHasSetEvent(const aInstance: TObject): Boolean;
  {* - определяет установлено ли у компонента хотя бы одно событие. }
var
 l_List     : PPropList;
 l_Prop     : PPropInfo;
 l_AllCount : Integer;
 l_Count    : Integer;
 l_Index    : Integer;
begin
 Result := False;
 l_AllCount := GetTypeData(aInstance.ClassInfo)^.PropCount;
 GetMem(l_List, l_AllCount * SizeOf(Pointer));
 try
   l_Count := GetPropList(aInstance.ClassInfo, [tkMethod], l_List);
   for l_Index := 0 to l_Count - 1 do
   begin
     l_Prop := l_List^[l_Index];
     if l_Prop = nil then
       Break;
     if GetMethodProp(aInstance, l_Prop).Code <> nil then
     begin
      Result := True;
      Break;
     end;//if GetMethodProp(l_Prop).Code <> nil then
   end;//for l_Index := 0 to l_Count - 1 do
 finally
   FreeMem(l_List, l_AllCount * SizeOf(Pointer));
 end;{try..finally}
end;//vcmHasSetEvent

function vcmInFormSet(const aDataSource : IvcmFormDataSource;
                      const theFormSet  : PIvcmFormSet = nil): Boolean;
  {* - определяет есть ли объекта сборка, если есть. то возвращает. }
begin
 if Assigned(theFormSet) then
  theFormSet^ := nil;
 Result := Assigned(aDataSource) and Assigned(aDataSource.UseCaseController) and
  Assigned(aDataSource.UseCaseController.FormSet);
 if Result and Assigned(theFormSet) then
  theFormSet^ := aDataSource.UseCaseController.FormSet;
end;

function vcmMakeCaption(const anEntityDef : IvcmEntityDef;
                        const anOpDef     : IvcmOperationDef): IvcmCString;
  {* - получить название операции. }
begin
 Result := nil;
 if Assigned(anOpDef) then
  Result := anOpDef.Caption;
 if Assigned(anEntityDef) and not anOpDef.IsCaptionUnique then
  Result := vcmFmt('%s /%s/', [anOpDef.Caption, anEntityDef.Caption]);
end;//vcmMakeCaption

procedure vcmMakeControlAction(aControl             : TWinControl;
                               const aEntityName    : String;
                               const aOperationName : String);
  {* - связывает компонент с Action. }
var
 l_Form       : TComponent;
 l_Entity     : TvcmEntitiesCollectionItem;
 l_Operation  : TvcmOperationsCollectionItem;
 l_EntityForm : IvcmEntity;
 l_Action     : TvcmAction;
begin
 if (aEntityName <> '') and (aOperationName <> '') then
 begin
  // Форма компонента
  l_Form := GetParentForm(aControl);
  if not Assigned(l_Form) or (aControl = l_Form) then
   l_Form := aControl.Owner;

  Assert(Assigned(l_Form) and (l_Form is TvcmEntityForm));

  if Assigned(l_Form) and (l_Form is TvcmEntityForm) then
  begin
   // Сущность
   l_Entity := nil;
   if (TvcmEntityForm(l_Form).Entities <> nil) AND
      (TvcmEntityForm(l_Form).Entities.Entities <> nil) then
    l_Entity := TvcmEntitiesCollectionItem(TvcmEntityForm(l_Form).Entities.Entities.FindItemByName(aEntityName));
   if Assigned(l_Entity) then
   begin
    // Операция
    l_Operation := TvcmOperationsCollectionItem(l_Entity.Operations.FindItemByName(aOperationName));
    // Action
    if Assigned(l_Operation) and Supports(l_Form, IvcmEntity, l_EntityForm) then
    try
     l_Entity.SupportedBy[aControl] := true;
     l_Action := TvcmActiveEntityActionEx.Create(aControl,
                                                l_EntityForm,
                                                l_Entity.EntityDef,
                                                l_Operation.OperationDef);
     // Если компонент при создании невидимый, то чтобы не происходило
     // перемиргивания инициализируем Action видимостью по умолчанию.
     l_Action.Visible := aControl.Visible;
     aControl.Action := l_Action;
    finally
     l_EntityForm := nil;
    end;//try..finally
   end;//Assigned(l_Entity)
  end;//Assigned(l_Form) and (l_Form is TvcmEntityForm)
 end;//(aEntityName <> '') and (aOperationName <> '')
end;

procedure vcmMakeControlAction(const aControl       : IvcmComponentWithAction;
                               const aEntityName    : String;
                               const aOperationName : String); overload;
var
 l_Form       : TComponent;
 l_Entity     : TvcmEntitiesCollectionItem;
 l_Operation  : TvcmOperationsCollectionItem;
 l_EntityForm : IvcmEntity;
 l_Action     : TvcmAction;
begin
 if (aEntityName <> '') and (aOperationName <> '') then
 begin
  // Форма компонента
  l_Form := aControl.GetParentForm;
  if not Assigned(l_Form) or (aControl.GetComponent = l_Form) then
   l_Form := aControl.GetComponent.Owner;

  Assert(Assigned(l_Form) and (l_Form is TvcmEntityForm));

  if Assigned(l_Form) and (l_Form is TvcmEntityForm) then
  begin
   // Сущность
   l_Entity := nil;
   if (TvcmEntityForm(l_Form).Entities <> nil) AND
      (TvcmEntityForm(l_Form).Entities.Entities <> nil) then
    l_Entity := TvcmEntitiesCollectionItem(TvcmEntityForm(l_Form).Entities.Entities.FindItemByName(aEntityName));
   if Assigned(l_Entity) then
   begin
    // Операция
    l_Operation := TvcmOperationsCollectionItem(l_Entity.Operations.FindItemByName(aOperationName));
    // Action
    if Assigned(l_Operation) and Supports(l_Form, IvcmEntity, l_EntityForm) then
    try
     l_Entity.SupportedBy[aControl.GetComponent] := true;
     l_Action := TvcmActiveEntityActionEx.Create(aControl.GetComponent,
                                                l_EntityForm,
                                                l_Entity.EntityDef,
                                                l_Operation.OperationDef);
     // Если компонент при создании невидимый, то чтобы не происходило
     // перемиргивания инициализируем Action видимостью по умолчанию.
     l_Action.Visible := aControl.Visible;
     aControl.Action := l_Action;
    finally
     l_EntityForm := nil;
    end;//try..finally
   end;//Assigned(l_Entity)
  end;//Assigned(l_Form) and (l_Form is TvcmEntityForm)
 end;//(aEntityName <> '') and (aOperationName <> '')
end;

procedure vcmDropConstraints(const aForm : TCustomForm);
  {* - нормализует окно, снимает Constraints. }
begin
 with aForm, Constraints do
 begin
  WindowState := wsNormal;
  MinHeight := 0;
  MinWidth  := 0;
  MaxHeight := 0;
  MaxWidth  := 0;
 end;
end;

procedure vcmCorrectWindowBounds(aForm: TvcmEntityForm);
var
 l_Rect : TRect;
 l_Desk : TRect;

 function lp_CheckHeight: Boolean;
 begin
  Result := not ((l_Rect.Bottom - l_Rect.Top) > (l_Desk.Bottom - l_Desk.Top));
 end;//lp_CheckHeight

 function lp_CheckWidth: Boolean;
 begin
  Result := not ((l_Rect.Right - l_Rect.Left) > (l_Desk.Right - l_Desk.Left));
 end;//lp_CheckWidth

begin
 if aForm.ZoneType in vcm_NotContainedForm then
 begin
  // Главная форма нам нужна для определения монитора:
  if (g_Dispatcher = nil) then
   Exit;
  if not Assigned(g_Dispatcher.FormDispatcher.CurrentMainForm) then
   Exit;
  l_Rect := vcmCheckWindowBounds(aForm.BoundsRect);
  l_Desk := Screen.MonitorFromRect(g_Dispatcher.FormDispatcher.CurrentMainForm.
   VCLWinControl.BoundsRect).WorkareaRect;
  case aForm.BorderStyle of
   // форма с изменяемыми размерами
   bsSizeable, bsToolWindow:
   begin
    // по высоте больше рабочего стола
    if not lp_CheckHeight then
    begin
     l_Rect.Top := l_Desk.Top;
     l_Rect.Bottom := l_Desk.Bottom;
    end;
    // по ширине больше рабочего стола
    if not lp_CheckWidth then
    begin
     l_Rect.Left := l_Desk.Left;
     l_Rect.Right := l_Desk.Right;
    end;
    // установим размеры формы
    aForm.BoundsRect := l_Rect;
   end;//bsSizeable, bsToolWindow:
   // форма с не изменяемыми размерами, масштабируем
   else
   begin
    while not lp_CheckHeight or not lp_CheckWidth do
    begin
     aForm.ScaleBy(9, 10);
     l_Rect.Right := l_Rect.Left + aForm.Width;
     l_Rect.Bottom := l_Rect.Top + aForm.Height;
    end;//while not lp_CheckHeight or not lp_CheckWidth do
   end;//else
  end;//case aForm.BorderStyle of
 end;
end;

function vcmCheckWindowBounds(const aBounds : TRect) : TRect;
  {* - проверяет, что границы aBounds не выходят за пределы экрана и
       корректирует их при необходимости. }
var
 lWidth  : Integer;
 lHeight : Integer;
 lMRect  : TRect;
begin
 Result := aBounds;
 lWidth := Abs(aBounds.Right - aBounds.Left);
 lHeight := Abs(aBounds.Bottom - aBounds.Top);
 // выходит за пределы экрана слева
 if Result.Left < Screen.DesktopRect.Left then
  Result.Left := Screen.DesktopRect.Left;
 // выходит за пределы экрана справа
 if ((Result.Left + lWidth) > Screen.DesktopRect.Right) then
  Result.Left := Screen.DesktopRect.Right - lWidth;

 // определим монитор, на котором размещено окно
 lMRect := Screen.MonitorFromPoint(Point(Result.Left, Result.Top)).WorkareaRect;

 // выходит за пределы экрана снизу
 if (Result.Top + lHeight) > lMRect.Bottom then
  Result.Top := lMRect.Bottom - lHeight;
 // выходит за пределы экрана сверху
 if (Result.Top < lMRect.Top) then
  Result.Top := lMRect.Top;

 // определим правую и нижнюю границу
 Result.Right := Result.Left + lWidth;
 Result.Bottom := Result.Top + lHeight;
end;

function vcmGetHelpKeyword(HelpInfo: PHelpInfo; aMenu, aPopupMenu: TMenu): string;

  function GetMenuHelpContext(Menu: TMenu): Integer;
  begin//GetMenuHelpContext
    Result := 0;
    if Menu = nil then Exit;
    Result := Menu.GetHelpContext(HelpInfo.iCtrlID, True);
    if Result = 0 then
      Result := Menu.GetHelpContext(HelpInfo.hItemHandle, False);
  end;//GetMenuHelpContext

  function ControlHasHelp(const Control: TWinControl) : Boolean;
  begin
    Result := false;
    if (Control.HelpType = htContext) and (Control.HelpContext <> 0)
      then Result := true
    else if (Control.HelpType = htKeyword) and (Control.HelpKeyword <> '') then
      Result := true;
  end;

  procedure GetHelpInfo(const Control: TWinControl; var HType: THelpType; var ContextID: Integer; var Keyword: String);
  begin
    if Control.HelpType = htContext then
    begin
      HType := htContext;
      ContextID := Control.HelpContext;
    end else
    begin
      HType := htKeyword;
      Keyword := Control.HelpKeyword;
    end;
  end;
  
var
 l_HType     : THelpType;
 l_ContextID : Integer;
 l_Control   : TWinControl;

begin
  l_ContextID := 0;
  with HelpInfo^ do
  begin
   if (iContextType = HELPINFO_WINDOW) then
   begin
    l_Control := FindControl(hItemHandle);
    while (l_Control <> nil) and ( not ControlHasHelp(l_Control)) do
      l_Control := l_Control.Parent;
    if (l_Control = nil) then Exit;
    GetHelpInfo(l_Control, l_HType, l_ContextID, Result);
   end//iContextType = HELPINFO_WINDOW
   else  { Message.HelpInfo.iContextType = HELPINFO_MENUITEM }
   begin
    l_HType := htContext;
    if aMenu <> nil then
     l_ContextID := GetMenuHelpContext(aMenu);
    if (l_ContextID = 0) and (aPopupMenu <> nil)  then
     l_ContextID := GetMenuHelpContext(aPopupMenu);
   end;//iContextType = HELPINFO_WINDOW
  end;//with Message.HelpInfo^
  if (l_HType = htContext) and (l_ContextID > 0) then
  begin
   with vcmCommandInfo(l_ContextID) do
    if rIsModule then
    begin
     Result := vcmGetNameByID(vcm_repModule, rItemID)
                  + '-' +
                  vcmGetNameByID(vcm_repOperation, rOperationID, -rItemID);
    end//vcmIsModuleCommandID(l_ContextID)
    else
    begin
     Result := vcmGetNameByID(vcm_repEntity, rItemID)
                  + '-' +
                  vcmGetNameByID(vcm_repOperation, rOperationID, rItemID);
    end;//vcmIsModuleCommandID(l_ContextID)
  end;//l_HType = htContext

end;

function vcmByteShift(aShift: TShiftState): Byte;
begin
 result := OvcByteShift(aShift);
end;

end.

