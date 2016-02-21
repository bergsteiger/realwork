unit kwOk;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwOk.pas"
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
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}
 TkwOk = class(_F1Test_)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOk
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , nsConst
 , bsTypesNew
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1Test.imp.pas}

procedure TkwOk.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF1DD9017F_var*
//#UC END# *4DAEEDE10285_4DAF1DD9017F_var*
begin
//#UC START# *4DAEEDE10285_4DAF1DD9017F_impl*
 aCtx.rCaller.Check(vcmDispatcher.EntityOperation(TdmStdRes.opcode_Result_OkExt, vcmParams), 'Операция Result OkExt не выполнилась');
//#UC END# *4DAEEDE10285_4DAF1DD9017F_impl*
end;//TkwOk.DoDoIt

class function TkwOk.GetWordNameForRegister: AnsiString;
begin
 Result := 'Ok';
end;//TkwOk.GetWordNameForRegister

initialization
 TkwOk.RegisterInEngine;
 {* Регистрация Ok }
{$IfEnd} // NOT Defined(NoScripts)

end.
