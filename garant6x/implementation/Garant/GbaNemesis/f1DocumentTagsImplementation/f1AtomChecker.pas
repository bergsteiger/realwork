unit f1AtomChecker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/f1AtomChecker.pas"
// Начат: 23.08.2010 12:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::Tf1AtomChecker
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsTagNodePrim,
  l3CProtoObject,
  F1TagDataProviderInterface,
  k2Base,
  l3Variant
  ;

type
 Tf1AtomChecker = class(Tl3CProtoObject, If1AtomChecker)
 private
 // private fields
   f_Tag : TnsTagNodePrim;
 protected
 // realized methods
   function CheckAtom(aProp: Tk2CustomProperty): Tl3Tag;
   function MakeSubTag(const aProvider: If1TagDataProvider): Il3TagRef;
   function Get_Tag: Tl3Tag;
 public
 // public methods
   constructor Create(aTag: TnsTagNodePrim); reintroduce;
   class function Make(aTag: TnsTagNodePrim): If1AtomChecker; reintroduce;
     {* Сигнатура фабрики Tf1AtomChecker.Make }
 end;//Tf1AtomChecker

implementation

uses
  nsSubNode
  ;

// start class Tf1AtomChecker

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
end;

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