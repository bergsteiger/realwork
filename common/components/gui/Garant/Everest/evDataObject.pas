unit evDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDataObject.pas"
// Начат: 06.04.2001 14:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevDataObject
//
// Реализация интерфейса IDataObject для выделения текста редактора
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  nevBase,
  l3StorableDataObject,
  evdInterfaces,
  l3IID
  ;

type
 TevDataObject = class(Tl3StorableDataObject)
  {* Реализация интерфейса IDataObject для выделения текста редактора }
 private
 // private fields
   f_Filters : InevTagGenerator;
   f_Block : IevdDataObject;
    {* Поле для свойства Block}
 protected
 // realized methods
   function Store(aFormat: Tl3ClipboardFormat;
    const aPool: IStream): Boolean; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoQueryGetData(const aFormatEtc: TFormatEtc): HResult; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aBlock: IevdDataObject;
    const aFormats: Tl3ClipboardFormats;
    const aFilters: InevTagGenerator); reintroduce;
 public
 // public properties
   property Block: IevdDataObject
     read f_Block;
 end;//TevDataObject

implementation

// start class TevDataObject

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
 {-}
begin
 f_Block := nil;
 inherited;
end;//TevDataObject.ClearFields

end.