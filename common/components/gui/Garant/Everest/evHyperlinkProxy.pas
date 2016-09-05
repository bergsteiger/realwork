unit evHyperlinkProxy;

// Модуль: "w:\common\components\gui\Garant\Everest\evHyperlinkProxy.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHyperlinkProxy" MUID: (4E1DD7720136)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , l3CProtoObject
 , nevNavigation
 , evdTypes
 , nevTools
 , afwNavigation
 , l3Types
 , l3Variant
 , l3Interfaces
;

type
 TevHyperlinkProxy = class(Tl3CProtoObject, IevHyperlink)
  private
   f_Link: IevHyperlink;
  protected
   function DoFromDocumentExternalHandle: Integer; virtual;
   function DoGetKind: TevLinkViewKind; virtual;
   function Exists: Boolean;
    {* Проверяет существует ли данная ссылка }
   procedure Insert;
    {* Вставляет новую ссылку }
   procedure Delete;
    {* Удаляет гипертекстовую ссылку }
   function Get_ID: Integer;
   procedure Set_ID(aValue: Integer);
   function pm_GetPara: InevPara;
   function pm_GetAddressList: IevAddressList;
   function pm_GetAddress: TevAddress;
   procedure pm_SetAddress(const aValue: TevAddress);
   function pm_GetURL: Tl3PCharLen;
   procedure pm_SetURL(const aValue: Tl3PCharLen);
   function pm_GetHint: Tl3PCharLen;
   procedure pm_SetHint(const aValue: Tl3PCharLen);
   function pm_GetKind: TevLinkViewKind;
   procedure pm_SetKind(aValue: TevLinkViewKind);
   function Get_FromDocumentExternalHandle: Integer;
   function Get_TargetDocumentID: Integer;
   function Get_Name: Tl3PCharLen;
   function GetHyperlink: Tl3Tag;
   procedure ClearFields; override;
  public
   constructor Create(const aLink: IevHyperlink); reintroduce;
   class function Make(const aLink: IevHyperlink): IevHyperlink; reintroduce;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//TevHyperlinkProxy
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , l3InterfacesMisc
 //#UC START# *4E1DD7720136impl_uses*
 //#UC END# *4E1DD7720136impl_uses*
;

constructor TevHyperlinkProxy.Create(const aLink: IevHyperlink);
//#UC START# *4E1DD7FE016D_4E1DD7720136_var*
//#UC END# *4E1DD7FE016D_4E1DD7720136_var*
begin
//#UC START# *4E1DD7FE016D_4E1DD7720136_impl*
 Assert(aLink <> nil);
 inherited Create;
 f_Link := aLink;
//#UC END# *4E1DD7FE016D_4E1DD7720136_impl*
end;//TevHyperlinkProxy.Create

class function TevHyperlinkProxy.Make(const aLink: IevHyperlink): IevHyperlink;
var
 l_Inst : TevHyperlinkProxy;
begin
 l_Inst := Create(aLink);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevHyperlinkProxy.Make

function TevHyperlinkProxy.DoFromDocumentExternalHandle: Integer;
//#UC START# *4E1DDB7D0368_4E1DD7720136_var*
//#UC END# *4E1DDB7D0368_4E1DD7720136_var*
begin
//#UC START# *4E1DDB7D0368_4E1DD7720136_impl*
 Result := f_Link.FromDocumentExternalHandle;
//#UC END# *4E1DDB7D0368_4E1DD7720136_impl*
end;//TevHyperlinkProxy.DoFromDocumentExternalHandle

function TevHyperlinkProxy.DoGetKind: TevLinkViewKind;
//#UC START# *55F6C6DC018B_4E1DD7720136_var*
//#UC END# *55F6C6DC018B_4E1DD7720136_var*
begin
//#UC START# *55F6C6DC018B_4E1DD7720136_impl*
 Result := f_Link.Kind;
//#UC END# *55F6C6DC018B_4E1DD7720136_impl*
end;//TevHyperlinkProxy.DoGetKind

function TevHyperlinkProxy.Exists: Boolean;
 {* Проверяет существует ли данная ссылка }
//#UC START# *49E5FCF403BB_4E1DD7720136_var*
//#UC END# *49E5FCF403BB_4E1DD7720136_var*
begin
//#UC START# *49E5FCF403BB_4E1DD7720136_impl*
 Result := f_Link.Exists;
//#UC END# *49E5FCF403BB_4E1DD7720136_impl*
end;//TevHyperlinkProxy.Exists

procedure TevHyperlinkProxy.Insert;
 {* Вставляет новую ссылку }
//#UC START# *49E5FD13001E_4E1DD7720136_var*
//#UC END# *49E5FD13001E_4E1DD7720136_var*
begin
//#UC START# *49E5FD13001E_4E1DD7720136_impl*
 f_Link.Insert;
//#UC END# *49E5FD13001E_4E1DD7720136_impl*
end;//TevHyperlinkProxy.Insert

procedure TevHyperlinkProxy.Delete;
 {* Удаляет гипертекстовую ссылку }
//#UC START# *49E5FD1D0339_4E1DD7720136_var*
//#UC END# *49E5FD1D0339_4E1DD7720136_var*
begin
//#UC START# *49E5FD1D0339_4E1DD7720136_impl*
 f_Link.Delete;
//#UC END# *49E5FD1D0339_4E1DD7720136_impl*
end;//TevHyperlinkProxy.Delete

function TevHyperlinkProxy.Get_ID: Integer;
//#UC START# *49E5FD3C021B_4E1DD7720136get_var*
//#UC END# *49E5FD3C021B_4E1DD7720136get_var*
begin
//#UC START# *49E5FD3C021B_4E1DD7720136get_impl*
 Result := f_Link.ID;
//#UC END# *49E5FD3C021B_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.Get_ID

procedure TevHyperlinkProxy.Set_ID(aValue: Integer);
//#UC START# *49E5FD3C021B_4E1DD7720136set_var*
//#UC END# *49E5FD3C021B_4E1DD7720136set_var*
begin
//#UC START# *49E5FD3C021B_4E1DD7720136set_impl*
 f_Link.Id := aValue;
//#UC END# *49E5FD3C021B_4E1DD7720136set_impl*
end;//TevHyperlinkProxy.Set_ID

function TevHyperlinkProxy.pm_GetPara: InevPara;
//#UC START# *49E6095100C3_4E1DD7720136get_var*
//#UC END# *49E6095100C3_4E1DD7720136get_var*
begin
//#UC START# *49E6095100C3_4E1DD7720136get_impl*
 Result := f_Link.Para;
//#UC END# *49E6095100C3_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetPara

function TevHyperlinkProxy.pm_GetAddressList: IevAddressList;
//#UC START# *49E609B701E8_4E1DD7720136get_var*
//#UC END# *49E609B701E8_4E1DD7720136get_var*
begin
//#UC START# *49E609B701E8_4E1DD7720136get_impl*
 Result := f_Link.AddressList;
//#UC END# *49E609B701E8_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetAddressList

function TevHyperlinkProxy.pm_GetAddress: TevAddress;
//#UC START# *49E609D303A4_4E1DD7720136get_var*
//#UC END# *49E609D303A4_4E1DD7720136get_var*
begin
//#UC START# *49E609D303A4_4E1DD7720136get_impl*
 Result := f_Link.Address;
//#UC END# *49E609D303A4_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetAddress

procedure TevHyperlinkProxy.pm_SetAddress(const aValue: TevAddress);
//#UC START# *49E609D303A4_4E1DD7720136set_var*
//#UC END# *49E609D303A4_4E1DD7720136set_var*
begin
//#UC START# *49E609D303A4_4E1DD7720136set_impl*
 f_Link.Address := aValue;
//#UC END# *49E609D303A4_4E1DD7720136set_impl*
end;//TevHyperlinkProxy.pm_SetAddress

function TevHyperlinkProxy.pm_GetURL: Tl3PCharLen;
//#UC START# *49E609FD0318_4E1DD7720136get_var*
//#UC END# *49E609FD0318_4E1DD7720136get_var*
begin
//#UC START# *49E609FD0318_4E1DD7720136get_impl*
 Result := f_Link.URL;
//#UC END# *49E609FD0318_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetURL

procedure TevHyperlinkProxy.pm_SetURL(const aValue: Tl3PCharLen);
//#UC START# *49E609FD0318_4E1DD7720136set_var*
//#UC END# *49E609FD0318_4E1DD7720136set_var*
begin
//#UC START# *49E609FD0318_4E1DD7720136set_impl*
 f_Link.URL := aValue;
//#UC END# *49E609FD0318_4E1DD7720136set_impl*
end;//TevHyperlinkProxy.pm_SetURL

function TevHyperlinkProxy.pm_GetHint: Tl3PCharLen;
//#UC START# *49E60A1B02C4_4E1DD7720136get_var*
//#UC END# *49E60A1B02C4_4E1DD7720136get_var*
begin
//#UC START# *49E60A1B02C4_4E1DD7720136get_impl*
 Result := f_Link.Hint;
//#UC END# *49E60A1B02C4_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetHint

procedure TevHyperlinkProxy.pm_SetHint(const aValue: Tl3PCharLen);
//#UC START# *49E60A1B02C4_4E1DD7720136set_var*
//#UC END# *49E60A1B02C4_4E1DD7720136set_var*
begin
//#UC START# *49E60A1B02C4_4E1DD7720136set_impl*
 f_Link.Hint := aValue;
//#UC END# *49E60A1B02C4_4E1DD7720136set_impl*
end;//TevHyperlinkProxy.pm_SetHint

function TevHyperlinkProxy.pm_GetKind: TevLinkViewKind;
//#UC START# *49E60A650155_4E1DD7720136get_var*
//#UC END# *49E60A650155_4E1DD7720136get_var*
begin
//#UC START# *49E60A650155_4E1DD7720136get_impl*
 Result := DoGetKind;
//#UC END# *49E60A650155_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.pm_GetKind

procedure TevHyperlinkProxy.pm_SetKind(aValue: TevLinkViewKind);
//#UC START# *49E60A650155_4E1DD7720136set_var*
//#UC END# *49E60A650155_4E1DD7720136set_var*
begin
//#UC START# *49E60A650155_4E1DD7720136set_impl*
 f_Link.Kind := aValue;
//#UC END# *49E60A650155_4E1DD7720136set_impl*
end;//TevHyperlinkProxy.pm_SetKind

function TevHyperlinkProxy.Get_FromDocumentExternalHandle: Integer;
//#UC START# *4A72AAF50077_4E1DD7720136get_var*
//#UC END# *4A72AAF50077_4E1DD7720136get_var*
begin
//#UC START# *4A72AAF50077_4E1DD7720136get_impl*
 Result := DoFromDocumentExternalHandle;
//#UC END# *4A72AAF50077_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.Get_FromDocumentExternalHandle

function TevHyperlinkProxy.Get_TargetDocumentID: Integer;
//#UC START# *4A72ABEF02AE_4E1DD7720136get_var*
//#UC END# *4A72ABEF02AE_4E1DD7720136get_var*
begin
//#UC START# *4A72ABEF02AE_4E1DD7720136get_impl*
 Result := f_Link.TargetDocumentID;
//#UC END# *4A72ABEF02AE_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.Get_TargetDocumentID

function TevHyperlinkProxy.Get_Name: Tl3PCharLen;
//#UC START# *4A72B4140281_4E1DD7720136get_var*
//#UC END# *4A72B4140281_4E1DD7720136get_var*
begin
//#UC START# *4A72B4140281_4E1DD7720136get_impl*
 Result := f_Link.Name;
//#UC END# *4A72B4140281_4E1DD7720136get_impl*
end;//TevHyperlinkProxy.Get_Name

function TevHyperlinkProxy.GetHyperlink: Tl3Tag;
//#UC START# *5063FF170259_4E1DD7720136_var*
//#UC END# *5063FF170259_4E1DD7720136_var*
begin
//#UC START# *5063FF170259_4E1DD7720136_impl*
 Result := nil;
//#UC END# *5063FF170259_4E1DD7720136_impl*
end;//TevHyperlinkProxy.GetHyperlink

function TevHyperlinkProxy.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47A0AD3A01F7_4E1DD7720136_var*
//#UC END# *47A0AD3A01F7_4E1DD7720136_var*
begin
//#UC START# *47A0AD3A01F7_4E1DD7720136_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
  Result := f_Link.QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_4E1DD7720136_impl*
end;//TevHyperlinkProxy.QueryInterface

procedure TevHyperlinkProxy.ClearFields;
begin
 f_Link := nil;
 inherited;
end;//TevHyperlinkProxy.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
