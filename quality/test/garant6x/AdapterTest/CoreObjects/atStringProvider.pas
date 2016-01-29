unit atStringProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringProvider.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatStringProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

type
 TatStringProvider = {abstract} class(TObject)
 private
 // private fields
   f_Random : Boolean;
    {* Поле для свойства Random}
   f_Looped : Boolean;
    {* Поле для свойства Looped}
 public
 // public methods
   function AcquireNext(out theString: AnsiString): Boolean; virtual; abstract;
   procedure Reset; virtual; abstract;
 public
 // public properties
   property Random: Boolean
     read f_Random
     write f_Random;
   property Looped: Boolean
     read f_Looped
     write f_Looped;
 end;//TatStringProvider

implementation

end.