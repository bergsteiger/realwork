unit kwVcmOpImageIndex;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwVcmOpImageIndex.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "vcm_op_ImageIndex" MUID: (523018AA0227)
// Имя типа: "TkwVcmOpImageIndex"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpImageIndex = {final} class(TkwOperationParamWordPrim)
  protected
   procedure DoParams(const aParams: IvcmTestParams;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwVcmOpImageIndex
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
;

procedure TkwVcmOpImageIndex.DoParams(const aParams: IvcmTestParams;
 const aCtx: TtfwContext);
//#UC START# *5230185F0140_523018AA0227_var*
//#UC END# *5230185F0140_523018AA0227_var*
begin
//#UC START# *5230185F0140_523018AA0227_impl*
 aCtx.rEngine.PushInt(aParams.Op.ImageIndex);
//#UC END# *5230185F0140_523018AA0227_impl*
end;//TkwVcmOpImageIndex.DoParams

class function TkwVcmOpImageIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:op:ImageIndex';
end;//TkwVcmOpImageIndex.GetWordNameForRegister

initialization
 TkwVcmOpImageIndex.RegisterInEngine;
 {* Регистрация vcm_op_ImageIndex }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
