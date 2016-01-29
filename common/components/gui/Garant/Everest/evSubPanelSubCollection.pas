unit evSubPanelSubCollection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSubPanelSubCollection.pas"
// Начат: 26.02.2010 16:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::SubPanel::TevSubPanelSubCollection
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Types,
  evSubPanelSubArray,
  evSubPanelSubCollectionPrim
  ;

type
 _l3ObjectByHandleSearcher_Parent_ = TevSubPanelSubCollectionPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}
 TevSubPanelSubCollection = class(_l3ObjectByHandleSearcher_)
 public
 // public methods
   function CheckLayer(aHandle: Tl3Handle): TevSubPanelSubArray;
 end;//TevSubPanelSubCollection

implementation

uses
  l3Base,
  SysUtils
  ;

type _Instance_R_ = TevSubPanelSubCollection;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectByHandleSearcher.imp.pas}

// start class TevSubPanelSubCollection

function TevSubPanelSubCollection.CheckLayer(aHandle: Tl3Handle): TevSubPanelSubArray;
//#UC START# *4B87D6CD02BD_4B87D32A0023_var*
var
 i : Integer;
 l_A : TevSubPanelSubArray;
//#UC END# *4B87D6CD02BD_4B87D32A0023_var*
begin
//#UC START# *4B87D6CD02BD_4B87D32A0023_impl*
 if FindData(aHandle, i) then
  Result := Items[i]
 else
 begin
  l_A := TevSubPanelSubArray.Create(Self.Owner, aHandle);
  try
   Add(l_A);
   Result := l_A;
  finally
   FreeAndNil(l_A);
  end;//try..finally
 end;//Result = nil
//#UC END# *4B87D6CD02BD_4B87D32A0023_impl*
end;//TevSubPanelSubCollection.CheckLayer

end.