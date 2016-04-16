unit QFLikeTextLoadKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� QFLikeTextLoad }

// ������: "w:\common\components\gui\Garant\Daily\Forms\QFLikeTextLoadKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "QFLikeTextLoadKeywordsPack" MUID: (E7D4D96CE8D4)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evTextSource
 , evQueryCardEditor
 , evLoadDocumentManager
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , QFLikeTextLoad_Form
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
 , SysUtils
;

type
 Tkw_Form_QFLikeTextLoad = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� QFLikeTextLoad
----
*������ �������������*:
[code]
'aControl' �����::QFLikeTextLoad TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_QFLikeTextLoad

 Tkw_QFLikeTextLoad_Component_TextSource = {final} class(TtfwControlString)
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
 end;//Tkw_QFLikeTextLoad_Component_TextSource

 Tkw_QFLikeTextLoad_Control_Text = {final} class(TtfwControlString)
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
 end;//Tkw_QFLikeTextLoad_Control_Text

 Tkw_QFLikeTextLoad_Control_Text_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_QFLikeTextLoad_Control_Text_Push

 Tkw_QFLikeTextLoad_Component_LoadManager = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QFLikeTextLoad_Component_LoadManager

 TkwQFLikeTextLoadFormTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.TextSource
[panel]������� TextSource ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
    {* ���������� ����� ������� .TQFLikeTextLoadForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwQFLikeTextLoadFormTextSource

 TkwQFLikeTextLoadFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.Text
[panel]������� Text ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevQueryCardEditor
*������:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.Text >>> l_TevQueryCardEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
    {* ���������� ����� ������� .TQFLikeTextLoadForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwQFLikeTextLoadFormText

 TkwQFLikeTextLoadFormLoadManager = {final} class(TtfwPropertyLike)
  {* ����� ������� .TQFLikeTextLoadForm.LoadManager
[panel]������� LoadManager ����� TQFLikeTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  private
   function LoadManager(const aCtx: TtfwContext;
    aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
    {* ���������� ����� ������� .TQFLikeTextLoadForm.LoadManager }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwQFLikeTextLoadFormLoadManager

function Tkw_Form_QFLikeTextLoad.GetString: AnsiString;
begin
 Result := 'QFLikeTextLoadForm';
end;//Tkw_Form_QFLikeTextLoad.GetString

class function Tkw_Form_QFLikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::QFLikeTextLoad';
end;//Tkw_Form_QFLikeTextLoad.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_QFLikeTextLoad_Component_TextSource.GetString

class procedure Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine

class function Tkw_QFLikeTextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_QFLikeTextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_QFLikeTextLoad_Control_Text.GetString

class procedure Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevQueryCardEditor);
end;//Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine

class function Tkw_QFLikeTextLoad_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_QFLikeTextLoad_Control_Text.GetWordNameForRegister

procedure Tkw_QFLikeTextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_QFLikeTextLoad_Control_Text_Push.DoDoIt

class function Tkw_QFLikeTextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_QFLikeTextLoad_Control_Text_Push.GetWordNameForRegister

function Tkw_QFLikeTextLoad_Component_LoadManager.GetString: AnsiString;
begin
 Result := 'LoadManager';
end;//Tkw_QFLikeTextLoad_Component_LoadManager.GetString

class procedure Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine

class function Tkw_QFLikeTextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::LoadManager';
end;//Tkw_QFLikeTextLoad_Component_LoadManager.GetWordNameForRegister

function TkwQFLikeTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
 aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
 {* ���������� ����� ������� .TQFLikeTextLoadForm.TextSource }
begin
 Result := aQFLikeTextLoadForm.TextSource;
end;//TkwQFLikeTextLoadFormTextSource.TextSource

procedure TkwQFLikeTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aQFLikeTextLoadForm: TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aQFLikeTextLoadForm));
end;//TkwQFLikeTextLoadFormTextSource.DoDoIt

procedure TkwQFLikeTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwQFLikeTextLoadFormTextSource.SetValuePrim

function TkwQFLikeTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevTextSource);
end;//TkwQFLikeTextLoadFormTextSource.GetResultTypeInfo

function TkwQFLikeTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwQFLikeTextLoadFormTextSource.GetAllParamsCount

function TkwQFLikeTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormTextSource.ParamsTypes

class function TkwQFLikeTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TQFLikeTextLoadForm.TextSource';
end;//TkwQFLikeTextLoadFormTextSource.GetWordNameForRegister

function TkwQFLikeTextLoadFormText.Text(const aCtx: TtfwContext;
 aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
 {* ���������� ����� ������� .TQFLikeTextLoadForm.Text }
begin
 Result := aQFLikeTextLoadForm.Text;
end;//TkwQFLikeTextLoadFormText.Text

procedure TkwQFLikeTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
var l_aQFLikeTextLoadForm: TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aQFLikeTextLoadForm));
end;//TkwQFLikeTextLoadFormText.DoDoIt

procedure TkwQFLikeTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwQFLikeTextLoadFormText.SetValuePrim

function TkwQFLikeTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwQFLikeTextLoadFormText.GetResultTypeInfo

function TkwQFLikeTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwQFLikeTextLoadFormText.GetAllParamsCount

function TkwQFLikeTextLoadFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormText.ParamsTypes

class function TkwQFLikeTextLoadFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TQFLikeTextLoadForm.Text';
end;//TkwQFLikeTextLoadFormText.GetWordNameForRegister

function TkwQFLikeTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
 {* ���������� ����� ������� .TQFLikeTextLoadForm.LoadManager }
begin
 Result := aQFLikeTextLoadForm.LoadManager;
end;//TkwQFLikeTextLoadFormLoadManager.LoadManager

procedure TkwQFLikeTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
var l_aQFLikeTextLoadForm: TQFLikeTextLoadForm;
begin
 try
  l_aQFLikeTextLoadForm := TQFLikeTextLoadForm(aCtx.rEngine.PopObjAs(TQFLikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aQFLikeTextLoadForm: TQFLikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoadManager(aCtx, l_aQFLikeTextLoadForm));
end;//TkwQFLikeTextLoadFormLoadManager.DoDoIt

procedure TkwQFLikeTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoadManager', aCtx);
end;//TkwQFLikeTextLoadFormLoadManager.SetValuePrim

function TkwQFLikeTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwQFLikeTextLoadFormLoadManager.GetResultTypeInfo

function TkwQFLikeTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwQFLikeTextLoadFormLoadManager.GetAllParamsCount

function TkwQFLikeTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TQFLikeTextLoadForm)]);
end;//TkwQFLikeTextLoadFormLoadManager.ParamsTypes

class function TkwQFLikeTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TQFLikeTextLoadForm.LoadManager';
end;//TkwQFLikeTextLoadFormLoadManager.GetWordNameForRegister

initialization
 Tkw_Form_QFLikeTextLoad.RegisterInEngine;
 {* ����������� Tkw_Form_QFLikeTextLoad }
 Tkw_QFLikeTextLoad_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_QFLikeTextLoad_Component_TextSource }
 Tkw_QFLikeTextLoad_Control_Text.RegisterInEngine;
 {* ����������� Tkw_QFLikeTextLoad_Control_Text }
 Tkw_QFLikeTextLoad_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_QFLikeTextLoad_Control_Text_Push }
 Tkw_QFLikeTextLoad_Component_LoadManager.RegisterInEngine;
 {* ����������� Tkw_QFLikeTextLoad_Component_LoadManager }
 TkwQFLikeTextLoadFormTextSource.RegisterInEngine;
 {* ����������� QFLikeTextLoadForm_TextSource }
 TkwQFLikeTextLoadFormText.RegisterInEngine;
 {* ����������� QFLikeTextLoadForm_Text }
 TkwQFLikeTextLoadFormLoadManager.RegisterInEngine;
 {* ����������� QFLikeTextLoadForm_LoadManager }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TQFLikeTextLoadForm));
 {* ����������� ���� QFLikeTextLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* ����������� ���� TevTextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
 {* ����������� ���� TevQueryCardEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* ����������� ���� TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
