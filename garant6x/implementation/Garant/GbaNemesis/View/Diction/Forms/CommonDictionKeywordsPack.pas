unit CommonDictionKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CommonDiction }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\CommonDictionKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "CommonDictionKeywordsPack" MUID: (4ABBB22002AA_Pack)

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
 , CommonDiction_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABBB22002AA_Packimpl_uses*
 //#UC END# *4ABBB22002AA_Packimpl_uses*
;

type
 TkwEnCommonDictionBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_CommonDiction.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TvtPanel;
    {* ���������� ����� ������� .Ten_CommonDiction.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCommonDictionBackgroundPanel

 TkwEnCommonDictionWordsTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_CommonDiction.WordsTree }
  private
   function WordsTree(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_CommonDiction.WordsTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCommonDictionWordsTree

 TkwEnCommonDictionContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_CommonDiction.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
    {* ���������� ����� ������� .Ten_CommonDiction.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCommonDictionContextFilter

 Tkw_Form_CommonDiction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CommonDiction
----
*������ �������������*:
[code]�����::CommonDiction TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CommonDiction

 Tkw_CommonDiction_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_BackgroundPanel

 Tkw_CommonDiction_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_BackgroundPanel_Push

 Tkw_CommonDiction_Control_WordsTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WordsTree
----
*������ �������������*:
[code]�������::WordsTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_WordsTree

 Tkw_CommonDiction_Control_WordsTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WordsTree
----
*������ �������������*:
[code]�������::WordsTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_WordsTree_Push

 Tkw_CommonDiction_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_ContextFilter

 Tkw_CommonDiction_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_ContextFilter_Push

function TkwEnCommonDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TvtPanel;
 {* ���������� ����� ������� .Ten_CommonDiction.BackgroundPanel }
begin
 Result := aen_CommonDiction.BackgroundPanel;
end;//TkwEnCommonDictionBackgroundPanel.BackgroundPanel

class function TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.BackgroundPanel';
end;//TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister

function TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo

function TkwEnCommonDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionBackgroundPanel.GetAllParamsCount

function TkwEnCommonDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionBackgroundPanel.ParamsTypes

procedure TkwEnCommonDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEnCommonDictionBackgroundPanel.SetValuePrim

procedure TkwEnCommonDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionBackgroundPanel.DoDoIt

function TkwEnCommonDictionWordsTree.WordsTree(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_CommonDiction.WordsTree }
begin
 Result := aen_CommonDiction.WordsTree;
end;//TkwEnCommonDictionWordsTree.WordsTree

class function TkwEnCommonDictionWordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.WordsTree';
end;//TkwEnCommonDictionWordsTree.GetWordNameForRegister

function TkwEnCommonDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnCommonDictionWordsTree.GetResultTypeInfo

function TkwEnCommonDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionWordsTree.GetAllParamsCount

function TkwEnCommonDictionWordsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionWordsTree.ParamsTypes

procedure TkwEnCommonDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WordsTree', aCtx);
end;//TkwEnCommonDictionWordsTree.SetValuePrim

procedure TkwEnCommonDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WordsTree(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionWordsTree.DoDoIt

function TkwEnCommonDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
 {* ���������� ����� ������� .Ten_CommonDiction.ContextFilter }
begin
 Result := aen_CommonDiction.ContextFilter;
end;//TkwEnCommonDictionContextFilter.ContextFilter

class function TkwEnCommonDictionContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.ContextFilter';
end;//TkwEnCommonDictionContextFilter.GetWordNameForRegister

function TkwEnCommonDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnCommonDictionContextFilter.GetResultTypeInfo

function TkwEnCommonDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionContextFilter.GetAllParamsCount

function TkwEnCommonDictionContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionContextFilter.ParamsTypes

procedure TkwEnCommonDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEnCommonDictionContextFilter.SetValuePrim

procedure TkwEnCommonDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionContextFilter.DoDoIt

function Tkw_Form_CommonDiction.GetString: AnsiString;
begin
 Result := 'en_CommonDiction';
end;//Tkw_Form_CommonDiction.GetString

class procedure Tkw_Form_CommonDiction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_CommonDiction);
end;//Tkw_Form_CommonDiction.RegisterInEngine

class function Tkw_Form_CommonDiction.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CommonDiction';
end;//Tkw_Form_CommonDiction.GetWordNameForRegister

function Tkw_CommonDiction_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetString

class procedure Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine

class function Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_CommonDiction_Control_WordsTree.GetString: AnsiString;
begin
 Result := 'WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetString

class procedure Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CommonDiction_Control_WordsTree.RegisterInEngine

class function Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister

procedure Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WordsTree');
 inherited;
end;//Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt

class function Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WordsTree:push';
end;//Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister

function Tkw_CommonDiction_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetString

class procedure Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine

class function Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt

class function Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister

initialization
 TkwEnCommonDictionBackgroundPanel.RegisterInEngine;
 {* ����������� en_CommonDiction_BackgroundPanel }
 TkwEnCommonDictionWordsTree.RegisterInEngine;
 {* ����������� en_CommonDiction_WordsTree }
 TkwEnCommonDictionContextFilter.RegisterInEngine;
 {* ����������� en_CommonDiction_ContextFilter }
 Tkw_Form_CommonDiction.RegisterInEngine;
 {* ����������� Tkw_Form_CommonDiction }
 Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_BackgroundPanel }
 Tkw_CommonDiction_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_BackgroundPanel_Push }
 Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_WordsTree }
 Tkw_CommonDiction_Control_WordsTree_Push.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_WordsTree_Push }
 Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_ContextFilter }
 Tkw_CommonDiction_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_CommonDiction_Control_ContextFilter_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_CommonDiction));
 {* ����������� ���� Ten_CommonDiction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
{$IfEnd} // Defined(Nemesis)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
