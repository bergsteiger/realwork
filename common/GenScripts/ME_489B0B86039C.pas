unit atCycleOperation;
 {* ������ ��������. ����� ����� ���������� ��������� ��������� ��������. }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atCycleOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatCycleOperation" MUID: (489B0B86039C)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatCycleOperation = class(TatOperationBase)
  {* ������ ��������. ����� ����� ���������� ��������� ��������� ��������. }
  protected
   procedure ExecuteSelf; override;
 end;//TatCycleOperation

implementation

uses
 l3ImplUses
;

procedure TatCycleOperation.ExecuteSelf;
//#UC START# *48089F460352_489B0B86039C_var*
//#UC END# *48089F460352_489B0B86039C_var*
begin
//#UC START# *48089F460352_489B0B86039C_impl*
  // ������ �� ������
//#UC END# *48089F460352_489B0B86039C_impl*
end;//TatCycleOperation.ExecuteSelf

end.
