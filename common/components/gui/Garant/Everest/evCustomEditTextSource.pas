unit evCustomEditTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomEditTextSource.pas"
// Начат: 13.05.2008 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevCustomEditTextSource
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evCustomMemoTextSource,
  nevTools
  ;

type
 TevCustomEditTextSource = class(TevCustomMemoTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 end;//TevCustomEditTextSource

implementation

uses
  evEditDocumentContainer,
  evCustomMemo
  ;

// start class TevCustomEditTextSource

function TevCustomEditTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D988102EC_var*
//#UC END# *482D9A030221_482D988102EC_var*
begin
//#UC START# *482D9A030221_482D988102EC_impl*
 Result := TevEditDocumentContainer.Make;
//#UC END# *482D9A030221_482D988102EC_impl*
end;//TevCustomEditTextSource.DoMakeDocumentContainer

end.