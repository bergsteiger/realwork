unit destListTable;

// Модуль: "w:\common\components\rtl\Garant\dd\destListTable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestListTable" MUID: (51DD4CDC0343)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , destList
 , ddCustomRTFReader
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestListTable = class(TddRTFDestination)
  private
   f_Lists: TrtfListTable;
  protected
   function pm_GetItems(anIndex: Integer): TrtfList;
   function pm_GetCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddList(aList: TdestList);
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
  public
   property Items[anIndex: Integer]: TrtfList
    read pm_GetItems;
    default;
   property Count: Integer
    read pm_GetCount;
 end;//TdestListTable

implementation

uses
 l3ImplUses
 , SysUtils
;

function TdestListTable.pm_GetItems(anIndex: Integer): TrtfList;
//#UC START# *51DD525200F4_51DD4CDC0343get_var*
var
 i: Integer;
//#UC END# *51DD525200F4_51DD4CDC0343get_var*
begin
//#UC START# *51DD525200F4_51DD4CDC0343get_impl*
 Result := nil;
 for i:= 0 to f_Lists.Hi do
  if TrtfList(f_Lists[i]).ID = anIndex then
  begin
   Result:= TrtfList(f_Lists[i]);
   Break;
  end;
//#UC END# *51DD525200F4_51DD4CDC0343get_impl*
end;//TdestListTable.pm_GetItems

function TdestListTable.pm_GetCount: Integer;
//#UC START# *51DD5310001B_51DD4CDC0343get_var*
//#UC END# *51DD5310001B_51DD4CDC0343get_var*
begin
//#UC START# *51DD5310001B_51DD4CDC0343get_impl*
 Result := f_Lists.Count;
//#UC END# *51DD5310001B_51DD4CDC0343get_impl*
end;//TdestListTable.pm_GetCount

procedure TdestListTable.AddList(aList: TdestList);
//#UC START# *51DD52C10041_51DD4CDC0343_var*
//#UC END# *51DD52C10041_51DD4CDC0343_var*
begin
//#UC START# *51DD52C10041_51DD4CDC0343_impl*
 f_Lists.AddList(aList.List);
//#UC END# *51DD52C10041_51DD4CDC0343_impl*
end;//TdestListTable.AddList

procedure TdestListTable.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51DD4CDC0343_var*
//#UC END# *5461BEC2017D_51DD4CDC0343_var*
begin
//#UC START# *5461BEC2017D_51DD4CDC0343_impl*

//#UC END# *5461BEC2017D_51DD4CDC0343_impl*
end;//TdestListTable.Close

procedure TdestListTable.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_51DD4CDC0343_var*
//#UC END# *54E1F08400F9_51DD4CDC0343_var*
begin
//#UC START# *54E1F08400F9_51DD4CDC0343_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51DD4CDC0343_impl*
end;//TdestListTable.WriteText

procedure TdestListTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51DD4CDC0343_var*
//#UC END# *479731C50290_51DD4CDC0343_var*
begin
//#UC START# *479731C50290_51DD4CDC0343_impl*
 inherited Cleanup;
 FreeAndNil(f_Lists);
//#UC END# *479731C50290_51DD4CDC0343_impl*
end;//TdestListTable.Cleanup

constructor TdestListTable.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51DD4CDC0343_var*
//#UC END# *51E7C9DB0213_51DD4CDC0343_var*
begin
//#UC START# *51E7C9DB0213_51DD4CDC0343_impl*
 inherited Create(aRTFReader);
 f_Lists := TrtfListTable.Make;
//#UC END# *51E7C9DB0213_51DD4CDC0343_impl*
end;//TdestListTable.Create

end.
