unit TreeAttributeFirstLevelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TreeAttributeFirstLevel }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\TreeAttributeFirstLevelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TreeAttributeFirstLevelKeywordsPack" MUID: (4AB8D5F8025F_Pack)

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
 , TreeAttributeFirstLevel_Form
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
;

type
 TkwEfTreeAttributeFirstLevelFirstLevelContent = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent }
  private
   function FirstLevelContent(const aCtx: TtfwContext;
    aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeFirstLevelFirstLevelContent

 Tkw_Form_TreeAttributeFirstLevel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TreeAttributeFirstLevel
----
*������ �������������*:
[code]�����::TreeAttributeFirstLevel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TreeAttributeFirstLevel

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FirstLevelContent
----
*������ �������������*:
[code]�������::FirstLevelContent TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FirstLevelContent
----
*������ �������������*:
[code]�������::FirstLevelContent:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push

function TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent(const aCtx: TtfwContext;
 aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent }
begin
 Result := aefTreeAttributeFirstLevel.FirstLevelContent;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent

class function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeFirstLevel.FirstLevelContent';
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount

function TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeFirstLevel)]);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FirstLevelContent', aCtx);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel;
begin
 try
  l_aefTreeAttributeFirstLevel := TefTreeAttributeFirstLevel(aCtx.rEngine.PopObjAs(TefTreeAttributeFirstLevel));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstLevelContent(aCtx, l_aefTreeAttributeFirstLevel));
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt

function Tkw_Form_TreeAttributeFirstLevel.GetString: AnsiString;
begin
 Result := 'efTreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetString

class procedure Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefTreeAttributeFirstLevel);
end;//Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine

class function Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister

function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString: AnsiString;
begin
 Result := 'FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString

class procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister

procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstLevelContent');
 inherited;
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstLevelContent:push';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister

initialization
 TkwEfTreeAttributeFirstLevelFirstLevelContent.RegisterInEngine;
 {* ����������� efTreeAttributeFirstLevel_FirstLevelContent }
 Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine;
 {* ����������� Tkw_Form_TreeAttributeFirstLevel }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeFirstLevel));
 {* ����������� ���� TefTreeAttributeFirstLevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
