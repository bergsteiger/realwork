unit eeHotSpot;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeHotSpot.pas"
// Стереотип: "SimpleClass"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , nevNavigation
 , l3Variant
 , eeInterfacesEx
 , l3IID
;

type
 TeeHotSpot = class(TeeTagEditorTool, IeeHotSpot)
  private
   f_Hyperlink: IevHyperlink;
   f_InSelection: Boolean;
   f_Sub: IeeSub;
  protected
   function Get_Para: IeePara;
   function Get_Hyperlink: IevHyperlink;
   function Get_InSelection: Boolean;
   function Get_Sub: IeeSub;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   constructor Create(aTagWrap: Tl3Variant;
    const aDocument: IeeDocumentEx;
    const aHyperlink: IevHyperlink;
    aInSelection: Boolean;
    const aSub: IeeSub = nil); reintroduce;
   class function Make(aTagWrap: Tl3Variant;
    const aDocument: IeeDocumentEx;
    const aHyperlink: IevHyperlink;
    aInSelection: Boolean;
    const aSub: IeeSub = nil): IeeHotSpot; reintroduce;
 end;//TeeHotSpot
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3String
 , eePara
 , SysUtils
;

constructor TeeHotSpot.Create(aTagWrap: Tl3Variant;
 const aDocument: IeeDocumentEx;
 const aHyperlink: IevHyperlink;
 aInSelection: Boolean;
 const aSub: IeeSub = nil);
//#UC START# *54872F04032C_5481DD0C0363_var*
//#UC END# *54872F04032C_5481DD0C0363_var*
begin
//#UC START# *54872F04032C_5481DD0C0363_impl*
 inherited Create(aTagWrap, aDocument, nil);
 f_Hyperlink := aHyperlink;
 f_InSelection := aInSelection;
 f_Sub := aSub;
//#UC END# *54872F04032C_5481DD0C0363_impl*
end;//TeeHotSpot.Create

class function TeeHotSpot.Make(aTagWrap: Tl3Variant;
 const aDocument: IeeDocumentEx;
 const aHyperlink: IevHyperlink;
 aInSelection: Boolean;
 const aSub: IeeSub = nil): IeeHotSpot;
var
 l_Inst : TeeHotSpot;
begin
 l_Inst := Create(aTagWrap, aDocument, aHyperlink, aInSelection, aSub);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TeeHotSpot.Make

function TeeHotSpot.Get_Para: IeePara;
//#UC START# *54819EA50228_5481DD0C0363get_var*
//#UC END# *54819EA50228_5481DD0C0363get_var*
begin
//#UC START# *54819EA50228_5481DD0C0363get_impl*
 QueryInterface(IeePara, Result);
//#UC END# *54819EA50228_5481DD0C0363get_impl*
end;//TeeHotSpot.Get_Para

function TeeHotSpot.Get_Hyperlink: IevHyperlink;
//#UC START# *54819EA90089_5481DD0C0363get_var*
//#UC END# *54819EA90089_5481DD0C0363get_var*
begin
//#UC START# *54819EA90089_5481DD0C0363get_impl*
 QueryInterface(IevHyperlink, Result);
//#UC END# *54819EA90089_5481DD0C0363get_impl*
end;//TeeHotSpot.Get_Hyperlink

function TeeHotSpot.Get_InSelection: Boolean;
//#UC START# *54819EB40253_5481DD0C0363get_var*
//#UC END# *54819EB40253_5481DD0C0363get_var*
begin
//#UC START# *54819EB40253_5481DD0C0363get_impl*
 Result := f_InSelection;
//#UC END# *54819EB40253_5481DD0C0363get_impl*
end;//TeeHotSpot.Get_InSelection

function TeeHotSpot.Get_Sub: IeeSub;
//#UC START# *54819EBD00AD_5481DD0C0363get_var*
//#UC END# *54819EBD00AD_5481DD0C0363get_var*
begin
//#UC START# *54819EBD00AD_5481DD0C0363get_impl*
 Result := f_Sub;
//#UC END# *54819EBD00AD_5481DD0C0363get_impl*
end;//TeeHotSpot.Get_Sub

procedure TeeHotSpot.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5481DD0C0363_var*
//#UC END# *479731C50290_5481DD0C0363_var*
begin
//#UC START# *479731C50290_5481DD0C0363_impl*
 f_Sub := nil;
 f_Hyperlink := nil;
 f_InSelection := False;
 inherited;
//#UC END# *479731C50290_5481DD0C0363_impl*
end;//TeeHotSpot.Cleanup

function TeeHotSpot.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_5481DD0C0363_var*
//#UC END# *4A60B23E00C3_5481DD0C0363_var*
begin
//#UC START# *4A60B23E00C3_5481DD0C0363_impl*
 if IID.EQ(IeePara) then
 begin
  if (Document = nil) then
   Result.SetNoInterface
  else 
  begin
   Result.SetOk;
   IeePara(Obj) := TeePara.Make(TagInst, Document);
  end;//Document = nil
 end 
 else 
 if IID.EQ(IevHyperlink) then
 begin
  if (f_Hyperlink = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   IevHyperlink(Obj) := f_Hyperlink;
  end;//f_Hyperlink = nil
 end 
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_5481DD0C0363_impl*
end;//TeeHotSpot.COMQueryInterface
{$IfEnd} // Defined(Nemesis)

end.
