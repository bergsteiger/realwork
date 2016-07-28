unit ddExtObjExtractor;
 {* выковыривает объект из EVD-потока и кладет его в поток хранилища }

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjExtractor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExtObjExtractor" MUID: (57987D2802C9)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddExtObjectMachine
 , ddSavedObjectsList
 , l3Variant
 //#UC START# *57987D2802C9intf_uses*
 //#UC END# *57987D2802C9intf_uses*
;

type
 //#UC START# *57987D2802C9ci*
 //#UC END# *57987D2802C9ci*
 //#UC START# *57987D2802C9cit*
 //#UC END# *57987D2802C9cit*
 TddExtObjExtractor = class(TddExtObjectMachine)
  {* выковыривает объект из EVD-потока и кладет его в поток хранилища }
  private
   f_SavedObjects: TddSavedObjectsList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure DocumentIDChanged; override;
 //#UC START# *57987D2802C9publ*
 //#UC END# *57987D2802C9publ*
 end;//TddExtObjExtractor

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *57987D2802C9impl_uses*
 , ActiveX

 , l3Stream

 , k2Tags

 , daSchemeConsts
 //#UC END# *57987D2802C9impl_uses*
;

procedure TddExtObjExtractor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57987D2802C9_var*
//#UC END# *479731C50290_57987D2802C9_var*
begin
//#UC START# *479731C50290_57987D2802C9_impl*
 FreeAndNil(f_SavedObjects);
 inherited;
//#UC END# *479731C50290_57987D2802C9_impl*
end;//TddExtObjExtractor.Cleanup

procedure TddExtObjExtractor.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_57987D2802C9_var*
var
 l_EVDStr : IStream;
//#UC END# *4836D52400D9_57987D2802C9_var*
begin
//#UC START# *4836D52400D9_57987D2802C9_impl*
 if (AtomIndex = k2_tiData) then
 begin
  if (SkipLevel = 2) then
  begin
   assert(DocID <> 0);
   Assert(Value.Kind = k2_vkStream);
   l_EVDStr := l3Stream2IStream(Value.AsStream);
   try
    if (f_SavedObjects = nil) then
     f_SavedObjects := TddSavedObjectsList.Create(CurrentFamily, DocID);
    f_SavedObjects.SaveObject(f_Buffer.Tags.Top.Box, l_EVDStr);
   finally
    l_EVDStr := nil;
   end;//try..finally
   StopBufferingAndFlush(false, TopObject[0], false);
   Exit;
  end;//SkipLevel = 2
 end;//AtomIndex = k2_tiData 
 inherited;
//#UC END# *4836D52400D9_57987D2802C9_impl*
end;//TddExtObjExtractor.AddAtomEx

procedure TddExtObjExtractor.DocumentIDChanged;
//#UC START# *57987D54034E_57987D2802C9_var*
//#UC END# *57987D54034E_57987D2802C9_var*
begin
//#UC START# *57987D54034E_57987D2802C9_impl*
 FreeAndNil(f_SavedObjects);
 inherited;
//#UC END# *57987D54034E_57987D2802C9_impl*
end;//TddExtObjExtractor.DocumentIDChanged

//#UC START# *57987D2802C9impl*
//#UC END# *57987D2802C9impl*

end.
