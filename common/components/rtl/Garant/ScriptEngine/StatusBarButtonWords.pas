unit StatusBarButtonWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$F1"
// ������: "StatusBarButtonWords.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi For F1::ScriptEngine$F1::StatusBarWords::StatusBarButtonWords
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If defined(Nemesis) AND not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  nscStatusBarButton,
  tfwClassLike
  ;

{$IfEnd} //Nemesis AND not NoScripts

implementation

{$If defined(Nemesis) AND not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopStatusBarButtonIsDown = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:StatusBarButton:IsDown
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aStatusBarButton pop:StatusBarButton:IsDown >>> l_Boolean
[code]  }
 private
 // private methods
   function IsDown(const aCtx: TtfwContext;
    aStatusBarButton: TnscStatusBarButton): Boolean;
     {* ���������� ����� ������� pop:StatusBarButton:IsDown }
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
 end;//TkwPopStatusBarButtonIsDown

// start class TkwPopStatusBarButtonIsDown

function TkwPopStatusBarButtonIsDown.IsDown(const aCtx: TtfwContext;
  aStatusBarButton: TnscStatusBarButton): Boolean;
//#UC START# *8D82AE1A2B57_33C559B72437_var*
//#UC END# *8D82AE1A2B57_33C559B72437_var*
begin
//#UC START# *8D82AE1A2B57_33C559B72437_impl*
 Result := aStatusBarButton.Down;
//#UC END# *8D82AE1A2B57_33C559B72437_impl*
end;//TkwPopStatusBarButtonIsDown.IsDown

procedure TkwPopStatusBarButtonIsDown.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStatusBarButton : TnscStatusBarButton;
begin
 try
  l_aStatusBarButton := TnscStatusBarButton(aCtx.rEngine.PopObjAs(TnscStatusBarButton));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStatusBarButton: TnscStatusBarButton : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((IsDown(aCtx, l_aStatusBarButton)));
end;//TkwPopStatusBarButtonIsDown.DoDoIt

class function TkwPopStatusBarButtonIsDown.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:StatusBarButton:IsDown';
end;//TkwPopStatusBarButtonIsDown.GetWordNameForRegister

function TkwPopStatusBarButtonIsDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopStatusBarButtonIsDown.GetResultTypeInfo

function TkwPopStatusBarButtonIsDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopStatusBarButtonIsDown.GetAllParamsCount

function TkwPopStatusBarButtonIsDown.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBarButton)]);
end;//TkwPopStatusBarButtonIsDown.ParamsTypes
{$IfEnd} //Nemesis AND not NoScripts

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� pop_StatusBarButton_IsDown
 TkwPopStatusBarButtonIsDown.RegisterInEngine;
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� ���� TnscStatusBarButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBarButton));
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //Nemesis AND not NoScripts

end.