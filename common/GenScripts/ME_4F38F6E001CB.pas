unit kwPopEditorBlockResize;

interface

uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResize = class(TkwBlockResize)
  {* *������:
aDelta aTop anEditor  pop:editor:BlockResize
* aDelta - �������� �����
* aTop - true ����� ������� ������� �������
* anEditor - ��������, � ������� ���������� ����. }
  procedure CorrectBlockPoint(const aCtx: TtfwContext;
   var aMap: InevMap;
   var aCursor: InevBasePoint);
 end;//TkwPopEditorBlockResize
 
implementation

uses
 l3ImplUses
;

end.
