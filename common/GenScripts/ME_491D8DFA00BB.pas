unit atNamedMutex;
 {* Обертка вокруг виндового мьютекса }

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atNamedMutex.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , l3_Base
 , Windows
;

type
 TatNamedMutex = class(Tl3_Base)
  {* Обертка вокруг виндового мьютекса }
  private
   f_MutexHandle: THandle;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aName: AnsiString); reintroduce;
   function Acquire(aTimeOut: LongWord = INFINITE): Boolean; virtual;
   procedure Release; virtual;
 end;//TatNamedMutex

implementation

uses
 l3ImplUses
 , SysUtils
;

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491D8DFA00BB_var*
//#UC END# *479731C50290_491D8DFA00BB_var*
begin
//#UC START# *479731C50290_491D8DFA00BB_impl*
  CloseHandle(f_MutexHandle);
  inherited;
//#UC END# *479731C50290_491D8DFA00BB_impl*
end;//TatNamedMutex.Cleanup

end.
