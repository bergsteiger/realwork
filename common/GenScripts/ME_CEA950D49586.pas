unit SaveLoadKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SaveLoad }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\SaveLoadKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CommonSearch_Module
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_SaveLoad = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� SaveLoad
----
*������ �������������*:
[code]
'aControl' �����::SaveLoad TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SaveLoad

 Tkw_SaveLoad_Control_pnHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SaveLoad_Control_pnHeader

 Tkw_SaveLoad_Control_pnHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pnHeader_Push

 Tkw_SaveLoad_Control_lbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SaveLoad_Control_lbHeader

 Tkw_SaveLoad_Control_lbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_lbHeader_Push

 Tkw_SaveLoad_Control_pbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SaveLoad_Control_pbHeader

 Tkw_SaveLoad_Control_pbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pbHeader_Push

 Tkw_SaveLoad_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SaveLoad_Control_ParentZone

 Tkw_SaveLoad_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_ParentZone_Push

 TkwCfSaveLoadPnHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfSaveLoad.pnHeader
[panel]������� pnHeader ����� TcfSaveLoad[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.pnHeader >>> l_TvtPanel
[code]  }
  private
   function pnHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtPanel;
    {* ���������� ����� ������� .TcfSaveLoad.pnHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadPnHeader

 TkwCfSaveLoadLbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfSaveLoad.lbHeader
[panel]������� lbHeader ����� TcfSaveLoad[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 acfSaveLoad .TcfSaveLoad.lbHeader >>> l_TvtLabel
[code]  }
  private
   function lbHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtLabel;
    {* ���������� ����� ������� .TcfSaveLoad.lbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadLbHeader

 TkwCfSaveLoadPbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfSaveLoad.pbHeader
[panel]������� pbHeader ����� TcfSaveLoad[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 acfSaveLoad .TcfSaveLoad.pbHeader >>> l_TPaintBox
[code]  }
  private
   function pbHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TPaintBox;
    {* ���������� ����� ������� .TcfSaveLoad.pbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadPbHeader

 TkwCfSaveLoadParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfSaveLoad.ParentZone
[panel]������� ParentZone ����� TcfSaveLoad[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtPanel;
    {* ���������� ����� ������� .TcfSaveLoad.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadParentZone

class function Tkw_Form_SaveLoad.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SaveLoad';
end;//Tkw_Form_SaveLoad.GetWordNameForRegister

function Tkw_Form_SaveLoad.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_577D804DEED5_var*
//#UC END# *4DDFD2EA0116_577D804DEED5_var*
begin
//#UC START# *4DDFD2EA0116_577D804DEED5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_577D804DEED5_impl*
end;//Tkw_Form_SaveLoad.GetString

class function Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader';
end;//Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_pnHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EF00184E37A8_var*
//#UC END# *4DDFD2EA0116_EF00184E37A8_var*
begin
//#UC START# *4DDFD2EA0116_EF00184E37A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EF00184E37A8_impl*
end;//Tkw_SaveLoad_Control_pnHeader.GetString

class procedure Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
//#UC START# *52A086150180_EF00184E37A8_var*
//#UC END# *52A086150180_EF00184E37A8_var*
begin
//#UC START# *52A086150180_EF00184E37A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EF00184E37A8_impl*
end;//Tkw_SaveLoad_Control_pnHeader.RegisterInEngine

procedure Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75AC194BB9D8_var*
//#UC END# *4DAEEDE10285_75AC194BB9D8_var*
begin
//#UC START# *4DAEEDE10285_75AC194BB9D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_75AC194BB9D8_impl*
end;//Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader:push';
end;//Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister

class function Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader';
end;//Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_lbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0596130B6DD0_var*
//#UC END# *4DDFD2EA0116_0596130B6DD0_var*
begin
//#UC START# *4DDFD2EA0116_0596130B6DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0596130B6DD0_impl*
end;//Tkw_SaveLoad_Control_lbHeader.GetString

class procedure Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
//#UC START# *52A086150180_0596130B6DD0_var*
//#UC END# *52A086150180_0596130B6DD0_var*
begin
//#UC START# *52A086150180_0596130B6DD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0596130B6DD0_impl*
end;//Tkw_SaveLoad_Control_lbHeader.RegisterInEngine

procedure Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D39F699314B6_var*
//#UC END# *4DAEEDE10285_D39F699314B6_var*
begin
//#UC START# *4DAEEDE10285_D39F699314B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D39F699314B6_impl*
end;//Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader:push';
end;//Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister

class function Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader';
end;//Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_pbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5CC753C5EEDF_var*
//#UC END# *4DDFD2EA0116_5CC753C5EEDF_var*
begin
//#UC START# *4DDFD2EA0116_5CC753C5EEDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5CC753C5EEDF_impl*
end;//Tkw_SaveLoad_Control_pbHeader.GetString

class procedure Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
//#UC START# *52A086150180_5CC753C5EEDF_var*
//#UC END# *52A086150180_5CC753C5EEDF_var*
begin
//#UC START# *52A086150180_5CC753C5EEDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5CC753C5EEDF_impl*
end;//Tkw_SaveLoad_Control_pbHeader.RegisterInEngine

procedure Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A1445EADEB6F_var*
//#UC END# *4DAEEDE10285_A1445EADEB6F_var*
begin
//#UC START# *4DAEEDE10285_A1445EADEB6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A1445EADEB6F_impl*
end;//Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader:push';
end;//Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister

class function Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister

function Tkw_SaveLoad_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5929D0B42CAB_var*
//#UC END# *4DDFD2EA0116_5929D0B42CAB_var*
begin
//#UC START# *4DDFD2EA0116_5929D0B42CAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5929D0B42CAB_impl*
end;//Tkw_SaveLoad_Control_ParentZone.GetString

class procedure Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_5929D0B42CAB_var*
//#UC END# *52A086150180_5929D0B42CAB_var*
begin
//#UC START# *52A086150180_5929D0B42CAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5929D0B42CAB_impl*
end;//Tkw_SaveLoad_Control_ParentZone.RegisterInEngine

procedure Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_158EA2C9A2C9_var*
//#UC END# *4DAEEDE10285_158EA2C9A2C9_var*
begin
//#UC START# *4DAEEDE10285_158EA2C9A2C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_158EA2C9A2C9_impl*
end;//Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt

class function Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister

function TkwCfSaveLoadPnHeader.pnHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtPanel;
 {* ���������� ����� ������� .TcfSaveLoad.pnHeader }
//#UC START# *59D7A2072AB7_2440EB34C9D0_var*
//#UC END# *59D7A2072AB7_2440EB34C9D0_var*
begin
//#UC START# *59D7A2072AB7_2440EB34C9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *59D7A2072AB7_2440EB34C9D0_impl*
end;//TkwCfSaveLoadPnHeader.pnHeader

procedure TkwCfSaveLoadPnHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2440EB34C9D0_var*
//#UC END# *4DAEEDE10285_2440EB34C9D0_var*
begin
//#UC START# *4DAEEDE10285_2440EB34C9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2440EB34C9D0_impl*
end;//TkwCfSaveLoadPnHeader.DoDoIt

class function TkwCfSaveLoadPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.pnHeader';
end;//TkwCfSaveLoadPnHeader.GetWordNameForRegister

procedure TkwCfSaveLoadPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2440EB34C9D0_var*
//#UC END# *52D00B00031A_2440EB34C9D0_var*
begin
//#UC START# *52D00B00031A_2440EB34C9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2440EB34C9D0_impl*
end;//TkwCfSaveLoadPnHeader.SetValuePrim

function TkwCfSaveLoadPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadPnHeader.GetResultTypeInfo

function TkwCfSaveLoadPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadPnHeader.GetAllParamsCount

function TkwCfSaveLoadPnHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfSaveLoadPnHeader.ParamsTypes

function TkwCfSaveLoadLbHeader.lbHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtLabel;
 {* ���������� ����� ������� .TcfSaveLoad.lbHeader }
//#UC START# *9F45CCDA8270_E675708F6BD5_var*
//#UC END# *9F45CCDA8270_E675708F6BD5_var*
begin
//#UC START# *9F45CCDA8270_E675708F6BD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *9F45CCDA8270_E675708F6BD5_impl*
end;//TkwCfSaveLoadLbHeader.lbHeader

procedure TkwCfSaveLoadLbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E675708F6BD5_var*
//#UC END# *4DAEEDE10285_E675708F6BD5_var*
begin
//#UC START# *4DAEEDE10285_E675708F6BD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E675708F6BD5_impl*
end;//TkwCfSaveLoadLbHeader.DoDoIt

class function TkwCfSaveLoadLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.lbHeader';
end;//TkwCfSaveLoadLbHeader.GetWordNameForRegister

procedure TkwCfSaveLoadLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E675708F6BD5_var*
//#UC END# *52D00B00031A_E675708F6BD5_var*
begin
//#UC START# *52D00B00031A_E675708F6BD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E675708F6BD5_impl*
end;//TkwCfSaveLoadLbHeader.SetValuePrim

function TkwCfSaveLoadLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCfSaveLoadLbHeader.GetResultTypeInfo

function TkwCfSaveLoadLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadLbHeader.GetAllParamsCount

function TkwCfSaveLoadLbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfSaveLoadLbHeader.ParamsTypes

function TkwCfSaveLoadPbHeader.pbHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TPaintBox;
 {* ���������� ����� ������� .TcfSaveLoad.pbHeader }
//#UC START# *083E1C6BCE60_26C9E1BE48F1_var*
//#UC END# *083E1C6BCE60_26C9E1BE48F1_var*
begin
//#UC START# *083E1C6BCE60_26C9E1BE48F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *083E1C6BCE60_26C9E1BE48F1_impl*
end;//TkwCfSaveLoadPbHeader.pbHeader

procedure TkwCfSaveLoadPbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_26C9E1BE48F1_var*
//#UC END# *4DAEEDE10285_26C9E1BE48F1_var*
begin
//#UC START# *4DAEEDE10285_26C9E1BE48F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_26C9E1BE48F1_impl*
end;//TkwCfSaveLoadPbHeader.DoDoIt

class function TkwCfSaveLoadPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.pbHeader';
end;//TkwCfSaveLoadPbHeader.GetWordNameForRegister

procedure TkwCfSaveLoadPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_26C9E1BE48F1_var*
//#UC END# *52D00B00031A_26C9E1BE48F1_var*
begin
//#UC START# *52D00B00031A_26C9E1BE48F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_26C9E1BE48F1_impl*
end;//TkwCfSaveLoadPbHeader.SetValuePrim

function TkwCfSaveLoadPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwCfSaveLoadPbHeader.GetResultTypeInfo

function TkwCfSaveLoadPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadPbHeader.GetAllParamsCount

function TkwCfSaveLoadPbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfSaveLoadPbHeader.ParamsTypes

function TkwCfSaveLoadParentZone.ParentZone(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtPanel;
 {* ���������� ����� ������� .TcfSaveLoad.ParentZone }
//#UC START# *EF9CFEE320EB_27482DAD1D6E_var*
//#UC END# *EF9CFEE320EB_27482DAD1D6E_var*
begin
//#UC START# *EF9CFEE320EB_27482DAD1D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *EF9CFEE320EB_27482DAD1D6E_impl*
end;//TkwCfSaveLoadParentZone.ParentZone

procedure TkwCfSaveLoadParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_27482DAD1D6E_var*
//#UC END# *4DAEEDE10285_27482DAD1D6E_var*
begin
//#UC START# *4DAEEDE10285_27482DAD1D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_27482DAD1D6E_impl*
end;//TkwCfSaveLoadParentZone.DoDoIt

class function TkwCfSaveLoadParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.ParentZone';
end;//TkwCfSaveLoadParentZone.GetWordNameForRegister

procedure TkwCfSaveLoadParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_27482DAD1D6E_var*
//#UC END# *52D00B00031A_27482DAD1D6E_var*
begin
//#UC START# *52D00B00031A_27482DAD1D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_27482DAD1D6E_impl*
end;//TkwCfSaveLoadParentZone.SetValuePrim

function TkwCfSaveLoadParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadParentZone.GetResultTypeInfo

function TkwCfSaveLoadParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadParentZone.GetAllParamsCount

function TkwCfSaveLoadParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfSaveLoadParentZone.ParamsTypes

initialization
 Tkw_Form_SaveLoad.RegisterInEngine;
 {* ����������� Tkw_Form_SaveLoad }
 Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_pnHeader }
 Tkw_SaveLoad_Control_pnHeader_Push.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_pnHeader_Push }
 Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_lbHeader }
 Tkw_SaveLoad_Control_lbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_lbHeader_Push }
 Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_pbHeader }
 Tkw_SaveLoad_Control_pbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_pbHeader_Push }
 Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_ParentZone }
 Tkw_SaveLoad_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_SaveLoad_Control_ParentZone_Push }
 TkwCfSaveLoadPnHeader.RegisterInEngine;
 {* ����������� cfSaveLoad_pnHeader }
 TkwCfSaveLoadLbHeader.RegisterInEngine;
 {* ����������� cfSaveLoad_lbHeader }
 TkwCfSaveLoadPbHeader.RegisterInEngine;
 {* ����������� cfSaveLoad_pbHeader }
 TkwCfSaveLoadParentZone.RegisterInEngine;
 {* ����������� cfSaveLoad_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfSaveLoad));
 {* ����������� ���� SaveLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
