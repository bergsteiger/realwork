unit nevDecorActiveHyperlink;

// Модуль: "w:\common\components\gui\Garant\Everest\nevDecorActiveHyperlink.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedHotSpot)}
uses
 l3IntfUses
 , nevActiveHyperlinkProxy
 , nevBase
 , nevTools
;

type
 InevDecorActiveHyperlink = interface
  ['{F090F594-9901-43C4-A1BF-64F448F2ECEA}']
  function Get_Obj: InevObjectPrim;
  property Obj: InevObjectPrim
   read Get_Obj;
 end;//InevDecorActiveHyperlink

 RnevDecorActiveHyperlinkClass = class of TnevDecorActiveHyperlink;

 TnevDecorActiveHyperlink = class(TnevActiveHyperlinkProxy, InevDecorActiveHyperlink)
  private
   f_Para: InevObjectPrim;
  protected
   function Get_Obj: InevObjectPrim;
   function DoIsSame(const anElement: InevActiveElement): Boolean; override;
   procedure DoInvalidate; override;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: InevObjectPrim;
    const anActive: InevActiveElement); reintroduce;
   class function Make(const aPara: InevObjectPrim;
    const anActive: InevActiveElement): InevActiveElement; reintroduce;
 end;//TnevDecorActiveHyperlink
{$IfEnd} // Defined(evNeedHotSpot)

implementation

{$If Defined(evNeedHotSpot)}
uses
 l3ImplUses
 , SysUtils
;

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
end;//TnevDecorActiveHyperlink.Make

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
begin
 f_Para := nil;
 inherited;
end;//TnevDecorActiveHyperlink.ClearFields
{$IfEnd} // Defined(evNeedHotSpot)

end.
