unit msmCaptionModel;

// Модуль: "w:\common\components\gui\Garant\msm\msmCaptionModel.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmCaptionModel" MUID: (57CD3E5A00F1)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmConcreteModels
 , msmModel
 , l3Interfaces
;

type
 {$Include w:\common\components\gui\Garant\msm\msmCaptionModel.imp.pas}
 TmsmCaptionModel = class(_msmCaptionModel_)
  public
   class function Make: ImsmCaptionModel; reintroduce;
 end;//TmsmCaptionModel

implementation

uses
 l3ImplUses
 //#UC START# *57CD3E5A00F1impl_uses*
 //#UC END# *57CD3E5A00F1impl_uses*
;

{$Include w:\common\components\gui\Garant\msm\msmCaptionModel.imp.pas}

class function TmsmCaptionModel.Make: ImsmCaptionModel;
var
 l_Inst : TmsmCaptionModel;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmCaptionModel.Make

end.
