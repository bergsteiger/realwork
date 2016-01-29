unit l3ProgressComponent;

interface

uses
 l3IntfUses
 , l3InterfacedComponent
 , l3Interfaces
;

type
 Tl3ProgressComponent = class(Tl3InterfacedComponent, Il3Progress)
  {* Базовый класс компонентов, имеющих индикатор прогресса. }
  procedure Start(Count: Integer;
   const aMsg: Il3CString); overload;
   {* начать процесс. }
  procedure Start(Count: Large;
   const aMsg: Il3CString); overload;
   {* начать процесс. }
  procedure Finish;
   {* закончить процесс. }
  procedure Progress(Current: Integer); overload;
   {* изменить текущее состояние. }
  procedure Progress(Current: Large); overload;
   {* изменить текущее состояние. }
  procedure ProgressEx(Current: Integer;
   const aMsg: Il3CString);
  procedure ChangeIO(Start: Boolean);
   {* изменить флаг InIO. }
  function InIO: Boolean;
   {* в процессе ввода/вывода? }
  function InUse: Boolean;
 end;//Tl3ProgressComponent
 
implementation

uses
 l3ImplUses
;

end.
