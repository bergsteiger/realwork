unit nsLeafParaDecorationsHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsLeafParaDecorationsHolder.pas"
// Начат: 25.11.2010 18:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::TnsLeafParaDecorationsHolder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Variant,
  k2Prim,
  evNative_Schema
  ;

type
 TnsLeafParaDecorationsHolder = class(LeafParaDecorationsHolderTagClass)
 protected
 // overridden protected methods
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
   procedure CheckChildInsert(var anIndex: Integer;
     var aChild: Tl3Variant;
     const anOp: Ik2Op); override;
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: Il3TagRef;
 end;//TnsLeafParaDecorationsHolder

implementation

uses
  SysUtils,
  CommentPara_Const,
  F1TagDataProviderInterface,
  nsNativeCommentPara,
  k2Tags,
  LeafParaDecorationsHolder_Const
  ;

// start class TnsLeafParaDecorationsHolder

constructor TnsLeafParaDecorationsHolder.Create;
//#UC START# *4CEFDCD80253_4CEFD73403E4_var*
//#UC END# *4CEFDCD80253_4CEFD73403E4_var*
begin
//#UC START# *4CEFDCD80253_4CEFD73403E4_impl*
 inherited Create(k2_typLeafParaDecorationsHolder);
//#UC END# *4CEFDCD80253_4CEFD73403E4_impl*
end;//TnsLeafParaDecorationsHolder.Create

class function TnsLeafParaDecorationsHolder.Make: Il3TagRef;
//#UC START# *4CEFDCE9012B_4CEFD73403E4_var*
var
 l_Inst : TnsLeafParaDecorationsHolder;
//#UC END# *4CEFDCE9012B_4CEFD73403E4_var*
begin
//#UC START# *4CEFDCE9012B_4CEFD73403E4_impl*
 l_Inst := Create;
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4CEFDCE9012B_4CEFD73403E4_impl*
end;//TnsLeafParaDecorationsHolder.Make

function TnsLeafParaDecorationsHolder.DeleteChildPrim(anIndex: Integer;
  aChild: Tl3Variant;
  const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_4CEFD73403E4_var*
var
 l_Sink : If1CommentSink;
//#UC END# *4C6CE735026E_4CEFD73403E4_var*
begin
//#UC START# *4C6CE735026E_4CEFD73403E4_impl*
 Assert((aContext <> nil) OR
        not aChild.IsKindOf(k2_typCommentPara),
        'http://mdp.garant.ru/pages/viewpage.action?pageId=265391680 в TkwEditorDeleteUserComment.DoIt подавали nil и попадали в ветку else');
 if (aContext <> nil) AND aChild.IsKindOf(k2_typCommentPara) then
 begin
  if aChild.Box.QI(If1CommentSink, l_Sink) then
   try
    l_Sink.State := l_Sink.State - [ns_nsChanged];
    l_Sink.Store(nil);
    // - типа чтобы удалить комментарий из базы
    Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
    Assert(Result);
    // - комментарий из базы уже удалили, поэтому мы не можем не удалить его из текста 
   finally
    l_Sink := nil;
   end//try..finally
  else
   Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
 end//aContext <> nil
 else
  Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
//#UC END# *4C6CE735026E_4CEFD73403E4_impl*
end;//TnsLeafParaDecorationsHolder.DeleteChildPrim

procedure TnsLeafParaDecorationsHolder.CheckChildInsert(var anIndex: Integer;
  var aChild: Tl3Variant;
  const anOp: Ik2Op);
//#UC START# *4CED66B8005F_4CEFD73403E4_var*
var
 l_Obj : TObject;
 l_Tag : Tl3Tag;
//#UC END# *4CED66B8005F_4CEFD73403E4_var*
begin
//#UC START# *4CED66B8005F_4CEFD73403E4_impl*
 inherited;
 if aChild.IsValid AND aChild.IsKindOf(k2_typCommentPara) then
 begin
  l_Obj := aChild.AsObject;
  if not l_Obj.InheritsFrom(TnsNativeCommentPara) then
  begin
   l_Tag := TnsNativeCommentPara.Make(aChild).AsObject;
   Assert(anIndex > 0);
   l_Tag.IntA[k2_tiHandle] := Self.Child[anIndex - 1].IntA[k2_tiHandle];
   l_Tag.SetRef(aChild);
  end//not l_Obj.InheritsFrom(TnsNativeCommentPara)
  else
   aChild.MarkModified;
 end;//aChild.IsValid
//#UC END# *4CED66B8005F_4CEFD73403E4_impl*
end;//TnsLeafParaDecorationsHolder.CheckChildInsert

end.