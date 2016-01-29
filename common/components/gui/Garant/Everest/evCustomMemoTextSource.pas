unit evCustomMemoTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evCustomMemoTextSource.pas"
// Начат: 23.05.1997 09:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevCustomMemoTextSource
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evTextSource,
  Classes,
  nevTools
  ;

type
 TevCustomMemoTextSource = class(TevTextSource)
 protected
 // overridden protected methods
   function DoMakeDocumentContainer: InevDocumentContainer; override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 end;//TevCustomMemoTextSource

implementation

uses
  evCustomMemoContainer
  ;

// start class TevCustomMemoTextSource

constructor TevCustomMemoTextSource.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_482D98A20190_var*
//#UC END# *47D1602000C6_482D98A20190_var*
begin
//#UC START# *47D1602000C6_482D98A20190_impl*
 inherited Create(AOwner);
 LinkEditor(AOwner);
//#UC END# *47D1602000C6_482D98A20190_impl*
end;//TevCustomMemoTextSource.Create

function TevCustomMemoTextSource.DoMakeDocumentContainer: InevDocumentContainer;
//#UC START# *482D9A030221_482D98A20190_var*
//#UC END# *482D9A030221_482D98A20190_var*
begin
//#UC START# *482D9A030221_482D98A20190_impl*
 Result := TevCustomMemoContainer.Make;
//#UC END# *482D9A030221_482D98A20190_impl*
end;//TevCustomMemoTextSource.DoMakeDocumentContainer

end.