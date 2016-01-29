unit ProgressIndicatorSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupportUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

ICancelLongProcess = interface;
{ - предварительное описание ICancelLongProcess. }


// Интерфейс для обратной связи при длительных операциях на сервере.
// Должен реализовываться пользователем адаптера.
IProgressIndicator = interface (IInterface) ['{885E85E3-E74C-4413-8408-2FB7533E7F8A}']
	function GetMaxCount (): Longint; stdcall;

	// Изменение состояния длительного процесса.
	// В качестве параметра cur_count подается либо число уже обработанных элементов, принимающих
	// участие в длительном процессе, либо число <=100 (при индикации в %).
	procedure SetCurrent (
		aCurCount: Longint;
		aArg: Longint
	); stdcall;
end;

// Интерфейс для возможности прерывания длительных операций на сервере. Используется в интерфейсе
// IProgressIndicator.
ICancelLongProcess = interface (IInterface) ['{CD915CB2-6E7A-4788-A5B0-ED90959D8399}']
	function DontUseMe: Pointer;
	// Вызывается для прерывания длительного процесса.
	procedure CancelProcess (); stdcall;
end;

implementation
end.