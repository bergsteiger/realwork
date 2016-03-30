unit DocWithPid;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocWithPid.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "DocWithPid" MUID: (4D9D92AF02B8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 DocWithPid = {abstract} class
  public
   procedure GetDocumentPid; virtual; abstract; stdcall;
 end;//DocWithPid

implementation

uses
 l3ImplUses
;

end.
