unit evDecorHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest\evDecorHotSpot.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDecorHotSpot" MUID: (4E1D961D02D6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , evHotSpotProxy
 , nevTools
 , nevGUIInterfaces
 , evDecorHyperlink
 , nevDecorActiveHyperlink
 , l3Interfaces
;

type
 TevDecorHotSpot = class(TevHotSpotProxy)
  protected
   f_Para: InevPara;
  protected
   function NeedProxyHyperlink: Boolean; virtual;
   function GetDecorHyperlinkClass: RevDecorHyperlink; virtual;
   function DoTransMouseMove(const aView: InevControlView;
    const aKeys: TevMouseState;
    out theActiveElement: InevActiveElement): Boolean; override;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: InevPara;
    const aHotSpot: IevHotSpot); reintroduce;
   class function Make(const aPara: InevPara;
    const aHotSpot: IevHotSpot): IevHotSpot; reintroduce;
   function GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass; virtual;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//TevDecorHotSpot
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , nevNavigation
;

constructor TevDecorHotSpot.Create(const aPara: InevPara;
 const aHotSpot: IevHotSpot);
//#UC START# *4E1D79FC01E9_4E1D961D02D6_var*
//#UC END# *4E1D79FC01E9_4E1D961D02D6_var*
begin
//#UC START# *4E1D79FC01E9_4E1D961D02D6_impl*
 Assert(aPara <> nil);
 inherited Create(aHotSpot);
 f_Para := aPara;
//#UC END# *4E1D79FC01E9_4E1D961D02D6_impl*
end;//TevDecorHotSpot.Create

class function TevDecorHotSpot.Make(const aPara: InevPara;
 const aHotSpot: IevHotSpot): IevHotSpot;
var
 l_Inst : TevDecorHotSpot;
begin
 l_Inst := Create(aPara, aHotSpot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevDecorHotSpot.Make

function TevDecorHotSpot.NeedProxyHyperlink: Boolean;
//#UC START# *552FAB2002BB_4E1D961D02D6_var*
//#UC END# *552FAB2002BB_4E1D961D02D6_var*
begin
//#UC START# *552FAB2002BB_4E1D961D02D6_impl*
 Result := True;
//#UC END# *552FAB2002BB_4E1D961D02D6_impl*
end;//TevDecorHotSpot.NeedProxyHyperlink

function TevDecorHotSpot.GetDecorHyperlinkClass: RevDecorHyperlink;
//#UC START# *55F6D02B0013_4E1D961D02D6_var*
//#UC END# *55F6D02B0013_4E1D961D02D6_var*
begin
//#UC START# *55F6D02B0013_4E1D961D02D6_impl*
 Result := TevDecorHyperlink;
//#UC END# *55F6D02B0013_4E1D961D02D6_impl*
end;//TevDecorHotSpot.GetDecorHyperlinkClass

function TevDecorHotSpot.GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass;
//#UC START# *55F7C7110022_4E1D961D02D6_var*
//#UC END# *55F7C7110022_4E1D961D02D6_var*
begin
//#UC START# *55F7C7110022_4E1D961D02D6_impl*
 Result := TnevDecorActiveHyperlink;
//#UC END# *55F7C7110022_4E1D961D02D6_impl*
end;//TevDecorHotSpot.GetDecorActiveHyperlinkClass

function TevDecorHotSpot.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
//#UC START# *47A0AD3A01F7_4E1D961D02D6_var*
//#UC END# *47A0AD3A01F7_4E1D961D02D6_var*
begin
//#UC START# *47A0AD3A01F7_4E1D961D02D6_impl*
 Result := inherited QueryInterface(IID, Obj);
 if NeedProxyHyperlink then
  if l3IOk(Result) AND SysUtils.IsEqualGUID(IID, IevHyperlink) then
   IevHyperlink(Obj) := GetDecorHyperlinkClass.Make(f_Para, IevHyperlink(Obj));
//#UC END# *47A0AD3A01F7_4E1D961D02D6_impl*
end;//TevDecorHotSpot.QueryInterface

function TevDecorHotSpot.DoTransMouseMove(const aView: InevControlView;
 const aKeys: TevMouseState;
 out theActiveElement: InevActiveElement): Boolean;
//#UC START# *4E1D94EF002C_4E1D961D02D6_var*
//#UC END# *4E1D94EF002C_4E1D961D02D6_var*
begin
//#UC START# *4E1D94EF002C_4E1D961D02D6_impl*
 Result := inherited DoTransMouseMove(aView, aKeys, theActiveElement);
 if NeedProxyHyperlink then
  if Result then
  begin
   if (theActiveElement = nil) then
    Result := false
   else
    theActiveElement := GetDecorActiveHyperlinkClass.Make(f_Para, theActiveElement);
  end;//Result
//#UC END# *4E1D94EF002C_4E1D961D02D6_impl*
end;//TevDecorHotSpot.DoTransMouseMove

procedure TevDecorHotSpot.ClearFields;
begin
 f_Para := nil;
 inherited;
end;//TevDecorHotSpot.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
