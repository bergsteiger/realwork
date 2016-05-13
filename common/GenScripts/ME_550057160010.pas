unit RemindersLineWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "RemindersLineWordsPack" MUID: (550057160010)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TvgRemindersLineFriend = {abstract} class(TvgRemindersLine)
  {* ���� � ������ TvgRemindersLine }
 end;//TvgRemindersLineFriend

 TkwPopRemindersLineClientToScreen = {final} class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:ClientToScreen }
  private
   function ClientToScreen(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    const aPoint: TPoint): TPoint;
    {* ���������� ����� ������� pop:RemindersLine:ClientToScreen }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineClientToScreen

 TkwPopRemindersLineGetReminder = {final} class(TtfwClassLike)
  {* ����� ������� pop:RemindersLine:GetReminder }
  private
   function GetReminder(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine;
    anIndex: Integer): TvgReminder;
    {* ���������� ����� ������� pop:RemindersLine:GetReminder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRemindersLineGetReminder

 TkwPopRemindersLineAbsLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsLeft }
  private
   function AbsLeft(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineAbsLeft

 TkwPopRemindersLineAbsTop = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:AbsTop }
  private
   function AbsTop(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:AbsTop }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineAbsTop

 TkwPopRemindersLineCount = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Count }
  private
   function Count(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Count }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineCount

 TkwPopRemindersLineHeight = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Height }
  private
   function Height(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Height }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineHeight

 TkwPopRemindersLineLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Left }
  private
   function Left(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Left }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineLeft

 TkwPopRemindersLineTop = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Top }
  private
   function Top(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Top }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineTop

 TkwPopRemindersLineVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Visible }
  private
   function Visible(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Boolean;
    {* ���������� ����� ������� pop:RemindersLine:Visible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineVisible

 TkwPopRemindersLineWidth = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:RemindersLine:Width }
  private
   function Width(const aCtx: TtfwContext;
    aRemindersLine: TvgRemindersLine): Integer;
    {* ���������� ����� ������� pop:RemindersLine:Width }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRemindersLineWidth

function TkwPopRemindersLineClientToScreen.ClientToScreen(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine;
 const aPoint: TPoint): TPoint;
 {* ���������� ����� ������� pop:RemindersLine:ClientToScreen }
//#UC START# *5500582C0070_5500582C0070_532322D901A3_Word_var*
//#UC END# *5500582C0070_5500582C0070_532322D901A3_Word_var*
begin
//#UC START# *5500582C0070_5500582C0070_532322D901A3_Word_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.ClientToScreen(aPoint);
//#UC END# *5500582C0070_5500582C0070_532322D901A3_Word_impl*
end;//TkwPopRemindersLineClientToScreen.ClientToScreen

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

function TkwPopRemindersLineGetReminder.GetReminder(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine;
 anIndex: Integer): TvgReminder;
 {* ���������� ����� ������� pop:RemindersLine:GetReminder }
//#UC START# *550058BD036F_550058BD036F_532322D901A3_Word_var*
//#UC END# *550058BD036F_550058BD036F_532322D901A3_Word_var*
begin
//#UC START# *550058BD036F_550058BD036F_532322D901A3_Word_impl*
 RunnerAssert(anIndex >= 0, '������ �� ����� ���� �������������', aCtx);
 RunnerAssert(anIndex < aRemindersLine.Count, '������ �� ����� ���� ������ ���������� �������', aCtx);
 Result := aRemindersLine.Reminder[anIndex];
//#UC END# *550058BD036F_550058BD036F_532322D901A3_Word_impl*
end;//TkwPopRemindersLineGetReminder.GetReminder

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

function TkwPopRemindersLineAbsLeft.AbsLeft(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
begin
 Result := aRemindersLine.AbsLeft;
end;//TkwPopRemindersLineAbsLeft.AbsLeft

class function TkwPopRemindersLineAbsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsLeft';
end;//TkwPopRemindersLineAbsLeft.GetWordNameForRegister

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

procedure TkwPopRemindersLineAbsLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AbsLeft', aCtx);
end;//TkwPopRemindersLineAbsLeft.SetValuePrim

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

function TkwPopRemindersLineAbsTop.AbsTop(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsTop }
begin
 Result := aRemindersLine.AbsTop;
end;//TkwPopRemindersLineAbsTop.AbsTop

class function TkwPopRemindersLineAbsTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsTop';
end;//TkwPopRemindersLineAbsTop.GetWordNameForRegister

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

procedure TkwPopRemindersLineAbsTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AbsTop', aCtx);
end;//TkwPopRemindersLineAbsTop.SetValuePrim

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

function TkwPopRemindersLineCount.Count(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Count }
begin
 Result := aRemindersLine.Count;
end;//TkwPopRemindersLineCount.Count

class function TkwPopRemindersLineCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Count';
end;//TkwPopRemindersLineCount.GetWordNameForRegister

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

procedure TkwPopRemindersLineCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Count', aCtx);
end;//TkwPopRemindersLineCount.SetValuePrim

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

function TkwPopRemindersLineHeight.Height(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Height }
begin
 Result := aRemindersLine.Height;
end;//TkwPopRemindersLineHeight.Height

class function TkwPopRemindersLineHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Height';
end;//TkwPopRemindersLineHeight.GetWordNameForRegister

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

procedure TkwPopRemindersLineHeight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Height', aCtx);
end;//TkwPopRemindersLineHeight.SetValuePrim

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

function TkwPopRemindersLineLeft.Left(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Left }
begin
 Result := aRemindersLine.Left;
end;//TkwPopRemindersLineLeft.Left

class function TkwPopRemindersLineLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Left';
end;//TkwPopRemindersLineLeft.GetWordNameForRegister

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

procedure TkwPopRemindersLineLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Left', aCtx);
end;//TkwPopRemindersLineLeft.SetValuePrim

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

function TkwPopRemindersLineTop.Top(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Top }
begin
 Result := aRemindersLine.Top;
end;//TkwPopRemindersLineTop.Top

class function TkwPopRemindersLineTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Top';
end;//TkwPopRemindersLineTop.GetWordNameForRegister

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

procedure TkwPopRemindersLineTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Top', aCtx);
end;//TkwPopRemindersLineTop.SetValuePrim

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

function TkwPopRemindersLineVisible.Visible(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Boolean;
 {* ���������� ����� ������� pop:RemindersLine:Visible }
//#UC START# *E53E3CB7238C_E53E3CB7238C_532322D901A3_Word_var*
//#UC END# *E53E3CB7238C_E53E3CB7238C_532322D901A3_Word_var*
begin
//#UC START# *E53E3CB7238C_E53E3CB7238C_532322D901A3_Word_impl*
 Result := TvgRemindersLineFriend(aRemindersLine).Form.Visible
//#UC END# *E53E3CB7238C_E53E3CB7238C_532322D901A3_Word_impl*
end;//TkwPopRemindersLineVisible.Visible

class function TkwPopRemindersLineVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Visible';
end;//TkwPopRemindersLineVisible.GetWordNameForRegister

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

procedure TkwPopRemindersLineVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Visible', aCtx);
end;//TkwPopRemindersLineVisible.SetValuePrim

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

function TkwPopRemindersLineWidth.Width(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Width }
begin
 Result := aRemindersLine.Width;
end;//TkwPopRemindersLineWidth.Width

class function TkwPopRemindersLineWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Width';
end;//TkwPopRemindersLineWidth.GetWordNameForRegister

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

procedure TkwPopRemindersLineWidth.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Width', aCtx);
end;//TkwPopRemindersLineWidth.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgRemindersLine));
 {* ����������� ���� TvgRemindersLine }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TPoint }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgReminder));
 {* ����������� ���� TvgReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

end.
