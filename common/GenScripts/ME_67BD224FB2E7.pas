unit ListInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ListInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ListInfo_Form
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
 Tkw_Form_ListInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ListInfo
----
*������ �������������*:
[code]
'aControl' �����::ListInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ListInfo

 Tkw_ListInfo_Control_ListInfoViewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ListInfoViewer
----
*������ �������������*:
[code]
�������::ListInfoViewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer

 Tkw_ListInfo_Control_ListInfoViewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ListInfoViewer
----
*������ �������������*:
[code]
�������::ListInfoViewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ListInfo_Control_ListInfoViewer_Push

 Tkw_ListInfo_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ListInfo_Component_TextSource

 TkwEfListInfoListInfoViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefListInfo.ListInfoViewer
[panel]������� ListInfoViewer ����� TefListInfo[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aefListInfo .TefListInfo.ListInfoViewer >>> l_TnscEditor
[code]  }
  private
   function ListInfoViewer(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscEditor;
    {* ���������� ����� ������� .TefListInfo.ListInfoViewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListInfoListInfoViewer

 TkwEfListInfoTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefListInfo.TextSource
[panel]������� TextSource ����� TefListInfo[panel]
*��� ����������:* TnscTextSource
*������:*
[code]
OBJECT VAR l_TnscTextSource
 aefListInfo .TefListInfo.TextSource >>> l_TnscTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aefListInfo: TefListInfo): TnscTextSource;
    {* ���������� ����� ������� .TefListInfo.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListInfoTextSource

class function Tkw_Form_ListInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ListInfo';
end;//Tkw_Form_ListInfo.GetWordNameForRegister

function Tkw_Form_ListInfo.GetString: AnsiString;
begin
 Result := 'efListInfo';
end;//Tkw_Form_ListInfo.GetString

class function Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetWordNameForRegister

function Tkw_ListInfo_Control_ListInfoViewer.GetString: AnsiString;
begin
 Result := 'ListInfoViewer';
end;//Tkw_ListInfo_Control_ListInfoViewer.GetString

class procedure Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine

procedure Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListInfoViewer');
 inherited;
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.DoDoIt

class function Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ListInfoViewer:push';
end;//Tkw_ListInfo_Control_ListInfoViewer_Push.GetWordNameForRegister

class function Tkw_ListInfo_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetWordNameForRegister

function Tkw_ListInfo_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_ListInfo_Component_TextSource.GetString

class procedure Tkw_ListInfo_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_ListInfo_Component_TextSource.RegisterInEngine

function TkwEfListInfoListInfoViewer.ListInfoViewer(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscEditor;
 {* ���������� ����� ������� .TefListInfo.ListInfoViewer }
begin
 Result := aefListInfo.ListInfoViewer;
end;//TkwEfListInfoListInfoViewer.ListInfoViewer

procedure TkwEfListInfoListInfoViewer.DoDoIt(const aCtx: TtfwContext);
var l_aefListInfo: TefListInfo;
begin
 try
  l_aefListInfo := TefListInfo(aCtx.rEngine.PopObjAs(TefListInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefListInfo: TefListInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListInfoViewer(aCtx, l_aefListInfo));
end;//TkwEfListInfoListInfoViewer.DoDoIt

class function TkwEfListInfoListInfoViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.ListInfoViewer';
end;//TkwEfListInfoListInfoViewer.GetWordNameForRegister

procedure TkwEfListInfoListInfoViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ListInfoViewer', aCtx);
end;//TkwEfListInfoListInfoViewer.SetValuePrim

function TkwEfListInfoListInfoViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwEfListInfoListInfoViewer.GetResultTypeInfo

function TkwEfListInfoListInfoViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListInfoListInfoViewer.GetAllParamsCount

function TkwEfListInfoListInfoViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoListInfoViewer.ParamsTypes

function TkwEfListInfoTextSource.TextSource(const aCtx: TtfwContext;
 aefListInfo: TefListInfo): TnscTextSource;
 {* ���������� ����� ������� .TefListInfo.TextSource }
begin
 Result := aefListInfo.TextSource;
end;//TkwEfListInfoTextSource.TextSource

procedure TkwEfListInfoTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aefListInfo: TefListInfo;
begin
 try
  l_aefListInfo := TefListInfo(aCtx.rEngine.PopObjAs(TefListInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefListInfo: TefListInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aefListInfo));
end;//TkwEfListInfoTextSource.DoDoIt

class function TkwEfListInfoTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefListInfo.TextSource';
end;//TkwEfListInfoTextSource.GetWordNameForRegister

procedure TkwEfListInfoTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwEfListInfoTextSource.SetValuePrim

function TkwEfListInfoTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTextSource);
end;//TkwEfListInfoTextSource.GetResultTypeInfo

function TkwEfListInfoTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListInfoTextSource.GetAllParamsCount

function TkwEfListInfoTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefListInfo)]);
end;//TkwEfListInfoTextSource.ParamsTypes

initialization
 Tkw_Form_ListInfo.RegisterInEngine;
 {* ����������� Tkw_Form_ListInfo }
 Tkw_ListInfo_Control_ListInfoViewer.RegisterInEngine;
 {* ����������� Tkw_ListInfo_Control_ListInfoViewer }
 Tkw_ListInfo_Control_ListInfoViewer_Push.RegisterInEngine;
 {* ����������� Tkw_ListInfo_Control_ListInfoViewer_Push }
 Tkw_ListInfo_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_ListInfo_Component_TextSource }
 TkwEfListInfoListInfoViewer.RegisterInEngine;
 {* ����������� efListInfo_ListInfoViewer }
 TkwEfListInfoTextSource.RegisterInEngine;
 {* ����������� efListInfo_TextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefListInfo));
 {* ����������� ���� ListInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* ����������� ���� TnscTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
