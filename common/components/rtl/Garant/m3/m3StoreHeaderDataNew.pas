unit m3StoreHeaderDataNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StoreHeaderDataNew.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3StoreHeaderDataNew
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StoreHeaderDataPrim
  ;

type
 Tm3StoreHeaderDataRecNew = packed record
//#UC START# *541057750002publ*
   rNextPosition: Int64;
     {* - позиция следующего свободного элемента каталога (для связывания в цепочки). }
   rTOCBuffRootPosition: Int64;
     {* - указатель на первый блок потока. }
   rTOCItemListPosition: Int64;
     {* - указатель на позицию где в данном потоке находится оглавление. }
   rRealSize: Int64;
     {* - реальный размер потока. }
//#UC END# *541057750002publ*
 end;//Tm3StoreHeaderDataRecNew

 Tm3StoreHeaderDataNew = class(Tm3StoreHeaderDataPrim)
 private
 // private fields
   Data : Tm3StoreHeaderDataRecNew;
   DataCompare : Tm3StoreHeaderDataRecNew;
 protected
 // realized methods
   function Modified: Boolean; override;
   function pm_GetRRealSizePrim: Int64; override;
   procedure pm_SetRRealSizePrim(aValue: Int64); override;
   function pm_GetFirstClusterPrim: Int64; override;
   procedure pm_SetFirstClusterPrim(aValue: Int64); override;
   function pm_GetRTOCItemListPositionPrim: Int64; override;
   procedure pm_SetRTOCItemListPositionPrim(aValue: Int64); override;
   procedure DoDoLoad; override;
   procedure DoDoSave; override;
   procedure DoSaveNextPosition(aNextPosition: Int64); override;
   procedure InitData(aNew: Boolean); override;
 public
 // realized methods
   class function DataSize: Integer; override;
 end;//Tm3StoreHeaderDataNew

implementation

uses
  m2MemLib,
  m2COMLib,
  ActiveX,
  m3Exceptions
  ;

// start class Tm3StoreHeaderDataNew

class function Tm3StoreHeaderDataNew.DataSize: Integer;
//#UC START# *5407189E0002_540854CA0131_var*
//#UC END# *5407189E0002_540854CA0131_var*
begin
//#UC START# *5407189E0002_540854CA0131_impl*
 Result := SizeOf(Tm3StoreHeaderDataRecNew); 
//#UC END# *5407189E0002_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.DataSize

function Tm3StoreHeaderDataNew.Modified: Boolean;
//#UC START# *540718BC025B_540854CA0131_var*
//#UC END# *540718BC025B_540854CA0131_var*
begin
//#UC START# *540718BC025B_540854CA0131_impl*
 Result := m2MEMCompare(@Self.Data,
                        @Self.DataCompare,
                        Self.DataSize) <> 0;
//#UC END# *540718BC025B_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.Modified

function Tm3StoreHeaderDataNew.pm_GetRRealSizePrim: Int64;
//#UC START# *540834BD03CA_540854CA0131get_var*
//#UC END# *540834BD03CA_540854CA0131get_var*
begin
//#UC START# *540834BD03CA_540854CA0131get_impl*
 Result := Data.rRealSize;
//#UC END# *540834BD03CA_540854CA0131get_impl*
end;//Tm3StoreHeaderDataNew.pm_GetRRealSizePrim

procedure Tm3StoreHeaderDataNew.pm_SetRRealSizePrim(aValue: Int64);
//#UC START# *540834BD03CA_540854CA0131set_var*
//#UC END# *540834BD03CA_540854CA0131set_var*
begin
//#UC START# *540834BD03CA_540854CA0131set_impl*
 Data.rRealSize := aValue;
//#UC END# *540834BD03CA_540854CA0131set_impl*
end;//Tm3StoreHeaderDataNew.pm_SetRRealSizePrim

function Tm3StoreHeaderDataNew.pm_GetFirstClusterPrim: Int64;
//#UC START# *540834F20369_540854CA0131get_var*
//#UC END# *540834F20369_540854CA0131get_var*
begin
//#UC START# *540834F20369_540854CA0131get_impl*
 Result := Data.rTOCBuffRootPosition;
//#UC END# *540834F20369_540854CA0131get_impl*
end;//Tm3StoreHeaderDataNew.pm_GetFirstClusterPrim

procedure Tm3StoreHeaderDataNew.pm_SetFirstClusterPrim(aValue: Int64);
//#UC START# *540834F20369_540854CA0131set_var*
//#UC END# *540834F20369_540854CA0131set_var*
begin
//#UC START# *540834F20369_540854CA0131set_impl*
 Data.rTOCBuffRootPosition := aValue;
//#UC END# *540834F20369_540854CA0131set_impl*
end;//Tm3StoreHeaderDataNew.pm_SetFirstClusterPrim

function Tm3StoreHeaderDataNew.pm_GetRTOCItemListPositionPrim: Int64;
//#UC START# *5408350602F2_540854CA0131get_var*
//#UC END# *5408350602F2_540854CA0131get_var*
begin
//#UC START# *5408350602F2_540854CA0131get_impl*
 Result := Data.rTOCItemListPosition;
//#UC END# *5408350602F2_540854CA0131get_impl*
end;//Tm3StoreHeaderDataNew.pm_GetRTOCItemListPositionPrim

procedure Tm3StoreHeaderDataNew.pm_SetRTOCItemListPositionPrim(aValue: Int64);
//#UC START# *5408350602F2_540854CA0131set_var*
//#UC END# *5408350602F2_540854CA0131set_var*
begin
//#UC START# *5408350602F2_540854CA0131set_impl*
 Data.rTOCItemListPosition := aValue;
//#UC END# *5408350602F2_540854CA0131set_impl*
end;//Tm3StoreHeaderDataNew.pm_SetRTOCItemListPositionPrim

procedure Tm3StoreHeaderDataNew.DoDoLoad;
//#UC START# *54083558039D_540854CA0131_var*
//#UC END# *54083558039D_540854CA0131_var*
begin
//#UC START# *54083558039D_540854CA0131_impl*
 Stream.ReadData(Position, Self.Data, Self.DataSize);
 DataCompare := Data;
//#UC END# *54083558039D_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.DoDoLoad

procedure Tm3StoreHeaderDataNew.DoDoSave;
//#UC START# *5408358802BD_540854CA0131_var*
//#UC END# *5408358802BD_540854CA0131_var*
begin
//#UC START# *5408358802BD_540854CA0131_impl*
 Stream.WriteData(Position, Self.Data, Self.DataSize);
 DataCompare := Data;
//#UC END# *5408358802BD_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.DoDoSave

procedure Tm3StoreHeaderDataNew.DoSaveNextPosition(aNextPosition: Int64);
//#UC START# *540DDBC0020B_540854CA0131_var*
//#UC END# *540DDBC0020B_540854CA0131_var*
begin
//#UC START# *540DDBC0020B_540854CA0131_impl*
 Stream.WriteData(Position, aNextPosition, SizeOf(aNextPosition));
 Data.rNextPosition := aNextPosition;
//#UC END# *540DDBC0020B_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.DoSaveNextPosition

procedure Tm3StoreHeaderDataNew.InitData(aNew: Boolean);
//#UC START# *54104EA90033_540854CA0131_var*
//#UC END# *54104EA90033_540854CA0131_var*
begin
//#UC START# *54104EA90033_540854CA0131_impl*
 Data.rNextPosition := Int64(-1);
 Data.rTOCBuffRootPosition := Int64(-1);
 Data.rTOCItemListPosition := Int64(-1);
 Data.rRealSize := 0;
 DataCompare := Data;
 if aNew then
  DataCompare.rRealSize := -1;
 // - это специально, чтобы ВНОВЬ созданный блок был модифицированным
//#UC END# *54104EA90033_540854CA0131_impl*
end;//Tm3StoreHeaderDataNew.InitData

end.