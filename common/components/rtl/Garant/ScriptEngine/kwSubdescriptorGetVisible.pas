unit kwSubdescriptorGetVisible;
 {* Помещает в стек видмость метки.
Формат:
[code]
aSubDescrObj subdescriptor:GetVisible
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetVisible.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetVisible = {final} class(TkwSubDescriptorFromStackWord)
  {* Помещает в стек видмость метки.
Формат:
[code]
aSubDescrObj subdescriptor:GetVisible
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetVisible
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwSubdescriptorGetVisible.DoWithSubDescriptor(aControl: TevSubDescriptor;
 const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D661D4008D_var*
//#UC END# *52D65E9502E1_52D661D4008D_var*
begin
//#UC START# *52D65E9502E1_52D661D4008D_impl*
 aCtx.rEngine.PushBool(aControl.Visible);
//#UC END# *52D65E9502E1_52D661D4008D_impl*
end;//TkwSubdescriptorGetVisible.DoWithSubDescriptor

class function TkwSubdescriptorGetVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'subdescriptor:GetVisible';
end;//TkwSubdescriptorGetVisible.GetWordNameForRegister

initialization
 TkwSubdescriptorGetVisible.RegisterInEngine;
 {* Регистрация subdescriptor_GetVisible }
{$IfEnd} // NOT Defined(NoScripts)

end.
