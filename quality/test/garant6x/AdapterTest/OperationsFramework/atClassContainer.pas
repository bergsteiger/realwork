unit atClassContainer;

// Библиотека "AdapterTest"
// Модуль: atClassContainer

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatClassContainer = class(TObject)
 public
 // public fields
   F_OpClass : CTatOperationBase;
 public
 // public methods
   constructor Create(opClass: CTatOperationBase); reintroduce;
 end;//TatClassContainer

implementation

// start class TatClassContainer

constructor TatClassContainer.Create(opClass: CTatOperationBase);
//#UC START# *4808A92C0073_4808A8F6016B_var*
//#UC END# *4808A92C0073_4808A8F6016B_var*
begin
//#UC START# *4808A92C0073_4808A8F6016B_impl*
    inherited Create;
    F_OpClass := opClass;
//#UC END# *4808A92C0073_4808A8F6016B_impl*
end;

end.