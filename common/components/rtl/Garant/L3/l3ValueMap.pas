unit l3ValueMap;
 {* базовая реализация мап "строка"-что-то. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ValueMap.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ValueMap" MUID: (478797300345)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseWithIDList
 , l3Interfaces
 , l3Except
;

type
 El3ValueMap = class(El3Error)
 end;//El3ValueMap

 El3ValueMapValueNotFound = class(El3ValueMap)
 end;//El3ValueMapValueNotFound

 Tl3ValueMap = class(Tl3BaseWithIDList, Il3ValueMap)
  {* базовая реализация мап "строка"-что-то. }
  private
   f_rMapID: Tl3ValueMapID;
  protected
   procedure DoGetDisplayNames(const aList: Il3StringsEx); virtual;
   function GetMapSize: Integer; virtual;
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* заполняет список значениями "UI-строка" }
   function MapSize: Integer;
    {* количество элементов в мапе. }
   procedure ClearFields; override;
  public
   constructor Create(const aID: Tl3ValueMapID); reintroduce; virtual;
  protected
   property rMapID: Tl3ValueMapID
    read f_rMapID;
 end;//Tl3ValueMap

implementation

uses
 l3ImplUses
 , l3Base
;

procedure Tl3ValueMap.DoGetDisplayNames(const aList: Il3StringsEx);
//#UC START# *478CFFBA017D_478797300345_var*
//#UC END# *478CFFBA017D_478797300345_var*
begin
//#UC START# *478CFFBA017D_478797300345_impl*
 aList.Clear;
//#UC END# *478CFFBA017D_478797300345_impl*
end;//Tl3ValueMap.DoGetDisplayNames

function Tl3ValueMap.GetMapSize: Integer;
//#UC START# *478CFFCE02DE_478797300345_var*
//#UC END# *478CFFCE02DE_478797300345_var*
begin
//#UC START# *478CFFCE02DE_478797300345_impl*
 Result := 0;
//#UC END# *478CFFCE02DE_478797300345_impl*
end;//Tl3ValueMap.GetMapSize

constructor Tl3ValueMap.Create(const aID: Tl3ValueMapID);
//#UC START# *478D01660020_478797300345_var*
//#UC END# *478D01660020_478797300345_var*
begin
//#UC START# *478D01660020_478797300345_impl*
 inherited Create;
 f_rMapID := aID;
//#UC END# *478D01660020_478797300345_impl*
end;//Tl3ValueMap.Create

function Tl3ValueMap.pm_GetMapID: Tl3ValueMapID;
//#UC START# *46A5EFE602DE_478797300345get_var*
//#UC END# *46A5EFE602DE_478797300345get_var*
begin
//#UC START# *46A5EFE602DE_478797300345get_impl*
 Result := f_rMapID;
//#UC END# *46A5EFE602DE_478797300345get_impl*
end;//Tl3ValueMap.pm_GetMapID

procedure Tl3ValueMap.GetDisplayNames(const aList: Il3StringsEx);
 {* заполняет список значениями "UI-строка" }
//#UC START# *46A5F0130365_478797300345_var*
//#UC END# *46A5F0130365_478797300345_var*
begin
//#UC START# *46A5F0130365_478797300345_impl*
 DoGetDisplayNames(aList);
//#UC END# *46A5F0130365_478797300345_impl*
end;//Tl3ValueMap.GetDisplayNames

function Tl3ValueMap.MapSize: Integer;
 {* количество элементов в мапе. }
//#UC START# *46A5F03800A2_478797300345_var*
//#UC END# *46A5F03800A2_478797300345_var*
begin
//#UC START# *46A5F03800A2_478797300345_impl*
 Result := GetMapSize;
//#UC END# *46A5F03800A2_478797300345_impl*
end;//Tl3ValueMap.MapSize

procedure Tl3ValueMap.ClearFields;
begin
 Finalize(f_rMapID);
 inherited;
end;//Tl3ValueMap.ClearFields

end.
