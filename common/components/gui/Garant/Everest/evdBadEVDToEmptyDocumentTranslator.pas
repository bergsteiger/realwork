unit evdBadEVDToEmptyDocumentTranslator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evdBadEVDToEmptyDocumentTranslator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Generators::TevdBadEVDToEmptyDocumentTranslator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base,
  k2TagGen,
  l3Variant,
  k2TagTranslator
  ;

type
 TevdBadEVDToEmptyDocumentTranslator = class(Tk2TagTranslator)
 private
 // private fields
   f_WasDocumentOpened : Boolean;
   f_DocType : Tk2Type;
   f_DocLanguage : Integer;
 protected
 // overridden protected methods
   procedure StartChild(TypeID: Tl3Type); override;
   procedure OpenStream; override;
     {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
   procedure CloseStream(NeedUndo: Boolean); override;
     {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
 public
 // public methods
   constructor Create(aDocType: Tk2Type;
     aDocLanguage: Integer); reintroduce;
   class procedure SetTo(var theGenerator: Ik2TagGenerator;
     aDocType: Tk2Type;
     aDocLanguage: Integer); overload; 
   class procedure SetTo(var theGenerator: Tk2TagGenerator;
     aDocType: Tk2Type;
     aDocLanguage: Integer); overload; 
 end;//TevdBadEVDToEmptyDocumentTranslator

implementation

uses
  SysUtils,
  Para_Const,
  Document_Const,
  k2Tags
  ;

// start class TevdBadEVDToEmptyDocumentTranslator

constructor TevdBadEVDToEmptyDocumentTranslator.Create(aDocType: Tk2Type;
  aDocLanguage: Integer);
//#UC START# *53BD37FF01C1_53BC0D790357_var*
//#UC END# *53BD37FF01C1_53BC0D790357_var*
begin
//#UC START# *53BD37FF01C1_53BC0D790357_impl*
 inherited Create;
 f_DocType := aDocType;
 f_DocLanguage := aDocLanguage;
//#UC END# *53BD37FF01C1_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.Create

class procedure TevdBadEVDToEmptyDocumentTranslator.SetTo(var theGenerator: Ik2TagGenerator;
  aDocType: Tk2Type;
  aDocLanguage: Integer);
//#UC START# *53BD38250015_53BC0D790357_var*
var
 l_G : TevdBadEVDToEmptyDocumentTranslator;
//#UC END# *53BD38250015_53BC0D790357_var*
begin
//#UC START# *53BD38250015_53BC0D790357_impl*
 l_G := Create(aDocType, aDocLanguage);
 try
  l_G.Generator := theGenerator;
  theGenerator := l_G;
 finally
  FreeAndNil(l_G);
 end;//try..finally
//#UC END# *53BD38250015_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.SetTo

class procedure TevdBadEVDToEmptyDocumentTranslator.SetTo(var theGenerator: Tk2TagGenerator;
  aDocType: Tk2Type;
  aDocLanguage: Integer);
//#UC START# *53BE871800DF_53BC0D790357_var*
var
 l_G : TevdBadEVDToEmptyDocumentTranslator;
//#UC END# *53BE871800DF_53BC0D790357_var*
begin
//#UC START# *53BE871800DF_53BC0D790357_impl*
 l_G := Create(aDocType, aDocLanguage);
 try
  l_G.Generator := theGenerator;
  l_G.SetRefTo(theGenerator);
 finally
  FreeAndNil(l_G);
 end;//try..finally
//#UC END# *53BE871800DF_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.SetTo

procedure TevdBadEVDToEmptyDocumentTranslator.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_53BC0D790357_var*
//#UC END# *4836D4650177_53BC0D790357_var*
begin
//#UC START# *4836D4650177_53BC0D790357_impl*
 inherited;
 if TypeID.IsKindOf(k2_typDocument) then
  f_WasDocumentOpened := true;
//#UC END# *4836D4650177_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.StartChild

procedure TevdBadEVDToEmptyDocumentTranslator.OpenStream;
//#UC START# *4836D49800CA_53BC0D790357_var*
//#UC END# *4836D49800CA_53BC0D790357_var*
begin
//#UC START# *4836D49800CA_53BC0D790357_impl*
 inherited;
 f_WasDocumentOpened := false;
//#UC END# *4836D49800CA_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.OpenStream

procedure TevdBadEVDToEmptyDocumentTranslator.CloseStream(NeedUndo: Boolean);
//#UC START# *4836D4B003DC_53BC0D790357_var*
//#UC END# *4836D4B003DC_53BC0D790357_var*
begin
//#UC START# *4836D4B003DC_53BC0D790357_impl*
 if not f_WasDocumentOpened then
 begin
  if (Generator <> nil) then
  begin
   if (f_DocType = nil) then
    Generator.StartChild(k2_typDocument)
   else
    Generator.StartChild(f_DocType);
    Generator.AddIntegerAtom(k2_tiLanguage, f_DocLanguage);
    Generator.StartDefaultChild;
    Generator.Finish;
   Generator.Finish;
  end;//Generator <> nil
 end;//not f_WasDocumentOpened
 inherited;
//#UC END# *4836D4B003DC_53BC0D790357_impl*
end;//TevdBadEVDToEmptyDocumentTranslator.CloseStream

end.