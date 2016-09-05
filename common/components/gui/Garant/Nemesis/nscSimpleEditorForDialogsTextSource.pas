unit nscSimpleEditorForDialogsTextSource;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsTextSource.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscSimpleEditorForDialogsTextSource" MUID: (4D6BAF110364)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemoTextSource
 , nevTools
;

type
 TnscSimpleEditorForDialogsTextSource = class(TevCustomMemoTextSource)
  protected
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TnscSimpleEditorForDialogsTextSource

implementation

uses
 l3ImplUses
 , nscSimpleEditorForDialogsContainer
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *4D6BAF110364impl_uses*
 //#UC END# *4D6BAF110364impl_uses*
;

function TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4D6BAF110364_var*
//#UC END# *482D9A030221_4D6BAF110364_var*
begin
//#UC START# *482D9A030221_4D6BAF110364_impl*
 Result := TnscSimpleEditorForDialogsContainer.Make;
//#UC END# *482D9A030221_4D6BAF110364_impl*
end;//TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscSimpleEditorForDialogsTextSource);
 {* Регистрация TnscSimpleEditorForDialogsTextSource }
{$IfEnd} // NOT Defined(NoScripts)

end.
