unit kwFiltersList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwFiltersList.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}
 TkwFiltersList = class(_VCMWord_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwFiltersList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwAnswer
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

procedure TkwFiltersList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DBA9CE301B4_var*
//#UC END# *4DAEEDE10285_4DBA9CE301B4_var*
begin
//#UC START# *4DAEEDE10285_4DBA9CE301B4_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Filters_FiltersListOpen, vcmParams));
//#UC END# *4DAEEDE10285_4DBA9CE301B4_impl*
end;//TkwFiltersList.DoDoIt

class function TkwFiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := 'filters:Open';
end;//TkwFiltersList.GetWordNameForRegister

initialization
 TkwFiltersList.RegisterInEngine;
 {* Регистрация TkwFiltersList }
{$IfEnd} // NOT Defined(NoScripts)

end.
