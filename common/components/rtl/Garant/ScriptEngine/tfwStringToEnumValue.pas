unit tfwStringToEnumValue;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStringToEnumValue.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStringToEnumValue" MUID: (553132CA032A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwStringToEnumValue = class(TtfwRegisterableWordPrim)
  private
   f_TypeInfo: PTypeInfo;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   class procedure Register(aTypeInfo: PTypeInfo);
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TtfwStringToEnumValue
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

class procedure TtfwStringToEnumValue.Register(aTypeInfo: PTypeInfo);
//#UC START# *55313331027C_553132CA032A_var*
var
 l_Inst : TtfwStringToEnumValue;
//#UC END# *55313331027C_553132CA032A_var*
begin
//#UC START# *55313331027C_553132CA032A_impl*
 l_Inst := Create;
 try
  l_Inst.f_TypeInfo := aTypeInfo;
  l_Inst.RegisterInstance(aTypeInfo.Name + ':NameToValue');
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *55313331027C_553132CA032A_impl*
end;//TtfwStringToEnumValue.Register

procedure TtfwStringToEnumValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_553132CA032A_var*
//#UC END# *4DAEEDE10285_553132CA032A_var*
begin
//#UC START# *4DAEEDE10285_553132CA032A_impl*
 aCtx.rEngine.PushInt(GetEnumValue(f_TypeInfo, aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_553132CA032A_impl*
end;//TtfwStringToEnumValue.DoDoIt

function TtfwStringToEnumValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_553132CA032A_var*
//#UC END# *551544E2001A_553132CA032A_var*
begin
//#UC START# *551544E2001A_553132CA032A_impl*
 Result := f_TypeInfo; 
//#UC END# *551544E2001A_553132CA032A_impl*
end;//TtfwStringToEnumValue.GetResultTypeInfo

initialization
 TtfwStringToEnumValue.RegisterClass;
 {* Регистрация TtfwStringToEnumValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
