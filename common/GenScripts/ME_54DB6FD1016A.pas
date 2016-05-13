unit StatusBarButtonWords;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarButtonWords.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StatusBarButtonWords" MUID: (54DB6FD1016A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

implementation

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nscStatusBarButton
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopStatusBarButtonIsDown = {final} class(TtfwClassLike)
  {* ����� ������� pop:StatusBarButton:IsDown }
  private
   function IsDown(const aCtx: TtfwContext;
    aStatusBarButton: TnscStatusBarButton): Boolean;
    {* ���������� ����� ������� pop:StatusBarButton:IsDown }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusBarButtonIsDown

function TkwPopStatusBarButtonIsDown.IsDown(const aCtx: TtfwContext;
 aStatusBarButton: TnscStatusBarButton): Boolean;
 {* ���������� ����� ������� pop:StatusBarButton:IsDown }
//#UC START# *552FC9C10154_552FC9C10154_503DE6F30027_Word_var*
//#UC END# *552FC9C10154_552FC9C10154_503DE6F30027_Word_var*
begin
//#UC START# *552FC9C10154_552FC9C10154_503DE6F30027_Word_impl*
 Result := aStatusBarButton.Down;
//#UC END# *552FC9C10154_552FC9C10154_503DE6F30027_Word_impl*
end;//TkwPopStatusBarButtonIsDown.IsDown

class function TkwPopStatusBarButtonIsDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:StatusBarButton:IsDown';
end;//TkwPopStatusBarButtonIsDown.GetWordNameForRegister

function TkwPopStatusBarButtonIsDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopStatusBarButtonIsDown.GetResultTypeInfo

function TkwPopStatusBarButtonIsDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopStatusBarButtonIsDown.GetAllParamsCount

function TkwPopStatusBarButtonIsDown.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBarButton)]);
end;//TkwPopStatusBarButtonIsDown.ParamsTypes

procedure TkwPopStatusBarButtonIsDown.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBarButton: TnscStatusBarButton;
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
 aCtx.rEngine.PushBool(IsDown(aCtx, l_aStatusBarButton));
end;//TkwPopStatusBarButtonIsDown.DoDoIt

initialization
 TkwPopStatusBarButtonIsDown.RegisterInEngine;
 {* ����������� pop_StatusBarButton_IsDown }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBarButton));
 {* ����������� ���� TnscStatusBarButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

end.
