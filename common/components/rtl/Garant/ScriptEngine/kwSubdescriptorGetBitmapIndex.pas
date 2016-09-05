unit kwSubdescriptorGetBitmapIndex;
 {* Помещает в стек иконки для отображения обычной метки
Формат:
[code]
aSubDescrObj subdescriptor:GetBitmapIndex
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBitmapIndex.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "subdescriptor_GetBitmapIndex" MUID: (52D6601F031E)
// Имя типа: "TkwSubdescriptorGetBitmapIndex"

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
 TkwSubdescriptorGetBitmapIndex = {final} class(TkwSubDescriptorFromStackWord)
  {* Помещает в стек иконки для отображения обычной метки
Формат:
[code]
aSubDescrObj subdescriptor:GetBitmapIndex
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetBitmapIndex
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52D6601F031Eimpl_uses*
 //#UC END# *52D6601F031Eimpl_uses*
;

procedure TkwSubdescriptorGetBitmapIndex.DoWithSubDescriptor(aControl: TevSubDescriptor;
 const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D6601F031E_var*
//#UC END# *52D65E9502E1_52D6601F031E_var*
begin
//#UC START# *52D65E9502E1_52D6601F031E_impl*
 aCtx.rEngine.PushInt(aControl.BitmapIndex);
//#UC END# *52D65E9502E1_52D6601F031E_impl*
end;//TkwSubdescriptorGetBitmapIndex.DoWithSubDescriptor

class function TkwSubdescriptorGetBitmapIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'subdescriptor:GetBitmapIndex';
end;//TkwSubdescriptorGetBitmapIndex.GetWordNameForRegister

initialization
 TkwSubdescriptorGetBitmapIndex.RegisterInEngine;
 {* Регистрация subdescriptor_GetBitmapIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
