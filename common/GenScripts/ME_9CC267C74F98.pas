unit RightEditionKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� RightEdition }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\RightEditionKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseEditions_Module
 , vtPanel
 , vtFocusLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
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
 , vtComboBoxQS
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
;

type
 Tkw_Form_RightEdition = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� RightEdition
----
*������ �������������*:
[code]
'aControl' �����::RightEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_RightEdition

 Tkw_RightEdition_Control_Header = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Header
----
*������ �������������*:
[code]
�������::Header TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_Header

 Tkw_RightEdition_Control_Header_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Header
----
*������ �������������*:
[code]
�������::Header:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Header_Push

 Tkw_RightEdition_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_pnLeft

 Tkw_RightEdition_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnLeft_Push

 Tkw_RightEdition_Control_EditionLink = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EditionLink
----
*������ �������������*:
[code]
�������::EditionLink TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_EditionLink

 Tkw_RightEdition_Control_EditionLink_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EditionLink
----
*������ �������������*:
[code]
�������::EditionLink:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionLink_Push

 Tkw_RightEdition_Control_pbIcon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbIcon
----
*������ �������������*:
[code]
�������::pbIcon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_pbIcon

 Tkw_RightEdition_Control_pbIcon_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbIcon
----
*������ �������������*:
[code]
�������::pbIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pbIcon_Push

 Tkw_RightEdition_Control_pnCaption = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnCaption
----
*������ �������������*:
[code]
�������::pnCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_pnCaption

 Tkw_RightEdition_Control_pnCaption_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnCaption
----
*������ �������������*:
[code]
�������::pnCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_pnCaption_Push

 Tkw_RightEdition_Control_EditionChoose = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EditionChoose
----
*������ �������������*:
[code]
�������::EditionChoose TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_EditionChoose

 Tkw_RightEdition_Control_EditionChoose_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EditionChoose
----
*������ �������������*:
[code]
�������::EditionChoose:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_EditionChoose_Push

 Tkw_RightEdition_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Control_Text

 Tkw_RightEdition_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RightEdition_Control_Text_Push

 Tkw_RightEdition_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RightEdition_Component_TextSource

 TkwRightEditionFormHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.Header
[panel]������� Header ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.Header >>> l_TvtPanel
[code]  }
  private
   function Header(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.Header }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormHeader

 TkwRightEditionFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pnLeft
[panel]������� pnLeft ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.pnLeft >>> l_TvtPanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormPnLeft

 TkwRightEditionFormEditionLink = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.EditionLink
[panel]������� EditionLink ����� TRightEditionForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aRightEditionForm .TRightEditionForm.EditionLink >>> l_TvtFocusLabel
[code]  }
  private
   function EditionLink(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtFocusLabel;
    {* ���������� ����� ������� .TRightEditionForm.EditionLink }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormEditionLink

 TkwRightEditionFormPbIcon = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pbIcon
[panel]������� pbIcon ����� TRightEditionForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aRightEditionForm .TRightEditionForm.pbIcon >>> l_TPaintBox
[code]  }
  private
   function pbIcon(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TPaintBox;
    {* ���������� ����� ������� .TRightEditionForm.pbIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormPbIcon

 TkwRightEditionFormPnCaption = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.pnCaption
[panel]������� pnCaption ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.pnCaption >>> l_TvtPanel
[code]  }
  private
   function pnCaption(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TvtPanel;
    {* ���������� ����� ������� .TRightEditionForm.pnCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormPnCaption

 TkwRightEditionFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRightEditionForm.Text
[panel]������� Text ����� TRightEditionForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aRightEditionForm .TRightEditionForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aRightEditionForm: TRightEditionForm): TnscEditor;
    {* ���������� ����� ������� .TRightEditionForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRightEditionFormText

class function Tkw_Form_RightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::RightEdition';
end;//Tkw_Form_RightEdition.GetWordNameForRegister

function Tkw_Form_RightEdition.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_930646B67F25_var*
//#UC END# *4DDFD2EA0116_930646B67F25_var*
begin
//#UC START# *4DDFD2EA0116_930646B67F25_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_930646B67F25_impl*
end;//Tkw_Form_RightEdition.GetString

class function Tkw_RightEdition_Control_Header.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Header';
end;//Tkw_RightEdition_Control_Header.GetWordNameForRegister

function Tkw_RightEdition_Control_Header.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C8BF4BB99E0D_var*
//#UC END# *4DDFD2EA0116_C8BF4BB99E0D_var*
begin
//#UC START# *4DDFD2EA0116_C8BF4BB99E0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C8BF4BB99E0D_impl*
end;//Tkw_RightEdition_Control_Header.GetString

class procedure Tkw_RightEdition_Control_Header.RegisterInEngine;
//#UC START# *52A086150180_C8BF4BB99E0D_var*
//#UC END# *52A086150180_C8BF4BB99E0D_var*
begin
//#UC START# *52A086150180_C8BF4BB99E0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C8BF4BB99E0D_impl*
end;//Tkw_RightEdition_Control_Header.RegisterInEngine

procedure Tkw_RightEdition_Control_Header_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACBB2405F6BD_var*
//#UC END# *4DAEEDE10285_ACBB2405F6BD_var*
begin
//#UC START# *4DAEEDE10285_ACBB2405F6BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACBB2405F6BD_impl*
end;//Tkw_RightEdition_Control_Header_Push.DoDoIt

class function Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Header:push';
end;//Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister

function Tkw_RightEdition_Control_pnLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_633301B88295_var*
//#UC END# *4DDFD2EA0116_633301B88295_var*
begin
//#UC START# *4DDFD2EA0116_633301B88295_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_633301B88295_impl*
end;//Tkw_RightEdition_Control_pnLeft.GetString

class procedure Tkw_RightEdition_Control_pnLeft.RegisterInEngine;
//#UC START# *52A086150180_633301B88295_var*
//#UC END# *52A086150180_633301B88295_var*
begin
//#UC START# *52A086150180_633301B88295_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_633301B88295_impl*
end;//Tkw_RightEdition_Control_pnLeft.RegisterInEngine

procedure Tkw_RightEdition_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0178294CE7EF_var*
//#UC END# *4DAEEDE10285_0178294CE7EF_var*
begin
//#UC START# *4DAEEDE10285_0178294CE7EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0178294CE7EF_impl*
end;//Tkw_RightEdition_Control_pnLeft_Push.DoDoIt

class function Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionLink';
end;//Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionLink.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8CAA62C48C38_var*
//#UC END# *4DDFD2EA0116_8CAA62C48C38_var*
begin
//#UC START# *4DDFD2EA0116_8CAA62C48C38_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8CAA62C48C38_impl*
end;//Tkw_RightEdition_Control_EditionLink.GetString

class procedure Tkw_RightEdition_Control_EditionLink.RegisterInEngine;
//#UC START# *52A086150180_8CAA62C48C38_var*
//#UC END# *52A086150180_8CAA62C48C38_var*
begin
//#UC START# *52A086150180_8CAA62C48C38_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8CAA62C48C38_impl*
end;//Tkw_RightEdition_Control_EditionLink.RegisterInEngine

procedure Tkw_RightEdition_Control_EditionLink_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44BEFD30E237_var*
//#UC END# *4DAEEDE10285_44BEFD30E237_var*
begin
//#UC START# *4DAEEDE10285_44BEFD30E237_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44BEFD30E237_impl*
end;//Tkw_RightEdition_Control_EditionLink_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionLink:push';
end;//Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbIcon';
end;//Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister

function Tkw_RightEdition_Control_pbIcon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1062238C93F1_var*
//#UC END# *4DDFD2EA0116_1062238C93F1_var*
begin
//#UC START# *4DDFD2EA0116_1062238C93F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1062238C93F1_impl*
end;//Tkw_RightEdition_Control_pbIcon.GetString

class procedure Tkw_RightEdition_Control_pbIcon.RegisterInEngine;
//#UC START# *52A086150180_1062238C93F1_var*
//#UC END# *52A086150180_1062238C93F1_var*
begin
//#UC START# *52A086150180_1062238C93F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1062238C93F1_impl*
end;//Tkw_RightEdition_Control_pbIcon.RegisterInEngine

procedure Tkw_RightEdition_Control_pbIcon_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8EC44868D15F_var*
//#UC END# *4DAEEDE10285_8EC44868D15F_var*
begin
//#UC START# *4DAEEDE10285_8EC44868D15F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8EC44868D15F_impl*
end;//Tkw_RightEdition_Control_pbIcon_Push.DoDoIt

class function Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbIcon:push';
end;//Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnCaption';
end;//Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister

function Tkw_RightEdition_Control_pnCaption.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5252D867215B_var*
//#UC END# *4DDFD2EA0116_5252D867215B_var*
begin
//#UC START# *4DDFD2EA0116_5252D867215B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5252D867215B_impl*
end;//Tkw_RightEdition_Control_pnCaption.GetString

class procedure Tkw_RightEdition_Control_pnCaption.RegisterInEngine;
//#UC START# *52A086150180_5252D867215B_var*
//#UC END# *52A086150180_5252D867215B_var*
begin
//#UC START# *52A086150180_5252D867215B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5252D867215B_impl*
end;//Tkw_RightEdition_Control_pnCaption.RegisterInEngine

procedure Tkw_RightEdition_Control_pnCaption_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BE24C12B9105_var*
//#UC END# *4DAEEDE10285_BE24C12B9105_var*
begin
//#UC START# *4DAEEDE10285_BE24C12B9105_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BE24C12B9105_impl*
end;//Tkw_RightEdition_Control_pnCaption_Push.DoDoIt

class function Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnCaption:push';
end;//Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionChoose';
end;//Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionChoose.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EAD4B54CACBA_var*
//#UC END# *4DDFD2EA0116_EAD4B54CACBA_var*
begin
//#UC START# *4DDFD2EA0116_EAD4B54CACBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EAD4B54CACBA_impl*
end;//Tkw_RightEdition_Control_EditionChoose.GetString

class procedure Tkw_RightEdition_Control_EditionChoose.RegisterInEngine;
//#UC START# *52A086150180_EAD4B54CACBA_var*
//#UC END# *52A086150180_EAD4B54CACBA_var*
begin
//#UC START# *52A086150180_EAD4B54CACBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EAD4B54CACBA_impl*
end;//Tkw_RightEdition_Control_EditionChoose.RegisterInEngine

procedure Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ADB2570AF60B_var*
//#UC END# *4DAEEDE10285_ADB2570AF60B_var*
begin
//#UC START# *4DAEEDE10285_ADB2570AF60B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ADB2570AF60B_impl*
end;//Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EditionChoose:push';
end;//Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister

class function Tkw_RightEdition_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_RightEdition_Control_Text.GetWordNameForRegister

function Tkw_RightEdition_Control_Text.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_69AFFFB9B3A0_var*
//#UC END# *4DDFD2EA0116_69AFFFB9B3A0_var*
begin
//#UC START# *4DDFD2EA0116_69AFFFB9B3A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_69AFFFB9B3A0_impl*
end;//Tkw_RightEdition_Control_Text.GetString

class procedure Tkw_RightEdition_Control_Text.RegisterInEngine;
//#UC START# *52A086150180_69AFFFB9B3A0_var*
//#UC END# *52A086150180_69AFFFB9B3A0_var*
begin
//#UC START# *52A086150180_69AFFFB9B3A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_69AFFFB9B3A0_impl*
end;//Tkw_RightEdition_Control_Text.RegisterInEngine

procedure Tkw_RightEdition_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6749336EDC1_var*
//#UC END# *4DAEEDE10285_A6749336EDC1_var*
begin
//#UC START# *4DAEEDE10285_A6749336EDC1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6749336EDC1_impl*
end;//Tkw_RightEdition_Control_Text_Push.DoDoIt

class function Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister

class function Tkw_RightEdition_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_RightEdition_Component_TextSource.GetWordNameForRegister

function Tkw_RightEdition_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_387F257C4B92_var*
//#UC END# *4DDFD2EA0116_387F257C4B92_var*
begin
//#UC START# *4DDFD2EA0116_387F257C4B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_387F257C4B92_impl*
end;//Tkw_RightEdition_Component_TextSource.GetString

class procedure Tkw_RightEdition_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_387F257C4B92_var*
//#UC END# *52A086150180_387F257C4B92_var*
begin
//#UC START# *52A086150180_387F257C4B92_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_387F257C4B92_impl*
end;//Tkw_RightEdition_Component_TextSource.RegisterInEngine

function TkwRightEditionFormHeader.Header(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.Header }
//#UC START# *26E3CABB4B89_AE860CA93B6E_var*
//#UC END# *26E3CABB4B89_AE860CA93B6E_var*
begin
//#UC START# *26E3CABB4B89_AE860CA93B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *26E3CABB4B89_AE860CA93B6E_impl*
end;//TkwRightEditionFormHeader.Header

procedure TkwRightEditionFormHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AE860CA93B6E_var*
//#UC END# *4DAEEDE10285_AE860CA93B6E_var*
begin
//#UC START# *4DAEEDE10285_AE860CA93B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AE860CA93B6E_impl*
end;//TkwRightEditionFormHeader.DoDoIt

class function TkwRightEditionFormHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.Header';
end;//TkwRightEditionFormHeader.GetWordNameForRegister

procedure TkwRightEditionFormHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AE860CA93B6E_var*
//#UC END# *52D00B00031A_AE860CA93B6E_var*
begin
//#UC START# *52D00B00031A_AE860CA93B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AE860CA93B6E_impl*
end;//TkwRightEditionFormHeader.SetValuePrim

function TkwRightEditionFormHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AE860CA93B6E_var*
//#UC END# *551544E2001A_AE860CA93B6E_var*
begin
//#UC START# *551544E2001A_AE860CA93B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AE860CA93B6E_impl*
end;//TkwRightEditionFormHeader.GetResultTypeInfo

function TkwRightEditionFormHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormHeader.GetAllParamsCount

function TkwRightEditionFormHeader.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AE860CA93B6E_var*
//#UC END# *5617F4D00243_AE860CA93B6E_var*
begin
//#UC START# *5617F4D00243_AE860CA93B6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AE860CA93B6E_impl*
end;//TkwRightEditionFormHeader.ParamsTypes

function TkwRightEditionFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.pnLeft }
//#UC START# *BE4C45D8DF9C_7E1E7EBF838A_var*
//#UC END# *BE4C45D8DF9C_7E1E7EBF838A_var*
begin
//#UC START# *BE4C45D8DF9C_7E1E7EBF838A_impl*
 !!! Needs to be implemented !!!
//#UC END# *BE4C45D8DF9C_7E1E7EBF838A_impl*
end;//TkwRightEditionFormPnLeft.pnLeft

procedure TkwRightEditionFormPnLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E1E7EBF838A_var*
//#UC END# *4DAEEDE10285_7E1E7EBF838A_var*
begin
//#UC START# *4DAEEDE10285_7E1E7EBF838A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7E1E7EBF838A_impl*
end;//TkwRightEditionFormPnLeft.DoDoIt

class function TkwRightEditionFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pnLeft';
end;//TkwRightEditionFormPnLeft.GetWordNameForRegister

procedure TkwRightEditionFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7E1E7EBF838A_var*
//#UC END# *52D00B00031A_7E1E7EBF838A_var*
begin
//#UC START# *52D00B00031A_7E1E7EBF838A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7E1E7EBF838A_impl*
end;//TkwRightEditionFormPnLeft.SetValuePrim

function TkwRightEditionFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7E1E7EBF838A_var*
//#UC END# *551544E2001A_7E1E7EBF838A_var*
begin
//#UC START# *551544E2001A_7E1E7EBF838A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7E1E7EBF838A_impl*
end;//TkwRightEditionFormPnLeft.GetResultTypeInfo

function TkwRightEditionFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPnLeft.GetAllParamsCount

function TkwRightEditionFormPnLeft.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7E1E7EBF838A_var*
//#UC END# *5617F4D00243_7E1E7EBF838A_var*
begin
//#UC START# *5617F4D00243_7E1E7EBF838A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7E1E7EBF838A_impl*
end;//TkwRightEditionFormPnLeft.ParamsTypes

function TkwRightEditionFormEditionLink.EditionLink(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtFocusLabel;
 {* ���������� ����� ������� .TRightEditionForm.EditionLink }
//#UC START# *BA269A730909_D2C7803A2AFF_var*
//#UC END# *BA269A730909_D2C7803A2AFF_var*
begin
//#UC START# *BA269A730909_D2C7803A2AFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA269A730909_D2C7803A2AFF_impl*
end;//TkwRightEditionFormEditionLink.EditionLink

procedure TkwRightEditionFormEditionLink.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D2C7803A2AFF_var*
//#UC END# *4DAEEDE10285_D2C7803A2AFF_var*
begin
//#UC START# *4DAEEDE10285_D2C7803A2AFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D2C7803A2AFF_impl*
end;//TkwRightEditionFormEditionLink.DoDoIt

class function TkwRightEditionFormEditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.EditionLink';
end;//TkwRightEditionFormEditionLink.GetWordNameForRegister

procedure TkwRightEditionFormEditionLink.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D2C7803A2AFF_var*
//#UC END# *52D00B00031A_D2C7803A2AFF_var*
begin
//#UC START# *52D00B00031A_D2C7803A2AFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D2C7803A2AFF_impl*
end;//TkwRightEditionFormEditionLink.SetValuePrim

function TkwRightEditionFormEditionLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D2C7803A2AFF_var*
//#UC END# *551544E2001A_D2C7803A2AFF_var*
begin
//#UC START# *551544E2001A_D2C7803A2AFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D2C7803A2AFF_impl*
end;//TkwRightEditionFormEditionLink.GetResultTypeInfo

function TkwRightEditionFormEditionLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormEditionLink.GetAllParamsCount

function TkwRightEditionFormEditionLink.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D2C7803A2AFF_var*
//#UC END# *5617F4D00243_D2C7803A2AFF_var*
begin
//#UC START# *5617F4D00243_D2C7803A2AFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D2C7803A2AFF_impl*
end;//TkwRightEditionFormEditionLink.ParamsTypes

function TkwRightEditionFormPbIcon.pbIcon(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TPaintBox;
 {* ���������� ����� ������� .TRightEditionForm.pbIcon }
//#UC START# *02860D7C7AA1_E1580AA1F7C8_var*
//#UC END# *02860D7C7AA1_E1580AA1F7C8_var*
begin
//#UC START# *02860D7C7AA1_E1580AA1F7C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *02860D7C7AA1_E1580AA1F7C8_impl*
end;//TkwRightEditionFormPbIcon.pbIcon

procedure TkwRightEditionFormPbIcon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E1580AA1F7C8_var*
//#UC END# *4DAEEDE10285_E1580AA1F7C8_var*
begin
//#UC START# *4DAEEDE10285_E1580AA1F7C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E1580AA1F7C8_impl*
end;//TkwRightEditionFormPbIcon.DoDoIt

class function TkwRightEditionFormPbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pbIcon';
end;//TkwRightEditionFormPbIcon.GetWordNameForRegister

procedure TkwRightEditionFormPbIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E1580AA1F7C8_var*
//#UC END# *52D00B00031A_E1580AA1F7C8_var*
begin
//#UC START# *52D00B00031A_E1580AA1F7C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E1580AA1F7C8_impl*
end;//TkwRightEditionFormPbIcon.SetValuePrim

function TkwRightEditionFormPbIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E1580AA1F7C8_var*
//#UC END# *551544E2001A_E1580AA1F7C8_var*
begin
//#UC START# *551544E2001A_E1580AA1F7C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E1580AA1F7C8_impl*
end;//TkwRightEditionFormPbIcon.GetResultTypeInfo

function TkwRightEditionFormPbIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPbIcon.GetAllParamsCount

function TkwRightEditionFormPbIcon.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E1580AA1F7C8_var*
//#UC END# *5617F4D00243_E1580AA1F7C8_var*
begin
//#UC START# *5617F4D00243_E1580AA1F7C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E1580AA1F7C8_impl*
end;//TkwRightEditionFormPbIcon.ParamsTypes

function TkwRightEditionFormPnCaption.pnCaption(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TvtPanel;
 {* ���������� ����� ������� .TRightEditionForm.pnCaption }
//#UC START# *C3C1B12CA022_AE83AF2A976A_var*
//#UC END# *C3C1B12CA022_AE83AF2A976A_var*
begin
//#UC START# *C3C1B12CA022_AE83AF2A976A_impl*
 !!! Needs to be implemented !!!
//#UC END# *C3C1B12CA022_AE83AF2A976A_impl*
end;//TkwRightEditionFormPnCaption.pnCaption

procedure TkwRightEditionFormPnCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AE83AF2A976A_var*
//#UC END# *4DAEEDE10285_AE83AF2A976A_var*
begin
//#UC START# *4DAEEDE10285_AE83AF2A976A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AE83AF2A976A_impl*
end;//TkwRightEditionFormPnCaption.DoDoIt

class function TkwRightEditionFormPnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.pnCaption';
end;//TkwRightEditionFormPnCaption.GetWordNameForRegister

procedure TkwRightEditionFormPnCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AE83AF2A976A_var*
//#UC END# *52D00B00031A_AE83AF2A976A_var*
begin
//#UC START# *52D00B00031A_AE83AF2A976A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AE83AF2A976A_impl*
end;//TkwRightEditionFormPnCaption.SetValuePrim

function TkwRightEditionFormPnCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AE83AF2A976A_var*
//#UC END# *551544E2001A_AE83AF2A976A_var*
begin
//#UC START# *551544E2001A_AE83AF2A976A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AE83AF2A976A_impl*
end;//TkwRightEditionFormPnCaption.GetResultTypeInfo

function TkwRightEditionFormPnCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormPnCaption.GetAllParamsCount

function TkwRightEditionFormPnCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AE83AF2A976A_var*
//#UC END# *5617F4D00243_AE83AF2A976A_var*
begin
//#UC START# *5617F4D00243_AE83AF2A976A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AE83AF2A976A_impl*
end;//TkwRightEditionFormPnCaption.ParamsTypes

function TkwRightEditionFormText.Text(const aCtx: TtfwContext;
 aRightEditionForm: TRightEditionForm): TnscEditor;
 {* ���������� ����� ������� .TRightEditionForm.Text }
//#UC START# *31C1B3653D64_39642DBB84EF_var*
//#UC END# *31C1B3653D64_39642DBB84EF_var*
begin
//#UC START# *31C1B3653D64_39642DBB84EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *31C1B3653D64_39642DBB84EF_impl*
end;//TkwRightEditionFormText.Text

procedure TkwRightEditionFormText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_39642DBB84EF_var*
//#UC END# *4DAEEDE10285_39642DBB84EF_var*
begin
//#UC START# *4DAEEDE10285_39642DBB84EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_39642DBB84EF_impl*
end;//TkwRightEditionFormText.DoDoIt

class function TkwRightEditionFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRightEditionForm.Text';
end;//TkwRightEditionFormText.GetWordNameForRegister

procedure TkwRightEditionFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_39642DBB84EF_var*
//#UC END# *52D00B00031A_39642DBB84EF_var*
begin
//#UC START# *52D00B00031A_39642DBB84EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_39642DBB84EF_impl*
end;//TkwRightEditionFormText.SetValuePrim

function TkwRightEditionFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_39642DBB84EF_var*
//#UC END# *551544E2001A_39642DBB84EF_var*
begin
//#UC START# *551544E2001A_39642DBB84EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_39642DBB84EF_impl*
end;//TkwRightEditionFormText.GetResultTypeInfo

function TkwRightEditionFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRightEditionFormText.GetAllParamsCount

function TkwRightEditionFormText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_39642DBB84EF_var*
//#UC END# *5617F4D00243_39642DBB84EF_var*
begin
//#UC START# *5617F4D00243_39642DBB84EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_39642DBB84EF_impl*
end;//TkwRightEditionFormText.ParamsTypes

initialization
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRightEditionForm));
 {* ����������� ���� RightEdition }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* ����������� ���� TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
