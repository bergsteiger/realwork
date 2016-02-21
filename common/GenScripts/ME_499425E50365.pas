unit vcmProfilerInterfaces;
 {* Профилирование. [$136264930] }

// Модуль: "w:\common\components\gui\Garant\VCM\vcmProfilerInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmExternalInterfaces
 , SysUtils
;

type
 IvcmProfiler = interface(IvcmBase)
  {* профайлер }
  ['{9414E6E8-AC1E-4B2C-8F9C-EB76E9BB846B}']
  function pm_GetId: Integer;
  function pm_GetHasFinished: Boolean;
  function pm_GetExecuteTime: Integer;
  function pm_GetExecuteCount: Integer;
  function pm_GetAverageExecuteTime: Integer;
  function pm_GetDisplayName: AnsiString;
  procedure Init(const aDisplayName: AnsiString;
   aFinishCount: Integer);
   {* инициализирует профайлер }
  procedure Start;
   {* начать замер }
  procedure Finish;
   {* закончить замер }
  property Id: Integer
   read pm_GetId;
   {* идентификатор профайлера }
  property HasFinished: Boolean
   read pm_GetHasFinished;
   {* определяет закончил ли профайлер работу }
  property ExecuteTime: Integer
   read pm_GetExecuteTime;
   {* время загрузки прецедента (в миллисекунадах) }
  property ExecuteCount: Integer
   read pm_GetExecuteCount;
   {* количество открытий прецедента. Профайлер запоминает результаты
           каждого замера }
  property AverageExecuteTime: Integer
   read pm_GetAverageExecuteTime;
   {* среднее время открытие прецедента }
  property DisplayName: AnsiString
   read pm_GetDisplayName;
   {* отображаемое название }
 end;//IvcmProfiler

 IvcmProfilersCollection = interface(IvcmBase)
  {* профайлеры }
  ['{0EE0F248-3908-4E76-B215-164D52D394DD}']
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
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
