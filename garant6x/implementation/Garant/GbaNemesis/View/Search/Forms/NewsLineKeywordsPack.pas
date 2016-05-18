unit NewsLineKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� NewsLine }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\NewsLineKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "NewsLineKeywordsPack" MUID: (4A8ECFCD0174_Pack)

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
 , NewsLine_Form
 , tfwPropertyLike
 , nscTreeViewForNewsLine
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
 TkwEnNewsLineDateList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenNewsLine.DateList }
  private
   function DateList(const aCtx: TtfwContext;
    aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
    {* ���������� ����� ������� .TenNewsLine.DateList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnNewsLineDateList

 Tkw_Form_NewsLine = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� NewsLine
----
*������ �������������*:
[code]�����::NewsLine TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_NewsLine

 Tkw_NewsLine_Control_DateList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DateList
----
*������ �������������*:
[code]�������::DateList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewsLine_Control_DateList

 Tkw_NewsLine_Control_DateList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DateList
----
*������ �������������*:
[code]�������::DateList:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewsLine_Control_DateList_Push

function TkwEnNewsLineDateList.DateList(const aCtx: TtfwContext;
 aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
 {* ���������� ����� ������� .TenNewsLine.DateList }
begin
 Result := aenNewsLine.DateList;
end;//TkwEnNewsLineDateList.DateList

class function TkwEnNewsLineDateList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenNewsLine.DateList';
end;//TkwEnNewsLineDateList.GetWordNameForRegister

function TkwEnNewsLineDateList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewForNewsLine);
end;//TkwEnNewsLineDateList.GetResultTypeInfo

function TkwEnNewsLineDateList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNewsLineDateList.GetAllParamsCount

function TkwEnNewsLineDateList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenNewsLine)]);
end;//TkwEnNewsLineDateList.ParamsTypes

procedure TkwEnNewsLineDateList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DateList', aCtx);
end;//TkwEnNewsLineDateList.SetValuePrim

procedure TkwEnNewsLineDateList.DoDoIt(const aCtx: TtfwContext);
var l_aenNewsLine: TenNewsLine;
begin
 try
  l_aenNewsLine := TenNewsLine(aCtx.rEngine.PopObjAs(TenNewsLine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenNewsLine: TenNewsLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DateList(aCtx, l_aenNewsLine));
end;//TkwEnNewsLineDateList.DoDoIt

function Tkw_Form_NewsLine.GetString: AnsiString;
begin
 Result := 'enNewsLine';
end;//Tkw_Form_NewsLine.GetString

class procedure Tkw_Form_NewsLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenNewsLine);
end;//Tkw_Form_NewsLine.RegisterInEngine

class function Tkw_Form_NewsLine.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::NewsLine';
end;//Tkw_Form_NewsLine.GetWordNameForRegister

function Tkw_NewsLine_Control_DateList.GetString: AnsiString;
begin
 Result := 'DateList';
end;//Tkw_NewsLine_Control_DateList.GetString

class procedure Tkw_NewsLine_Control_DateList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewForNewsLine);
end;//Tkw_NewsLine_Control_DateList.RegisterInEngine

class function Tkw_NewsLine_Control_DateList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DateList';
end;//Tkw_NewsLine_Control_DateList.GetWordNameForRegister

procedure Tkw_NewsLine_Control_DateList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DateList');
 inherited;
end;//Tkw_NewsLine_Control_DateList_Push.DoDoIt

class function Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DateList:push';
end;//Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister

initialization
 TkwEnNewsLineDateList.RegisterInEngine;
 {* ����������� enNewsLine_DateList }
 Tkw_Form_NewsLine.RegisterInEngine;
 {* ����������� Tkw_Form_NewsLine }
 Tkw_NewsLine_Control_DateList.RegisterInEngine;
 {* ����������� Tkw_NewsLine_Control_DateList }
 Tkw_NewsLine_Control_DateList_Push.RegisterInEngine;
 {* ����������� Tkw_NewsLine_Control_DateList_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenNewsLine));
 {* ����������� ���� TenNewsLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewForNewsLine));
 {* ����������� ���� TnscTreeViewForNewsLine }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
