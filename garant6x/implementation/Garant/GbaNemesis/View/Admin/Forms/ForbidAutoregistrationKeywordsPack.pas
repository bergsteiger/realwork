unit ForbidAutoregistrationKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ForbidAutoregistration }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\ForbidAutoregistrationKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ForbidAutoregistrationKeywordsPack" MUID: (4AA8E405032A_Pack)

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
 , ForbidAutoregistration_Form
 , tfwPropertyLike
 , vtLabel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtGroupBox
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AA8E405032A_Packimpl_uses*
 //#UC END# *4AA8E405032A_Packimpl_uses*
;

type
 TkwEfForbidAutoregistrationLblReference = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.lblReference }
  private
   function lblReference(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* ���������� ����� ������� .TefForbidAutoregistration.lblReference }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationLblReference

 TkwEfForbidAutoregistrationGbInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.gbInfo }
  private
   function gbInfo(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
    {* ���������� ����� ������� .TefForbidAutoregistration.gbInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationGbInfo

 TkwEfForbidAutoregistrationLblPhone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.lblPhone }
  private
   function lblPhone(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* ���������� ����� ������� .TefForbidAutoregistration.lblPhone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationLblPhone

 TkwEfForbidAutoregistrationLblEmail = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.lblEmail }
  private
   function lblEmail(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* ���������� ����� ������� .TefForbidAutoregistration.lblEmail }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationLblEmail

 TkwEfForbidAutoregistrationLblHint = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.lblHint }
  private
   function lblHint(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* ���������� ����� ������� .TefForbidAutoregistration.lblHint }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationLblHint

 TkwEfForbidAutoregistrationCbPhone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.cbPhone }
  private
   function cbPhone(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
    {* ���������� ����� ������� .TefForbidAutoregistration.cbPhone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationCbPhone

 TkwEfForbidAutoregistrationCbEmail = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefForbidAutoregistration.cbEmail }
  private
   function cbEmail(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
    {* ���������� ����� ������� .TefForbidAutoregistration.cbEmail }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfForbidAutoregistrationCbEmail

 Tkw_Form_ForbidAutoregistration = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ForbidAutoregistration
----
*������ �������������*:
[code]�����::ForbidAutoregistration TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ForbidAutoregistration

 Tkw_ForbidAutoregistration_Control_lblReference = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblReference
----
*������ �������������*:
[code]�������::lblReference TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblReference

 Tkw_ForbidAutoregistration_Control_lblReference_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblReference
----
*������ �������������*:
[code]�������::lblReference:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblReference_Push

 Tkw_ForbidAutoregistration_Control_gbInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� gbInfo
----
*������ �������������*:
[code]�������::gbInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_gbInfo

 Tkw_ForbidAutoregistration_Control_gbInfo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� gbInfo
----
*������ �������������*:
[code]�������::gbInfo:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push

 Tkw_ForbidAutoregistration_Control_lblPhone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblPhone
----
*������ �������������*:
[code]�������::lblPhone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblPhone

 Tkw_ForbidAutoregistration_Control_lblPhone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblPhone
----
*������ �������������*:
[code]�������::lblPhone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push

 Tkw_ForbidAutoregistration_Control_lblEmail = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblEmail
----
*������ �������������*:
[code]�������::lblEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblEmail

 Tkw_ForbidAutoregistration_Control_lblEmail_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblEmail
----
*������ �������������*:
[code]�������::lblEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push

 Tkw_ForbidAutoregistration_Control_lblHint = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblHint
----
*������ �������������*:
[code]�������::lblHint TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblHint

 Tkw_ForbidAutoregistration_Control_lblHint_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblHint
----
*������ �������������*:
[code]�������::lblHint:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblHint_Push

 Tkw_ForbidAutoregistration_Control_cbPhone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbPhone
----
*������ �������������*:
[code]�������::cbPhone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbPhone

 Tkw_ForbidAutoregistration_Control_cbPhone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbPhone
----
*������ �������������*:
[code]�������::cbPhone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push

 Tkw_ForbidAutoregistration_Control_cbEmail = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbEmail
----
*������ �������������*:
[code]�������::cbEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbEmail

 Tkw_ForbidAutoregistration_Control_cbEmail_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� cbEmail
----
*������ �������������*:
[code]�������::cbEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push

function TkwEfForbidAutoregistrationLblReference.lblReference(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* ���������� ����� ������� .TefForbidAutoregistration.lblReference }
begin
 Result := aefForbidAutoregistration.lblReference;
end;//TkwEfForbidAutoregistrationLblReference.lblReference

class function TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblReference';
end;//TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblReference.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblReference.GetAllParamsCount

function TkwEfForbidAutoregistrationLblReference.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblReference.ParamsTypes

procedure TkwEfForbidAutoregistrationLblReference.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblReference', aCtx);
end;//TkwEfForbidAutoregistrationLblReference.SetValuePrim

procedure TkwEfForbidAutoregistrationLblReference.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblReference(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblReference.DoDoIt

function TkwEfForbidAutoregistrationGbInfo.gbInfo(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
 {* ���������� ����� ������� .TefForbidAutoregistration.gbInfo }
begin
 Result := aefForbidAutoregistration.gbInfo;
end;//TkwEfForbidAutoregistrationGbInfo.gbInfo

class function TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.gbInfo';
end;//TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister

function TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo

function TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount

function TkwEfForbidAutoregistrationGbInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationGbInfo.ParamsTypes

procedure TkwEfForbidAutoregistrationGbInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� gbInfo', aCtx);
end;//TkwEfForbidAutoregistrationGbInfo.SetValuePrim

procedure TkwEfForbidAutoregistrationGbInfo.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbInfo(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationGbInfo.DoDoIt

function TkwEfForbidAutoregistrationLblPhone.lblPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* ���������� ����� ������� .TefForbidAutoregistration.lblPhone }
begin
 Result := aefForbidAutoregistration.lblPhone;
end;//TkwEfForbidAutoregistrationLblPhone.lblPhone

class function TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblPhone';
end;//TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationLblPhone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblPhone.ParamsTypes

procedure TkwEfForbidAutoregistrationLblPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblPhone', aCtx);
end;//TkwEfForbidAutoregistrationLblPhone.SetValuePrim

procedure TkwEfForbidAutoregistrationLblPhone.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblPhone(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblPhone.DoDoIt

function TkwEfForbidAutoregistrationLblEmail.lblEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* ���������� ����� ������� .TefForbidAutoregistration.lblEmail }
begin
 Result := aefForbidAutoregistration.lblEmail;
end;//TkwEfForbidAutoregistrationLblEmail.lblEmail

class function TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblEmail';
end;//TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationLblEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblEmail.ParamsTypes

procedure TkwEfForbidAutoregistrationLblEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblEmail', aCtx);
end;//TkwEfForbidAutoregistrationLblEmail.SetValuePrim

procedure TkwEfForbidAutoregistrationLblEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblEmail(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblEmail.DoDoIt

function TkwEfForbidAutoregistrationLblHint.lblHint(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* ���������� ����� ������� .TefForbidAutoregistration.lblHint }
begin
 Result := aefForbidAutoregistration.lblHint;
end;//TkwEfForbidAutoregistrationLblHint.lblHint

class function TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblHint';
end;//TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblHint.GetAllParamsCount

function TkwEfForbidAutoregistrationLblHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblHint.ParamsTypes

procedure TkwEfForbidAutoregistrationLblHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblHint', aCtx);
end;//TkwEfForbidAutoregistrationLblHint.SetValuePrim

procedure TkwEfForbidAutoregistrationLblHint.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblHint(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblHint.DoDoIt

function TkwEfForbidAutoregistrationCbPhone.cbPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* ���������� ����� ������� .TefForbidAutoregistration.cbPhone }
begin
 Result := aefForbidAutoregistration.cbPhone;
end;//TkwEfForbidAutoregistrationCbPhone.cbPhone

class function TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbPhone';
end;//TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister

function TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationCbPhone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbPhone.ParamsTypes

procedure TkwEfForbidAutoregistrationCbPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbPhone', aCtx);
end;//TkwEfForbidAutoregistrationCbPhone.SetValuePrim

procedure TkwEfForbidAutoregistrationCbPhone.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbPhone(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationCbPhone.DoDoIt

function TkwEfForbidAutoregistrationCbEmail.cbEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* ���������� ����� ������� .TefForbidAutoregistration.cbEmail }
begin
 Result := aefForbidAutoregistration.cbEmail;
end;//TkwEfForbidAutoregistrationCbEmail.cbEmail

class function TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbEmail';
end;//TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister

function TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationCbEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbEmail.ParamsTypes

procedure TkwEfForbidAutoregistrationCbEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbEmail', aCtx);
end;//TkwEfForbidAutoregistrationCbEmail.SetValuePrim

procedure TkwEfForbidAutoregistrationCbEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbEmail(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationCbEmail.DoDoIt

function Tkw_Form_ForbidAutoregistration.GetString: AnsiString;
begin
 Result := 'efForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetString

class procedure Tkw_Form_ForbidAutoregistration.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefForbidAutoregistration);
end;//Tkw_Form_ForbidAutoregistration.RegisterInEngine

class function Tkw_Form_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblReference.GetString: AnsiString;
begin
 Result := 'lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblReference');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblReference:push';
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_gbInfo.GetString: AnsiString;
begin
 Result := 'gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetString

class procedure Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbInfo');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::gbInfo:push';
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblPhone.GetString: AnsiString;
begin
 Result := 'lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblPhone:push';
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblEmail.GetString: AnsiString;
begin
 Result := 'lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblEmail:push';
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblHint.GetString: AnsiString;
begin
 Result := 'lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblHint');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblHint:push';
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbPhone.GetString: AnsiString;
begin
 Result := 'cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbPhone:push';
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbEmail.GetString: AnsiString;
begin
 Result := 'cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbEmail:push';
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister

initialization
 TkwEfForbidAutoregistrationLblReference.RegisterInEngine;
 {* ����������� efForbidAutoregistration_lblReference }
 TkwEfForbidAutoregistrationGbInfo.RegisterInEngine;
 {* ����������� efForbidAutoregistration_gbInfo }
 TkwEfForbidAutoregistrationLblPhone.RegisterInEngine;
 {* ����������� efForbidAutoregistration_lblPhone }
 TkwEfForbidAutoregistrationLblEmail.RegisterInEngine;
 {* ����������� efForbidAutoregistration_lblEmail }
 TkwEfForbidAutoregistrationLblHint.RegisterInEngine;
 {* ����������� efForbidAutoregistration_lblHint }
 TkwEfForbidAutoregistrationCbPhone.RegisterInEngine;
 {* ����������� efForbidAutoregistration_cbPhone }
 TkwEfForbidAutoregistrationCbEmail.RegisterInEngine;
 {* ����������� efForbidAutoregistration_cbEmail }
 Tkw_Form_ForbidAutoregistration.RegisterInEngine;
 {* ����������� Tkw_Form_ForbidAutoregistration }
 Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblReference }
 Tkw_ForbidAutoregistration_Control_lblReference_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblReference_Push }
 Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_gbInfo }
 Tkw_ForbidAutoregistration_Control_gbInfo_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_gbInfo_Push }
 Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblPhone }
 Tkw_ForbidAutoregistration_Control_lblPhone_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblPhone_Push }
 Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblEmail }
 Tkw_ForbidAutoregistration_Control_lblEmail_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblEmail_Push }
 Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblHint }
 Tkw_ForbidAutoregistration_Control_lblHint_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_lblHint_Push }
 Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_cbPhone }
 Tkw_ForbidAutoregistration_Control_cbPhone_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_cbPhone_Push }
 Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_cbEmail }
 Tkw_ForbidAutoregistration_Control_cbEmail_Push.RegisterInEngine;
 {* ����������� Tkw_ForbidAutoregistration_Control_cbEmail_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefForbidAutoregistration));
 {* ����������� ���� TefForbidAutoregistration }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
