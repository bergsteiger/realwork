unit evEditProcessor;

// Модуль: "w:\common\components\gui\Garant\Everest\evEditProcessor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevEditProcessor" MUID: (482D8B94020E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evMemoProcessor
;

type
 TevEditProcessor = class(TevMemoProcessor)
  protected
   procedure InitFields; override;
   procedure BeepOnParaLimit; override;
 end;//TevEditProcessor

implementation

uses
 l3ImplUses
;

procedure TevEditProcessor.InitFields;
//#UC START# *47A042E100E2_482D8B94020E_var*
//#UC END# *47A042E100E2_482D8B94020E_var*
begin
//#UC START# *47A042E100E2_482D8B94020E_impl*
 inherited;
 TextParaLimit := 1;
//#UC END# *47A042E100E2_482D8B94020E_impl*
end;//TevEditProcessor.InitFields

procedure TevEditProcessor.BeepOnParaLimit;
//#UC START# *482D91730258_482D8B94020E_var*
//#UC END# *482D91730258_482D8B94020E_var*
begin
//#UC START# *482D91730258_482D8B94020E_impl*
 // - не пищим
//#UC END# *482D91730258_482D8B94020E_impl*
end;//TevEditProcessor.BeepOnParaLimit

end.
