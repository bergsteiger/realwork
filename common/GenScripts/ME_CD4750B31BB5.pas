unit RubricatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Rubricator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\RubricatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , nscSimpleEditor
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Rubricator_Form
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
 Tkw_Form_Rubricator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Rubricator
----
*������ �������������*:
[code]
'aControl' �����::Rubricator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Rubricator

 Tkw_Rubricator_Control_RubricatorList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RubricatorList
----
*������ �������������*:
[code]
�������::RubricatorList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_RubricatorList

 Tkw_Rubricator_Control_RubricatorList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RubricatorList
----
*������ �������������*:
[code]
�������::RubricatorList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_RubricatorList_Push

 Tkw_Rubricator_Control_TopPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_TopPanel

 Tkw_Rubricator_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_TopPanel_Push

 Tkw_Rubricator_Control_PaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PaintBox
----
*������ �������������*:
[code]
�������::PaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_PaintBox

 Tkw_Rubricator_Control_PaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PaintBox
----
*������ �������������*:
[code]
�������::PaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_PaintBox_Push

 Tkw_Rubricator_Control_NewDocLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NewDocLabel
----
*������ �������������*:
[code]
�������::NewDocLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_NewDocLabel

 Tkw_Rubricator_Control_NewDocLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NewDocLabel
----
*������ �������������*:
[code]
�������::NewDocLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_NewDocLabel_Push

 Tkw_Rubricator_Control_DelimiterPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DelimiterPanel
----
*������ �������������*:
[code]
�������::DelimiterPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_DelimiterPanel

 Tkw_Rubricator_Control_DelimiterPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DelimiterPanel
----
*������ �������������*:
[code]
�������::DelimiterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_DelimiterPanel_Push

 Tkw_Rubricator_Component_ExampleTextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ExampleTextSource
----
*������ �������������*:
[code]
���������::ExampleTextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Component_ExampleTextSource

 TkwEfRubricatorRubricatorList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.RubricatorList
[panel]������� RubricatorList ����� TefRubricator[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefRubricator .TefRubricator.RubricatorList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function RubricatorList(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TefRubricator.RubricatorList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorRubricatorList

 TkwEfRubricatorTopPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.TopPanel
[panel]������� TopPanel ����� TefRubricator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TvtPanel;
    {* ���������� ����� ������� .TefRubricator.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorTopPanel

 TkwEfRubricatorPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.PaintBox
[panel]������� PaintBox ����� TefRubricator[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefRubricator .TefRubricator.PaintBox >>> l_TPaintBox
[code]  }
  private
   function PaintBox(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TPaintBox;
    {* ���������� ����� ������� .TefRubricator.PaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorPaintBox

 TkwEfRubricatorNewDocLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.NewDocLabel
[panel]������� NewDocLabel ����� TefRubricator[panel]
*��� ����������:* TnscSimpleEditor
*������:*
[code]
OBJECT VAR l_TnscSimpleEditor
 aefRubricator .TefRubricator.NewDocLabel >>> l_TnscSimpleEditor
[code]  }
  private
   function NewDocLabel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscSimpleEditor;
    {* ���������� ����� ������� .TefRubricator.NewDocLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorNewDocLabel

 TkwEfRubricatorDelimiterPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.DelimiterPanel
[panel]������� DelimiterPanel ����� TefRubricator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.DelimiterPanel >>> l_TvtPanel
[code]  }
  private
   function DelimiterPanel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TvtPanel;
    {* ���������� ����� ������� .TefRubricator.DelimiterPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorDelimiterPanel

 TkwEfRubricatorExampleTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.ExampleTextSource
[panel]������� ExampleTextSource ����� TefRubricator[panel]
*��� ����������:* TnscTextSource
*������:*
[code]
OBJECT VAR l_TnscTextSource
 aefRubricator .TefRubricator.ExampleTextSource >>> l_TnscTextSource
[code]  }
  private
   function ExampleTextSource(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscTextSource;
    {* ���������� ����� ������� .TefRubricator.ExampleTextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorExampleTextSource

class function Tkw_Form_Rubricator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Rubricator';
end;//Tkw_Form_Rubricator.GetWordNameForRegister

function Tkw_Form_Rubricator.GetString: AnsiString;
begin
 Result := 'efRubricator';
end;//Tkw_Form_Rubricator.GetString

class function Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RubricatorList';
end;//Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister

function Tkw_Rubricator_Control_RubricatorList.GetString: AnsiString;
begin
 Result := 'RubricatorList';
end;//Tkw_Rubricator_Control_RubricatorList.GetString

class procedure Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Rubricator_Control_RubricatorList.RegisterInEngine

procedure Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RubricatorList');
 inherited;
end;//Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt

class function Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RubricatorList:push';
end;//Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel';
end;//Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_TopPanel.GetString: AnsiString;
begin
 Result := 'TopPanel';
end;//Tkw_Rubricator_Control_TopPanel.GetString

class procedure Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Rubricator_Control_TopPanel.RegisterInEngine

procedure Tkw_Rubricator_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_Rubricator_Control_TopPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel:push';
end;//Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PaintBox';
end;//Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister

function Tkw_Rubricator_Control_PaintBox.GetString: AnsiString;
begin
 Result := 'PaintBox';
end;//Tkw_Rubricator_Control_PaintBox.GetString

class procedure Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_Rubricator_Control_PaintBox.RegisterInEngine

procedure Tkw_Rubricator_Control_PaintBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PaintBox');
 inherited;
end;//Tkw_Rubricator_Control_PaintBox_Push.DoDoIt

class function Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PaintBox:push';
end;//Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewDocLabel';
end;//Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister

function Tkw_Rubricator_Control_NewDocLabel.GetString: AnsiString;
begin
 Result := 'NewDocLabel';
end;//Tkw_Rubricator_Control_NewDocLabel.GetString

class procedure Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditor);
end;//Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine

procedure Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NewDocLabel');
 inherited;
end;//Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt

class function Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewDocLabel:push';
end;//Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DelimiterPanel';
end;//Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_DelimiterPanel.GetString: AnsiString;
begin
 Result := 'DelimiterPanel';
end;//Tkw_Rubricator_Control_DelimiterPanel.GetString

class procedure Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine

procedure Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DelimiterPanel');
 inherited;
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DelimiterPanel:push';
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ExampleTextSource';
end;//Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister

function Tkw_Rubricator_Component_ExampleTextSource.GetString: AnsiString;
begin
 Result := 'ExampleTextSource';
end;//Tkw_Rubricator_Component_ExampleTextSource.GetString

class procedure Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine

function TkwEfRubricatorRubricatorList.RubricatorList(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TefRubricator.RubricatorList }
begin
 Result := aefRubricator.RubricatorList;
end;//TkwEfRubricatorRubricatorList.RubricatorList

procedure TkwEfRubricatorRubricatorList.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RubricatorList(aCtx, l_aefRubricator));
end;//TkwEfRubricatorRubricatorList.DoDoIt

class function TkwEfRubricatorRubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.RubricatorList';
end;//TkwEfRubricatorRubricatorList.GetWordNameForRegister

procedure TkwEfRubricatorRubricatorList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RubricatorList', aCtx);
end;//TkwEfRubricatorRubricatorList.SetValuePrim

function TkwEfRubricatorRubricatorList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfRubricatorRubricatorList.GetResultTypeInfo

function TkwEfRubricatorRubricatorList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorRubricatorList.GetAllParamsCount

function TkwEfRubricatorRubricatorList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorRubricatorList.ParamsTypes

function TkwEfRubricatorTopPanel.TopPanel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TvtPanel;
 {* ���������� ����� ������� .TefRubricator.TopPanel }
begin
 Result := aefRubricator.TopPanel;
end;//TkwEfRubricatorTopPanel.TopPanel

procedure TkwEfRubricatorTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopPanel(aCtx, l_aefRubricator));
end;//TkwEfRubricatorTopPanel.DoDoIt

class function TkwEfRubricatorTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.TopPanel';
end;//TkwEfRubricatorTopPanel.GetWordNameForRegister

procedure TkwEfRubricatorTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TopPanel', aCtx);
end;//TkwEfRubricatorTopPanel.SetValuePrim

function TkwEfRubricatorTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfRubricatorTopPanel.GetResultTypeInfo

function TkwEfRubricatorTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorTopPanel.GetAllParamsCount

function TkwEfRubricatorTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorTopPanel.ParamsTypes

function TkwEfRubricatorPaintBox.PaintBox(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TPaintBox;
 {* ���������� ����� ������� .TefRubricator.PaintBox }
begin
 Result := aefRubricator.PaintBox;
end;//TkwEfRubricatorPaintBox.PaintBox

procedure TkwEfRubricatorPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PaintBox(aCtx, l_aefRubricator));
end;//TkwEfRubricatorPaintBox.DoDoIt

class function TkwEfRubricatorPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.PaintBox';
end;//TkwEfRubricatorPaintBox.GetWordNameForRegister

procedure TkwEfRubricatorPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PaintBox', aCtx);
end;//TkwEfRubricatorPaintBox.SetValuePrim

function TkwEfRubricatorPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfRubricatorPaintBox.GetResultTypeInfo

function TkwEfRubricatorPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorPaintBox.GetAllParamsCount

function TkwEfRubricatorPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorPaintBox.ParamsTypes

function TkwEfRubricatorNewDocLabel.NewDocLabel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscSimpleEditor;
 {* ���������� ����� ������� .TefRubricator.NewDocLabel }
begin
 Result := aefRubricator.NewDocLabel;
end;//TkwEfRubricatorNewDocLabel.NewDocLabel

procedure TkwEfRubricatorNewDocLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NewDocLabel(aCtx, l_aefRubricator));
end;//TkwEfRubricatorNewDocLabel.DoDoIt

class function TkwEfRubricatorNewDocLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.NewDocLabel';
end;//TkwEfRubricatorNewDocLabel.GetWordNameForRegister

procedure TkwEfRubricatorNewDocLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NewDocLabel', aCtx);
end;//TkwEfRubricatorNewDocLabel.SetValuePrim

function TkwEfRubricatorNewDocLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscSimpleEditor);
end;//TkwEfRubricatorNewDocLabel.GetResultTypeInfo

function TkwEfRubricatorNewDocLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorNewDocLabel.GetAllParamsCount

function TkwEfRubricatorNewDocLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorNewDocLabel.ParamsTypes

function TkwEfRubricatorDelimiterPanel.DelimiterPanel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TvtPanel;
 {* ���������� ����� ������� .TefRubricator.DelimiterPanel }
begin
 Result := aefRubricator.DelimiterPanel;
end;//TkwEfRubricatorDelimiterPanel.DelimiterPanel

procedure TkwEfRubricatorDelimiterPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DelimiterPanel(aCtx, l_aefRubricator));
end;//TkwEfRubricatorDelimiterPanel.DoDoIt

class function TkwEfRubricatorDelimiterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.DelimiterPanel';
end;//TkwEfRubricatorDelimiterPanel.GetWordNameForRegister

procedure TkwEfRubricatorDelimiterPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DelimiterPanel', aCtx);
end;//TkwEfRubricatorDelimiterPanel.SetValuePrim

function TkwEfRubricatorDelimiterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfRubricatorDelimiterPanel.GetResultTypeInfo

function TkwEfRubricatorDelimiterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorDelimiterPanel.GetAllParamsCount

function TkwEfRubricatorDelimiterPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorDelimiterPanel.ParamsTypes

function TkwEfRubricatorExampleTextSource.ExampleTextSource(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscTextSource;
 {* ���������� ����� ������� .TefRubricator.ExampleTextSource }
begin
 Result := aefRubricator.ExampleTextSource;
end;//TkwEfRubricatorExampleTextSource.ExampleTextSource

procedure TkwEfRubricatorExampleTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aefRubricator: TefRubricator;
begin
 try
  l_aefRubricator := TefRubricator(aCtx.rEngine.PopObjAs(TefRubricator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefRubricator: TefRubricator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ExampleTextSource(aCtx, l_aefRubricator));
end;//TkwEfRubricatorExampleTextSource.DoDoIt

class function TkwEfRubricatorExampleTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.ExampleTextSource';
end;//TkwEfRubricatorExampleTextSource.GetWordNameForRegister

procedure TkwEfRubricatorExampleTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ExampleTextSource', aCtx);
end;//TkwEfRubricatorExampleTextSource.SetValuePrim

function TkwEfRubricatorExampleTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwEfRubricatorExampleTextSource.GetResultTypeInfo

function TkwEfRubricatorExampleTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfRubricatorExampleTextSource.GetAllParamsCount

function TkwEfRubricatorExampleTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefRubricator)]);
end;//TkwEfRubricatorExampleTextSource.ParamsTypes

initialization
 Tkw_Form_Rubricator.RegisterInEngine;
 {* ����������� Tkw_Form_Rubricator }
 Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_RubricatorList }
 Tkw_Rubricator_Control_RubricatorList_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_RubricatorList_Push }
 Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_TopPanel }
 Tkw_Rubricator_Control_TopPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_TopPanel_Push }
 Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_PaintBox }
 Tkw_Rubricator_Control_PaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_PaintBox_Push }
 Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_NewDocLabel }
 Tkw_Rubricator_Control_NewDocLabel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_NewDocLabel_Push }
 Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_DelimiterPanel }
 Tkw_Rubricator_Control_DelimiterPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_DelimiterPanel_Push }
 Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Component_ExampleTextSource }
 TkwEfRubricatorRubricatorList.RegisterInEngine;
 {* ����������� efRubricator_RubricatorList }
 TkwEfRubricatorTopPanel.RegisterInEngine;
 {* ����������� efRubricator_TopPanel }
 TkwEfRubricatorPaintBox.RegisterInEngine;
 {* ����������� efRubricator_PaintBox }
 TkwEfRubricatorNewDocLabel.RegisterInEngine;
 {* ����������� efRubricator_NewDocLabel }
 TkwEfRubricatorDelimiterPanel.RegisterInEngine;
 {* ����������� efRubricator_DelimiterPanel }
 TkwEfRubricatorExampleTextSource.RegisterInEngine;
 {* ����������� efRubricator_ExampleTextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefRubricator));
 {* ����������� ���� Rubricator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
 {* ����������� ���� TnscSimpleEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* ����������� ���� TnscTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
