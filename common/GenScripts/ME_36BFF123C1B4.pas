unit GroupPropertyKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� GroupProperty }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\GroupPropertyKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtLabel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_GroupProperty = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� GroupProperty
----
*������ �������������*:
[code]
'aControl' �����::GroupProperty TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_GroupProperty

 Tkw_GroupProperty_Control_edName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edName
----
*������ �������������*:
[code]
�������::edName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_GroupProperty_Control_edName

 Tkw_GroupProperty_Control_edName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edName
----
*������ �������������*:
[code]
�������::edName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_edName_Push

 Tkw_GroupProperty_Control_Label1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Label1
----
*������ �������������*:
[code]
�������::Label1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_GroupProperty_Control_Label1

 Tkw_GroupProperty_Control_Label1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Label1
----
*������ �������������*:
[code]
�������::Label1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_Label1_Push

 TkwEfGroupPropertyEdName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefGroupProperty.edName
[panel]������� edName ����� TefGroupProperty[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aefGroupProperty .TefGroupProperty.edName >>> l_TnscEdit
[code]  }
  private
   function edName(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TnscEdit;
    {* ���������� ����� ������� .TefGroupProperty.edName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfGroupPropertyEdName

 TkwEfGroupPropertyLabel1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefGroupProperty.Label1
[panel]������� Label1 ����� TefGroupProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefGroupProperty .TefGroupProperty.Label1 >>> l_TvtLabel
[code]  }
  private
   function Label1(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TvtLabel;
    {* ���������� ����� ������� .TefGroupProperty.Label1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfGroupPropertyLabel1

class function Tkw_Form_GroupProperty.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::GroupProperty';
end;//Tkw_Form_GroupProperty.GetWordNameForRegister

function Tkw_Form_GroupProperty.GetString: AnsiString;
begin
 Result := 'efGroupProperty';
end;//Tkw_Form_GroupProperty.GetString

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
begin
 Result := 'edName';
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_GroupProperty_Control_edName.RegisterInEngine

procedure Tkw_GroupProperty_Control_edName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB2BEA77BADC_var*
//#UC END# *4DAEEDE10285_CB2BEA77BADC_var*
begin
//#UC START# *4DAEEDE10285_CB2BEA77BADC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB2BEA77BADC_impl*
end;//Tkw_GroupProperty_Control_edName_Push.DoDoIt

class function Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edName:push';
end;//Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister

class function Tkw_GroupProperty_Control_Label1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1';
end;//Tkw_GroupProperty_Control_Label1.GetWordNameForRegister

function Tkw_GroupProperty_Control_Label1.GetString: AnsiString;
begin
 Result := 'Label1';
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_GroupProperty_Control_Label1.RegisterInEngine

procedure Tkw_GroupProperty_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FFA6B00B1564_var*
//#UC END# *4DAEEDE10285_FFA6B00B1564_var*
begin
//#UC START# *4DAEEDE10285_FFA6B00B1564_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FFA6B00B1564_impl*
end;//Tkw_GroupProperty_Control_Label1_Push.DoDoIt

class function Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1:push';
end;//Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister

function TkwEfGroupPropertyEdName.edName(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TnscEdit;
 {* ���������� ����� ������� .TefGroupProperty.edName }
begin
 Result := aefGroupProperty.edName;
end;//TkwEfGroupPropertyEdName.edName

procedure TkwEfGroupPropertyEdName.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupProperty: TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edName(aCtx, l_aefGroupProperty));
end;//TkwEfGroupPropertyEdName.DoDoIt

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edName', aCtx);
end;//TkwEfGroupPropertyEdName.SetValuePrim

function TkwEfGroupPropertyEdName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfGroupPropertyEdName.GetResultTypeInfo

function TkwEfGroupPropertyEdName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupPropertyEdName.GetAllParamsCount

function TkwEfGroupPropertyEdName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyEdName.ParamsTypes

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TvtLabel;
 {* ���������� ����� ������� .TefGroupProperty.Label1 }
begin
 Result := aefGroupProperty.Label1;
end;//TkwEfGroupPropertyLabel1.Label1

procedure TkwEfGroupPropertyLabel1.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupProperty: TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Label1(aCtx, l_aefGroupProperty));
end;//TkwEfGroupPropertyLabel1.DoDoIt

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Label1', aCtx);
end;//TkwEfGroupPropertyLabel1.SetValuePrim

function TkwEfGroupPropertyLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfGroupPropertyLabel1.GetResultTypeInfo

function TkwEfGroupPropertyLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupPropertyLabel1.GetAllParamsCount

function TkwEfGroupPropertyLabel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyLabel1.ParamsTypes

initialization
 Tkw_Form_GroupProperty.RegisterInEngine;
 {* ����������� Tkw_Form_GroupProperty }
 Tkw_GroupProperty_Control_edName.RegisterInEngine;
 {* ����������� Tkw_GroupProperty_Control_edName }
 Tkw_GroupProperty_Control_edName_Push.RegisterInEngine;
 {* ����������� Tkw_GroupProperty_Control_edName_Push }
 Tkw_GroupProperty_Control_Label1.RegisterInEngine;
 {* ����������� Tkw_GroupProperty_Control_Label1 }
 Tkw_GroupProperty_Control_Label1_Push.RegisterInEngine;
 {* ����������� Tkw_GroupProperty_Control_Label1_Push }
 TkwEfGroupPropertyEdName.RegisterInEngine;
 {* ����������� efGroupProperty_edName }
 TkwEfGroupPropertyLabel1.RegisterInEngine;
 {* ����������� efGroupProperty_Label1 }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupProperty));
 {* ����������� ���� GroupProperty }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
