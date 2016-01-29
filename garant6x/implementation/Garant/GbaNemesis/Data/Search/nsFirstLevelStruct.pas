unit nsFirstLevelStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Search/nsFirstLevelStruct.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Search::TnsFirstLevelStruct
//
// Коллеги, это что?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  nsAttributeOneLevelTreeStruct
  ;

type
 TnsFirstLevelStruct = class(TnsAttributeOneLevelTreeStruct)
  {* Коллеги, это что? }
 public
 // public methods
   class function Make(const aTag: Il3CString;
    aShowRoot: Boolean): Il3SimpleTree;
     {* Создаёт экземпляр дерева }
 end;//TnsFirstLevelStruct

implementation

uses
  nsAttributeTreeCacheNew,
  DynamicTreeUnit
  ;

// start class TnsFirstLevelStruct

class function TnsFirstLevelStruct.Make(const aTag: Il3CString;
  aShowRoot: Boolean): Il3SimpleTree;
//#UC START# *4909DCCD018E_4909DC950238_var*
var
 l_Node: INodeBase;
//#UC END# *4909DCCD018E_4909DC950238_var*
begin
//#UC START# *4909DCCD018E_4909DC950238_impl*
 Result := nil;
 l_Node := TnsAttributeTreeCacheNew.Instance.AttributeRootClosed[aTag];
 try
  if (l_Node <> nil) then
   Result := inherited Make(l_Node, aTag, aShowRoot);
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4909DCCD018E_4909DC950238_impl*
end;//TnsFirstLevelStruct.Make

end.