unit RedactionsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Redactions }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\RedactionsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "RedactionsKeywordsPack" MUID: (B7646B5A91F5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Redactions_Form
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
 Tkw_Form_Redactions = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Redactions
----
*������ �������������*:
[code]
'aControl' �����::Redactions TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Redactions

 Tkw_Redactions_Control_RedactionTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RedactionTree
----
*������ �������������*:
[code]
�������::RedactionTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Redactions_Control_RedactionTree

 Tkw_Redactions_Control_RedactionTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RedactionTree
----
*������ �������������*:
[code]
�������::RedactionTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Redactions_Control_RedactionTree_Push

 TkwRedactionsFormRedactionTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRedactionsForm.RedactionTree
[panel]������� RedactionTree ����� TRedactionsForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aRedactionsForm .TRedactionsForm.RedactionTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function RedactionTree(const aCtx: TtfwContext;
    aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRedactionsFormRedactionTree

function Tkw_Form_Redactions.GetString: AnsiString;
begin
 Result := 'RedactionsForm';
end;//Tkw_Form_Redactions.GetString

class function Tkw_Form_Redactions.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Redactions';
end;//Tkw_Form_Redactions.GetWordNameForRegister

function Tkw_Redactions_Control_RedactionTree.GetString: AnsiString;
begin
 Result := 'RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetString

class procedure Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Redactions_Control_RedactionTree.RegisterInEngine

class function Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister

procedure Tkw_Redactions_Control_RedactionTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RedactionTree');
 inherited;
end;//Tkw_Redactions_Control_RedactionTree_Push.DoDoIt

class function Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RedactionTree:push';
end;//Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister

function TkwRedactionsFormRedactionTree.RedactionTree(const aCtx: TtfwContext;
 aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
begin
 Result := aRedactionsForm.RedactionTree;
end;//TkwRedactionsFormRedactionTree.RedactionTree

procedure TkwRedactionsFormRedactionTree.DoDoIt(const aCtx: TtfwContext);
var l_aRedactionsForm: TRedactionsForm;
begin
 try
  l_aRedactionsForm := TRedactionsForm(aCtx.rEngine.PopObjAs(TRedactionsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRedactionsForm: TRedactionsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RedactionTree(aCtx, l_aRedactionsForm));
end;//TkwRedactionsFormRedactionTree.DoDoIt

procedure TkwRedactionsFormRedactionTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RedactionTree', aCtx);
end;//TkwRedactionsFormRedactionTree.SetValuePrim

function TkwRedactionsFormRedactionTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwRedactionsFormRedactionTree.GetResultTypeInfo

function TkwRedactionsFormRedactionTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRedactionsFormRedactionTree.GetAllParamsCount

function TkwRedactionsFormRedactionTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRedactionsForm)]);
end;//TkwRedactionsFormRedactionTree.ParamsTypes

class function TkwRedactionsFormRedactionTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRedactionsForm.RedactionTree';
end;//TkwRedactionsFormRedactionTree.GetWordNameForRegister

initialization
 Tkw_Form_Redactions.RegisterInEngine;
 {* ����������� Tkw_Form_Redactions }
 Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
 {* ����������� Tkw_Redactions_Control_RedactionTree }
 Tkw_Redactions_Control_RedactionTree_Push.RegisterInEngine;
 {* ����������� Tkw_Redactions_Control_RedactionTree_Push }
 TkwRedactionsFormRedactionTree.RegisterInEngine;
 {* ����������� RedactionsForm_RedactionTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRedactionsForm));
 {* ����������� ���� Redactions }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
