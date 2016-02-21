unit WinControlsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WinControlsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
 , Classes
 , Types
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , Messages
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlMouseLeftClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseLeftClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseLeftClick
[code]  }
  private
   procedure MouseLeftClick(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aPoint: TPoint);
    {* Реализация слова скрипта pop:Control:MouseLeftClick }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseLeftClick

 TkwPopControlMouseMiddleClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseMiddleClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseMiddleClick
[code]  }
  private
   procedure MouseMiddleClick(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aPoint: TPoint);
    {* Реализация слова скрипта pop:Control:MouseMiddleClick }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseMiddleClick

 TkwPopControlMouseRightClick = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseRightClick
*Пример:*
[code]
 aPoint aControl pop:Control:MouseRightClick
[code]  }
  private
   procedure MouseRightClick(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aPoint: TPoint);
    {* Реализация слова скрипта pop:Control:MouseRightClick }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseRightClick

 TkwPopControlFindControlByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:FindControlByName
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aName aControl pop:Control:FindControlByName >>> l_TComponent
[code]  }
  private
   function FindControlByName(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aName: AnsiString): TComponent;
    {* Реализация слова скрипта pop:Control:FindControlByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFindControlByName

 TkwPopControlGetControl = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:GetControl
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 anIndex aControl pop:Control:GetControl >>> l_TControl
[code]  }
  private
   function GetControl(const aCtx: TtfwContext;
    aControl: TWinControl;
    anIndex: Integer): TControl;
    {* Реализация слова скрипта pop:Control:GetControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlGetControl

 TkwPopControlMouseWheelUp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseWheelUp
*Пример:*
[code]
 aControl pop:Control:MouseWheelUp
[code]  }
  private
   procedure MouseWheelUp(const aCtx: TtfwContext;
    aControl: TWinControl);
    {* Реализация слова скрипта pop:Control:MouseWheelUp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseWheelUp

 TkwPopControlMouseWheelDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseWheelDown
*Пример:*
[code]
 aControl pop:Control:MouseWheelDown
[code]  }
  private
   procedure MouseWheelDown(const aCtx: TtfwContext;
    aControl: TWinControl);
    {* Реализация слова скрипта pop:Control:MouseWheelDown }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseWheelDown

 TkwPopControlSetFocus = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:SetFocus
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:SetFocus >>> l_Boolean
[code]  }
  private
   function SetFocus(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* Реализация слова скрипта pop:Control:SetFocus }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlSetFocus

 TkwPopControlMouseLeftDragAndDrop = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Control:MouseLeftDragAndDrop
*Пример:*
[code]
 aPoint aDelta aControl pop:Control:MouseLeftDragAndDrop
[code]  }
  private
   procedure MouseLeftDragAndDrop(const aCtx: TtfwContext;
    aControl: TWinControl;
    const aDelta: TPoint;
    const aPoint: TPoint);
    {* Реализация слова скрипта pop:Control:MouseLeftDragAndDrop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlMouseLeftDragAndDrop

 TkwPopControlControlCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:ControlCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl pop:Control:ControlCount >>> l_Integer
[code]  }
  private
   function ControlCount(const aCtx: TtfwContext;
    aControl: TWinControl): Integer;
    {* Реализация слова скрипта pop:Control:ControlCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlControlCount

 TkwPopControlHandle = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Handle
*Тип результата:* Cardinal
*Пример:*
[code]
CARDINAL VAR l_Cardinal
 aControl pop:Control:Handle >>> l_Cardinal
[code]  }
  private
   function Handle(const aCtx: TtfwContext;
    aControl: TWinControl): Cardinal;
    {* Реализация слова скрипта pop:Control:Handle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHandle

 TkwPopControlFocused = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:Focused
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:Focused >>> l_Boolean
[code]  }
  private
   function Focused(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* Реализация слова скрипта pop:Control:Focused }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlFocused

 TkwPopControlCanFocus = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:CanFocus
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:CanFocus >>> l_Boolean
[code]  }
  private
   function CanFocus(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* Реализация слова скрипта pop:Control:CanFocus }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlCanFocus

procedure TkwPopControlMouseLeftClick.MouseLeftClick(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aPoint: TPoint);
 {* Реализация слова скрипта pop:Control:MouseLeftClick }
//#UC START# *D86EEEFC03D7_207CDF6BFC46_var*
var
 l_Pos      : TPoint;
 l_MousePos : TSmallPoint;
//#UC END# *D86EEEFC03D7_207CDF6BFC46_var*
begin
//#UC START# *D86EEEFC03D7_207CDF6BFC46_impl*
 with aControl.BoundsRect do
  l_Pos := Point(Left + aPoint.X, Top + aPoint.Y);
 l_MousePos := PointToSmallPoint(l_Pos);

 SendMessage(aControl.Handle, WM_LBUTTONDOWN, 0, Longint(l_MousePos));
 SendMessage(aControl.Handle, WM_LBUTTONUP, 0, Longint(l_MousePos));
//#UC END# *D86EEEFC03D7_207CDF6BFC46_impl*
end;//TkwPopControlMouseLeftClick.MouseLeftClick

procedure TkwPopControlMouseLeftClick.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
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
 MouseLeftClick(aCtx, l_aControl, l_aPoint);
end;//TkwPopControlMouseLeftClick.DoDoIt

class function TkwPopControlMouseLeftClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseLeftClick';
end;//TkwPopControlMouseLeftClick.GetWordNameForRegister

function TkwPopControlMouseLeftClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseLeftClick.GetResultTypeInfo

function TkwPopControlMouseLeftClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlMouseLeftClick.GetAllParamsCount

function TkwPopControlMouseLeftClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiStruct]);
end;//TkwPopControlMouseLeftClick.ParamsTypes

procedure TkwPopControlMouseMiddleClick.MouseMiddleClick(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aPoint: TPoint);
 {* Реализация слова скрипта pop:Control:MouseMiddleClick }
//#UC START# *0EBF330C06BD_652B805E6BDC_var*
var
 l_Pos      : TPoint;
 l_MousePos : TSmallPoint;
//#UC END# *0EBF330C06BD_652B805E6BDC_var*
begin
//#UC START# *0EBF330C06BD_652B805E6BDC_impl*
 with aControl.BoundsRect do
  l_Pos := Point(Left + aPoint.X, Top + aPoint.Y);
 l_MousePos := PointToSmallPoint(l_Pos);

 SendMessage(aControl.Handle, WM_MBUTTONDOWN, 0, Longint(l_MousePos));
 SendMessage(aControl.Handle, WM_MBUTTONUP, 0, Longint(l_MousePos));
//#UC END# *0EBF330C06BD_652B805E6BDC_impl*
end;//TkwPopControlMouseMiddleClick.MouseMiddleClick

procedure TkwPopControlMouseMiddleClick.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
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
 MouseMiddleClick(aCtx, l_aControl, l_aPoint);
end;//TkwPopControlMouseMiddleClick.DoDoIt

class function TkwPopControlMouseMiddleClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseMiddleClick';
end;//TkwPopControlMouseMiddleClick.GetWordNameForRegister

function TkwPopControlMouseMiddleClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseMiddleClick.GetResultTypeInfo

function TkwPopControlMouseMiddleClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlMouseMiddleClick.GetAllParamsCount

function TkwPopControlMouseMiddleClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiStruct]);
end;//TkwPopControlMouseMiddleClick.ParamsTypes

procedure TkwPopControlMouseRightClick.MouseRightClick(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aPoint: TPoint);
 {* Реализация слова скрипта pop:Control:MouseRightClick }
//#UC START# *700C331C0034_01A83C03B567_var*
var
 l_Pos      : TPoint;
 l_MousePos : TSmallPoint;
//#UC END# *700C331C0034_01A83C03B567_var*
begin
//#UC START# *700C331C0034_01A83C03B567_impl*
 with aControl.BoundsRect do
  l_Pos := Point(Left + aPoint.X, Top + aPoint.Y);
 l_MousePos := PointToSmallPoint(l_Pos);

 SendMessage(aControl.Handle, WM_RBUTTONDOWN, 0, Longint(l_MousePos));
 SendMessage(aControl.Handle, WM_RBUTTONUP, 0, Longint(l_MousePos));
//#UC END# *700C331C0034_01A83C03B567_impl*
end;//TkwPopControlMouseRightClick.MouseRightClick

procedure TkwPopControlMouseRightClick.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
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
 MouseRightClick(aCtx, l_aControl, l_aPoint);
end;//TkwPopControlMouseRightClick.DoDoIt

class function TkwPopControlMouseRightClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseRightClick';
end;//TkwPopControlMouseRightClick.GetWordNameForRegister

function TkwPopControlMouseRightClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseRightClick.GetResultTypeInfo

function TkwPopControlMouseRightClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlMouseRightClick.GetAllParamsCount

function TkwPopControlMouseRightClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiStruct]);
end;//TkwPopControlMouseRightClick.ParamsTypes

function TkwPopControlFindControlByName.FindControlByName(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aName: AnsiString): TComponent;
 {* Реализация слова скрипта pop:Control:FindControlByName }
//#UC START# *50D08C92A338_89E1228A3BE4_var*
 function DoFindControl(aControl: TWinControl): TComponent{TControl};
 var
  l_Index : Integer;
  l_C : TControl;
  l_Cmp : TComponent;
 begin//DoFindControl
  if (aControl.Name = aName) then
   Result := aControl
  else
  begin
   Result := nil;
   for l_Index := 0 to Pred(aControl.ControlCount) do
   begin
    l_C := aControl.Controls[l_Index];
    if (l_C.Name = aName) then
    begin
     Result := l_C;
     Exit;
    end//l_C.Name = l_Name
    else
    begin
     if (l_C Is TWinControl) then
     begin
      Result := DoFindControl(TWinControl(l_C));
      if (Result <> nil) then
       Exit;
     end;//l_C Is TWinControl
    end;//l_C.Name = l_Name
   end;//for l_Index
   if (Result = nil) then
    for l_Index := 0 to Pred(aControl.ComponentCount) do
    begin
     l_Cmp := aControl.Components[l_Index];
     if (l_Cmp Is TControl) AND (l_Cmp.Name = aName) then
     begin
      Result := {TControl}(l_Cmp);
      Exit;
     end//l_C.Name = aName
     else
     if (l_Cmp Is TWinControl) then
     begin
      Result := DoFindControl(TWinControl(l_Cmp));
      if (Result <> nil) then
       Exit;
     end;//l_C Is TWinControl
     Result := l_Cmp.FindComponent(aName);
     if (Result <> nil) then
      Exit;
     if (l_Cmp.Name = aName) then
     begin
      Result := l_Cmp;
      Exit;
     end;//l_C.Name = aName
    end;//for l_Index
  end;//aControl.Name = l_Name
 end;//DoFindControl
//#UC END# *50D08C92A338_89E1228A3BE4_var*
begin
//#UC START# *50D08C92A338_89E1228A3BE4_impl*
 Result := DoFindControl(aControl);
//#UC END# *50D08C92A338_89E1228A3BE4_impl*
end;//TkwPopControlFindControlByName.FindControlByName

procedure TkwPopControlFindControlByName.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aName: AnsiString;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindControlByName(aCtx, l_aControl, l_aName));
end;//TkwPopControlFindControlByName.DoDoIt

class function TkwPopControlFindControlByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:FindControlByName';
end;//TkwPopControlFindControlByName.GetWordNameForRegister

function TkwPopControlFindControlByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComponent);
end;//TkwPopControlFindControlByName.GetResultTypeInfo

function TkwPopControlFindControlByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlFindControlByName.GetAllParamsCount

function TkwPopControlFindControlByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiString]);
end;//TkwPopControlFindControlByName.ParamsTypes

function TkwPopControlGetControl.GetControl(const aCtx: TtfwContext;
 aControl: TWinControl;
 anIndex: Integer): TControl;
 {* Реализация слова скрипта pop:Control:GetControl }
//#UC START# *F53158879374_0EDEBD14C685_var*
//#UC END# *F53158879374_0EDEBD14C685_var*
begin
//#UC START# *F53158879374_0EDEBD14C685_impl*
 Result := aControl.Controls[anIndex];
//#UC END# *F53158879374_0EDEBD14C685_impl*
end;//TkwPopControlGetControl.GetControl

procedure TkwPopControlGetControl.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_anIndex: Integer;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetControl(aCtx, l_aControl, l_anIndex));
end;//TkwPopControlGetControl.DoDoIt

class function TkwPopControlGetControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:GetControl';
end;//TkwPopControlGetControl.GetWordNameForRegister

function TkwPopControlGetControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwPopControlGetControl.GetResultTypeInfo

function TkwPopControlGetControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopControlGetControl.GetAllParamsCount

function TkwPopControlGetControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), TypeInfo(Integer)]);
end;//TkwPopControlGetControl.ParamsTypes

procedure TkwPopControlMouseWheelUp.MouseWheelUp(const aCtx: TtfwContext;
 aControl: TWinControl);
 {* Реализация слова скрипта pop:Control:MouseWheelUp }
//#UC START# *2F3D3440A024_60259FDDB2DC_var*
//#UC END# *2F3D3440A024_60259FDDB2DC_var*
begin
//#UC START# *2F3D3440A024_60259FDDB2DC_impl*
 SendMessage(aControl.Handle, WM_VSCROLL, MakeWParam(SB_LINEUP, 0), 0);
//#UC END# *2F3D3440A024_60259FDDB2DC_impl*
end;//TkwPopControlMouseWheelUp.MouseWheelUp

procedure TkwPopControlMouseWheelUp.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MouseWheelUp(aCtx, l_aControl);
end;//TkwPopControlMouseWheelUp.DoDoIt

class function TkwPopControlMouseWheelUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseWheelUp';
end;//TkwPopControlMouseWheelUp.GetWordNameForRegister

function TkwPopControlMouseWheelUp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseWheelUp.GetResultTypeInfo

function TkwPopControlMouseWheelUp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlMouseWheelUp.GetAllParamsCount

function TkwPopControlMouseWheelUp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlMouseWheelUp.ParamsTypes

procedure TkwPopControlMouseWheelDown.MouseWheelDown(const aCtx: TtfwContext;
 aControl: TWinControl);
 {* Реализация слова скрипта pop:Control:MouseWheelDown }
//#UC START# *31CD1215C543_5676987B6AD8_var*
//#UC END# *31CD1215C543_5676987B6AD8_var*
begin
//#UC START# *31CD1215C543_5676987B6AD8_impl*
 SendMessage(aControl.Handle, WM_VSCROLL, MakeWParam(SB_LINEDOWN, 0), 0);
//#UC END# *31CD1215C543_5676987B6AD8_impl*
end;//TkwPopControlMouseWheelDown.MouseWheelDown

procedure TkwPopControlMouseWheelDown.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MouseWheelDown(aCtx, l_aControl);
end;//TkwPopControlMouseWheelDown.DoDoIt

class function TkwPopControlMouseWheelDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseWheelDown';
end;//TkwPopControlMouseWheelDown.GetWordNameForRegister

function TkwPopControlMouseWheelDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseWheelDown.GetResultTypeInfo

function TkwPopControlMouseWheelDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlMouseWheelDown.GetAllParamsCount

function TkwPopControlMouseWheelDown.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlMouseWheelDown.ParamsTypes

function TkwPopControlSetFocus.SetFocus(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* Реализация слова скрипта pop:Control:SetFocus }
//#UC START# *E30431C2D5CE_52E34524FDF7_var*
//#UC END# *E30431C2D5CE_52E34524FDF7_var*
begin
//#UC START# *E30431C2D5CE_52E34524FDF7_impl*
 if aControl.CanFocus then
  aControl.SetFocus;
 Result := aControl.Focused;
//#UC END# *E30431C2D5CE_52E34524FDF7_impl*
end;//TkwPopControlSetFocus.SetFocus

procedure TkwPopControlSetFocus.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(SetFocus(aCtx, l_aControl));
end;//TkwPopControlSetFocus.DoDoIt

class function TkwPopControlSetFocus.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:SetFocus';
end;//TkwPopControlSetFocus.GetWordNameForRegister

function TkwPopControlSetFocus.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlSetFocus.GetResultTypeInfo

function TkwPopControlSetFocus.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlSetFocus.GetAllParamsCount

function TkwPopControlSetFocus.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlSetFocus.ParamsTypes

procedure TkwPopControlMouseLeftDragAndDrop.MouseLeftDragAndDrop(const aCtx: TtfwContext;
 aControl: TWinControl;
 const aDelta: TPoint;
 const aPoint: TPoint);
 {* Реализация слова скрипта pop:Control:MouseLeftDragAndDrop }
//#UC START# *E69FBA5A5B0F_7A8A3BB834BD_var*
var
 l_Pos       : TPoint;
 l_Pos1      : TPoint;
 l_MousePos  : TSmallPoint;
 l_MousePos1 : TSmallPoint;
//#UC END# *E69FBA5A5B0F_7A8A3BB834BD_var*
begin
//#UC START# *E69FBA5A5B0F_7A8A3BB834BD_impl*
 with aControl.BoundsRect do
 begin
  l_Pos := Point(Left + aPoint.X, Top + aPoint.Y);
  l_Pos1 := Point(l_Pos.X + aDelta.X, l_Pos.Y + aDelta.Y);
 end;//with aControl.BoundsRect 
 l_MousePos := PointToSmallPoint(l_Pos);
 l_MousePos1 := PointToSmallPoint(l_Pos1);

 SendMessage(aControl.Handle, WM_LBUTTONDOWN, 0, Longint(l_MousePos));
 SendMessage(aControl.Handle, WM_MOUSEMOVE, 0, Longint(l_MousePos1));
 SendMessage(aControl.Handle, WM_LBUTTONUP, 0, Longint(l_MousePos1));
//#UC END# *E69FBA5A5B0F_7A8A3BB834BD_impl*
end;//TkwPopControlMouseLeftDragAndDrop.MouseLeftDragAndDrop

procedure TkwPopControlMouseLeftDragAndDrop.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
var l_aDelta: TPoint;
var l_aPoint: TPoint;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDelta := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDelta: TPoint : ' + E.Message, aCtx);
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
 MouseLeftDragAndDrop(aCtx, l_aControl, l_aDelta, l_aPoint);
end;//TkwPopControlMouseLeftDragAndDrop.DoDoIt

class function TkwPopControlMouseLeftDragAndDrop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:MouseLeftDragAndDrop';
end;//TkwPopControlMouseLeftDragAndDrop.GetWordNameForRegister

function TkwPopControlMouseLeftDragAndDrop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopControlMouseLeftDragAndDrop.GetResultTypeInfo

function TkwPopControlMouseLeftDragAndDrop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopControlMouseLeftDragAndDrop.GetAllParamsCount

function TkwPopControlMouseLeftDragAndDrop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl), @tfw_tiStruct, @tfw_tiStruct]);
end;//TkwPopControlMouseLeftDragAndDrop.ParamsTypes

function TkwPopControlControlCount.ControlCount(const aCtx: TtfwContext;
 aControl: TWinControl): Integer;
 {* Реализация слова скрипта pop:Control:ControlCount }
begin
 Result := aControl.ControlCount;
end;//TkwPopControlControlCount.ControlCount

procedure TkwPopControlControlCount.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ControlCount(aCtx, l_aControl));
end;//TkwPopControlControlCount.DoDoIt

class function TkwPopControlControlCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:ControlCount';
end;//TkwPopControlControlCount.GetWordNameForRegister

procedure TkwPopControlControlCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ControlCount', aCtx);
end;//TkwPopControlControlCount.SetValuePrim

function TkwPopControlControlCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopControlControlCount.GetResultTypeInfo

function TkwPopControlControlCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlControlCount.GetAllParamsCount

function TkwPopControlControlCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlControlCount.ParamsTypes

function TkwPopControlHandle.Handle(const aCtx: TtfwContext;
 aControl: TWinControl): Cardinal;
 {* Реализация слова скрипта pop:Control:Handle }
begin
 Result := aControl.Handle;
end;//TkwPopControlHandle.Handle

procedure TkwPopControlHandle.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Handle(aCtx, l_aControl)));
end;//TkwPopControlHandle.DoDoIt

class function TkwPopControlHandle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Handle';
end;//TkwPopControlHandle.GetWordNameForRegister

procedure TkwPopControlHandle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Handle', aCtx);
end;//TkwPopControlHandle.SetValuePrim

function TkwPopControlHandle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Cardinal);
end;//TkwPopControlHandle.GetResultTypeInfo

function TkwPopControlHandle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHandle.GetAllParamsCount

function TkwPopControlHandle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlHandle.ParamsTypes

function TkwPopControlFocused.Focused(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* Реализация слова скрипта pop:Control:Focused }
begin
 Result := aControl.Focused;
end;//TkwPopControlFocused.Focused

procedure TkwPopControlFocused.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Focused(aCtx, l_aControl));
end;//TkwPopControlFocused.DoDoIt

class function TkwPopControlFocused.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:Focused';
end;//TkwPopControlFocused.GetWordNameForRegister

procedure TkwPopControlFocused.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Focused', aCtx);
end;//TkwPopControlFocused.SetValuePrim

function TkwPopControlFocused.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlFocused.GetResultTypeInfo

function TkwPopControlFocused.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlFocused.GetAllParamsCount

function TkwPopControlFocused.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlFocused.ParamsTypes

function TkwPopControlCanFocus.CanFocus(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* Реализация слова скрипта pop:Control:CanFocus }
begin
 Result := aControl.CanFocus;
end;//TkwPopControlCanFocus.CanFocus

procedure TkwPopControlCanFocus.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(CanFocus(aCtx, l_aControl));
end;//TkwPopControlCanFocus.DoDoIt

class function TkwPopControlCanFocus.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:CanFocus';
end;//TkwPopControlCanFocus.GetWordNameForRegister

procedure TkwPopControlCanFocus.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CanFocus', aCtx);
end;//TkwPopControlCanFocus.SetValuePrim

function TkwPopControlCanFocus.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlCanFocus.GetResultTypeInfo

function TkwPopControlCanFocus.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlCanFocus.GetAllParamsCount

function TkwPopControlCanFocus.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlCanFocus.ParamsTypes

initialization
 TkwPopControlMouseLeftClick.RegisterInEngine;
 {* Регистрация pop_Control_MouseLeftClick }
 TkwPopControlMouseMiddleClick.RegisterInEngine;
 {* Регистрация pop_Control_MouseMiddleClick }
 TkwPopControlMouseRightClick.RegisterInEngine;
 {* Регистрация pop_Control_MouseRightClick }
 TkwPopControlFindControlByName.RegisterInEngine;
 {* Регистрация pop_Control_FindControlByName }
 TkwPopControlGetControl.RegisterInEngine;
 {* Регистрация pop_Control_GetControl }
 TkwPopControlMouseWheelUp.RegisterInEngine;
 {* Регистрация pop_Control_MouseWheelUp }
 TkwPopControlMouseWheelDown.RegisterInEngine;
 {* Регистрация pop_Control_MouseWheelDown }
 TkwPopControlSetFocus.RegisterInEngine;
 {* Регистрация pop_Control_SetFocus }
 TkwPopControlMouseLeftDragAndDrop.RegisterInEngine;
 {* Регистрация pop_Control_MouseLeftDragAndDrop }
 TkwPopControlControlCount.RegisterInEngine;
 {* Регистрация pop_Control_ControlCount }
 TkwPopControlHandle.RegisterInEngine;
 {* Регистрация pop_Control_Handle }
 TkwPopControlFocused.RegisterInEngine;
 {* Регистрация pop_Control_Focused }
 TkwPopControlCanFocus.RegisterInEngine;
 {* Регистрация pop_Control_CanFocus }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
 {* Регистрация типа TWinControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TPoint }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* Регистрация типа TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Cardinal));
 {* Регистрация типа Cardinal }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
