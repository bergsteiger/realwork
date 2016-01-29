unit nevActiveHyperlinkProxy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevActiveHyperlinkProxy.pas"
// Начат: 13.07.2011 16:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TnevActiveHyperlinkProxy
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
  l3CProtoObject,
  l3Interfaces
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 TnevActiveHyperlinkProxy = class(Tl3CProtoObject, InevActiveElement)
 protected
 // realized methods
   function IsSame(const anElement: InevActiveElement): Boolean;
   function Get_Para: InevPara;
   procedure Invalidate;
     {* Перерисовывает область активного элемента }
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
     {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 public
 // public fields
   f_Active : InevActiveElement;
 protected
 // protected methods
   function DoIsSame(const anElement: InevActiveElement): Boolean; virtual;
   procedure DoInvalidate; virtual;
 public
 // public methods
   constructor Create(const anActive: InevActiveElement); reintroduce;
   class function Make(const anActive: InevActiveElement): InevActiveElement; reintroduce;
     {* Сигнатура фабрики TnevActiveHyperlinkProxy.Make }
 end;//TnevActiveHyperlinkProxy
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  l3InterfacesMisc
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TnevActiveHyperlinkProxy

constructor TnevActiveHyperlinkProxy.Create(const anActive: InevActiveElement);
//#UC START# *4E1D95CA035F_4E1D95610271_var*
//#UC END# *4E1D95CA035F_4E1D95610271_var*
begin
//#UC START# *4E1D95CA035F_4E1D95610271_impl*
 Assert(anActive <> nil);
 inherited Create;
 f_Active := anActive;
//#UC END# *4E1D95CA035F_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.Create

class function TnevActiveHyperlinkProxy.Make(const anActive: InevActiveElement): InevActiveElement;
var
 l_Inst : TnevActiveHyperlinkProxy;
begin
 l_Inst := Create(anActive);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevActiveHyperlinkProxy.DoIsSame(const anElement: InevActiveElement): Boolean;
//#UC START# *4E1DB93401C4_4E1D95610271_var*
//#UC END# *4E1DB93401C4_4E1D95610271_var*
begin
//#UC START# *4E1DB93401C4_4E1D95610271_impl*
 Result := f_Active.IsSame(anElement);
//#UC END# *4E1DB93401C4_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.DoIsSame

procedure TnevActiveHyperlinkProxy.DoInvalidate;
//#UC START# *4FBF5D0203DC_4E1D95610271_var*
//#UC END# *4FBF5D0203DC_4E1D95610271_var*
begin
//#UC START# *4FBF5D0203DC_4E1D95610271_impl*
 f_Active.Para.Invalidate([]);
//#UC END# *4FBF5D0203DC_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.DoInvalidate

function TnevActiveHyperlinkProxy.IsSame(const anElement: InevActiveElement): Boolean;
//#UC START# *4A27C48E017F_4E1D95610271_var*
//#UC END# *4A27C48E017F_4E1D95610271_var*
begin
//#UC START# *4A27C48E017F_4E1D95610271_impl*
 Result := DoIsSame(anElement);
//#UC END# *4A27C48E017F_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.IsSame

function TnevActiveHyperlinkProxy.Get_Para: InevPara;
//#UC START# *4A27C5CD001C_4E1D95610271get_var*
//#UC END# *4A27C5CD001C_4E1D95610271get_var*
begin
//#UC START# *4A27C5CD001C_4E1D95610271get_impl*
 Result := f_Active.Para;
//#UC END# *4A27C5CD001C_4E1D95610271get_impl*
end;//TnevActiveHyperlinkProxy.Get_Para

procedure TnevActiveHyperlinkProxy.Invalidate;
//#UC START# *4FBF5595010C_4E1D95610271_var*
//#UC END# *4FBF5595010C_4E1D95610271_var*
begin
//#UC START# *4FBF5595010C_4E1D95610271_impl*
 DoInvalidate;
//#UC END# *4FBF5595010C_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.Invalidate

function TnevActiveHyperlinkProxy.QueryInterface(const IID: TGUID;
  out Obj): HResult;
//#UC START# *47A0AD3A01F7_4E1D95610271_var*
//#UC END# *47A0AD3A01F7_4E1D95610271_var*
begin
//#UC START# *47A0AD3A01F7_4E1D95610271_impl*
 Result := inherited QueryInterface(IID, Obj);
 if l3IFail(Result) then
  Result := f_Active.QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_4E1D95610271_impl*
end;//TnevActiveHyperlinkProxy.QueryInterface

procedure TnevActiveHyperlinkProxy.ClearFields;
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_Active := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TnevActiveHyperlinkProxy.ClearFields

{$IfEnd} //evNeedHotSpot

end.