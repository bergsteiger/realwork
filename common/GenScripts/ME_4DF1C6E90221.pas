unit PrintRowHeightsSpy;
 {* Проверяльщик высот строк на разных страницах }

// Модуль: "w:\common\components\gui\Garant\Everest\new\PrintRowHeightsSpy.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3ProtoObject
 , l3Filer
;

type
 TRowHeight = record
  rTableID: Integer;
  rRowID: Integer;
  rHeight: Integer;
  rPage: Integer;
  rTopAnchorID: Integer;
 end;//TRowHeight

 _ItemType_ = TRowHeight;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TRowHeightsList = class(_l3RecordListPrim_)
 end;//TRowHeightsList

 TPrintRowHeightsSpy = class(Tl3ProtoObject)
  {* Следилка за высотами строк на разных страницах }
  private
   f_Filer: Tl3CustomFiler;
  public
   f_RowHeights: TRowHeightsList;
  protected
   procedure Release; override;
   procedure BeforeAddToCache; override;
    {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
  public
   procedure AddRowData(const aData: TRowHeight);
    {* Добавить данные о высоте строки. }
   procedure ClearData;
    {* Очистить данные о строках. }
   class function Exists: Boolean;
   procedure StartLogging(const aLogName: AnsiString);
   procedure StopLogging;
   class function Instance: TPrintRowHeightsSpy;
    {* Метод получения экземпляра синглетона TPrintRowHeightsSpy }
 end;//TPrintRowHeightsSpy
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , evConst
;

var g_TPrintRowHeightsSpy: TPrintRowHeightsSpy = nil;
 {* Экземпляр синглетона TPrintRowHeightsSpy }

procedure TPrintRowHeightsSpyFree;
 {* Метод освобождения экземпляра синглетона TPrintRowHeightsSpy }
begin
 l3Free(g_TPrintRowHeightsSpy);
end;//TPrintRowHeightsSpyFree

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4DF1C7F20336_var*
//#UC END# *47B07CF403D0_4DF1C7F20336_var*
begin
//#UC START# *47B07CF403D0_4DF1C7F20336_impl*
 Result := (A.rTableID = B.rTableID) and
           (A.rRowID = B.rRowID) and (A.rPage = B.rPage);
//#UC END# *47B07CF403D0_4DF1C7F20336_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4DF1C7F20336_var*
//#UC END# *47B2C42A0163_4DF1C7F20336_var*
begin
//#UC START# *47B2C42A0163_4DF1C7F20336_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4DF1C7F20336_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4DF1C7F20336_var*
//#UC END# *47B99D4503A2_4DF1C7F20336_var*
begin
//#UC START# *47B99D4503A2_4DF1C7F20336_impl*
  Result := CI.rA^.rTableID - CI.rB^.rTableID;
 if Result = 0 then
  Result := CI.rA^.rRowID - CI.rB^.rRowID;
 if Result = 0 then
  Result := CI.rA^.rPage - CI.rB^.rPage; 
//#UC END# *47B99D4503A2_4DF1C7F20336_impl*
end;//CompareExistingItems

type _Instance_R_ = TRowHeightsList;

{$Include l3RecordListPrim.imp.pas}

procedure TPrintRowHeightsSpy.AddRowData(const aData: TRowHeight);
 {* Добавить данные о высоте строки. }
//#UC START# *4DF1C9B1012D_4DF1C7300012_var*

  function MangleCoord(aValue : Integer): Integer;
  begin
   Result := (aValue div 100) * 100;
  end;

var
 l_Index  : Integer;
 l_Height : Integer;
 l_Delta  : Integer;
//#UC END# *4DF1C9B1012D_4DF1C7300012_var*
begin
//#UC START# *4DF1C9B1012D_4DF1C7300012_impl*
 if aData.rPage = -1 then Exit;
 if f_RowHeights = nil then
  f_RowHeights := TRowHeightsList.Create;
 if f_RowHeights.FindData(aData, l_Index) then
 begin
  l_Height := f_RowHeights[l_Index].rHeight;
  l_Delta := Abs(l_Height - aData.rHeight);
  f_Filer.WriteLn(Format('%d %d %d %d', [aData.rRowID, aData.rPage, MangleCoord(l_Height), MangleCoord(aData.rHeight)]));
  if (l_Delta >= 3 * evEpsilon) then
   f_Filer.WriteLn(Format('Несовпадают высоты строки %d на странице %d: %d, %d', [aData.rRowID - aData.rTopAnchorID, aData.rPage, MangleCoord(l_Height), MangleCoord(aData.rHeight)]));
 end // if f_RowHeights.FindData(aData, l_Index) then
 else
  f_RowHeights.Add(aData);
//#UC END# *4DF1C9B1012D_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.AddRowData

procedure TPrintRowHeightsSpy.ClearData;
 {* Очистить данные о строках. }
//#UC START# *4DF1CA0803E2_4DF1C7300012_var*
//#UC END# *4DF1CA0803E2_4DF1C7300012_var*
begin
//#UC START# *4DF1CA0803E2_4DF1C7300012_impl*
 if (f_RowHeights <> nil) and (f_RowHeights.Count > 0) then
 begin
  f_Filer.WriteLn('Окончание страницы');
  f_RowHeights.Clear;
 end; // if f_RowHeights <> nil then
//#UC END# *4DF1CA0803E2_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.ClearData

class function TPrintRowHeightsSpy.Exists: Boolean;
//#UC START# *4DF1DB350207_4DF1C7300012_var*
//#UC END# *4DF1DB350207_4DF1C7300012_var*
begin
//#UC START# *4DF1DB350207_4DF1C7300012_impl*
 Result := (g_TPrintRowHeightsSpy <> nil) and (g_TPrintRowHeightsSpy.f_Filer <> nil);
//#UC END# *4DF1DB350207_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.Exists

procedure TPrintRowHeightsSpy.StartLogging(const aLogName: AnsiString);
//#UC START# *4DF8692C0010_4DF1C7300012_var*
//#UC END# *4DF8692C0010_4DF1C7300012_var*
begin
//#UC START# *4DF8692C0010_4DF1C7300012_impl*
 Assert(f_Filer = nil);
 f_Filer := Tl3CustomDOSFiler.Make(aLogName, l3_fmWrite);
 f_Filer.Open; 
//#UC END# *4DF8692C0010_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.StartLogging

procedure TPrintRowHeightsSpy.StopLogging;
//#UC START# *4DF869520107_4DF1C7300012_var*
//#UC END# *4DF869520107_4DF1C7300012_var*
begin
//#UC START# *4DF869520107_4DF1C7300012_impl*
 try
  f_Filer.Close;
 finally
  l3Free(f_Filer);
 end;
//#UC END# *4DF869520107_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.StopLogging

class function TPrintRowHeightsSpy.Instance: TPrintRowHeightsSpy;
 {* Метод получения экземпляра синглетона TPrintRowHeightsSpy }
begin
 if (g_TPrintRowHeightsSpy = nil) then
 begin
  l3System.AddExitProc(TPrintRowHeightsSpyFree);
  g_TPrintRowHeightsSpy := Create;
 end;
 Result := g_TPrintRowHeightsSpy;
end;//TPrintRowHeightsSpy.Instance

procedure TPrintRowHeightsSpy.Release;
//#UC START# *479F2AFB0397_4DF1C7300012_var*
//#UC END# *479F2AFB0397_4DF1C7300012_var*
begin
//#UC START# *479F2AFB0397_4DF1C7300012_impl*
 l3Free(f_RowHeights);
//#UC END# *479F2AFB0397_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.Release

procedure TPrintRowHeightsSpy.BeforeAddToCache;
 {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
//#UC START# *479F2B3302C1_4DF1C7300012_var*
//#UC END# *479F2B3302C1_4DF1C7300012_var*
begin
//#UC START# *479F2B3302C1_4DF1C7300012_impl*
 if f_RowHeights <> nil then
  f_RowHeights.Clear;
//#UC END# *479F2B3302C1_4DF1C7300012_impl*
end;//TPrintRowHeightsSpy.BeforeAddToCache
{$IfEnd} // Defined(nsTest)

end.
