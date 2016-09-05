unit nscCustomChatMemoContainer;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscCustomChatMemoContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscCustomChatMemoContainer" MUID: (4A8BB2BD015E)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , evCustomMemoContainer
 , nevDocumentContainer
 , evOpProc
;

type
 TnscCustomChatMemoContainer = class(TevCustomMemoContainer)
  protected
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function PartGeneratorClass: RevDocumentPartGenerator; override;
 end;//TnscCustomChatMemoContainer
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nscCustomChatMemoDocumentPartGenerator
 , nscCustomChatMemoProcessor
 //#UC START# *4A8BB2BD015Eimpl_uses*
 //#UC END# *4A8BB2BD015Eimpl_uses*
;

procedure TnscCustomChatMemoContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_4A8BB2BD015E_var*
//#UC END# *47F35245009A_4A8BB2BD015E_var*
begin
//#UC START# *47F35245009A_4A8BB2BD015E_impl*
 theProcessor := TnscCustomChatMemoProcessor.Create;
//#UC END# *47F35245009A_4A8BB2BD015E_impl*
end;//TnscCustomChatMemoContainer.MakeProcessor

function TnscCustomChatMemoContainer.PartGeneratorClass: RevDocumentPartGenerator;
//#UC START# *48033300004D_4A8BB2BD015E_var*
//#UC END# *48033300004D_4A8BB2BD015E_var*
begin
//#UC START# *48033300004D_4A8BB2BD015E_impl*
 Result := TnscCustomChatMemoDocumentPartGenerator;
//#UC END# *48033300004D_4A8BB2BD015E_impl*
end;//TnscCustomChatMemoContainer.PartGeneratorClass
{$IfEnd} // Defined(Nemesis)

end.
