unit nsDocumentTagNodeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsDocumentTagNodeBase.pas"
// Начат: 23.08.2010 16:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsDocumentTagNodeBase
//
// Базовая нода документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  F1TagDataProviderInterface,
  nsOwnedDocumentTagNodePrim
  ;

type
 TnsDocumentTagNodeBase = class(TnsOwnedDocumentTagNodePrim)
  {* Базовая нода документа }
 public
 // public methods
   constructor CreatePrim(const aNode: If1TagDataProvider);
 end;//TnsDocumentTagNodeBase

implementation

uses
  k2Facade
  ;

// start class TnsDocumentTagNodeBase

constructor TnsDocumentTagNodeBase.CreatePrim(const aNode: If1TagDataProvider);
//#UC START# *4C72528B0170_4C72633902D0_var*
//#UC END# *4C72528B0170_4C72633902D0_var*
begin
//#UC START# *4C72528B0170_4C72633902D0_impl*
 inherited Create(aNode.TypeID, aNode, nil, []);
//#UC END# *4C72528B0170_4C72633902D0_impl*
end;//TnsDocumentTagNodeBase.CreatePrim

end.