unit tfwString;
 {* Базовый предок для добавления слов в словарь. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwString.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwString" MUID: (4DDFD1430390)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwString = {abstract} class(TtfwRegisterableWord)
  {* Базовый предок для добавления слов в словарь. }
  protected
   function GetString: AnsiString; virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TtfwString
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwScriptingTypes
;

function TtfwString.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4DDFD1430390_var*
//#UC END# *4DDFD2EA0116_4DDFD1430390_var*
begin
//#UC START# *4DDFD2EA0116_4DDFD1430390_impl*
 Result := '';
 Assert(false);
//#UC END# *4DDFD2EA0116_4DDFD1430390_impl*
end;//TtfwString.GetString

procedure TtfwString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DDFD1430390_var*
//#UC END# *4DAEEDE10285_4DDFD1430390_var*
begin
//#UC START# *4DAEEDE10285_4DDFD1430390_impl*
 aCtx.rEngine.PushString(TtfwCStringFactory.C(GetString));
//#UC END# *4DAEEDE10285_4DDFD1430390_impl*
end;//TtfwString.DoDoIt

function TtfwString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DDFD1430390_var*
//#UC END# *551544E2001A_4DDFD1430390_var*
begin
//#UC START# *551544E2001A_4DDFD1430390_impl*
 Result := @tfw_tiString;
//#UC END# *551544E2001A_4DDFD1430390_impl*
end;//TtfwString.GetResultTypeInfo

initialization
 TtfwString.RegisterClass;
 {* Регистрация TtfwString }
{$IfEnd} // NOT Defined(NoScripts)

end.
