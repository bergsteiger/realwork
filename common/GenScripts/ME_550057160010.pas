unit RemindersLineWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\RemindersLineWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vgRemindersLine
 , Types
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVGScene) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
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
//#UC START# *4DAEEDE10285_9653AE4CDED4_var*
//#UC END# *4DAEEDE10285_9653AE4CDED4_var*
begin
//#UC START# *4DAEEDE10285_9653AE4CDED4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9653AE4CDED4_impl*
end;//TkwPopRemindersLineClientToScreen.DoDoIt

class function TkwPopRemindersLineClientToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:ClientToScreen';
end;//TkwPopRemindersLineClientToScreen.GetWordNameForRegister

function TkwPopRemindersLineClientToScreen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9653AE4CDED4_var*
//#UC END# *551544E2001A_9653AE4CDED4_var*
begin
//#UC START# *551544E2001A_9653AE4CDED4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9653AE4CDED4_impl*
end;//TkwPopRemindersLineClientToScreen.GetResultTypeInfo

function TkwPopRemindersLineClientToScreen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_9653AE4CDED4_var*
//#UC END# *559687E6025A_9653AE4CDED4_var*
begin
//#UC START# *559687E6025A_9653AE4CDED4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_9653AE4CDED4_impl*
end;//TkwPopRemindersLineClientToScreen.GetAllParamsCount

function TkwPopRemindersLineClientToScreen.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9653AE4CDED4_var*
//#UC END# *5617F4D00243_9653AE4CDED4_var*
begin
//#UC START# *5617F4D00243_9653AE4CDED4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9653AE4CDED4_impl*
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
//#UC START# *4DAEEDE10285_FF04F6E03205_var*
//#UC END# *4DAEEDE10285_FF04F6E03205_var*
begin
//#UC START# *4DAEEDE10285_FF04F6E03205_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.DoDoIt

class function TkwPopRemindersLineGetReminder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:GetReminder';
end;//TkwPopRemindersLineGetReminder.GetWordNameForRegister

function TkwPopRemindersLineGetReminder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FF04F6E03205_var*
//#UC END# *551544E2001A_FF04F6E03205_var*
begin
//#UC START# *551544E2001A_FF04F6E03205_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.GetResultTypeInfo

function TkwPopRemindersLineGetReminder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FF04F6E03205_var*
//#UC END# *559687E6025A_FF04F6E03205_var*
begin
//#UC START# *559687E6025A_FF04F6E03205_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.GetAllParamsCount

function TkwPopRemindersLineGetReminder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FF04F6E03205_var*
//#UC END# *5617F4D00243_FF04F6E03205_var*
begin
//#UC START# *5617F4D00243_FF04F6E03205_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FF04F6E03205_impl*
end;//TkwPopRemindersLineGetReminder.ParamsTypes

function TkwPopRemindersLineAbsLeft.AbsLeft(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsLeft }
//#UC START# *098686462F4C_F126CBF8C36E_var*
//#UC END# *098686462F4C_F126CBF8C36E_var*
begin
//#UC START# *098686462F4C_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *098686462F4C_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.AbsLeft

procedure TkwPopRemindersLineAbsLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F126CBF8C36E_var*
//#UC END# *4DAEEDE10285_F126CBF8C36E_var*
begin
//#UC START# *4DAEEDE10285_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.DoDoIt

class function TkwPopRemindersLineAbsLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsLeft';
end;//TkwPopRemindersLineAbsLeft.GetWordNameForRegister

procedure TkwPopRemindersLineAbsLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F126CBF8C36E_var*
//#UC END# *52D00B00031A_F126CBF8C36E_var*
begin
//#UC START# *52D00B00031A_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.SetValuePrim

function TkwPopRemindersLineAbsLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F126CBF8C36E_var*
//#UC END# *551544E2001A_F126CBF8C36E_var*
begin
//#UC START# *551544E2001A_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.GetResultTypeInfo

function TkwPopRemindersLineAbsLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F126CBF8C36E_var*
//#UC END# *559687E6025A_F126CBF8C36E_var*
begin
//#UC START# *559687E6025A_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.GetAllParamsCount

function TkwPopRemindersLineAbsLeft.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F126CBF8C36E_var*
//#UC END# *5617F4D00243_F126CBF8C36E_var*
begin
//#UC START# *5617F4D00243_F126CBF8C36E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F126CBF8C36E_impl*
end;//TkwPopRemindersLineAbsLeft.ParamsTypes

function TkwPopRemindersLineAbsTop.AbsTop(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:AbsTop }
//#UC START# *0D9680EB1A19_1F4F64719530_var*
//#UC END# *0D9680EB1A19_1F4F64719530_var*
begin
//#UC START# *0D9680EB1A19_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D9680EB1A19_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.AbsTop

procedure TkwPopRemindersLineAbsTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1F4F64719530_var*
//#UC END# *4DAEEDE10285_1F4F64719530_var*
begin
//#UC START# *4DAEEDE10285_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.DoDoIt

class function TkwPopRemindersLineAbsTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:AbsTop';
end;//TkwPopRemindersLineAbsTop.GetWordNameForRegister

procedure TkwPopRemindersLineAbsTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1F4F64719530_var*
//#UC END# *52D00B00031A_1F4F64719530_var*
begin
//#UC START# *52D00B00031A_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.SetValuePrim

function TkwPopRemindersLineAbsTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1F4F64719530_var*
//#UC END# *551544E2001A_1F4F64719530_var*
begin
//#UC START# *551544E2001A_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.GetResultTypeInfo

function TkwPopRemindersLineAbsTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1F4F64719530_var*
//#UC END# *559687E6025A_1F4F64719530_var*
begin
//#UC START# *559687E6025A_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.GetAllParamsCount

function TkwPopRemindersLineAbsTop.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1F4F64719530_var*
//#UC END# *5617F4D00243_1F4F64719530_var*
begin
//#UC START# *5617F4D00243_1F4F64719530_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1F4F64719530_impl*
end;//TkwPopRemindersLineAbsTop.ParamsTypes

function TkwPopRemindersLineCount.Count(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Count }
//#UC START# *8837FD9CBC1A_445623FA8275_var*
//#UC END# *8837FD9CBC1A_445623FA8275_var*
begin
//#UC START# *8837FD9CBC1A_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *8837FD9CBC1A_445623FA8275_impl*
end;//TkwPopRemindersLineCount.Count

procedure TkwPopRemindersLineCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_445623FA8275_var*
//#UC END# *4DAEEDE10285_445623FA8275_var*
begin
//#UC START# *4DAEEDE10285_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_445623FA8275_impl*
end;//TkwPopRemindersLineCount.DoDoIt

class function TkwPopRemindersLineCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Count';
end;//TkwPopRemindersLineCount.GetWordNameForRegister

procedure TkwPopRemindersLineCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_445623FA8275_var*
//#UC END# *52D00B00031A_445623FA8275_var*
begin
//#UC START# *52D00B00031A_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_445623FA8275_impl*
end;//TkwPopRemindersLineCount.SetValuePrim

function TkwPopRemindersLineCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_445623FA8275_var*
//#UC END# *551544E2001A_445623FA8275_var*
begin
//#UC START# *551544E2001A_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_445623FA8275_impl*
end;//TkwPopRemindersLineCount.GetResultTypeInfo

function TkwPopRemindersLineCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_445623FA8275_var*
//#UC END# *559687E6025A_445623FA8275_var*
begin
//#UC START# *559687E6025A_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_445623FA8275_impl*
end;//TkwPopRemindersLineCount.GetAllParamsCount

function TkwPopRemindersLineCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_445623FA8275_var*
//#UC END# *5617F4D00243_445623FA8275_var*
begin
//#UC START# *5617F4D00243_445623FA8275_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_445623FA8275_impl*
end;//TkwPopRemindersLineCount.ParamsTypes

function TkwPopRemindersLineHeight.Height(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Height }
//#UC START# *90CD34A37938_760507B09407_var*
//#UC END# *90CD34A37938_760507B09407_var*
begin
//#UC START# *90CD34A37938_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *90CD34A37938_760507B09407_impl*
end;//TkwPopRemindersLineHeight.Height

procedure TkwPopRemindersLineHeight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_760507B09407_var*
//#UC END# *4DAEEDE10285_760507B09407_var*
begin
//#UC START# *4DAEEDE10285_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_760507B09407_impl*
end;//TkwPopRemindersLineHeight.DoDoIt

class function TkwPopRemindersLineHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Height';
end;//TkwPopRemindersLineHeight.GetWordNameForRegister

procedure TkwPopRemindersLineHeight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_760507B09407_var*
//#UC END# *52D00B00031A_760507B09407_var*
begin
//#UC START# *52D00B00031A_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_760507B09407_impl*
end;//TkwPopRemindersLineHeight.SetValuePrim

function TkwPopRemindersLineHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_760507B09407_var*
//#UC END# *551544E2001A_760507B09407_var*
begin
//#UC START# *551544E2001A_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_760507B09407_impl*
end;//TkwPopRemindersLineHeight.GetResultTypeInfo

function TkwPopRemindersLineHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_760507B09407_var*
//#UC END# *559687E6025A_760507B09407_var*
begin
//#UC START# *559687E6025A_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_760507B09407_impl*
end;//TkwPopRemindersLineHeight.GetAllParamsCount

function TkwPopRemindersLineHeight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_760507B09407_var*
//#UC END# *5617F4D00243_760507B09407_var*
begin
//#UC START# *5617F4D00243_760507B09407_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_760507B09407_impl*
end;//TkwPopRemindersLineHeight.ParamsTypes

function TkwPopRemindersLineLeft.Left(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Left }
//#UC START# *CE96AE07E93B_52CD5A5422A8_var*
//#UC END# *CE96AE07E93B_52CD5A5422A8_var*
begin
//#UC START# *CE96AE07E93B_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *CE96AE07E93B_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.Left

procedure TkwPopRemindersLineLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52CD5A5422A8_var*
//#UC END# *4DAEEDE10285_52CD5A5422A8_var*
begin
//#UC START# *4DAEEDE10285_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.DoDoIt

class function TkwPopRemindersLineLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Left';
end;//TkwPopRemindersLineLeft.GetWordNameForRegister

procedure TkwPopRemindersLineLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_52CD5A5422A8_var*
//#UC END# *52D00B00031A_52CD5A5422A8_var*
begin
//#UC START# *52D00B00031A_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.SetValuePrim

function TkwPopRemindersLineLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_52CD5A5422A8_var*
//#UC END# *551544E2001A_52CD5A5422A8_var*
begin
//#UC START# *551544E2001A_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.GetResultTypeInfo

function TkwPopRemindersLineLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_52CD5A5422A8_var*
//#UC END# *559687E6025A_52CD5A5422A8_var*
begin
//#UC START# *559687E6025A_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.GetAllParamsCount

function TkwPopRemindersLineLeft.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_52CD5A5422A8_var*
//#UC END# *5617F4D00243_52CD5A5422A8_var*
begin
//#UC START# *5617F4D00243_52CD5A5422A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_52CD5A5422A8_impl*
end;//TkwPopRemindersLineLeft.ParamsTypes

function TkwPopRemindersLineTop.Top(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Top }
//#UC START# *E071319A2497_E47F2394242D_var*
//#UC END# *E071319A2497_E47F2394242D_var*
begin
//#UC START# *E071319A2497_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *E071319A2497_E47F2394242D_impl*
end;//TkwPopRemindersLineTop.Top

procedure TkwPopRemindersLineTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E47F2394242D_var*
//#UC END# *4DAEEDE10285_E47F2394242D_var*
begin
//#UC START# *4DAEEDE10285_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E47F2394242D_impl*
end;//TkwPopRemindersLineTop.DoDoIt

class function TkwPopRemindersLineTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Top';
end;//TkwPopRemindersLineTop.GetWordNameForRegister

procedure TkwPopRemindersLineTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E47F2394242D_var*
//#UC END# *52D00B00031A_E47F2394242D_var*
begin
//#UC START# *52D00B00031A_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E47F2394242D_impl*
end;//TkwPopRemindersLineTop.SetValuePrim

function TkwPopRemindersLineTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E47F2394242D_var*
//#UC END# *551544E2001A_E47F2394242D_var*
begin
//#UC START# *551544E2001A_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E47F2394242D_impl*
end;//TkwPopRemindersLineTop.GetResultTypeInfo

function TkwPopRemindersLineTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E47F2394242D_var*
//#UC END# *559687E6025A_E47F2394242D_var*
begin
//#UC START# *559687E6025A_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E47F2394242D_impl*
end;//TkwPopRemindersLineTop.GetAllParamsCount

function TkwPopRemindersLineTop.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E47F2394242D_var*
//#UC END# *5617F4D00243_E47F2394242D_var*
begin
//#UC START# *5617F4D00243_E47F2394242D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E47F2394242D_impl*
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
//#UC START# *4DAEEDE10285_002E70A99E5D_var*
//#UC END# *4DAEEDE10285_002E70A99E5D_var*
begin
//#UC START# *4DAEEDE10285_002E70A99E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.DoDoIt

class function TkwPopRemindersLineVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Visible';
end;//TkwPopRemindersLineVisible.GetWordNameForRegister

procedure TkwPopRemindersLineVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_002E70A99E5D_var*
//#UC END# *52D00B00031A_002E70A99E5D_var*
begin
//#UC START# *52D00B00031A_002E70A99E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.SetValuePrim

function TkwPopRemindersLineVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_002E70A99E5D_var*
//#UC END# *551544E2001A_002E70A99E5D_var*
begin
//#UC START# *551544E2001A_002E70A99E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.GetResultTypeInfo

function TkwPopRemindersLineVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_002E70A99E5D_var*
//#UC END# *559687E6025A_002E70A99E5D_var*
begin
//#UC START# *559687E6025A_002E70A99E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.GetAllParamsCount

function TkwPopRemindersLineVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_002E70A99E5D_var*
//#UC END# *5617F4D00243_002E70A99E5D_var*
begin
//#UC START# *5617F4D00243_002E70A99E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_002E70A99E5D_impl*
end;//TkwPopRemindersLineVisible.ParamsTypes

function TkwPopRemindersLineWidth.Width(const aCtx: TtfwContext;
 aRemindersLine: TvgRemindersLine): Integer;
 {* ���������� ����� ������� pop:RemindersLine:Width }
//#UC START# *F370C7CB88F6_ECE9F55BFC1D_var*
//#UC END# *F370C7CB88F6_ECE9F55BFC1D_var*
begin
//#UC START# *F370C7CB88F6_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *F370C7CB88F6_ECE9F55BFC1D_impl*
end;//TkwPopRemindersLineWidth.Width

procedure TkwPopRemindersLineWidth.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ECE9F55BFC1D_var*
//#UC END# *4DAEEDE10285_ECE9F55BFC1D_var*
begin
//#UC START# *4DAEEDE10285_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ECE9F55BFC1D_impl*
end;//TkwPopRemindersLineWidth.DoDoIt

class function TkwPopRemindersLineWidth.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RemindersLine:Width';
end;//TkwPopRemindersLineWidth.GetWordNameForRegister

procedure TkwPopRemindersLineWidth.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_ECE9F55BFC1D_var*
//#UC END# *52D00B00031A_ECE9F55BFC1D_var*
begin
//#UC START# *52D00B00031A_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_ECE9F55BFC1D_impl*
end;//TkwPopRemindersLineWidth.SetValuePrim

function TkwPopRemindersLineWidth.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ECE9F55BFC1D_var*
//#UC END# *551544E2001A_ECE9F55BFC1D_var*
begin
//#UC START# *551544E2001A_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ECE9F55BFC1D_impl*
end;//TkwPopRemindersLineWidth.GetResultTypeInfo

function TkwPopRemindersLineWidth.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_ECE9F55BFC1D_var*
//#UC END# *559687E6025A_ECE9F55BFC1D_var*
begin
//#UC START# *559687E6025A_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_ECE9F55BFC1D_impl*
end;//TkwPopRemindersLineWidth.GetAllParamsCount

function TkwPopRemindersLineWidth.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ECE9F55BFC1D_var*
//#UC END# *5617F4D00243_ECE9F55BFC1D_var*
begin
//#UC START# *5617F4D00243_ECE9F55BFC1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ECE9F55BFC1D_impl*
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
