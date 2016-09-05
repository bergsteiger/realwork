unit TreeAttributeSelectKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TreeAttributeSelect }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelectKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TreeAttributeSelectKeywordsPack" MUID: (4AAF487F03BC_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , TreeAttributeSelect_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AAF487F03BC_Packimpl_uses*
 //#UC END# *4AAF487F03BC_Packimpl_uses*
;

type
 TkwEfTreeAttributeSelectBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
    {* ���������� ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectBackgroundPanel

 TkwEfTreeAttributeSelectContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
    {* ���������� ����� ������� .TefTreeAttributeSelect.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectContextFilter

 TkwEfTreeAttributeSelectAttributeTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.AttributeTree }
  private
   function AttributeTree(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .TefTreeAttributeSelect.AttributeTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectAttributeTree

 Tkw_Form_TreeAttributeSelect = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TreeAttributeSelect
----
*������ �������������*:
[code]�����::TreeAttributeSelect TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect

 Tkw_TreeAttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel

 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

 Tkw_TreeAttributeSelect_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter

 Tkw_TreeAttributeSelect_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push

 Tkw_TreeAttributeSelect_Control_AttributeTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� AttributeTree
----
*������ �������������*:
[code]�������::AttributeTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree

 Tkw_TreeAttributeSelect_Control_AttributeTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� AttributeTree
----
*������ �������������*:
[code]�������::AttributeTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push

function TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
 {* ���������� ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
begin
 Result := aefTreeAttributeSelect.BackgroundPanel;
end;//TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel

class function TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.BackgroundPanel';
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister

function TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes

procedure TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim

procedure TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt

function TkwEfTreeAttributeSelectContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
 {* ���������� ����� ������� .TefTreeAttributeSelect.ContextFilter }
begin
 Result := aefTreeAttributeSelect.ContextFilter;
end;//TkwEfTreeAttributeSelectContextFilter.ContextFilter

class function TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.ContextFilter';
end;//TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister

function TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo

function TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount

function TkwEfTreeAttributeSelectContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectContextFilter.ParamsTypes

procedure TkwEfTreeAttributeSelectContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEfTreeAttributeSelectContextFilter.SetValuePrim

procedure TkwEfTreeAttributeSelectContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectContextFilter.DoDoIt

function TkwEfTreeAttributeSelectAttributeTree.AttributeTree(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .TefTreeAttributeSelect.AttributeTree }
begin
 Result := aefTreeAttributeSelect.AttributeTree;
end;//TkwEfTreeAttributeSelectAttributeTree.AttributeTree

class function TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.AttributeTree';
end;//TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister

function TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo

function TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount

function TkwEfTreeAttributeSelectAttributeTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectAttributeTree.ParamsTypes

procedure TkwEfTreeAttributeSelectAttributeTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AttributeTree', aCtx);
end;//TkwEfTreeAttributeSelectAttributeTree.SetValuePrim

procedure TkwEfTreeAttributeSelectAttributeTree.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AttributeTree(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectAttributeTree.DoDoIt

function Tkw_Form_TreeAttributeSelect.GetString: AnsiString;
begin
 Result := 'efTreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetString

class procedure Tkw_Form_TreeAttributeSelect.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefTreeAttributeSelect);
end;//Tkw_Form_TreeAttributeSelect.RegisterInEngine

class function Tkw_Form_TreeAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetString

class procedure Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_AttributeTree.GetString: AnsiString;
begin
 Result := 'AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetString

class procedure Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AttributeTree');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AttributeTree:push';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister

initialization
 TkwEfTreeAttributeSelectBackgroundPanel.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_BackgroundPanel }
 TkwEfTreeAttributeSelectContextFilter.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_ContextFilter }
 TkwEfTreeAttributeSelectAttributeTree.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_AttributeTree }
 Tkw_Form_TreeAttributeSelect.RegisterInEngine;
 {* ����������� Tkw_Form_TreeAttributeSelect }
 Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_BackgroundPanel }
 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push }
 Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_ContextFilter }
 Tkw_TreeAttributeSelect_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_ContextFilter_Push }
 Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_AttributeTree }
 Tkw_TreeAttributeSelect_Control_AttributeTree_Push.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeSelect_Control_AttributeTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeSelect));
 {* ����������� ���� TefTreeAttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
