unit htFromTable;

// Модуль: "w:\common\components\rtl\Garant\HT\htFromTable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtFromTable" MUID: (55530BB9007A)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , daFromTable
 , htInterfaces
 {$If NOT Defined(Nemesis)}
 , HT_Const
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 ThtFromTable = class(TdaFromTable, IhtFromTable)
  private
   f_Handle: ThtTblHandle;
  protected
   function Get_Handle: ThtTblHandle;
   procedure Prepare(const aHelper: IhtDataSchemeHelper;
    RequireNewHandle: Boolean);
   procedure Unprepare;
 end;//ThtFromTable

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , HT_DLL
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Err
 {$IfEnd} // NOT Defined(Nemesis)
;

function ThtFromTable.Get_Handle: ThtTblHandle;
//#UC START# *555C8490016F_55530BB9007Aget_var*
//#UC END# *555C8490016F_55530BB9007Aget_var*
begin
//#UC START# *555C8490016F_55530BB9007Aget_impl*
 Result := f_Handle;
//#UC END# *555C8490016F_55530BB9007Aget_impl*
end;//ThtFromTable.Get_Handle

procedure ThtFromTable.Prepare(const aHelper: IhtDataSchemeHelper;
 RequireNewHandle: Boolean);
//#UC START# *555C91AF003A_55530BB9007A_var*
var
 hTable : ThtTblHandle;
 l_Ok   : Longint;
//#UC END# *555C91AF003A_55530BB9007A_var*
begin
//#UC START# *555C91AF003A_55530BB9007A_impl*
 if not Prepared then
 begin
  l_Ok := htTableHandleByName(PAnsiChar(aHelper.TableFullPath(Table.Kind)), hTable);
  if (l_Ok < 0) or RequireNewHandle then
   Ht(htTableOpen(PAnsiChar(aHelper.TableFullPath(Table.Kind)),PAnsiChar(aHelper.TablePassword(Table.Kind)),PAnsiChar(aHelper.TablePassword(Table.Kind)), GlobalHtServer.HyTechTableOpenMode, f_Handle))
  else
   Ht(htDupTableHandle(hTable, f_Handle));
  GlobalHtServer.Family[aHelper.TableFamily(Table.Kind)].Lock(GlobalHtServer.HyTechTableOpenMode);
  Prepared := True;
 end;
//#UC END# *555C91AF003A_55530BB9007A_impl*
end;//ThtFromTable.Prepare

procedure ThtFromTable.Unprepare;
//#UC START# *555C91D8022C_55530BB9007A_var*
//#UC END# *555C91D8022C_55530BB9007A_var*
begin
//#UC START# *555C91D8022C_55530BB9007A_impl*
 if Prepared then
 begin
  Ht(htTableClose(f_Handle));
  GlobalHtServer.Family[aHelper.TableFamily(Table.Kind)].Unlock;
  Prepared := False;
 end;
//#UC END# *555C91D8022C_55530BB9007A_impl*
end;//ThtFromTable.Unprepare

end.
