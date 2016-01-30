unit eeSubPanelExport;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeSubPanelExport.pas"
// Стереотип: "GuiControl"

{$Include eeDefine.inc}

interface

uses
 l3IntfUses
 , evSubPanel
 , eeInterfaces
;

type
 TeeSubPanelExport = class(TevCustomSubPanel, IeeSubPanel)
  protected
   function GetHotSpot(aSubType: Integer;
    aSubHandle: Integer): IeeHotSpot;
   function Get_SubViewDescriptors: IeeSubViewDescriptors;
  public
   function CheckSubOnPoint(aX: Integer;
    aY: Integer;
    out theSub: IeeSub): Boolean;
 end;//TeeSubPanelExport

implementation

uses
 l3ImplUses
 , nevTools
 , eeInterfacesEx
 {$If Defined(Nemesis)}
 , eeSubDescriptorsExport
 {$IfEnd} // Defined(Nemesis)
 , SysUtils
 {$If Defined(Nemesis)}
 , eeSub
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , eeHotSpot
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TeeSubPanelExport.GetHotSpot(aSubType: Integer;
 aSubHandle: Integer): IeeHotSpot;
//#UC START# *5481C789009F_4C7F94A9028D_var*
var
 l_LayerID: Integer;
 l_Flag: Integer;
 l_Document: IeeDocumentEx;
//#UC END# *5481C789009F_4C7F94A9028D_var*
begin
//#UC START# *5481C789009F_4C7F94A9028D_impl*
 l_LayerID := aSubType;
 if (l_LayerID < 0) then
 begin
  l_LayerID := -l_LayerID;
  l_Flag := Succ(l_LayerID mod 10);
  l_LayerID := l_LayerID div 10;
 end else
  l_Flag := 0;
 if Supports(Control, IeeDocumentEx, l_Document) then
  try
   {$If Declared(TeeHotSpot)}
   Result := TeeHotSpot.Make(nil, l_Document, nil, False,
                             TeeSub.Make(l_Document, aSubHandle, l_LayerID, l_Flag));
   {$IfEnd}                          
  finally
   l_Document := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *5481C789009F_4C7F94A9028D_impl*
end;//TeeSubPanelExport.GetHotSpot

function TeeSubPanelExport.CheckSubOnPoint(aX: Integer;
 aY: Integer;
 out theSub: IeeSub): Boolean;
//#UC START# *5481D1B20067_4C7F94A9028D_var*
var
 l_Flag: Integer;
 l_Sub: IevSub;
 l_Document: IeeDocumentEx;
//#UC END# *5481D1B20067_4C7F94A9028D_var*
begin
//#UC START# *5481D1B20067_4C7F94A9028D_impl*
 Result := inherited CheckSubOnPoint(aX, aY, l_Sub, l_Flag);
 if Result then
 begin
  if Supports(Control, IeeDocumentEx, l_Document) then
  try
   {$If Declared(TeeSub)}
   theSub := TeeSub.Make(l_Document, l_Sub.ID, l_Sub.LayerID, l_Flag);
   {$IfEnd}
  finally
   l_Document := nil;
  end//try..finally
  else
   Result := False;
 end;//Result  
//#UC END# *5481D1B20067_4C7F94A9028D_impl*
end;//TeeSubPanelExport.CheckSubOnPoint

function TeeSubPanelExport.Get_SubViewDescriptors: IeeSubViewDescriptors;
//#UC START# *5481A0B20112_4C7F94A9028Dget_var*
//#UC END# *5481A0B20112_4C7F94A9028Dget_var*
begin
//#UC START# *5481A0B20112_4C7F94A9028Dget_impl*
 {$If Declared(TeeSubDescriptors)}
 Result := SubDescriptors as TeeSubDescriptors;
 {$Else}
 Result := nil;
 {$IfEnd}
//#UC END# *5481A0B20112_4C7F94A9028Dget_impl*
end;//TeeSubPanelExport.Get_SubViewDescriptors

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TeeSubPanelExport);
 {* Регистрация TeeSubPanelExport }
{$IfEnd} // NOT Defined(NoScripts)

end.
