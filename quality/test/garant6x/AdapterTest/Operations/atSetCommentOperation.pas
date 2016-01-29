unit atSetCommentOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSetCommentOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSetCommentOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  atOperationBase
  ;

type
 TatSetCommentOperation = class(TatOperationBase)
 protected
 // realized methods
   procedure ExecuteSelf; override;
 protected
 // overridden protected methods
   procedure InitParamList; override;
 end;//TatSetCommentOperation

implementation

uses
  DocumentUnit,
  atDocumentHelper,
  atLogger,
  SysUtils,
  ActiveX,
  atUserComment
  ;

// start class TatSetCommentOperation

procedure TatSetCommentOperation.ExecuteSelf;
//#UC START# *48089F460352_483FF1480190_var*
  var
    l_CommentText : String;
    i, l_CommentsCount, l_ParasCount, l_CommentsInserted : Integer;
    l_Document : IDocument;
    l_ParaEPs : TEntryPointArr;
    l_DTP : IDocumentTextProvider;
    l_IsSetOnFirstNodes : Boolean;
    l_UserComment : IatUserComment;
    l_NewPos : Int64;
//#UC END# *48089F460352_483FF1480190_var*
begin
//#UC START# *48089F460352_483FF1480190_impl*
  l_CommentText := Parameters['comment_text'].AsStr;
  l_CommentsCount := Parameters['count'].AsInt;
  l_IsSetOnFirstNodes := Parameters['is_set_on_first_nodes'].AsBool;
  //
  l_Document := ExecutionContext.UserWorkContext.CurrDoc;
  Assert(l_Document <> nil, 'l_Document <> nil');
  Logger.Info('Вставляем комментарии в документ с номером ' + IntToStr(l_Document.GetInternalId));
  //
  l_Document.GetTextProvider(false, l_DTP);
  // поиск нод, на которые будем ставить комментарии
  l_ParaEPs := TatDocumentHelper.GetParaEPArray(l_DTP, l_CommentsCount, NOT l_IsSetOnFirstNodes);
  //
  if (l_ParaEPs <> nil) then
  begin
    // создаем комментарий
    l_UserComment := TatUserComment.Make;
    l_UserComment.CommentText := l_CommentText;
    // добавляем комментарий в документ
    l_CommentsInserted := 0;
    for i := 0 to High(l_ParaEPs) do
    begin
      (l_UserComment as IStream).Seek(0, 0, l_NewPos);
      l_DTP.SetChildComment(l_ParaEPs[i], l_UserComment as IStream);
      Inc(l_CommentsInserted);
    end;
    Logger.Info( 'Вставили ' + IntToStr(l_CommentsInserted) + ' комментариев из ' + IntToStr(l_CommentsCount) + '.');
  end
  else
    Logger.Error('Не удалось найти ни одной ноды, на которую можно было бы поставить комментарий!');
//#UC END# *48089F460352_483FF1480190_impl*
end;//TatSetCommentOperation.ExecuteSelf

procedure TatSetCommentOperation.InitParamList;
//#UC START# *48089F3701B4_483FF1480190_var*
//#UC END# *48089F3701B4_483FF1480190_var*
begin
//#UC START# *48089F3701B4_483FF1480190_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('count', 'Количество комментариев', '1') );
    Add( ParamType.Create('comment_text', 'Текст комментария', '') );
    Add( ParamType.Create('is_set_on_first_nodes', 'Ставить ли комментарии на первые попавшиеся ноды', 'true') );
  end;
//#UC END# *48089F3701B4_483FF1480190_impl*
end;//TatSetCommentOperation.InitParamList

end.