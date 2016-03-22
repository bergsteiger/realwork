unit k2OpMisc;
 {* Утилитные методы для работы с пачками операций }

// Модуль: "w:\common\components\rtl\Garant\K2\k2OpMisc.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "k2OpMisc" MUID: (48CF8F160109)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
;

function k2StartOp(const aProcessorSource: IUnknown;
 anOpCode: Integer = 0): Il3OpPack; overload;
 {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
function k2StartOp(const aProcessor: Ik2Processor;
 anOpCode: Integer = 0): Il3OpPack; overload;
 {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
function k2Proc(const anOp: Il3OpPack): Ik2Processor;
 {* возвращает процессор операций в контексте которого выполняется данная пачка или nil - если пачка = nil }

implementation

uses
 l3ImplUses
 , SysUtils
;

function k2StartOp(const aProcessorSource: IUnknown;
 anOpCode: Integer = 0): Il3OpPack;
 {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
//#UC START# *48CF8F3C02C9_48CF8F160109_var*
var
 l_Processor : Ik2Processor;
//#UC END# *48CF8F3C02C9_48CF8F160109_var*
begin
//#UC START# *48CF8F3C02C9_48CF8F160109_impl*
 if Supports(aProcessorSource, Ik2Processor, l_Processor) then
  try
   Result := l_Processor.StartOp(anOpCode);
  finally
   l_Processor := nil;
  end
 else
  Result := nil;
//#UC END# *48CF8F3C02C9_48CF8F160109_impl*
end;//k2StartOp

function k2StartOp(const aProcessor: Ik2Processor;
 anOpCode: Integer = 0): Il3OpPack;
 {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
//#UC START# *48CF8F6103E5_48CF8F160109_var*
//#UC END# *48CF8F6103E5_48CF8F160109_var*
begin
//#UC START# *48CF8F6103E5_48CF8F160109_impl*
 if (aProcessor = nil) then
  Result := nil
 else
  Result := aProcessor.StartOp(anOpCode);
//#UC END# *48CF8F6103E5_48CF8F160109_impl*
end;//k2StartOp

function k2Proc(const anOp: Il3OpPack): Ik2Processor;
 {* возвращает процессор операций в контексте которого выполняется данная пачка или nil - если пачка = nil }
//#UC START# *48CF8F8B0388_48CF8F160109_var*
//#UC END# *48CF8F8B0388_48CF8F160109_var*
begin
//#UC START# *48CF8F8B0388_48CF8F160109_impl*
 if (anOp = nil) then
  Result := nil
 else
  Result := anOp.Processor; 
//#UC END# *48CF8F8B0388_48CF8F160109_impl*
end;//k2Proc

end.
