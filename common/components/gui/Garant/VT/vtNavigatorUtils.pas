unit vtNavigatorUtils;

(*-----------------------------------------------------------------------------
 Название:   npUtils
 Автор:      М. Морозов
 Назначение:
 История:

 $Id: vtNavigatorUtils.pas,v 1.23 2015/09/04 13:51:07 kostitsin Exp $

 $Log: vtNavigatorUtils.pas,v $
 Revision 1.23  2015/09/04 13:51:07  kostitsin
 {requestlink: 606434039 }

 Revision 1.22  2015/04/21 11:41:09  morozov
 {RequestLink: 595974185}

 Revision 1.21  2015/04/02 07:25:35  morozov
 {RequestLink: 595963346}

 Revision 1.20  2015/03/31 16:47:54  lulin
 - правим руками для NoTabs.

 Revision 1.19  2015/03/31 16:41:05  lulin
 - правим руками для NoTabs.

 Revision 1.18  2015/03/31 16:39:54  lulin
 - правим руками для NoTabs.

 Revision 1.17  2015/01/30 11:29:31  morozov
 {RequestLink: 587161831}

 Revision 1.16  2014/12/04 12:15:53  morozov
 {RequestLink: 570120392}

 Revision 1.15  2014/11/10 09:04:36  morozov
 {RequestLink: 570120392}

 Revision 1.14  2014/08/11 12:12:30  morozov
 {RequestLink: 554580040}

 Revision 1.13  2014/08/11 11:57:01  morozov
 {RequestLink: 554580040}

 Revision 1.12  2014/01/16 11:00:56  morozov
 {RequestLink: 508187704}

 Revision 1.11  2014/01/15 09:37:49  morozov
 {RequestLink: 508187704}

 Revision 1.10  2014/01/10 16:24:52  kostitsin
 [$510593012]

 Revision 1.9  2009/07/29 06:59:02  oman
 - new: {RequestLink:158336069}

 Revision 1.8  2009/07/29 06:56:43  oman
 - new: {RequestLink:158336069}

 Revision 1.7  2008/06/27 11:13:12  oman
 - fix: Боремся с балончиками (cq29470)

 Revision 1.6  2008/06/27 10:37:03  oman
 - fix: Боремся с балончиками (cq29470)

 Revision 1.5  2007/08/15 15:15:19  lulin
 - не передаем лишний параметр.

 Revision 1.4  2007/08/14 19:31:40  lulin
 - оптимизируем очистку памяти.

 Revision 1.3  2005/12/01 14:11:01  mmorozov
 - bugfix: function npIsWindowMinimized (cq: 00018418);

 Revision 1.2  2005/07/07 08:44:43  mmorozov
 new: global function npIsWindowMinimized;

 Revision 1.1  2005/06/09 09:47:51  mmorozov
 - компоненты перенесены в библиотеку VT;

 Revision 1.8  2005/01/28 17:33:05  mmorozov
 remove: не используемый модуль;

 Revision 1.7  2005/01/28 17:30:37  mmorozov
 new: function npIsFloatingForm;
 new: function npIsInFloatNavigator;

 Revision 1.6  2004/10/01 09:19:41  mmorozov
 change: для Немезиса npIsModalForm использует IvcmEntityForm.IsModalForm;

 Revision 1.5  2004/09/30 07:21:42  mmorozov
 new: method npIsParentWindow;
 new: method npIsModalForm;

 Revision 1.4  2004/09/17 12:19:11  mmorozov
 new: overload npIsOwnerWindow;

 Revision 1.3  2004/08/23 11:34:01  mmorozov
 no message

 Revision 1.2  2004/08/23 11:33:19  mmorozov
 - add cvs log;

-----------------------------------------------------------------------------*)

{$Include vtDefine.inc}

interface

uses
  Classes,
  Controls,
  
  vtNavigator
  ;

function npIsOwnerWindow(aOwner       : TComponent;
                         var aControl : TWinControl;
                         aHandle      : THandle) : Boolean;
  overload;
  {* - проверяет является ли aOwner прародителем окна с описателем aHandle. }
function npIsOwnerWindow(aOwner       : TComponent;
                         aHandle      : THandle) : Boolean;
  overload;
  {* - проверяет является ли aOwner прародителем окна с описателем aHandle. }
function npIsParentWindow(aParent : TWinControl;
                          aHandle : THandle) : Boolean;
  {* - определяет является ли aParent родителем aHandle. }
function npFindWindow(aComponent : TComponent;
                      aHandle    : THandle) : TWinControl;
  {* - поиск в aComponent окна с описателем aHandle. При поиске проверяются
       Components и Controls всех вложенных компонентов. }
function npIsModalForm(aHandle : THandle) : Boolean;
  {* - определяет является ли компонент с указанным Handle модальной формой. }
function npIsFloatingForm(aHandle : THandle) : Boolean;
  {* - определяет является ли компонент с указанным Handle плавающей формой. }
function npIsInFloatNavigator(aHandle : THandle) : Boolean;
  {* - окно находится в плавающем навигаторе. }
function npIsWindowMinimized(const aWindow : TWinControl) : Boolean;
  {* - определяет является ли aWindow минимизированным. }
function npGetActivationValue(aNavigator: TWinControl; aMainForm: TWinControl;
 aWindowWithActivation: THandle): Boolean;
  {* - возвращает флаг активации - нужно ли скрыть или показать навигатор. }
procedure DoNotifyControls(aOwner       : TComponent;
                         aMsg         : Integer;
                         aWParam      : Integer;
                         aLParam      : Integer);

implementation

uses
  Forms,
  Windows,
  {$IfDef Nemesis}
  SysUtils,
  vcmInterfaces,
  {$If not defined(NoTabs) AND not defined(nsTest)}
  l3TabbedContainersDispatcher,
  {$IfEnd}
  {$EndIf Nemesis}
  l3Base
  ;

procedure DoNotifyControls(aOwner       : TComponent;
                         aMsg         : Integer;
                         aWParam      : Integer;
                         aLParam      : Integer);
var
 l_Index : Integer;
begin
 with aOwner do
  for l_Index := 0 to Pred(ComponentCount) do
  begin
   if Components[l_Index] is TWinControl then
    with TWinControl(Components[l_Index]) do
     SendMessage(Handle, aMsg, aWParam, aLParam);
   DoNotifyControls(Components[l_Index], aMsg, aWParam, aLParam);
  end;//for l_Index
end;

function npIsWindowMinimized(const aWindow : TWinControl) : Boolean;
  {* - определяет является ли aWindow минимизированным. }
var
 lWP : TWindowPlacement;
begin
 Result := False;
 if Assigned(aWindow) and aWindow.HandleAllocated then
 begin
  l3FillChar(lWP, SizeOf(lWP));
  lWP.length := SizeOf(lWP);
  Windows.GetWindowPlacement(aWindow.Handle, @lWP);
  Result := lWP.showCmd = SW_SHOWMINIMIZED;
 end;
end;

function npGetActivationValue(aNavigator: TWinControl; aMainForm: TWinControl; aWindowWithActivation: THandle): Boolean;
var
 l_Control: TWinControl;
 l_ControlParentForm: TCustomForm;
begin
 Result := npIsOwnerWindow(aMainForm, aWindowWithActivation);
 {$IfDef Nemesis}
 {$If not defined(nsTest)}
 {$If not defined(NoTabs)}
 if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs then
 begin
  if (not Result) then
  begin
   l_Control := FindControl(aWindowWithActivation);
   if (l_Control <> nil) then
   begin
    if (l_Control.Owner <> nil) and
       (l_Control.Owner is TControl) then
    begin
     l_ControlParentForm := GetParentForm(TControl(l_Control.Owner));
     if ((l_ControlParentForm = GetParentForm(aNavigator)) or
        ((aNavigator.Owner <> nil) and (aNavigator.Owner is TControl) and
         (l_ControlParentForm = GetParentForm(TControl(aNavigator.Owner)))) or
        ((l_ControlParentForm = aMainForm) and aMainForm.Visible)) then
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=570120392,
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=595963346
      Result := True;
    end;
   end;
  end
  else
   Result := Result and aMainForm.Visible;
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=587161831
  // Вроде бы незачем показывать навигатор, если форма еще не показывается 
 end;//Tl3TabbedContainersDispatcher.Instance.NeedUseTabs
 {$IfEnd}
 {$IfEnd}
 {$EndIf Nemesis}
end;

function npIsInFloatNavigator(aHandle : THandle) : Boolean;
  {* - окно находится в плавающем навигаторе. }
var
 lControl : TWinControl;
begin
 Result := False;
 lControl := FindControl(aHandle);
 if Assigned(lControl) then
 begin
  while Assigned(lControl) do
  begin
   if lControl is TnpFloatingWindow then
   begin
    Result := True;
    Break;
   end;
   lControl := lControl.Parent;
  end;
 end;
end;

function npIsModalForm(aHandle : THandle) : Boolean;
  {* - определяет является ли компонент с указанным Handle модальной формой. }
var
 lControl : TWinControl;
 {$IfDef Nemesis}
 lForm    : IvcmEntityForm;
 {$EndIf Nemesis}
begin
 lControl := FindControl(aHandle);
 Result := Assigned(lControl) and (lControl is TCustomForm);
 if Result then
  {$IfDef Nemesis}
  if Supports(lControl, IvcmEntityForm, lForm) then
  try
   Result := lForm.IsModalForm;
  finally
   lForm := nil;
  end
  else
   Result := (fsModal in TCustomForm(lControl).FormState);
  {$Else}
  Result := (fsModal in TCustomForm(lControl).FormState);
  {$EndIf Nemesis}
end;

function npIsFloatingForm(aHandle : THandle) : Boolean;
  {* - определяет является ли компонент с указанным Handle плавающей формой. }
var
 lControl : TWinControl;
 {$IfDef Nemesis}
 lForm    : IvcmEntityForm;
 {$EndIf Nemesis}
begin
 lControl := FindControl(aHandle);
 Result := Assigned(lControl) and (lControl is TCustomForm);
 if Result then
  {$IfDef Nemesis}
  if Supports(lControl, IvcmEntityForm, lForm) then
  try
   Result := (lForm.ZoneType in [vcm_ztFloating, vcm_ztSimpleFloat]);
  finally
   lForm := nil;
  end;
  {$Else}
  Result := TCustomForm(lControl).Owner = Application;
  {$EndIf Nemesis}
end;

function npIsOwnerWindow(aOwner       : TComponent;
                         aHandle      : THandle) : Boolean;
  {* - проверяет является ли aOwner прародителем окна с описателем aHandle. }
var
 lControl : TWinControl;
begin
 Result := npIsOwnerWindow(aOwner, lControl, aHandle);
end;

function npIsOwnerWindow(aOwner       : TComponent;
                         var aControl : TWinControl;
                         aHandle      : THandle) : Boolean;
var
 lOwner : TComponent;
begin
 Result := False;
 aControl := FindControl(aHandle);
 if Assigned(aControl) then
 begin
  {$IfDef Nemesis}
  {$If not defined(nsTest)}
  {$If not defined(NoTabs)}
  if Tl3TabbedContainersDispatcher.Instance.NeedUseTabs and
     (aControl <> aOwner) AND
     (aOwner is TForm) AND
     (aControl <> nil) AND
     (aControl is TForm) then
   Result := Tl3TabbedContainersDispatcher.Instance.IsFormInContainer(TForm(aOwner), TForm(aControl));
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=554580040
  {$IfEnd}
  {$IfEnd}
  {$EndIf Nemesis}
  if (not Result) then
  begin
   if aControl = aOwner then
    Result := True
   else
   begin
    lOwner := aControl.Owner;
    while Assigned(lOwner) do
    begin
     if (lOwner = aOwner) then
     begin
      Result := True;
      Break;
     end
     else
      lOwner := lOwner.Owner;
    end;
   end;
  end;
 end;
end;

function npIsParentWindow(aParent : TWinControl;
                          aHandle : THandle) : Boolean;
{* - определяет является ли aParent родителем aHandle. }
var
 lControl : TWinControl;
 lParent  : TWinControl;
begin
 Result := False;
 lControl := FindControl(aHandle);
 if Assigned(lControl) then
 begin
  lParent := lControl.Parent;
  while Assigned(lParent) and (lParent <> aParent) do
   lParent := lParent.Parent;
  Result := Assigned(lParent);
 end;
end;

function npFindWindow(aComponent : TComponent;
                      aHandle    : THandle) : TWinControl;
var
 lIndex, J : Integer;
 lControl  : TWinControl;
begin
 Result := nil;
 with aComponent do
  for lIndex := 0 to Pred(ComponentCount) do
  begin
   (* ребенок и есть искомое окно *)
   if (Components[lIndex] is TWinControl) then
   begin
    lControl := TWinControl(Components[lIndex]);
    if lControl.HandleAllocated and (lControl.Handle = aHandle) then
     Result := lControl;
    (* поищем в компонентах, которые на нём лежат *)
    if not Assigned(Result) then
     for J := 0 to Pred(lControl.ControlCount) do
     begin
      if (lControl.Controls[J] is TWinControl) and
          TWinControl(lControl.Controls[J]).HandleAllocated and
         (TWinControl(lControl.Controls[J]).Handle = aHandle) then
       Result := TWinControl(lControl.Controls[J])
      else
       Result := npFindWindow(lControl.Controls[J], aHandle);
      if Assigned(Result) then
       Break;
     end;
   end;
   (* поищем в детях ребенка *)
   if not Assigned(Result) and (Components[lIndex].ComponentCount > 0) then
    Result := npFindWindow(Components[lIndex], aHandle);
   (* окно найдено, выходим *)
   if Assigned(Result) then
    Break;
  end;
end;

end.
