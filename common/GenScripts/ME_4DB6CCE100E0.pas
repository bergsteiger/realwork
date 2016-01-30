unit kwInteger;
 {* Зарезервированное слово Interger }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwInteger.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
;

type
 TkwInteger = class(TtfwWord)
  {* Зарезервированное слово Interger }
  private
   f_Value: Integer;
    {* Поле для свойства Value }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   constructor Create(aValue: Integer); reintroduce;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function WordName: Il3CString; override;
  public
   property Value: Integer
    read f_Value;
 end;//TkwInteger
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TkwInteger.Create(aValue: Integer);
//#UC START# *4DB6CD0F02C5_4DB6CCE100E0_var*
//#UC END# *4DB6CD0F02C5_4DB6CCE100E0_var*
begin
//#UC START# *4DB6CD0F02C5_4DB6CCE100E0_impl*
 inherited Create;
 f_Value := aValue;
//#UC END# *4DB6CD0F02C5_4DB6CCE100E0_impl*
end;//TkwInteger.Create

procedure TkwInteger.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6CCE100E0_var*
//#UC END# *4DAEEDE10285_4DB6CCE100E0_var*
begin
//#UC START# *4DAEEDE10285_4DB6CCE100E0_impl*
 aCtx.rEngine.PushInt(f_Value);
//#UC END# *4DAEEDE10285_4DB6CCE100E0_impl*
end;//TkwInteger.DoDoIt

function TkwInteger.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DB6CCE100E0_var*
//#UC END# *551544E2001A_4DB6CCE100E0_var*
begin
//#UC START# *551544E2001A_4DB6CCE100E0_impl*
 Result := TypeInfo(Integer);
//#UC END# *551544E2001A_4DB6CCE100E0_impl*
end;//TkwInteger.GetResultTypeInfo

function TkwInteger.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4DB6CCE100E0_var*
//#UC END# *55AFD7DA0258_4DB6CCE100E0_var*
begin
//#UC START# *55AFD7DA0258_4DB6CCE100E0_impl*
 Result := TtfwCStringFactory.C(IntToStr(f_Value));
//#UC END# *55AFD7DA0258_4DB6CCE100E0_impl*
end;//TkwInteger.WordName

initialization
 TkwInteger.RegisterClass;
 {* Регистрация TkwInteger }
{$IfEnd} // NOT Defined(NoScripts)

end.
