unit l3UnknownPrim.imp;

interface

uses
 l3IntfUses
;

type
 _l3UnknownPrim_ = class(_l3CheckStamp_)
  {* Класс-примесь реализующий подсчет ссылок и кеширование. }
  procedure ClearFields;
  procedure BeforeClearFields;
  procedure AfterDestroyCalled;
  procedure AfterFree;
   {* функция, вызываемая после каждого уменьшении счетчика ссылок на объект, не приводящего к уничтожению объекта }
  procedure InitAfterAlloc;
  function AllocInstanceMem: TObject;
  procedure FreeInstanceMem;
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; overload;
  procedure BeforeAddToCache;
   {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
  procedure InitFields;
  function IsCacheable: Boolean;
   {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
  procedure BeforeFree;
   {* функция, вызываемая при каждом уменьшении счетчика ссылок на 1. Вернув false может запретить уничтожение объекта. }
  function CheckUnfreedResource(aPtrToResource: Pointer): Boolean;
   {* Является ли ссылка на поле объекта правильно не освобожденным ресурсом.
              Возвращает правильно ли не освобожден инткрфейс }
  function NeedCleanupFields: Boolean;
  function __AddRef: Integer; stdcall;
   {* Увеличивает счетчик ссылок. }
  function __Release: Integer; stdcall;
   {* Уменьшает счетчик ссылок. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; overload; stdcall;
   {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_l3UnknownPrim_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
