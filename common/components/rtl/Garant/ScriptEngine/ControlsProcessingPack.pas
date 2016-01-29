unit ControlsProcessingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "ControlsProcessingPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ControlsProcessing::ControlsProcessingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  l3Interfaces,
  Types,
  Graphics,
  Controls,
  Forms,
  Menus,
  Windows,
  tfwScriptingInterfaces,
  tfwRegisterableWord,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  kwBynameControlPush,
  Messages,
  l3PopupMenuHelper,
  l3FormsService,
  l3ControlFontService,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TControlFriend = {abstract} class(TControl)
  {* Друг для TControl }
 end;//TControlFriend

 TkwPopControlClientToScreen = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ClientToScreen
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ClientToScreen >>> l_TPoint
[code]  }
 private
 // private methods
   function ClientToScreen(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
     {* Реализация слова скрипта pop:Control:ClientToScreen }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClientToScreen

// start class TkwPopControlClientToScreen

function TkwPopControlClientToScreen.ClientToScreen(const aCtx: TtfwContext;
  aControl: TControl;
  const aPoint: TPoint): TPoint;
 {-}
begin
 Result := aControl.ClientToScreen(aPoint);
end;//TkwPopControlClientToScreen.ClientToScreen

procedure TkwPopControlClientToScreen.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
 l_aPoint : TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint((ClientToScreen(aCtx, l_aControl, l_aPoint)));
end;//TkwPopControlClientToScreen.DoDoIt

class function TkwPopControlClientToScreen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:ClientToScreen';
end;//TkwPopControlClientToScreen.GetWordNameForRegister

function TkwPopControlClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlClientToScreen.GetResultTypeInfo

function TkwPopControlClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopControlClientToScreen.GetAllParamsCount

function TkwPopControlClientToScreen.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlClientToScreen.ParamsTypes

type
 TkwPopControlScreenToClient = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:ScreenToClient
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aControl pop:Control:ScreenToClient >>> l_TPoint
[code]  }
 private
 // private methods
   function ScreenToClient(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TPoint;
     {* Реализация слова скрипта pop:Control:ScreenToClient }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlScreenToClient

// start class TkwPopControlScreenToClient

function TkwPopControlScreenToClient.ScreenToClient(const aCtx: TtfwContext;
  aControl: TControl;
  const aPoint: TPoint): TPoint;
 {-}
begin
 Result := aControl.ScreenToClient(aPoint);
end;//TkwPopControlScreenToClient.ScreenToClient

procedure TkwPopControlScreenToClient.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
 l_aPoint : TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint((ScreenToClient(aCtx, l_aControl, l_aPoint)));
end;//TkwPopControlScreenToClient.DoDoIt

class function TkwPopControlScreenToClient.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:ScreenToClient';
end;//TkwPopControlScreenToClient.GetWordNameForRegister

function TkwPopControlScreenToClient.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiStruct;
end;//TkwPopControlScreenToClient.GetResultTypeInfo

function TkwPopControlScreenToClient.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopControlScreenToClient.GetAllParamsCount

function TkwPopControlScreenToClient.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlScreenToClient.ParamsTypes

type
 TkwPopControlInvalidate = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Invalidate
*Пример:*
[code]
 aControl pop:Control:Invalidate
[code]  }
 private
 // private methods
   procedure Invalidate(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Invalidate }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlInvalidate

// start class TkwPopControlInvalidate

procedure TkwPopControlInvalidate.Invalidate(const aCtx: TtfwContext;
  aControl: TControl);
 {-}
begin
 aControl.Invalidate;
end;//TkwPopControlInvalidate.Invalidate

procedure TkwPopControlInvalidate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Invalidate(aCtx, l_aControl);
end;//TkwPopControlInvalidate.DoDoIt

class function TkwPopControlInvalidate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Invalidate';
end;//TkwPopControlInvalidate.GetWordNameForRegister

function TkwPopControlInvalidate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlInvalidate.GetResultTypeInfo

function TkwPopControlInvalidate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlInvalidate.GetAllParamsCount

function TkwPopControlInvalidate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlInvalidate.ParamsTypes

type
 TkwPopControlRepaint = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Repaint
*Пример:*
[code]
 aControl pop:Control:Repaint
[code]  }
 private
 // private methods
   procedure Repaint(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Repaint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlRepaint

// start class TkwPopControlRepaint

procedure TkwPopControlRepaint.Repaint(const aCtx: TtfwContext;
  aControl: TControl);
 {-}
begin
 aControl.Repaint;
end;//TkwPopControlRepaint.Repaint

procedure TkwPopControlRepaint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Repaint(aCtx, l_aControl);
end;//TkwPopControlRepaint.DoDoIt

class function TkwPopControlRepaint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Repaint';
end;//TkwPopControlRepaint.GetWordNameForRegister

function TkwPopControlRepaint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlRepaint.GetResultTypeInfo

function TkwPopControlRepaint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlRepaint.GetAllParamsCount

function TkwPopControlRepaint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlRepaint.ParamsTypes

type
 TkwPopControlClick = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Click
*Пример:*
[code]
 aControl pop:Control:Click
[code]  }
 private
 // private methods
   procedure Click(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Click }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlClick

// start class TkwPopControlClick

procedure TkwPopControlClick.Click(const aCtx: TtfwContext;
  aControl: TControl);
//#UC START# *61CF2F0B3020_F8C716BBBC31_var*
//#UC END# *61CF2F0B3020_F8C716BBBC31_var*
begin
//#UC START# *61CF2F0B3020_F8C716BBBC31_impl*
 TControlFriend(aControl).Click;
//#UC END# *61CF2F0B3020_F8C716BBBC31_impl*
end;//TkwPopControlClick.Click

procedure TkwPopControlClick.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Click(aCtx, l_aControl);
end;//TkwPopControlClick.DoDoIt

class function TkwPopControlClick.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Click';
end;//TkwPopControlClick.GetWordNameForRegister

function TkwPopControlClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlClick.GetResultTypeInfo

function TkwPopControlClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlClick.GetAllParamsCount

function TkwPopControlClick.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlClick.ParamsTypes

type
 TkwPopControlShow = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Show
*Пример:*
[code]
 aControl pop:Control:Show
[code]  }
 private
 // private methods
   procedure Show(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Show }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlShow

// start class TkwPopControlShow

procedure TkwPopControlShow.Show(const aCtx: TtfwContext;
  aControl: TControl);
 {-}
begin
 aControl.Show;
end;//TkwPopControlShow.Show

procedure TkwPopControlShow.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Show(aCtx, l_aControl);
end;//TkwPopControlShow.DoDoIt

class function TkwPopControlShow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Show';
end;//TkwPopControlShow.GetWordNameForRegister

function TkwPopControlShow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlShow.GetResultTypeInfo

function TkwPopControlShow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlShow.GetAllParamsCount

function TkwPopControlShow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShow.ParamsTypes

type
 TkwPopControlHide = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Hide
*Пример:*
[code]
 aControl pop:Control:Hide
[code]  }
 private
 // private methods
   procedure Hide(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Hide }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHide

// start class TkwPopControlHide

procedure TkwPopControlHide.Hide(const aCtx: TtfwContext;
  aControl: TControl);
 {-}
begin
 aControl.Hide;
end;//TkwPopControlHide.Hide

procedure TkwPopControlHide.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Hide(aCtx, l_aControl);
end;//TkwPopControlHide.DoDoIt

class function TkwPopControlHide.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Hide';
end;//TkwPopControlHide.GetWordNameForRegister

function TkwPopControlHide.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlHide.GetResultTypeInfo

function TkwPopControlHide.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlHide.GetAllParamsCount

function TkwPopControlHide.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHide.ParamsTypes

type
 TkwPopControlUndock = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:Undock
*Пример:*
[code]
 aControl pop:Control:Undock
[code]  }
 private
 // private methods
   procedure Undock(const aCtx: TtfwContext;
    aControl: TControl);
     {* Реализация слова скрипта pop:Control:Undock }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlUndock

// start class TkwPopControlUndock

procedure TkwPopControlUndock.Undock(const aCtx: TtfwContext;
  aControl: TControl);
//#UC START# *E44BD472B7AB_6BAE007A323D_var*
//#UC END# *E44BD472B7AB_6BAE007A323D_var*
begin
//#UC START# *E44BD472B7AB_6BAE007A323D_impl*
 aControl.ManualDock(nil, nil, alNone);
//#UC END# *E44BD472B7AB_6BAE007A323D_impl*
end;//TkwPopControlUndock.Undock

procedure TkwPopControlUndock.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Undock(aCtx, l_aControl);
end;//TkwPopControlUndock.DoDoIt

class function TkwPopControlUndock.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Undock';
end;//TkwPopControlUndock.GetWordNameForRegister

function TkwPopControlUndock.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlUndock.GetResultTypeInfo

function TkwPopControlUndock.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlUndock.GetAllParamsCount

function TkwPopControlUndock.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlUndock.ParamsTypes

type
 TkwPopControlGetPopupMenu = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetPopupMenu
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aPoint aControl pop:Control:GetPopupMenu >>> l_TMenuItem
[code]  }
 private
 // private methods
   function GetPopupMenu(const aCtx: TtfwContext;
    aControl: TControl;
    const aPoint: TPoint): TMenuItem;
     {* Реализация слова скрипта pop:Control:GetPopupMenu }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetPopupMenu

// start class TkwPopControlGetPopupMenu

function TkwPopControlGetPopupMenu.GetPopupMenu(const aCtx: TtfwContext;
  aControl: TControl;
  const aPoint: TPoint): TMenuItem;
//#UC START# *03EB93F2B4F5_42A7FAEADBD6_var*
//#UC END# *03EB93F2B4F5_42A7FAEADBD6_var*
begin
//#UC START# *03EB93F2B4F5_42A7FAEADBD6_impl*
 Result := Tl3PopupMenuHelper.Instance.GetPopupMenu(aControl, aPoint);
//#UC END# *03EB93F2B4F5_42A7FAEADBD6_impl*
end;//TkwPopControlGetPopupMenu.GetPopupMenu

procedure TkwPopControlGetPopupMenu.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
 l_aPoint : TPoint;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetPopupMenu(aCtx, l_aControl, l_aPoint)));
end;//TkwPopControlGetPopupMenu.DoDoIt

class function TkwPopControlGetPopupMenu.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:GetPopupMenu';
end;//TkwPopControlGetPopupMenu.GetWordNameForRegister

function TkwPopControlGetPopupMenu.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopControlGetPopupMenu.GetResultTypeInfo

function TkwPopControlGetPopupMenu.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopControlGetPopupMenu.GetAllParamsCount

function TkwPopControlGetPopupMenu.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl), @tfw_tiStruct]);
end;//TkwPopControlGetPopupMenu.ParamsTypes

type
 TkwPopControlGetTopParentForm = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetTopParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetTopParentForm >>> l_TCustomForm
[code]  }
 private
 // private methods
   function GetTopParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
     {* Реализация слова скрипта pop:Control:GetTopParentForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetTopParentForm

// start class TkwPopControlGetTopParentForm

function TkwPopControlGetTopParentForm.GetTopParentForm(const aCtx: TtfwContext;
  aControl: TControl): TCustomForm;
//#UC START# *D1A25E7B9BDA_801293AEE662_var*
//#UC END# *D1A25E7B9BDA_801293AEE662_var*
begin
//#UC START# *D1A25E7B9BDA_801293AEE662_impl*
 Result := Tl3FormsService.Instance.GetTopParentForm(aControl);
//#UC END# *D1A25E7B9BDA_801293AEE662_impl*
end;//TkwPopControlGetTopParentForm.GetTopParentForm

procedure TkwPopControlGetTopParentForm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetTopParentForm(aCtx, l_aControl)));
end;//TkwPopControlGetTopParentForm.DoDoIt

class function TkwPopControlGetTopParentForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:GetTopParentForm';
end;//TkwPopControlGetTopParentForm.GetWordNameForRegister

function TkwPopControlGetTopParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetTopParentForm.GetResultTypeInfo

function TkwPopControlGetTopParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlGetTopParentForm.GetAllParamsCount

function TkwPopControlGetTopParentForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetTopParentForm.ParamsTypes

type
 TkwPopControlGetMainForm = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetMainForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetMainForm >>> l_TCustomForm
[code]  }
 private
 // private methods
   function GetMainForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
     {* Реализация слова скрипта pop:Control:GetMainForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetMainForm

// start class TkwPopControlGetMainForm

function TkwPopControlGetMainForm.GetMainForm(const aCtx: TtfwContext;
  aControl: TControl): TCustomForm;
//#UC START# *2075E5D1B087_19DF01986BE7_var*
//#UC END# *2075E5D1B087_19DF01986BE7_var*
begin
//#UC START# *2075E5D1B087_19DF01986BE7_impl*
 Result := Tl3FormsService.Instance.GetMainForm(aControl);
//#UC END# *2075E5D1B087_19DF01986BE7_impl*
end;//TkwPopControlGetMainForm.GetMainForm

procedure TkwPopControlGetMainForm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetMainForm(aCtx, l_aControl)));
end;//TkwPopControlGetMainForm.DoDoIt

class function TkwPopControlGetMainForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:GetMainForm';
end;//TkwPopControlGetMainForm.GetWordNameForRegister

function TkwPopControlGetMainForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetMainForm.GetResultTypeInfo

function TkwPopControlGetMainForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlGetMainForm.GetAllParamsCount

function TkwPopControlGetMainForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetMainForm.ParamsTypes

type
 TkwPopControlGetParentForm = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetParentForm >>> l_TCustomForm
[code]  }
 private
 // private methods
   function GetParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
     {* Реализация слова скрипта pop:Control:GetParentForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetParentForm

// start class TkwPopControlGetParentForm

function TkwPopControlGetParentForm.GetParentForm(const aCtx: TtfwContext;
  aControl: TControl): TCustomForm;
//#UC START# *290504A82C40_BC5B460C7FEA_var*
//#UC END# *290504A82C40_BC5B460C7FEA_var*
begin
//#UC START# *290504A82C40_BC5B460C7FEA_impl*
 Result := Tl3FormsService.Instance.GetParentForm(aControl);
//#UC END# *290504A82C40_BC5B460C7FEA_impl*
end;//TkwPopControlGetParentForm.GetParentForm

procedure TkwPopControlGetParentForm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetParentForm(aCtx, l_aControl)));
end;//TkwPopControlGetParentForm.DoDoIt

class function TkwPopControlGetParentForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:GetParentForm';
end;//TkwPopControlGetParentForm.GetWordNameForRegister

function TkwPopControlGetParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetParentForm.GetResultTypeInfo

function TkwPopControlGetParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlGetParentForm.GetAllParamsCount

function TkwPopControlGetParentForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetParentForm.ParamsTypes

type
 TkwPopControlGetAnotherParentForm = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetAnotherParentForm
*Тип результата:* TCustomForm
*Пример:*
[code]
OBJECT VAR l_TCustomForm
 aControl pop:Control:GetAnotherParentForm >>> l_TCustomForm
[code]  }
 private
 // private methods
   function GetAnotherParentForm(const aCtx: TtfwContext;
    aControl: TControl): TCustomForm;
     {* Реализация слова скрипта pop:Control:GetAnotherParentForm }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetAnotherParentForm

// start class TkwPopControlGetAnotherParentForm

function TkwPopControlGetAnotherParentForm.GetAnotherParentForm(const aCtx: TtfwContext;
  aControl: TControl): TCustomForm;
//#UC START# *68CF70189B15_8A00B7773D0C_var*
//#UC END# *68CF70189B15_8A00B7773D0C_var*
begin
//#UC START# *68CF70189B15_8A00B7773D0C_impl*
 Result := Tl3FormsService.Instance.GetAnotherParentForm(aControl);
//#UC END# *68CF70189B15_8A00B7773D0C_impl*
end;//TkwPopControlGetAnotherParentForm.GetAnotherParentForm

procedure TkwPopControlGetAnotherParentForm.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GetAnotherParentForm(aCtx, l_aControl)));
end;//TkwPopControlGetAnotherParentForm.DoDoIt

class function TkwPopControlGetAnotherParentForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:GetAnotherParentForm';
end;//TkwPopControlGetAnotherParentForm.GetWordNameForRegister

function TkwPopControlGetAnotherParentForm.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TCustomForm);
end;//TkwPopControlGetAnotherParentForm.GetResultTypeInfo

function TkwPopControlGetAnotherParentForm.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlGetAnotherParentForm.GetAllParamsCount

function TkwPopControlGetAnotherParentForm.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlGetAnotherParentForm.ParamsTypes

type
 TkwControlByHandle = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта Control:ByHandle
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aHandle Control:ByHandle >>> l_TControl
[code]  }
 private
 // private methods
   function ByHandle(const aCtx: TtfwContext;
    aHandle: THandle): TControl;
     {* Реализация слова скрипта Control:ByHandle }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlByHandle

// start class TkwControlByHandle

function TkwControlByHandle.ByHandle(const aCtx: TtfwContext;
  aHandle: THandle): TControl;
//#UC START# *C84440B65B87_0241DA0F487D_var*
//#UC END# *C84440B65B87_0241DA0F487D_var*
begin
//#UC START# *C84440B65B87_0241DA0F487D_impl*
 Result := FindControl(aHandle);
 RunnerAssert(Assigned(Result), 'Не найден контрол.', aCtx);
//#UC END# *C84440B65B87_0241DA0F487D_impl*
end;//TkwControlByHandle.ByHandle

procedure TkwControlByHandle.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aHandle : THandle;
begin
 try
  l_aHandle := THandle(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHandle: THandle : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ByHandle(aCtx, l_aHandle)));
end;//TkwControlByHandle.DoDoIt

class function TkwControlByHandle.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Control:ByHandle';
end;//TkwControlByHandle.GetWordNameForRegister

function TkwControlByHandle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TControl);
end;//TkwControlByHandle.GetResultTypeInfo

function TkwControlByHandle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwControlByHandle.GetAllParamsCount

function TkwControlByHandle.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(THandle)]);
end;//TkwControlByHandle.ParamsTypes

type
 TkwControlFocusedControlPush = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта focused:control:push
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 focused:control:push >>> l_TControl
[code]  }
 private
 // private methods
   function FocusedControlPush(const aCtx: TtfwContext): TControl;
     {* Реализация слова скрипта focused:control:push }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwControlFocusedControlPush

// start class TkwControlFocusedControlPush

function TkwControlFocusedControlPush.FocusedControlPush(const aCtx: TtfwContext): TControl;
//#UC START# *190B20AA18AF_DDB6E934DC7B_var*
var
 l_C : TControl;
//#UC END# *190B20AA18AF_DDB6E934DC7B_var*
begin
//#UC START# *190B20AA18AF_DDB6E934DC7B_impl*
 l_C := FindControl(GetFocus);
 if (l_C = nil) then
 // - наверное мы под отладчиком или из под нас выдернули фокус
 begin
  RunnerAssert(Screen.ActiveForm <> nil, 'Нет активной формы', aCtx);
  l_C := Screen.ActiveForm.ActiveControl;
 end;//l_C = nil
 RunnerAssert(l_C <> nil, 'Не нашли контрол в фокусе', aCtx);
 Result := l_C;
//#UC END# *190B20AA18AF_DDB6E934DC7B_impl*
end;//TkwControlFocusedControlPush.FocusedControlPush

procedure TkwControlFocusedControlPush.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushObj((FocusedControlPush(aCtx)));
end;//TkwControlFocusedControlPush.DoDoIt

class function TkwControlFocusedControlPush.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'focused:control:push';
end;//TkwControlFocusedControlPush.GetWordNameForRegister

function TkwControlFocusedControlPush.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TControl);
end;//TkwControlFocusedControlPush.GetResultTypeInfo

function TkwControlFocusedControlPush.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwControlFocusedControlPush.GetAllParamsCount

function TkwControlFocusedControlPush.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwControlFocusedControlPush.ParamsTypes

type
 TkwPopControlColor = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Color
*Тип результата:* TColor
*Пример:*
[code]
TColor VAR l_TColor
 aControl pop:Control:Color >>> l_TColor
[code]  }
 private
 // private methods
   function Color(const aCtx: TtfwContext;
    aControl: TControl): TColor;
     {* Реализация слова скрипта pop:Control:Color }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 protected
 // protected methods
   class procedure DoSetValue(aControl: TControl;
    aValue: TColor);
     {* Метод установки значения свойства Color }
 end;//TkwPopControlColor

// start class TkwPopControlColor

function TkwPopControlColor.Color(const aCtx: TtfwContext;
  aControl: TControl): TColor;
//#UC START# *AACBF5E37A06_EBE4B9074377_var*
//#UC END# *AACBF5E37A06_EBE4B9074377_var*
begin
//#UC START# *AACBF5E37A06_EBE4B9074377_impl*
 Result := TControlFriend(aControl).Color;
//#UC END# *AACBF5E37A06_EBE4B9074377_impl*
end;//TkwPopControlColor.Color

class procedure TkwPopControlColor.DoSetValue(aControl: TControl;
  aValue: TColor);
//#UC START# *8D28522E42BF_EBE4B9074377_var*
//#UC END# *8D28522E42BF_EBE4B9074377_var*
begin
//#UC START# *8D28522E42BF_EBE4B9074377_impl*
 TControlFriend(aControl).Color := aValue;
//#UC END# *8D28522E42BF_EBE4B9074377_impl*
end;//TkwPopControlColor.DoSetValue

procedure TkwPopControlColor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Color(aCtx, l_aControl)));
end;//TkwPopControlColor.DoDoIt

class function TkwPopControlColor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Color';
end;//TkwPopControlColor.GetWordNameForRegister

procedure TkwPopControlColor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_Control, (aValue.AsInt));
end;//TkwPopControlColor.SetValuePrim

function TkwPopControlColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TColor);
end;//TkwPopControlColor.GetResultTypeInfo

function TkwPopControlColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlColor.GetAllParamsCount

function TkwPopControlColor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlColor.ParamsTypes

type
 TkwPopControlEnabled = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Enabled >>> l_Boolean
[code]  }
 private
 // private methods
   function Enabled(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
     {* Реализация слова скрипта pop:Control:Enabled }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlEnabled

// start class TkwPopControlEnabled

function TkwPopControlEnabled.Enabled(const aCtx: TtfwContext;
  aControl: TControl): Boolean;
 {-}
begin
 Result := aControl.Enabled;
end;//TkwPopControlEnabled.Enabled

procedure TkwPopControlEnabled.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Enabled(aCtx, l_aControl)));
end;//TkwPopControlEnabled.DoDoIt

class function TkwPopControlEnabled.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Enabled';
end;//TkwPopControlEnabled.GetWordNameForRegister

procedure TkwPopControlEnabled.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwPopControlEnabled.SetValuePrim

function TkwPopControlEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlEnabled.GetResultTypeInfo

function TkwPopControlEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlEnabled.GetAllParamsCount

function TkwPopControlEnabled.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlEnabled.ParamsTypes

type
 TkwPopControlVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Visible >>> l_Boolean
[code]  }
 private
 // private methods
   function Visible(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
     {* Реализация слова скрипта pop:Control:Visible }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlVisible

// start class TkwPopControlVisible

function TkwPopControlVisible.Visible(const aCtx: TtfwContext;
  aControl: TControl): Boolean;
 {-}
begin
 Result := aControl.Visible;
end;//TkwPopControlVisible.Visible

procedure TkwPopControlVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Visible(aCtx, l_aControl)));
end;//TkwPopControlVisible.DoDoIt

class function TkwPopControlVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Visible';
end;//TkwPopControlVisible.GetWordNameForRegister

procedure TkwPopControlVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopControlVisible.SetValuePrim

function TkwPopControlVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlVisible.GetResultTypeInfo

function TkwPopControlVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlVisible.GetAllParamsCount

function TkwPopControlVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlVisible.ParamsTypes

type
 TkwPopControlName = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Name >>> l_String
[code]  }
 private
 // private methods
   function Name(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
     {* Реализация слова скрипта pop:Control:Name }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlName

// start class TkwPopControlName

function TkwPopControlName.Name(const aCtx: TtfwContext;
  aControl: TControl): AnsiString;
 {-}
begin
 Result := aControl.Name;
end;//TkwPopControlName.Name

procedure TkwPopControlName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((Name(aCtx, l_aControl)));
end;//TkwPopControlName.DoDoIt

class function TkwPopControlName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Name';
end;//TkwPopControlName.GetWordNameForRegister

procedure TkwPopControlName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopControlName.SetValuePrim

function TkwPopControlName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopControlName.GetResultTypeInfo

function TkwPopControlName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlName.GetAllParamsCount

function TkwPopControlName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlName.ParamsTypes

type
 TkwPopControlHint = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Hint
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Hint >>> l_String
[code]  }
 private
 // private methods
   function Hint(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
     {* Реализация слова скрипта pop:Control:Hint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHint

// start class TkwPopControlHint

function TkwPopControlHint.Hint(const aCtx: TtfwContext;
  aControl: TControl): AnsiString;
 {-}
begin
 Result := aControl.Hint;
end;//TkwPopControlHint.Hint

procedure TkwPopControlHint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((Hint(aCtx, l_aControl)));
end;//TkwPopControlHint.DoDoIt

class function TkwPopControlHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Hint';
end;//TkwPopControlHint.GetWordNameForRegister

procedure TkwPopControlHint.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Hint', aCtx);
end;//TkwPopControlHint.SetValuePrim

function TkwPopControlHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopControlHint.GetResultTypeInfo

function TkwPopControlHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlHint.GetAllParamsCount

function TkwPopControlHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHint.ParamsTypes

type
 TkwPopControlShowHint = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ShowHint
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:ShowHint >>> l_Boolean
[code]  }
 private
 // private methods
   function ShowHint(const aCtx: TtfwContext;
    aControl: TControl): Boolean;
     {* Реализация слова скрипта pop:Control:ShowHint }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlShowHint

// start class TkwPopControlShowHint

function TkwPopControlShowHint.ShowHint(const aCtx: TtfwContext;
  aControl: TControl): Boolean;
 {-}
begin
 Result := aControl.ShowHint;
end;//TkwPopControlShowHint.ShowHint

procedure TkwPopControlShowHint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((ShowHint(aCtx, l_aControl)));
end;//TkwPopControlShowHint.DoDoIt

class function TkwPopControlShowHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:ShowHint';
end;//TkwPopControlShowHint.GetWordNameForRegister

procedure TkwPopControlShowHint.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowHint', aCtx);
end;//TkwPopControlShowHint.SetValuePrim

function TkwPopControlShowHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlShowHint.GetResultTypeInfo

function TkwPopControlShowHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlShowHint.GetAllParamsCount

function TkwPopControlShowHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlShowHint.ParamsTypes

type
 TkwPopControlCaption = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Caption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aControl pop:Control:Caption >>> l_String
[code]  }
 private
 // private methods
   function Caption(const aCtx: TtfwContext;
    aControl: TControl): AnsiString;
     {* Реализация слова скрипта pop:Control:Caption }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlCaption

// start class TkwPopControlCaption

function TkwPopControlCaption.Caption(const aCtx: TtfwContext;
  aControl: TControl): AnsiString;
//#UC START# *DAFCD40E37A8_6ED40CDED494_var*
//#UC END# *DAFCD40E37A8_6ED40CDED494_var*
begin
//#UC START# *DAFCD40E37A8_6ED40CDED494_impl*
 Result := TControlFriend(aControl).Caption;
//#UC END# *DAFCD40E37A8_6ED40CDED494_impl*
end;//TkwPopControlCaption.Caption

procedure TkwPopControlCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((Caption(aCtx, l_aControl)));
end;//TkwPopControlCaption.DoDoIt

class function TkwPopControlCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Caption';
end;//TkwPopControlCaption.GetWordNameForRegister

procedure TkwPopControlCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwPopControlCaption.SetValuePrim

function TkwPopControlCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopControlCaption.GetResultTypeInfo

function TkwPopControlCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlCaption.GetAllParamsCount

function TkwPopControlCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlCaption.ParamsTypes

type
 TkwPopControlTop = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Top >>> l_Integer
[code]  }
 private
 // private methods
   function Top(const aCtx: TtfwContext;
    aControl: TControl): Integer;
     {* Реализация слова скрипта pop:Control:Top }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlTop

// start class TkwPopControlTop

function TkwPopControlTop.Top(const aCtx: TtfwContext;
  aControl: TControl): Integer;
 {-}
begin
 Result := aControl.Top;
end;//TkwPopControlTop.Top

procedure TkwPopControlTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Top(aCtx, l_aControl)));
end;//TkwPopControlTop.DoDoIt

class function TkwPopControlTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Top';
end;//TkwPopControlTop.GetWordNameForRegister

procedure TkwPopControlTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Top := (aValue.AsInt);
end;//TkwPopControlTop.SetValuePrim

function TkwPopControlTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlTop.GetResultTypeInfo

function TkwPopControlTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlTop.GetAllParamsCount

function TkwPopControlTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlTop.ParamsTypes

type
 TkwPopControlLeft = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Left >>> l_Integer
[code]  }
 private
 // private methods
   function Left(const aCtx: TtfwContext;
    aControl: TControl): Integer;
     {* Реализация слова скрипта pop:Control:Left }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlLeft

// start class TkwPopControlLeft

function TkwPopControlLeft.Left(const aCtx: TtfwContext;
  aControl: TControl): Integer;
 {-}
begin
 Result := aControl.Left;
end;//TkwPopControlLeft.Left

procedure TkwPopControlLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Left(aCtx, l_aControl)));
end;//TkwPopControlLeft.DoDoIt

class function TkwPopControlLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Left';
end;//TkwPopControlLeft.GetWordNameForRegister

procedure TkwPopControlLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Left := (aValue.AsInt);
end;//TkwPopControlLeft.SetValuePrim

function TkwPopControlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlLeft.GetResultTypeInfo

function TkwPopControlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlLeft.GetAllParamsCount

function TkwPopControlLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlLeft.ParamsTypes

type
 TkwPopControlHeight = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Height >>> l_Integer
[code]  }
 private
 // private methods
   function Height(const aCtx: TtfwContext;
    aControl: TControl): Integer;
     {* Реализация слова скрипта pop:Control:Height }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHeight

// start class TkwPopControlHeight

function TkwPopControlHeight.Height(const aCtx: TtfwContext;
  aControl: TControl): Integer;
 {-}
begin
 Result := aControl.Height;
end;//TkwPopControlHeight.Height

procedure TkwPopControlHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Height(aCtx, l_aControl)));
end;//TkwPopControlHeight.DoDoIt

class function TkwPopControlHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Height';
end;//TkwPopControlHeight.GetWordNameForRegister

procedure TkwPopControlHeight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Height := (aValue.AsInt);
end;//TkwPopControlHeight.SetValuePrim

function TkwPopControlHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlHeight.GetResultTypeInfo

function TkwPopControlHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlHeight.GetAllParamsCount

function TkwPopControlHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlHeight.ParamsTypes

type
 TkwPopControlWidth = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:Width >>> l_Integer
[code]  }
 private
 // private methods
   function Width(const aCtx: TtfwContext;
    aControl: TControl): Integer;
     {* Реализация слова скрипта pop:Control:Width }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlWidth

// start class TkwPopControlWidth

function TkwPopControlWidth.Width(const aCtx: TtfwContext;
  aControl: TControl): Integer;
 {-}
begin
 Result := aControl.Width;
end;//TkwPopControlWidth.Width

procedure TkwPopControlWidth.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Width(aCtx, l_aControl)));
end;//TkwPopControlWidth.DoDoIt

class function TkwPopControlWidth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Width';
end;//TkwPopControlWidth.GetWordNameForRegister

procedure TkwPopControlWidth.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Control: TControl;
begin
 try
  l_Control := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Control: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Control.Width := (aValue.AsInt);
end;//TkwPopControlWidth.SetValuePrim

function TkwPopControlWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlWidth.GetResultTypeInfo

function TkwPopControlWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlWidth.GetAllParamsCount

function TkwPopControlWidth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlWidth.ParamsTypes

type
 TkwPopControlParent = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Parent
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 aControl pop:Control:Parent >>> l_TControl
[code]  }
 private
 // private methods
   function Parent(const aCtx: TtfwContext;
    aControl: TControl): TControl;
     {* Реализация слова скрипта pop:Control:Parent }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlParent

// start class TkwPopControlParent

function TkwPopControlParent.Parent(const aCtx: TtfwContext;
  aControl: TControl): TControl;
 {-}
begin
 Result := aControl.Parent;
end;//TkwPopControlParent.Parent

procedure TkwPopControlParent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Parent(aCtx, l_aControl)));
end;//TkwPopControlParent.DoDoIt

class function TkwPopControlParent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Parent';
end;//TkwPopControlParent.GetWordNameForRegister

procedure TkwPopControlParent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Parent', aCtx);
end;//TkwPopControlParent.SetValuePrim

function TkwPopControlParent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TControl);
end;//TkwPopControlParent.GetResultTypeInfo

function TkwPopControlParent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlParent.GetAllParamsCount

function TkwPopControlParent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlParent.ParamsTypes

type
 TkwPopControlFont = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Font
*Тип результата:* Il3FontInfo
*Пример:*
[code]
INTERFACE VAR l_Il3FontInfo
 aControl pop:Control:Font >>> l_Il3FontInfo
[code]  }
 private
 // private methods
   function Font(const aCtx: TtfwContext;
    aControl: TControl): Il3FontInfo;
     {* Реализация слова скрипта pop:Control:Font }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFont

// start class TkwPopControlFont

function TkwPopControlFont.Font(const aCtx: TtfwContext;
  aControl: TControl): Il3FontInfo;
//#UC START# *BCE0497B09C6_520187343F71_var*
//#UC END# *BCE0497B09C6_520187343F71_var*
begin
//#UC START# *BCE0497B09C6_520187343F71_impl*
 Result := Tl3ControlFontService.Instance.GetFont(aControl);
//#UC END# *BCE0497B09C6_520187343F71_impl*
end;//TkwPopControlFont.Font

procedure TkwPopControlFont.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TControl;
begin
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf((Font(aCtx, l_aControl)), TypeInfo(Il3FontInfo));
end;//TkwPopControlFont.DoDoIt

class function TkwPopControlFont.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:Font';
end;//TkwPopControlFont.GetWordNameForRegister

procedure TkwPopControlFont.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Font', aCtx);
end;//TkwPopControlFont.SetValuePrim

function TkwPopControlFont.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Il3FontInfo);
end;//TkwPopControlFont.GetResultTypeInfo

function TkwPopControlFont.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlFont.GetAllParamsCount

function TkwPopControlFont.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TControl)]);
end;//TkwPopControlFont.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_ClientToScreen
 TkwPopControlClientToScreen.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_ScreenToClient
 TkwPopControlScreenToClient.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Invalidate
 TkwPopControlInvalidate.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Repaint
 TkwPopControlRepaint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Click
 TkwPopControlClick.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Show
 TkwPopControlShow.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Hide
 TkwPopControlHide.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Undock
 TkwPopControlUndock.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_GetPopupMenu
 TkwPopControlGetPopupMenu.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_GetTopParentForm
 TkwPopControlGetTopParentForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_GetMainForm
 TkwPopControlGetMainForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_GetParentForm
 TkwPopControlGetParentForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_GetAnotherParentForm
 TkwPopControlGetAnotherParentForm.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация Control_ByHandle
 TkwControlByHandle.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация Control_focused_control_push
 TkwControlFocusedControlPush.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Color
 TkwPopControlColor.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Enabled
 TkwPopControlEnabled.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Visible
 TkwPopControlVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Name
 TkwPopControlName.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Hint
 TkwPopControlHint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_ShowHint
 TkwPopControlShowHint.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Caption
 TkwPopControlCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Top
 TkwPopControlTop.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Left
 TkwPopControlLeft.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Height
 TkwPopControlHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Width
 TkwPopControlWidth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Parent
 TkwPopControlParent.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_Font
 TkwPopControlFont.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TPoint
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TMenuItem
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TCustomForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomForm));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа THandle
 TtfwTypeRegistrator.RegisterType(TypeInfo(THandle));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TColor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TColor));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Il3FontInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
{$IfEnd} //not NoScripts AND not NoVCL

end.