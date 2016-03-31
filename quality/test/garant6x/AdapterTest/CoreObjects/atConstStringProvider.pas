unit atConstStringProvider;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atConstStringProvider.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatConstStringProvider" MUID: (5037D1DF03D8)

interface

uses
 l3IntfUses
 , atStringProvider
;

type
 TatConstStringProvider = class(TatStringProvider)
  private
   f_Acquired: Boolean;
   f_String: AnsiString;
  public
   constructor Create(const aString: AnsiString); reintroduce; virtual;
   function AcquireNext(out theString: AnsiString): Boolean; override;
   procedure Reset; override;
 end;//TatConstStringProvider

implementation

uses
 l3ImplUses
;

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
