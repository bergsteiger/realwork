unit htDataSchemeHelper;

// Модуль: "w:\common\components\rtl\Garant\HT\htDataSchemeHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtDataSchemeHelper" MUID: (555F0C89007D)

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
 , daScheme
 , daSchemeConsts
 //#UC START# *555F0C89007Dimpl_uses*
 //#UC END# *555F0C89007Dimpl_uses*
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
//#UC END# *555EF7F5009F_555F0C89007D_var*
begin
//#UC START# *555EF7F5009F_555F0C89007D_impl*
 if TdaScheme.Instance.Table(aTable).FamilyID = MainTblsFamily then
  Result := ConcatDirName(f_Params.TablePath, TdaScheme.Instance.Table(aTable).Code)
 else
  if aTable in [da_ftAutolinkDocumentsLocal, da_ftAutolinkEditionsLocal, da_ftAutolinkDocumentsRemote, da_ftAutolinkEditionsRemote] then
   Result := ConcatDirName(f_Params.DocStoragePath, 'garant\' + TdaScheme.Instance.Table(aTable).Code)
  else
   Result := ConcatDirName(f_Params.DocStoragePath, 'garant\' + TdaScheme.Instance.Table(aTable).Code + IntToHex(TdaScheme.Instance.Table(aTable).FamilyID, 3));
//#UC END# *555EF7F5009F_555F0C89007D_impl*
end;//ThtDataSchemeHelper.TableFullPath

function ThtDataSchemeHelper.TablePassword(aTable: TdaTables): AnsiString;
//#UC START# *555EF81A03BF_555F0C89007D_var*
const
 cIndexMap: array [TdaTables] of Integer = (
  1,1,0,0,0,0,0,1,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0
 );

 cPasswordMap : Array [0..1] of AnsiString = ('','corvax');

//#UC END# *555EF81A03BF_555F0C89007D_var*
begin
//#UC START# *555EF81A03BF_555F0C89007D_impl*
 Result := cPasswordMap[cIndexMap[aTable]];
//#UC END# *555EF81A03BF_555F0C89007D_impl*
end;//ThtDataSchemeHelper.TablePassword

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
