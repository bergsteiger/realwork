unit l3ListUtils;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ListUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3ListUtils" MUID: (5721B7D401CF)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintList
 , l3DatLst
 , Classes
;

function l3IsIdenticalLists(aL1: Tl3LongintList;
 aL2: Tl3LongintList;
 aOrderIsImportant: Boolean = False): Boolean; overload;
function l3IsIdenticalLists(aL1: Tl3StringDataList;
 aL2: Tl3StringDataList): Boolean; overload;
function l3IsIdenticalLists(aL1: TStrings;
 aL2: TStrings): Boolean; overload;

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *5721B7D401CFimpl_uses*
 //#UC END# *5721B7D401CFimpl_uses*
;

function l3IsIdenticalLists(aL1: Tl3LongintList;
 aL2: Tl3LongintList;
 aOrderIsImportant: Boolean = False): Boolean;
//#UC START# *5721B80000C0_5721B7D401CF_var*
var
 I: Integer;
//#UC END# *5721B80000C0_5721B7D401CF_var*
begin
//#UC START# *5721B80000C0_5721B7D401CF_impl*
 Result := (Pointer(aL1) = Pointer(aL2));
 if not Result then
 begin
  if (aL1 = nil) or (aL2 = nil) then
   Exit;
  if aL1.Count = aL2.Count then
  begin
   if aOrderIsImportant then
   begin
    for I := 0 to Pred(aL1.Count) do
    begin
     Result := aL1.Items[I] = aL2.Items[I];
     if not Result then
      Exit;
    end;
   end
   else
   begin
    for I := 0 to Pred(aL1.Count) do
    begin
     Result := aL1.IndexOf(aL2.Items[I]) >= 0;
     if not Result then
      Exit;
    end;
   end;
  end;
 end;
//#UC END# *5721B80000C0_5721B7D401CF_impl*
end;//l3IsIdenticalLists

function l3IsIdenticalLists(aL1: Tl3StringDataList;
 aL2: Tl3StringDataList): Boolean;
//#UC START# *5721BC780362_5721B7D401CF_var*
var
 l_IDX: Integer;
//#UC END# *5721BC780362_5721B7D401CF_var*
begin
//#UC START# *5721BC780362_5721B7D401CF_impl*
 Result := (Pointer(aL1) = Pointer(aL2));
 if not Result then
 begin
  if (aL1 = nil) or (aL2 = nil) then
   Exit;
  if (aL1.Count = aL2.Count) and (aL1.DataSize = aL2.DataSize) and (aL1.DataSize <> 0) then
  begin
   for l_IDX := 0 to aL1.Count - 1 do
   begin
    if aL1.PasStr[l_IDX] <> aL2.PasStr[l_IDX] then
     Exit;
    if not CompareMem(aL1.Data[l_IDX], aL2.Data[l_IDX], aL1.DataSize) then
     Exit;
   end;
   Result := True;
  end;
 end;
//#UC END# *5721BC780362_5721B7D401CF_impl*
end;//l3IsIdenticalLists

function l3IsIdenticalLists(aL1: TStrings;
 aL2: TStrings): Boolean;
//#UC START# *57AADAD40150_5721B7D401CF_var*
var
 l_IDX: Integer;
//#UC END# *57AADAD40150_5721B7D401CF_var*
begin
//#UC START# *57AADAD40150_5721B7D401CF_impl*
 Result := (Pointer(aL1) = Pointer(aL2));
 if not Result then
 begin
  if (aL1 = nil) or (aL2 = nil) then
   Exit;
  if (aL1.Count = aL2.Count) then
  begin
   for l_IDX := 0 to aL1.Count - 1 do
   begin
    if aL1[l_IDX] <> aL2[l_IDX] then
     Exit;
    if Pointer(aL1.Objects[l_IDX]) <> Pointer(aL2.Objects[l_IDX]) then
     Exit;
   end;
   Result := True;
  end;
 end;
//#UC END# *57AADAD40150_5721B7D401CF_impl*
end;//l3IsIdenticalLists

end.
