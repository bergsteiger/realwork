unit bsUserDataObject;
 {* Данные списка пользователей }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\bsUserDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TbsUserDataObject" MUID: (49F552BA0035)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , evNodeData
 , bsInterfaces
 , l3Interfaces
 , l3TreeInterfaces
 , l3InternalInterfaces
 , l3IID
;

type
 TbsUserDataObject = class(TevNodeData)
  {* Данные списка пользователей }
  private
   f_UserData: IbsUserTreeData;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetData(const aFormatEtcIn: TFormatEtc;
    var medium: Tl3StoragePlace): HResult; override;
   function GetFormats: Tl3ClipboardFormats; override;
   function MakeExtData: IDataObject; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   constructor Create(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap;
    const aUserData: IbsUserTreeData); reintroduce;
   class function Make(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap;
    const aUserData: IbsUserTreeData): IDataObject; reintroduce;
 end;//TbsUserDataObject
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3TreeConst
 , l3Base
 , Windows
 , nsUserDataObject
 //#UC START# *49F552BA0035impl_uses*
 //#UC END# *49F552BA0035impl_uses*
;

constructor TbsUserDataObject.Create(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap;
 const aUserData: IbsUserTreeData);
//#UC START# *49F5530A032E_49F552BA0035_var*
//#UC END# *49F5530A032E_49F552BA0035_var*
begin
//#UC START# *49F5530A032E_49F552BA0035_impl*
 inherited Create(aData, aBitmap);
 f_UserData := aUserData;
//#UC END# *49F5530A032E_49F552BA0035_impl*
end;//TbsUserDataObject.Create

class function TbsUserDataObject.Make(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap;
 const aUserData: IbsUserTreeData): IDataObject;
var
 l_Inst : TbsUserDataObject;
begin
 l_Inst := Create(aData, aBitmap, aUserData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsUserDataObject.Make

procedure TbsUserDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49F552BA0035_var*
//#UC END# *479731C50290_49F552BA0035_var*
begin
//#UC START# *479731C50290_49F552BA0035_impl*
 f_UserData := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49F552BA0035_impl*
end;//TbsUserDataObject.Cleanup

function TbsUserDataObject.DoGetData(const aFormatEtcIn: TFormatEtc;
 var medium: Tl3StoragePlace): HResult;
//#UC START# *48F3495D0398_49F552BA0035_var*
var
 l_Handle : THandle;
 l_Data   : Pl3TreeData;
//#UC END# *48F3495D0398_49F552BA0035_var*
begin
//#UC START# *48F3495D0398_49F552BA0035_impl*
 Result := inherited DoGetData(aFormatEtcIn, medium);
 if (Result <> S_Ok) then
 begin
  with aFormatEtcIn do
  begin
   if (cfFormat = CF_TreeNodes) then
   begin
    if (tymed AND TYMED_HGLOBAL <> 0) then
    begin
     medium.tymed := TYMED_HGLOBAL;
     l_Handle := l3System.GlobalAlloc(GMEM_SHARE, SizeOf(Tl3TreeData));
     try
      l_Data := GlobalLock(l_Handle);
      try
       l3FillChar(l_Data^, SizeOf(l_Data^), 0);
       l_Data.rMultiSelection := True;
       Pointer(l_Data.rNode) := Pointer(f_UserData.Node);
       Pointer(l_Data.rNodes) := Pointer(f_UserData);
      finally
       GlobalUnlock(l_Handle);
      end;//try..finally
      medium.hGlobal := l3System.ReleaseHandle(l_Handle);
      Result := S_Ok;
     except
      l3System.GlobalFree(l_Handle);
      Result := E_OutOfMemory;
     end;//try..except
    end;//tymed AND TYMED_HGLOBAL <> 0
   end;//cfFormat = CF_TreeNode
  end;//with aFormatEtcIn
 end;//Result <> S_Ok
//#UC END# *48F3495D0398_49F552BA0035_impl*
end;//TbsUserDataObject.DoGetData

function TbsUserDataObject.GetFormats: Tl3ClipboardFormats;
//#UC START# *48F4B33501DE_49F552BA0035_var*
//#UC END# *48F4B33501DE_49F552BA0035_var*
begin
//#UC START# *48F4B33501DE_49F552BA0035_impl*
 Result := l3CatFormatArray([CF_TreeNodes], inherited GetFormats);
//#UC END# *48F4B33501DE_49F552BA0035_impl*
end;//TbsUserDataObject.GetFormats

function TbsUserDataObject.MakeExtData: IDataObject;
//#UC START# *48F89615037B_49F552BA0035_var*
//#UC END# *48F89615037B_49F552BA0035_var*
begin
//#UC START# *48F89615037B_49F552BA0035_impl*
 Result := TnsUserDataObject.Make(f_UserData.Users);
//#UC END# *48F89615037B_49F552BA0035_impl*
end;//TbsUserDataObject.MakeExtData

function TbsUserDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_49F552BA0035_var*
//#UC END# *4A60B23E00C3_49F552BA0035_var*
begin
//#UC START# *4A60B23E00C3_49F552BA0035_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and IID.EQ(IbsUserTreeData) then
 begin
  Result.SetOK;
  IbsUserTreeData(Obj) := f_UserData;
 end;//if l3IFail(Result) and IID.EQ(IbsListTreeData) then
//#UC END# *4A60B23E00C3_49F552BA0035_impl*
end;//TbsUserDataObject.COMQueryInterface
{$IfEnd} // Defined(Admin)

end.
