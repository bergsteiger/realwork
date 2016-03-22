unit m3StoreHeaderDataNew;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoreHeaderDataNew.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StoreHeaderDataNew" MUID: (540854CA0131)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3StoreHeaderDataPrim
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
   Data: Tm3StoreHeaderDataRecNew;
   DataCompare: Tm3StoreHeaderDataRecNew;
  protected
   function Modified: Boolean; override;
   function pm_GetrRealSizePrim: Int64; override;
   procedure pm_SetrRealSizePrim(aValue: Int64); override;
   function pm_GetFirstClusterPrim: Int64; override;
   procedure pm_SetFirstClusterPrim(aValue: Int64); override;
   function pm_GetrTOCItemListPositionPrim: Int64; override;
   procedure pm_SetrTOCItemListPositionPrim(aValue: Int64); override;
   procedure DoDoLoad; override;
   procedure DoDoSave; override;
   procedure DoSaveNextPosition(aNextPosition: Int64); override;
   procedure InitData(aNew: Boolean); override;
  public
   class function DataSize: Integer; override;
 end;//Tm3StoreHeaderDataNew

implementation

uses
 l3ImplUses
 , m2MemLib
 , m2COMLib
 , ActiveX
 , m3Exceptions
;

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

function Tm3StoreHeaderDataNew.pm_GetrRealSizePrim: Int64;
//#UC START# *540834BD03CA_540854CA0131get_var*
//#UC END# *540834BD03CA_540854CA0131get_var*
begin
//#UC START# *540834BD03CA_540854CA0131get_impl*
 Result := Data.rRealSize;
//#UC END# *540834BD03CA_540854CA0131get_impl*
end;//Tm3StoreHeaderDataNew.pm_GetrRealSizePrim

procedure Tm3StoreHeaderDataNew.pm_SetrRealSizePrim(aValue: Int64);
//#UC START# *540834BD03CA_540854CA0131set_var*
//#UC END# *540834BD03CA_540854CA0131set_var*
begin
//#UC START# *540834BD03CA_540854CA0131set_impl*
 Data.rRealSize := aValue;
//#UC END# *540834BD03CA_540854CA0131set_impl*
end;//Tm3StoreHeaderDataNew.pm_SetrRealSizePrim

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

function Tm3StoreHeaderDataNew.pm_GetrTOCItemListPositionPrim: Int64;
//#UC START# *5408350602F2_540854CA0131get_var*
//#UC END# *5408350602F2_540854CA0131get_var*
begin
//#UC START# *5408350602F2_540854CA0131get_impl*
 Result := Data.rTOCItemListPosition;
//#UC END# *5408350602F2_540854CA0131get_impl*
end;//Tm3StoreHeaderDataNew.pm_GetrTOCItemListPositionPrim

procedure Tm3StoreHeaderDataNew.pm_SetrTOCItemListPositionPrim(aValue: Int64);
//#UC START# *5408350602F2_540854CA0131set_var*
//#UC END# *5408350602F2_540854CA0131set_var*
begin
//#UC START# *5408350602F2_540854CA0131set_impl*
 Data.rTOCItemListPosition := aValue;
//#UC END# *5408350602F2_540854CA0131set_impl*
end;//Tm3StoreHeaderDataNew.pm_SetrTOCItemListPositionPrim

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
