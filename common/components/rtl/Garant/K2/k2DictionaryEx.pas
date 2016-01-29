unit k2DictionaryEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Модуль: "w:/common/components/rtl/Garant/K2/k2DictionaryEx.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2DictionaryEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base,
  k2Dictionary,
  l3Variant
  ;

type
 TLastRec = record
  {* Предыдущий элемент, к которому обращались }
   rID : Integer; // Идентификатор элемента
   rTag : Tl3Tag; // Собственно элемент
 end;//TLastRec

 Tk2DictionaryEx = class(Tk2Dictionary)
 private
 // private fields
   f_AtomType : Tk2Type;
    {* Поле для свойства AtomType}
 protected
 // overridden property methods
   function pm_GetDRByID(anID: Integer): _StringType_; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   f_LastRec : TLastRec;
 public
 // public methods
   constructor Create(aType: Tk2Type); reintroduce;
 protected
 // protected properties
   property AtomType: Tk2Type
     read f_AtomType;
 end;//Tk2DictionaryEx

implementation

uses
  k2Tags
  ;

// start class Tk2DictionaryEx

constructor Tk2DictionaryEx.Create(aType: Tk2Type);
//#UC START# *53565C580228_535664EC03B3_var*
//#UC END# *53565C580228_535664EC03B3_var*
begin
//#UC START# *53565C580228_535664EC03B3_impl*
 f_AtomType := aType;
 MakeSorted;
//#UC END# *53565C580228_535664EC03B3_impl*
end;//Tk2DictionaryEx.Create

procedure Tk2DictionaryEx.Cleanup;
//#UC START# *479731C50290_535664EC03B3_var*
//#UC END# *479731C50290_535664EC03B3_var*
begin
//#UC START# *479731C50290_535664EC03B3_impl*
 f_LastRec.rTag := nil;
 inherited;
//#UC END# *479731C50290_535664EC03B3_impl*
end;//Tk2DictionaryEx.Cleanup

function Tk2DictionaryEx.pm_GetDRByID(anID: Integer): _StringType_;
//#UC START# *4B8BBA220048_535664EC03B3get_var*
//#UC END# *4B8BBA220048_535664EC03B3get_var*
begin
//#UC START# *4B8BBA220048_535664EC03B3get_impl*
 if (f_LastRec.rTag <> nil) AND (f_LastRec.rID = anID) then
  Result := f_LastRec.rTag
 else
 begin
  Result := inherited pm_GetDRByID(anID);
  if (Result <> nil) then
  begin
   f_LastRec.rTag := Result;
   f_LastRec.rID := anID;
  end//Result <> nil
 end;//(f_LastRec.rTag <> nil) AND (f_LastRec.rID = anID)
//#UC END# *4B8BBA220048_535664EC03B3get_impl*
end;//Tk2DictionaryEx.pm_GetDRByID

end.