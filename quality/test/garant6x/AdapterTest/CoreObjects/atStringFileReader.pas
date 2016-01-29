unit atStringFileReader;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringFileReader.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatStringFileReader
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atBits,
  atStringsFromFile,
  atStringProvider
  ;

type
 TatStringFileReader = class(TatStringProvider)
 protected
 // realized methods
   function AcquireNext(out theString: AnsiString): Boolean; override;
   procedure Reset; override;
 public
 // overridden public methods
   destructor Destroy; override;
 protected
 // protected fields
   f_StringsUsage : TatBits;
   f_Strings : TatStringsFromFile;
 public
 // public methods
   constructor Create(const aFileName: AnsiString); reintroduce; virtual;
 end;//TatStringFileReader

implementation

uses
  SysUtils
  ;

// start class TatStringFileReader

constructor TatStringFileReader.Create(const aFileName: AnsiString);
//#UC START# *502A457D0301_502A45570012_var*
//#UC END# *502A457D0301_502A45570012_var*
begin
//#UC START# *502A457D0301_502A45570012_impl*
  f_Strings := TatStringsFromFile.Create(aFileName);
  f_StringsUsage := TatBits.Create;
  f_StringsUsage.Size := f_Strings.Count;
//#UC END# *502A457D0301_502A45570012_impl*
end;//TatStringFileReader.Create

function TatStringFileReader.AcquireNext(out theString: AnsiString): Boolean;
//#UC START# *502A459F005A_502A45570012_var*
  var
    i : Integer;
//#UC END# *502A459F005A_502A45570012_var*
begin
//#UC START# *502A459F005A_502A45570012_impl*
  Result := false;

  if Random then
    i := f_StringsUsage.GetRandomOpenBit
  else
  begin
    i := f_StringsUsage.GetLastSetBit;
    if i = f_StringsUsage.Size-1 then
      i := -1
    else
      Inc(i)
  end;

  if i=-1 then
  begin
    if Looped then
    begin
      Reset;
      Result := AcquireNext(theString);
    end;
    Exit;
  end;

  f_StringsUsage[i] := true;
  theString := f_Strings.Strings[i];
  Result := true;
//#UC END# *502A459F005A_502A45570012_impl*
end;//TatStringFileReader.AcquireNext

procedure TatStringFileReader.Reset;
//#UC START# *502AACD103A6_502A45570012_var*
//#UC END# *502AACD103A6_502A45570012_var*
begin
//#UC START# *502AACD103A6_502A45570012_impl*
  f_StringsUsage.Reset;
//#UC END# *502AACD103A6_502A45570012_impl*
end;//TatStringFileReader.Reset

destructor TatStringFileReader.Destroy;
//#UC START# *48077504027E_502A45570012_var*
//#UC END# *48077504027E_502A45570012_var*
begin
//#UC START# *48077504027E_502A45570012_impl*
  FreeAndNil(f_StringsUsage);
  FreeAndNil(f_Strings);
  //
  inherited;
//#UC END# *48077504027E_502A45570012_impl*
end;//TatStringFileReader.Destroy

end.