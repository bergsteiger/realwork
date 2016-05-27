unit csDeleteDocsQueryPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csDeleteDocsQueryPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsDeleteDocsQueryPrim" MUID: (53B6A54A0181)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
;

type
 TcsDeleteDocsQueryPrim = class(TddProcessTask)
  public
   class function GetTaggedDataType: Tk2Type; override;
 end;//TcsDeleteDocsQueryPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , DeleteDocsQuery_Const
;

class function TcsDeleteDocsQueryPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typDeleteDocsQuery;
end;//TcsDeleteDocsQueryPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
