unit StatusBarWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtStatusBar
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusBarGetPanel = {final} class(TtfwClassLike)
  {* ����� ������� pop:vtStatusBar:GetPanel
[panel]*��������:* �������� � ���� ������ ���������� �� ������.
������:
[code]
anIndex aStatusControl pop:vtStatusBar:GetPanel
[code]
anIndex - ����� ������.
aStatusControl - ������� ������-���.
� ���� ���������� ������ ������ TvtStatusPanel[panel]
*��� ����������:* TvtStatusPanel
*������:*
[code]
OBJECT VAR l_TvtStatusPanel
 anIndex aStatusBar pop:vtStatusBar:GetPanel >>> l_TvtStatusPanel
[code]  }
  private
   function GetPanel(const aCtx: TtfwContext;
    aStatusBar: TvtStatusBar;
    anIndex: Integer): TvtStatusPanel;
    {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusBarGetPanel

function TkwPopStatusBarGetPanel.GetPanel(const aCtx: TtfwContext;
 aStatusBar: TvtStatusBar;
 anIndex: Integer): TvtStatusPanel;
 {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
//#UC START# *2B3EB01EE00A_0B36D9E86F88_var*
//#UC END# *2B3EB01EE00A_0B36D9E86F88_var*
begin
//#UC START# *2B3EB01EE00A_0B36D9E86F88_impl*
 Result := aStatusBar.Panels.Items[anIndex];
//#UC END# *2B3EB01EE00A_0B36D9E86F88_impl*
end;//TkwPopStatusBarGetPanel.GetPanel

procedure TkwPopStatusBarGetPanel.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBar: TvtStatusBar;
var l_anIndex: Integer;
begin
 try
  l_aStatusBar := TvtStatusBar(aCtx.rEngine.PopObjAs(TvtStatusBar));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStatusBar: TvtStatusBar : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj(GetPanel(aCtx, l_aStatusBar, l_anIndex));
end;//TkwPopStatusBarGetPanel.DoDoIt

class function TkwPopStatusBarGetPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:vtStatusBar:GetPanel';
end;//TkwPopStatusBarGetPanel.GetWordNameForRegister

function TkwPopStatusBarGetPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtStatusPanel);
end;//TkwPopStatusBarGetPanel.GetResultTypeInfo

function TkwPopStatusBarGetPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopStatusBarGetPanel.GetAllParamsCount

function TkwPopStatusBarGetPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtStatusBar), TypeInfo(Integer)]);
end;//TkwPopStatusBarGetPanel.ParamsTypes

initialization
 TkwPopStatusBarGetPanel.RegisterInEngine;
 {* ����������� pop_StatusBar_GetPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusBar));
 {* ����������� ���� TvtStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* ����������� ���� TvtStatusPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
