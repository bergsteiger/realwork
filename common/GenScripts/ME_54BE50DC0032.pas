unit eeDocumentCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeDocumentCursorPair" MUID: (54BE50DC0032)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(evUseVisibleCursors)}
 , evDocumentCursorPair
 {$IfEnd} // Defined(evUseVisibleCursors)
 , nevTools
 , l3Interfaces
 , nevBase
;

type
 TeeDocumentCursorPair = class(TevDocumentCursorPair)
  protected
   {$If Defined(evUseVisibleCursors)}
   function DoInsertStream(const aView: InevView;
    const aStream: IStream;
    aFormat: TnevFormat;
    const anOp: InevOp;
    aFlags: TevLoadFlags;
    aCodePage: Integer): Boolean; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
 end;//TeeDocumentCursorPair

implementation

uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , eeCursorTools
 , CommentPara_Const
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
;

{$If Defined(evUseVisibleCursors)}
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
{$IfEnd} // Defined(evUseVisibleCursors)

end.
