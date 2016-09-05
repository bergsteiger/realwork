unit msmModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModel" MUID: (57ADBFD200CA)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , msmControllers
 , msmEvents
 , ImsmEventsSubscriberList
;

type
 _msmEventsPublisher_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}
 _msmEventFire_Parent_ = _msmEventsPublisher_;
 {$Include w:\common\components\gui\Garant\msm\msmEventFire.imp.pas}
 TmsmModel = class(_msmEventFire_, ImsmModel, ImsmEventsPublisher)
  protected
   function As_ImsmEventsPublisher: ImsmEventsPublisher;
    {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: ImsmModel; reintroduce;
 end;//TmsmModel

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57ADBFD200CAimpl_uses*
 //#UC END# *57ADBFD200CAimpl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmEventsPublisher.imp.pas}

{$Include w:\common\components\gui\Garant\msm\msmEventFire.imp.pas}

class function TmsmModel.Make: ImsmModel;
var
 l_Inst : TmsmModel;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModel.Make

function TmsmModel.As_ImsmEventsPublisher: ImsmEventsPublisher;
 {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
begin
 Result := Self;
end;//TmsmModel.As_ImsmEventsPublisher

procedure TmsmModel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57ADBFD200CA_var*
//#UC END# *479731C50290_57ADBFD200CA_var*
begin
//#UC START# *479731C50290_57ADBFD200CA_impl*
 inherited;
//#UC END# *479731C50290_57ADBFD200CA_impl*
end;//TmsmModel.Cleanup

end.
