unit RedactionsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Redactions }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\RedactionsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , nscTreeViewWithAdapterDragDrop
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
 Tkw_Form_Redactions = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Redactions
----
*������ �������������*:
[code]
'aControl' �����::Redactions TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Redactions

 Tkw_Redactions_Control_RedactionTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RedactionTree
----
*������ �������������*:
[code]
�������::RedactionTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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

class function Tkw_Form_Redactions.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Redactions';
end;//Tkw_Form_Redactions.GetWordNameForRegister

function Tkw_Form_Redactions.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4BF10666C1F4_var*
//#UC END# *4DDFD2EA0116_4BF10666C1F4_var*
begin
//#UC START# *4DDFD2EA0116_4BF10666C1F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4BF10666C1F4_impl*
end;//Tkw_Form_Redactions.GetString

class function Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister

function Tkw_Redactions_Control_RedactionTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8515DEBDD215_var*
//#UC END# *4DDFD2EA0116_8515DEBDD215_var*
begin
//#UC START# *4DDFD2EA0116_8515DEBDD215_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8515DEBDD215_impl*
end;//Tkw_Redactions_Control_RedactionTree.GetString

class procedure Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
//#UC START# *52A086150180_8515DEBDD215_var*
//#UC END# *52A086150180_8515DEBDD215_var*
begin
//#UC START# *52A086150180_8515DEBDD215_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8515DEBDD215_impl*
end;//Tkw_Redactions_Control_RedactionTree.RegisterInEngine

procedure Tkw_Redactions_Control_RedactionTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ED029CBD2268_var*
//#UC END# *4DAEEDE10285_ED029CBD2268_var*
begin
//#UC START# *4DAEEDE10285_ED029CBD2268_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ED029CBD2268_impl*
end;//Tkw_Redactions_Control_RedactionTree_Push.DoDoIt

class function Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RedactionTree:push';
end;//Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister

function TkwRedactionsFormRedactionTree.RedactionTree(const aCtx: TtfwContext;
 aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
//#UC START# *B19A1ABEC5DE_A2E39CF13C2B_var*
//#UC END# *B19A1ABEC5DE_A2E39CF13C2B_var*
begin
//#UC START# *B19A1ABEC5DE_A2E39CF13C2B_impl*
 !!! Needs to be implemented !!!
//#UC END# *B19A1ABEC5DE_A2E39CF13C2B_impl*
end;//TkwRedactionsFormRedactionTree.RedactionTree

procedure TkwRedactionsFormRedactionTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A2E39CF13C2B_var*
//#UC END# *4DAEEDE10285_A2E39CF13C2B_var*
begin
//#UC START# *4DAEEDE10285_A2E39CF13C2B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A2E39CF13C2B_impl*
end;//TkwRedactionsFormRedactionTree.DoDoIt

class function TkwRedactionsFormRedactionTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRedactionsForm.RedactionTree';
end;//TkwRedactionsFormRedactionTree.GetWordNameForRegister

procedure TkwRedactionsFormRedactionTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
DoSetValue(, aValue);
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
 Result := OpenTypesToTypes([]);
end;//TkwRedactionsFormRedactionTree.ParamsTypes

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
