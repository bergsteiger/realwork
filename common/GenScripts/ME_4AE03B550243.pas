unit nsEditionsContainerData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Editions\nsEditionsContainerData.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , EditionsInterfaces
 , DocumentUnit
;

type
 _MnsDocument_Parent_ = Tl3ProtoObject;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\MnsDocument.imp.pas}
 TnsEditionsContainerData = class(_MnsDocument_, InsEditionsContainerData)
  public
   constructor Create(const aDoc: IDocument;
    const aDocumentForReturn: TnsDocumentForReturnInfo); reintroduce;
   class function Make(const aDoc: IDocument;
    const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionsContainerData; reintroduce;
 end;//TnsEditionsContainerData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Editions\MnsDocument.imp.pas}

constructor TnsEditionsContainerData.Create(const aDoc: IDocument;
 const aDocumentForReturn: TnsDocumentForReturnInfo);
//#UC START# *4AE03BD6033A_4AE03B550243_var*
//#UC END# *4AE03BD6033A_4AE03B550243_var*
begin
//#UC START# *4AE03BD6033A_4AE03B550243_impl*
 inherited Create;
 Init(aDoc, aDocumentForReturn);
//#UC END# *4AE03BD6033A_4AE03B550243_impl*
end;//TnsEditionsContainerData.Create

class function TnsEditionsContainerData.Make(const aDoc: IDocument;
 const aDocumentForReturn: TnsDocumentForReturnInfo): InsEditionsContainerData;
var
 l_Inst : TnsEditionsContainerData;
begin
 l_Inst := Create(aDoc, aDocumentForReturn);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsEditionsContainerData.Make
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
