unit atNamedMutex;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atNamedMutex.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatNamedMutex
//
// Обертка вокруг виндового мьютекса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  l3_Base,
  Windows
  ;

type
 TatNamedMutex = class(Tl3_Base)
  {* Обертка вокруг виндового мьютекса }
 private
 // private fields
   f_MutexHandle : THandle;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aName: AnsiString); reintroduce;
   function Acquire(aTimeOut: LongWord = INFINITE): Boolean; virtual;
   procedure Release; virtual;
 end;//TatNamedMutex

implementation

uses
  SysUtils
  ;

// start class TatNamedMutex

constructor TatNamedMutex.Create(const aName: AnsiString);
//#UC START# *491D94ED015F_491D8DFA00BB_var*
//#UC END# *491D94ED015F_491D8DFA00BB_var*
begin
//#UC START# *491D94ED015F_491D8DFA00BB_impl*
  inherited Create;
  f_MutexHandle := CreateMutex(nil, false, PAnsiChar('{7273D3A2-313D-44DE-9D04-A3A90137271A}_' + aName));
  if (f_MutexHandle = 0) then
    Raise Exception.Create('Не могу создать мьютекс!');
//#UC END# *491D94ED015F_491D8DFA00BB_impl*
end;//TatNamedMutex.Create

function TatNamedMutex.Acquire(aTimeOut: LongWord = INFINITE): Boolean;
//#UC START# *491D955302A3_491D8DFA00BB_var*
//#UC END# *491D955302A3_491D8DFA00BB_var*
begin
//#UC START# *491D955302A3_491D8DFA00BB_impl*
  Result := (WaitForSingleObject(f_MutexHandle, aTimeOut) = WAIT_OBJECT_0);
//#UC END# *491D955302A3_491D8DFA00BB_impl*
end;//TatNamedMutex.Acquire

procedure TatNamedMutex.Release;
//#UC START# *491D959F0347_491D8DFA00BB_var*
//#UC END# *491D959F0347_491D8DFA00BB_var*
begin
//#UC START# *491D959F0347_491D8DFA00BB_impl*
  ReleaseMutex(f_MutexHandle);
//#UC END# *491D959F0347_491D8DFA00BB_impl*
end;//TatNamedMutex.Release

procedure TatNamedMutex.Cleanup;
//#UC START# *479731C50290_491D8DFA00BB_var*
//#UC END# *479731C50290_491D8DFA00BB_var*
begin
//#UC START# *479731C50290_491D8DFA00BB_impl*
  CloseHandle(f_MutexHandle);
  inherited;
//#UC END# *479731C50290_491D8DFA00BB_impl*
end;//TatNamedMutex.Cleanup

end.