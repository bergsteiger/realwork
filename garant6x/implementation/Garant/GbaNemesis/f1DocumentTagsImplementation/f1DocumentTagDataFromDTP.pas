unit f1DocumentTagDataFromDTP;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1DocumentTagDataFromDTP.pas"
// Начат: 23.08.2010 17:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::Tf1DocumentTagDataFromDTP
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit,
  F1TagDataProviderInterface,
  f1TagDataFromDTP,
  IOUnit,
  l3Interfaces,
  k2Base,
  nevBase,
  l3Variant
  ;

type
 Tf1DocumentTagDataFromDTP = class(Tf1ListTagDataFromDTPPrim)
 protected
 // realized methods
   function GetChildID: TChildID; override;
   function GetParentLayerID: DTPLayerID; override;
 public
 // public methods
   class function Make(const aProvider: IDocumentTextProvider): If1TagDataProvider; reintroduce;
     {* Сигнатура фабрики Tf1DocumentTagDataFromDTP.Make }
 end;//Tf1DocumentTagDataFromDTP

implementation

// start class Tf1DocumentTagDataFromDTP

class function Tf1DocumentTagDataFromDTP.Make(const aProvider: IDocumentTextProvider): If1TagDataProvider;
var
 l_Inst : Tf1DocumentTagDataFromDTP;
begin
 l_Inst := Create(aProvider);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function Tf1DocumentTagDataFromDTP.GetChildID: TChildID;
//#UC START# *4C7281C90170_4C727C990284_var*
//#UC END# *4C7281C90170_4C727C990284_var*
begin
//#UC START# *4C7281C90170_4C727C990284_impl*
 Result := ROOT_CHILD;
//#UC END# *4C7281C90170_4C727C990284_impl*
end;//Tf1DocumentTagDataFromDTP.GetChildID

function Tf1DocumentTagDataFromDTP.GetParentLayerID: DTPLayerID;
//#UC START# *4C7289B80158_4C727C990284_var*
//#UC END# *4C7289B80158_4C727C990284_var*
begin
//#UC START# *4C7289B80158_4C727C990284_impl*
 Result := ROOT_LAYER;
//#UC END# *4C7289B80158_4C727C990284_impl*
end;//Tf1DocumentTagDataFromDTP.GetParentLayerID

end.