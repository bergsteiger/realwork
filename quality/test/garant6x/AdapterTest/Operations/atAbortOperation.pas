unit atAbortOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atAbortOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatAbortOperation
//
// Немедленное прерывание работы теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatAbortOperation = class(TatOperationBase)
  {* Немедленное прерывание работы теста }
 protected
 // realized methods
   procedure ExecuteSelf; override;
 end;//TatAbortOperation

implementation

uses
  Windows
  ;

// start class TatAbortOperation

procedure TatAbortOperation.ExecuteSelf;
//#UC START# *48089F460352_48A2A3F10001_var*
//#UC END# *48089F460352_48A2A3F10001_var*
begin
//#UC START# *48089F460352_48A2A3F10001_impl*
  TerminateProcess( GetCurrentProcess, 1 );
//#UC END# *48089F460352_48A2A3F10001_impl*
end;//TatAbortOperation.ExecuteSelf

end.