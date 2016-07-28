unit ddExtObjInserter;
 {* вставляет в EVD-поток объект из потока хранилища }

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjInserter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddExtObjInserter" MUID: (57987CF90375)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddExtObjectMachine
 , ddExtObjectDataList
 , l3Variant
 //#UC START# *57987CF90375intf_uses*
 //#UC END# *57987CF90375intf_uses*
;

type
 //#UC START# *57987CF90375ci*
 //#UC END# *57987CF90375ci*
 //#UC START# *57987CF90375cit*
 //#UC END# *57987CF90375cit*
 TddExtObjInserter = class(TddExtObjectMachine)
  {* вставляет в EVD-поток объект из потока хранилища }
  private
   f_LoadedObjects: TddExtObjectDataList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer;
    aNeedCloseBracket: Boolean); override;
   procedure DocumentIDChanged; override;
 //#UC START# *57987CF90375publ*
 //#UC END# *57987CF90375publ*
 end;//TddExtObjInserter

implementation

uses
 l3ImplUses
 , ddExtObjectData
 , SysUtils
 //#UC START# *57987CF90375impl_uses*
 , ActiveX

 , k2Tags

 , m3StorageInterfaces
 
 , daSchemeConsts

 , Dt_Serv
 //#UC END# *57987CF90375impl_uses*
;

procedure TddExtObjInserter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57987CF90375_var*
//#UC END# *479731C50290_57987CF90375_var*
begin
//#UC START# *479731C50290_57987CF90375_impl*
 FreeAndNil(f_LoadedObjects);
 inherited;
//#UC END# *479731C50290_57987CF90375_impl*
end;//TddExtObjInserter.Cleanup

procedure TddExtObjInserter.DoFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer;
 aNeedCloseBracket: Boolean);
//#UC START# *4D53D8BF00D5_57987CF90375_var*

 procedure AddToGenerator(aData: TddExtObjectData);
 begin//AddToGenerator
  Generator.StartChild(TypeTable.TypeByHandle[-aTagId]);
  try
   aLeaf.AsObject.WriteTag(Generator);
   Generator.AddAtom(k2_tiData, aData);
  finally
   if aNeedCloseBracket then
    Generator.Finish;
  end;//try..finally
 end;//AddToGenerator

var
 l_InternalID: Integer;
 l_ExternalID: Integer;
 l_IStr : IStream;
 l_Data : TddExtObjectData;
 l_Index : Integer;
//#UC END# *4D53D8BF00D5_57987CF90375_var*
begin
//#UC START# *4D53D8BF00D5_57987CF90375_impl*
 assert(DocID <> 0);
 if not aLeaf.Attr[k2_tiData].IsValid then // если данные находятся в потоке хранилища, а не в EVD
 begin
  Assert(aTagId < 0);
  l_InternalID := aLeaf.IntA[k2_tiInternalHandle]; // Это порядковый номер картинки в документе
  l_ExternalID := aLeaf.IntA[k2_tiExternalHandle];
  if (f_LoadedObjects <> nil) then
  begin
   for l_Index := 0 to Pred(f_LoadedObjects.Count) do
   begin
    l_Data := f_LoadedObjects.Items[l_Index];
    if (l_Data.InternalID = l_InternalID) then
    begin
     AddToGenerator(l_Data);
     Exit;
    end;//l_Data.InternalID = l_InternalID
   end;//for l_Index
  end;//f_LoadedObjects <> nil
  l_IStr := dtGetObjectStream(CurrentFamily, DocID, l_InternalID, m3_saRead);
  try
   l_Data := TddExtObjectData.CreateFromIStream(l_IStr, l_InternalID, l_ExternalID);
   try
    l_IStr := nil;
    if (f_LoadedObjects = nil) then
     f_LoadedObjects := TddExtObjectDataList.Create;
    f_LoadedObjects.Add(l_Data);
    AddToGenerator(l_Data);
    Exit;
   finally
    FreeAndNil(l_Data);
   end;//try..finally
  finally
   l_IStr := nil;
  end;//try..finally
 end;// then // если данные находятся в потоке хранилища, а не в EVD
 inherited;
//#UC END# *4D53D8BF00D5_57987CF90375_impl*
end;//TddExtObjInserter.DoFlushBuffer

procedure TddExtObjInserter.DocumentIDChanged;
//#UC START# *57987D54034E_57987CF90375_var*
//#UC END# *57987D54034E_57987CF90375_var*
begin
//#UC START# *57987D54034E_57987CF90375_impl*
 FreeAndNil(f_LoadedObjects);
 inherited;
//#UC END# *57987D54034E_57987CF90375_impl*
end;//TddExtObjInserter.DocumentIDChanged

//#UC START# *57987CF90375impl*
//#UC END# *57987CF90375impl*

end.
