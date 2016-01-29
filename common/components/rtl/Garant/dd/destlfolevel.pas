unit destlfolevel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destlfolevel.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::Tdestlfolevel
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
  destListoverride,
  ddCustomRTFReader,
  RTFtypes,
  ddRTFState,
  l3Base
  ;

type
 Tdestlfolevel = class(TddRTFDestination)
 private
 // private fields
   f_destListoverride : TdestListoverride;
   f_Value : Integer;
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Clear; override;
   procedure ApplyProperty(propType: TPropType;
     What: TIProp;
     Value: LongInt;
     aState: TddRTFState); override;
 public
 // public methods
   constructor Create(aRTFReader: TddCustomRTFReader;
     aListOverride: TdestListoverride); reintroduce;
 end;//Tdestlfolevel

implementation

// start class Tdestlfolevel

constructor Tdestlfolevel.Create(aRTFReader: TddCustomRTFReader;
  aListOverride: TdestListoverride);
//#UC START# *5582993D0071_558298F60162_var*
//#UC END# *5582993D0071_558298F60162_var*
begin
//#UC START# *5582993D0071_558298F60162_impl*
 inherited Create(aRTFReader);
 f_Value := 0;
 f_destListoverride := aListOverride;
//#UC END# *5582993D0071_558298F60162_impl*
end;//Tdestlfolevel.Create

procedure Tdestlfolevel.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_558298F60162_var*
//#UC END# *5461BEC2017D_558298F60162_var*
begin
//#UC START# *5461BEC2017D_558298F60162_impl*
 if f_Value > 0 then
  f_destListoverride.ListOverride.AddStartAt(f_Value);
 Clear;
//#UC END# *5461BEC2017D_558298F60162_impl*
end;//Tdestlfolevel.Close

procedure Tdestlfolevel.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_558298F60162_var*
//#UC END# *54E1F08400F9_558298F60162_var*
begin
//#UC START# *54E1F08400F9_558298F60162_impl*

//#UC END# *54E1F08400F9_558298F60162_impl*
end;//Tdestlfolevel.WriteText

procedure Tdestlfolevel.Cleanup;
//#UC START# *479731C50290_558298F60162_var*
//#UC END# *479731C50290_558298F60162_var*
begin
//#UC START# *479731C50290_558298F60162_impl*
 f_Value := 0;
 f_destListoverride := nil;
 inherited;
//#UC END# *479731C50290_558298F60162_impl*
end;//Tdestlfolevel.Cleanup

procedure Tdestlfolevel.Clear;
//#UC START# *51D27A48038E_558298F60162_var*
//#UC END# *51D27A48038E_558298F60162_var*
begin
//#UC START# *51D27A48038E_558298F60162_impl*
 f_Value := 0;
//#UC END# *51D27A48038E_558298F60162_impl*
end;//Tdestlfolevel.Clear

procedure Tdestlfolevel.ApplyProperty(propType: TPropType;
  What: TIProp;
  Value: LongInt;
  aState: TddRTFState);
//#UC START# *51D27EC50388_558298F60162_var*
//#UC END# *51D27EC50388_558298F60162_var*
begin
//#UC START# *51D27EC50388_558298F60162_impl*
 case What of
  iproplistoverridestartat: f_Value := 1;
  iproplevelstartat: f_Value := Value;
 end;
//#UC END# *51D27EC50388_558298F60162_impl*
end;//Tdestlfolevel.ApplyProperty

end.