unit k2OpMisc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2OpMisc.pas"
// Начат: 19.09.2001 18:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::K2::k2PrimObjects::k2OpMisc
//
// Утилитные методы для работы с пачками операций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant
  ;

function K2StartOp(const aProcessorSource: IUnknown;
  anOpCode: Integer = 0): Il3OpPack; overload; 
   {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
function K2StartOp(const aProcessor: Ik2Processor;
  anOpCode: Integer = 0): Il3OpPack; overload; 
   {* открывает пачку операций. aProcessorSource может поддерживать Il3Processor }
function K2Proc(const anOp: Il3OpPack): Ik2Processor;
   {* возвращает процессор операций в контексте которого выполняется данная пачка или nil - если пачка = nil }

implementation

uses
  SysUtils
  ;

// unit methods

function K2StartOp(const aProcessorSource: IUnknown;
  anOpCode: Integer = 0): Il3OpPack;
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
end;//K2StartOp

function K2StartOp(const aProcessor: Ik2Processor;
  anOpCode: Integer = 0): Il3OpPack;
//#UC START# *48CF8F6103E5_48CF8F160109_var*
//#UC END# *48CF8F6103E5_48CF8F160109_var*
begin
//#UC START# *48CF8F6103E5_48CF8F160109_impl*
 if (aProcessor = nil) then
  Result := nil
 else
  Result := aProcessor.StartOp(anOpCode);
//#UC END# *48CF8F6103E5_48CF8F160109_impl*
end;//K2StartOp

function K2Proc(const anOp: Il3OpPack): Ik2Processor;
//#UC START# *48CF8F8B0388_48CF8F160109_var*
//#UC END# *48CF8F8B0388_48CF8F160109_var*
begin
//#UC START# *48CF8F8B0388_48CF8F160109_impl*
 if (anOp = nil) then
  Result := nil
 else
  Result := anOp.Processor; 
//#UC END# *48CF8F8B0388_48CF8F160109_impl*
end;//K2Proc

end.