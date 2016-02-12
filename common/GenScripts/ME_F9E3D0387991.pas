unit LeftEditionKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы LeftEdition }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\LeftEditionKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
 Tkw_Form_LeftEdition = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы LeftEdition
----
*Пример использования*:
[code]
'aControl' форма::LeftEdition TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_LeftEdition

 Tkw_LeftEdition_Control_Header = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Header
----
*Пример использования*:
[code]
контрол::Header TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_Header

 Tkw_LeftEdition_Control_Header_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Header
----
*Пример использования*:
[code]
контрол::Header:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_Header_Push

 Tkw_LeftEdition_Control_pnLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_pnLeft

 Tkw_LeftEdition_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_pnLeft_Push

 Tkw_LeftEdition_Control_EditionLink = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EditionLink
----
*Пример использования*:
[code]
контрол::EditionLink TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_EditionLink

 Tkw_LeftEdition_Control_EditionLink_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EditionLink
----
*Пример использования*:
[code]
контрол::EditionLink:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_EditionLink_Push

 Tkw_LeftEdition_Control_pbIcon = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbIcon
----
*Пример использования*:
[code]
контрол::pbIcon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_pbIcon

 Tkw_LeftEdition_Control_pbIcon_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbIcon
----
*Пример использования*:
[code]
контрол::pbIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_pbIcon_Push

 Tkw_LeftEdition_Control_pnCaption = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnCaption
----
*Пример использования*:
[code]
контрол::pnCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_pnCaption

 Tkw_LeftEdition_Control_pnCaption_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnCaption
----
*Пример использования*:
[code]
контрол::pnCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_pnCaption_Push

 Tkw_LeftEdition_Control_EditionChoose = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EditionChoose
----
*Пример использования*:
[code]
контрол::EditionChoose TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_EditionChoose

 Tkw_LeftEdition_Control_EditionChoose_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EditionChoose
----
*Пример использования*:
[code]
контрол::EditionChoose:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_EditionChoose_Push

 Tkw_LeftEdition_Control_Text = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Control_Text

 Tkw_LeftEdition_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LeftEdition_Control_Text_Push

 Tkw_LeftEdition_Component_TextSource = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LeftEdition_Component_TextSource

 TkwLeftEditionFormHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.Header
[panel]Контрол Header формы TLeftEditionForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.Header >>> l_TvtPanel
[code]  }
  private
   function Header(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TvtPanel;
    {* Реализация слова скрипта .TLeftEditionForm.Header }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormHeader

 TkwLeftEditionFormPnLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.pnLeft
[panel]Контрол pnLeft формы TLeftEditionForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.pnLeft >>> l_TvtPanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TvtPanel;
    {* Реализация слова скрипта .TLeftEditionForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormPnLeft

 TkwLeftEditionFormEditionLink = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.EditionLink
[panel]Контрол EditionLink формы TLeftEditionForm[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLeftEditionForm .TLeftEditionForm.EditionLink >>> l_TvtFocusLabel
[code]  }
  private
   function EditionLink(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TvtFocusLabel;
    {* Реализация слова скрипта .TLeftEditionForm.EditionLink }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormEditionLink

 TkwLeftEditionFormPbIcon = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.pbIcon
[panel]Контрол pbIcon формы TLeftEditionForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aLeftEditionForm .TLeftEditionForm.pbIcon >>> l_TPaintBox
[code]  }
  private
   function pbIcon(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TPaintBox;
    {* Реализация слова скрипта .TLeftEditionForm.pbIcon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormPbIcon

 TkwLeftEditionFormPnCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.pnCaption
[panel]Контрол pnCaption формы TLeftEditionForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.pnCaption >>> l_TvtPanel
[code]  }
  private
   function pnCaption(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TvtPanel;
    {* Реализация слова скрипта .TLeftEditionForm.pnCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormPnCaption

 TkwLeftEditionFormText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLeftEditionForm.Text
[panel]Контрол Text формы TLeftEditionForm[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aLeftEditionForm .TLeftEditionForm.Text >>> l_TnscEditor
[code]  }
  private
   function Text(const aCtx: TtfwContext;
    aLeftEditionForm: TLeftEditionForm): TnscEditor;
    {* Реализация слова скрипта .TLeftEditionForm.Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLeftEditionFormText

class function Tkw_Form_LeftEdition.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::LeftEdition';
end;//Tkw_Form_LeftEdition.GetWordNameForRegister

function Tkw_Form_LeftEdition.GetString: AnsiString;
begin
 Result := 'LeftEditionForm';
end;//Tkw_Form_LeftEdition.GetString

class function Tkw_LeftEdition_Control_Header.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Header';
end;//Tkw_LeftEdition_Control_Header.GetWordNameForRegister

function Tkw_LeftEdition_Control_Header.GetString: AnsiString;
begin
 Result := 'Header';
end;//Tkw_LeftEdition_Control_Header.GetString

class procedure Tkw_LeftEdition_Control_Header.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_Header.RegisterInEngine

procedure Tkw_LeftEdition_Control_Header_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_59773F4EFA4D_var*
//#UC END# *4DAEEDE10285_59773F4EFA4D_var*
begin
//#UC START# *4DAEEDE10285_59773F4EFA4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_59773F4EFA4D_impl*
end;//Tkw_LeftEdition_Control_Header_Push.DoDoIt

class function Tkw_LeftEdition_Control_Header_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Header:push';
end;//Tkw_LeftEdition_Control_Header_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft';
end;//Tkw_LeftEdition_Control_pnLeft.GetWordNameForRegister

function Tkw_LeftEdition_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_LeftEdition_Control_pnLeft.GetString

class procedure Tkw_LeftEdition_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_pnLeft.RegisterInEngine

procedure Tkw_LeftEdition_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB7BEFDBF522_var*
//#UC END# *4DAEEDE10285_CB7BEFDBF522_var*
begin
//#UC START# *4DAEEDE10285_CB7BEFDBF522_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB7BEFDBF522_impl*
end;//Tkw_LeftEdition_Control_pnLeft_Push.DoDoIt

class function Tkw_LeftEdition_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_LeftEdition_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_EditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditionLink';
end;//Tkw_LeftEdition_Control_EditionLink.GetWordNameForRegister

function Tkw_LeftEdition_Control_EditionLink.GetString: AnsiString;
begin
 Result := 'EditionLink';
end;//Tkw_LeftEdition_Control_EditionLink.GetString

class procedure Tkw_LeftEdition_Control_EditionLink.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_LeftEdition_Control_EditionLink.RegisterInEngine

procedure Tkw_LeftEdition_Control_EditionLink_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6C806A6EC517_var*
//#UC END# *4DAEEDE10285_6C806A6EC517_var*
begin
//#UC START# *4DAEEDE10285_6C806A6EC517_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6C806A6EC517_impl*
end;//Tkw_LeftEdition_Control_EditionLink_Push.DoDoIt

class function Tkw_LeftEdition_Control_EditionLink_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditionLink:push';
end;//Tkw_LeftEdition_Control_EditionLink_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_pbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIcon';
end;//Tkw_LeftEdition_Control_pbIcon.GetWordNameForRegister

function Tkw_LeftEdition_Control_pbIcon.GetString: AnsiString;
begin
 Result := 'pbIcon';
end;//Tkw_LeftEdition_Control_pbIcon.GetString

class procedure Tkw_LeftEdition_Control_pbIcon.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_LeftEdition_Control_pbIcon.RegisterInEngine

procedure Tkw_LeftEdition_Control_pbIcon_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_279784090AE0_var*
//#UC END# *4DAEEDE10285_279784090AE0_var*
begin
//#UC START# *4DAEEDE10285_279784090AE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_279784090AE0_impl*
end;//Tkw_LeftEdition_Control_pbIcon_Push.DoDoIt

class function Tkw_LeftEdition_Control_pbIcon_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIcon:push';
end;//Tkw_LeftEdition_Control_pbIcon_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_pnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnCaption';
end;//Tkw_LeftEdition_Control_pnCaption.GetWordNameForRegister

function Tkw_LeftEdition_Control_pnCaption.GetString: AnsiString;
begin
 Result := 'pnCaption';
end;//Tkw_LeftEdition_Control_pnCaption.GetString

class procedure Tkw_LeftEdition_Control_pnCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_pnCaption.RegisterInEngine

procedure Tkw_LeftEdition_Control_pnCaption_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_646256617EFD_var*
//#UC END# *4DAEEDE10285_646256617EFD_var*
begin
//#UC START# *4DAEEDE10285_646256617EFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_646256617EFD_impl*
end;//Tkw_LeftEdition_Control_pnCaption_Push.DoDoIt

class function Tkw_LeftEdition_Control_pnCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnCaption:push';
end;//Tkw_LeftEdition_Control_pnCaption_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_EditionChoose.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditionChoose';
end;//Tkw_LeftEdition_Control_EditionChoose.GetWordNameForRegister

function Tkw_LeftEdition_Control_EditionChoose.GetString: AnsiString;
begin
 Result := 'EditionChoose';
end;//Tkw_LeftEdition_Control_EditionChoose.GetString

class procedure Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine

procedure Tkw_LeftEdition_Control_EditionChoose_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB34B6592D45_var*
//#UC END# *4DAEEDE10285_CB34B6592D45_var*
begin
//#UC START# *4DAEEDE10285_CB34B6592D45_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB34B6592D45_impl*
end;//Tkw_LeftEdition_Control_EditionChoose_Push.DoDoIt

class function Tkw_LeftEdition_Control_EditionChoose_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EditionChoose:push';
end;//Tkw_LeftEdition_Control_EditionChoose_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text';
end;//Tkw_LeftEdition_Control_Text.GetWordNameForRegister

function Tkw_LeftEdition_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_LeftEdition_Control_Text.GetString

class procedure Tkw_LeftEdition_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_LeftEdition_Control_Text.RegisterInEngine

procedure Tkw_LeftEdition_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B41D8E3EF18D_var*
//#UC END# *4DAEEDE10285_B41D8E3EF18D_var*
begin
//#UC START# *4DAEEDE10285_B41D8E3EF18D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B41D8E3EF18D_impl*
end;//Tkw_LeftEdition_Control_Text_Push.DoDoIt

class function Tkw_LeftEdition_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Text:push';
end;//Tkw_LeftEdition_Control_Text_Push.GetWordNameForRegister

class function Tkw_LeftEdition_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::TextSource';
end;//Tkw_LeftEdition_Component_TextSource.GetWordNameForRegister

function Tkw_LeftEdition_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_LeftEdition_Component_TextSource.GetString

class procedure Tkw_LeftEdition_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_LeftEdition_Component_TextSource.RegisterInEngine

function TkwLeftEditionFormHeader.Header(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {* Реализация слова скрипта .TLeftEditionForm.Header }
begin
 Result := aLeftEditionForm.Header;
end;//TkwLeftEditionFormHeader.Header

procedure TkwLeftEditionFormHeader.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Header(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormHeader.DoDoIt

class function TkwLeftEditionFormHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.Header';
end;//TkwLeftEditionFormHeader.GetWordNameForRegister

procedure TkwLeftEditionFormHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Header', aCtx);
end;//TkwLeftEditionFormHeader.SetValuePrim

function TkwLeftEditionFormHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormHeader.GetResultTypeInfo

function TkwLeftEditionFormHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormHeader.GetAllParamsCount

function TkwLeftEditionFormHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormHeader.ParamsTypes

function TkwLeftEditionFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {* Реализация слова скрипта .TLeftEditionForm.pnLeft }
begin
 Result := aLeftEditionForm.pnLeft;
end;//TkwLeftEditionFormPnLeft.pnLeft

procedure TkwLeftEditionFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormPnLeft.DoDoIt

class function TkwLeftEditionFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.pnLeft';
end;//TkwLeftEditionFormPnLeft.GetWordNameForRegister

procedure TkwLeftEditionFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwLeftEditionFormPnLeft.SetValuePrim

function TkwLeftEditionFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormPnLeft.GetResultTypeInfo

function TkwLeftEditionFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormPnLeft.GetAllParamsCount

function TkwLeftEditionFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPnLeft.ParamsTypes

function TkwLeftEditionFormEditionLink.EditionLink(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TvtFocusLabel;
 {* Реализация слова скрипта .TLeftEditionForm.EditionLink }
begin
 Result := aLeftEditionForm.EditionLink;
end;//TkwLeftEditionFormEditionLink.EditionLink

procedure TkwLeftEditionFormEditionLink.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EditionLink(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormEditionLink.DoDoIt

class function TkwLeftEditionFormEditionLink.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.EditionLink';
end;//TkwLeftEditionFormEditionLink.GetWordNameForRegister

procedure TkwLeftEditionFormEditionLink.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EditionLink', aCtx);
end;//TkwLeftEditionFormEditionLink.SetValuePrim

function TkwLeftEditionFormEditionLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLeftEditionFormEditionLink.GetResultTypeInfo

function TkwLeftEditionFormEditionLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormEditionLink.GetAllParamsCount

function TkwLeftEditionFormEditionLink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormEditionLink.ParamsTypes

function TkwLeftEditionFormPbIcon.pbIcon(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TPaintBox;
 {* Реализация слова скрипта .TLeftEditionForm.pbIcon }
begin
 Result := aLeftEditionForm.pbIcon;
end;//TkwLeftEditionFormPbIcon.pbIcon

procedure TkwLeftEditionFormPbIcon.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbIcon(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormPbIcon.DoDoIt

class function TkwLeftEditionFormPbIcon.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.pbIcon';
end;//TkwLeftEditionFormPbIcon.GetWordNameForRegister

procedure TkwLeftEditionFormPbIcon.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbIcon', aCtx);
end;//TkwLeftEditionFormPbIcon.SetValuePrim

function TkwLeftEditionFormPbIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLeftEditionFormPbIcon.GetResultTypeInfo

function TkwLeftEditionFormPbIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormPbIcon.GetAllParamsCount

function TkwLeftEditionFormPbIcon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPbIcon.ParamsTypes

function TkwLeftEditionFormPnCaption.pnCaption(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {* Реализация слова скрипта .TLeftEditionForm.pnCaption }
begin
 Result := aLeftEditionForm.pnCaption;
end;//TkwLeftEditionFormPnCaption.pnCaption

procedure TkwLeftEditionFormPnCaption.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnCaption(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormPnCaption.DoDoIt

class function TkwLeftEditionFormPnCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.pnCaption';
end;//TkwLeftEditionFormPnCaption.GetWordNameForRegister

procedure TkwLeftEditionFormPnCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnCaption', aCtx);
end;//TkwLeftEditionFormPnCaption.SetValuePrim

function TkwLeftEditionFormPnCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormPnCaption.GetResultTypeInfo

function TkwLeftEditionFormPnCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormPnCaption.GetAllParamsCount

function TkwLeftEditionFormPnCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPnCaption.ParamsTypes

function TkwLeftEditionFormText.Text(const aCtx: TtfwContext;
 aLeftEditionForm: TLeftEditionForm): TnscEditor;
 {* Реализация слова скрипта .TLeftEditionForm.Text }
begin
 Result := aLeftEditionForm.Text;
end;//TkwLeftEditionFormText.Text

procedure TkwLeftEditionFormText.DoDoIt(const aCtx: TtfwContext);
var l_aLeftEditionForm: TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aLeftEditionForm));
end;//TkwLeftEditionFormText.DoDoIt

class function TkwLeftEditionFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLeftEditionForm.Text';
end;//TkwLeftEditionFormText.GetWordNameForRegister

procedure TkwLeftEditionFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwLeftEditionFormText.SetValuePrim

function TkwLeftEditionFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwLeftEditionFormText.GetResultTypeInfo

function TkwLeftEditionFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwLeftEditionFormText.GetAllParamsCount

function TkwLeftEditionFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormText.ParamsTypes

initialization
 Tkw_Form_LeftEdition.RegisterInEngine;
 {* Регистрация Tkw_Form_LeftEdition }
 Tkw_LeftEdition_Control_Header.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_Header }
 Tkw_LeftEdition_Control_Header_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_Header_Push }
 Tkw_LeftEdition_Control_pnLeft.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pnLeft }
 Tkw_LeftEdition_Control_pnLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pnLeft_Push }
 Tkw_LeftEdition_Control_EditionLink.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_EditionLink }
 Tkw_LeftEdition_Control_EditionLink_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_EditionLink_Push }
 Tkw_LeftEdition_Control_pbIcon.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pbIcon }
 Tkw_LeftEdition_Control_pbIcon_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pbIcon_Push }
 Tkw_LeftEdition_Control_pnCaption.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pnCaption }
 Tkw_LeftEdition_Control_pnCaption_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_pnCaption_Push }
 Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_EditionChoose }
 Tkw_LeftEdition_Control_EditionChoose_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_EditionChoose_Push }
 Tkw_LeftEdition_Control_Text.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_Text }
 Tkw_LeftEdition_Control_Text_Push.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Control_Text_Push }
 Tkw_LeftEdition_Component_TextSource.RegisterInEngine;
 {* Регистрация Tkw_LeftEdition_Component_TextSource }
 TkwLeftEditionFormHeader.RegisterInEngine;
 {* Регистрация LeftEditionForm_Header }
 TkwLeftEditionFormPnLeft.RegisterInEngine;
 {* Регистрация LeftEditionForm_pnLeft }
 TkwLeftEditionFormEditionLink.RegisterInEngine;
 {* Регистрация LeftEditionForm_EditionLink }
 TkwLeftEditionFormPbIcon.RegisterInEngine;
 {* Регистрация LeftEditionForm_pbIcon }
 TkwLeftEditionFormPnCaption.RegisterInEngine;
 {* Регистрация LeftEditionForm_pnCaption }
 TkwLeftEditionFormText.RegisterInEngine;
 {* Регистрация LeftEditionForm_Text }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLeftEditionForm));
 {* Регистрация типа LeftEdition }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
