unit GroupPropertyKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� GroupProperty }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\GroupPropertyKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "GroupPropertyKeywordsPack" MUID: (4AA8E3E20024_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , GroupProperty_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA8E3E20024_Packimpl_uses*
 //#UC END# *4AA8E3E20024_Packimpl_uses*
;

type
 TkwEfGroupPropertyEdName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefGroupProperty.edName }
  private
   function edName(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TnscEdit;
    {* ���������� ����� ������� .TefGroupProperty.edName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupPropertyEdName

 TkwEfGroupPropertyLabel1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefGroupProperty.Label1 }
  private
   function Label1(const aCtx: TtfwContext;
    aefGroupProperty: TefGroupProperty): TvtLabel;
    {* ���������� ����� ������� .TefGroupProperty.Label1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupPropertyLabel1

 Tkw_Form_GroupProperty = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� GroupProperty
----
*������ �������������*:
[code]�����::GroupProperty TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_GroupProperty

 Tkw_GroupProperty_Control_edName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edName
----
*������ �������������*:
[code]�������::edName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_edName

 Tkw_GroupProperty_Control_edName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edName
----
*������ �������������*:
[code]�������::edName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_edName_Push

 Tkw_GroupProperty_Control_Label1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Label1
----
*������ �������������*:
[code]�������::Label1 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_Label1

 Tkw_GroupProperty_Control_Label1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Label1
----
*������ �������������*:
[code]�������::Label1:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupProperty_Control_Label1_Push

function TkwEfGroupPropertyEdName.edName(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TnscEdit;
 {* ���������� ����� ������� .TefGroupProperty.edName }
begin
 Result := aefGroupProperty.edName;
end;//TkwEfGroupPropertyEdName.edName

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

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

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edName', aCtx);
end;//TkwEfGroupPropertyEdName.SetValuePrim

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

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
 aefGroupProperty: TefGroupProperty): TvtLabel;
 {* ���������� ����� ������� .TefGroupProperty.Label1 }
begin
 Result := aefGroupProperty.Label1;
end;//TkwEfGroupPropertyLabel1.Label1

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

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

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Label1', aCtx);
end;//TkwEfGroupPropertyLabel1.SetValuePrim

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

function Tkw_Form_GroupProperty.GetString: AnsiString;
begin
 Result := 'efGroupProperty';
end;//Tkw_Form_GroupProperty.GetString

class procedure Tkw_Form_GroupProperty.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefGroupProperty);
end;//Tkw_Form_GroupProperty.RegisterInEngine

class function Tkw_Form_GroupProperty.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::GroupProperty';
end;//Tkw_Form_GroupProperty.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
begin
 Result := 'edName';
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_GroupProperty_Control_edName.RegisterInEngine

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

procedure Tkw_GroupProperty_Control_edName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edName');
 inherited;
end;//Tkw_GroupProperty_Control_edName_Push.DoDoIt

class function Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edName:push';
end;//Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister

function Tkw_GroupProperty_Control_Label1.GetString: AnsiString;
begin
 Result := 'Label1';
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_GroupProperty_Control_Label1.RegisterInEngine

class function Tkw_GroupProperty_Control_Label1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1';
end;//Tkw_GroupProperty_Control_Label1.GetWordNameForRegister

procedure Tkw_GroupProperty_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_GroupProperty_Control_Label1_Push.DoDoIt

class function Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1:push';
end;//Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister

initialization
 TkwEfGroupPropertyEdName.RegisterInEngine;
 {* ����������� efGroupProperty_edName }
 TkwEfGroupPropertyLabel1.RegisterInEngine;
 {* ����������� efGroupProperty_Label1 }
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupProperty));
 {* ����������� ���� TefGroupProperty }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
