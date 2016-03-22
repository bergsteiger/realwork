unit ddRowProperty;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddRowProperty.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddRowProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddBorder,
  ddPropertyObject,
  ddTypes,
  k2Interfaces
  ;

type
 TddRowProperty = class(TddPropertyObject)
 private
 // private fields
   f_Gaph : LongInt;
    {* Поле для свойства Gaph}
   f_Left : LongInt;
    {* Поле для свойства Left}
   f_Width : LongInt;
    {* Поле для свойства Width}
   f_AutoFit : Boolean;
    {* Поле для свойства AutoFit}
   f_Border : TddBorder;
    {* Поле для свойства Border}
   f_IsLastRow : Boolean;
    {* Поле для свойства IsLastRow}
   f_RowIndex : LongInt;
    {* Поле для свойства RowIndex}
   f_trwWidthB : LongInt;
    {* Поле для свойства trwWidthB}
   f_trftsWidthA : TddRTFWidthUnits;
    {* Поле для свойства trftsWidthA}
   f_trftsWidthB : TddRTFWidthUnits;
    {* Поле для свойства trftsWidthB}
   f_trwWidthA : LongInt;
    {* Поле для свойства trwWidthA}
 protected
 // property methods
   procedure pm_SetAutoFit(aValue: Boolean);
   function pm_GetTrwWidthB: LongInt;
   procedure pm_SetTrwWidthB(aValue: LongInt);
   procedure pm_SetTrftsWidthA(aValue: TddRTFWidthUnits);
   procedure pm_SetTrftsWidthB(aValue: TddRTFWidthUnits);
   function pm_GetTrwWidthA: LongInt;
   procedure pm_SetTrwWidthA(aValue: LongInt);
 protected
 // realized methods
   procedure MergeWith(P: TddPropertyObject); override;
   procedure InheriteFrom(P: TddPropertyObject); override;
   procedure Write2Generator(const Generator: Ik2TagGenerator); override;
   procedure Reset; override;
   function Diff(P: TddPropertyObject;
     aForReader: Boolean): TddPropertyObject; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create; override;
     {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
   procedure Clear; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
 public
 // public properties
   property Gaph: LongInt
     read f_Gaph
     write f_Gaph;
   property Left: LongInt
     read f_Left
     write f_Left;
   property Width: LongInt
     read f_Width
     write f_Width;
   property AutoFit: Boolean
     read f_AutoFit
     write pm_SetAutoFit;
   property Border: TddBorder
     read f_Border;
   property IsLastRow: Boolean
     read f_IsLastRow
     write f_IsLastRow;
   property RowIndex: LongInt
     read f_RowIndex
     write f_RowIndex;
   property trwWidthB: LongInt
     read pm_GetTrwWidthB
     write pm_SetTrwWidthB;
   property trftsWidthA: TddRTFWidthUnits
     read f_trftsWidthA
     write pm_SetTrftsWidthA;
   property trftsWidthB: TddRTFWidthUnits
     read f_trftsWidthB
     write pm_SetTrftsWidthB;
   property trwWidthA: LongInt
     read pm_GetTrwWidthA
     write pm_SetTrwWidthA;
 end;//TddRowProperty

implementation

uses
  l3Base,
  ddCellProperty
  ;

// start class TddRowProperty

procedure TddRowProperty.pm_SetAutoFit(aValue: Boolean);
//#UC START# *518A11380166_518A10050368set_var*
//#UC END# *518A11380166_518A10050368set_var*
begin
//#UC START# *518A11380166_518A10050368set_impl*
 f_AutoFit := aValue;
//#UC END# *518A11380166_518A10050368set_impl*
end;//TddRowProperty.pm_SetAutoFit

function TddRowProperty.pm_GetTrwWidthB: LongInt;
//#UC START# *5390359B0041_518A10050368get_var*
//#UC END# *5390359B0041_518A10050368get_var*
begin
//#UC START# *5390359B0041_518A10050368get_impl*
 Result := f_trwWidthB;
//#UC END# *5390359B0041_518A10050368get_impl*
end;//TddRowProperty.pm_GetTrwWidthB

procedure TddRowProperty.pm_SetTrwWidthB(aValue: LongInt);
//#UC START# *5390359B0041_518A10050368set_var*
//#UC END# *5390359B0041_518A10050368set_var*
begin
//#UC START# *5390359B0041_518A10050368set_impl*
 f_trwWidthB := aValue;
//#UC END# *5390359B0041_518A10050368set_impl*
end;//TddRowProperty.pm_SetTrwWidthB

procedure TddRowProperty.pm_SetTrftsWidthA(aValue: TddRTFWidthUnits);
//#UC START# *561618B20192_518A10050368set_var*
//#UC END# *561618B20192_518A10050368set_var*
begin
//#UC START# *561618B20192_518A10050368set_impl*
 f_TrftsWidthA := aValue;
//#UC END# *561618B20192_518A10050368set_impl*
end;//TddRowProperty.pm_SetTrftsWidthA

procedure TddRowProperty.pm_SetTrftsWidthB(aValue: TddRTFWidthUnits);
//#UC START# *561618E6019B_518A10050368set_var*
//#UC END# *561618E6019B_518A10050368set_var*
begin
//#UC START# *561618E6019B_518A10050368set_impl*
 f_TrftsWidthB := aValue;
//#UC END# *561618E6019B_518A10050368set_impl*
end;//TddRowProperty.pm_SetTrftsWidthB

function TddRowProperty.pm_GetTrwWidthA: LongInt;
//#UC START# *56161936018E_518A10050368get_var*
//#UC END# *56161936018E_518A10050368get_var*
begin
//#UC START# *56161936018E_518A10050368get_impl*
 Result := f_TrwWidthA;
//#UC END# *56161936018E_518A10050368get_impl*
end;//TddRowProperty.pm_GetTrwWidthA

procedure TddRowProperty.pm_SetTrwWidthA(aValue: LongInt);
//#UC START# *56161936018E_518A10050368set_var*
//#UC END# *56161936018E_518A10050368set_var*
begin
//#UC START# *56161936018E_518A10050368set_impl*
 f_TrwWidthA := aValue;
//#UC END# *56161936018E_518A10050368set_impl*
end;//TddRowProperty.pm_SetTrwWidthA

procedure TddRowProperty.MergeWith(P: TddPropertyObject);
//#UC START# *525E369F0158_518A10050368_var*
//#UC END# *525E369F0158_518A10050368_var*
begin
//#UC START# *525E369F0158_518A10050368_impl*
 Assert(False);
//#UC END# *525E369F0158_518A10050368_impl*
end;//TddRowProperty.MergeWith

procedure TddRowProperty.InheriteFrom(P: TddPropertyObject);
//#UC START# *525E37430345_518A10050368_var*
//#UC END# *525E37430345_518A10050368_var*
begin
//#UC START# *525E37430345_518A10050368_impl*
 Assert(False);
//#UC END# *525E37430345_518A10050368_impl*
end;//TddRowProperty.InheriteFrom

procedure TddRowProperty.Write2Generator(const Generator: Ik2TagGenerator);
//#UC START# *525E377B007E_518A10050368_var*
//#UC END# *525E377B007E_518A10050368_var*
begin
//#UC START# *525E377B007E_518A10050368_impl*
 Assert(False);
//#UC END# *525E377B007E_518A10050368_impl*
end;//TddRowProperty.Write2Generator

procedure TddRowProperty.Reset;
//#UC START# *525E478A0232_518A10050368_var*
//#UC END# *525E478A0232_518A10050368_var*
begin
//#UC START# *525E478A0232_518A10050368_impl*
 Assert(False);
//#UC END# *525E478A0232_518A10050368_impl*
end;//TddRowProperty.Reset

function TddRowProperty.Diff(P: TddPropertyObject;
  aForReader: Boolean): TddPropertyObject;
//#UC START# *525E47E10065_518A10050368_var*
//#UC END# *525E47E10065_518A10050368_var*
begin
//#UC START# *525E47E10065_518A10050368_impl*
 Assert(False);
 Result := nil;
//#UC END# *525E47E10065_518A10050368_impl*
end;//TddRowProperty.Diff

constructor TddRowProperty.Create;
//#UC START# *47914F960008_518A10050368_var*
//#UC END# *47914F960008_518A10050368_var*
begin
//#UC START# *47914F960008_518A10050368_impl*
 inherited;
 f_RowIndex := -1;
 f_Gaph := ddDefaultPad;
 f_Left := -ddDefaultPad;
 f_Width := 0;
 f_IsLastRow := False;
 f_Border := TddBorder.Create;
 f_Border.isFramed := True;
 f_Border.BorderOwner := boRow;
 f_trwWidthB := 0;
 f_trwWidthA := 0;
 f_trftsWidthA := dd_wuNull;
 f_trftsWidthB := dd_wuNull;
//#UC END# *47914F960008_518A10050368_impl*
end;//TddRowProperty.Create

procedure TddRowProperty.Cleanup;
//#UC START# *479731C50290_518A10050368_var*
//#UC END# *479731C50290_518A10050368_var*
begin
//#UC START# *479731C50290_518A10050368_impl*
 f_IsLastRow := False;
 f_RowIndex := -1;
 l3Free(f_Border);
 f_trwWidthB := 0;
 f_trwWidthA := 0;
 f_trftsWidthA := dd_wuNull;
 f_trftsWidthB := dd_wuNull;
 inherited;
//#UC END# *479731C50290_518A10050368_impl*
end;//TddRowProperty.Cleanup

procedure TddRowProperty.Clear;
//#UC START# *518A13330058_518A10050368_var*
//#UC END# *518A13330058_518A10050368_var*
begin
//#UC START# *518A13330058_518A10050368_impl*
 f_RowIndex := -1;
 f_IsLastRow := False;
 f_Border.Clear;
 Left := -ddDefaultPad;
 Gaph := ddDefaultPad;
 f_trwWidthB := 0;
 f_trwWidthA := 0;
 f_trftsWidthA := dd_wuNull;
 f_trftsWidthB := dd_wuNull;
//#UC END# *518A13330058_518A10050368_impl*
end;//TddRowProperty.Clear

procedure TddRowProperty.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_518A10050368_var*
//#UC END# *5301DFE6002C_518A10050368_var*
begin
//#UC START# *5301DFE6002C_518A10050368_impl*
 if (anOther is TddRowProperty) then
 begin
  Left := TddRowProperty(anOther).Left;
  Gaph := TddRowProperty(anOther).Gaph;
  trwWidthB := TddRowProperty(anOther).trwWidthB;
  trwWidthA := TddRowProperty(anOther).trwWidthA;
  trftsWidthA := TddRowProperty(anOther).trftsWidthA;
  trftsWidthB := TddRowProperty(anOther).trftsWidthB;
  RowIndex := TddRowProperty(anOther).RowIndex;
  IsLastRow := TddRowProperty(anOther).IsLastRow;
  f_Border.AssignFrom(TddRowProperty(anOther).Border);
 end // if (anOther is TddRowProperty) then
 else
  inherited AssignFrom(anOther);
//#UC END# *5301DFE6002C_518A10050368_impl*
end;//TddRowProperty.AssignFrom

end.