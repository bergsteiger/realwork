unit msmUseCase;

// Модуль: "w:\common\components\gui\Garant\msm\msmUseCase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmUseCase" MUID: (57AD94F00212)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmControllers
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmController;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TmsmUseCase = class(_l3InterfaceRefList_, ImsmUseCase)
  protected
   procedure AddController(const aController: ImsmController);
   procedure Activate;
  public
   constructor Create; reintroduce;
   class function Make: ImsmUseCase; reintroduce;
 end;//TmsmUseCase

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57AD94F00212impl_uses*
 //#UC END# *57AD94F00212impl_uses*
;

type _Instance_R_ = TmsmUseCase;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

constructor TmsmUseCase.Create;
//#UC START# *57B1AEDB0188_57AD94F00212_var*
//#UC END# *57B1AEDB0188_57AD94F00212_var*
begin
//#UC START# *57B1AEDB0188_57AD94F00212_impl*
 inherited Create;
//#UC END# *57B1AEDB0188_57AD94F00212_impl*
end;//TmsmUseCase.Create

class function TmsmUseCase.Make: ImsmUseCase;
var
 l_Inst : TmsmUseCase;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmUseCase.Make

procedure TmsmUseCase.AddController(const aController: ImsmController);
//#UC START# *57AD949C0005_57AD94F00212_var*
//#UC END# *57AD949C0005_57AD94F00212_var*
begin
//#UC START# *57AD949C0005_57AD94F00212_impl*
 Add(aController);
//#UC END# *57AD949C0005_57AD94F00212_impl*
end;//TmsmUseCase.AddController

procedure TmsmUseCase.Activate;
//#UC START# *57B1ABA800A6_57AD94F00212_var*
var
 l_Index : Integer;
//#UC END# *57B1ABA800A6_57AD94F00212_var*
begin
//#UC START# *57B1ABA800A6_57AD94F00212_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Activate;
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Activated;
//#UC END# *57B1ABA800A6_57AD94F00212_impl*
end;//TmsmUseCase.Activate

end.
