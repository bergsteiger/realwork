unit daProgressProcHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daProgressProcHolder.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DA::Provider::TdaProgressProcHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

uses
  l3Types,
  l3ProtoObject,
  daInterfaces
  ;

type
 TdaProgressProcHolder = class(Tl3ProtoObject, IdaProgressSubscriber)
 private
 // private fields
   f_Proc : Tl3ProgressProc;
 protected
 // realized methods
   procedure DoProgressNotify(aState: Byte;
     aValue: Integer;
     const aMsg: AnsiString = '');
 public
 // public methods
   constructor Create(aProc: Tl3ProgressProc); reintroduce;
   class function Make(aProc: Tl3ProgressProc): IdaProgressSubscriber; reintroduce;
     {* Сигнатура фабрики TdaProgressProcHolder.Make }
 end;//TdaProgressProcHolder

implementation

// start class TdaProgressProcHolder

constructor TdaProgressProcHolder.Create(aProc: Tl3ProgressProc);
//#UC START# *552524220076_552523F2014F_var*
//#UC END# *552524220076_552523F2014F_var*
begin
//#UC START# *552524220076_552523F2014F_impl*
 inherited Create;
 f_Proc := aProc;
//#UC END# *552524220076_552523F2014F_impl*
end;//TdaProgressProcHolder.Create

class function TdaProgressProcHolder.Make(aProc: Tl3ProgressProc): IdaProgressSubscriber;
var
 l_Inst : TdaProgressProcHolder;
begin
 l_Inst := Create(aProc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TdaProgressProcHolder.DoProgressNotify(aState: Byte;
  aValue: Integer;
  const aMsg: AnsiString = '');
//#UC START# *552514570311_552523F2014F_var*
//#UC END# *552514570311_552523F2014F_var*
begin
//#UC START# *552514570311_552523F2014F_impl*
 if Assigned(f_Proc) then
  f_Proc(aState, aValue, aMsg);
//#UC END# *552514570311_552523F2014F_impl*
end;//TdaProgressProcHolder.DoProgressNotify

end.