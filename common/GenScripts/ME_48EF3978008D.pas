unit evDataObject;
 {* Реализация интерфейса IDataObject для выделения текста редактора }

// Модуль: "w:\common\components\gui\Garant\Everest\evDataObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3StorableDataObject
 , evdInterfaces
 , nevBase
 , l3Interfaces
 , l3IID
;

type
 TevDataObject = class(Tl3StorableDataObject)
  {* Реализация интерфейса IDataObject для выделения текста редактора }
  private
   f_Filters: InevTagGenerator;
   f_Block: IevdDataObject;
    {* Поле для свойства Block }
  protected
   function Store(aFormat: Tl3ClipboardFormat;
    const aPool: IStream): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoQueryGetData(const aFormatEtc: TFormatEtc): HResult; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   constructor Create(const aBlock: IevdDataObject;
    const aFormats: Tl3ClipboardFormats;
    const aFilters: InevTagGenerator); reintroduce;
  public
   property Block: IevdDataObject
    read f_Block;
 end;//TevDataObject

implementation

uses
 l3ImplUses
;

constructor TevDataObject.Create(const aBlock: IevdDataObject;
 const aFormats: Tl3ClipboardFormats;
 const aFilters: InevTagGenerator);
//#UC START# *48F4687B02D0_48EF3978008D_var*
//#UC END# *48F4687B02D0_48EF3978008D_var*
begin
//#UC START# *48F4687B02D0_48EF3978008D_impl*
 inherited Create(aFormats);
 f_Block := aBlock;
 f_Filters := aFilters;
//#UC END# *48F4687B02D0_48EF3978008D_impl*
end;//TevDataObject.Create

function TevDataObject.Store(aFormat: Tl3ClipboardFormat;
 const aPool: IStream): Boolean;
//#UC START# *48F37AC50290_48EF3978008D_var*
//#UC END# *48F37AC50290_48EF3978008D_var*
begin
//#UC START# *48F37AC50290_48EF3978008D_impl*
 Result := f_Block.Store(aFormat, aPool, f_Filters);
//#UC END# *48F37AC50290_48EF3978008D_impl*
end;//TevDataObject.Store

procedure TevDataObject.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48EF3978008D_var*
//#UC END# *479731C50290_48EF3978008D_var*
begin
//#UC START# *479731C50290_48EF3978008D_impl*
 f_Block := nil;
 f_Filters := nil;
 inherited;
//#UC END# *479731C50290_48EF3978008D_impl*
end;//TevDataObject.Cleanup

function TevDataObject.DoQueryGetData(const aFormatEtc: TFormatEtc): HResult;
//#UC START# *48F359680368_48EF3978008D_var*
//#UC END# *48F359680368_48EF3978008D_var*
begin
//#UC START# *48F359680368_48EF3978008D_impl*
 if (f_Block = nil) then
  Result := OLE_E_NotRunning
 else
  Result := inherited DoQueryGetData(aFormatEtc);
//#UC END# *48F359680368_48EF3978008D_impl*
end;//TevDataObject.DoQueryGetData

function TevDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_48EF3978008D_var*
//#UC END# *4A60B23E00C3_48EF3978008D_var*
begin
//#UC START# *4A60B23E00C3_48EF3978008D_impl*
 Result.SetOk;
 if IID.EQ(IevdDataObject) then
  IevdDataObject(Obj) := f_Block
 else
 if IID.EQ(IStream) then
  Result := Tl3HResult_C(f_Block.QueryInterface(IID.IID, Obj))
 else
 if IID.EQ(Il3DataObjectInfo) then
  Result := Tl3HResult_C(f_Block.QueryInterface(IID.IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_48EF3978008D_impl*
end;//TevDataObject.COMQueryInterface

procedure TevDataObject.ClearFields;
begin
 f_Block := nil;
 inherited;
end;//TevDataObject.ClearFields

end.
