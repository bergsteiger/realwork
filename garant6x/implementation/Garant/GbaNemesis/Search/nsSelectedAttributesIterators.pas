unit nsSelectedAttributesIterators;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsSelectedAttributesIterators.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::SearchLite::Search::Search::TnsSelectedAttributesIterators
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  l3SimpleObject,
  SearchInterfaces
  ;

type
 TnsSelectedAttributesIterators = class(Tl3SimpleObject, InsSelectedAttributesIterators)
 private
 // private fields
   f_OrIterator : INodeIterator;
   f_AndIterator : INodeIterator;
   f_NotIterator : INodeIterator;
 protected
 // realized methods
   function Get_OrIterator: INodeIterator;
   function Get_AndIterator: INodeIterator;
   function Get_NotIterator: INodeIterator;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const anOrIterator: INodeIterator;
    const anAndIterator: INodeIterator;
    const aNotIterator: INodeIterator); reintroduce;
   class function Make(const anOrIterator: INodeIterator;
    const anAndIterator: INodeIterator;
    const aNotIterator: INodeIterator): InsSelectedAttributesIterators; reintroduce;
 end;//TnsSelectedAttributesIterators

implementation

// start class TnsSelectedAttributesIterators

constructor TnsSelectedAttributesIterators.Create(const anOrIterator: INodeIterator;
  const anAndIterator: INodeIterator;
  const aNotIterator: INodeIterator);
//#UC START# *4AE58EF903D2_4AE58E7C00A4_var*
//#UC END# *4AE58EF903D2_4AE58E7C00A4_var*
begin
//#UC START# *4AE58EF903D2_4AE58E7C00A4_impl*
 inherited Create;
 f_OrIterator := anOrIterator;
 f_AndIterator := anAndIterator;
 f_NotIterator := aNotIterator;
//#UC END# *4AE58EF903D2_4AE58E7C00A4_impl*
end;//TnsSelectedAttributesIterators.Create

class function TnsSelectedAttributesIterators.Make(const anOrIterator: INodeIterator;
  const anAndIterator: INodeIterator;
  const aNotIterator: INodeIterator): InsSelectedAttributesIterators;
var
 l_Inst : TnsSelectedAttributesIterators;
begin
 l_Inst := Create(anOrIterator, anAndIterator, aNotIterator);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsSelectedAttributesIterators.Get_OrIterator: INodeIterator;
//#UC START# *4AE589E702F9_4AE58E7C00A4get_var*
//#UC END# *4AE589E702F9_4AE58E7C00A4get_var*
begin
//#UC START# *4AE589E702F9_4AE58E7C00A4get_impl*
 Result := f_OrIterator;
//#UC END# *4AE589E702F9_4AE58E7C00A4get_impl*
end;//TnsSelectedAttributesIterators.Get_OrIterator

function TnsSelectedAttributesIterators.Get_AndIterator: INodeIterator;
//#UC START# *4AE58A0603A2_4AE58E7C00A4get_var*
//#UC END# *4AE58A0603A2_4AE58E7C00A4get_var*
begin
//#UC START# *4AE58A0603A2_4AE58E7C00A4get_impl*
 Result := f_AndIterator;
//#UC END# *4AE58A0603A2_4AE58E7C00A4get_impl*
end;//TnsSelectedAttributesIterators.Get_AndIterator

function TnsSelectedAttributesIterators.Get_NotIterator: INodeIterator;
//#UC START# *4AE58A1203BE_4AE58E7C00A4get_var*
//#UC END# *4AE58A1203BE_4AE58E7C00A4get_var*
begin
//#UC START# *4AE58A1203BE_4AE58E7C00A4get_impl*
 Result := f_NotIterator;
//#UC END# *4AE58A1203BE_4AE58E7C00A4get_impl*
end;//TnsSelectedAttributesIterators.Get_NotIterator

procedure TnsSelectedAttributesIterators.Cleanup;
//#UC START# *479731C50290_4AE58E7C00A4_var*
//#UC END# *479731C50290_4AE58E7C00A4_var*
begin
//#UC START# *479731C50290_4AE58E7C00A4_impl*
 f_OrIterator := nil;
 f_AndIterator := nil;
 f_NotIterator := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4AE58E7C00A4_impl*
end;//TnsSelectedAttributesIterators.Cleanup

end.