unit nscCustomChatMemoContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscCustomChatMemoContainer.pas"
// Начат: 19.08.2009 12:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::Memos::TnscCustomChatMemoContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  evCustomMemoContainer,
  evOpProc,
  nevDocumentContainer
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscCustomChatMemoContainer = class(TevCustomMemoContainer)
 protected
 // overridden protected methods
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function PartGeneratorClass: RevDocumentPartGenerator; override;
 end;//TnscCustomChatMemoContainer
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  nscCustomChatMemoDocumentPartGenerator,
  nscCustomChatMemoProcessor
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscCustomChatMemoContainer

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

{$IfEnd} //Nemesis

end.