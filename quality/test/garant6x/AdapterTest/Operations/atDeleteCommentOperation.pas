unit atDeleteCommentOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atDeleteCommentOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDeleteCommentOperation" MUID: (4817437E02D8)

interface

uses
 l3IntfUses
 , atOperationBase
;

type
 TatDeleteCommentOperation = class(TatOperationBase)
  protected
   procedure ExecuteSelf; override;
   procedure InitParamList; override;
 end;//TatDeleteCommentOperation

implementation

uses
 l3ImplUses
 , atLogger
 , SysUtils
 , atDocumentHelper
 , DocumentUnit
 //#UC START# *4817437E02D8impl_uses*
 //#UC END# *4817437E02D8impl_uses*
;

procedure TatDeleteCommentOperation.ExecuteSelf;
//#UC START# *48089F460352_4817437E02D8_var*
  var
    l_Document : IDocument;
    l_CountToDel, l_CountDeleted : Integer;
    l_DTP : IDocumentTextProvider;
    l_DTPIter : TatDTPParaIterator;
//#UC END# *48089F460352_4817437E02D8_var*
begin
//#UC START# *48089F460352_4817437E02D8_impl*
  l_Document := ExecutionContext.UserWorkContext.CurrDoc;
  assert(l_Document <> nil, 'l_Document <> nil');
  Logger.Info('Удаляем комментарии из документа ' + IntToStr(l_Document.GetInternalId));
  //
  l_CountToDel := Parameters['count'].AsInt;
  //
  l_Document.GetTextProvider(false, l_DTP);
  l_CountDeleted := 0;
  l_DTPIter := TatDTPParaIterator.Create(l_DTP);
  l_DTPIter.IsParaMustHaveComments := true;
  try
    while ((l_CountToDel = -1) OR (l_CountDeleted < l_CountToDel)) AND l_DTPIter.HasNext do
    begin
      l_DTP.RemoveChildComment(l_DTPIter.GetNext);
      Inc(l_CountDeleted);
    end;
  finally
    FreeAndNil(l_DTPIter);
  end;
  Logger.Info('Удалено %d комментариев', [l_CountDeleted]);
//#UC END# *48089F460352_4817437E02D8_impl*
end;//TatDeleteCommentOperation.ExecuteSelf

procedure TatDeleteCommentOperation.InitParamList;
//#UC START# *48089F3701B4_4817437E02D8_var*
//#UC END# *48089F3701B4_4817437E02D8_var*
begin
//#UC START# *48089F3701B4_4817437E02D8_impl*
  inherited;
  with f_ParamList do
    Add( ParamType.Create('count', 'Количество удаляемых комментариев', '-1') );
//#UC END# *48089F3701B4_4817437E02D8_impl*
end;//TatDeleteCommentOperation.InitParamList

end.
