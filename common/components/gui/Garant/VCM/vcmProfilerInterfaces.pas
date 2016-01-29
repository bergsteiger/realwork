unit vcmProfilerInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/vcmProfilerInterfaces.pas"
// Начат: 12.02.2009 16:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::VCM::vcmProfilerInterfaces
//
// Профилирование. [$136264930]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  SysUtils
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
{$IfEnd} //not NoVCM

implementation

end.