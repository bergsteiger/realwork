unit htFromTable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "HT"
// Модуль: "w:/common/components/rtl/Garant/HT/htFromTable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::HT::Provider::ThtFromTable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\HT\htDefineDA.inc}

interface

uses
  htInterfaces
  {$If not defined(Nemesis)}
  ,
  HT_Const
  {$IfEnd} //not Nemesis
  ,
  daFromTable
  ;

type
 ThtFromTable = class(TdaFromTable, IhtFromTable)
 private
 // private fields
   f_Handle : ThtTblHandle;
 protected
 // realized methods
   function Get_Handle: ThtTblHandle;
   procedure Prepare(const aHelper: IhtDataSchemeHelper;
    RequireNewHandle: Boolean);
   procedure Unprepare(const aHelper: IhtDataSchemeHelper);
 end;//ThtFromTable

implementation

uses
  Classes
  {$If not defined(Nemesis)}
  ,
  HT_DLL
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Serv
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_Err
  {$IfEnd} //not Nemesis
  
  ;

// start class ThtFromTable

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

procedure ThtFromTable.Unprepare(const aHelper: IhtDataSchemeHelper);
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