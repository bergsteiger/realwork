unit kwSubdescriptorGetBlockBitmapIndex;
 {* Помещает в стек индекс иконки для отображения метки блока
Формат:
[code]
aSubDescrObj subdescriptor:GetBlockBitmapIndex
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetBlockBitmapIndex.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "subdescriptor_GetBlockBitmapIndex" MUID: (52D660670205)
// Имя типа: "TkwSubdescriptorGetBlockBitmapIndex"

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
 TkwSubdescriptorGetBlockBitmapIndex = {final} class(TkwSubDescriptorFromStackWord)
  {* Помещает в стек индекс иконки для отображения метки блока
Формат:
[code]
aSubDescrObj subdescriptor:GetBlockBitmapIndex
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetBlockBitmapIndex
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwSubdescriptorGetBlockBitmapIndex.DoWithSubDescriptor(aControl: TevSubDescriptor;
 const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D660670205_var*
//#UC END# *52D65E9502E1_52D660670205_var*
begin
//#UC START# *52D65E9502E1_52D660670205_impl*
 aCtx.rEngine.PushInt(aControl.BlockBitmapIndex);
//#UC END# *52D65E9502E1_52D660670205_impl*
end;//TkwSubdescriptorGetBlockBitmapIndex.DoWithSubDescriptor

class function TkwSubdescriptorGetBlockBitmapIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'subdescriptor:GetBlockBitmapIndex';
end;//TkwSubdescriptorGetBlockBitmapIndex.GetWordNameForRegister

initialization
 TkwSubdescriptorGetBlockBitmapIndex.RegisterInEngine;
 {* Регистрация subdescriptor_GetBlockBitmapIndex }
{$IfEnd} // NOT Defined(NoScripts)

end.
