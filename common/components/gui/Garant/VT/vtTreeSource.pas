unit vtTreeSource;

{ Библиотека ""           }
{ Начал: Люлин А.В.       }
{ Модуль: vtTreeSource -  }
{ Начат: 23.12.2004 14:52 }
{ $Id: vtTreeSource.pas,v 1.2 2004/12/23 12:22:37 lulin Exp $ }

// $Log: vtTreeSource.pas,v $
// Revision 1.2  2004/12/23 12:22:37  lulin
// - new interface: Il3SimpleTreeSource.
//
// Revision 1.1  2004/12/23 12:04:11  lulin
// - new unit: vtTreeSource.
//
//

{$I vtDefine.inc }

interface

uses
  l3TreeInterfaces,
  l3InterfacedComponent
  ;

type
  TvtCustomTreeSource = class(Tl3InterfacedComponent, Il3SimpleTreeSource)
    private
    // internal fields
      f_Tree : Il3SimpleTree;
    protected
    // interface methods
      // Il3SimpleTreeSource
      function  Get_Tree: Il3SimpleTree;
      procedure Set_Tree(const aValue: Il3SimpleTree);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public properties
      property Tree: Il3SimpleTree
        read Get_Tree
        write Set_Tree;
        {-}
  end;//TvtCustomTreeSource

  TvtTreeSource = class(TvtCustomTreeSource)
  end;//TvtTreeSource

implementation

procedure TvtCustomTreeSource.Cleanup;
  //override;
  {-}
begin
 Tree := nil;
 inherited;
end;

function TvtCustomTreeSource.Get_Tree: Il3SimpleTree;
  {-}
begin
 Result := f_Tree;
end;

procedure TvtCustomTreeSource.Set_Tree(const aValue: Il3SimpleTree);
  {-}
begin
 f_Tree := aValue;
end;

end.

