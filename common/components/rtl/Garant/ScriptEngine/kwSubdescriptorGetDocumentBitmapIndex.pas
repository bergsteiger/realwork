unit kwSubdescriptorGetDocumentBitmapIndex;
 {* Помещает в стек индекс иконки для отображения метки документа.
Формат:
[code]
aSubDescrObj subdescriptor:GetDocumentBitmapIndex
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDocumentBitmapIndex.pas"
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
 TkwSubdescriptorGetDocumentBitmapIndex = {final} class(TkwSubDescriptorFromStackWord)
  {* Помещает в стек индекс иконки для отображения метки документа.
Формат:
[code]
aSubDescrObj subdescriptor:GetDocumentBitmapIndex
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetDocumentBitmapIndex
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwSubdescriptorGetDocumentBitmapIndex.DoWithSubDescriptor(aControl: TevSubDescriptor;
 const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D660C703AC_var*
//#UC END# *52D65E9502E1_52D660C703AC_var*
begin
//#UC START# *52D65E9502E1_52D660C703AC_impl*
 aCtx.rEngine.PushInt(aControl.DocumentBitmapIndex);
//#UC END# *52D65E9502E1_52D660C703AC_impl*
end;//TkwSubdescriptorGetDocumentBitmapIndex.DoWithSubDescriptor

class function TkwSubdescriptorGetDocumentBitmapIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'subdescriptor:GetDocumentBitmapIndex';
end;//TkwSubdescriptorGetDocumentBitmapIndex.GetWordNameForRegister

initialization
 TkwSubdescriptorGetDocumentBitmapIndex.RegisterInEngine;
 {* Регистрация subdescriptor_GetDocumentBitmapIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
