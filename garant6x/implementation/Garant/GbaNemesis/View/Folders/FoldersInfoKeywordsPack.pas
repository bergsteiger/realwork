unit FoldersInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersInfoKeywordsPack.pas"
// �����: 27.08.2009 20:37
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ����������::Folders::View::Folders::PrimFolders$UC::FoldersInfoKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� FoldersInfo
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  vtPanel,
  FoldersInfo_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_FoldersInfo = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� FoldersInfo
----
*������ �������������*:
[code]
'aControl' �����::FoldersInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_FoldersInfo

// start class Tkw_Form_FoldersInfo

class function Tkw_Form_FoldersInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::FoldersInfo';
end;//Tkw_Form_FoldersInfo.GetWordNameForRegister

function Tkw_Form_FoldersInfo.GetString: AnsiString;
 {-}
begin
 Result := 'cfFoldersInfo';
end;//Tkw_Form_FoldersInfo.GetString

type
  Tkw_FoldersInfo_Control_ChildZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersInfo_Control_ChildZone

// start class Tkw_FoldersInfo_Control_ChildZone

class function Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister

function Tkw_FoldersInfo_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetString

class procedure Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine

type
  Tkw_FoldersInfo_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersInfo_Control_ChildZone_Push

// start class Tkw_FoldersInfo_Control_ChildZone_Push

procedure Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt

class function Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone:push';
end;//Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister

type
  TkwCfFoldersInfoChildZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfFoldersInfo.ChildZone
[panel]������� ChildZone ����� TcfFoldersInfo[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfFoldersInfo .TcfFoldersInfo.ChildZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     acfFoldersInfo: TcfFoldersInfo): TvtPanel;
     {* ���������� ����� ������� .TcfFoldersInfo.ChildZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfFoldersInfoChildZone

// start class TkwCfFoldersInfoChildZone

function TkwCfFoldersInfoChildZone.ChildZone(const aCtx: TtfwContext;
  acfFoldersInfo: TcfFoldersInfo): TvtPanel;
 {-}
begin
 Result := acfFoldersInfo.ChildZone;
end;//TkwCfFoldersInfoChildZone.ChildZone

procedure TkwCfFoldersInfoChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfFoldersInfo : TcfFoldersInfo;
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
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_acfFoldersInfo)));
end;//TkwCfFoldersInfoChildZone.DoDoIt

class function TkwCfFoldersInfoChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfFoldersInfo.ChildZone';
end;//TkwCfFoldersInfoChildZone.GetWordNameForRegister

procedure TkwCfFoldersInfoChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwCfFoldersInfoChildZone.SetValuePrim

function TkwCfFoldersInfoChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersInfoChildZone.GetResultTypeInfo

function TkwCfFoldersInfoChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfFoldersInfoChildZone.GetAllParamsCount

function TkwCfFoldersInfoChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFoldersInfo)]);
end;//TkwCfFoldersInfoChildZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_FoldersInfo
 Tkw_Form_FoldersInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FoldersInfo_Control_ChildZone
 Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FoldersInfo_Control_ChildZone_Push
 Tkw_FoldersInfo_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� cfFoldersInfo_ChildZone
 TkwCfFoldersInfoChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� FoldersInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFoldersInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.