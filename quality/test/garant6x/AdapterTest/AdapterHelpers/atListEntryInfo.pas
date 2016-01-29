unit atListEntryInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atListEntryInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatListEntryInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  BaseTypesUnit,
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  l3_Base
  ;

type
 _EntityInterface_ = IListEntryInfo;
 {$Include ..\AdapterHelpers\atEntity.imp.pas}
 TatListEntryInfo = class(_atEntity_)
 protected
 // property methods
   function pm_GetDocument: IDocument; virtual;
   function pm_GetPID: TPId; virtual;
 public
 // public properties
   property Document: IDocument
     read pm_GetDocument;
   property PID: TPId
     read pm_GetPID;
 end;//TatListEntryInfo

implementation

uses
  SysUtils,
  IOUnit
  ;

{$Include ..\AdapterHelpers\atEntity.imp.pas}

// start class TatListEntryInfo

function TatListEntryInfo.pm_GetDocument: IDocument;
//#UC START# *5051EB280111_5051EA2101A5get_var*
//#UC END# *5051EB280111_5051EA2101A5get_var*
begin
//#UC START# *5051EB280111_5051EA2101A5get_impl*
  f_Entity.GetDoc(Result);
//#UC END# *5051EB280111_5051EA2101A5get_impl*
end;//TatListEntryInfo.pm_GetDocument

function TatListEntryInfo.pm_GetPID: TPId;
//#UC START# *5061FF260047_5051EA2101A5get_var*
//#UC END# *5061FF260047_5051EA2101A5get_var*
begin
//#UC START# *5061FF260047_5051EA2101A5get_impl*
  f_Entity.GetPid(Result);
//#UC END# *5061FF260047_5051EA2101A5get_impl*
end;//TatListEntryInfo.pm_GetPID

end.