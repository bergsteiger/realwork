unit bsListDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsListDataObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 TbsListDataObject = class(TevNodeData)
  private
   f_ListData: IbsListTreeData;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetData(const aFormatEtcIn: TFormatEtc;
    var medium: Tl3StoragePlace): HResult; override;
   function GetFormats: Tl3ClipboardFormats; override;
   function MakeExtData: IDataObject; override;
  public
   constructor Create(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap;
    const aListData: IbsListTreeData); reintroduce;
   class function Make(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap;
    const aListData: IbsListTreeData): IDataObject; reintroduce;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TbsListDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , nsNodesDataObject
 , bsConvert
 , l3TreeConst
 , Windows
;

constructor TbsListDataObject.Create(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap;
 const aListData: IbsListTreeData);
//#UC START# *48F7415A0374_48F740E40022_var*
//#UC END# *48F7415A0374_48F740E40022_var*
begin
//#UC START# *48F7415A0374_48F740E40022_impl*
 inherited Create(aData, aBitmap);
 f_ListData := aListData;
//#UC END# *48F7415A0374_48F740E40022_impl*
end;//TbsListDataObject.Create

class function TbsListDataObject.Make(const aData: Il3SimpleNode;
 const aBitmap: Il3Bitmap;
 const aListData: IbsListTreeData): IDataObject;
var
 l_Inst : TbsListDataObject;
begin
 l_Inst := Create(aData, aBitmap, aListData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsListDataObject.Make

procedure TbsListDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F740E40022_var*
//#UC END# *479731C50290_48F740E40022_var*
begin
//#UC START# *479731C50290_48F740E40022_impl*
 f_ListData := nil;
 inherited;
//#UC END# *479731C50290_48F740E40022_impl*
end;//TbsListDataObject.Cleanup

function TbsListDataObject.DoGetData(const aFormatEtcIn: TFormatEtc;
 var medium: Tl3StoragePlace): HResult;
//#UC START# *48F3495D0398_48F740E40022_var*
var
 l_Handle : THandle;
 l_Data   : Pl3TreeData;
//#UC END# *48F3495D0398_48F740E40022_var*
begin
//#UC START# *48F3495D0398_48F740E40022_impl*
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
       Pointer(l_Data.rNode) := Pointer(f_ListData.Node);
       Pointer(l_Data.rNodes) := Pointer(f_ListData);
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
//#UC END# *48F3495D0398_48F740E40022_impl*
end;//TbsListDataObject.DoGetData

function TbsListDataObject.GetFormats: Tl3ClipboardFormats;
//#UC START# *48F4B33501DE_48F740E40022_var*
//#UC END# *48F4B33501DE_48F740E40022_var*
begin
//#UC START# *48F4B33501DE_48F740E40022_impl*
 Result := l3CatFormatArray([CF_TreeNodes], inherited GetFormats);
//#UC END# *48F4B33501DE_48F740E40022_impl*
end;//TbsListDataObject.GetFormats

function TbsListDataObject.MakeExtData: IDataObject;
//#UC START# *48F89615037B_48F740E40022_var*
//#UC END# *48F89615037B_48F740E40022_var*
begin
//#UC START# *48F89615037B_48F740E40022_impl*
 Result := TnsNodesDataObject.Make(f_ListData.Nodes,
  bsAdapterToBusiness(f_ListData.List.GetContentType));
//#UC END# *48F89615037B_48F740E40022_impl*
end;//TbsListDataObject.MakeExtData

function TbsListDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_48F740E40022_var*
//#UC END# *4A60B23E00C3_48F740E40022_var*
begin
//#UC START# *4A60B23E00C3_48F740E40022_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail and IID.EQ(IbsListTreeData) then
 begin
  Result.SetOK;
  IbsListTreeData(Obj) := f_ListData;
 end;//if l3IFail(Result) and IID.EQ(IbsListTreeData) then
//#UC END# *4A60B23E00C3_48F740E40022_impl*
end;//TbsListDataObject.COMQueryInterface
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
