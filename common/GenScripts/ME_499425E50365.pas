unit vcmProfilerInterfaces;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , SysUtils
;

type
 IvcmProfiler = interface(IvcmBase)
  {* профайлер }
  procedure Init(const aDisplayName: AnsiString;
   aFinishCount: Integer);
   {* инициализирует профайлер }
  procedure Start;
   {* начать замер }
  procedure Finish;
   {* закончить замер }
 end;//IvcmProfiler
 
 IvcmProfilersCollection = interface(IvcmBase)
  {* профайлеры }
  procedure StartProfile(const aDisplayName: AnsiString;
   anId: Integer;
   aFinishCount: Integer);
   {* aFinishCount - устанавливает количество вызовов Finish после которых
                         считается, что профайле отработал и его свойство
                         HasFinished установится в True }
  procedure FinishProfile(anId: Integer);
   {* завершить работу профайлера. EvcmProfilerWasNotStarted }
  function FindById(anId: Integer): IvcmProfiler;
   {* это нужно пользователям профайлера, они знают только его
          идентификатор }
 end;//IvcmProfilersCollection
 
 EvcmProfilerWasNotStarted = class(Exception)
  {* Профайлер не был запущен }
 end;//EvcmProfilerWasNotStarted
 
implementation

uses
 l3ImplUses
;

end.
