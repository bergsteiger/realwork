unit F1LikeTextLoadKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� F1LikeTextLoad }

// ������: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoadKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "F1LikeTextLoadKeywordsPack" MUID: (FD7B4F4B69EA)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
 , evLoadDocumentManager
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , F1LikeTextLoad_Form
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
 Tkw_Form_F1LikeTextLoad = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� F1LikeTextLoad
----
*������ �������������*:
[code]
'aControl' �����::F1LikeTextLoad TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_F1LikeTextLoad

 Tkw_F1LikeTextLoad_Control_Text = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Control_Text

 Tkw_F1LikeTextLoad_Control_Text_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_F1LikeTextLoad_Control_Text_Push

 Tkw_F1LikeTextLoad_Component_TextSource = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_TextSource

 Tkw_F1LikeTextLoad_Component_LoadManager = {final} class(TtfwControlString)
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
 end;//Tkw_F1LikeTextLoad_Component_LoadManager

 TkwF1LikeTextLoadFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.Text
[panel]������� Text ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TeeEditorExport
*������:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.Text >>> l_TeeEditorExport
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
    {* ���������� ����� ������� .TF1LikeTextLoadForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormText

 TkwF1LikeTextLoadFormTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.TextSource
[panel]������� TextSource ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TeeTextSourceExport
*������:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
    {* ���������� ����� ������� .TF1LikeTextLoadForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormTextSource

 TkwF1LikeTextLoadFormLoadManager = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeTextLoadForm.LoadManager
[panel]������� LoadManager ����� TF1LikeTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  private
   function LoadManager(const aCtx: TtfwContext;
    aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
    {* ���������� ����� ������� .TF1LikeTextLoadForm.LoadManager }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1LikeTextLoadFormLoadManager

function Tkw_Form_F1LikeTextLoad.GetString: AnsiString;
begin
 Result := 'F1LikeTextLoadForm';
end;//Tkw_Form_F1LikeTextLoad.GetString

class function Tkw_Form_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::F1LikeTextLoad';
end;//Tkw_Form_F1LikeTextLoad.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_F1LikeTextLoad_Control_Text.GetString

class procedure Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeEditorExport);
end;//Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine

class function Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_F1LikeTextLoad_Control_Text.GetWordNameForRegister

procedure Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_F1LikeTextLoad_Control_Text_Push.DoDoIt

class function Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_F1LikeTextLoad_Control_Text_Push.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetString

class procedure Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTextSourceExport);
end;//Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine

class function Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_F1LikeTextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_F1LikeTextLoad_Component_LoadManager.GetString: AnsiString;
begin
 Result := 'LoadManager';
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetString

class procedure Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine

class function Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::LoadManager';
end;//Tkw_F1LikeTextLoad_Component_LoadManager.GetWordNameForRegister

function TkwF1LikeTextLoadFormText.Text(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
 {* ���������� ����� ������� .TF1LikeTextLoadForm.Text }
begin
 Result := aF1LikeTextLoadForm.Text;
end;//TkwF1LikeTextLoadFormText.Text

procedure TkwF1LikeTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeTextLoadForm: TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aF1LikeTextLoadForm));
end;//TkwF1LikeTextLoadFormText.DoDoIt

procedure TkwF1LikeTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwF1LikeTextLoadFormText.SetValuePrim

function TkwF1LikeTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeEditorExport);
end;//TkwF1LikeTextLoadFormText.GetResultTypeInfo

function TkwF1LikeTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeTextLoadFormText.GetAllParamsCount

function TkwF1LikeTextLoadFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormText.ParamsTypes

class function TkwF1LikeTextLoadFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.Text';
end;//TkwF1LikeTextLoadFormText.GetWordNameForRegister

function TkwF1LikeTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
 {* ���������� ����� ������� .TF1LikeTextLoadForm.TextSource }
begin
 Result := aF1LikeTextLoadForm.TextSource;
end;//TkwF1LikeTextLoadFormTextSource.TextSource

procedure TkwF1LikeTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeTextLoadForm: TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aF1LikeTextLoadForm));
end;//TkwF1LikeTextLoadFormTextSource.DoDoIt

procedure TkwF1LikeTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwF1LikeTextLoadFormTextSource.SetValuePrim

function TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTextSourceExport);
end;//TkwF1LikeTextLoadFormTextSource.GetResultTypeInfo

function TkwF1LikeTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeTextLoadFormTextSource.GetAllParamsCount

function TkwF1LikeTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormTextSource.ParamsTypes

class function TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.TextSource';
end;//TkwF1LikeTextLoadFormTextSource.GetWordNameForRegister

function TkwF1LikeTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
 {* ���������� ����� ������� .TF1LikeTextLoadForm.LoadManager }
begin
 Result := aF1LikeTextLoadForm.LoadManager;
end;//TkwF1LikeTextLoadFormLoadManager.LoadManager

procedure TkwF1LikeTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeTextLoadForm: TF1LikeTextLoadForm;
begin
 try
  l_aF1LikeTextLoadForm := TF1LikeTextLoadForm(aCtx.rEngine.PopObjAs(TF1LikeTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeTextLoadForm: TF1LikeTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoadManager(aCtx, l_aF1LikeTextLoadForm));
end;//TkwF1LikeTextLoadFormLoadManager.DoDoIt

procedure TkwF1LikeTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoadManager', aCtx);
end;//TkwF1LikeTextLoadFormLoadManager.SetValuePrim

function TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwF1LikeTextLoadFormLoadManager.GetResultTypeInfo

function TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeTextLoadFormLoadManager.GetAllParamsCount

function TkwF1LikeTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeTextLoadForm)]);
end;//TkwF1LikeTextLoadFormLoadManager.ParamsTypes

class function TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeTextLoadForm.LoadManager';
end;//TkwF1LikeTextLoadFormLoadManager.GetWordNameForRegister

initialization
 Tkw_Form_F1LikeTextLoad.RegisterInEngine;
 {* ����������� Tkw_Form_F1LikeTextLoad }
 Tkw_F1LikeTextLoad_Control_Text.RegisterInEngine;
 {* ����������� Tkw_F1LikeTextLoad_Control_Text }
 Tkw_F1LikeTextLoad_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_F1LikeTextLoad_Control_Text_Push }
 Tkw_F1LikeTextLoad_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_F1LikeTextLoad_Component_TextSource }
 Tkw_F1LikeTextLoad_Component_LoadManager.RegisterInEngine;
 {* ����������� Tkw_F1LikeTextLoad_Component_LoadManager }
 TkwF1LikeTextLoadFormText.RegisterInEngine;
 {* ����������� F1LikeTextLoadForm_Text }
 TkwF1LikeTextLoadFormTextSource.RegisterInEngine;
 {* ����������� F1LikeTextLoadForm_TextSource }
 TkwF1LikeTextLoadFormLoadManager.RegisterInEngine;
 {* ����������� F1LikeTextLoadForm_LoadManager }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TF1LikeTextLoadForm));
 {* ����������� ���� F1LikeTextLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorExport));
 {* ����������� ���� TeeEditorExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTextSourceExport));
 {* ����������� ���� TeeTextSourceExport }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* ����������� ���� TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
