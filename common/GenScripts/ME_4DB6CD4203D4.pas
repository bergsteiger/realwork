unit kwString;
 {* Помещает значение в стек как строковое. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwString.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , l3Interfaces
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TkwString = class(TtfwRegisterableWordPrim)
  {* Помещает значение в стек как строковое. }
  private
   f_Value: Il3CString;
    {* Поле для свойства Value }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aValue: Il3CString); reintroduce;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function WordName: Il3CString; override;
  public
   property Value: Il3CString
    read f_Value;
 end;//TkwString
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
;

constructor TkwString.Create(const aValue: Il3CString);
//#UC START# *4DB6CD7402A0_4DB6CD4203D4_var*
//#UC END# *4DB6CD7402A0_4DB6CD4203D4_var*
begin
//#UC START# *4DB6CD7402A0_4DB6CD4203D4_impl*
 inherited Create;
 f_Value := aValue;
//#UC END# *4DB6CD7402A0_4DB6CD4203D4_impl*
end;//TkwString.Create

procedure TkwString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6CD4203D4_var*
//#UC END# *4DAEEDE10285_4DB6CD4203D4_var*
begin
//#UC START# *4DAEEDE10285_4DB6CD4203D4_impl*
 aCtx.rEngine.PushString(f_Value);
//#UC END# *4DAEEDE10285_4DB6CD4203D4_impl*
end;//TkwString.DoDoIt

procedure TkwString.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DB6CD4203D4_var*
//#UC END# *479731C50290_4DB6CD4203D4_var*
begin
//#UC START# *479731C50290_4DB6CD4203D4_impl*
 f_Value := nil;
 inherited;
//#UC END# *479731C50290_4DB6CD4203D4_impl*
end;//TkwString.Cleanup

procedure TkwString.ClearFields;
begin
 f_Value := nil;
 inherited;
end;//TkwString.ClearFields

function TkwString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DB6CD4203D4_var*
//#UC END# *551544E2001A_4DB6CD4203D4_var*
begin
//#UC START# *551544E2001A_4DB6CD4203D4_impl*
 Result := @tfw_tiString;
//#UC END# *551544E2001A_4DB6CD4203D4_impl*
end;//TkwString.GetResultTypeInfo

function TkwString.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4DB6CD4203D4_var*
//#UC END# *55AFD7DA0258_4DB6CD4203D4_var*
begin
//#UC START# *55AFD7DA0258_4DB6CD4203D4_impl*
 Result := f_Value;
//#UC END# *55AFD7DA0258_4DB6CD4203D4_impl*
end;//TkwString.WordName

initialization
 TkwString.RegisterClass;
 {* Регистрация TkwString }
{$IfEnd} // NOT Defined(NoScripts)

end.
