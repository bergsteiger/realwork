unit atOpenSavedBookmarkOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atOpenSavedBookmarkOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatOpenSavedBookmarkOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DocumentUnit,
  atFoldersHelper,
  atOperationBase,
  FoldersUnit
  ;

type
 _FoldersNodeMatcher_ = TatBookmarkMatcher;
 _ObjectType_ = IBookmark;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}
 TatOpenSavedBookmarkOperation = class(_atOpenFoldersObjectAddon_)
 protected
 // realized methods
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
 protected
 // overridden protected methods
   procedure ExecuteChilds; override;
 end;//TatOpenSavedBookmarkOperation

implementation

uses
  atDocumentHelper,
  BaseTypesUnit,
  atLogger,
  SysUtils,
  atNodeHelper
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}

// start class TatOpenSavedBookmarkOperation

procedure TatOpenSavedBookmarkOperation.OnFoldersObject(const aFoldersObject: _ObjectType_);
//#UC START# *4FD0D2530143_4FD0D1B203CD_var*
  var
    l_DocReader : TatDocReader;
//#UC END# *4FD0D2530143_4FD0D1B203CD_var*
begin
//#UC START# *4FD0D2530143_4FD0D1B203CD_impl*
  inherited;
  //
  with TatBookmark.Create(aFoldersObject) do
  try
    Logger.Info('Читаем закладку с именем "%s" - она показывает на параграф № %d документа № %d',
      [Name, Para, Document.GetInternalId]);

    if f_IsEmulateOpening then
    begin
      try
        l_DocReader := TatDocReader.Create(Document);
      except
        on ECanNotFindData do
        begin
          Logger.Info('Не удается открыть документ %d, видимо, он отсутвует в базе', [Document.GetInternalId]);
          Exit;
        end;
      end;
      //
      try
        l_DocReader.ReadFromPara(Para);
      finally
        FreeAndNil(l_DocReader);
      end;
    end;

    inherited ExecuteChilds;  
  finally
    Free;
  end;
//#UC END# *4FD0D2530143_4FD0D1B203CD_impl*
end;//TatOpenSavedBookmarkOperation.OnFoldersObject

procedure TatOpenSavedBookmarkOperation.ExecuteChilds;
//#UC START# *48089F660238_4FD0D1B203CD_var*
//#UC END# *48089F660238_4FD0D1B203CD_var*
begin
//#UC START# *48089F660238_4FD0D1B203CD_impl*
  //
//#UC END# *48089F660238_4FD0D1B203CD_impl*
end;//TatOpenSavedBookmarkOperation.ExecuteChilds

end.