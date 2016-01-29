unit nevDecorActiveHyperlink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevDecorActiveHyperlink.pas"
// Начат: 13.07.2011 16:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::HotSpots::TnevDecorActiveHyperlink
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
  nevBase,
  nevTools,
  nevActiveHyperlinkProxy
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}
type
 InevDecorActiveHyperlink = interface(IUnknown)
   ['{F090F594-9901-43C4-A1BF-64F448F2ECEA}']
   function Get_Obj: InevObjectPrim;
   property Obj: InevObjectPrim
     read Get_Obj;
 end;//InevDecorActiveHyperlink

 RnevDecorActiveHyperlinkClass = class of TnevDecorActiveHyperlink;

 TnevDecorActiveHyperlink = class(TnevActiveHyperlinkProxy, InevDecorActiveHyperlink)
 private
 // private fields
   f_Para : InevObjectPrim;
 protected
 // realized methods
   function Get_Obj: InevObjectPrim;
 protected
 // overridden protected methods
   function DoIsSame(const anElement: InevActiveElement): Boolean; override;
   procedure DoInvalidate; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aPara: InevObjectPrim;
     const anActive: InevActiveElement); reintroduce;
   class function Make(const aPara: InevObjectPrim;
     const anActive: InevActiveElement): InevActiveElement; reintroduce;
     {* Сигнатура фабрики TnevDecorActiveHyperlink.Make }
 end;//TnevDecorActiveHyperlink
{$IfEnd} //evNeedHotSpot

implementation

{$If defined(evNeedHotSpot)}
uses
  SysUtils
  ;
{$IfEnd} //evNeedHotSpot

{$If defined(evNeedHotSpot)}

// start class TnevDecorActiveHyperlink

constructor TnevDecorActiveHyperlink.Create(const aPara: InevObjectPrim;
  const anActive: InevActiveElement);
//#UC START# *4E1D97080355_4E1D96B8035A_var*
//#UC END# *4E1D97080355_4E1D96B8035A_var*
begin
//#UC START# *4E1D97080355_4E1D96B8035A_impl*
 Assert(aPara <> nil);
 inherited Create(anActive);
 f_Para := aPara;
//#UC END# *4E1D97080355_4E1D96B8035A_impl*
end;//TnevDecorActiveHyperlink.Create

class function TnevDecorActiveHyperlink.Make(const aPara: InevObjectPrim;
  const anActive: InevActiveElement): InevActiveElement;
var
 l_Inst : TnevDecorActiveHyperlink;
begin
 l_Inst := Create(aPara, anActive);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevDecorActiveHyperlink.Get_Obj: InevObjectPrim;
//#UC START# *4E1DB90E005B_4E1D96B8035Aget_var*
//#UC END# *4E1DB90E005B_4E1D96B8035Aget_var*
begin
//#UC START# *4E1DB90E005B_4E1D96B8035Aget_impl*
 Result := f_Para;
//#UC END# *4E1DB90E005B_4E1D96B8035Aget_impl*
end;//TnevDecorActiveHyperlink.Get_Obj

function TnevDecorActiveHyperlink.DoIsSame(const anElement: InevActiveElement): Boolean;
//#UC START# *4E1DB93401C4_4E1D96B8035A_var*
var
 l_DAH : InevDecorActiveHyperlink;
//#UC END# *4E1DB93401C4_4E1D96B8035A_var*
begin
//#UC START# *4E1DB93401C4_4E1D96B8035A_impl*
 Result := inherited DoIsSame(anElement);
 if Result then
  if Supports(anElement, InevDecorActiveHyperlink, l_DAH) then
   try
    Result := f_Para.AsObject.Box.IsSame(l_DAH.Obj.AsObject.Box);
   finally
    l_DAH := nil;
   end//try..finally
  else
   Result := false;
//#UC END# *4E1DB93401C4_4E1D96B8035A_impl*
end;//TnevDecorActiveHyperlink.DoIsSame

procedure TnevDecorActiveHyperlink.DoInvalidate;
//#UC START# *4FBF5D0203DC_4E1D96B8035A_var*
var
 l_P : InevPara;
//#UC END# *4FBF5D0203DC_4E1D96B8035A_var*
begin
//#UC START# *4FBF5D0203DC_4E1D96B8035A_impl*
 inherited;
 if f_Para.AsObject.QT(InevPara, l_P) then
  l_P.Invalidate([]);
//#UC END# *4FBF5D0203DC_4E1D96B8035A_impl*
end;//TnevDecorActiveHyperlink.DoInvalidate

procedure TnevDecorActiveHyperlink.ClearFields;
 {-}
begin
 {$If defined(evNeedHotSpot)}
 f_Para := nil;
 {$IfEnd} //evNeedHotSpot
 inherited;
end;//TnevDecorActiveHyperlink.ClearFields

{$IfEnd} //evNeedHotSpot

end.