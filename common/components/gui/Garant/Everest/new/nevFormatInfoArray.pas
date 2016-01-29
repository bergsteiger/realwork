unit nevFormatInfoArray;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevFormatInfoArray.pas"
// Начат: 11.11.2008 14:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Rendering::TnevFormatInfoArray
//
// "Разреженный" массив с информацией о форматировании параграфов, см. [$122672470]
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevFormatInfo,
  nevFormatInfoList,
  l3CProtoObject
  ;

type
 TnevFormatInfoArray = class(Tl3CProtoObject)
  {* "Разреженный" массив с информацией о форматировании параграфов, см. [$122672470] }
 private
 // private fields
   f_Children : TnevFormatInfoList;
   f_IndexOfs : Integer;
 protected
 // property methods
   function pm_GetItems(anIndex: Integer): TnevFormatInfo;
   procedure pm_SetItems(anIndex: Integer; aValue: TnevFormatInfo);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   procedure ClearReferencesToParentFormatInfo;
   procedure ChildAdded(anIndex: Integer);
   procedure ChildDeleted(anIndex: Integer);
 public
 // public properties
   property Items[anIndex: Integer]: TnevFormatInfo
     read pm_GetItems
     write pm_SetItems;
     default;
 end;//TnevFormatInfoArray

implementation

uses
  SysUtils
  ;

// start class TnevFormatInfoArray

procedure TnevFormatInfoArray.ClearReferencesToParentFormatInfo;
//#UC START# *4EA57037029A_49196E5F01CD_var*
//#UC END# *4EA57037029A_49196E5F01CD_var*
begin
//#UC START# *4EA57037029A_49196E5F01CD_impl*
 if (f_Children <> nil) then
  f_Children.ClearReferencesToParentFormatInfo;
//#UC END# *4EA57037029A_49196E5F01CD_impl*
end;//TnevFormatInfoArray.ClearReferencesToParentFormatInfo

function TnevFormatInfoArray.pm_GetItems(anIndex: Integer): TnevFormatInfo;
//#UC START# *49196FB8039F_49196E5F01CDget_var*
//#UC END# *49196FB8039F_49196E5F01CDget_var*
begin
//#UC START# *49196FB8039F_49196E5F01CDget_impl*
 if (anIndex < f_IndexOfs) then
  Result := nil
 else
 if (f_Children = nil) then
  Result := nil
 else
 if (anIndex - f_IndexOfs >= f_Children.Count) then
  Result := nil
 else
  Result := f_Children[anIndex - f_IndexOfs];
//#UC END# *49196FB8039F_49196E5F01CDget_impl*
end;//TnevFormatInfoArray.pm_GetItems

procedure TnevFormatInfoArray.pm_SetItems(anIndex: Integer; aValue: TnevFormatInfo);
//#UC START# *49196FB8039F_49196E5F01CDset_var*
//#UC END# *49196FB8039F_49196E5F01CDset_var*
begin
//#UC START# *49196FB8039F_49196E5F01CDset_impl*
 if ((f_Children = nil) OR f_Children.Empty) AND (aValue = nil) then
  Exit;
 if (f_Children = nil) then
  f_Children := TnevFormatInfoList.Create;
 if f_Children.Empty then
  f_IndexOfs := anIndex;
  // - пустую голову списка можно не хранить
 if (anIndex < f_IndexOfs) then
 // - надо вставить в начало
 begin
  if (aValue = nil) then
   Exit;
  while (anIndex < f_IndexOfs) do
  begin
   f_Children.Insert(0, nil);
   Dec(f_IndexOfs);
  end;//while (anIndex < f_IndexOfs)
  Assert(f_IndexOfs >= 0)
 end//anIndex < f_IndexOfs
 else 
 if (f_Children.Count <= anIndex - f_IndexOfs) then
 begin
  if (aValue = nil) then
   Exit;
  f_Children.Count := anIndex - f_IndexOfs + 1;
 end;//f_Children.Count <= anIndex
 Assert(anIndex - f_IndexOfs >= 0);
 f_Children[anIndex - f_IndexOfs] := aValue;
//#UC END# *49196FB8039F_49196E5F01CDset_impl*
end;//TnevFormatInfoArray.pm_SetItems

procedure TnevFormatInfoArray.ChildAdded(anIndex: Integer);
//#UC START# *491972F102A1_49196E5F01CD_var*
//#UC END# *491972F102A1_49196E5F01CD_var*
begin
//#UC START# *491972F102A1_49196E5F01CD_impl*
 if (anIndex - f_IndexOfs >= 0) then
  if (f_Children <> nil) then
   if (f_Children.Count > anIndex - f_IndexOfs) then
    f_Children.Insert(anIndex - f_IndexOfs, nil);
//#UC END# *491972F102A1_49196E5F01CD_impl*
end;//TnevFormatInfoArray.ChildAdded

procedure TnevFormatInfoArray.ChildDeleted(anIndex: Integer);
//#UC START# *491973120092_49196E5F01CD_var*
//#UC END# *491973120092_49196E5F01CD_var*
begin
//#UC START# *491973120092_49196E5F01CD_impl*
 if (anIndex - f_IndexOfs >= 0) then
  if (f_Children <> nil) then
   if (f_Children.Count > anIndex - f_IndexOfs) then
   begin
    f_Children.Delete(anIndex - f_IndexOfs);
    if f_Children.Empty then
     f_IndexOfs := 0;
   end;//f_Children.Count > anIndex - f_IndexOfs
//#UC END# *491973120092_49196E5F01CD_impl*
end;//TnevFormatInfoArray.ChildDeleted

procedure TnevFormatInfoArray.Cleanup;
//#UC START# *479731C50290_49196E5F01CD_var*
//#UC END# *479731C50290_49196E5F01CD_var*
begin
//#UC START# *479731C50290_49196E5F01CD_impl*
 FreeAndNil(f_Children);
 f_IndexOfs := 0;
 inherited;
//#UC END# *479731C50290_49196E5F01CD_impl*
end;//TnevFormatInfoArray.Cleanup

end.