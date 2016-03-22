unit daProgressProcHolder;

// Модуль: "w:\common\components\rtl\Garant\DA\daProgressProcHolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaProgressProcHolder" MUID: (552523F2014F)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , l3Types
;

type
 TdaProgressProcHolder = class(Tl3ProtoObject, IdaProgressSubscriber)
  private
   f_Proc: Tl3ProgressProc;
  protected
   procedure DoProgressNotify(aState: Byte;
    aValue: Integer;
    const aMsg: AnsiString = '');
  public
   constructor Create(aProc: Tl3ProgressProc); reintroduce;
   class function Make(aProc: Tl3ProgressProc): IdaProgressSubscriber; reintroduce;
 end;//TdaProgressProcHolder

implementation

uses
 l3ImplUses
;

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
end;//TdaProgressProcHolder.Make

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
