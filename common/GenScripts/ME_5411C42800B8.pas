unit m3StoreHeader;
 {* Описатель элемента хранилища (потока или подхранилища) }

// Модуль: "w:\common\components\rtl\Garant\m3\m3StoreHeader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StoreHeader" MUID: (5411C42800B8)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , m3StoreHeaderDataPrim
 , m3RootStreamManagerPrim
 , l3_String
 , l3Base
 , m3StorageInterfaces
;

type
 Tm3StoreHeader = class(Tl3CProtoObject)
  {* Описатель элемента хранилища (потока или подхранилища) }
  private
   f_HeaderData: Tm3StoreHeaderDataPrim;
   f_RootStreamManager: Tm3RootStreamManagerPrim;
   f_Name: Tl3_String;
  protected
   function pm_GetTOCListPosition: Int64;
   procedure pm_SetTOCListPosition(aValue: Int64);
   constructor CreatePrim(aName: Tl3String;
    aRootStreamManager: Tm3RootStreamManagerPrim;
    aData: Tm3StoreHeaderDataPrim); reintroduce;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Create(anAccess: Tm3StoreAccess;
    aName: Tl3String;
    aRootStreamManager: Tm3RootStreamManagerPrim;
    aTOCItemDataPosition: Int64): Tm3StoreHeader;
  public
   property HeaderData: Tm3StoreHeaderDataPrim
    read f_HeaderData;
   property RootStreamManager: Tm3RootStreamManagerPrim
    read f_RootStreamManager;
   property TOCListPosition: Int64
    read pm_GetTOCListPosition
    write pm_SetTOCListPosition;
   property Name: Tl3_String
    read f_Name;
 end;//Tm3StoreHeader

implementation

uses
 l3ImplUses
 , SysUtils
 , ActiveX
;

function Tm3StoreHeader.pm_GetTOCListPosition: Int64;
//#UC START# *5411C49E0248_5411C42800B8get_var*
//#UC END# *5411C49E0248_5411C42800B8get_var*
begin
//#UC START# *5411C49E0248_5411C42800B8get_impl*
 Result := Self.HeaderData.RTOCItemListPosition;
//#UC END# *5411C49E0248_5411C42800B8get_impl*
end;//Tm3StoreHeader.pm_GetTOCListPosition

procedure Tm3StoreHeader.pm_SetTOCListPosition(aValue: Int64);
//#UC START# *5411C49E0248_5411C42800B8set_var*
//#UC END# *5411C49E0248_5411C42800B8set_var*
begin
//#UC START# *5411C49E0248_5411C42800B8set_impl*
 Self.HeaderData.RTOCItemListPosition := aValue;
//#UC END# *5411C49E0248_5411C42800B8set_impl*
end;//Tm3StoreHeader.pm_SetTOCListPosition

constructor Tm3StoreHeader.CreatePrim(aName: Tl3String;
 aRootStreamManager: Tm3RootStreamManagerPrim;
 aData: Tm3StoreHeaderDataPrim);
//#UC START# *5411C4EB00A3_5411C42800B8_var*
//#UC END# *5411C4EB00A3_5411C42800B8_var*
begin
//#UC START# *5411C4EB00A3_5411C42800B8_impl*
 Assert(aData <> nil);
 Assert(aRootStreamManager <> nil);
 inherited Create;
 aName.SetRefTo(f_Name);
 aData.SetRefTo(f_HeaderData);
 aRootStreamManager.SetRefTo(f_RootStreamManager);
//#UC END# *5411C4EB00A3_5411C42800B8_impl*
end;//Tm3StoreHeader.CreatePrim

class function Tm3StoreHeader.Create(anAccess: Tm3StoreAccess;
 aName: Tl3String;
 aRootStreamManager: Tm3RootStreamManagerPrim;
 aTOCItemDataPosition: Int64): Tm3StoreHeader;
//#UC START# *54183548003F_5411C42800B8_var*
var
 l_Data : Tm3StoreHeaderDataPrim;
//#UC END# *54183548003F_5411C42800B8_var*
begin
//#UC START# *54183548003F_5411C42800B8_impl*
 Assert((anAccess = m3_saRead) OR (anAccess = m3_saReadWrite) OR
        (anAccess = STGM_READ) OR (anAccess = STGM_READWRITE));
 Assert(aRootStreamManager <> nil);
 l_Data := aRootStreamManager.StoreHeaderDataClass.Create(aRootStreamManager,
                                                          ATOCItemDataPosition,
                                                          (anAccess AND (STGM_WRITE OR STGM_READWRITE) = 0),
                                                          aName);
 try
  Result := CreatePrim(aName, aRootStreamManager, l_Data);
 finally
  FreeAndNil(l_Data);
 end;//try..finally
//#UC END# *54183548003F_5411C42800B8_impl*
end;//Tm3StoreHeader.Create

procedure Tm3StoreHeader.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5411C42800B8_var*
//#UC END# *479731C50290_5411C42800B8_var*
begin
//#UC START# *479731C50290_5411C42800B8_impl*
 try
  FreeAndNil(f_RootStreamManager);
 finally
  try
   FreeAndNil(f_Name);
  finally
   try
    inherited;
   finally
    FreeAndNil(f_HeaderData);
   end;//try..finally 
  end;//try..finally
 end;//try..finally
//#UC END# *479731C50290_5411C42800B8_impl*
end;//Tm3StoreHeader.Cleanup

end.
