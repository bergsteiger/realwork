unit evSubPanelSubCollection;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelSubCollection.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evSubPanelSubCollectionPrim
 , evSubPanelSubArray
 , l3Types
;

type
 _l3ObjectByHandleSearcher_Parent_ = TevSubPanelSubCollectionPrim;
 {$Include l3ObjectByHandleSearcher.imp.pas}
 TevSubPanelSubCollection = class(_l3ObjectByHandleSearcher_)
  public
   function CheckLayer(aHandle: Tl3Handle): TevSubPanelSubArray;
 end;//TevSubPanelSubCollection

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

type _Instance_R_ = TevSubPanelSubCollection;

{$Include l3ObjectByHandleSearcher.imp.pas}

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
