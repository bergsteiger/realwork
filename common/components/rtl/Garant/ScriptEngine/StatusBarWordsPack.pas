unit StatusBarWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VT"
// ������: "StatusBarWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtControlsFromStackWords::StatusBarWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  vtStatusBar,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopStatusBarGetPanel = {final scriptword} class(TtfwClassLike)
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
 // private methods
   function GetPanel(const aCtx: TtfwContext;
    aStatusBar: TvtStatusBar;
    anIndex: Integer): TvtStatusPanel;
     {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
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
 end;//TkwPopStatusBarGetPanel

// start class TkwPopStatusBarGetPanel

function TkwPopStatusBarGetPanel.GetPanel(const aCtx: TtfwContext;
  aStatusBar: TvtStatusBar;
  anIndex: Integer): TvtStatusPanel;
//#UC START# *2B3EB01EE00A_0B36D9E86F88_var*
//#UC END# *2B3EB01EE00A_0B36D9E86F88_var*
begin
//#UC START# *2B3EB01EE00A_0B36D9E86F88_impl*
 Result := aStatusBar.Panels.Items[anIndex];
//#UC END# *2B3EB01EE00A_0B36D9E86F88_impl*
end;//TkwPopStatusBarGetPanel.GetPanel

procedure TkwPopStatusBarGetPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStatusBar : TvtStatusBar;
 l_anIndex : Integer;
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
 aCtx.rEngine.PushObj((GetPanel(aCtx, l_aStatusBar, l_anIndex)));
end;//TkwPopStatusBarGetPanel.DoDoIt

class function TkwPopStatusBarGetPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:vtStatusBar:GetPanel';
end;//TkwPopStatusBarGetPanel.GetWordNameForRegister

function TkwPopStatusBarGetPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtStatusPanel);
end;//TkwPopStatusBarGetPanel.GetResultTypeInfo

function TkwPopStatusBarGetPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopStatusBarGetPanel.GetAllParamsCount

function TkwPopStatusBarGetPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvtStatusBar), TypeInfo(Integer)]);
end;//TkwPopStatusBarGetPanel.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_StatusBar_GetPanel
 TkwPopStatusBarGetPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusBar));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtStatusPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
{$IfEnd} //not NoScripts

end.