unit nscSimpleEditorForDialogsContainer;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscSimpleEditorForDialogsContainer.pas"
// Стереотип: "SimpleClass"

{$Include nscDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemoContainer
;

type
 TnscSimpleEditorForDialogsContainer = class(TevCustomMemoContainer)
  protected
   function UseWikiMarkup: Boolean; override;
 end;//TnscSimpleEditorForDialogsContainer

implementation

uses
 l3ImplUses
;

function TnscSimpleEditorForDialogsContainer.UseWikiMarkup: Boolean;
//#UC START# *4D6BAFE8013D_4D6BAF99010E_var*
//#UC END# *4D6BAFE8013D_4D6BAF99010E_var*
begin
//#UC START# *4D6BAFE8013D_4D6BAF99010E_impl*
 Result := true;
//#UC END# *4D6BAFE8013D_4D6BAF99010E_impl*
end;//TnscSimpleEditorForDialogsContainer.UseWikiMarkup

end.
