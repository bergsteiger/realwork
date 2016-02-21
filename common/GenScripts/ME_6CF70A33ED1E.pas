unit TreeAttributeSelectKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TreeAttributeSelect }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\TreeAttributeSelectKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LiteSearch_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , SearchLite_Strange_Controls
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
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
 Tkw_Form_TreeAttributeSelect = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TreeAttributeSelect
----
*������ �������������*:
[code]
'aControl' �����::TreeAttributeSelect TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect

 Tkw_TreeAttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel

 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

 Tkw_TreeAttributeSelect_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter

 Tkw_TreeAttributeSelect_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push

 Tkw_TreeAttributeSelect_Control_AttributeTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� AttributeTree
----
*������ �������������*:
[code]
�������::AttributeTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree

 Tkw_TreeAttributeSelect_Control_AttributeTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� AttributeTree
----
*������ �������������*:
[code]
�������::AttributeTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push

 TkwEfTreeAttributeSelectBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.BackgroundPanel
[panel]������� BackgroundPanel ����� TefTreeAttributeSelect[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefTreeAttributeSelect .TefTreeAttributeSelect.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
    {* ���������� ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectBackgroundPanel

 TkwEfTreeAttributeSelectContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.ContextFilter
[panel]������� ContextFilter ����� TefTreeAttributeSelect[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aefTreeAttributeSelect .TefTreeAttributeSelect.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
    {* ���������� ����� ������� .TefTreeAttributeSelect.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectContextFilter

 TkwEfTreeAttributeSelectAttributeTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeSelect.AttributeTree
[panel]������� AttributeTree ����� TefTreeAttributeSelect[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aefTreeAttributeSelect .TefTreeAttributeSelect.AttributeTree >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function AttributeTree(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .TefTreeAttributeSelect.AttributeTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectAttributeTree

class function Tkw_Form_TreeAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetWordNameForRegister

function Tkw_Form_TreeAttributeSelect.GetString: AnsiString;
begin
 Result := 'efTreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetString

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_95E80DC828A3_var*
//#UC END# *4DAEEDE10285_95E80DC828A3_var*
begin
//#UC START# *4DAEEDE10285_95E80DC828A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_95E80DC828A3_impl*
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetString

class procedure Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BF89704B3469_var*
//#UC END# *4DAEEDE10285_BF89704B3469_var*
begin
//#UC START# *4DAEEDE10285_BF89704B3469_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BF89704B3469_impl*
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_AttributeTree.GetString: AnsiString;
begin
 Result := 'AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetString

class procedure Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1774552B0AC8_var*
//#UC END# *4DAEEDE10285_1774552B0AC8_var*
begin
//#UC START# *4DAEEDE10285_1774552B0AC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1774552B0AC8_impl*
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AttributeTree:push';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister

function TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
 {* ���������� ����� ������� .TefTreeAttributeSelect.BackgroundPanel }
begin
 Result := aefTreeAttributeSelect.BackgroundPanel;
end;//TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel

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

class function TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.BackgroundPanel';
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim

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

function TkwEfTreeAttributeSelectContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
 {* ���������� ����� ������� .TefTreeAttributeSelect.ContextFilter }
begin
 Result := aefTreeAttributeSelect.ContextFilter;
end;//TkwEfTreeAttributeSelectContextFilter.ContextFilter

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

class function TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.ContextFilter';
end;//TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEfTreeAttributeSelectContextFilter.SetValuePrim

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

function TkwEfTreeAttributeSelectAttributeTree.AttributeTree(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .TefTreeAttributeSelect.AttributeTree }
begin
 Result := aefTreeAttributeSelect.AttributeTree;
end;//TkwEfTreeAttributeSelectAttributeTree.AttributeTree

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

class function TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.AttributeTree';
end;//TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectAttributeTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AttributeTree', aCtx);
end;//TkwEfTreeAttributeSelectAttributeTree.SetValuePrim

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

initialization
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
 TkwEfTreeAttributeSelectBackgroundPanel.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_BackgroundPanel }
 TkwEfTreeAttributeSelectContextFilter.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_ContextFilter }
 TkwEfTreeAttributeSelectAttributeTree.RegisterInEngine;
 {* ����������� efTreeAttributeSelect_AttributeTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeSelect));
 {* ����������� ���� TreeAttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(NoScripts)

end.
