unit StatusBarWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StatusBarWordsPack" MUID: (552E3E7E023A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , vtStatusBar
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *552E3E7E023Aimpl_uses*
 //#UC END# *552E3E7E023Aimpl_uses*
;

type
 TkwPopStatusBarGetPanel = {final} class(TtfwClassLike)
  {* ����� ������� pop:vtStatusBar:GetPanel }
  private
   function GetPanel(const aCtx: TtfwContext;
    aStatusBar: TvtStatusBar;
    anIndex: Integer): TvtStatusPanel;
    {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusBarGetPanel

function TkwPopStatusBarGetPanel.GetPanel(const aCtx: TtfwContext;
 aStatusBar: TvtStatusBar;
 anIndex: Integer): TvtStatusPanel;
 {* ���������� ����� ������� pop:vtStatusBar:GetPanel }
//#UC START# *552E3EE00284_552E3EE00284_4E15A00502A3_Word_var*
//#UC END# *552E3EE00284_552E3EE00284_4E15A00502A3_Word_var*
begin
//#UC START# *552E3EE00284_552E3EE00284_4E15A00502A3_Word_impl*
 Result := aStatusBar.Panels.Items[anIndex];
//#UC END# *552E3EE00284_552E3EE00284_4E15A00502A3_Word_impl*
end;//TkwPopStatusBarGetPanel.GetPanel

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

initialization
 TkwPopStatusBarGetPanel.RegisterInEngine;
 {* ����������� pop_StatusBar_GetPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusBar));
 {* ����������� ���� TvtStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* ����������� ���� TvtStatusPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
