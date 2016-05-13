unit WorkJournalKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� WorkJournal }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\WorkJournalKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "WorkJournalKeywordsPack" MUID: (B772BF700C99)

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
 , WorkJournal_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_WorkJournal

 Tkw_WorkJournal_Control_JournalTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� JournalTree
----
*������ �������������*:
[code]
�������::JournalTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WorkJournal_Control_JournalTree

 Tkw_WorkJournal_Control_JournalTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* ����� ������� .TWorkJournalForm.JournalTree }
  private
   function JournalTree(const aCtx: TtfwContext;
    aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TWorkJournalForm.JournalTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwWorkJournalFormJournalTree

function Tkw_Form_WorkJournal.GetString: AnsiString;
begin
 Result := 'WorkJournalForm';
end;//Tkw_Form_WorkJournal.GetString

class function Tkw_Form_WorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::WorkJournal';
end;//Tkw_Form_WorkJournal.GetWordNameForRegister

function Tkw_WorkJournal_Control_JournalTree.GetString: AnsiString;
begin
 Result := 'JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetString

class procedure Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_WorkJournal_Control_JournalTree.RegisterInEngine

class function Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister

procedure Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('JournalTree');
 inherited;
end;//Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt

class function Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::JournalTree:push';
end;//Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister

function TkwWorkJournalFormJournalTree.JournalTree(const aCtx: TtfwContext;
 aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TWorkJournalForm.JournalTree }
begin
 Result := aWorkJournalForm.JournalTree;
end;//TkwWorkJournalFormJournalTree.JournalTree

procedure TkwWorkJournalFormJournalTree.DoDoIt(const aCtx: TtfwContext);
var l_aWorkJournalForm: TWorkJournalForm;
begin
 try
  l_aWorkJournalForm := TWorkJournalForm(aCtx.rEngine.PopObjAs(TWorkJournalForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWorkJournalForm: TWorkJournalForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(JournalTree(aCtx, l_aWorkJournalForm));
end;//TkwWorkJournalFormJournalTree.DoDoIt

class function TkwWorkJournalFormJournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWorkJournalForm.JournalTree';
end;//TkwWorkJournalFormJournalTree.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TWorkJournalForm)]);
end;//TkwWorkJournalFormJournalTree.ParamsTypes

procedure TkwWorkJournalFormJournalTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� JournalTree', aCtx);
end;//TkwWorkJournalFormJournalTree.SetValuePrim

initialization
 Tkw_Form_WorkJournal.RegisterInEngine;
 {* ����������� Tkw_Form_WorkJournal }
 Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
 {* ����������� Tkw_WorkJournal_Control_JournalTree }
 Tkw_WorkJournal_Control_JournalTree_Push.RegisterInEngine;
 {* ����������� Tkw_WorkJournal_Control_JournalTree_Push }
 TkwWorkJournalFormJournalTree.RegisterInEngine;
 {* ����������� WorkJournalForm_JournalTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWorkJournalForm));
 {* ����������� ���� TWorkJournalForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
