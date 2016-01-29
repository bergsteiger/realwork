unit nsF1DocumentTagNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsF1DocumentTagNode.pas"
// Начат: 17.08.2010 15:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsF1DocumentTagNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DocumentUnit,
  nsDocumentTagNodeBase,
  l3Variant,
  k2Base
  ;

type
 TnsF1DocumentTagNode = class(TnsDocumentTagNodeBase)
 protected
 // overridden protected methods
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
 public
 // public methods
   constructor Create(const aProvider: IDocumentTextProvider); reintroduce; overload; 
   class function Make(const aProvider: IDocumentTextProvider): Il3TagRef; overload; 
   constructor Create(aHandle: Cardinal;
     const aDoc: IDocument); overload; 
   class function Make(aHandle: Cardinal;
     const aDoc: IDocument): Il3TagRef; overload; 
 end;//TnsF1DocumentTagNode

implementation

uses
  f1DocumentTagDataFromDTP,
  SysUtils,
  f1DocumentTagDataFromDTPHandle,
  evdTypes,
  k2Tags
  ;

// start class TnsF1DocumentTagNode

constructor TnsF1DocumentTagNode.Create(const aProvider: IDocumentTextProvider);
//#UC START# *4C7275540230_4C6A750F024E_var*
//#UC END# *4C7275540230_4C6A750F024E_var*
begin
//#UC START# *4C7275540230_4C6A750F024E_impl*
 CreatePrim(Tf1DocumentTagDataFromDTP.Make(aProvider));
//#UC END# *4C7275540230_4C6A750F024E_impl*
end;//TnsF1DocumentTagNode.Create

class function TnsF1DocumentTagNode.Make(const aProvider: IDocumentTextProvider): Il3TagRef;
//#UC START# *4C727576036D_4C6A750F024E_var*
var
 l_Inst : TnsF1DocumentTagNode;
//#UC END# *4C727576036D_4C6A750F024E_var*
begin
//#UC START# *4C727576036D_4C6A750F024E_impl*
 l_Inst := Create(aProvider);
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4C727576036D_4C6A750F024E_impl*
end;//TnsF1DocumentTagNode.Make

constructor TnsF1DocumentTagNode.Create(aHandle: Cardinal;
  const aDoc: IDocument);
//#UC START# *4D66AE430241_4C6A750F024E_var*
//#UC END# *4D66AE430241_4C6A750F024E_var*
begin
//#UC START# *4D66AE430241_4C6A750F024E_impl*
 CreatePrim(Tf1DocumentTagDataFromDTPHandle.Make(aHandle, aDoc));
//#UC END# *4D66AE430241_4C6A750F024E_impl*
end;//TnsF1DocumentTagNode.Create

class function TnsF1DocumentTagNode.Make(aHandle: Cardinal;
  const aDoc: IDocument): Il3TagRef;
//#UC START# *4D66AE6A01E2_4C6A750F024E_var*
var
 l_Inst : TnsF1DocumentTagNode;
//#UC END# *4D66AE6A01E2_4C6A750F024E_var*
begin
//#UC START# *4D66AE6A01E2_4C6A750F024E_impl*
 l_Inst := Create(aHandle, aDoc);
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4D66AE6A01E2_4C6A750F024E_impl*
end;//TnsF1DocumentTagNode.Make

function TnsF1DocumentTagNode.DoGetSubAtom(aProp: Tk2Prop;
  out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_4C6A750F024E_var*
//#UC END# *4C6D1D450332_4C6A750F024E_var*
begin
//#UC START# *4C6D1D450332_4C6A750F024E_impl*
 Case aProp.TagIndex of
  k2_tiInContents:
  begin
   ParseStyle;
   Data := aProp.MakeTag(Ord(ev_spOnlyOnSubPanel)).AsObject;
   Result := true;
  end;//k2_tiInContents
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_4C6A750F024E_impl*
end;//TnsF1DocumentTagNode.DoGetSubAtom

end.