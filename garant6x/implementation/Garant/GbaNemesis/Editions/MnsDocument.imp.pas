{$IfNDef MnsDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\MnsDocument.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "MnsDocument" MUID: (4AE03C7F0002)
// Имя типа: "_MnsDocument_"

{$Define MnsDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _MnsDocument_ = class(_MnsDocument_Parent_)
  private
   f_DocumentForReturn: TnsDocumentForReturnInfo;
  protected
   f_Doc: IDocument;
    {* Документ }
  protected
   procedure Init(const aDoc: IDocument;
    const aDocumentForReturn: TnsDocumentForReturnInfo);
   function Get_Document: IDocument;
   function Get_DocumentForReturn: TnsDocumentForReturnInfo;
   procedure ClearFields; override;
 end;//_MnsDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_MnsDocument_ = _MnsDocument_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else MnsDocument_imp}

{$IfNDef MnsDocument_imp_impl}

{$Define MnsDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
begin
 f_Doc := nil;
 Finalize(f_DocumentForReturn);
 inherited;
end;//_MnsDocument_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf MnsDocument_imp_impl}

{$EndIf MnsDocument_imp}

