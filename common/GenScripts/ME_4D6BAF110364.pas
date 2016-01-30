unit nscSimpleEditorForDialogsTextSource;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsTextSource.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

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
;

function TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_4D6BAF110364_var*
//#UC END# *482D9A030221_4D6BAF110364_var*
begin
//#UC START# *482D9A030221_4D6BAF110364_impl*
 Result := TnscSimpleEditorForDialogsContainer.Make;
//#UC END# *482D9A030221_4D6BAF110364_impl*
end;//TnscSimpleEditorForDialogsTextSource.DoMakeDocumentContainer

end.
