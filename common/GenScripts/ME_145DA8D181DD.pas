unit EULAKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� EULA }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\EULAKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , vtLabel
 , vtButton
 , eeMemoWithEditOperations
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_EULA = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� EULA
----
*������ �������������*:
[code]
'aControl' �����::EULA TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EULA

 Tkw_EULA_Control_ShellCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel

 Tkw_EULA_Control_ShellCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel_Push

 Tkw_EULA_Control_OkButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_OkButton

 Tkw_EULA_Control_OkButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_OkButton_Push

 Tkw_EULA_Control_eeMemoWithEditOperations1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� eeMemoWithEditOperations1
----
*������ �������������*:
[code]
�������::eeMemoWithEditOperations1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1

 Tkw_EULA_Control_eeMemoWithEditOperations1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� eeMemoWithEditOperations1
----
*������ �������������*:
[code]
�������::eeMemoWithEditOperations1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push

 TkwEfEULAShellCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.ShellCaptionLabel
[panel]������� ShellCaptionLabel ����� TefEULA[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefEULA .TefEULA.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function ShellCaptionLabel(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtLabel;
    {* ���������� ����� ������� .TefEULA.ShellCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAShellCaptionLabel

 TkwEfEULAOkButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.OkButton
[panel]������� OkButton ����� TefEULA[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aefEULA .TefEULA.OkButton >>> l_TvtButton
[code]  }
  private
   function OkButton(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtButton;
    {* ���������� ����� ������� .TefEULA.OkButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAOkButton

 TkwEfEULAEeMemoWithEditOperations1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.eeMemoWithEditOperations1
[panel]������� eeMemoWithEditOperations1 ����� TefEULA[panel]
*��� ����������:* TeeMemoWithEditOperations
*������:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aefEULA .TefEULA.eeMemoWithEditOperations1 >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function eeMemoWithEditOperations1(const aCtx: TtfwContext;
    aefEULA: TefEULA): TeeMemoWithEditOperations;
    {* ���������� ����� ������� .TefEULA.eeMemoWithEditOperations1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAEeMemoWithEditOperations1

class function Tkw_Form_EULA.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::EULA';
end;//Tkw_Form_EULA.GetWordNameForRegister

function Tkw_Form_EULA.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C8D203B9FBAE_var*
//#UC END# *4DDFD2EA0116_C8D203B9FBAE_var*
begin
//#UC START# *4DDFD2EA0116_C8D203B9FBAE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C8D203B9FBAE_impl*
end;//Tkw_Form_EULA.GetString

class function Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel';
end;//Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister

function Tkw_EULA_Control_ShellCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_133785C674AC_var*
//#UC END# *4DDFD2EA0116_133785C674AC_var*
begin
//#UC START# *4DDFD2EA0116_133785C674AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_133785C674AC_impl*
end;//Tkw_EULA_Control_ShellCaptionLabel.GetString

class procedure Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_133785C674AC_var*
//#UC END# *52A086150180_133785C674AC_var*
begin
//#UC START# *52A086150180_133785C674AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_133785C674AC_impl*
end;//Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine

procedure Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44424D6041C9_var*
//#UC END# *4DAEEDE10285_44424D6041C9_var*
begin
//#UC START# *4DAEEDE10285_44424D6041C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44424D6041C9_impl*
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel:push';
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister

class function Tkw_EULA_Control_OkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton';
end;//Tkw_EULA_Control_OkButton.GetWordNameForRegister

function Tkw_EULA_Control_OkButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3BDBAE387D96_var*
//#UC END# *4DDFD2EA0116_3BDBAE387D96_var*
begin
//#UC START# *4DDFD2EA0116_3BDBAE387D96_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3BDBAE387D96_impl*
end;//Tkw_EULA_Control_OkButton.GetString

class procedure Tkw_EULA_Control_OkButton.RegisterInEngine;
//#UC START# *52A086150180_3BDBAE387D96_var*
//#UC END# *52A086150180_3BDBAE387D96_var*
begin
//#UC START# *52A086150180_3BDBAE387D96_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3BDBAE387D96_impl*
end;//Tkw_EULA_Control_OkButton.RegisterInEngine

procedure Tkw_EULA_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E0554E1E3296_var*
//#UC END# *4DAEEDE10285_E0554E1E3296_var*
begin
//#UC START# *4DAEEDE10285_E0554E1E3296_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E0554E1E3296_impl*
end;//Tkw_EULA_Control_OkButton_Push.DoDoIt

class function Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton:push';
end;//Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister

class function Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::eeMemoWithEditOperations1';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister

function Tkw_EULA_Control_eeMemoWithEditOperations1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6830474D7205_var*
//#UC END# *4DDFD2EA0116_6830474D7205_var*
begin
//#UC START# *4DDFD2EA0116_6830474D7205_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6830474D7205_impl*
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetString

class procedure Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
//#UC START# *52A086150180_6830474D7205_var*
//#UC END# *52A086150180_6830474D7205_var*
begin
//#UC START# *52A086150180_6830474D7205_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6830474D7205_impl*
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine

procedure Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_243E1D1B0C92_var*
//#UC END# *4DAEEDE10285_243E1D1B0C92_var*
begin
//#UC START# *4DAEEDE10285_243E1D1B0C92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_243E1D1B0C92_impl*
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt

class function Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::eeMemoWithEditOperations1:push';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister

function TkwEfEULAShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
 aefEULA: TefEULA): TvtLabel;
 {* ���������� ����� ������� .TefEULA.ShellCaptionLabel }
//#UC START# *628A5F6D2722_58C15386A400_var*
//#UC END# *628A5F6D2722_58C15386A400_var*
begin
//#UC START# *628A5F6D2722_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *628A5F6D2722_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.ShellCaptionLabel

procedure TkwEfEULAShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_58C15386A400_var*
//#UC END# *4DAEEDE10285_58C15386A400_var*
begin
//#UC START# *4DAEEDE10285_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.DoDoIt

class function TkwEfEULAShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.ShellCaptionLabel';
end;//TkwEfEULAShellCaptionLabel.GetWordNameForRegister

procedure TkwEfEULAShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_58C15386A400_var*
//#UC END# *52D00B00031A_58C15386A400_var*
begin
//#UC START# *52D00B00031A_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.SetValuePrim

function TkwEfEULAShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_58C15386A400_var*
//#UC END# *551544E2001A_58C15386A400_var*
begin
//#UC START# *551544E2001A_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.GetResultTypeInfo

function TkwEfEULAShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_58C15386A400_var*
//#UC END# *559687E6025A_58C15386A400_var*
begin
//#UC START# *559687E6025A_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.GetAllParamsCount

function TkwEfEULAShellCaptionLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_58C15386A400_var*
//#UC END# *5617F4D00243_58C15386A400_var*
begin
//#UC START# *5617F4D00243_58C15386A400_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_58C15386A400_impl*
end;//TkwEfEULAShellCaptionLabel.ParamsTypes

function TkwEfEULAOkButton.OkButton(const aCtx: TtfwContext;
 aefEULA: TefEULA): TvtButton;
 {* ���������� ����� ������� .TefEULA.OkButton }
//#UC START# *A7249F70CDDB_84B2391A0258_var*
//#UC END# *A7249F70CDDB_84B2391A0258_var*
begin
//#UC START# *A7249F70CDDB_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *A7249F70CDDB_84B2391A0258_impl*
end;//TkwEfEULAOkButton.OkButton

procedure TkwEfEULAOkButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_84B2391A0258_var*
//#UC END# *4DAEEDE10285_84B2391A0258_var*
begin
//#UC START# *4DAEEDE10285_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_84B2391A0258_impl*
end;//TkwEfEULAOkButton.DoDoIt

class function TkwEfEULAOkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.OkButton';
end;//TkwEfEULAOkButton.GetWordNameForRegister

procedure TkwEfEULAOkButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_84B2391A0258_var*
//#UC END# *52D00B00031A_84B2391A0258_var*
begin
//#UC START# *52D00B00031A_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_84B2391A0258_impl*
end;//TkwEfEULAOkButton.SetValuePrim

function TkwEfEULAOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_84B2391A0258_var*
//#UC END# *551544E2001A_84B2391A0258_var*
begin
//#UC START# *551544E2001A_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_84B2391A0258_impl*
end;//TkwEfEULAOkButton.GetResultTypeInfo

function TkwEfEULAOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_84B2391A0258_var*
//#UC END# *559687E6025A_84B2391A0258_var*
begin
//#UC START# *559687E6025A_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_84B2391A0258_impl*
end;//TkwEfEULAOkButton.GetAllParamsCount

function TkwEfEULAOkButton.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_84B2391A0258_var*
//#UC END# *5617F4D00243_84B2391A0258_var*
begin
//#UC START# *5617F4D00243_84B2391A0258_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_84B2391A0258_impl*
end;//TkwEfEULAOkButton.ParamsTypes

function TkwEfEULAEeMemoWithEditOperations1.eeMemoWithEditOperations1(const aCtx: TtfwContext;
 aefEULA: TefEULA): TeeMemoWithEditOperations;
 {* ���������� ����� ������� .TefEULA.eeMemoWithEditOperations1 }
//#UC START# *70E6A37FB9C7_ACE4A3A50395_var*
//#UC END# *70E6A37FB9C7_ACE4A3A50395_var*
begin
//#UC START# *70E6A37FB9C7_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *70E6A37FB9C7_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.eeMemoWithEditOperations1

procedure TkwEfEULAEeMemoWithEditOperations1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACE4A3A50395_var*
//#UC END# *4DAEEDE10285_ACE4A3A50395_var*
begin
//#UC START# *4DAEEDE10285_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.DoDoIt

class function TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.eeMemoWithEditOperations1';
end;//TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister

procedure TkwEfEULAEeMemoWithEditOperations1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_ACE4A3A50395_var*
//#UC END# *52D00B00031A_ACE4A3A50395_var*
begin
//#UC START# *52D00B00031A_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.SetValuePrim

function TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ACE4A3A50395_var*
//#UC END# *551544E2001A_ACE4A3A50395_var*
begin
//#UC START# *551544E2001A_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo

function TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_ACE4A3A50395_var*
//#UC END# *559687E6025A_ACE4A3A50395_var*
begin
//#UC START# *559687E6025A_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount

function TkwEfEULAEeMemoWithEditOperations1.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ACE4A3A50395_var*
//#UC END# *5617F4D00243_ACE4A3A50395_var*
begin
//#UC START# *5617F4D00243_ACE4A3A50395_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ACE4A3A50395_impl*
end;//TkwEfEULAEeMemoWithEditOperations1.ParamsTypes

initialization
 Tkw_Form_EULA.RegisterInEngine;
 {* ����������� Tkw_Form_EULA }
 Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_ShellCaptionLabel }
 Tkw_EULA_Control_ShellCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_ShellCaptionLabel_Push }
 Tkw_EULA_Control_OkButton.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_OkButton }
 Tkw_EULA_Control_OkButton_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_OkButton_Push }
 Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_eeMemoWithEditOperations1 }
 Tkw_EULA_Control_eeMemoWithEditOperations1_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_eeMemoWithEditOperations1_Push }
 TkwEfEULAShellCaptionLabel.RegisterInEngine;
 {* ����������� efEULA_ShellCaptionLabel }
 TkwEfEULAOkButton.RegisterInEngine;
 {* ����������� efEULA_OkButton }
 TkwEfEULAEeMemoWithEditOperations1.RegisterInEngine;
 {* ����������� efEULA_eeMemoWithEditOperations1 }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefEULA));
 {* ����������� ���� EULA }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* ����������� ���� TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
