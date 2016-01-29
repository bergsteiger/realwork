unit nsDocumentLikeStateHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/nsDocumentLikeStateHolder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TnsDocumentLikeStateHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentAndListInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 InsDocumentLikeStateHolder = interface(IUnknown)
   ['{944B3FBB-00EB-4E3D-AE0B-AC0B0F59788F}']
   function Get_LikeState: TdocLikeState;
   procedure Set_LikeState(aValue: TdocLikeState);
   property LikeState: TdocLikeState
     read Get_LikeState
     write Set_LikeState;
 end;//InsDocumentLikeStateHolder

 TnsDocumentLikeStateHolder = class(Tl3ProtoObject, InsDocumentLikeStateHolder)
 private
 // private fields
   f_LikeState : TdocLikeState;
 protected
 // realized methods
   function Get_LikeState: TdocLikeState;
   procedure Set_LikeState(aValue: TdocLikeState);
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   class function Make: InsDocumentLikeStateHolder; reintroduce;
     {* Сигнатура фабрики TnsDocumentLikeStateHolder.Make }
 end;//TnsDocumentLikeStateHolder
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDocumentLikeStateHolder

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
end;

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

{$IfEnd} //not Admin AND not Monitorings

end.