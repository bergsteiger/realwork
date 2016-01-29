unit atSaveFoldersQueryToXMLOperation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/Operations/atSaveFoldersQueryToXMLOperation.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::Operations::TatSaveFoldersQueryToXMLOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SearchUnit,
  atFoldersHelper,
  atOperationBase,
  FoldersUnit,
  atQuery
  ;

type
 _FoldersNodeMatcher_ = TatQueryMatcher;
 _ObjectType_ = IQuery;
 {$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}
 _atSaveQueryToXMLAddon_Parent_ = _atOpenFoldersObjectAddon_;
 {$Include ..\Operations\atSaveQueryToXMLAddon.imp.pas}
 TatSaveFoldersQueryToXMLOperation = class(_atSaveQueryToXMLAddon_)
 protected
 // realized methods
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
 end;//TatSaveFoldersQueryToXMLOperation

implementation

uses
  atLogger,
  SysUtils,
  BaseTypesUnit,
  atNodeHelper,
  atCommon,
  XMLIntf,
  atQueryTypeConverter,
  Windows
  ;

{$Include ..\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include ..\Operations\atOpenFoldersObjectAddon.imp.pas}

{$Include ..\Operations\atSaveQueryToXMLAddon.imp.pas}

// start class TatSaveFoldersQueryToXMLOperation

procedure TatSaveFoldersQueryToXMLOperation.OnFoldersObject(const aFoldersObject: _ObjectType_);
//#UC START# *4FD0D2530143_5006FF3D006C_var*
  var
    l_Query : TatQuery;
//#UC END# *4FD0D2530143_5006FF3D006C_var*
begin
//#UC START# *4FD0D2530143_5006FF3D006C_impl*
  l_Query := TatQuery.Create(aFoldersObject);
  try
    SaveQuery(l_Query);
  finally
    FreeAndNil(l_Query);
  end;
//#UC END# *4FD0D2530143_5006FF3D006C_impl*
end;//TatSaveFoldersQueryToXMLOperation.OnFoldersObject

end.