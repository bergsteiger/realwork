unit evConstStringDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Лукьянец Р.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evConstStringDataObject.pas"
// Начат: 16.07.2007
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevConstStringDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evConstStringStorable,
  evdInterfaces,
  l3Interfaces,
  evPersistentDataObjectEx,
  ActiveX,
  Windows,
  nevBase
  ;

type
 _StorableClass_ = TevConstStringStorable;
 _DataType_ = IevdHyperlinkInfo;
 {$Include ..\Everest\evDataObjectFromStorable.imp.pas}
 TevConstStringDataObject = class(_evDataObjectFromStorable_)
 protected
 // overridden protected methods
   function GetIsQuestionNeedBeforeFlush: Boolean; override;
   function DoStore(aFormat: TnevFormat;
    const aPool: IStream;
    const aFilters: InevTagGenerator;
    aFlags: TevdStoreFlags): Boolean; override;
 end;//TevConstStringDataObject

implementation

uses
  l3String,
  evTypes,
  evdTextToFirstParaAdder,
  evFormats,
  nevTools,
  l3Base
  ;

{$Include ..\Everest\evDataObjectFromStorable.imp.pas}

// start class TevConstStringDataObject

function TevConstStringDataObject.GetIsQuestionNeedBeforeFlush: Boolean;
//#UC START# *48F4818300A5_48F48A23007D_var*
//#UC END# *48F4818300A5_48F48A23007D_var*
begin
//#UC START# *48F4818300A5_48F48A23007D_impl*
 Result := inherited GetIsQuestionNeedBeforeFlush;
//#UC END# *48F4818300A5_48F48A23007D_impl*
end;//TevConstStringDataObject.GetIsQuestionNeedBeforeFlush

function TevConstStringDataObject.DoStore(aFormat: TnevFormat;
  const aPool: IStream;
  const aFilters: InevTagGenerator;
  aFlags: TevdStoreFlags): Boolean;
//#UC START# *48F481B6035B_48F48A23007D_var*
var
 l_Filter : InevTagGenerator;
 l_AppInfo : Il3CString;
//#UC END# *48F481B6035B_48F48A23007D_var*
begin
//#UC START# *48F481B6035B_48F48A23007D_impl*
 l_Filter := aFilters;
 if (aFormat = CF_RTF) then
 begin
  l_AppInfo := Data.AppInfo;
  if not l3IsNil(l_AppInfo) then
   TevdTextToFirstParaAdder.SetTo(l_Filter, l_AppInfo);
 end;//aFormat = CF_RTF
 try
  Result := inherited DoStore(aFormat, aPool, l_Filter, aFlags);
 finally
  l_Filter := nil;
 end;//try..finally
//#UC END# *48F481B6035B_48F48A23007D_impl*
end;//TevConstStringDataObject.DoStore

end.