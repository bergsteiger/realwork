unit StyleEditorExampleKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorExample }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorExampleKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , eeEditorWithoutOperations
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_StyleEditorExample = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StyleEditorExample
----
*������ �������������*:
[code]
'aControl' �����::StyleEditorExample TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StyleEditorExample

 Tkw_StyleEditorExample_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorExample_Component_TextSource

 Tkw_StyleEditorExample_Control_EditorPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EditorPanel
----
*������ �������������*:
[code]
�������::EditorPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorExample_Control_EditorPanel

 Tkw_StyleEditorExample_Control_EditorPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EditorPanel
----
*������ �������������*:
[code]
�������::EditorPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_EditorPanel_Push

 Tkw_StyleEditorExample_Control_Editor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Editor
----
*������ �������������*:
[code]
�������::Editor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorExample_Control_Editor

 Tkw_StyleEditorExample_Control_Editor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Editor
----
*������ �������������*:
[code]
�������::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorExample_Control_Editor_Push

 TkwStyleEditorExampleFormTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorExampleForm.TextSource
[panel]������� TextSource ����� TStyleEditorExampleForm[panel]
*��� ����������:* TnscTextSource
*������:*
[code]
OBJECT VAR l_TnscTextSource
 aStyleEditorExampleForm .TStyleEditorExampleForm.TextSource >>> l_TnscTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
    {* ���������� ����� ������� .TStyleEditorExampleForm.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorExampleFormTextSource

 TkwStyleEditorExampleFormEditorPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorExampleForm.EditorPanel
[panel]������� EditorPanel ����� TStyleEditorExampleForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aStyleEditorExampleForm .TStyleEditorExampleForm.EditorPanel >>> l_TvtPanel
[code]  }
  private
   function EditorPanel(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
    {* ���������� ����� ������� .TStyleEditorExampleForm.EditorPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorExampleFormEditorPanel

 TkwStyleEditorExampleFormEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorExampleForm.Editor
[panel]������� Editor ����� TStyleEditorExampleForm[panel]
*��� ����������:* TeeEditorWithoutOperations
*������:*
[code]
OBJECT VAR l_TeeEditorWithoutOperations
 aStyleEditorExampleForm .TStyleEditorExampleForm.Editor >>> l_TeeEditorWithoutOperations
[code]  }
  private
   function Editor(const aCtx: TtfwContext;
    aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
    {* ���������� ����� ������� .TStyleEditorExampleForm.Editor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorExampleFormEditor

class function Tkw_Form_StyleEditorExample.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StyleEditorExample';
end;//Tkw_Form_StyleEditorExample.GetWordNameForRegister

function Tkw_Form_StyleEditorExample.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B221D9CACD6B_var*
//#UC END# *4DDFD2EA0116_B221D9CACD6B_var*
begin
//#UC START# *4DDFD2EA0116_B221D9CACD6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B221D9CACD6B_impl*
end;//Tkw_Form_StyleEditorExample.GetString

class function Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_StyleEditorExample_Component_TextSource.GetWordNameForRegister

function Tkw_StyleEditorExample_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FA586B6A0B65_var*
//#UC END# *4DDFD2EA0116_FA586B6A0B65_var*
begin
//#UC START# *4DDFD2EA0116_FA586B6A0B65_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FA586B6A0B65_impl*
end;//Tkw_StyleEditorExample_Component_TextSource.GetString

class procedure Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_FA586B6A0B65_var*
//#UC END# *52A086150180_FA586B6A0B65_var*
begin
//#UC START# *52A086150180_FA586B6A0B65_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FA586B6A0B65_impl*
end;//Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine

class function Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditorPanel';
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_EditorPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C2A8374FE1C1_var*
//#UC END# *4DDFD2EA0116_C2A8374FE1C1_var*
begin
//#UC START# *4DDFD2EA0116_C2A8374FE1C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C2A8374FE1C1_impl*
end;//Tkw_StyleEditorExample_Control_EditorPanel.GetString

class procedure Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
//#UC START# *52A086150180_C2A8374FE1C1_var*
//#UC END# *52A086150180_C2A8374FE1C1_var*
begin
//#UC START# *52A086150180_C2A8374FE1C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C2A8374FE1C1_impl*
end;//Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine

procedure Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B66BE256676C_var*
//#UC END# *4DAEEDE10285_B66BE256676C_var*
begin
//#UC START# *4DAEEDE10285_B66BE256676C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B66BE256676C_impl*
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditorPanel:push';
end;//Tkw_StyleEditorExample_Control_EditorPanel_Push.GetWordNameForRegister

class function Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor';
end;//Tkw_StyleEditorExample_Control_Editor.GetWordNameForRegister

function Tkw_StyleEditorExample_Control_Editor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2B72FEDAF18A_var*
//#UC END# *4DDFD2EA0116_2B72FEDAF18A_var*
begin
//#UC START# *4DDFD2EA0116_2B72FEDAF18A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2B72FEDAF18A_impl*
end;//Tkw_StyleEditorExample_Control_Editor.GetString

class procedure Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
//#UC START# *52A086150180_2B72FEDAF18A_var*
//#UC END# *52A086150180_2B72FEDAF18A_var*
begin
//#UC START# *52A086150180_2B72FEDAF18A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2B72FEDAF18A_impl*
end;//Tkw_StyleEditorExample_Control_Editor.RegisterInEngine

procedure Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BAB3E2FC4875_var*
//#UC END# *4DAEEDE10285_BAB3E2FC4875_var*
begin
//#UC START# *4DAEEDE10285_BAB3E2FC4875_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BAB3E2FC4875_impl*
end;//Tkw_StyleEditorExample_Control_Editor_Push.DoDoIt

class function Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor:push';
end;//Tkw_StyleEditorExample_Control_Editor_Push.GetWordNameForRegister

function TkwStyleEditorExampleFormTextSource.TextSource(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TnscTextSource;
 {* ���������� ����� ������� .TStyleEditorExampleForm.TextSource }
//#UC START# *B7F8B8429264_94CDC606065E_var*
//#UC END# *B7F8B8429264_94CDC606065E_var*
begin
//#UC START# *B7F8B8429264_94CDC606065E_impl*
 !!! Needs to be implemented !!!
//#UC END# *B7F8B8429264_94CDC606065E_impl*
end;//TkwStyleEditorExampleFormTextSource.TextSource

procedure TkwStyleEditorExampleFormTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_94CDC606065E_var*
//#UC END# *4DAEEDE10285_94CDC606065E_var*
begin
//#UC START# *4DAEEDE10285_94CDC606065E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_94CDC606065E_impl*
end;//TkwStyleEditorExampleFormTextSource.DoDoIt

class function TkwStyleEditorExampleFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.TextSource';
end;//TkwStyleEditorExampleFormTextSource.GetWordNameForRegister

procedure TkwStyleEditorExampleFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_94CDC606065E_var*
//#UC END# *52D00B00031A_94CDC606065E_var*
begin
//#UC START# *52D00B00031A_94CDC606065E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_94CDC606065E_impl*
end;//TkwStyleEditorExampleFormTextSource.SetValuePrim

function TkwStyleEditorExampleFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_94CDC606065E_var*
//#UC END# *551544E2001A_94CDC606065E_var*
begin
//#UC START# *551544E2001A_94CDC606065E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_94CDC606065E_impl*
end;//TkwStyleEditorExampleFormTextSource.GetResultTypeInfo

function TkwStyleEditorExampleFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormTextSource.GetAllParamsCount

function TkwStyleEditorExampleFormTextSource.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_94CDC606065E_var*
//#UC END# *5617F4D00243_94CDC606065E_var*
begin
//#UC START# *5617F4D00243_94CDC606065E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_94CDC606065E_impl*
end;//TkwStyleEditorExampleFormTextSource.ParamsTypes

function TkwStyleEditorExampleFormEditorPanel.EditorPanel(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TvtPanel;
 {* ���������� ����� ������� .TStyleEditorExampleForm.EditorPanel }
//#UC START# *FEFA6CD2F33E_42F01C50817A_var*
//#UC END# *FEFA6CD2F33E_42F01C50817A_var*
begin
//#UC START# *FEFA6CD2F33E_42F01C50817A_impl*
 !!! Needs to be implemented !!!
//#UC END# *FEFA6CD2F33E_42F01C50817A_impl*
end;//TkwStyleEditorExampleFormEditorPanel.EditorPanel

procedure TkwStyleEditorExampleFormEditorPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_42F01C50817A_var*
//#UC END# *4DAEEDE10285_42F01C50817A_var*
begin
//#UC START# *4DAEEDE10285_42F01C50817A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_42F01C50817A_impl*
end;//TkwStyleEditorExampleFormEditorPanel.DoDoIt

class function TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.EditorPanel';
end;//TkwStyleEditorExampleFormEditorPanel.GetWordNameForRegister

procedure TkwStyleEditorExampleFormEditorPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_42F01C50817A_var*
//#UC END# *52D00B00031A_42F01C50817A_var*
begin
//#UC START# *52D00B00031A_42F01C50817A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_42F01C50817A_impl*
end;//TkwStyleEditorExampleFormEditorPanel.SetValuePrim

function TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_42F01C50817A_var*
//#UC END# *551544E2001A_42F01C50817A_var*
begin
//#UC START# *551544E2001A_42F01C50817A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_42F01C50817A_impl*
end;//TkwStyleEditorExampleFormEditorPanel.GetResultTypeInfo

function TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormEditorPanel.GetAllParamsCount

function TkwStyleEditorExampleFormEditorPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_42F01C50817A_var*
//#UC END# *5617F4D00243_42F01C50817A_var*
begin
//#UC START# *5617F4D00243_42F01C50817A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_42F01C50817A_impl*
end;//TkwStyleEditorExampleFormEditorPanel.ParamsTypes

function TkwStyleEditorExampleFormEditor.Editor(const aCtx: TtfwContext;
 aStyleEditorExampleForm: TStyleEditorExampleForm): TeeEditorWithoutOperations;
 {* ���������� ����� ������� .TStyleEditorExampleForm.Editor }
//#UC START# *A7476DCB0195_32A323F849AD_var*
//#UC END# *A7476DCB0195_32A323F849AD_var*
begin
//#UC START# *A7476DCB0195_32A323F849AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *A7476DCB0195_32A323F849AD_impl*
end;//TkwStyleEditorExampleFormEditor.Editor

procedure TkwStyleEditorExampleFormEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_32A323F849AD_var*
//#UC END# *4DAEEDE10285_32A323F849AD_var*
begin
//#UC START# *4DAEEDE10285_32A323F849AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_32A323F849AD_impl*
end;//TkwStyleEditorExampleFormEditor.DoDoIt

class function TkwStyleEditorExampleFormEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorExampleForm.Editor';
end;//TkwStyleEditorExampleFormEditor.GetWordNameForRegister

procedure TkwStyleEditorExampleFormEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_32A323F849AD_var*
//#UC END# *52D00B00031A_32A323F849AD_var*
begin
//#UC START# *52D00B00031A_32A323F849AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_32A323F849AD_impl*
end;//TkwStyleEditorExampleFormEditor.SetValuePrim

function TkwStyleEditorExampleFormEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_32A323F849AD_var*
//#UC END# *551544E2001A_32A323F849AD_var*
begin
//#UC START# *551544E2001A_32A323F849AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_32A323F849AD_impl*
end;//TkwStyleEditorExampleFormEditor.GetResultTypeInfo

function TkwStyleEditorExampleFormEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorExampleFormEditor.GetAllParamsCount

function TkwStyleEditorExampleFormEditor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_32A323F849AD_var*
//#UC END# *5617F4D00243_32A323F849AD_var*
begin
//#UC START# *5617F4D00243_32A323F849AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_32A323F849AD_impl*
end;//TkwStyleEditorExampleFormEditor.ParamsTypes

initialization
 Tkw_Form_StyleEditorExample.RegisterInEngine;
 {* ����������� Tkw_Form_StyleEditorExample }
 Tkw_StyleEditorExample_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_StyleEditorExample_Component_TextSource }
 Tkw_StyleEditorExample_Control_EditorPanel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorExample_Control_EditorPanel }
 Tkw_StyleEditorExample_Control_EditorPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorExample_Control_EditorPanel_Push }
 Tkw_StyleEditorExample_Control_Editor.RegisterInEngine;
 {* ����������� Tkw_StyleEditorExample_Control_Editor }
 Tkw_StyleEditorExample_Control_Editor_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorExample_Control_Editor_Push }
 TkwStyleEditorExampleFormTextSource.RegisterInEngine;
 {* ����������� StyleEditorExampleForm_TextSource }
 TkwStyleEditorExampleFormEditorPanel.RegisterInEngine;
 {* ����������� StyleEditorExampleForm_EditorPanel }
 TkwStyleEditorExampleFormEditor.RegisterInEngine;
 {* ����������� StyleEditorExampleForm_Editor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorExampleForm));
 {* ����������� ���� StyleEditorExample }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* ����������� ���� TnscTextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorWithoutOperations));
 {* ����������� ���� TeeEditorWithoutOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
