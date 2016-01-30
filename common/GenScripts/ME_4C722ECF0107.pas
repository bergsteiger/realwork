unit f1AtomChecker;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\f1AtomChecker.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , F1TagDataProviderInterface
 , nsTagNodePrim
 , l3Variant
 , k2Base
;

type
 Tf1AtomChecker = class(Tl3CProtoObject, If1AtomChecker)
  private
   f_Tag: TnsTagNodePrim;
  protected
   function CheckAtom(aProp: Tk2CustomProperty): Tl3Tag;
   function MakeSubTag(const aProvider: If1TagDataProvider): Il3TagRef;
   function Get_Tag: Tl3Tag;
  public
   constructor Create(aTag: TnsTagNodePrim); reintroduce;
   class function Make(aTag: TnsTagNodePrim): If1AtomChecker; reintroduce;
 end;//Tf1AtomChecker

implementation

uses
 l3ImplUses
 , nsSubNode
;

constructor Tf1AtomChecker.Create(aTag: TnsTagNodePrim);
//#UC START# *4C722F6B0307_4C722ECF0107_var*
//#UC END# *4C722F6B0307_4C722ECF0107_var*
begin
//#UC START# *4C722F6B0307_4C722ECF0107_impl*
 inherited Create;
 f_Tag := aTag;
//#UC END# *4C722F6B0307_4C722ECF0107_impl*
end;//Tf1AtomChecker.Create

class function Tf1AtomChecker.Make(aTag: TnsTagNodePrim): If1AtomChecker;
var
 l_Inst : Tf1AtomChecker;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tf1AtomChecker.Make

function Tf1AtomChecker.CheckAtom(aProp: Tk2CustomProperty): Tl3Tag;
//#UC START# *4C722E2901C7_4C722ECF0107_var*
//#UC END# *4C722E2901C7_4C722ECF0107_var*
begin
//#UC START# *4C722E2901C7_4C722ECF0107_impl*
 Result := f_Tag.CheckAtom(aProp);
//#UC END# *4C722E2901C7_4C722ECF0107_impl*
end;//Tf1AtomChecker.CheckAtom

function Tf1AtomChecker.MakeSubTag(const aProvider: If1TagDataProvider): Il3TagRef;
//#UC START# *4C726EF902D9_4C722ECF0107_var*
//#UC END# *4C726EF902D9_4C722ECF0107_var*
begin
//#UC START# *4C726EF902D9_4C722ECF0107_impl*
 Result := TnsSubNode.MakeNodeTag(aProvider);
//#UC END# *4C726EF902D9_4C722ECF0107_impl*
end;//Tf1AtomChecker.MakeSubTag

function Tf1AtomChecker.Get_Tag: Tl3Tag;
//#UC START# *4CEBCD9B00D2_4C722ECF0107get_var*
//#UC END# *4CEBCD9B00D2_4C722ECF0107get_var*
begin
//#UC START# *4CEBCD9B00D2_4C722ECF0107get_impl*
 Result := f_Tag;
//#UC END# *4CEBCD9B00D2_4C722ECF0107get_impl*
end;//Tf1AtomChecker.Get_Tag

end.
