unit ProgressIndicatorSupportUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ProgressIndicatorSupportUnit.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 IProgressIndicator = interface
  {* Интерфейс для обратной связи при длительных операциях на сервере.
Должен реализовываться пользователем адаптера. }
  ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
  function Get_max_count: Integer;
  procedure set_current(cur_count: Integer;
   arg: Integer
   {* Дополнительный параметр. });
   {* Изменение состояния длительного процесса.
В качестве параметра cur_count подается либо число уже обработанных элементов, принимающих участие в длительном процессе, либо число <=100 (при индикации в %). }
  property max_count: Integer
   read Get_max_count;
 end;//IProgressIndicator

 ICancelLongProcess = interface
  {* Интерфейс для возможности прерывания длительных операций на сервере. Используется в интерфейсе IProgressIndicator. }
  ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
  procedure cancel_process;
   {* Вызывается для прерывания длительного процесса. }
 end;//ICancelLongProcess

implementation

uses
 l3ImplUses
;

end.
