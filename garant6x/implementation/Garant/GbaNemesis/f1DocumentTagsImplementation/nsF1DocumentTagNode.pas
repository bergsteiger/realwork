unit nsF1DocumentTagNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsF1DocumentTagNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsF1DocumentTagNode" MUID: (4C6A750F024E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDocumentTagNodeBase
 , l3Variant
 , DocumentUnit
 , k2Base
;

type
 TnsF1DocumentTagNode = class(TnsDocumentTagNodeBase)
  protected
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
  public
   constructor Create(const aProvider: IDocumentTextProvider); reintroduce; overload;
   class function Make(const aProvider: IDocumentTextProvider): Il3TagRef; overload;
   constructor Create(aHandle: Cardinal;
    const aDoc: IDocument); reintroduce; overload;
   class function Make(aHandle: Cardinal;
    const aDoc: IDocument): Il3TagRef; overload;
 end;//TnsF1DocumentTagNode

implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
 , f1DocumentTagDataFromDTP
 , SysUtils
 , f1DocumentTagDataFromDTPHandle
;

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
