unit m3StoreHeaderData;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoreHeaderData.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3StoreHeaderDataPrim
;

type
 Tm3StoreHeaderDataRec = packed record
  {* Элемент оглавления IStorage }
 //#UC START# *54070C54022Cpubl*
   rNextPosition: Int64;
     {* - позиция следующего свободного элемента каталога (для связывания в цепочки). }
   {$IfDef m3StoreHasCRC}
   rBodyCRC: LongInt;
     {* - контрольная сумма. }
   {$EndIf m3StoreHasCRC}
   rTOCBuffRootPosition: Int64;
     {* - указатель на первый блок потока. }
   rTOCItemListPosition: Int64;
     {* - указатель на позицию где в данном потоке находится оглавление. }
   rRealSize: Int64;
     {* - реальный размер потока. }
   {$IfDef m3StoreHasGUID}
   rCLSID: TGUID;
     {* - GUID потока (для поддержки идеологии Microsoft OLE). }
   {$EndIf m3StoreHasGUID}
   {$IfDef m3StoreHas_Body}
   _Body: packed array [1..8] of AnsiChar;
     {* - резерв. }
   {$EndIf m3StoreHas_Body}
 //#UC END# *54070C54022Cpubl*
 end;//Tm3StoreHeaderDataRec

 Tm3StoreHeaderData = class(Tm3StoreHeaderDataPrim)
  private
   Data: Tm3StoreHeaderDataRec;
   DataCompare: Tm3StoreHeaderDataRec;
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
 end;//Tm3StoreHeaderData

implementation

uses
 l3ImplUses
 , m2MemLib
 , l3Base
 , ActiveX
 , m2COMLib
 , m3Exceptions
;

class function Tm3StoreHeaderData.DataSize: Integer;
//#UC START# *5407189E0002_54071860020E_var*
//#UC END# *5407189E0002_54071860020E_var*
begin
//#UC START# *5407189E0002_54071860020E_impl*
 Result := SizeOf(Tm3StoreHeaderDataRec); 
//#UC END# *5407189E0002_54071860020E_impl*
end;//Tm3StoreHeaderData.DataSize

function Tm3StoreHeaderData.Modified: Boolean;
//#UC START# *540718BC025B_54071860020E_var*
//#UC END# *540718BC025B_54071860020E_var*
begin
//#UC START# *540718BC025B_54071860020E_impl*
 Result := m2MEMCompare(@Self.Data,
                        @Self.DataCompare,
                        Self.DataSize) <> 0;
//#UC END# *540718BC025B_54071860020E_impl*
end;//Tm3StoreHeaderData.Modified

function Tm3StoreHeaderData.pm_GetrRealSizePrim: Int64;
//#UC START# *540834BD03CA_54071860020Eget_var*
//#UC END# *540834BD03CA_54071860020Eget_var*
begin
//#UC START# *540834BD03CA_54071860020Eget_impl*
 Result := Data.rRealSize;
//#UC END# *540834BD03CA_54071860020Eget_impl*
end;//Tm3StoreHeaderData.pm_GetrRealSizePrim

procedure Tm3StoreHeaderData.pm_SetrRealSizePrim(aValue: Int64);
//#UC START# *540834BD03CA_54071860020Eset_var*
//#UC END# *540834BD03CA_54071860020Eset_var*
begin
//#UC START# *540834BD03CA_54071860020Eset_impl*
 Data.rRealSize := aValue;
//#UC END# *540834BD03CA_54071860020Eset_impl*
end;//Tm3StoreHeaderData.pm_SetrRealSizePrim

function Tm3StoreHeaderData.pm_GetFirstClusterPrim: Int64;
//#UC START# *540834F20369_54071860020Eget_var*
//#UC END# *540834F20369_54071860020Eget_var*
begin
//#UC START# *540834F20369_54071860020Eget_impl*
 Result := Data.rTOCBuffRootPosition;
//#UC END# *540834F20369_54071860020Eget_impl*
end;//Tm3StoreHeaderData.pm_GetFirstClusterPrim

procedure Tm3StoreHeaderData.pm_SetFirstClusterPrim(aValue: Int64);
//#UC START# *540834F20369_54071860020Eset_var*
//#UC END# *540834F20369_54071860020Eset_var*
begin
//#UC START# *540834F20369_54071860020Eset_impl*
 Data.rTOCBuffRootPosition := aValue;
//#UC END# *540834F20369_54071860020Eset_impl*
end;//Tm3StoreHeaderData.pm_SetFirstClusterPrim

function Tm3StoreHeaderData.pm_GetrTOCItemListPositionPrim: Int64;
//#UC START# *5408350602F2_54071860020Eget_var*
//#UC END# *5408350602F2_54071860020Eget_var*
begin
//#UC START# *5408350602F2_54071860020Eget_impl*
 Result := Data.rTOCItemListPosition;
//#UC END# *5408350602F2_54071860020Eget_impl*
end;//Tm3StoreHeaderData.pm_GetrTOCItemListPositionPrim

procedure Tm3StoreHeaderData.pm_SetrTOCItemListPositionPrim(aValue: Int64);
//#UC START# *5408350602F2_54071860020Eset_var*
//#UC END# *5408350602F2_54071860020Eset_var*
begin
//#UC START# *5408350602F2_54071860020Eset_impl*
 Data.rTOCItemListPosition := aValue;
//#UC END# *5408350602F2_54071860020Eset_impl*
end;//Tm3StoreHeaderData.pm_SetrTOCItemListPositionPrim

procedure Tm3StoreHeaderData.DoDoLoad;
//#UC START# *54083558039D_54071860020E_var*
//#UC END# *54083558039D_54071860020E_var*
begin
//#UC START# *54083558039D_54071860020E_impl*
 Stream.ReadData(Position, Self.Data, Self.DataSize);
 DataCompare := Data;
//#UC END# *54083558039D_54071860020E_impl*
end;//Tm3StoreHeaderData.DoDoLoad

procedure Tm3StoreHeaderData.DoDoSave;
//#UC START# *5408358802BD_54071860020E_var*
//#UC END# *5408358802BD_54071860020E_var*
begin
//#UC START# *5408358802BD_54071860020E_impl*
 Stream.WriteData(Position, Self.Data, Self.DataSize);
 DataCompare := Data;
//#UC END# *5408358802BD_54071860020E_impl*
end;//Tm3StoreHeaderData.DoDoSave

procedure Tm3StoreHeaderData.DoSaveNextPosition(aNextPosition: Int64);
//#UC START# *540DDBC0020B_54071860020E_var*
//#UC END# *540DDBC0020B_54071860020E_var*
begin
//#UC START# *540DDBC0020B_54071860020E_impl*
 Stream.WriteData(Position, aNextPosition, SizeOf(aNextPosition));
 Data.rNextPosition := aNextPosition;
//#UC END# *540DDBC0020B_54071860020E_impl*
end;//Tm3StoreHeaderData.DoSaveNextPosition

procedure Tm3StoreHeaderData.InitData(aNew: Boolean);
//#UC START# *54104EA90033_54071860020E_var*
//#UC END# *54104EA90033_54071860020E_var*
begin
//#UC START# *54104EA90033_54071860020E_impl*
 Data.rNextPosition := Int64(-1);
 {$IfDef m3StoreHasCRC}
 Data.rBodyCRC := 0;
 {$EndIf m3StoreHasCRC}
 Data.rTOCBuffRootPosition := Int64(-1);
 Data.rTOCItemListPosition := Int64(-1);
 Data.rRealSize := 0;
 {$IfDef m3StoreHasGUID}
 Data.rCLSID := GUID_NULL;
 {$EndIf m3StoreHasGUID}
 {$IfDef m3StoreHas_Body}
 l3FillChar(Data._Body, SizeOf(Data._Body));
 {$EndIf m3StoreHas_Body}
 DataCompare := Data;
 if aNew then
  DataCompare.rRealSize := -1;
 // - это специально, чтобы ВНОВЬ созданный блок был модифицированным
//#UC END# *54104EA90033_54071860020E_impl*
end;//Tm3StoreHeaderData.InitData

end.
