unit evCustomEditDocumentContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomEditDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomMemoContainer
 , k2Base
 , evOpProc
;

type
 TevCustomEditDocumentContainer = class(TevCustomMemoContainer)
  protected
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function GetDocumentType: Tk2Type; override;
 end;//TevCustomEditDocumentContainer

implementation

uses
 l3ImplUses
 , evEditProcessor
 , k2Tags
 , TinyDocument_Const
;

procedure TevCustomEditDocumentContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_482D894F00D6_var*
//#UC END# *47F35245009A_482D894F00D6_var*
begin
//#UC START# *47F35245009A_482D894F00D6_impl*
 theProcessor := TevEditProcessor.Create;
//#UC END# *47F35245009A_482D894F00D6_impl*
end;//TevCustomEditDocumentContainer.MakeProcessor

function TevCustomEditDocumentContainer.GetDocumentType: Tk2Type;
//#UC START# *4A8D226F0164_482D894F00D6_var*
//#UC END# *4A8D226F0164_482D894F00D6_var*
begin
//#UC START# *4A8D226F0164_482D894F00D6_impl*
 Result := k2_typTinyDocument;
//#UC END# *4A8D226F0164_482D894F00D6_impl*
end;//TevCustomEditDocumentContainer.GetDocumentType

end.
