unit FoldersInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� FoldersInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "FoldersInfoKeywordsPack" MUID: (9910530E861F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , FoldersInfo_Form
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
 Tkw_Form_FoldersInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� FoldersInfo
----
*������ �������������*:
[code]
'aControl' �����::FoldersInfo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_FoldersInfo

 Tkw_FoldersInfo_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersInfo_Control_ChildZone

 Tkw_FoldersInfo_Control_ChildZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersInfo_Control_ChildZone_Push

 TkwCfFoldersInfoChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfFoldersInfo.ChildZone }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfFoldersInfo: TcfFoldersInfo): TvtPanel;
    {* ���������� ����� ������� .TcfFoldersInfo.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfFoldersInfoChildZone

function Tkw_Form_FoldersInfo.GetString: AnsiString;
begin
 Result := 'cfFoldersInfo';
end;//Tkw_Form_FoldersInfo.GetString

class function Tkw_Form_FoldersInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::FoldersInfo';
end;//Tkw_Form_FoldersInfo.GetWordNameForRegister

function Tkw_FoldersInfo_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetString

class procedure Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine

class function Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister

procedure Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt

class function Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister

function TkwCfFoldersInfoChildZone.ChildZone(const aCtx: TtfwContext;
 acfFoldersInfo: TcfFoldersInfo): TvtPanel;
 {* ���������� ����� ������� .TcfFoldersInfo.ChildZone }
begin
 Result := acfFoldersInfo.ChildZone;
end;//TkwCfFoldersInfoChildZone.ChildZone

procedure TkwCfFoldersInfoChildZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFoldersInfo: TcfFoldersInfo;
begin
 try
  l_acfFoldersInfo := TcfFoldersInfo(aCtx.rEngine.PopObjAs(TcfFoldersInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfFoldersInfo: TcfFoldersInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_acfFoldersInfo));
end;//TkwCfFoldersInfoChildZone.DoDoIt

class function TkwCfFoldersInfoChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFoldersInfo.ChildZone';
end;//TkwCfFoldersInfoChildZone.GetWordNameForRegister

function TkwCfFoldersInfoChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersInfoChildZone.GetResultTypeInfo

function TkwCfFoldersInfoChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersInfoChildZone.GetAllParamsCount

function TkwCfFoldersInfoChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFoldersInfo)]);
end;//TkwCfFoldersInfoChildZone.ParamsTypes

procedure TkwCfFoldersInfoChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwCfFoldersInfoChildZone.SetValuePrim

initialization
 Tkw_Form_FoldersInfo.RegisterInEngine;
 {* ����������� Tkw_Form_FoldersInfo }
 Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_FoldersInfo_Control_ChildZone }
 Tkw_FoldersInfo_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_FoldersInfo_Control_ChildZone_Push }
 TkwCfFoldersInfoChildZone.RegisterInEngine;
 {* ����������� cfFoldersInfo_ChildZone }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFoldersInfo));
 {* ����������� ���� TcfFoldersInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
