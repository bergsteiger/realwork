unit atAbortOperation;
 {* ����������� ���������� ������ ����� }

// ������: "w:\quality\test\garant6x\AdapterTest\Operations\atAbortOperation.pas"
// ���������: "SimpleClass"
// ������� ������: "TatAbortOperation" MUID: (48A2A3F10001)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatAbortOperation = class(TatOperationBase)
  {* ����������� ���������� ������ ����� }
  protected
   procedure ExecuteSelf; override;
 end;//TatAbortOperation

implementation

uses
 l3ImplUses
 , Windows
 //#UC START# *48A2A3F10001impl_uses*
 //#UC END# *48A2A3F10001impl_uses*
;

procedure TatAbortOperation.ExecuteSelf;
//#UC START# *48089F460352_48A2A3F10001_var*
//#UC END# *48089F460352_48A2A3F10001_var*
begin
//#UC START# *48089F460352_48A2A3F10001_impl*
  TerminateProcess( GetCurrentProcess, 1 );
//#UC END# *48089F460352_48A2A3F10001_impl*
end;//TatAbortOperation.ExecuteSelf

end.
