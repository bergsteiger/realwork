unit RemindersLineWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "RemindersLineWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::ReminderWords::RemindersLineWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types,
  tfwScriptingInterfaces,
  vgRemindersLine,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TvgRemindersLineFriend = {abstract} class(TvgRemindersLine)
  {* Друг для TvgRemindersLine }
 end;//TvgRemindersLineFriend

 TkwPopRemindersLineClientToScreen = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:RemindersLine:ClientToScreen
*Тип результата:* TPoint
*Пример:*
[code]
VAR l_TPoint
 aPoint aRemindersLine pop:RemindersLine:ClientToScreen >>> l_TPoint
[code]  }
 private
 // private methods
   function ClientToScreen(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    const aPoint: TPoint): TPoint;
     {* Реализация слова скрипта pop:RemindersLine:ClientToScreen }
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
 end;//TkwPopRemindersLineClientToScreen

// start class TkwPopRemindersLineClientToScreen

function TkwPopRemindersLineClientToScreen.ClientToScreen(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine;
  const aPoint: TPoint): TPoint;
//#UC START# *49A3CD754B3E_9653AE4CDED4_var*
//#UC END# *49A3CD754B3E_9653AE4CDED4_var*
begin
//#UC START# *49A3CD754B3E_9653AE4CDED4_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.ClientToScreen(aPoint);
//#UC END# *49A3CD754B3E_9653AE4CDED4_impl*
end;//TkwPopRemindersLineClientToScreen.ClientToScreen

procedure TkwPopRemindersLineClientToScreen.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
 l_aPoint : TPoint;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushPoint((ClientToScreen(aCtx, l_aRemindersLine, l_aPoint)));
end;//TkwPopRemindersLineClientToScreen.DoDoIt

class function TkwPopRemindersLineClientToScreen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:ClientToScreen';
end;//TkwPopRemindersLineClientToScreen.GetWordNameForRegister

function TkwPopRemindersLineClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiStruct;
end;//TkwPopRemindersLineClientToScreen.GetResultTypeInfo

function TkwPopRemindersLineClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopRemindersLineClientToScreen.GetAllParamsCount

function TkwPopRemindersLineClientToScreen.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine), @tfw_tiStruct]);
end;//TkwPopRemindersLineClientToScreen.ParamsTypes

type
 TkwPopRemindersLineGetReminder = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:RemindersLine:GetReminder
*Тип результата:* TvgReminder
*Пример:*
[code]
OBJECT VAR l_TvgReminder
 anIndex aRemindersLine pop:RemindersLine:GetReminder >>> l_TvgReminder
[code]  }
 private
 // private methods
   function GetReminder(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    anIndex: Integer): TvgReminder;
     {* Реализация слова скрипта pop:RemindersLine:GetReminder }
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
 end;//TkwPopRemindersLineGetReminder

// start class TkwPopRemindersLineGetReminder

function TkwPopRemindersLineGetReminder.GetReminder(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine;
  anIndex: Integer): TvgReminder;
//#UC START# *E8E2745918DB_FF04F6E03205_var*
//#UC END# *E8E2745918DB_FF04F6E03205_var*
begin
//#UC START# *E8E2745918DB_FF04F6E03205_impl*
 RunnerAssert(anIndex >= 0, 'Индекс не может быть отрицательным', aCtx);
 RunnerAssert(anIndex < aRemindersLine.Count, 'Индекс не может быть больше количества медалей', aCtx);
 Result := aRemindersLine.Reminder[anIndex];
//#UC END# *E8E2745918DB_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.GetReminder

procedure TkwPopRemindersLineGetReminder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
 l_anIndex : Integer;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((GetReminder(aCtx, l_aRemindersLine, l_anIndex)));
end;//TkwPopRemindersLineGetReminder.DoDoIt

class function TkwPopRemindersLineGetReminder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:GetReminder';
end;//TkwPopRemindersLineGetReminder.GetWordNameForRegister

function TkwPopRemindersLineGetReminder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvgReminder);
end;//TkwPopRemindersLineGetReminder.GetResultTypeInfo

function TkwPopRemindersLineGetReminder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopRemindersLineGetReminder.GetAllParamsCount

function TkwPopRemindersLineGetReminder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine), TypeInfo(Integer)]);
end;//TkwPopRemindersLineGetReminder.ParamsTypes

type
 TkwPopRemindersLineAbsLeft = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:AbsLeft
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsLeft >>> l_Integer
[code]  }
 private
 // private methods
   function AbsLeft(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:AbsLeft }
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
 end;//TkwPopRemindersLineAbsLeft

// start class TkwPopRemindersLineAbsLeft

function TkwPopRemindersLineAbsLeft.AbsLeft(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.AbsLeft;
end;//TkwPopRemindersLineAbsLeft.AbsLeft

procedure TkwPopRemindersLineAbsLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((AbsLeft(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineAbsLeft.DoDoIt

class function TkwPopRemindersLineAbsLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:AbsLeft';
end;//TkwPopRemindersLineAbsLeft.GetWordNameForRegister

procedure TkwPopRemindersLineAbsLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству AbsLeft', aCtx);
end;//TkwPopRemindersLineAbsLeft.SetValuePrim

function TkwPopRemindersLineAbsLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineAbsLeft.GetResultTypeInfo

function TkwPopRemindersLineAbsLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineAbsLeft.GetAllParamsCount

function TkwPopRemindersLineAbsLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineAbsLeft.ParamsTypes

type
 TkwPopRemindersLineAbsTop = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:AbsTop
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsTop >>> l_Integer
[code]  }
 private
 // private methods
   function AbsTop(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:AbsTop }
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
 end;//TkwPopRemindersLineAbsTop

// start class TkwPopRemindersLineAbsTop

function TkwPopRemindersLineAbsTop.AbsTop(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.AbsTop;
end;//TkwPopRemindersLineAbsTop.AbsTop

procedure TkwPopRemindersLineAbsTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((AbsTop(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineAbsTop.DoDoIt

class function TkwPopRemindersLineAbsTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:AbsTop';
end;//TkwPopRemindersLineAbsTop.GetWordNameForRegister

procedure TkwPopRemindersLineAbsTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству AbsTop', aCtx);
end;//TkwPopRemindersLineAbsTop.SetValuePrim

function TkwPopRemindersLineAbsTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineAbsTop.GetResultTypeInfo

function TkwPopRemindersLineAbsTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineAbsTop.GetAllParamsCount

function TkwPopRemindersLineAbsTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineAbsTop.ParamsTypes

type
 TkwPopRemindersLineCount = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Count >>> l_Integer
[code]  }
 private
 // private methods
   function Count(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:Count }
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
 end;//TkwPopRemindersLineCount

// start class TkwPopRemindersLineCount

function TkwPopRemindersLineCount.Count(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.Count;
end;//TkwPopRemindersLineCount.Count

procedure TkwPopRemindersLineCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Count(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineCount.DoDoIt

class function TkwPopRemindersLineCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Count';
end;//TkwPopRemindersLineCount.GetWordNameForRegister

procedure TkwPopRemindersLineCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwPopRemindersLineCount.SetValuePrim

function TkwPopRemindersLineCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineCount.GetResultTypeInfo

function TkwPopRemindersLineCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineCount.GetAllParamsCount

function TkwPopRemindersLineCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineCount.ParamsTypes

type
 TkwPopRemindersLineHeight = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Height
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Height >>> l_Integer
[code]  }
 private
 // private methods
   function Height(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:Height }
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
 end;//TkwPopRemindersLineHeight

// start class TkwPopRemindersLineHeight

function TkwPopRemindersLineHeight.Height(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.Height;
end;//TkwPopRemindersLineHeight.Height

procedure TkwPopRemindersLineHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Height(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineHeight.DoDoIt

class function TkwPopRemindersLineHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Height';
end;//TkwPopRemindersLineHeight.GetWordNameForRegister

procedure TkwPopRemindersLineHeight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Height', aCtx);
end;//TkwPopRemindersLineHeight.SetValuePrim

function TkwPopRemindersLineHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineHeight.GetResultTypeInfo

function TkwPopRemindersLineHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineHeight.GetAllParamsCount

function TkwPopRemindersLineHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineHeight.ParamsTypes

type
 TkwPopRemindersLineLeft = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Left
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Left >>> l_Integer
[code]  }
 private
 // private methods
   function Left(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:Left }
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
 end;//TkwPopRemindersLineLeft

// start class TkwPopRemindersLineLeft

function TkwPopRemindersLineLeft.Left(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.Left;
end;//TkwPopRemindersLineLeft.Left

procedure TkwPopRemindersLineLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Left(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineLeft.DoDoIt

class function TkwPopRemindersLineLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Left';
end;//TkwPopRemindersLineLeft.GetWordNameForRegister

procedure TkwPopRemindersLineLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Left', aCtx);
end;//TkwPopRemindersLineLeft.SetValuePrim

function TkwPopRemindersLineLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineLeft.GetResultTypeInfo

function TkwPopRemindersLineLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineLeft.GetAllParamsCount

function TkwPopRemindersLineLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineLeft.ParamsTypes

type
 TkwPopRemindersLineTop = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Top
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Top >>> l_Integer
[code]  }
 private
 // private methods
   function Top(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:Top }
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
 end;//TkwPopRemindersLineTop

// start class TkwPopRemindersLineTop

function TkwPopRemindersLineTop.Top(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.Top;
end;//TkwPopRemindersLineTop.Top

procedure TkwPopRemindersLineTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Top(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineTop.DoDoIt

class function TkwPopRemindersLineTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Top';
end;//TkwPopRemindersLineTop.GetWordNameForRegister

procedure TkwPopRemindersLineTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Top', aCtx);
end;//TkwPopRemindersLineTop.SetValuePrim

function TkwPopRemindersLineTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineTop.GetResultTypeInfo

function TkwPopRemindersLineTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineTop.GetAllParamsCount

function TkwPopRemindersLineTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineTop.ParamsTypes

type
 TkwPopRemindersLineVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Visible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRemindersLine pop:RemindersLine:Visible >>> l_Boolean
[code]  }
 private
 // private methods
   function Visible(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Boolean;
     {* Реализация слова скрипта pop:RemindersLine:Visible }
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
 end;//TkwPopRemindersLineVisible

// start class TkwPopRemindersLineVisible

function TkwPopRemindersLineVisible.Visible(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Boolean;
//#UC START# *F41481B972B5_002E70A99E5D_var*
//#UC END# *F41481B972B5_002E70A99E5D_var*
begin
//#UC START# *F41481B972B5_002E70A99E5D_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.Visible
//#UC END# *F41481B972B5_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.Visible

procedure TkwPopRemindersLineVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Visible(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineVisible.DoDoIt

class function TkwPopRemindersLineVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Visible';
end;//TkwPopRemindersLineVisible.GetWordNameForRegister

procedure TkwPopRemindersLineVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwPopRemindersLineVisible.SetValuePrim

function TkwPopRemindersLineVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRemindersLineVisible.GetResultTypeInfo

function TkwPopRemindersLineVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineVisible.GetAllParamsCount

function TkwPopRemindersLineVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineVisible.ParamsTypes

type
 TkwPopRemindersLineWidth = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RemindersLine:Width
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Width >>> l_Integer
[code]  }
 private
 // private methods
   function Width(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
     {* Реализация слова скрипта pop:RemindersLine:Width }
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
 end;//TkwPopRemindersLineWidth

// start class TkwPopRemindersLineWidth

function TkwPopRemindersLineWidth.Width(const aCtx: TtfwContext;
  aRemindersLine: TvgRemindersLine): Integer;
 {-}
begin
 Result := aRemindersLine.Width;
end;//TkwPopRemindersLineWidth.Width

procedure TkwPopRemindersLineWidth.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRemindersLine : TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Width(aCtx, l_aRemindersLine)));
end;//TkwPopRemindersLineWidth.DoDoIt

class function TkwPopRemindersLineWidth.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RemindersLine:Width';
end;//TkwPopRemindersLineWidth.GetWordNameForRegister

procedure TkwPopRemindersLineWidth.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Width', aCtx);
end;//TkwPopRemindersLineWidth.SetValuePrim

function TkwPopRemindersLineWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineWidth.GetResultTypeInfo

function TkwPopRemindersLineWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRemindersLineWidth.GetAllParamsCount

function TkwPopRemindersLineWidth.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineWidth.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_ClientToScreen
 TkwPopRemindersLineClientToScreen.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_GetReminder
 TkwPopRemindersLineGetReminder.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_AbsLeft
 TkwPopRemindersLineAbsLeft.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_AbsTop
 TkwPopRemindersLineAbsTop.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Count
 TkwPopRemindersLineCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Height
 TkwPopRemindersLineHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Left
 TkwPopRemindersLineLeft.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Top
 TkwPopRemindersLineTop.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Visible
 TkwPopRemindersLineVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация pop_RemindersLine_Width
 TkwPopRemindersLineWidth.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TvgRemindersLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgRemindersLine));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TPoint
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа TvgReminder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
{$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene

end.