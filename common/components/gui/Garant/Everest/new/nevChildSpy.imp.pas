{$IfNDef nevChildSpy_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevChildSpy.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Rendering::nevChildSpy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevChildSpy_imp}
 _nevChildSpy_ = {mixin} class(_nevChildSpy_Parent_)
 public
 // public methods
   procedure ChildAdded(const aList: InevParaList;
    const aChild: InevPara); virtual; abstract;
   procedure ChildDeleted(const aList: InevParaList;
    const aChild: InevPara); virtual; abstract;
 end;//_nevChildSpy_

{$Else nevChildSpy_imp}


{$EndIf nevChildSpy_imp}
