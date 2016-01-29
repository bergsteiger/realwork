unit evCustomStyleManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Variant
 , nevTools
;

 (*
 MevCustomStyleManager = interface
  {* �������� ������� TevCustomStyleManager }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//MevCustomStyleManager
 *)
 
type
 IevCustomStyleManager = interface
  {* ��������� ������� TevCustomStyleManager }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//IevCustomStyleManager
 
 TevCustomStyleManager = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function IsAbolishedDocumentLink(aSeg: Tl3Variant;
   const aPara: InevPara): Boolean;
  function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
 end;//TevCustomStyleManager
 
implementation

uses
 l3ImplUses
;

end.
