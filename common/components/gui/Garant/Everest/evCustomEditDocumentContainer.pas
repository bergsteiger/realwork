unit evCustomEditDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomEditDocumentContainer.pas"
// Начат: 13.05.2008 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevCustomEditDocumentContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomMemoContainer,
  evOpProc,
  k2Base
  ;

type
 TevCustomEditDocumentContainer = class(TevCustomMemoContainer)
 protected
 // overridden protected methods
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function GetDocumentType: Tk2Type; override;
 end;//TevCustomEditDocumentContainer

implementation

uses
  evEditProcessor,
  k2Tags,
  TinyDocument_Const
  ;

// start class TevCustomEditDocumentContainer

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