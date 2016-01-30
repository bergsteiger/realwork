unit NOT_FINISHED_m3DB;
 {* ���������� ��������� ���������� �����������. }

// ������: "w:\common\components\rtl\Garant\m3\NOT_FINISHED_m3DB.pas"
// ���������: "UtilityPack"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseObject
 , m3DBInterfaces
 , m3PrimDB
 , m3StorageInterfaces
 , l3Filer
;

type
 Tm3BaseRangeParam = (
  {* ��������� �������. }
  m3_brpIndexed
  , m3_brpModified
 );//Tm3BaseRangeParam

 Tm3BaseRangeParams = set of Tm3BaseRangeParam;
  {* ��������� �������. }

 Tm3BaseRange = {abstract} class(Tm3BaseObject, Im3DBRange)
  {* ������� ���������� ������� ����������. }
  protected
   function Mul(const aRange: Im3DBRange): Im3DBRange;
    {* ���������� �������. }
   {$If NOT Defined(m3NoEVD)}
   function Iterate(const aFilter: Im3TagGenerator;
    aNeedWriteToBase: Boolean;
    aParts: Tm3DocPartSet = m3_AllDocParts): Integer;
   {$IfEnd} // NOT Defined(m3NoEVD)
   function IterateF(anAction: Tm3FilerAction;
    aParts: Tm3DocPartSet = m3_AllDocParts): Integer; overload;
   function IterateF(anAction: Tm3DocumentAction;
    aParts: Tm3DocPartSet = m3_AllDocParts): Integer; overload;
   function CopyTo(const aDB: Im3DB;
    aMode: Tm3DBCopyMode = m3_cmRewrite;
    aParts: Tm3DocPartSet = m3_AllDocParts): Boolean;
    {* ���������� ������� � ������ ����. }
 end;//Tm3BaseRange

 Im3BaseRangeParamsSource = interface
  {* ��������� �������. }
  ['{156B14ED-B943-4DFC-9FED-CD8C32BAF936}']
  function Get_Params: Tm3BaseRangeParams;
  procedure Set_Params(aValue: Tm3BaseRangeParams);
  property Params: Tm3BaseRangeParams
   read Get_Params
   write Set_Params;
   {* ��������� �������. }
 end;//Im3BaseRangeParamsSource

 Tm3DocListRange = class(Tm3BaseRange)
  {* ���������� ������� ����������, �� ������ �������. }
 end;//Tm3DocListRange

 Tm3BaseParametricRange = class(Tm3BaseRange, Im3BaseRangeParamsSource)
  protected
   function Get_Params: Tm3BaseRangeParams;
   procedure Set_Params(aValue: Tm3BaseRangeParams);
 end;//Tm3BaseParametricRange

 Tm3CommonListSelector = (
  clsDeleted
  , clsModified
 );//Tm3CommonListSelector

 Tm3CustomDB = {abstract} class(Tm3PrimDB, Im3DB)
  {* ������� ���������� ��������� ����������. }
  protected
   procedure SetList(aListSelector: Tm3CommonListSelector;
    anID: Integer;
    aInsert: Boolean); virtual;
    {* ���������� ������ aListSelector. }
   function IndexedFiles(anIndexID: Integer = 1): Im3DBRange;
    {* ��������������� �����. }
   function ModifiedFiles(aNotEmpty: Boolean = False;
    aLevel: Integer = 0): Im3DBRange;
    {* ���������������� �����. }
   function AllFiles: Im3DBRange;
    {* ��� ����� ����. }
   function InProcess: Boolean; overload;
    {* � ����� ���� �������. }
   function Stopped: Boolean; overload;
    {* ���������� ������� ��� ����������. }
   procedure FlushLists;
    {* ���������� ��� Modified � Deleted ������. ����������� ��� �������� ������� ���������� � ����� ������� �����. ��� �� ���������� ��� ����������� ������� ������� � ���� (Tm3DB). }
   function LastElapsed: TDateTime; overload;
    {* ����� ���������� �������� � �����. }
   function GetDocument(anID: Integer): Im3DBDocument;
    {* ���������� �������� �� ������. }
   procedure FreeVersions;
    {* �������� � ���, ��� ��������� ������ ����� ��������� (��������) }
   function FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
    {* ����� � ���������������� �� ������ }
   procedure DeleteMain;
    {* ������� �������� ����� }
   procedure RenameMain(const aNewName: AnsiString);
    {* ��������������� ���������� ����� }
   procedure RenameVersion(const aNewName: AnsiString);
    {* ��������������� ���������� ����� }
   procedure Rename(const aNewName: AnsiString);
    {* ��������������� ��� ���� }
   function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
   function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
  public
   procedure Stop;
    {* ���������� ������� �������. }
   function Purge: integer;
    {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
   function Update(aNotEmpty: Boolean = True;
    aPurgeDeletedObjects: Boolean = True): Boolean;
    {* ���������� ����� �� ���������� ����� � ����������. }
   procedure Start(aOpenMode: Tm3StoreAccess);
    {* �������� ������� � �����. }
   procedure Finish;
    {* ����������� ������� � �����. }
   procedure ModifyModified(anID: Integer); override;
    {* ��������� �������� � ������ ��������� }
   procedure DeleteVersion;
    {* ������� ��������� ������ }
   function CompareVersionWithBackup: Boolean;
   procedure CopyBackupToVersion;
   procedure CopyVersionToBackup;
   procedure ExtractMainTo(const aDir: AnsiString);
   procedure ExtractVersionTo(const aDir: AnsiString);
   procedure ExtractBackupTo(const aDir: AnsiString);
   function IsExclusive: Boolean; override;
   function LastElapsed: TDateTime; override;
   function Stopped: Boolean; override;
   procedure Yield; override;
   procedure TuneFiler(aFiler: Tl3CustomFiler); override;
   procedure ModifyDeleted(anID: Integer;
    aInsert: Boolean); override;
   function InProcess: Boolean; override;
   function AsDB: Im3DB; override;
 end;//Tm3CustomDB

 Tm3DB = class(Tm3CustomDB)
  public
   function MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
    {* ���������� ������ ���������� ����� }
   function GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
    {* ���������� ������ ���������� ����� }
   function GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage; override;
    {* ���������� ������ ��������� ����� }
   procedure Start(aOpenMode: Tm3StoreAccess); override;
    {* �������� ������� � ����� }
   procedure Finish; override;
    {* ����������� ������� � ����� }
   procedure StartEx(aVersionsMode: Tm3StoreAccess;
    aConstMode: Tm3StoreAccess); override;
    {* �������� ������� � ����� }
   procedure CloseBase; override;
    {* ��������� �������� ����� }
 end;//Tm3DB

 Tm3BiCompBaseRange = class(Tm3BaseParametricRange)
  {* ����� - � ���� ������������. }
 end;//Tm3BiCompBaseRange

implementation

uses
 l3ImplUses
 , m3BackupTools
 , m3DBDocument
 , m3DBFiler
 , k2EVDReaderService
 , k2EVDWriterService
 , l3ProxyStream
 , m3DBProxyWriteStream
 , m3NewVersionStream
;

function Tm3BaseRange.Mul(const aRange: Im3DBRange): Im3DBRange;
 {* ���������� �������. }
//#UC START# *472718E303CA_4742DD750368_var*
//#UC END# *472718E303CA_4742DD750368_var*
begin
//#UC START# *472718E303CA_4742DD750368_impl*
 assert(false, 'Tm3BaseRange.Mul not implemented');
//#UC END# *472718E303CA_4742DD750368_impl*
end;//Tm3BaseRange.Mul

{$If NOT Defined(m3NoEVD)}
function Tm3BaseRange.Iterate(const aFilter: Im3TagGenerator;
 aNeedWriteToBase: Boolean;
 aParts: Tm3DocPartSet = m3_AllDocParts): Integer;
//#UC START# *472719650005_4742DD750368_var*
//#UC END# *472719650005_4742DD750368_var*
begin
//#UC START# *472719650005_4742DD750368_impl*
 assert(false, 'Tm3BaseRange.Iterate not implemented');
//#UC END# *472719650005_4742DD750368_impl*
end;//Tm3BaseRange.Iterate
{$IfEnd} // NOT Defined(m3NoEVD)

function Tm3BaseRange.IterateF(anAction: Tm3FilerAction;
 aParts: Tm3DocPartSet = m3_AllDocParts): Integer;
//#UC START# *47271A4301A1_4742DD750368_var*
//#UC END# *47271A4301A1_4742DD750368_var*
begin
//#UC START# *47271A4301A1_4742DD750368_impl*
 assert(false, 'Tm3BaseRange.IterateF not implemented');
//#UC END# *47271A4301A1_4742DD750368_impl*
end;//Tm3BaseRange.IterateF

function Tm3BaseRange.IterateF(anAction: Tm3DocumentAction;
 aParts: Tm3DocPartSet = m3_AllDocParts): Integer;
//#UC START# *47271A8703B1_4742DD750368_var*
//#UC END# *47271A8703B1_4742DD750368_var*
begin
//#UC START# *47271A8703B1_4742DD750368_impl*
 assert(false, 'Tm3BaseRange.IterateF not implemented');
//#UC END# *47271A8703B1_4742DD750368_impl*
end;//Tm3BaseRange.IterateF

function Tm3BaseRange.CopyTo(const aDB: Im3DB;
 aMode: Tm3DBCopyMode = m3_cmRewrite;
 aParts: Tm3DocPartSet = m3_AllDocParts): Boolean;
 {* ���������� ������� � ������ ����. }
//#UC START# *47271A9E01AC_4742DD750368_var*
//#UC END# *47271A9E01AC_4742DD750368_var*
begin
//#UC START# *47271A9E01AC_4742DD750368_impl*
 assert(false, 'Tm3BaseRange.CopyTo not implemented');
//#UC END# *47271A9E01AC_4742DD750368_impl*
end;//Tm3BaseRange.CopyTo

function Tm3BaseParametricRange.Get_Params: Tm3BaseRangeParams;
//#UC START# *4742E29F0333_555B4E46039Aget_var*
//#UC END# *4742E29F0333_555B4E46039Aget_var*
begin
//#UC START# *4742E29F0333_555B4E46039Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4742E29F0333_555B4E46039Aget_impl*
end;//Tm3BaseParametricRange.Get_Params

procedure Tm3BaseParametricRange.Set_Params(aValue: Tm3BaseRangeParams);
//#UC START# *4742E29F0333_555B4E46039Aset_var*
//#UC END# *4742E29F0333_555B4E46039Aset_var*
begin
//#UC START# *4742E29F0333_555B4E46039Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4742E29F0333_555B4E46039Aset_impl*
end;//Tm3BaseParametricRange.Set_Params

procedure Tm3CustomDB.SetList(aListSelector: Tm3CommonListSelector;
 anID: Integer;
 aInsert: Boolean);
 {* ���������� ������ aListSelector. }
//#UC START# *47446C7401CD_4742CA25034B_var*
//#UC END# *47446C7401CD_4742CA25034B_var*
begin
//#UC START# *47446C7401CD_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.SetList not implemented');
//#UC END# *47446C7401CD_4742CA25034B_impl*
end;//Tm3CustomDB.SetList

function Tm3CustomDB.IndexedFiles(anIndexID: Integer = 1): Im3DBRange;
 {* ��������������� �����. }
//#UC START# *47271FFF00D9_4742CA25034B_var*
//#UC END# *47271FFF00D9_4742CA25034B_var*
begin
//#UC START# *47271FFF00D9_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.IndexedFiles not implemented');
//#UC END# *47271FFF00D9_4742CA25034B_impl*
end;//Tm3CustomDB.IndexedFiles

function Tm3CustomDB.ModifiedFiles(aNotEmpty: Boolean = False;
 aLevel: Integer = 0): Im3DBRange;
 {* ���������������� �����. }
//#UC START# *4727201800DF_4742CA25034B_var*
//#UC END# *4727201800DF_4742CA25034B_var*
begin
//#UC START# *4727201800DF_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.ModifiedFiles not implemented');
//#UC END# *4727201800DF_4742CA25034B_impl*
end;//Tm3CustomDB.ModifiedFiles

function Tm3CustomDB.AllFiles: Im3DBRange;
 {* ��� ����� ����. }
//#UC START# *4727203C02FE_4742CA25034B_var*
//#UC END# *4727203C02FE_4742CA25034B_var*
begin
//#UC START# *4727203C02FE_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.AllFiles not implemented');
//#UC END# *4727203C02FE_4742CA25034B_impl*
end;//Tm3CustomDB.AllFiles

function Tm3CustomDB.InProcess: Boolean;
 {* � ����� ���� �������. }
//#UC START# *47272B6400D4_4742CA25034B_var*
//#UC END# *47272B6400D4_4742CA25034B_var*
begin
//#UC START# *47272B6400D4_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.InProcess not implemented');
//#UC END# *47272B6400D4_4742CA25034B_impl*
end;//Tm3CustomDB.InProcess

function Tm3CustomDB.Stopped: Boolean;
 {* ���������� ������� ��� ����������. }
//#UC START# *47272B8403DD_4742CA25034B_var*
//#UC END# *47272B8403DD_4742CA25034B_var*
begin
//#UC START# *47272B8403DD_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Stopped not implemented');
//#UC END# *47272B8403DD_4742CA25034B_impl*
end;//Tm3CustomDB.Stopped

procedure Tm3CustomDB.Stop;
 {* ���������� ������� �������. }
//#UC START# *47272B980395_4742CA25034B_var*
//#UC END# *47272B980395_4742CA25034B_var*
begin
//#UC START# *47272B980395_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Stop not implemented');
//#UC END# *47272B980395_4742CA25034B_impl*
end;//Tm3CustomDB.Stop

function Tm3CustomDB.Purge: integer;
 {* ������� �����, ���������� ��� ��������� � ���������� ����� ���������. }
//#UC START# *47272BAA0251_4742CA25034B_var*
//#UC END# *47272BAA0251_4742CA25034B_var*
begin
//#UC START# *47272BAA0251_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Purge not implemented');
//#UC END# *47272BAA0251_4742CA25034B_impl*
end;//Tm3CustomDB.Purge

function Tm3CustomDB.Update(aNotEmpty: Boolean = True;
 aPurgeDeletedObjects: Boolean = True): Boolean;
 {* ���������� ����� �� ���������� ����� � ����������. }
//#UC START# *47272BBF01F7_4742CA25034B_var*
//#UC END# *47272BBF01F7_4742CA25034B_var*
begin
//#UC START# *47272BBF01F7_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Update not implemented');
//#UC END# *47272BBF01F7_4742CA25034B_impl*
end;//Tm3CustomDB.Update

procedure Tm3CustomDB.FlushLists;
 {* ���������� ��� Modified � Deleted ������. ����������� ��� �������� ������� ���������� � ����� ������� �����. ��� �� ���������� ��� ����������� ������� ������� � ���� (Tm3DB). }
//#UC START# *47272BD7022E_4742CA25034B_var*
//#UC END# *47272BD7022E_4742CA25034B_var*
begin
//#UC START# *47272BD7022E_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.FlushLists not implemented');
//#UC END# *47272BD7022E_4742CA25034B_impl*
end;//Tm3CustomDB.FlushLists

procedure Tm3CustomDB.Start(aOpenMode: Tm3StoreAccess);
 {* �������� ������� � �����. }
//#UC START# *47272C0C0284_4742CA25034B_var*
//#UC END# *47272C0C0284_4742CA25034B_var*
begin
//#UC START# *47272C0C0284_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Start not implemented');
//#UC END# *47272C0C0284_4742CA25034B_impl*
end;//Tm3CustomDB.Start

procedure Tm3CustomDB.Finish;
 {* ����������� ������� � �����. }
//#UC START# *47272C1D02C4_4742CA25034B_var*
//#UC END# *47272C1D02C4_4742CA25034B_var*
begin
//#UC START# *47272C1D02C4_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.Finish not implemented');
//#UC END# *47272C1D02C4_4742CA25034B_impl*
end;//Tm3CustomDB.Finish

function Tm3CustomDB.LastElapsed: TDateTime;
 {* ����� ���������� �������� � �����. }
//#UC START# *47272C6B008C_4742CA25034B_var*
//#UC END# *47272C6B008C_4742CA25034B_var*
begin
//#UC START# *47272C6B008C_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.LastElapsed not implemented');
//#UC END# *47272C6B008C_4742CA25034B_impl*
end;//Tm3CustomDB.LastElapsed

function Tm3CustomDB.GetDocument(anID: Integer): Im3DBDocument;
 {* ���������� �������� �� ������. }
//#UC START# *47272E7903B3_4742CA25034B_var*
//#UC END# *47272E7903B3_4742CA25034B_var*
begin
//#UC START# *47272E7903B3_4742CA25034B_impl*
 assert(false, 'Tm3CustomDB.GetDocument not implemented');
//#UC END# *47272E7903B3_4742CA25034B_impl*
end;//Tm3CustomDB.GetDocument

procedure Tm3CustomDB.FreeVersions;
 {* �������� � ���, ��� ��������� ������ ����� ��������� (��������) }
//#UC START# *49BE895B01ED_4742CA25034B_var*
//#UC END# *49BE895B01ED_4742CA25034B_var*
begin
//#UC START# *49BE895B01ED_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BE895B01ED_4742CA25034B_impl*
end;//Tm3CustomDB.FreeVersions

procedure Tm3CustomDB.ModifyModified(anID: Integer);
 {* ��������� �������� � ������ ��������� }
//#UC START# *49BFC6640310_4742CA25034B_var*
//#UC END# *49BFC6640310_4742CA25034B_var*
begin
//#UC START# *49BFC6640310_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BFC6640310_4742CA25034B_impl*
end;//Tm3CustomDB.ModifyModified

function Tm3CustomDB.FilesInList(const aList: Im3StorageElementIDList): Im3DBRange;
 {* ����� � ���������������� �� ������ }
//#UC START# *4BC8352E02D3_4742CA25034B_var*
//#UC END# *4BC8352E02D3_4742CA25034B_var*
begin
//#UC START# *4BC8352E02D3_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BC8352E02D3_4742CA25034B_impl*
end;//Tm3CustomDB.FilesInList

procedure Tm3CustomDB.DeleteVersion;
 {* ������� ��������� ������ }
//#UC START# *4FA16B78016F_4742CA25034B_var*
//#UC END# *4FA16B78016F_4742CA25034B_var*
begin
//#UC START# *4FA16B78016F_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FA16B78016F_4742CA25034B_impl*
end;//Tm3CustomDB.DeleteVersion

procedure Tm3CustomDB.DeleteMain;
 {* ������� �������� ����� }
//#UC START# *4FA16B91036A_4742CA25034B_var*
//#UC END# *4FA16B91036A_4742CA25034B_var*
begin
//#UC START# *4FA16B91036A_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FA16B91036A_4742CA25034B_impl*
end;//Tm3CustomDB.DeleteMain

procedure Tm3CustomDB.RenameMain(const aNewName: AnsiString);
 {* ��������������� ���������� ����� }
//#UC START# *4FBB76D701DC_4742CA25034B_var*
//#UC END# *4FBB76D701DC_4742CA25034B_var*
begin
//#UC START# *4FBB76D701DC_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FBB76D701DC_4742CA25034B_impl*
end;//Tm3CustomDB.RenameMain

procedure Tm3CustomDB.RenameVersion(const aNewName: AnsiString);
 {* ��������������� ���������� ����� }
//#UC START# *4FBB76F50376_4742CA25034B_var*
//#UC END# *4FBB76F50376_4742CA25034B_var*
begin
//#UC START# *4FBB76F50376_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FBB76F50376_4742CA25034B_impl*
end;//Tm3CustomDB.RenameVersion

procedure Tm3CustomDB.Rename(const aNewName: AnsiString);
 {* ��������������� ��� ���� }
//#UC START# *4FBB827801E4_4742CA25034B_var*
//#UC END# *4FBB827801E4_4742CA25034B_var*
begin
//#UC START# *4FBB827801E4_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FBB827801E4_4742CA25034B_impl*
end;//Tm3CustomDB.Rename

function Tm3CustomDB.CompareVersionWithBackup: Boolean;
//#UC START# *5419A76B0193_4742CA25034B_var*
//#UC END# *5419A76B0193_4742CA25034B_var*
begin
//#UC START# *5419A76B0193_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5419A76B0193_4742CA25034B_impl*
end;//Tm3CustomDB.CompareVersionWithBackup

procedure Tm3CustomDB.CopyBackupToVersion;
//#UC START# *5419A79201B8_4742CA25034B_var*
//#UC END# *5419A79201B8_4742CA25034B_var*
begin
//#UC START# *5419A79201B8_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5419A79201B8_4742CA25034B_impl*
end;//Tm3CustomDB.CopyBackupToVersion

procedure Tm3CustomDB.CopyVersionToBackup;
//#UC START# *5419A7AA002A_4742CA25034B_var*
//#UC END# *5419A7AA002A_4742CA25034B_var*
begin
//#UC START# *5419A7AA002A_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5419A7AA002A_4742CA25034B_impl*
end;//Tm3CustomDB.CopyVersionToBackup

procedure Tm3CustomDB.ExtractMainTo(const aDir: AnsiString);
//#UC START# *541AE1C4006F_4742CA25034B_var*
//#UC END# *541AE1C4006F_4742CA25034B_var*
begin
//#UC START# *541AE1C4006F_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *541AE1C4006F_4742CA25034B_impl*
end;//Tm3CustomDB.ExtractMainTo

procedure Tm3CustomDB.ExtractVersionTo(const aDir: AnsiString);
//#UC START# *541AE4C701CE_4742CA25034B_var*
//#UC END# *541AE4C701CE_4742CA25034B_var*
begin
//#UC START# *541AE4C701CE_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *541AE4C701CE_4742CA25034B_impl*
end;//Tm3CustomDB.ExtractVersionTo

procedure Tm3CustomDB.ExtractBackupTo(const aDir: AnsiString);
//#UC START# *541AF7940108_4742CA25034B_var*
//#UC END# *541AF7940108_4742CA25034B_var*
begin
//#UC START# *541AF7940108_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *541AF7940108_4742CA25034B_impl*
end;//Tm3CustomDB.ExtractBackupTo

function Tm3CustomDB.IsExclusive: Boolean;
//#UC START# *5551D4570112_4742CA25034B_var*
//#UC END# *5551D4570112_4742CA25034B_var*
begin
//#UC START# *5551D4570112_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5551D4570112_4742CA25034B_impl*
end;//Tm3CustomDB.IsExclusive

function Tm3CustomDB.GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *555330090162_4742CA25034B_var*
//#UC END# *555330090162_4742CA25034B_var*
begin
//#UC START# *555330090162_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555330090162_4742CA25034B_impl*
end;//Tm3CustomDB.GetBackupStorage

function Tm3CustomDB.GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *5553302501A8_4742CA25034B_var*
//#UC END# *5553302501A8_4742CA25034B_var*
begin
//#UC START# *5553302501A8_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5553302501A8_4742CA25034B_impl*
end;//Tm3CustomDB.GetVersionsStorage

function Tm3CustomDB.MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
//#UC START# *555361A80058_4742CA25034B_var*
//#UC END# *555361A80058_4742CA25034B_var*
begin
//#UC START# *555361A80058_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555361A80058_4742CA25034B_impl*
end;//Tm3CustomDB.MainStorage

function Tm3CustomDB.LastElapsed: TDateTime;
//#UC START# *555373BC008A_4742CA25034B_var*
//#UC END# *555373BC008A_4742CA25034B_var*
begin
//#UC START# *555373BC008A_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555373BC008A_4742CA25034B_impl*
end;//Tm3CustomDB.LastElapsed

function Tm3CustomDB.Stopped: Boolean;
//#UC START# *555373EC02D1_4742CA25034B_var*
//#UC END# *555373EC02D1_4742CA25034B_var*
begin
//#UC START# *555373EC02D1_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555373EC02D1_4742CA25034B_impl*
end;//Tm3CustomDB.Stopped

procedure Tm3CustomDB.Yield;
//#UC START# *555379B30054_4742CA25034B_var*
//#UC END# *555379B30054_4742CA25034B_var*
begin
//#UC START# *555379B30054_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555379B30054_4742CA25034B_impl*
end;//Tm3CustomDB.Yield

procedure Tm3CustomDB.TuneFiler(aFiler: Tl3CustomFiler);
//#UC START# *55537EB101A3_4742CA25034B_var*
//#UC END# *55537EB101A3_4742CA25034B_var*
begin
//#UC START# *55537EB101A3_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *55537EB101A3_4742CA25034B_impl*
end;//Tm3CustomDB.TuneFiler

procedure Tm3CustomDB.ModifyDeleted(anID: Integer;
 aInsert: Boolean);
//#UC START# *555382D401F9_4742CA25034B_var*
//#UC END# *555382D401F9_4742CA25034B_var*
begin
//#UC START# *555382D401F9_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *555382D401F9_4742CA25034B_impl*
end;//Tm3CustomDB.ModifyDeleted

function Tm3CustomDB.InProcess: Boolean;
//#UC START# *5553831A0253_4742CA25034B_var*
//#UC END# *5553831A0253_4742CA25034B_var*
begin
//#UC START# *5553831A0253_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5553831A0253_4742CA25034B_impl*
end;//Tm3CustomDB.InProcess

function Tm3CustomDB.AsDB: Im3DB;
//#UC START# *5553685D006D_4742CA25034B_var*
//#UC END# *5553685D006D_4742CA25034B_var*
begin
//#UC START# *5553685D006D_4742CA25034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5553685D006D_4742CA25034B_impl*
end;//Tm3CustomDB.AsDB

function Tm3DB.MainStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
 {* ���������� ������ ���������� ����� }
//#UC START# *49BFD4CE0235_4742CA9702AE_var*
//#UC END# *49BFD4CE0235_4742CA9702AE_var*
begin
//#UC START# *49BFD4CE0235_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BFD4CE0235_4742CA9702AE_impl*
end;//Tm3DB.MainStorage

function Tm3DB.GetVersionsStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
 {* ���������� ������ ���������� ����� }
//#UC START# *49BFD4F3013E_4742CA9702AE_var*
//#UC END# *49BFD4F3013E_4742CA9702AE_var*
begin
//#UC START# *49BFD4F3013E_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BFD4F3013E_4742CA9702AE_impl*
end;//Tm3DB.GetVersionsStorage

function Tm3DB.GetBackupStorage(aMode: Tm3StoreAccess): Im3IndexedStorage;
 {* ���������� ������ ��������� ����� }
//#UC START# *49BFD52D0076_4742CA9702AE_var*
//#UC END# *49BFD52D0076_4742CA9702AE_var*
begin
//#UC START# *49BFD52D0076_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49BFD52D0076_4742CA9702AE_impl*
end;//Tm3DB.GetBackupStorage

procedure Tm3DB.Start(aOpenMode: Tm3StoreAccess);
 {* �������� ������� � ����� }
//#UC START# *49C2496903D4_4742CA9702AE_var*
//#UC END# *49C2496903D4_4742CA9702AE_var*
begin
//#UC START# *49C2496903D4_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49C2496903D4_4742CA9702AE_impl*
end;//Tm3DB.Start

procedure Tm3DB.Finish;
 {* ����������� ������� � ����� }
//#UC START# *49C249810227_4742CA9702AE_var*
//#UC END# *49C249810227_4742CA9702AE_var*
begin
//#UC START# *49C249810227_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49C249810227_4742CA9702AE_impl*
end;//Tm3DB.Finish

procedure Tm3DB.StartEx(aVersionsMode: Tm3StoreAccess;
 aConstMode: Tm3StoreAccess);
 {* �������� ������� � ����� }
//#UC START# *49C75F73038A_4742CA9702AE_var*
//#UC END# *49C75F73038A_4742CA9702AE_var*
begin
//#UC START# *49C75F73038A_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49C75F73038A_4742CA9702AE_impl*
end;//Tm3DB.StartEx

procedure Tm3DB.CloseBase;
 {* ��������� �������� ����� }
//#UC START# *49C75F8C02B9_4742CA9702AE_var*
//#UC END# *49C75F8C02B9_4742CA9702AE_var*
begin
//#UC START# *49C75F8C02B9_4742CA9702AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *49C75F8C02B9_4742CA9702AE_impl*
end;//Tm3DB.CloseBase

end.
