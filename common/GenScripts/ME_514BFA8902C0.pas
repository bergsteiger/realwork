unit kwPopEditorBlockResizeEX;

interface

uses
 l3IntfUses
 , kwBlockResize
 , tfwScriptingInterfaces
 , nevTools
;

type
 TkwPopEditorBlockResizeEX = class(TkwBlockResize)
  {* *������:
aDelta aTop aLevel anEditor  pop:editor:BlockResizeEX
* aDelta - �������� �����
* aTop - true ����� ������� ������� �������
* aLevel - ������� ����������� �����.
* anEditor - ��������, � ������� ���������� ����. }
  procedure CorrectBlockPoint(const aCtx: TtfwContext;
   var aMap: InevMap;
   var aCursor: InevBasePoint);
 end;//TkwPopEditorBlockResizeEX
 
implementation

uses
 l3ImplUses
;

end.
