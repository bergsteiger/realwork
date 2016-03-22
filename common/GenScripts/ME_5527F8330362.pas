unit tfwTypeRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypeRegistrator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTypeRegistrator" MUID: (5527F8330362)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TypInfo
;

type
 TtfwTypeRegistrator = class
  private
   class procedure RegisterColorValue(const aValue: AnsiString);
   class procedure RegisterCharsetValue(const aValue: AnsiString);
  public
   class function RegisterType(aTypeInfo: PTypeInfo): Boolean;
 end;//TtfwTypeRegistrator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwEnumRegistrator
 , tfwClassRef
 , tfwInterfaceRegistrator
 , tfwTypeModifier
 , tfwEnumConstantRegistrator
 , Graphics
;

class function TtfwTypeRegistrator.RegisterType(aTypeInfo: PTypeInfo): Boolean;
//#UC START# *5527F84D01B5_5527F8330362_var*
//#UC END# *5527F84D01B5_5527F8330362_var*
begin
//#UC START# *5527F84D01B5_5527F8330362_impl*
 Result := false;
 if (aTypeInfo <> nil) then
 begin
  Case aTypeInfo.Kind of
   tkUnknown:
    // - ничего не регистрируем
    ;
   tkClass:
    Result := TtfwClassRef.Register(GetTypeData(aTypeInfo).ClassType);
   tkEnumeration:
    Result := TtfwEnumRegistrator.RegisterEnum(aTypeInfo);
   tkInterface:
    Result := TtfwInterfaceRegistrator.RegisterInterface(aTypeInfo);
   tkInteger:
    Result := TtfwTypeModifier.RegisterTypeModifier(aTypeInfo);
   tkString:
    Result := TtfwTypeModifier.RegisterTypeModifier(aTypeInfo);
   else
    Result := TtfwTypeModifier.RegisterTypeModifier(aTypeInfo);
  end;//Case aTypeInfo.Kind
  if Result then
  begin
   if (aTypeInfo = TypeInfo(TColor)) then
    GetColorValues(RegisterColorValue)
   else
   if (aTypeInfo = TypeInfo(TFontCharset)) then
    GetCharsetValues(RegisterCharsetValue);
  end;//Result
 end;//aTypeInfo <> nil
//#UC END# *5527F84D01B5_5527F8330362_impl*
end;//TtfwTypeRegistrator.RegisterType

class procedure TtfwTypeRegistrator.RegisterColorValue(const aValue: AnsiString);
//#UC START# *55C361080119_5527F8330362_var*
var
 l_TI : PTypeInfo;
//#UC END# *55C361080119_5527F8330362_var*
begin
//#UC START# *55C361080119_5527F8330362_impl*
 l_TI := TypeInfo(TColor);
 TtfwEnumConstantRegistrator.Register(l_TI.Name + '::' + aValue, StringToColor(aValue), l_TI);
//#UC END# *55C361080119_5527F8330362_impl*
end;//TtfwTypeRegistrator.RegisterColorValue

class procedure TtfwTypeRegistrator.RegisterCharsetValue(const aValue: AnsiString);
//#UC START# *55C48B0D0230_5527F8330362_var*
var
 l_TI : PTypeInfo;
 l_Index : Integer;
//#UC END# *55C48B0D0230_5527F8330362_var*
begin
//#UC START# *55C48B0D0230_5527F8330362_impl*
 l_TI := TypeInfo(TFontCharset);
 IdentToCharset(aValue, l_Index);
 TtfwEnumConstantRegistrator.Register(l_TI.Name + '::' + aValue, l_Index, l_TI);
//#UC END# *55C48B0D0230_5527F8330362_impl*
end;//TtfwTypeRegistrator.RegisterCharsetValue
{$IfEnd} // NOT Defined(NoScripts)

end.
