unit nscTreeViewWithAdapterDragDrop;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Components"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Components/nscTreeViewWithAdapterDragDrop.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> F1 Базовые определения предметной области::LegalDomain::Components::Tree$WithDnD::TnscTreeViewWithAdapterDragDrop
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscTreeView
  {$IfEnd} //Nemesis
  ,
  vtOutlinerWithDragDrop
  ;

type
 TnscTreeViewWithAdapterDragDrop = class(TnscTreeView)
 protected
 // overridden protected methods
   function DataObjectClass: RvtNodeDataObject; override;
 end;//TnscTreeViewWithAdapterDragDrop

implementation

uses
  nsEntitiesTreeDataObject
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TnscTreeViewWithAdapterDragDrop

function TnscTreeViewWithAdapterDragDrop.DataObjectClass: RvtNodeDataObject;
//#UC START# *52DD106403D3_52DE57DF007B_var*
//#UC END# *52DD106403D3_52DE57DF007B_var*
begin
//#UC START# *52DD106403D3_52DE57DF007B_impl*
{$ifdef Nemesis}
 {$If Declared(TnsEntitiesTreeDataObject)}
 Result := TnsEntitiesTreeDataObject;
 {$else}
 Result := inherited DataObjectClass;
 {$IfEnd}
{$else}
 Result := inherited DataObjectClass;
{$endif}
//#UC END# *52DD106403D3_52DE57DF007B_impl*
end;//TnscTreeViewWithAdapterDragDrop.DataObjectClass

initialization
{$If not defined(NoScripts)}
// Регистрация TnscTreeViewWithAdapterDragDrop
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
{$IfEnd} //not NoScripts

end.