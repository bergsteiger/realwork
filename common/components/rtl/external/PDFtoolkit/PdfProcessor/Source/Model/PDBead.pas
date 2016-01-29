unit PDBead;

interface

uses
  gtObject, PDElement, PDBaseObject, PDPage, PDTypes, PDRect;

type

 (**
  * A bead is a single rectangle in an article thread. An article thread
  * represents a sequence of physically discontiguous but logically related
  * items in a document (for example, a news story that starts on one page of a
  * newsletter and runs onto one or more nonconsecutive pages)
  *
  * A bead remains valid as long as a thread is current and active.
  *)
  TgtPDBead = class(TgtPDElement)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    procedure Update; override;

    function GetPage: TgtPDPage;
    function GetIndex: Integer;
    function GetRect: TgtPDRect;
    function GetThread: TgtPDElement;

    procedure Insert(NewNext: TgtPDBead);

    procedure SetPage(Page: TgtPDPage);
    procedure SetRect(const Rect: TgtPDRect);

    function Next: TgtPDBead;
    function Prev: TgtPDBead;

    function IsEqual(Bead: TgtPDBead): Boolean;
  end;

implementation

{ TgtPDBead }

constructor TgtPDBead.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

destructor TgtPDBead.Destroy;
begin

  inherited;
end;

 (**
  * Gets the index of a bead in its thread.
  *
  * @return The index of the bead in its thread. The first bead in a thread has
  *         an index of zero.
  *)

function TgtPDBead.GetIndex: Integer;
begin
  Result := 0;
end;

 (**
  * Gets the page on which a bead is located.
  *
  * @return The page on which the bead resides.
  *)

function TgtPDBead.GetPage: TgtPDPage;
begin
  Result := nil;
end;

 (**
  * Gets a bead's bounding rectangle.
  *
  * @return The bead's bounding rectangle, specified in user space coordinates.
  *)

function TgtPDBead.GetRect: TgtPDRect;
begin
  Result := nil;
end;

 (**
  * Gets the thread containing the specified bead.
  *
  * @return The bead's thread, or nil if the bead does not belong to a thread.
  *         The user will have to typecast the result to TgtPDThread to use it.
  *)

function TgtPDBead.GetThread: TgtPDElement;
begin
  Result := nil;
end;

 (**
  * Inserts a bead after this bead.
  *
  * @param The bead to insert.
  *)

procedure TgtPDBead.Insert(NewNext: TgtPDBead);
begin

end;

(**
  * Tests two beads for equality. This method is useful to detect the end of a
  * thread since the last bead in a thread points to the first.
  *
  * @param Bead The Bead to which comparison has to be made
  *
  * @return True if the two beads are identical, False otherwise.
  *)

function TgtPDBead.IsEqual(Bead: TgtPDBead): Boolean;
begin
  Result := False;
end;

(**
  * Gets the next bead in a thread.
  *
  * @return The next bead, or a nil object. On the last bead, GetNext() returns
  *         the first bead.
  *)

function TgtPDBead.Next: TgtPDBead;
begin
  Result := nil;
end;

(**
  * Gets the previous bead in a thread.
  *
  * @return The previous bead, or a nil object. if this is the first bead in the
  *         thread.
  *)

function TgtPDBead.Prev: TgtPDBead;
begin
  Result := nil;
end;

(**
  * Sets the page for a bead.
  *
  * @param Page The page on which bead is located.
  *)

procedure TgtPDBead.SetPage(Page: TgtPDPage);
begin

end;

(**
  * Sets a bead's bounding rectangle.
  *
  * @param Rect the bead's bounding rectangle, specified in user space coordinates.
  *)

procedure TgtPDBead.SetRect(const Rect: TgtPDRect);
begin

end;

procedure TgtPDBead.Update;
begin
  inherited;

end;

end.
