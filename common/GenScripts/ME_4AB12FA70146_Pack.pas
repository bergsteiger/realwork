unit PictureInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PictureInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PictureInfoKeywordsPack" MUID: (4AB12FA70146_Pack)

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
 , PictureInfo_Form
 , tfwPropertyLike
 , eeMemoWithEditOperations
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
 TkwEnPictureInfoInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PictureInfo.Info }
  private
   function Info(const aCtx: TtfwContext;
    aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
    {* ���������� ����� ������� .Ten_PictureInfo.Info }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnPictureInfoInfo

 Tkw_Form_PictureInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PictureInfo
----
*������ �������������*:
[code]�����::PictureInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PictureInfo

 Tkw_PictureInfo_Control_Info = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Info
----
*������ �������������*:
[code]�������::Info TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PictureInfo_Control_Info

 Tkw_PictureInfo_Control_Info_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Info
----
*������ �������������*:
[code]�������::Info:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PictureInfo_Control_Info_Push

function TkwEnPictureInfoInfo.Info(const aCtx: TtfwContext;
 aen_PictureInfo: Ten_PictureInfo): TeeMemoWithEditOperations;
 {* ���������� ����� ������� .Ten_PictureInfo.Info }
begin
 Result := aen_PictureInfo.Info;
end;//TkwEnPictureInfoInfo.Info

class function TkwEnPictureInfoInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PictureInfo.Info';
end;//TkwEnPictureInfoInfo.GetWordNameForRegister

function TkwEnPictureInfoInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnPictureInfoInfo.GetResultTypeInfo

function TkwEnPictureInfoInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPictureInfoInfo.GetAllParamsCount

function TkwEnPictureInfoInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PictureInfo)]);
end;//TkwEnPictureInfoInfo.ParamsTypes

procedure TkwEnPictureInfoInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Info', aCtx);
end;//TkwEnPictureInfoInfo.SetValuePrim

procedure TkwEnPictureInfoInfo.DoDoIt(const aCtx: TtfwContext);
var l_aen_PictureInfo: Ten_PictureInfo;
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
 aCtx.rEngine.PushObj(Info(aCtx, l_aen_PictureInfo));
end;//TkwEnPictureInfoInfo.DoDoIt

function Tkw_Form_PictureInfo.GetString: AnsiString;
begin
 Result := 'en_PictureInfo';
end;//Tkw_Form_PictureInfo.GetString

class procedure Tkw_Form_PictureInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_PictureInfo);
end;//Tkw_Form_PictureInfo.RegisterInEngine

class function Tkw_Form_PictureInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PictureInfo';
end;//Tkw_Form_PictureInfo.GetWordNameForRegister

function Tkw_PictureInfo_Control_Info.GetString: AnsiString;
begin
 Result := 'Info';
end;//Tkw_PictureInfo_Control_Info.GetString

class procedure Tkw_PictureInfo_Control_Info.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_PictureInfo_Control_Info.RegisterInEngine

class function Tkw_PictureInfo_Control_Info.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Info';
end;//Tkw_PictureInfo_Control_Info.GetWordNameForRegister

procedure Tkw_PictureInfo_Control_Info_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Info');
 inherited;
end;//Tkw_PictureInfo_Control_Info_Push.DoDoIt

class function Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Info:push';
end;//Tkw_PictureInfo_Control_Info_Push.GetWordNameForRegister

initialization
 TkwEnPictureInfoInfo.RegisterInEngine;
 {* ����������� en_PictureInfo_Info }
 Tkw_Form_PictureInfo.RegisterInEngine;
 {* ����������� Tkw_Form_PictureInfo }
 Tkw_PictureInfo_Control_Info.RegisterInEngine;
 {* ����������� Tkw_PictureInfo_Control_Info }
 Tkw_PictureInfo_Control_Info_Push.RegisterInEngine;
 {* ����������� Tkw_PictureInfo_Control_Info_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PictureInfo));
 {* ����������� ���� Ten_PictureInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* ����������� ���� TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
