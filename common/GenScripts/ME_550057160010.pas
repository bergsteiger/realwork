unit RemindersLineWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vgRemindersLine
 , tfwClassLike
 , Types
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TvgRemindersLineFriend = {abstract} class(TvgRemindersLine)
  {* ���� ��� TvgRemindersLine }
 end;//TvgRemindersLineFriend

 TkwPopRemindersLineClientToScreen = {final} class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:ClientToScreen
*��� ����������:* TPoint
*������:*
[code]
VAR l_TPoint
 aPoint aRemindersLine pop:RemindersLine:ClientToScreen >>> l_TPoint
[code]  }
  private
   function ClientToScreen(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    const aPoint: TPoint): TPoint;
    {* ���������� ����� ������� pop:RemindersLine:ClientToScreen }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineClientToScreen

 TkwPopRemindersLineGetReminder = {final} class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:GetReminder
*��� ����������:* TvgReminder
*������:*
[code]
OBJECT VAR l_TvgReminder
 anIndex aRemindersLine pop:RemindersLine:GetReminder >>> l_TvgReminder
[code]  }
  private
   function GetReminder(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    anIndex: Integer): TvgReminder;
    {* ���������� ����� ������� pop:RemindersLine:GetReminder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineGetReminder

 TkwPopRemindersLineAbsLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsLeft
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsLeft >>> l_Integer
[code]  }
  private
   function AbsLeft(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineAbsLeft

 TkwPopRemindersLineAbsTop = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsTop
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:AbsTop >>> l_Integer
[code]  }
  private
   function AbsTop(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:AbsTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineAbsTop

 TkwPopRemindersLineCount = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Count
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Count >>> l_Integer
[code]  }
  private
   function Count(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Count }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineCount

 TkwPopRemindersLineHeight = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Height
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Height >>> l_Integer
[code]  }
  private
   function Height(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Height }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineHeight

 TkwPopRemindersLineLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Left
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Left >>> l_Integer
[code]  }
  private
   function Left(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Left }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineLeft

 TkwPopRemindersLineTop = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Top
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Top >>> l_Integer
[code]  }
  private
   function Top(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Top }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineTop

 TkwPopRemindersLineVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Visible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aRemindersLine pop:RemindersLine:Visible >>> l_Boolean
[code]  }
  private
   function Visible(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Boolean;
    {* ���������� ����� ������� pop:RemindersLine:Visible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineVisible

 TkwPopRemindersLineWidth = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Width
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aRemindersLine pop:RemindersLine:Width >>> l_Integer
[code]  }
  private
   function Width(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Width }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineWidth

function TkwPopRemindersLineClientToScreen.ClientToScreen(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine;
 const aPoint: TPoint): TPoint;
 {* ���������� ����� ������� pop:RemindersLine:ClientToScreen }
//#UC START# *49A3CD754B3E_9653AE4CDED4_var*
//#UC END# *49A3CD754B3E_9653AE4CDED4_var*
begin
//#UC START# *49A3CD754B3E_9653AE4CDED4_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.ClientToScreen(aPoint);
//#UC END# *49A3CD754B3E_9653AE4CDED4_impl*
end;//TkwPopRemindersLineClientToScreen.ClientToScreen

procedure TkwPopRemindersLineClientToScreen.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
var l_aPoint: TPoint;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPoint := aCtx.rEngine.PopPoint;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aPoint: TPoint : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushPoint(ClientToScreen(aCtx, l_aRemindersLine, l_aPoint));
end;//TkwPopRemindersLineClientToScreen.DoDoIt

class function TkwPopRemindersLineClientToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:ClientToScreen';
end;//TkwPopRemindersLineClientToScreen.GetWordNameForRegister

function TkwPopRemindersLineClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwPopRemindersLineClientToScreen.GetResultTypeInfo

function TkwPopRemindersLineClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopRemindersLineClientToScreen.GetAllParamsCount

function TkwPopRemindersLineClientToScreen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine), @tfw_tiStruct]);
end;//TkwPopRemindersLineClientToScreen.ParamsTypes

function TkwPopRemindersLineGetReminder.GetReminder(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine;
 anIndex: Integer): TvgReminder;
 {* ���������� ����� ������� pop:RemindersLine:GetReminder }
//#UC START# *E8E2745918DB_FF04F6E03205_var*
//#UC END# *E8E2745918DB_FF04F6E03205_var*
begin
//#UC START# *E8E2745918DB_FF04F6E03205_impl*
 RunnerAssert(anIndex >= 0, '������ �� ����� ���� �������������', aCtx);
 RunnerAssert(anIndex < aRemindersLine.Count, '������ �� ����� ���� ������ ���������� �������', aCtx);
 Result := aRemindersLine.Reminder[anIndex];
//#UC END# *E8E2745918DB_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.GetReminder

procedure TkwPopRemindersLineGetReminder.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
var l_anIndex: Integer;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetReminder(aCtx, l_aRemindersLine, l_anIndex));
end;//TkwPopRemindersLineGetReminder.DoDoIt

class function TkwPopRemindersLineGetReminder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:GetReminder';
end;//TkwPopRemindersLineGetReminder.GetWordNameForRegister

function TkwPopRemindersLineGetReminder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgReminder);
end;//TkwPopRemindersLineGetReminder.GetResultTypeInfo

function TkwPopRemindersLineGetReminder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopRemindersLineGetReminder.GetAllParamsCount

function TkwPopRemindersLineGetReminder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine), TypeInfo(Integer)]);
end;//TkwPopRemindersLineGetReminder.ParamsTypes

function TkwPopRemindersLineAbsLeft.AbsLeft(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
begin
 Result := aRemindersLine.AbsLeft;
end;//TkwPopRemindersLineAbsLeft.AbsLeft

procedure TkwPopRemindersLineAbsLeft.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(AbsLeft(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineAbsLeft.DoDoIt

class function TkwPopRemindersLineAbsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsLeft';
end;//TkwPopRemindersLineAbsLeft.GetWordNameForRegister

procedure TkwPopRemindersLineAbsLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AbsLeft', aCtx);
end;//TkwPopRemindersLineAbsLeft.SetValuePrim

function TkwPopRemindersLineAbsLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineAbsLeft.GetResultTypeInfo

function TkwPopRemindersLineAbsLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineAbsLeft.GetAllParamsCount

function TkwPopRemindersLineAbsLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineAbsLeft.ParamsTypes

function TkwPopRemindersLineAbsTop.AbsTop(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsTop }
begin
 Result := aRemindersLine.AbsTop;
end;//TkwPopRemindersLineAbsTop.AbsTop

procedure TkwPopRemindersLineAbsTop.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(AbsTop(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineAbsTop.DoDoIt

class function TkwPopRemindersLineAbsTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsTop';
end;//TkwPopRemindersLineAbsTop.GetWordNameForRegister

procedure TkwPopRemindersLineAbsTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AbsTop', aCtx);
end;//TkwPopRemindersLineAbsTop.SetValuePrim

function TkwPopRemindersLineAbsTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineAbsTop.GetResultTypeInfo

function TkwPopRemindersLineAbsTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineAbsTop.GetAllParamsCount

function TkwPopRemindersLineAbsTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineAbsTop.ParamsTypes

function TkwPopRemindersLineCount.Count(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Count }
begin
 Result := aRemindersLine.Count;
end;//TkwPopRemindersLineCount.Count

procedure TkwPopRemindersLineCount.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Count(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineCount.DoDoIt

class function TkwPopRemindersLineCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Count';
end;//TkwPopRemindersLineCount.GetWordNameForRegister

procedure TkwPopRemindersLineCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Count', aCtx);
end;//TkwPopRemindersLineCount.SetValuePrim

function TkwPopRemindersLineCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineCount.GetResultTypeInfo

function TkwPopRemindersLineCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineCount.GetAllParamsCount

function TkwPopRemindersLineCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineCount.ParamsTypes

function TkwPopRemindersLineHeight.Height(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Height }
begin
 Result := aRemindersLine.Height;
end;//TkwPopRemindersLineHeight.Height

procedure TkwPopRemindersLineHeight.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Height(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineHeight.DoDoIt

class function TkwPopRemindersLineHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Height';
end;//TkwPopRemindersLineHeight.GetWordNameForRegister

procedure TkwPopRemindersLineHeight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Height', aCtx);
end;//TkwPopRemindersLineHeight.SetValuePrim

function TkwPopRemindersLineHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineHeight.GetResultTypeInfo

function TkwPopRemindersLineHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineHeight.GetAllParamsCount

function TkwPopRemindersLineHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineHeight.ParamsTypes

function TkwPopRemindersLineLeft.Left(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Left }
begin
 Result := aRemindersLine.Left;
end;//TkwPopRemindersLineLeft.Left

procedure TkwPopRemindersLineLeft.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Left(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineLeft.DoDoIt

class function TkwPopRemindersLineLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Left';
end;//TkwPopRemindersLineLeft.GetWordNameForRegister

procedure TkwPopRemindersLineLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Left', aCtx);
end;//TkwPopRemindersLineLeft.SetValuePrim

function TkwPopRemindersLineLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineLeft.GetResultTypeInfo

function TkwPopRemindersLineLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineLeft.GetAllParamsCount

function TkwPopRemindersLineLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineLeft.ParamsTypes

function TkwPopRemindersLineTop.Top(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Top }
begin
 Result := aRemindersLine.Top;
end;//TkwPopRemindersLineTop.Top

procedure TkwPopRemindersLineTop.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Top(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineTop.DoDoIt

class function TkwPopRemindersLineTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Top';
end;//TkwPopRemindersLineTop.GetWordNameForRegister

procedure TkwPopRemindersLineTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Top', aCtx);
end;//TkwPopRemindersLineTop.SetValuePrim

function TkwPopRemindersLineTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineTop.GetResultTypeInfo

function TkwPopRemindersLineTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineTop.GetAllParamsCount

function TkwPopRemindersLineTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineTop.ParamsTypes

function TkwPopRemindersLineVisible.Visible(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Boolean;
 {* ���������� ����� ������� pop:RemindersLine:Visible }
//#UC START# *F41481B972B5_002E70A99E5D_var*
//#UC END# *F41481B972B5_002E70A99E5D_var*
begin
//#UC START# *F41481B972B5_002E70A99E5D_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.Visible
//#UC END# *F41481B972B5_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.Visible

procedure TkwPopRemindersLineVisible.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Visible(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineVisible.DoDoIt

class function TkwPopRemindersLineVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Visible';
end;//TkwPopRemindersLineVisible.GetWordNameForRegister

procedure TkwPopRemindersLineVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Visible', aCtx);
end;//TkwPopRemindersLineVisible.SetValuePrim

function TkwPopRemindersLineVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRemindersLineVisible.GetResultTypeInfo

function TkwPopRemindersLineVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineVisible.GetAllParamsCount

function TkwPopRemindersLineVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineVisible.ParamsTypes

function TkwPopRemindersLineWidth.Width(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Width }
begin
 Result := aRemindersLine.Width;
end;//TkwPopRemindersLineWidth.Width

procedure TkwPopRemindersLineWidth.DoDoIt(const aCtx: TtfwContext);
var l_aRemindersLine: TvgRemindersLine;
begin
 try
  l_aRemindersLine := TvgRemindersLine(aCtx.rEngine.PopObjAs(TvgRemindersLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRemindersLine: TvgRemindersLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Width(aCtx, l_aRemindersLine));
end;//TkwPopRemindersLineWidth.DoDoIt

class function TkwPopRemindersLineWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Width';
end;//TkwPopRemindersLineWidth.GetWordNameForRegister

procedure TkwPopRemindersLineWidth.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Width', aCtx);
end;//TkwPopRemindersLineWidth.SetValuePrim

function TkwPopRemindersLineWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopRemindersLineWidth.GetResultTypeInfo

function TkwPopRemindersLineWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRemindersLineWidth.GetAllParamsCount

function TkwPopRemindersLineWidth.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvgRemindersLine)]);
end;//TkwPopRemindersLineWidth.ParamsTypes

initialization
 TkwPopRemindersLineClientToScreen.RegisterInEngine;
 {* ����������� pop_RemindersLine_ClientToScreen }
 TkwPopRemindersLineGetReminder.RegisterInEngine;
 {* ����������� pop_RemindersLine_GetReminder }
 TkwPopRemindersLineAbsLeft.RegisterInEngine;
 {* ����������� pop_RemindersLine_AbsLeft }
 TkwPopRemindersLineAbsTop.RegisterInEngine;
 {* ����������� pop_RemindersLine_AbsTop }
 TkwPopRemindersLineCount.RegisterInEngine;
 {* ����������� pop_RemindersLine_Count }
 TkwPopRemindersLineHeight.RegisterInEngine;
 {* ����������� pop_RemindersLine_Height }
 TkwPopRemindersLineLeft.RegisterInEngine;
 {* ����������� pop_RemindersLine_Left }
 TkwPopRemindersLineTop.RegisterInEngine;
 {* ����������� pop_RemindersLine_Top }
 TkwPopRemindersLineVisible.RegisterInEngine;
 {* ����������� pop_RemindersLine_Visible }
 TkwPopRemindersLineWidth.RegisterInEngine;
 {* ����������� pop_RemindersLine_Width }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgRemindersLine));
 {* ����������� ���� TvgRemindersLine }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
 {* ����������� ���� TvgReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

end.
