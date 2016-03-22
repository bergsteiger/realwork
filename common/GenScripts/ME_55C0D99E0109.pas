unit tfwEnumConstantRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwEnumConstantRegistrator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwEnumConstantRegistrator" MUID: (55C0D99E0109)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIntegerConstantRegistrator
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwEnumConstantRegistrator = class(TtfwIntegerConstantRegistrator)
  private
   f_TypeInfo: PTypeInfo;
  protected
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   constructor Create(aValue: Integer;
    aTypeInfo: PTypeInfo); reintroduce;
   class procedure Register(const aName: AnsiString;
    aValue: Integer;
    aTypeInfo: PTypeInfo);
 end;//TtfwEnumConstantRegistrator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwEnumConstantRegistrator.Create(aValue: Integer;
 aTypeInfo: PTypeInfo);
//#UC START# *55C0DA200397_55C0D99E0109_var*
//#UC END# *55C0DA200397_55C0D99E0109_var*
begin
//#UC START# *55C0DA200397_55C0D99E0109_impl*
 inherited Create(aValue);
 f_TypeInfo := aTypeInfo;
//#UC END# *55C0DA200397_55C0D99E0109_impl*
end;//TtfwEnumConstantRegistrator.Create

class procedure TtfwEnumConstantRegistrator.Register(const aName: AnsiString;
 aValue: Integer;
 aTypeInfo: PTypeInfo);
//#UC START# *55C0DA7C026A_55C0D99E0109_var*
var
 l_Inst : TtfwEnumConstantRegistrator;
//#UC END# *55C0DA7C026A_55C0D99E0109_var*
begin
//#UC START# *55C0DA7C026A_55C0D99E0109_impl*
 l_Inst := Create(aValue, aTypeInfo);
 try
  l_Inst.RegisterInstance(aName);
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *55C0DA7C026A_55C0D99E0109_impl*
end;//TtfwEnumConstantRegistrator.Register

function TtfwEnumConstantRegistrator.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_55C0D99E0109get_var*
//#UC END# *52CFC11603C8_55C0D99E0109get_var*
begin
//#UC START# *52CFC11603C8_55C0D99E0109get_impl*
 Result := TtfwWordInfo.Make(f_TypeInfo);
//#UC END# *52CFC11603C8_55C0D99E0109get_impl*
end;//TtfwEnumConstantRegistrator.pm_GetResultTypeInfo

initialization
 TtfwEnumConstantRegistrator.RegisterInEngine;
 {* Регистрация TtfwEnumConstantRegistrator }
{$IfEnd} // NOT Defined(NoScripts)

end.
