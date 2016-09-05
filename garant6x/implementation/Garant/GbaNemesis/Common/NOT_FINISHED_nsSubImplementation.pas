unit NOT_FINISHED_nsSubImplementation;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_FINISHED_nsSubImplementation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsSubImplementation" MUID: (4683589D0031)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsSubPrim
 , l3TreeInterfaces
;

type
 TnsSubImplementation = class(TnsSubPrim)
  private
   f_Node: Il3SimpleRootNode;
  protected
   procedure ClearFields; override;
 end;//TnsSubImplementation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4683589D0031impl_uses*
 //#UC END# *4683589D0031impl_uses*
;

procedure TnsSubImplementation.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TnsSubImplementation.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
