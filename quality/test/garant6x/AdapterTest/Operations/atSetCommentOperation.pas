unit atSetCommentOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/Operations/atSetCommentOperation.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSetCommentOperation
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
  Logger.Info('��������� ����������� � �������� � ������� ' + IntToStr(l_Document.GetInternalId));
  //
  l_Document.GetTextProvider(false, l_DTP);
  // ����� ���, �� ������� ����� ������� �����������
  l_ParaEPs := TatDocumentHelper.GetParaEPArray(l_DTP, l_CommentsCount, NOT l_IsSetOnFirstNodes);
  //
  if (l_ParaEPs <> nil) then
  begin
    // ������� �����������
    l_UserComment := TatUserComment.Make;
    l_UserComment.CommentText := l_CommentText;
    // ��������� ����������� � ��������
    l_CommentsInserted := 0;
    for i := 0 to High(l_ParaEPs) do
    begin
      (l_UserComment as IStream).Seek(0, 0, l_NewPos);
      l_DTP.SetChildComment(l_ParaEPs[i], l_UserComment as IStream);
      Inc(l_CommentsInserted);
    end;
    Logger.Info( '�������� ' + IntToStr(l_CommentsInserted) + ' ������������ �� ' + IntToStr(l_CommentsCount) + '.');
  end
  else
    Logger.Error('�� ������� ����� �� ����� ����, �� ������� ����� ���� �� ��������� �����������!');
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
    Add( ParamType.Create('count', '���������� ������������', '1') );
    Add( ParamType.Create('comment_text', '����� �����������', '') );
    Add( ParamType.Create('is_set_on_first_nodes', '������� �� ����������� �� ������ ���������� ����', 'true') );
  end;
//#UC END# *48089F3701B4_483FF1480190_impl*
end;//TatSetCommentOperation.InitParamList

end.