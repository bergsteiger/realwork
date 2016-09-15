unit msmUseCases;

// Модуль: "w:\common\components\gui\Garant\msm\msmUseCases.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmUseCases" MUID: (57CEAF3602AB)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
;

type
 ImsmUseCase = interface
  ['{54200745-EE4F-42D0-840A-8209E1EBE0D3}']
  procedure AddController(const aController: ImsmController);
  procedure Bind(const aController: ImsmController);
  procedure Activate;
  procedure Activated;
 end;//ImsmUseCase

implementation

uses
 l3ImplUses
;

end.
