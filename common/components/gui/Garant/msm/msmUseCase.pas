unit msmUseCase;

// Модуль: "w:\common\components\gui\Garant\msm\msmUseCase.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmUseCase" MUID: (57AD94F00212)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , ImsmControllerList
 , msmUseCases
 , msmControllers
;

type
 TmsmUseCase = class(TImsmControllerList, ImsmUseCase)
  protected
   procedure AddController(const aController: ImsmController);
   procedure Bind(const aController: ImsmController);
  public
   constructor Create; reintroduce;
   class function Make: ImsmUseCase; reintroduce;
 end;//TmsmUseCase

implementation

uses
 l3ImplUses
 //#UC START# *57AD94F00212impl_uses*
 //#UC END# *57AD94F00212impl_uses*
;

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

procedure TmsmUseCase.Bind(const aController: ImsmController);
//#UC START# *57D29826015D_57AD94F00212_var*
//#UC END# *57D29826015D_57AD94F00212_var*
begin
//#UC START# *57D29826015D_57AD94F00212_impl*
 AddController(aController);
//#UC END# *57D29826015D_57AD94F00212_impl*
end;//TmsmUseCase.Bind

end.
