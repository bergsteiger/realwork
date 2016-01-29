unit nsDocumentToolsNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsDocumentToolsNew.pas"
// Начат: 11.10.2010 15:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::nsDocumentToolsNew
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  nevTools,
  nevObjectHolder,
  l3Variant
  ;

procedure NsGetText(const aDocument: IDocument;
  out theStream: InevObjectHolder);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsF1DocumentTagNode,
  SysUtils
  ;

// unit methods

procedure NsGetText(const aDocument: IDocument;
  out theStream: InevObjectHolder);
//#UC START# *4D3EC093030F_4CB2EE9F02FE_var*
//#UC END# *4D3EC093030F_4CB2EE9F02FE_var*
var
 l_Tag : Tl3Tag;
 l_Obj : InevObject;
 l_Holder : TnevObjectHolder;
 l_Provider : IDocumentTextProvider;
begin
//#UC START# *4D3EC093030F_4CB2EE9F02FE_impl*
 if (aDocument <> nil) then
 begin
  aDocument.GetTextProvider(true, l_Provider);
  try
   Assert(l_Provider <> nil);
   l_Tag := TnsF1DocumentTagNode.Make(l_Provider).AsObject;
   try
    Assert(l_Tag <> nil);
    if not l_Tag.QT(InevObject, l_Obj) then
     Assert(false);
    l_Holder := TnevObjectHolder.Create(l_Obj);
    try
     theStream := l_Holder;
    finally
     FreeAndNil(l_Holder);
    end;//try..finally
   finally
    l_Tag := nil;
   end;//try..finally
  finally
   l_Provider := nil;
  end;//try..finally
 end;//(aDocument <> nil)
//#UC END# *4D3EC093030F_4CB2EE9F02FE_impl*
end;//NsGetText
{$IfEnd} //not Admin AND not Monitorings

end.