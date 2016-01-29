unit PictureInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/PictureInfoKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::PictureInfoKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� PictureInfo
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
  PictureInfo_Form,
  eeMemoWithEditOperations,
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
  Tkw_Form_PictureInfo = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� PictureInfo
----
*������ �������������*:
[code]
'aControl' �����::PictureInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_PictureInfo

// start class Tkw_Form_PictureInfo

class function Tkw_Form_PictureInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::PictureInfo';
end;//Tkw_Form_PictureInfo.GetWordNameForRegister

function Tkw_Form_PictureInfo.GetString: AnsiString;
 {-}
begin
 Result := 'en_PictureInfo';
end;//Tkw_Form_PictureInfo.GetString

type
  Tkw_PictureInfo_Control_Info = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Info
----
*������ �������������*:
[code]
�������::Info TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PictureInfo_Control_Info

// start class Tkw_PictureInfo_Control_Info

class function Tkw_PictureInfo_Control_Info.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Info';
end;//Tkw_PictureInfo_Control_Info.GetWordNameForRegister

function Tkw_PictureInfo_Control_Info.GetString: AnsiString;
 {-}
begin
 Result := 'Info';
end;//Tkw_PictureInfo_Control_Info.GetString

class procedure Tkw_PictureInfo_Control_Info.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_PictureInfo_Control_Info.RegisterInEngine

type
  Tkw_PictureInfo_Control_Info_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Info
----
*������ �������������*:
[code]
�������::Info:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PictureInfo_Control_Info_Push

// start class Tkw_PictureInfo_Control_Info_Push

procedure Tkw_PictureInfo_Control_Info_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Info');
 inherited;
end;//Tkw_PictureInfo_Control_Info_Push.DoDoIt

class function Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Info:push';
end;//Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister

type
  TkwEnPictureInfoInfo = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_PictureInfo.Info
[panel]������� Info ����� Ten_PictureInfo[panel]
*��� ����������:* TeeMemoWithEditOperations
*������:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aen_PictureInfo .Ten_PictureInfo.Info >>> l_TeeMemoWithEditOperations
[code]  }
  private
  // private methods
   function Info(const aCtx: TtfwContext;
     aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
     {* ���������� ����� ������� .Ten_PictureInfo.Info }
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
  end;//TkwEnPictureInfoInfo

// start class TkwEnPictureInfoInfo

function TkwEnPictureInfoInfo.Info(const aCtx: TtfwContext;
  aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
 {-}
begin
 Result := aen_PictureInfo.Info;
end;//TkwEnPictureInfoInfo.Info

procedure TkwEnPictureInfoInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PictureInfo : Ten_PictureInfo;
begin
 try
  l_aen_PictureInfo := Ten_PictureInfo(aCtx.rEngine.PopObjAs(Ten_PictureInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PictureInfo: Ten_PictureInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Info(aCtx, l_aen_PictureInfo)));
end;//TkwEnPictureInfoInfo.DoDoIt

class function TkwEnPictureInfoInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PictureInfo.Info';
end;//TkwEnPictureInfoInfo.GetWordNameForRegister

procedure TkwEnPictureInfoInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Info', aCtx);
end;//TkwEnPictureInfoInfo.SetValuePrim

function TkwEnPictureInfoInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnPictureInfoInfo.GetResultTypeInfo

function TkwEnPictureInfoInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPictureInfoInfo.GetAllParamsCount

function TkwEnPictureInfoInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PictureInfo)]);
end;//TkwEnPictureInfoInfo.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_PictureInfo
 Tkw_Form_PictureInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_PictureInfo_Control_Info
 Tkw_PictureInfo_Control_Info.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_PictureInfo_Control_Info_Push
 Tkw_PictureInfo_Control_Info_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_PictureInfo_Info
 TkwEnPictureInfoInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� PictureInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PictureInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TeeMemoWithEditOperations
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.