unit k2DictionaryEx;

// Модуль: "w:\common\components\rtl\Garant\K2\k2DictionaryEx.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2DictionaryEx" MUID: (535664EC03B3)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2Dictionary
 , k2Base
 , l3Variant
;

type
 TLastRec = record
  {* Предыдущий элемент, к которому обращались }
  rID: Integer;
   {* Идентификатор элемента }
  rTag: Tl3Tag;
   {* Собственно элемент }
 end;//TLastRec

 Tk2DictionaryEx = class(Tk2Dictionary)
  private
   f_AtomType: Tk2Type;
  protected
   f_LastRec: TLastRec;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetDRByID(anID: Integer): _StringType_; override;
  public
   constructor Create(aType: Tk2Type); reintroduce;
  protected
   property AtomType: Tk2Type
    read f_AtomType;
 end;//Tk2DictionaryEx

implementation

uses
 l3ImplUses
 , k2Tags
 //#UC START# *535664EC03B3impl_uses*
 //#UC END# *535664EC03B3impl_uses*
;

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
 {* Функция очистки полей объекта. }
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
