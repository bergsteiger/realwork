unit ProgressIndicatorSupportUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ProgressIndicatorSupportUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

type
 IProgressIndicator = interface(IUnknown)
  {* Интерфейс для обратной связи при длительных операциях на сервере.
Должен реализовываться пользователем адаптера. }
   ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
   function GetMaxCount: Integer; stdcall;
   procedure SetCurrent(aCurCount: Integer;
    aArg: Integer
    {* Дополнительный параметр.}); stdcall;
     {* Изменение состояния длительного процесса.
В качестве параметра cur_count подается либо число уже обработанных элементов, принимающих участие в длительном процессе, либо число <=100 (при индикации в %). }
   property max_count: Integer
     read GetMaxCount;
 end;//IProgressIndicator

 ICancelLongProcess = interface(IUnknown)
  {* Интерфейс для возможности прерывания длительных операций на сервере. Используется в интерфейсе IProgressIndicator. }
   ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
   procedure CancelProcess; stdcall;
     {* Вызывается для прерывания длительного процесса. }
 end;//ICancelLongProcess

implementation

end.