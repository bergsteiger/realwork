unit Runner;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/quality/test/garant6x/AdapterTest/Runner.pas"
// Начат: 03.06.2011 15:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest$Target::TRunner
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

type
 TRunner = class
 public
 // public methods
   class procedure Run;
 end;//TRunner

implementation

uses
  atAdapterTest,
  SysUtils,
  ActiveX
  {$If defined(Nemesis)}
  ,
  eeDocument_Schema
  {$IfEnd} //Nemesis
  
  ;

// start class TRunner

class procedure TRunner.Run;
//#UC START# *4DE8CA530214_4DE8C9DB02AD_var*
var
  Test : TatAdapterTest;
//#UC END# *4DE8CA530214_4DE8C9DB02AD_var*
begin
//#UC START# *4DE8CA530214_4DE8C9DB02AD_impl*
  CoInitialize(nil);
  try
   Test := TatAdapterTest.Create;
   try
    Test.Start;
   finally
    FreeAndNil(Test);
   end;//try..finally
  finally
    CoUninitialize;
  end;//try..finally
//#UC END# *4DE8CA530214_4DE8C9DB02AD_impl*
end;//TRunner.Run

end.