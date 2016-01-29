unit eeHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeHotSpot.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Engine Core::TeeHotSpot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  eeInterfaces,
  eeInterfacesEx,
  nevNavigation,
  l3Variant,
  eeTagEditorTool,
  l3IID
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeHotSpot = class(TeeTagEditorTool, IeeHotSpot)
 private
 // private fields
   f_Hyperlink : IevHyperlink;
   f_InSelection : Boolean;
   f_Sub : IeeSub;
 protected
 // realized methods
   function Get_Para: IeePara;
   function Get_Hyperlink: IevHyperlink;
   function Get_InSelection: Boolean;
   function Get_Sub: IeeSub;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 public
 // public methods
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
     {* Сигнатура фабрики TeeHotSpot.Make }
 end;//TeeHotSpot
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3String,
  eePara,
  SysUtils
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TeeHotSpot

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
end;

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

{$IfEnd} //Nemesis

end.