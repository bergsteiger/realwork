unit l3Prg;

interface

uses
 l3IntfUses
 , l3_Base
 , l3Interfaces
;

type
 Tl3ProgressIndicator = class(Tl3_Base, Il3Progress)
  {* Индикатор прогресса. }
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
 end;//Tl3ProgressIndicator
 
implementation

uses
 l3ImplUses
;

end.
