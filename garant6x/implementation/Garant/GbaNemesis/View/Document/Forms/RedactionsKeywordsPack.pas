unit RedactionsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Redactions }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\RedactionsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "RedactionsKeywordsPack" MUID: (4A8EE2890012_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Redactions_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A8EE2890012_Packimpl_uses*
 //#UC END# *4A8EE2890012_Packimpl_uses*
;

type
 TkwRedactionsFormRedactionTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRedactionsForm.RedactionTree }
  private
   function RedactionTree(const aCtx: TtfwContext;
    aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRedactionsFormRedactionTree

 Tkw_Form_Redactions = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Redactions
----
*������ �������������*:
[code]�����::Redactions TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Redactions

 Tkw_Redactions_Control_RedactionTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RedactionTree
----
*������ �������������*:
[code]�������::RedactionTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Redactions_Control_RedactionTree

 Tkw_Redactions_Control_RedactionTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RedactionTree
----
*������ �������������*:
[code]�������::RedactionTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Redactions_Control_RedactionTree_Push

function TkwRedactionsFormRedactionTree.RedactionTree(const aCtx: TtfwContext;
 aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
begin
 Result := aRedactionsForm.RedactionTree;
end;//TkwRedactionsFormRedactionTree.RedactionTree

class function TkwRedactionsFormRedactionTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRedactionsForm.RedactionTree';
end;//TkwRedactionsFormRedactionTree.GetWordNameForRegister

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

procedure TkwRedactionsFormRedactionTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RedactionTree', aCtx);
end;//TkwRedactionsFormRedactionTree.SetValuePrim

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

function Tkw_Form_Redactions.GetString: AnsiString;
begin
 Result := 'RedactionsForm';
end;//Tkw_Form_Redactions.GetString

class procedure Tkw_Form_Redactions.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TRedactionsForm);
end;//Tkw_Form_Redactions.RegisterInEngine

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

initialization
 TkwRedactionsFormRedactionTree.RegisterInEngine;
 {* ����������� RedactionsForm_RedactionTree }
 Tkw_Form_Redactions.RegisterInEngine;
 {* ����������� Tkw_Form_Redactions }
 Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
 {* ����������� Tkw_Redactions_Control_RedactionTree }
 Tkw_Redactions_Control_RedactionTree_Push.RegisterInEngine;
 {* ����������� Tkw_Redactions_Control_RedactionTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRedactionsForm));
 {* ����������� ���� TRedactionsForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
