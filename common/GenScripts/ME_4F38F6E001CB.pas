unit kwPopEditorBlockResize;
 {* *Формат:
aDelta aTop anEditor  pop:editor:BlockResize
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* anEditor - редактор, в котором изменяется блок. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorBlockResize.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_BlockResize" MUID: (4F38F6E001CB)
// Имя типа: "TkwPopEditorBlockResize"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResize = class(TkwBlockResize)
  {* *Формат:
aDelta aTop anEditor  pop:editor:BlockResize
* aDelta - смещение блока
* aTop - true чтобы двигать верхнюю границу
* anEditor - редактор, в котором изменяется блок. }
  protected
   procedure CorrectBlockPoint(const aCtx: TtfwContext;
    var aMap: InevMap;
    var aCursor: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorBlockResize
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopEditorBlockResize.CorrectBlockPoint(const aCtx: TtfwContext;
 var aMap: InevMap;
 var aCursor: InevBasePoint);
//#UC START# *514BFC55039E_4F38F6E001CB_var*
//#UC END# *514BFC55039E_4F38F6E001CB_var*
begin
//#UC START# *514BFC55039E_4F38F6E001CB_impl*
 
//#UC END# *514BFC55039E_4F38F6E001CB_impl*
end;//TkwPopEditorBlockResize.CorrectBlockPoint

class function TkwPopEditorBlockResize.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:BlockResize';
end;//TkwPopEditorBlockResize.GetWordNameForRegister

initialization
 TkwPopEditorBlockResize.RegisterInEngine;
 {* Регистрация pop_editor_BlockResize }
{$IfEnd} // NOT Defined(NoScripts)

end.
