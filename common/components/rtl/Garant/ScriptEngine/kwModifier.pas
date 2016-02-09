unit kwModifier;
 {* Поддержка модификаторов. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwModifier.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwTypeInfo
 , tfwScriptingInterfaces
;

type
 TkwModifier = {abstract} class(TtfwRegisterableWord)
  {* Поддержка модификаторов. }
  protected
   function pm_GetModifier: TtfwTypeInfo; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
  protected
   property Modifier: TtfwTypeInfo
    read pm_GetModifier;
 end;//TkwModifier
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwModifier.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DCACE1201A3_var*
//#UC END# *4DAEEDE10285_4DCACE1201A3_var*
begin
//#UC START# *4DAEEDE10285_4DCACE1201A3_impl*
 aCtx.SetWordInfo(aCtx.rTypeInfo.IncludeType(Self.Modifier));
//#UC END# *4DAEEDE10285_4DCACE1201A3_impl*
end;//TkwModifier.DoDoIt

function TkwModifier.IsImmediate(const aCtx: TtfwContext): Boolean;
begin
 Result := True;
end;//TkwModifier.IsImmediate

initialization
 TkwModifier.RegisterClass;
 {* Регистрация Modifier }
{$IfEnd} // NOT Defined(NoScripts)

end.
