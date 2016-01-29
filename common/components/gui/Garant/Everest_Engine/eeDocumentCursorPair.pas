unit eeDocumentCursorPair;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentCursorPair.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Cursors::TeeDocumentCursorPair
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  Classes
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursorPair
  {$IfEnd} //evUseVisibleCursors
  ,
  l3Interfaces,
  nevBase,
  nevTools
  ;

type
 TeeDocumentCursorPair = class(TevDocumentCursorPair)
 protected
 // overridden protected methods
   {$If defined(evUseVisibleCursors)}
   function DoInsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp;
    aFlags: TevLoadFlags;
    aCodePage: Integer): Boolean; override;
   {$IfEnd} //evUseVisibleCursors
 end;//TeeDocumentCursorPair

implementation

uses
  SysUtils
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  eeCursorTools,
  CommentPara_Const
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
  ;

// start class TeeDocumentCursorPair

{$If defined(evUseVisibleCursors)}
function TeeDocumentCursorPair.DoInsertStream(const aView: InevView;
  const aStream: IStream;
  aFormat: TnevFormat;
  const anOp: InevOp;
  aFlags: TevLoadFlags;
  aCodePage: Integer): Boolean;
//#UC START# *4A3A8BEE029F_54BE50DC0032_var*
var
 l_S : InevBasePoint;
 l_F : InevBasePoint;
//#UC END# *4A3A8BEE029F_54BE50DC0032_var*
begin
//#UC START# *4A3A8BEE029F_54BE50DC0032_impl*
 if evIsInReadOnlyPara(ParaX) then
 begin
  Result := false;
  Assert(false);
  Exit;
 end;//OR _IsInReadOnlyPara(ParaX)
 if (eeEditorByPara(ParaX) <> nil) then
 // - привязаны к специфическому редактору
 begin
  if evInPara(f_Start, k2_typCommentPara, l_S) then
  begin
   if evInPara(f_Finish, k2_typCommentPara, l_F) then
   begin
    if l_S.Obj.AsObject.IsSame(l_F.Obj^.AsObject) then
    begin
     Result := l_S.Obj.Range(l_S, l_F).Text.Modify.InsertStream(aView, aStream, aFormat, anOp, aFlags, aCodePage);
     //Result := GetChildSel(l_S.Position).Text.Modify.InsertStream(aStream, aFormat, anOp, aFlags, aCodePage);
     Exit;
    end;//l_S.Obj.IsSame(l_F.Obj)
   end;//evInPara(f_Finish, k2_idCommentPara, l_F)
  end;//evInPara(f_Start, k2_idCommentPara, l_S)
  Result := f_Finish.Text.Modify.InsertStream(aView, aStream, aFormat, anOp, aFlags, aCodePage);
  Exit;
 end;//_Editor(aView, ParaX) <> nil
 Result := inherited DoInsertStream(aView, aStream, aFormat, anOp, aFlags, aCodePage);
//#UC END# *4A3A8BEE029F_54BE50DC0032_impl*
end;//TeeDocumentCursorPair.DoInsertStream
{$IfEnd} //evUseVisibleCursors

end.