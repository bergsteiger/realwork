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
//#UC START# *4DDFD2EA0116_75116EAE1983_var*
//#UC END# *4DDFD2EA0116_75116EAE1983_var*
begin
//#UC START# *4DDFD2EA0116_75116EAE1983_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_75116EAE1983_impl*
end;//Tkw_Form_GroupProperty.GetString

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CE2ACDC15DE5_var*
//#UC END# *4DDFD2EA0116_CE2ACDC15DE5_var*
begin
//#UC START# *4DDFD2EA0116_CE2ACDC15DE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CE2ACDC15DE5_impl*
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
//#UC START# *52A086150180_CE2ACDC15DE5_var*
//#UC END# *52A086150180_CE2ACDC15DE5_var*
begin
//#UC START# *52A086150180_CE2ACDC15DE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CE2ACDC15DE5_impl*
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
//#UC START# *4DDFD2EA0116_A59F7FE083FA_var*
//#UC END# *4DDFD2EA0116_A59F7FE083FA_var*
begin
//#UC START# *4DDFD2EA0116_A59F7FE083FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A59F7FE083FA_impl*
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
//#UC START# *52A086150180_A59F7FE083FA_var*
//#UC END# *52A086150180_A59F7FE083FA_var*
begin
//#UC START# *52A086150180_A59F7FE083FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A59F7FE083FA_impl*
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
//#UC START# *B4B1217E98F2_4F99EBEBC67D_var*
//#UC END# *B4B1217E98F2_4F99EBEBC67D_var*
begin
//#UC START# *B4B1217E98F2_4F99EBEBC67D_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4B1217E98F2_4F99EBEBC67D_impl*
end;//TkwEfGroupPropertyEdName.edName

procedure TkwEfGroupPropertyEdName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F99EBEBC67D_var*
//#UC END# *4DAEEDE10285_4F99EBEBC67D_var*
begin
//#UC START# *4DAEEDE10285_4F99EBEBC67D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4F99EBEBC67D_impl*
end;//TkwEfGroupPropertyEdName.DoDoIt

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4F99EBEBC67D_var*
//#UC END# *52D00B00031A_4F99EBEBC67D_var*
begin
//#UC START# *52D00B00031A_4F99EBEBC67D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4F99EBEBC67D_impl*
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
 Result := OpenTypesToTypes([]);
end;//TkwEfGroupPropertyEdName.ParamsTypes

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TvtLabel;
 {* ���������� ����� ������� .TefGroupProperty.Label1 }
//#UC START# *F29CEAD31E48_8DC84936A887_var*
//#UC END# *F29CEAD31E48_8DC84936A887_var*
begin
//#UC START# *F29CEAD31E48_8DC84936A887_impl*
 !!! Needs to be implemented !!!
//#UC END# *F29CEAD31E48_8DC84936A887_impl*
end;//TkwEfGroupPropertyLabel1.Label1

procedure TkwEfGroupPropertyLabel1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8DC84936A887_var*
//#UC END# *4DAEEDE10285_8DC84936A887_var*
begin
//#UC START# *4DAEEDE10285_8DC84936A887_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8DC84936A887_impl*
end;//TkwEfGroupPropertyLabel1.DoDoIt

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8DC84936A887_var*
//#UC END# *52D00B00031A_8DC84936A887_var*
begin
//#UC START# *52D00B00031A_8DC84936A887_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8DC84936A887_impl*
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
 Result := OpenTypesToTypes([]);
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
