unit l3ValueMapManager;
 {* ������� ���������� ��������� ��� "������"-���-��. }

// ������: "w:\common\components\rtl\Garant\L3\l3ValueMapManager.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ValueMapManagerPrim
 , l3Interfaces
 , l3ValueMap
 , l3Types
;

type
 _FindDataType_ = Tl3ValueMapID;
 _l3Searcher_Parent_ = Tl3ValueMapManagerPrim;
 {$Include l3Searcher.imp.pas}
 Tl3ValueMapManager = class(_l3Searcher_)
  {* ������� ���������� ��������� ��� "������"-���-��. }
  protected
   function pm_GetMap(const aID: Tl3ValueMapID): Il3ValueMap; { can raise El3ValueMap }
   function MakeDefaultMap(const aID: Tl3ValueMapID): Il3ValueMap; virtual;
  public
   property Map[const aID: Tl3ValueMapID]: Il3ValueMap
    read pm_GetMap;
 end;//Tl3ValueMapManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer; override;
 {* ���������� ������������ ������� � �������. }
//#UC START# *47B9BAFD01F4_478E372C025D_var*
//#UC END# *47B9BAFD01F4_478E372C025D_var*
begin
//#UC START# *47B9BAFD01F4_478E372C025D_impl*
 //Assert(aSortIndex = l3_siNative);
 Assert(aSortIndex = l3_siByID);
 Result := anItem.MapID.rID - aData.rID;
//#UC END# *47B9BAFD01F4_478E372C025D_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3ValueMapManager;

{$Include l3Searcher.imp.pas}

function Tl3ValueMapManager.pm_GetMap(const aID: Tl3ValueMapID): Il3ValueMap; { can raise El3ValueMap }
//#UC START# *47A1C3DA01BE_478E372C025Dget_var*
var
 l_Index: Integer;
 l_Map: Il3ValueMap;
//#UC END# *47A1C3DA01BE_478E372C025Dget_var*
begin
//#UC START# *47A1C3DA01BE_478E372C025Dget_impl*
 if not FindData(aID, l_Index, l3_siByID) then
  begin
   l_Map := MakeDefaultMap(aID);
   try
    if l_Map<>nil then
     Result := Items[Add(l_Map)]
    else
     Result := nil;
   finally
    l_Map := nil;
   end;
  end
 else
  Result := Items[l_Index];
 if Assigned(Result) and (Result.MapID.rName <> aID.rName) then
  raise El3ValueMap.CreateFmt('Duplicate value map id = %d names (%s - %s)',[aID.rID, Result.MapID.rName, aID.rName]);
//#UC END# *47A1C3DA01BE_478E372C025Dget_impl*
end;//Tl3ValueMapManager.pm_GetMap

function Tl3ValueMapManager.MakeDefaultMap(const aID: Tl3ValueMapID): Il3ValueMap;
//#UC START# *47A1C42301B5_478E372C025D_var*
//#UC END# *47A1C42301B5_478E372C025D_var*
begin
//#UC START# *47A1C42301B5_478E372C025D_impl*
 Assert(False,Format('Value map id %d not found',[aID.rID]));
 Result := nil;
//#UC END# *47A1C42301B5_478E372C025D_impl*
end;//Tl3ValueMapManager.MakeDefaultMap

end.
