unit StatusPanelWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\StatusPanelWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StatusPanelWordsPack" MUID: (552E403E0038)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vtStatusBar
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopStatusPanelGetText = {final} class(TtfwClassLike)
  {* ����� ������� pop:vtStatusPanel:GetText
[panel]*��������:* ���������� ����� ������
*������:* 
[code]
aPanel pop:vtStatusPanel:GetText
[code]
aPanel - ������ ������ TvtStatusPanel, ������� ����� �������� � ������� pop:vtStatusPanel:GetText[panel]
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aStatusPanel pop:vtStatusPanel:GetText >>> l_String
[code]  }
  private
   function GetText(const aCtx: TtfwContext;
    aStatusPanel: TvtStatusPanel): AnsiString;
    {* ���������� ����� ������� pop:vtStatusPanel:GetText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopStatusPanelGetText

function TkwPopStatusPanelGetText.GetText(const aCtx: TtfwContext;
 aStatusPanel: TvtStatusPanel): AnsiString;
 {* ���������� ����� ������� pop:vtStatusPanel:GetText }
//#UC START# *D504B43B31FD_7D107A8BDD1A_var*
//#UC END# *D504B43B31FD_7D107A8BDD1A_var*
begin
//#UC START# *D504B43B31FD_7D107A8BDD1A_impl*
 Result := aStatusPanel.Text;
//#UC END# *D504B43B31FD_7D107A8BDD1A_impl*
end;//TkwPopStatusPanelGetText.GetText

procedure TkwPopStatusPanelGetText.DoDoIt(const aCtx: TtfwContext);
var l_aStatusPanel: TvtStatusPanel;
begin
 try
  l_aStatusPanel := TvtStatusPanel(aCtx.rEngine.PopObjAs(TvtStatusPanel));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStatusPanel: TvtStatusPanel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(GetText(aCtx, l_aStatusPanel));
end;//TkwPopStatusPanelGetText.DoDoIt

function TkwPopStatusPanelGetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopStatusPanelGetText.GetResultTypeInfo

function TkwPopStatusPanelGetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopStatusPanelGetText.GetAllParamsCount

function TkwPopStatusPanelGetText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtStatusPanel)]);
end;//TkwPopStatusPanelGetText.ParamsTypes

class function TkwPopStatusPanelGetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:vtStatusPanel:GetText';
end;//TkwPopStatusPanelGetText.GetWordNameForRegister

initialization
 TkwPopStatusPanelGetText.RegisterInEngine;
 {* ����������� pop_StatusPanel_GetText }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStatusPanel));
 {* ����������� ���� TvtStatusPanel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
{$IfEnd} // NOT Defined(NoScripts)

end.
