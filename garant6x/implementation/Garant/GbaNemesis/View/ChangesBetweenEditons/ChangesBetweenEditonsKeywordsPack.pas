unit ChangesBetweenEditonsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ChangesBetweenEditons }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\ChangesBetweenEditonsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ChangesBetweenEditonsKeywordsPack" MUID: (B796AE5D8508)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ChangesBetweenEditons_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
;

type
 Tkw_Form_ChangesBetweenEditons = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ChangesBetweenEditons
----
*������ �������������*:
[code]
'aControl' �����::ChangesBetweenEditons TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ChangesBetweenEditons

 Tkw_ChangesBetweenEditons_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Control_Text

 Tkw_ChangesBetweenEditons_Control_Text_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Control_Text_Push

 Tkw_ChangesBetweenEditons_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChangesBetweenEditons_Component_TextSource

 TkwChangesBetweenEditonsFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChangesBetweenEditonsForm.Text
[panel]������� Text ����� TChangesBetweenEditonsForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aChangesBetweenEditonsForm .TChangesBetweenEditonsForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
    {* ���������� ����� ������� .TChangesBetweenEditonsForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChangesBetweenEditonsFormText

function Tkw_Form_ChangesBetweenEditons.GetString: AnsiString;
begin
 Result := 'ChangesBetweenEditonsForm';
end;//Tkw_Form_ChangesBetweenEditons.GetString

class function Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ChangesBetweenEditons';
end;//Tkw_Form_ChangesBetweenEditons.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetString

class procedure Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine

class function Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_ChangesBetweenEditons_Control_Text.GetWordNameForRegister

procedure Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.DoDoIt

class function Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_ChangesBetweenEditons_Control_Text_Push.GetWordNameForRegister

function Tkw_ChangesBetweenEditons_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetString

class procedure Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine

class function Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_ChangesBetweenEditons_Component_TextSource.GetWordNameForRegister

function TkwChangesBetweenEditonsFormText.Text(const aCtx: TtfwContext;
 aChangesBetweenEditonsForm: TChangesBetweenEditonsForm): TnscEditor;
 {* ���������� ����� ������� .TChangesBetweenEditonsForm.Text }
begin
 Result := aChangesBetweenEditonsForm.Text;
end;//TkwChangesBetweenEditonsFormText.Text

procedure TkwChangesBetweenEditonsFormText.DoDoIt(const aCtx: TtfwContext);
var l_aChangesBetweenEditonsForm: TChangesBetweenEditonsForm;
begin
 try
  l_aChangesBetweenEditonsForm := TChangesBetweenEditonsForm(aCtx.rEngine.PopObjAs(TChangesBetweenEditonsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChangesBetweenEditonsForm: TChangesBetweenEditonsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aChangesBetweenEditonsForm));
end;//TkwChangesBetweenEditonsFormText.DoDoIt

procedure TkwChangesBetweenEditonsFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwChangesBetweenEditonsFormText.SetValuePrim

function TkwChangesBetweenEditonsFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwChangesBetweenEditonsFormText.GetResultTypeInfo

function TkwChangesBetweenEditonsFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChangesBetweenEditonsFormText.GetAllParamsCount

function TkwChangesBetweenEditonsFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChangesBetweenEditonsForm)]);
end;//TkwChangesBetweenEditonsFormText.ParamsTypes

class function TkwChangesBetweenEditonsFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChangesBetweenEditonsForm.Text';
end;//TkwChangesBetweenEditonsFormText.GetWordNameForRegister

initialization
 Tkw_Form_ChangesBetweenEditons.RegisterInEngine;
 {* ����������� Tkw_Form_ChangesBetweenEditons }
 Tkw_ChangesBetweenEditons_Control_Text.RegisterInEngine;
 {* ����������� Tkw_ChangesBetweenEditons_Control_Text }
 Tkw_ChangesBetweenEditons_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_ChangesBetweenEditons_Control_Text_Push }
 Tkw_ChangesBetweenEditons_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_ChangesBetweenEditons_Component_TextSource }
 TkwChangesBetweenEditonsFormText.RegisterInEngine;
 {* ����������� ChangesBetweenEditonsForm_Text }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChangesBetweenEditonsForm));
 {* ����������� ���� ChangesBetweenEditons }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
