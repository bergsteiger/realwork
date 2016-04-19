unit NOT_FINISHED_evSubWaiter;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_evSubWaiter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSubWaiter" MUID: (4988405001B5)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Tool
 , nevTools
;

type
 TevSubWaiter = class(Tl3Tool)
  protected
   function TrySelectSub(const aContainer: InevDocumentContainer;
    const aSel: InevSelection;
    aSubID: Integer;
    aType: Integer): Boolean; virtual;
   function TrySelectPara(const aContainer: InevDocumentContainer;
    const aSel: InevSelection;
    aParaID: Integer): Boolean; virtual;
 end;//TevSubWaiter

implementation

uses
 l3ImplUses
;

function TevSubWaiter.TrySelectSub(const aContainer: InevDocumentContainer;
 const aSel: InevSelection;
 aSubID: Integer;
 aType: Integer): Boolean;
//#UC START# *5715DB6E02FC_4988405001B5_var*
//#UC END# *5715DB6E02FC_4988405001B5_var*
begin
//#UC START# *5715DB6E02FC_4988405001B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DB6E02FC_4988405001B5_impl*
end;//TevSubWaiter.TrySelectSub

function TevSubWaiter.TrySelectPara(const aContainer: InevDocumentContainer;
 const aSel: InevSelection;
 aParaID: Integer): Boolean;
//#UC START# *4BFFA0FF01D2_4988405001B5_var*
//#UC END# *4BFFA0FF01D2_4988405001B5_var*
begin
//#UC START# *4BFFA0FF01D2_4988405001B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BFFA0FF01D2_4988405001B5_impl*
end;//TevSubWaiter.TrySelectPara

end.
