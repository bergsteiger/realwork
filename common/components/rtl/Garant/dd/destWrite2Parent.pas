unit destWrite2Parent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destWrite2Parent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestWrite2Parent
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
  ddCustomRTFReader,
  destSkip,
  l3Base,
  RTFtypes,
  ddRTFState
  ;

type
 TdestWrite2Parent = class(TdestSkip)
 private
 // private fields
   f_ParentDestination : TddRTFDestination;
    {* Поле для свойства ParentDestination}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 public
 // public methods
   constructor Create(aRTFReader: TddCustomRTFReader;
     aParent: TddRTFDestination); reintroduce;
 public
 // public properties
   property ParentDestination: TddRTFDestination
     read f_ParentDestination;
 end;//TdestWrite2Parent

implementation

// start class TdestWrite2Parent

constructor TdestWrite2Parent.Create(aRTFReader: TddCustomRTFReader;
  aParent: TddRTFDestination);
//#UC START# *54E3055F033C_54E3046A00AE_var*
//#UC END# *54E3055F033C_54E3046A00AE_var*
begin
//#UC START# *54E3055F033C_54E3046A00AE_impl*
 inherited Create(aRTFReader);
 f_ParentDestination := aParent;
//#UC END# *54E3055F033C_54E3046A00AE_impl*
end;//TdestWrite2Parent.Create

procedure TdestWrite2Parent.Cleanup;
//#UC START# *479731C50290_54E3046A00AE_var*
//#UC END# *479731C50290_54E3046A00AE_var*
begin
//#UC START# *479731C50290_54E3046A00AE_impl*
 inherited;
 f_ParentDestination := nil;
//#UC END# *479731C50290_54E3046A00AE_impl*
end;//TdestWrite2Parent.Cleanup

procedure TdestWrite2Parent.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_54E3046A00AE_var*
//#UC END# *54E1F08400F9_54E3046A00AE_var*
begin
//#UC START# *54E1F08400F9_54E3046A00AE_impl*
 f_ParentDestination.WriteText(RDS, aText, aState);
//#UC END# *54E1F08400F9_54E3046A00AE_impl*
end;//TdestWrite2Parent.WriteText

end.