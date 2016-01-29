unit NOT_FINISHED_ddRTFProperties;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddRTFProperties.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::ddCommon::ddRTFProperties
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  l3NCString,
  RTFtypes,
  Classes
  ;

type
 TddCustomStyleEntry = class
 end;//TddCustomStyleEntry

 TddStyleEntry = class(TddCustomStyleEntry)
 end;//TddStyleEntry

 TddFontEntry = class(Tl3NCString)
 private
 // private fields
   f_FontType : TFontType;
    {* Поле для свойства FontType}
   f_Family : TFontFamily;
    {* Поле для свойства Family}
   f_Alternate : Tl3String;
    {* Поле для свойства Alternate}
   f_Panose : Tl3String;
    {* Поле для свойства Panose}
   f_Pitch : Byte;
    {* Поле для свойства Pitch}
   f_Number : Integer;
    {* Поле для свойства Number}
   f_CharSet : Integer;
    {* Поле для свойства CharSet}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeAddToCache; override;
     {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   procedure InitFields; override;
 public
 // overridden public methods
   procedure Assign(Source: TPersistent); override;
 public
 // public properties
   property FontType: TFontType
     read f_FontType
     write f_FontType;
   property Family: TFontFamily
     read f_Family
     write f_Family;
   property Alternate: Tl3String
     read f_Alternate;
   property Panose: Tl3String
     read f_Panose;
   property Pitch: Byte
     read f_Pitch
     write f_Pitch;
   property Number: Integer
     read f_Number
     write f_Number;
   property CharSet: Integer
     read f_CharSet
     write f_CharSet;
 end;//TddFontEntry

 TddRTFInfo = class
 end;//TddRTFInfo

implementation

// start class TddFontEntry

procedure TddFontEntry.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_54E19074022B_var*
//#UC END# *478CF34E02CE_54E19074022B_var*
begin
//#UC START# *478CF34E02CE_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *478CF34E02CE_54E19074022B_impl*
end;//TddFontEntry.Assign

procedure TddFontEntry.Cleanup;
//#UC START# *479731C50290_54E19074022B_var*
//#UC END# *479731C50290_54E19074022B_var*
begin
//#UC START# *479731C50290_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_54E19074022B_impl*
end;//TddFontEntry.Cleanup

procedure TddFontEntry.BeforeAddToCache;
//#UC START# *479F2B3302C1_54E19074022B_var*
//#UC END# *479F2B3302C1_54E19074022B_var*
begin
//#UC START# *479F2B3302C1_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *479F2B3302C1_54E19074022B_impl*
end;//TddFontEntry.BeforeAddToCache

procedure TddFontEntry.InitFields;
//#UC START# *47A042E100E2_54E19074022B_var*
//#UC END# *47A042E100E2_54E19074022B_var*
begin
//#UC START# *47A042E100E2_54E19074022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_54E19074022B_impl*
end;//TddFontEntry.InitFields
end.