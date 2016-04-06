unit NOT_COMPLETED_nevNullParaList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevNullParaList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevNullParaList" MUID: (48CE5C2E0058)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevNullPara
 , nevTools
 , nevBase
 , l3Variant
;

type
 TnevNullParaList = class(TnevNullPara, InevObjectList, InevParaList, InevParaListModify)
  protected
   function IndexOfObj(const aPara: InevObject): TnevParaIndex;
   function pm_GetCount: TnevParaIndex;
   function pm_GetLeafShapeCount: Integer;
   function pm_GetObj(anIndex: TnevParaIndex): InevObject;
   function pm_GetAlmostLinear: Boolean;
   function GetParas(aFrom: TnevParaIndex = nev_piFirst;
    aTo: TnevParaIndex = nev_piLast): InevParas;
    {* возвращает список параграфов. }
   function Modify: InevParaListModify;
   function pm_GetParaCount: TnevParaIndex;
   function pm_GetPara(anIndex: TnevParaIndex): InevPara;
   function InsertPara(aPID: TnevParaIndex;
    aPara: Tl3Variant;
    const anOp: InevOp;
    aFlags: TevInsertParaFlags = [ev_ipfNeedFire]): Boolean;
    {* вставляет параграф в указанную позицию. }
   function InsertDefaultPara(aPID: TnevParaIndex;
    const anOp: InevOp;
    aNeedFire: Boolean = True): Boolean;
    {* вставляет параграф с типом по-умолчанию в указанную позицию. }
   function IteratePara(anAction: InevParaList_IteratePara_Action;
    aLo: TnevParaIndex = nev_piFirst;
    aHi: TnevParaIndex = nev_piLast;
    aLoadedOnly: Boolean = False): Integer; virtual;
   function IterateParaF(anAction: InevParaList_IteratePara_Action;
    aLo: TnevParaIndex = nev_piFirst;
    aHi: TnevParaIndex = nev_piLast;
    aLoadedOnly: Boolean = False): Integer;
   function GetOwnerPara: InevParaList; override;
   function GetIsList: Boolean; override;
   function GetToList: InevObjectList; override;
   function GetAsList: InevParaList; override;
  public
   class function Make: InevParaList; reintroduce;
 end;//TnevNullParaList
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , l3Base
 , nevFacade
;

class function TnevNullParaList.Make: InevParaList;
var
 l_Inst : TnevNullParaList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevNullParaList.Make

function TnevNullParaList.IndexOfObj(const aPara: InevObject): TnevParaIndex;
//#UC START# *47C6A568017D_48CE5C2E0058_var*
//#UC END# *47C6A568017D_48CE5C2E0058_var*
begin
//#UC START# *47C6A568017D_48CE5C2E0058_impl*
 Result := nev_piNull;
//#UC END# *47C6A568017D_48CE5C2E0058_impl*
end;//TnevNullParaList.IndexOfObj

function TnevNullParaList.pm_GetCount: TnevParaIndex;
//#UC START# *47C6A5770114_48CE5C2E0058get_var*
//#UC END# *47C6A5770114_48CE5C2E0058get_var*
begin
//#UC START# *47C6A5770114_48CE5C2E0058get_impl*
 Result := 0;
//#UC END# *47C6A5770114_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetCount

function TnevNullParaList.pm_GetLeafShapeCount: Integer;
//#UC START# *47C6A58A02B6_48CE5C2E0058get_var*
//#UC END# *47C6A58A02B6_48CE5C2E0058get_var*
begin
//#UC START# *47C6A58A02B6_48CE5C2E0058get_impl*
 Result := 0;
//#UC END# *47C6A58A02B6_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetLeafShapeCount

function TnevNullParaList.pm_GetObj(anIndex: TnevParaIndex): InevObject;
//#UC START# *47C6A596031E_48CE5C2E0058get_var*
//#UC END# *47C6A596031E_48CE5C2E0058get_var*
begin
//#UC START# *47C6A596031E_48CE5C2E0058get_impl*
 Result := pm_GetPara(anIndex);
//#UC END# *47C6A596031E_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetObj

function TnevNullParaList.pm_GetAlmostLinear: Boolean;
//#UC START# *47C6A5C6002E_48CE5C2E0058get_var*
//#UC END# *47C6A5C6002E_48CE5C2E0058get_var*
begin
//#UC START# *47C6A5C6002E_48CE5C2E0058get_impl*
 Result := true;
//#UC END# *47C6A5C6002E_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetAlmostLinear

function TnevNullParaList.GetParas(aFrom: TnevParaIndex = nev_piFirst;
 aTo: TnevParaIndex = nev_piLast): InevParas;
 {* возвращает список параграфов. }
//#UC START# *47C6AC130151_48CE5C2E0058_var*
//#UC END# *47C6AC130151_48CE5C2E0058_var*
begin
//#UC START# *47C6AC130151_48CE5C2E0058_impl*
 Result := nil;
//#UC END# *47C6AC130151_48CE5C2E0058_impl*
end;//TnevNullParaList.GetParas

function TnevNullParaList.Modify: InevParaListModify;
//#UC START# *47C6AC79001C_48CE5C2E0058_var*
//#UC END# *47C6AC79001C_48CE5C2E0058_var*
begin
//#UC START# *47C6AC79001C_48CE5C2E0058_impl*
 Result := Self;
//#UC END# *47C6AC79001C_48CE5C2E0058_impl*
end;//TnevNullParaList.Modify

function TnevNullParaList.pm_GetParaCount: TnevParaIndex;
//#UC START# *47C6AC870058_48CE5C2E0058get_var*
//#UC END# *47C6AC870058_48CE5C2E0058get_var*
begin
//#UC START# *47C6AC870058_48CE5C2E0058get_impl*
 Result := 0;
//#UC END# *47C6AC870058_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetParaCount

function TnevNullParaList.pm_GetPara(anIndex: TnevParaIndex): InevPara;
//#UC START# *47C6AC9F01DF_48CE5C2E0058get_var*
//#UC END# *47C6AC9F01DF_48CE5C2E0058get_var*
begin
//#UC START# *47C6AC9F01DF_48CE5C2E0058get_impl*
 Result := nev.NullPara;
 Result.ParentTool := Self;
//#UC END# *47C6AC9F01DF_48CE5C2E0058get_impl*
end;//TnevNullParaList.pm_GetPara

function TnevNullParaList.InsertPara(aPID: TnevParaIndex;
 aPara: Tl3Variant;
 const anOp: InevOp;
 aFlags: TevInsertParaFlags = [ev_ipfNeedFire]): Boolean;
 {* вставляет параграф в указанную позицию. }
//#UC START# *47C6ACC90087_48CE5C2E0058_var*
//#UC END# *47C6ACC90087_48CE5C2E0058_var*
begin
//#UC START# *47C6ACC90087_48CE5C2E0058_impl*
 Result := false;
//#UC END# *47C6ACC90087_48CE5C2E0058_impl*
end;//TnevNullParaList.InsertPara

function TnevNullParaList.InsertDefaultPara(aPID: TnevParaIndex;
 const anOp: InevOp;
 aNeedFire: Boolean = True): Boolean;
 {* вставляет параграф с типом по-умолчанию в указанную позицию. }
//#UC START# *47C6ACE6026E_48CE5C2E0058_var*
//#UC END# *47C6ACE6026E_48CE5C2E0058_var*
begin
//#UC START# *47C6ACE6026E_48CE5C2E0058_impl*
 Result := false;
//#UC END# *47C6ACE6026E_48CE5C2E0058_impl*
end;//TnevNullParaList.InsertDefaultPara

function TnevNullParaList.IteratePara(anAction: InevParaList_IteratePara_Action;
 aLo: TnevParaIndex = nev_piFirst;
 aHi: TnevParaIndex = nev_piLast;
 aLoadedOnly: Boolean = False): Integer;
//#UC START# *4BB0751F00A4_48CE5C2E0058_var*
//#UC END# *4BB0751F00A4_48CE5C2E0058_var*
begin
//#UC START# *4BB0751F00A4_48CE5C2E0058_impl*
 Result := nev_piNull;
//#UC END# *4BB0751F00A4_48CE5C2E0058_impl*
end;//TnevNullParaList.IteratePara

function TnevNullParaList.IterateParaF(anAction: InevParaList_IteratePara_Action;
 aLo: TnevParaIndex = nev_piFirst;
 aHi: TnevParaIndex = nev_piLast;
 aLoadedOnly: Boolean = False): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := IteratePara(anAction, aLo, aHi, aLoadedOnly);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//TnevNullParaList.IterateParaF

function TnevNullParaList.GetOwnerPara: InevParaList;
//#UC START# *48CE65BC021C_48CE5C2E0058_var*
//#UC END# *48CE65BC021C_48CE5C2E0058_var*
begin
//#UC START# *48CE65BC021C_48CE5C2E0058_impl*
 Result := Self;
//#UC END# *48CE65BC021C_48CE5C2E0058_impl*
end;//TnevNullParaList.GetOwnerPara

function TnevNullParaList.GetIsList: Boolean;
//#UC START# *48CE681402F4_48CE5C2E0058_var*
//#UC END# *48CE681402F4_48CE5C2E0058_var*
begin
//#UC START# *48CE681402F4_48CE5C2E0058_impl*
 Result := true;
//#UC END# *48CE681402F4_48CE5C2E0058_impl*
end;//TnevNullParaList.GetIsList

function TnevNullParaList.GetToList: InevObjectList;
//#UC START# *48CE699100FE_48CE5C2E0058_var*
//#UC END# *48CE699100FE_48CE5C2E0058_var*
begin
//#UC START# *48CE699100FE_48CE5C2E0058_impl*
 Result := Self;
//#UC END# *48CE699100FE_48CE5C2E0058_impl*
end;//TnevNullParaList.GetToList

function TnevNullParaList.GetAsList: InevParaList;
//#UC START# *48CE69D3015A_48CE5C2E0058_var*
//#UC END# *48CE69D3015A_48CE5C2E0058_var*
begin
//#UC START# *48CE69D3015A_48CE5C2E0058_impl*
 Result := Self;
//#UC END# *48CE69D3015A_48CE5C2E0058_impl*
end;//TnevNullParaList.GetAsList
{$IfEnd} // Defined(k2ForEditor)

end.
