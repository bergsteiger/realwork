unit atAbortOperation;
 {* Немедленное прерывание работы теста }

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atAbortOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatAbortOperation" MUID: (48A2A3F10001)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatAbortOperation = class(TatOperationBase)
  {* Немедленное прерывание работы теста }
  protected
   procedure ExecuteSelf; override;
 end;//TatAbortOperation

implementation

uses
 l3ImplUses
 , Windows
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
