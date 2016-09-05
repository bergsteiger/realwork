unit nsEditionDiffData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionDiffData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsEditionDiffData" MUID: (4A7FD7E9035C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsCompareEditionsInfoPrim
 , EditionsInterfaces
 , DocumentUnit
 , eeInterfaces
 , Base_Operations_F1Services_Contracts
;

type
 TnsEditionDiffData = class(TnsCompareEditionsInfoPrim, InsEditionDiffData)
  public
   class function Make(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionDiffData; reintroduce;
 end;//TnsEditionDiffData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *4A7FD7E9035Cimpl_uses*
 //#UC END# *4A7FD7E9035Cimpl_uses*
;

class function TnsEditionDiffData.Make(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionDiffData;
var
 l_Inst : TnsEditionDiffData;
begin
 l_Inst := Create(aDoc, aPara, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionDiffData.Make
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
