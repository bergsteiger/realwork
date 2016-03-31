unit atSaveFoldersQueryToXMLOperation;

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atSaveFoldersQueryToXMLOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSaveFoldersQueryToXMLOperation" MUID: (5006FF3D006C)

interface

uses
 l3IntfUses
 , atFoldersHelper
 , SearchUnit
 , atOperationBase
 , FoldersUnit
 , atQuery
;

type
 _FoldersNodeMatcher_ = TatQueryMatcher;
 _ObjectType_ = IQuery;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}
 _atOpenFoldersObjectAddon_Parent_ = _atProcessNamedFoldersObjectOperation_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atOpenFoldersObjectAddon.imp.pas}
 _atSaveQueryToXMLAddon_Parent_ = _atOpenFoldersObjectAddon_;
 {$Include w:\quality\test\garant6x\AdapterTest\Operations\atSaveQueryToXMLAddon.imp.pas}
 TatSaveFoldersQueryToXMLOperation = class(_atSaveQueryToXMLAddon_)
  protected
   procedure OnFoldersObject(const aFoldersObject: _ObjectType_); override;
 end;//TatSaveFoldersQueryToXMLOperation

implementation

uses
 l3ImplUses
 , atLogger
 , SysUtils
 , BaseTypesUnit
 , atNodeHelper
 , atCommon
 , XMLIntf
 , atQueryTypeConverter
 , Windows
;

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atProcessNamedFoldersObjectOperation.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atOpenFoldersObjectAddon.imp.pas}

{$Include w:\quality\test\garant6x\AdapterTest\Operations\atSaveQueryToXMLAddon.imp.pas}

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
