{$IfNDef MnsDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/MnsDocument.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::CommonObjects::MnsDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define MnsDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _MnsDocument_ = {mixin} class(_MnsDocument_Parent_)
 private
 // private fields
   f_DocumentForReturn : TnsDocumentForReturnInfo;
 protected
 // realized methods
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Doc : IDocument;
    {* Документ}
 protected
 // protected methods
   procedure Init(const aDoc: IDocument;
     const aDocumentForReturn: TnsDocumentForReturnInfo);
 end;//_MnsDocument_
{$Else}

 _MnsDocument_ = _MnsDocument_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else MnsDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _MnsDocument_

procedure _MnsDocument_.Init(const aDoc: IDocument;
  const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4AE03D230118_4AE03C7F0002_var*
//#UC END# *4AE03D230118_4AE03C7F0002_var*
begin
//#UC START# *4AE03D230118_4AE03C7F0002_impl*
 f_Doc := aDoc;
 f_DocumentForReturn := aDocumentForReturn;
//#UC END# *4AE03D230118_4AE03C7F0002_impl*
end;//_MnsDocument_.Init

function _MnsDocument_.Get_Document: IDocument;
//#UC START# *4A8006FC02A1_4AE03C7F0002get_var*
//#UC END# *4A8006FC02A1_4AE03C7F0002get_var*
begin
//#UC START# *4A8006FC02A1_4AE03C7F0002get_impl*
 Result := f_Doc;
//#UC END# *4A8006FC02A1_4AE03C7F0002get_impl*
end;//_MnsDocument_.Get_Document

function _MnsDocument_.Get_DocumentForReturn: TnsDocumentForReturnInfo;
//#UC START# *4B5852A800F5_4AE03C7F0002get_var*
//#UC END# *4B5852A800F5_4AE03C7F0002get_var*
begin
//#UC START# *4B5852A800F5_4AE03C7F0002get_impl*
 Result := f_DocumentForReturn;
//#UC END# *4B5852A800F5_4AE03C7F0002get_impl*
end;//_MnsDocument_.Get_DocumentForReturn

procedure _MnsDocument_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Doc := nil;
 {$IfEnd} //not Admin AND not Monitorings
 Finalize(f_DocumentForReturn);
 inherited;
end;//_MnsDocument_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf MnsDocument_imp}
