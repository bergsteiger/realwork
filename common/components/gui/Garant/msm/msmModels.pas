unit msmModels;

// Модуль: "w:\common\components\gui\Garant\msm\msmModels.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmModels" MUID: (57CEB4640283)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmEvents
;

type
 ImsmModel = interface
  ['{FCD19034-099E-4C0D-BE89-D5E8325EBD9B}']
  function As_ImsmEventsPublisher: ImsmEventsPublisher;
   {* Метод приведения нашего интерфейса к ImsmEventsPublisher }
 end;//ImsmModel

implementation

uses
 l3ImplUses
;

end.
