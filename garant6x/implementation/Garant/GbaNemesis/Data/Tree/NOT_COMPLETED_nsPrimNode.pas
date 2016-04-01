unit NOT_COMPLETED_nsPrimNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\NOT_COMPLETED_nsPrimNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsPrimNode" MUID: (4ADDF4020322)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , eeVirtualNode
;

type
 TnsPrimNode = {abstract} class(TeeVirtualNode)
  protected
   f_NumInParent: Integer;
  protected
   function DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer; override;
  public
   constructor Create(aNumInParent: Integer); reintroduce;
 end;//TnsPrimNode

implementation

uses
 l3ImplUses
;

constructor TnsPrimNode.Create(aNumInParent: Integer);
//#UC START# *4AE030AF029D_4ADDF4020322_var*
//#UC END# *4AE030AF029D_4ADDF4020322_var*
begin
//#UC START# *4AE030AF029D_4ADDF4020322_impl*
 inherited Create;
 f_NumInParent := aNumInParent;
//#UC END# *4AE030AF029D_4ADDF4020322_impl*
end;//TnsPrimNode.Create

function TnsPrimNode.DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer;
//#UC START# *54C8E1F30128_4ADDF4020322_var*
//#UC END# *54C8E1F30128_4ADDF4020322_var*
begin
//#UC START# *54C8E1F30128_4ADDF4020322_impl*
 if aOnlyOneLevel then
 begin
  if (f_NumInParent < 0) then
   f_NumInParent := inherited DoGetNumInParent(true);
  Result := f_NumInParent;
 end//aOnlyOneLevel
 else
  Result := inherited DoGetNumInParent(aOnlyOneLevel);
//#UC END# *54C8E1F30128_4ADDF4020322_impl*
end;//TnsPrimNode.DoGetNumInParent

end.
