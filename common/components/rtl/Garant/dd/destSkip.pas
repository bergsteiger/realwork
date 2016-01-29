unit destSkip;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destSkip.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestSkip
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddRTFdestination,
  ddRTFState,
  l3Base,
  RTFtypes
  ;

type
 TdestSkip = class(TddRTFDestination)
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 end;//TdestSkip

implementation

// start class TdestSkip

procedure TdestSkip.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_5461C67A0207_var*
//#UC END# *5461BEC2017D_5461C67A0207_var*
begin
//#UC START# *5461BEC2017D_5461C67A0207_impl*
//#UC END# *5461BEC2017D_5461C67A0207_impl*
end;//TdestSkip.Close

procedure TdestSkip.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_5461C67A0207_var*
//#UC END# *54E1F08400F9_5461C67A0207_var*
begin
//#UC START# *54E1F08400F9_5461C67A0207_impl*
 Assert(False);
//#UC END# *54E1F08400F9_5461C67A0207_impl*
end;//TdestSkip.WriteText

end.