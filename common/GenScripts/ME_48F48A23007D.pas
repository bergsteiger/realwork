unit evConstStringDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evConstStringDataObject.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evConstStringStorable
 , evdInterfaces
 , nevBase
 , l3Interfaces
 , evPersistentDataObjectEx
;

type
 _StorableClass_ = TevConstStringStorable;
 _DataType_ = IevdHyperlinkInfo;
 {$Include evDataObjectFromStorable.imp.pas}
 TevConstStringDataObject = class(_evDataObjectFromStorable_)
  protected
   function GetIsQuestionNeedBeforeFlush: Boolean; override;
   function DoStore(aFormat: TnevFormat;
    const aPool: IStream;
    const aFilters: InevTagGenerator;
    aFlags: TevdStoreFlags): Boolean; override;
 end;//TevConstStringDataObject

implementation

uses
 l3ImplUses
 , l3String
 , evTypes
 , evdTextToFirstParaAdder
 , evFormats
 , nevTools
 , l3Base
;

{$Include evDataObjectFromStorable.imp.pas}

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
