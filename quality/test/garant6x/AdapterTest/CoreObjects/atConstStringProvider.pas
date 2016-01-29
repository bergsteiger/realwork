unit atConstStringProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atConstStringProvider.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatConstStringProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atStringProvider
  ;

type
 TatConstStringProvider = class(TatStringProvider)
 private
 // private fields
   f_Acquired : Boolean;
   f_String : AnsiString;
 protected
 // realized methods
   function AcquireNext(out theString: AnsiString): Boolean; override;
   procedure Reset; override;
 public
 // public methods
   constructor Create(const aString: AnsiString); reintroduce; virtual;
 end;//TatConstStringProvider

implementation

// start class TatConstStringProvider

constructor TatConstStringProvider.Create(const aString: AnsiString);
//#UC START# *5037D2B10112_5037D1DF03D8_var*
//#UC END# *5037D2B10112_5037D1DF03D8_var*
begin
//#UC START# *5037D2B10112_5037D1DF03D8_impl*
  f_String := aString;
  f_Acquired := false;
//#UC END# *5037D2B10112_5037D1DF03D8_impl*
end;//TatConstStringProvider.Create

function TatConstStringProvider.AcquireNext(out theString: AnsiString): Boolean;
//#UC START# *502A459F005A_5037D1DF03D8_var*
//#UC END# *502A459F005A_5037D1DF03D8_var*
begin
//#UC START# *502A459F005A_5037D1DF03D8_impl*
  if (NOT f_Acquired) OR Looped then
  begin
    theString := f_String;
    f_Acquired := true;
    Result := true;
  end
  else
    Result := false;
//#UC END# *502A459F005A_5037D1DF03D8_impl*
end;//TatConstStringProvider.AcquireNext

procedure TatConstStringProvider.Reset;
//#UC START# *502AACD103A6_5037D1DF03D8_var*
//#UC END# *502AACD103A6_5037D1DF03D8_var*
begin
//#UC START# *502AACD103A6_5037D1DF03D8_impl*
  f_Acquired := false;
//#UC END# *502AACD103A6_5037D1DF03D8_impl*
end;//TatConstStringProvider.Reset

end.