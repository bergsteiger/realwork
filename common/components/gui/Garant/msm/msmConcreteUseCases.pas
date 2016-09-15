unit msmConcreteUseCases;

// Модуль: "w:\common\components\gui\Garant\msm\msmConcreteUseCases.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmConcreteUseCases" MUID: (57D2DB49000A)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , msmControllers
 , msmConcreteModels
 , msmUseCases
;

type
 ImsmDrawingUseCase = interface(ImsmUseCase)
  ['{DCEF0346-205B-4372-824F-153BCE359DAC}']
  function Get_MainList: ImsmListModel;
  function Get_Navigator: ImsmTreeModel;
  function Get_Drawing: ImsmDrawingModel;
  function Get_FloatingNavigator: ImsmTreeModel;
  function Get_Caption: ImsmCaptionModel;
  property MainList: ImsmListModel
   read Get_MainList;
  property Navigator: ImsmTreeModel
   read Get_Navigator;
  property Drawing: ImsmDrawingModel
   read Get_Drawing;
  property FloatingNavigator: ImsmTreeModel
   read Get_FloatingNavigator;
  property Caption: ImsmCaptionModel
   read Get_Caption;
 end;//ImsmDrawingUseCase

 ImsmDrawingUseCaseView = interface(ImsmUseCase)
  ['{638BB9EE-937E-4002-86CF-32AFFD0E700D}']
 end;//ImsmDrawingUseCaseView

implementation

uses
 l3ImplUses
;

end.
