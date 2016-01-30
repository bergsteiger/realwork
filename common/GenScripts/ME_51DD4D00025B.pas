unit destListOverrideTable;

// Модуль: "w:\common\components\rtl\Garant\dd\destListOverrideTable.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , destListTable
 , destListoverride
 , ddCustomRTFReader
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestListOverrideTable = class(TddRTFDestination)
  private
   f_ListOverrideTable: TrtfListOverrideTable;
   f_DestListTable: TdestListTable;
   f_WasRestart: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddListOverride(aListOverride: TdestListoverride);
   function LS2List(aLS: Integer;
    out aWasRestart: Boolean): TrtfList;
   constructor Create(aRTFReader: TddCustomRTFReader;
    const aDestListTable: TdestListTable); reintroduce;
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
 end;//TdestListOverrideTable

implementation

uses
 l3ImplUses
 , SysUtils
 , ddTypes
;

procedure TdestListOverrideTable.AddListOverride(aListOverride: TdestListoverride);
//#UC START# *51DD5870005A_51DD4D00025B_var*
var
 l_LO: TrtfListOverride;
//#UC END# *51DD5870005A_51DD4D00025B_var*
begin
//#UC START# *51DD5870005A_51DD4D00025B_impl*
 l_LO := TrtfListOverride.Create;
 try
  l_LO.Assign(aListOverride.ListOverride);
  f_ListOverrideTable.Add(l_LO);
 finally
  FreeAndNil(l_LO);
 end;
//#UC END# *51DD5870005A_51DD4D00025B_impl*
end;//TdestListOverrideTable.AddListOverride

function TdestListOverrideTable.LS2List(aLS: Integer;
 out aWasRestart: Boolean): TrtfList;
//#UC START# *51DD58890154_51DD4D00025B_var*
var
 i             : Integer;
 l_ListOverride: TrtfListOverride;
//#UC END# *51DD58890154_51DD4D00025B_var*
begin
//#UC START# *51DD58890154_51DD4D00025B_impl*
 Result := nil;
 for i := 0 to f_ListOverrideTable.Hi do
  if TrtfListOverride(f_ListOverrideTable[i]).LS = aLS then
  begin
   l_ListOverride := TrtfListOverride(f_ListOverrideTable[i]);
   Assert(l_ListOverride <> nil);
   Result := f_DestListTable[l_ListOverride.ListID];
   aWasRestart := f_WasRestart;
   f_WasRestart := False;
   if (Result <> nil) and (l_ListOverride.GetStartAtCount > 0) then
   begin
    f_WasRestart := True;
    Result.RestartAt(l_ListOverride.StartAtList);
    l_ListOverride.StartAtList.Clear;
   end; // if (Result <> nil) and (l_ListOverride.StartAt > -1) then 
   Break;
  end; // if TrtfListOverride(f_ListOverrideTable[i]).LS = aLS then
//#UC END# *51DD58890154_51DD4D00025B_impl*
end;//TdestListOverrideTable.LS2List

constructor TdestListOverrideTable.Create(aRTFReader: TddCustomRTFReader;
 const aDestListTable: TdestListTable);
//#UC START# *55829A62037B_51DD4D00025B_var*
//#UC END# *55829A62037B_51DD4D00025B_var*
begin
//#UC START# *55829A62037B_51DD4D00025B_impl*
 inherited Create(aRTFReader);
 f_ListOverrideTable := TrtfListOverrideTable.Create();
 f_DestListTable := aDestListTable;
 f_WasRestart := False;
//#UC END# *55829A62037B_51DD4D00025B_impl*
end;//TdestListOverrideTable.Create

procedure TdestListOverrideTable.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51DD4D00025B_var*
//#UC END# *5461BEC2017D_51DD4D00025B_var*
begin
//#UC START# *5461BEC2017D_51DD4D00025B_impl*

//#UC END# *5461BEC2017D_51DD4D00025B_impl*
end;//TdestListOverrideTable.Close

procedure TdestListOverrideTable.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_51DD4D00025B_var*
//#UC END# *54E1F08400F9_51DD4D00025B_var*
begin
//#UC START# *54E1F08400F9_51DD4D00025B_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51DD4D00025B_impl*
end;//TdestListOverrideTable.WriteText

procedure TdestListOverrideTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51DD4D00025B_var*
//#UC END# *479731C50290_51DD4D00025B_var*
begin
//#UC START# *479731C50290_51DD4D00025B_impl*
 f_WasRestart := False;
 f_DestListTable := nil;
 inherited;
 FreeAndNil(f_ListOverrideTable);
//#UC END# *479731C50290_51DD4D00025B_impl*
end;//TdestListOverrideTable.Cleanup

end.
