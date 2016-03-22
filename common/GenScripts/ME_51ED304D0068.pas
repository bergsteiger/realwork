unit nsDocumentLikeStateHolder;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsDocumentLikeStateHolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDocumentLikeStateHolder" MUID: (51ED304D0068)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , DocumentAndListInterfaces
;

type
 InsDocumentLikeStateHolder = interface
  ['{944B3FBB-00EB-4E3D-AE0B-AC0B0F59788F}']
  function Get_LikeState: TdocLikeState;
  procedure Set_LikeState(aValue: TdocLikeState);
  property LikeState: TdocLikeState
   read Get_LikeState
   write Set_LikeState;
 end;//InsDocumentLikeStateHolder

 TnsDocumentLikeStateHolder = class(Tl3ProtoObject, InsDocumentLikeStateHolder)
  private
   f_LikeState: TdocLikeState;
  protected
   function Get_LikeState: TdocLikeState;
   procedure Set_LikeState(aValue: TdocLikeState);
  public
   constructor Create; reintroduce;
   class function Make: InsDocumentLikeStateHolder; reintroduce;
 end;//TnsDocumentLikeStateHolder
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

constructor TnsDocumentLikeStateHolder.Create;
//#UC START# *51ED52BC02FC_51ED304D0068_var*
//#UC END# *51ED52BC02FC_51ED304D0068_var*
begin
//#UC START# *51ED52BC02FC_51ED304D0068_impl*
 inherited;
 f_LikeState := dlsDefault;
//#UC END# *51ED52BC02FC_51ED304D0068_impl*
end;//TnsDocumentLikeStateHolder.Create

class function TnsDocumentLikeStateHolder.Make: InsDocumentLikeStateHolder;
var
 l_Inst : TnsDocumentLikeStateHolder;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDocumentLikeStateHolder.Make

function TnsDocumentLikeStateHolder.Get_LikeState: TdocLikeState;
//#UC START# *51ED55A2038E_51ED304D0068get_var*
//#UC END# *51ED55A2038E_51ED304D0068get_var*
begin
//#UC START# *51ED55A2038E_51ED304D0068get_impl*
 Result := f_LikeState;
//#UC END# *51ED55A2038E_51ED304D0068get_impl*
end;//TnsDocumentLikeStateHolder.Get_LikeState

procedure TnsDocumentLikeStateHolder.Set_LikeState(aValue: TdocLikeState);
//#UC START# *51ED55A2038E_51ED304D0068set_var*
//#UC END# *51ED55A2038E_51ED304D0068set_var*
begin
//#UC START# *51ED55A2038E_51ED304D0068set_impl*
 f_LikeState := aValue;
//#UC END# *51ED55A2038E_51ED304D0068set_impl*
end;//TnsDocumentLikeStateHolder.Set_LikeState
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
