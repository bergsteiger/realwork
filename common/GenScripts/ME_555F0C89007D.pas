unit htDataSchemeHelper;

// Модуль: "w:\common\components\rtl\Garant\HT\htDataSchemeHelper.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , htInterfaces
 , htDataProviderParams
 , daTypes
;

type
 ThtDataSchemeHelper = class(Tl3ProtoObject, IhtDataSchemeHelper)
  private
   f_Params: ThtDataProviderParams;
  protected
   function TableFullPath(aTable: TdaTables): AnsiString;
   function TablePassword(aTable: TdaTables): AnsiString;
   function TableFamily(aTable: TdaTables): TdaFamilyID;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aParams: ThtDataProviderParams); reintroduce;
   class function Make(aParams: ThtDataProviderParams): IhtDataSchemeHelper; reintroduce;
 end;//ThtDataSchemeHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3FileUtils
;

constructor ThtDataSchemeHelper.Create(aParams: ThtDataProviderParams);
//#UC START# *555F0CCD008C_555F0C89007D_var*
//#UC END# *555F0CCD008C_555F0C89007D_var*
begin
//#UC START# *555F0CCD008C_555F0C89007D_impl*
 inherited Create;
 aParams.SetRefTo(f_Params);
//#UC END# *555F0CCD008C_555F0C89007D_impl*
end;//ThtDataSchemeHelper.Create

class function ThtDataSchemeHelper.Make(aParams: ThtDataProviderParams): IhtDataSchemeHelper;
var
 l_Inst : ThtDataSchemeHelper;
begin
 l_Inst := Create(aParams);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtDataSchemeHelper.Make

function ThtDataSchemeHelper.TableFullPath(aTable: TdaTables): AnsiString;
//#UC START# *555EF7F5009F_555F0C89007D_var*
const
 cMap: array [TdaTables] of AnsiString = (
  'ACCESS','PASS','USERS','GUDT','GULNK',
  'FAMILY','FREE','BB_LOG', 'CTRL', 'REGIONS',

  '---', // фиктивная таблица
  'FILE','HLINK','SUB','FREE',
  'DT#1','DT#2','DT#3','DT#5',
  'DT#6','DT#7','DT#8','DT#9','DT#A',
  'DT#B','DT#C','DT#D','DT#E','DT#3E',
  'DT#F','DT#I','DT#J',

  'LNK#1','LNK#2','LNK#3','LNK#5',
  'LNK#6','LNK#7','LNK#8','LNK#9',
  'LNK#B','LNK#C','LNK#D','LNK#E',
  'LNK#F','LNK#I','LNK#J',
  'LNK#K',
  'PRIOR','RENUM','STAGE','LOG',
  'ACTIV', 'ALARM', 'CTRL',
  'FILE'{Dup1}, 'FILE'{Dup2}
 );
//#UC END# *555EF7F5009F_555F0C89007D_var*
begin
//#UC START# *555EF7F5009F_555F0C89007D_impl*
 if TableFamily(aTable) = 0 then
  Result := ConcatDirName(f_Params.TablePath, cMap[aTable])
 else
  Result := ConcatDirName(f_Params.DocStoragePath, cMap[aTable] + IntToHex(TableFamily(aTable), 3));
//#UC END# *555EF7F5009F_555F0C89007D_impl*
end;//ThtDataSchemeHelper.TableFullPath

function ThtDataSchemeHelper.TablePassword(aTable: TdaTables): AnsiString;
//#UC START# *555EF81A03BF_555F0C89007D_var*
const
 cIndexMap: array [TdaTables] of Integer = (
  1,1,0,0,0,0,0,1,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 );

 cPasswordMap : Array [0..1] of AnsiString = ('','corvax');

//#UC END# *555EF81A03BF_555F0C89007D_var*
begin
//#UC START# *555EF81A03BF_555F0C89007D_impl*
 Result := cPasswordMap[cIndexMap[aTable]];
//#UC END# *555EF81A03BF_555F0C89007D_impl*
end;//ThtDataSchemeHelper.TablePassword

function ThtDataSchemeHelper.TableFamily(aTable: TdaTables): TdaFamilyID;
//#UC START# *555EF83803BE_555F0C89007D_var*
const
 cMap: array [TdaTables] of TdaFamilyID = (
  0,0,0,0,0,0,0,0,0,0,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
 );
//#UC END# *555EF83803BE_555F0C89007D_var*
begin
//#UC START# *555EF83803BE_555F0C89007D_impl*
 Result := cMap[aTable];
//#UC END# *555EF83803BE_555F0C89007D_impl*
end;//ThtDataSchemeHelper.TableFamily

procedure ThtDataSchemeHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_555F0C89007D_var*
//#UC END# *479731C50290_555F0C89007D_var*
begin
//#UC START# *479731C50290_555F0C89007D_impl*
 FreeAndNil(f_Params);
 inherited;
//#UC END# *479731C50290_555F0C89007D_impl*
end;//ThtDataSchemeHelper.Cleanup

end.
