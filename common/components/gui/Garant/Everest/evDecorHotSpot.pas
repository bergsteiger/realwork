unit evDecorHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDecorHotSpot.pas"
// Начат: 13.07.2011 16:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TevDecorHotSpot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedHotSpot)}
uses
  nevTools,
  nevGUIInterfaces,
  evHotSpotProxy,
  nevDecorActiveHyperlink,
  evDecorHyperlink,
  afwInterfaces,
  l3Interfaces
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TevDecorHotSpot = class(TevHotSpotProxy)
 protected
 // overridden protected methods
   function DoTransMouseMove(const aView: InevControlView;
     const aKeys: TevMouseState;
     out theActiveElement: InevActiveElement): Boolean; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
     {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 protected
 // protected fields
   f_Para : InevPara;
 protected
 // protected methods
   function NeedProxyHyperlink: Boolean; virtual;
   function GetDecorHyperlinkClass: RevDecorHyperlink; virtual;
 public
 // public methods
   constructor Create(const aPara: InevPara;
     const aHotSpot: IevHotSpot); reintroduce;
   class function Make(const aPara: InevPara;
     const aHotSpot: IevHotSpot): IevHotSpot; reintroduce;
     {* Сигнатура фабрики TevDecorHotSpot.Make }
   function GetDecorActiveHyperlinkClass: RnevDecorActiveHyperlinkClass; virtual;
 end;//TevDecorHotSpot
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  l3InterfacesMisc,
  SysUtils,
  nevNavigation
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TevDecorHotSpot

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
end;

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
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_Para := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TevDecorHotSpot.ClearFields

{$IfEnd} //evNeedHotSpot

end.