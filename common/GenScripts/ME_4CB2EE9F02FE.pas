unit nsDocumentToolsNew;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsDocumentToolsNew.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Variant
 , nevTools
 , nevObjectHolder
 , DocumentUnit
;

procedure nsGetText(const aDocument: IDocument;
 out theStream: InevObjectHolder);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsF1DocumentTagNode
 , SysUtils
;

procedure nsGetText(const aDocument: IDocument;
 out theStream: InevObjectHolder);
//#UC START# *4D3EC093030F_4CB2EE9F02FE_var*
//#UC END# *4D3EC093030F_4CB2EE9F02FE_var*
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
end;//nsGetText
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
