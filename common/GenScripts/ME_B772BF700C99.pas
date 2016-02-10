unit WorkJournalKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� WorkJournal }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\WorkJournalKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseWorkJournal_Module
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
 Tkw_Form_WorkJournal = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� WorkJournal
----
*������ �������������*:
[code]
'aControl' �����::WorkJournal TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_WorkJournal

 Tkw_WorkJournal_Control_JournalTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� JournalTree
----
*������ �������������*:
[code]
�������::JournalTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_WorkJournal_Control_JournalTree

 Tkw_WorkJournal_Control_JournalTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� JournalTree
----
*������ �������������*:
[code]
�������::JournalTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WorkJournal_Control_JournalTree_Push

 TkwWorkJournalFormJournalTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TWorkJournalForm.JournalTree
[panel]������� JournalTree ����� TWorkJournalForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aWorkJournalForm .TWorkJournalForm.JournalTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function JournalTree(const aCtx: TtfwContext;
    aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TWorkJournalForm.JournalTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWorkJournalFormJournalTree

class function Tkw_Form_WorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::WorkJournal';
end;//Tkw_Form_WorkJournal.GetWordNameForRegister

function Tkw_Form_WorkJournal.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_228AAA176ABA_var*
//#UC END# *4DDFD2EA0116_228AAA176ABA_var*
begin
//#UC START# *4DDFD2EA0116_228AAA176ABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_228AAA176ABA_impl*
end;//Tkw_Form_WorkJournal.GetString

class function Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister

function Tkw_WorkJournal_Control_JournalTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E8E6940573D8_var*
//#UC END# *4DDFD2EA0116_E8E6940573D8_var*
begin
//#UC START# *4DDFD2EA0116_E8E6940573D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E8E6940573D8_impl*
end;//Tkw_WorkJournal_Control_JournalTree.GetString

class procedure Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
//#UC START# *52A086150180_E8E6940573D8_var*
//#UC END# *52A086150180_E8E6940573D8_var*
begin
//#UC START# *52A086150180_E8E6940573D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E8E6940573D8_impl*
end;//Tkw_WorkJournal_Control_JournalTree.RegisterInEngine

procedure Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C5BABF360A3C_var*
//#UC END# *4DAEEDE10285_C5BABF360A3C_var*
begin
//#UC START# *4DAEEDE10285_C5BABF360A3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C5BABF360A3C_impl*
end;//Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt

class function Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::JournalTree:push';
end;//Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister

function TkwWorkJournalFormJournalTree.JournalTree(const aCtx: TtfwContext;
 aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TWorkJournalForm.JournalTree }
//#UC START# *0880E186193F_2FB40EF219EB_var*
//#UC END# *0880E186193F_2FB40EF219EB_var*
begin
//#UC START# *0880E186193F_2FB40EF219EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *0880E186193F_2FB40EF219EB_impl*
end;//TkwWorkJournalFormJournalTree.JournalTree

procedure TkwWorkJournalFormJournalTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2FB40EF219EB_var*
//#UC END# *4DAEEDE10285_2FB40EF219EB_var*
begin
//#UC START# *4DAEEDE10285_2FB40EF219EB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2FB40EF219EB_impl*
end;//TkwWorkJournalFormJournalTree.DoDoIt

class function TkwWorkJournalFormJournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWorkJournalForm.JournalTree';
end;//TkwWorkJournalFormJournalTree.GetWordNameForRegister

procedure TkwWorkJournalFormJournalTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwWorkJournalFormJournalTree.SetValuePrim

function TkwWorkJournalFormJournalTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwWorkJournalFormJournalTree.GetResultTypeInfo

function TkwWorkJournalFormJournalTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWorkJournalFormJournalTree.GetAllParamsCount

function TkwWorkJournalFormJournalTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwWorkJournalFormJournalTree.ParamsTypes

initialization
 Tkw_Form_WorkJournal.RegisterInEngine;
 {* ����������� Tkw_Form_WorkJournal }
 Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
 {* ����������� Tkw_WorkJournal_Control_JournalTree }
 Tkw_WorkJournal_Control_JournalTree_Push.RegisterInEngine;
 {* ����������� Tkw_WorkJournal_Control_JournalTree_Push }
 TkwWorkJournalFormJournalTree.RegisterInEngine;
 {* ����������� WorkJournalForm_JournalTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWorkJournalForm));
 {* ����������� ���� WorkJournal }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
