unit tfwIntegerToEnumName;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerToEnumName.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwIntegerToEnumName = class(TtfwRegisterableWordPrim)
  private
   f_TypeInfo: PTypeInfo;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   class procedure Register(aTypeInfo: PTypeInfo);
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TtfwIntegerToEnumName
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , tfwStringToEnumValue
;

class procedure TtfwIntegerToEnumName.Register(aTypeInfo: PTypeInfo);
//#UC START# *553129980377_553128CE018D_var*
var
 l_Inst : TtfwIntegerToEnumName;
//#UC END# *553129980377_553128CE018D_var*
begin
//#UC START# *553129980377_553128CE018D_impl*
 l_Inst := Create;
 try
  l_Inst.f_TypeInfo := aTypeInfo;
  l_Inst.RegisterInstance(aTypeInfo.Name + ':ValueToName');
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
 TtfwStringToEnumValue.Register(aTypeInfo);
//#UC END# *553129980377_553128CE018D_impl*
end;//TtfwIntegerToEnumName.Register

procedure TtfwIntegerToEnumName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_553128CE018D_var*
//#UC END# *4DAEEDE10285_553128CE018D_var*
begin
//#UC START# *4DAEEDE10285_553128CE018D_impl*
 aCtx.rEngine.PushString(GetEnumName(f_TypeInfo, aCtx.rEngine.PopInt));
//#UC END# *4DAEEDE10285_553128CE018D_impl*
end;//TtfwIntegerToEnumName.DoDoIt

function TtfwIntegerToEnumName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_553128CE018D_var*
//#UC END# *551544E2001A_553128CE018D_var*
begin
//#UC START# *551544E2001A_553128CE018D_impl*
 Result := TypeInfo(String); 
//#UC END# *551544E2001A_553128CE018D_impl*
end;//TtfwIntegerToEnumName.GetResultTypeInfo

initialization
 TtfwIntegerToEnumName.RegisterClass;
 {* Регистрация TtfwIntegerToEnumName }
{$IfEnd} // NOT Defined(NoScripts)

end.
