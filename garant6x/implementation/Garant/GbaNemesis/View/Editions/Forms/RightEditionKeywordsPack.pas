unit RightEditionKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� RightEdition }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\RightEditionKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "RightEditionKeywordsPack" MUID: (4A6EC062005F_Pack)

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
 , RightEdition_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtFocusLabel
 , ExtCtrls
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , vtComboBoxQS
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwRightEditionFormHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.Header }
  private
   function Header(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.Header }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormHeader

 TkwRightEditionFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pnLeft }
  private
   function pnLeft(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.pnLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormPnLeft

 TkwRightEditionFormEditionLink = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.EditionLink }
  private
   function EditionLink(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtFocusLabel;
    {* ���������� ����� ������� .TRightEditionForm.EditionLink }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormEditionLink

 TkwRightEditionFormPbIcon = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pbIcon }
  private
   function pbIcon(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TPaintBox;
    {* ���������� ����� ������� .TRightEditionForm.pbIcon }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormPbIcon

 TkwRightEditionFormPnCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pnCaption }
  private
   function pnCaption(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.pnCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormPnCaption

 TkwRightEditionFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.Text }
  private
   function Text(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TnscEditor;
    {* ���������� ����� ������� .TRightEditionForm.Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRightEditionFormText

 Tkw_Form_RightEdition = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� RightEdition
----
*������ �������������*:
[code]�����::RightEdition TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_RightEdition

 Tkw_RightEdition_Control_Header = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Header
----
*������ �������������*:
[code]�������::Header TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Header

 Tkw_RightEdition_Control_Header_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Header
----
*������ �������������*:
[code]�������::Header:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Header_Push

 Tkw_RightEdition_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnLeft

 Tkw_RightEdition_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnLeft_Push

 Tkw_RightEdition_Control_EditionLink = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EditionLink
----
*������ �������������*:
[code]�������::EditionLink TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionLink

 Tkw_RightEdition_Control_EditionLink_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EditionLink
----
*������ �������������*:
[code]�������::EditionLink:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionLink_Push

 Tkw_RightEdition_Control_pbIcon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbIcon
----
*������ �������������*:
[code]�������::pbIcon TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pbIcon

 Tkw_RightEdition_Control_pbIcon_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbIcon
----
*������ �������������*:
[code]�������::pbIcon:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pbIcon_Push

 Tkw_RightEdition_Control_pnCaption = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnCaption
----
*������ �������������*:
[code]�������::pnCaption TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnCaption

 Tkw_RightEdition_Control_pnCaption_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnCaption
----
*������ �������������*:
[code]�������::pnCaption:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnCaption_Push

 Tkw_RightEdition_Control_EditionChoose = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EditionChoose
----
*������ �������������*:
[code]�������::EditionChoose TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionChoose

 Tkw_RightEdition_Control_EditionChoose_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EditionChoose
----
*������ �������������*:
[code]�������::EditionChoose:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionChoose_Push

 Tkw_RightEdition_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]�������::Text TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Text

 Tkw_RightEdition_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]�������::Text:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Text_Push

 Tkw_RightEdition_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]���������::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Component_TextSource

function TkwRightEditionFormHeader.Header(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.Header }
begin
 Result := aRightEditionForm.Header;
end;//TkwRightEditionFormHeader.Header

class function TkwRightEditionFormHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.Header';
end;//TkwRightEditionFormHeader.GetWordNameForRegister

function TkwRightEditionFormHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormHeader.GetResultTypeInfo

function TkwRightEditionFormHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormHeader.GetAllParamsCount

function TkwRightEditionFormHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormHeader.ParamsTypes

procedure TkwRightEditionFormHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Header', aCtx);
end;//TkwRightEditionFormHeader.SetValuePrim

procedure TkwRightEditionFormHeader.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Header(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormHeader.DoDoIt

function TkwRightEditionFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.pnLeft }
begin
 Result := aRightEditionForm.pnLeft;
end;//TkwRightEditionFormPnLeft.pnLeft

class function TkwRightEditionFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pnLeft';
end;//TkwRightEditionFormPnLeft.GetWordNameForRegister

function TkwRightEditionFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormPnLeft.GetResultTypeInfo

function TkwRightEditionFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPnLeft.GetAllParamsCount

function TkwRightEditionFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPnLeft.ParamsTypes

procedure TkwRightEditionFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwRightEditionFormPnLeft.SetValuePrim

procedure TkwRightEditionFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormPnLeft.DoDoIt

function TkwRightEditionFormEditionLink.EditionLink(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtFocusLabel;
 {* ���������� ����� ������� .TRightEditionForm.EditionLink }
begin
 Result := aRightEditionForm.EditionLink;
end;//TkwRightEditionFormEditionLink.EditionLink

class function TkwRightEditionFormEditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.EditionLink';
end;//TkwRightEditionFormEditionLink.GetWordNameForRegister

function TkwRightEditionFormEditionLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwRightEditionFormEditionLink.GetResultTypeInfo

function TkwRightEditionFormEditionLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormEditionLink.GetAllParamsCount

function TkwRightEditionFormEditionLink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormEditionLink.ParamsTypes

procedure TkwRightEditionFormEditionLink.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EditionLink', aCtx);
end;//TkwRightEditionFormEditionLink.SetValuePrim

procedure TkwRightEditionFormEditionLink.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EditionLink(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormEditionLink.DoDoIt

function TkwRightEditionFormPbIcon.pbIcon(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TPaintBox;
 {* ���������� ����� ������� .TRightEditionForm.pbIcon }
begin
 Result := aRightEditionForm.pbIcon;
end;//TkwRightEditionFormPbIcon.pbIcon

class function TkwRightEditionFormPbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pbIcon';
end;//TkwRightEditionFormPbIcon.GetWordNameForRegister

function TkwRightEditionFormPbIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwRightEditionFormPbIcon.GetResultTypeInfo

function TkwRightEditionFormPbIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPbIcon.GetAllParamsCount

function TkwRightEditionFormPbIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPbIcon.ParamsTypes

procedure TkwRightEditionFormPbIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbIcon', aCtx);
end;//TkwRightEditionFormPbIcon.SetValuePrim

procedure TkwRightEditionFormPbIcon.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbIcon(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormPbIcon.DoDoIt

function TkwRightEditionFormPnCaption.pnCaption(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.pnCaption }
begin
 Result := aRightEditionForm.pnCaption;
end;//TkwRightEditionFormPnCaption.pnCaption

class function TkwRightEditionFormPnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pnCaption';
end;//TkwRightEditionFormPnCaption.GetWordNameForRegister

function TkwRightEditionFormPnCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormPnCaption.GetResultTypeInfo

function TkwRightEditionFormPnCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPnCaption.GetAllParamsCount

function TkwRightEditionFormPnCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPnCaption.ParamsTypes

procedure TkwRightEditionFormPnCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnCaption', aCtx);
end;//TkwRightEditionFormPnCaption.SetValuePrim

procedure TkwRightEditionFormPnCaption.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnCaption(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormPnCaption.DoDoIt

function TkwRightEditionFormText.Text(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TnscEditor;
 {* ���������� ����� ������� .TRightEditionForm.Text }
begin
 Result := aRightEditionForm.Text;
end;//TkwRightEditionFormText.Text

class function TkwRightEditionFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.Text';
end;//TkwRightEditionFormText.GetWordNameForRegister

function TkwRightEditionFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwRightEditionFormText.GetResultTypeInfo

function TkwRightEditionFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormText.GetAllParamsCount

function TkwRightEditionFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormText.ParamsTypes

procedure TkwRightEditionFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwRightEditionFormText.SetValuePrim

procedure TkwRightEditionFormText.DoDoIt(const aCtx: TtfwContext);
var l_aRightEditionForm: TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aRightEditionForm));
end;//TkwRightEditionFormText.DoDoIt

function Tkw_Form_RightEdition.GetString: AnsiString;
begin
 Result := 'RightEditionForm';
end;//Tkw_Form_RightEdition.GetString

class procedure Tkw_Form_RightEdition.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TRightEditionForm);
end;//Tkw_Form_RightEdition.RegisterInEngine

class function Tkw_Form_RightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::RightEdition';
end;//Tkw_Form_RightEdition.GetWordNameForRegister

function Tkw_RightEdition_Control_Header.GetString: AnsiString;
begin
 Result := 'Header';
end;//Tkw_RightEdition_Control_Header.GetString

class procedure Tkw_RightEdition_Control_Header.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_Header.RegisterInEngine

class function Tkw_RightEdition_Control_Header.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Header';
end;//Tkw_RightEdition_Control_Header.GetWordNameForRegister

procedure Tkw_RightEdition_Control_Header_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Header');
 inherited;
end;//Tkw_RightEdition_Control_Header_Push.DoDoIt

class function Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Header:push';
end;//Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_RightEdition_Control_pnLeft.GetString

class procedure Tkw_RightEdition_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_pnLeft.RegisterInEngine

class function Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister

procedure Tkw_RightEdition_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_RightEdition_Control_pnLeft_Push.DoDoIt

class function Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionLink.GetString: AnsiString;
begin
 Result := 'EditionLink';
end;//Tkw_RightEdition_Control_EditionLink.GetString

class procedure Tkw_RightEdition_Control_EditionLink.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_RightEdition_Control_EditionLink.RegisterInEngine

class function Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionLink';
end;//Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister

procedure Tkw_RightEdition_Control_EditionLink_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EditionLink');
 inherited;
end;//Tkw_RightEdition_Control_EditionLink_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionLink:push';
end;//Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_pbIcon.GetString: AnsiString;
begin
 Result := 'pbIcon';
end;//Tkw_RightEdition_Control_pbIcon.GetString

class procedure Tkw_RightEdition_Control_pbIcon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_RightEdition_Control_pbIcon.RegisterInEngine

class function Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbIcon';
end;//Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister

procedure Tkw_RightEdition_Control_pbIcon_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbIcon');
 inherited;
end;//Tkw_RightEdition_Control_pbIcon_Push.DoDoIt

class function Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbIcon:push';
end;//Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_pnCaption.GetString: AnsiString;
begin
 Result := 'pnCaption';
end;//Tkw_RightEdition_Control_pnCaption.GetString

class procedure Tkw_RightEdition_Control_pnCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_pnCaption.RegisterInEngine

class function Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnCaption';
end;//Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister

procedure Tkw_RightEdition_Control_pnCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnCaption');
 inherited;
end;//Tkw_RightEdition_Control_pnCaption_Push.DoDoIt

class function Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnCaption:push';
end;//Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionChoose.GetString: AnsiString;
begin
 Result := 'EditionChoose';
end;//Tkw_RightEdition_Control_EditionChoose.GetString

class procedure Tkw_RightEdition_Control_EditionChoose.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_RightEdition_Control_EditionChoose.RegisterInEngine

class function Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionChoose';
end;//Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister

procedure Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EditionChoose');
 inherited;
end;//Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionChoose:push';
end;//Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister

function Tkw_RightEdition_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_RightEdition_Control_Text.GetString

class procedure Tkw_RightEdition_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_RightEdition_Control_Text.RegisterInEngine

class function Tkw_RightEdition_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_RightEdition_Control_Text.GetWordNameForRegister

procedure Tkw_RightEdition_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_RightEdition_Control_Text_Push.DoDoIt

class function Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister

function Tkw_RightEdition_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_RightEdition_Component_TextSource.GetString

class procedure Tkw_RightEdition_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_RightEdition_Component_TextSource.RegisterInEngine

class function Tkw_RightEdition_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_RightEdition_Component_TextSource.GetWordNameForRegister

initialization
 TkwRightEditionFormHeader.RegisterInEngine;
 {* ����������� RightEditionForm_Header }
 TkwRightEditionFormPnLeft.RegisterInEngine;
 {* ����������� RightEditionForm_pnLeft }
 TkwRightEditionFormEditionLink.RegisterInEngine;
 {* ����������� RightEditionForm_EditionLink }
 TkwRightEditionFormPbIcon.RegisterInEngine;
 {* ����������� RightEditionForm_pbIcon }
 TkwRightEditionFormPnCaption.RegisterInEngine;
 {* ����������� RightEditionForm_pnCaption }
 TkwRightEditionFormText.RegisterInEngine;
 {* ����������� RightEditionForm_Text }
 Tkw_Form_RightEdition.RegisterInEngine;
 {* ����������� Tkw_Form_RightEdition }
 Tkw_RightEdition_Control_Header.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_Header }
 Tkw_RightEdition_Control_Header_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_Header_Push }
 Tkw_RightEdition_Control_pnLeft.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pnLeft }
 Tkw_RightEdition_Control_pnLeft_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pnLeft_Push }
 Tkw_RightEdition_Control_EditionLink.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_EditionLink }
 Tkw_RightEdition_Control_EditionLink_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_EditionLink_Push }
 Tkw_RightEdition_Control_pbIcon.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pbIcon }
 Tkw_RightEdition_Control_pbIcon_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pbIcon_Push }
 Tkw_RightEdition_Control_pnCaption.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pnCaption }
 Tkw_RightEdition_Control_pnCaption_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_pnCaption_Push }
 Tkw_RightEdition_Control_EditionChoose.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_EditionChoose }
 Tkw_RightEdition_Control_EditionChoose_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_EditionChoose_Push }
 Tkw_RightEdition_Control_Text.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_Text }
 Tkw_RightEdition_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Control_Text_Push }
 Tkw_RightEdition_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_RightEdition_Component_TextSource }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRightEditionForm));
 {* ����������� ���� TRightEditionForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* ����������� ���� TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
