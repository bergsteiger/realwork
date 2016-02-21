unit kwSubdescriptorGetColumn;
 {* Помещает в стек номер колонки.
Формат:
[code]
aSubDescrObj subdescriptor:GetColumn
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetColumn.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetColumn = {final} class(TkwSubDescriptorFromStackWord)
  {* Помещает в стек номер колонки.
Формат:
[code]
aSubDescrObj subdescriptor:GetColumn
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetColumn
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwSubdescriptorGetColumn.DoWithSubDescriptor(aControl: TevSubDescriptor;
 const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D6622F0148_var*
//#UC END# *52D65E9502E1_52D6622F0148_var*
begin
//#UC START# *52D65E9502E1_52D6622F0148_impl*
 aCtx.rEngine.PushInt(aControl.Column);
//#UC END# *52D65E9502E1_52D6622F0148_impl*
end;//TkwSubdescriptorGetColumn.DoWithSubDescriptor

class function TkwSubdescriptorGetColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'subdescriptor:GetColumn';
end;//TkwSubdescriptorGetColumn.GetWordNameForRegister

initialization
 TkwSubdescriptorGetColumn.RegisterInEngine;
 {* Регистрация subdescriptor_GetColumn }
{$IfEnd} // NOT Defined(NoScripts)

end.
