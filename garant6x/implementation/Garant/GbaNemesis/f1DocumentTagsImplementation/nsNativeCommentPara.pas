unit nsNativeCommentPara;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "f1DocumentTagsImplementation"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsNativeCommentPara.pas"
// Начат: 24.11.2010 19:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::f1DocumentTagsImplementation::TagDataProviders::TnsNativeCommentPara
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  l3ProtoObject,
  F1TagDataProviderInterface,
  l3Variant,
  k2Base,
  l3IID,
  evNative_Schema
  ;

type
 _nsNativePara_Parent_ = CommentParaTagClass;
 {$Include ..\f1DocumentTagsImplementation\nsNativePara.imp.pas}
 _StyleParser_Parent_ = _nsNativePara_;
 {$Include ..\f1DocumentTagsImplementation\StyleParser.imp.pas}
 TnsNativeCommentPara = class(_StyleParser_)
 private
 // private fields
   f_State : TnsNodeStates;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 public
 // public methods
   class function MakeFromStyle(const aStyle: IStream;
     anOwner: Tl3Tag): Il3TagRef;
   constructor CreateFromStyle(const aStyle: IStream;
     anOwner: Tl3Tag);
 end;//TnsNativeCommentPara

implementation

uses
  SysUtils,
  nevTools,
  DocumentUnit
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  LeafParaDecorationsHolder_Const,
  CommentPara_Const,
  k2Facade,
  l3Base,
  evdVer,
  k2Empty_Const,
  nsStyleParser
  ;

type _Instance_R_ = TnsNativeCommentPara;

{$Include ..\f1DocumentTagsImplementation\nsNativePara.imp.pas}


{$Include ..\f1DocumentTagsImplementation\StyleParser.imp.pas}

type
  TnsNativeCommentParaSink = class(Tl3ProtoObject, If1CommentSink)
  private
  // private fields
   f_Comment : TnsNativeCommentPara;
  protected
  // realized methods
   function Get_State: TnsNodeStates;
   procedure Set_State(aValue: TnsNodeStates);
   procedure Store(const aStream: IEVDStream);
  public
  // public methods
   constructor Create(aComment: TnsNativeCommentPara); reintroduce;
   class function Make(aComment: TnsNativeCommentPara): If1CommentSink; reintroduce;
     {* Сигнатура фабрики TnsNativeCommentParaSink.Make }
  end;//TnsNativeCommentParaSink

// start class TnsNativeCommentParaSink

constructor TnsNativeCommentParaSink.Create(aComment: TnsNativeCommentPara);
//#UC START# *4CEE3A6702A7_4CEE3A2502C0_var*
//#UC END# *4CEE3A6702A7_4CEE3A2502C0_var*
begin
//#UC START# *4CEE3A6702A7_4CEE3A2502C0_impl*
 inherited Create;
 f_Comment := aComment;
//#UC END# *4CEE3A6702A7_4CEE3A2502C0_impl*
end;//TnsNativeCommentParaSink.Create

class function TnsNativeCommentParaSink.Make(aComment: TnsNativeCommentPara): If1CommentSink;
var
 l_Inst : TnsNativeCommentParaSink;
begin
 l_Inst := Create(aComment);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsNativeCommentParaSink.Get_State: TnsNodeStates;
//#UC START# *4CEE38DA0365_4CEE3A2502C0get_var*
//#UC END# *4CEE38DA0365_4CEE3A2502C0get_var*
begin
//#UC START# *4CEE38DA0365_4CEE3A2502C0get_impl*
 Result := f_Comment.f_State;
//#UC END# *4CEE38DA0365_4CEE3A2502C0get_impl*
end;//TnsNativeCommentParaSink.Get_State

procedure TnsNativeCommentParaSink.Set_State(aValue: TnsNodeStates);
//#UC START# *4CEE38DA0365_4CEE3A2502C0set_var*
//#UC END# *4CEE38DA0365_4CEE3A2502C0set_var*
begin
//#UC START# *4CEE38DA0365_4CEE3A2502C0set_impl*
 f_Comment.f_State := aValue;
//#UC END# *4CEE38DA0365_4CEE3A2502C0set_impl*
end;//TnsNativeCommentParaSink.Set_State

procedure TnsNativeCommentParaSink.Store(const aStream: IEVDStream);
//#UC START# *4CEE3904013D_4CEE3A2502C0_var*
var
 l_Para  : InevPara;
 l_Prev  : InevPara;
 l_Owner : InevPara;
 l_Prov  : If1TagDataProvider;
 //l_Cont  : InevDocumentContainer;
 //l_Op    : InevOp;
//#UC END# *4CEE3904013D_4CEE3A2502C0_var*
begin
//#UC START# *4CEE3904013D_4CEE3A2502C0_impl*
 if not f_Comment.QT(InevPara, l_Para) then
  Assert(false);
 if not f_Comment.Owner.QT(InevPara, l_Owner) then
  Assert(false);
 l_Prev := l_Para.Prev;
 if (l_Prev = nil) OR not l_Prev.AsObject.IsValid then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=265391680
 // - наверное тут уже всё удаляют в результате Undo
 // !!! а может быть тут дело в том, что в Undo запись кладётся НЕ ТОТ ребёнок
 // не учитывается ИСКРИВЛЕНИЕ ПРОСТРАНСТВА с k2_typLeafParaDecorationsHolder
 begin
  Assert(l_Owner.AsObject.IsKindOf(k2_typLeafParaDecorationsHolder));
  Assert(l_Owner.PID < 0);
  // - типа контейнер уже удалён
  Exit;
(*  l_Prev := evPrevOverallPara(l_Para);
  Assert((l_Prev <> nil) AND l_Prev.IsValid);
  if not Supports(l_Prev.Box, If1TagDataProvider, l_Prov) then
   Assert(false);
  Assert(l_Para.PID = 0);
  l_Cont := l_Owner.DocumentContainer;
  Assert(l_Cont <> nil);
  l_Op := l_Cont.Processor.StartOp;
  try
   Assert(l_Op.InUndo);
   l_Op.CheckOff;
   try
    l_Owner.Edit.Delete(false, l_Op);
   finally
    l_Op.CheckOn;
   end;//try..finally
  finally
   l_Op := nil;
  end;//try..finally
  l_Prov.wStyle := nil;
  Exit;*)
 end//l_Para = nil
 else
  begin
   Assert((l_Prev <> nil) AND l_Prev.AsObject.IsValid);
   if l_Prev.AsObject.IsKindOf(k2_typCommentPara) then Exit;   
   if not l_Prev.AsObject.Box.QI(If1TagDataProvider, l_Prov) then
    Assert(false);
   l_Prov.wStyle := aStream;
  end;//l_Para = nil
//#UC END# *4CEE3904013D_4CEE3A2502C0_impl*
end;//TnsNativeCommentParaSink.Store

class function TnsNativeCommentPara.MakeFromStyle(const aStyle: IStream;
  anOwner: Tl3Tag): Il3TagRef;
//#UC START# *4CEFB6910213_4CED3DF702F9_var*
var
 l_Inst : TnsNativeCommentPara;
//#UC END# *4CEFB6910213_4CED3DF702F9_var*
begin
//#UC START# *4CEFB6910213_4CED3DF702F9_impl*
 l_Inst := CreateFromStyle(aStyle, anOwner);
 try
  Result := l_Inst.AsRef;
 finally
  l_Inst.Free;
 end;//try..finally
//#UC END# *4CEFB6910213_4CED3DF702F9_impl*
end;//TnsNativeCommentPara.MakeFromStyle

constructor TnsNativeCommentPara.CreateFromStyle(const aStyle: IStream;
  anOwner: Tl3Tag);
//#UC START# *4CEFB6B202FF_4CED3DF702F9_var*
//#UC END# *4CEFB6B202FF_4CED3DF702F9_var*
begin
//#UC START# *4CEFB6B202FF_4CED3DF702F9_impl*
 Create(k2_typCommentPara);
 Include(f_State, ns_nsNotNeedSynchronizeWithTree);
 Exclude(f_State, ns_nsChanged);
 pm_SetTagOwner(anOwner);
 DoDoParseStyle(aStyle);
 Include(f_State, ns_nsStyleParsed);
//#UC END# *4CEFB6B202FF_4CED3DF702F9_impl*
end;//TnsNativeCommentPara.CreateFromStyle

procedure TnsNativeCommentPara.Cleanup;
//#UC START# *479731C50290_4CED3DF702F9_var*
//#UC END# *479731C50290_4CED3DF702F9_var*
begin
//#UC START# *479731C50290_4CED3DF702F9_impl*
 f_State := [];
 inherited;
//#UC END# *479731C50290_4CED3DF702F9_impl*
end;//TnsNativeCommentPara.Cleanup

procedure TnsNativeCommentPara.InitFields;
//#UC START# *47A042E100E2_4CED3DF702F9_var*
//#UC END# *47A042E100E2_4CED3DF702F9_var*
begin
//#UC START# *47A042E100E2_4CED3DF702F9_impl*
 inherited;
 Include(f_State, ns_nsNotNeedSynchronizeWithTree);
//#UC END# *47A042E100E2_4CED3DF702F9_impl*
end;//TnsNativeCommentPara.InitFields

function TnsNativeCommentPara.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4CED3DF702F9_var*
//#UC END# *4A60B23E00C3_4CED3DF702F9_var*
begin
//#UC START# *4A60B23E00C3_4CED3DF702F9_impl*
 if IID.EQ(If1CommentSink) then
 begin
  If1CommentSink(Obj) := TnsNativeCommentParaSink.Make(Self);
  Result.SetOk;
 end//IID.EQ(If1CommentSink)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4CED3DF702F9_impl*
end;//TnsNativeCommentPara.COMQueryInterface

end.