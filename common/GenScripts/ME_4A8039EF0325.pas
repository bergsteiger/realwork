unit nsCompareEditionsInfoPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsCompareEditionsInfoPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsRedactionCurrentPara
 , DocumentUnit
 , eeInterfaces
 , EditionsInterfaces
;

type
 _MnsDocument_Parent_ = TnsRedactionCurrentPara;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\MnsDocument.imp.pas}
 TnsCompareEditionsInfoPrim = class(_MnsDocument_)
  public
   constructor Create(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    const aDocumentForReturn: TnsDocumentForReturnInfo); reintroduce;
 end;//TnsCompareEditionsInfoPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\MnsDocument.imp.pas}

constructor TnsCompareEditionsInfoPrim.Create(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4B585365015A_4A8039EF0325_var*
//#UC END# *4B585365015A_4A8039EF0325_var*
begin
//#UC START# *4B585365015A_4A8039EF0325_impl*
 Assert(aDoc <> nil);
 Assert(aDocumentForReturn.rDoc <> nil);
 inherited Create(aPara);
 Init(aDoc, aDocumentForReturn);
//#UC END# *4B585365015A_4A8039EF0325_impl*
end;//TnsCompareEditionsInfoPrim.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
