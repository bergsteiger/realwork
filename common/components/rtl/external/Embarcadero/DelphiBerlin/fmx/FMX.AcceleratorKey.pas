{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.AcceleratorKey;

interface

{$SCOPEDENUMS ON}

uses FMX.Types;

type
  /// <summary>This is an interface that descendant classes must implement to in order to be a accelerator key
  /// receiver.</summary>
  IAcceleratorKeyReceiver = interface
    ['{1C679082-65F2-4C54-A2C4-CD4C00E2C465}']
    /// <summary>True if the objects can trigger the action, False otherwise.</summary>
    /// <remarks>Even if an object can trigger an action because it is registered as an accelerator key receiver, it is
    /// possible that the object may not want to react with the accelerator key event. For example, a submenu that is
    /// hidden, or a tab page that is hidden.</remarks>
    function CanTriggerAcceleratorKey: Boolean;
    /// <summary>This method is invoked to allow the object to do everything it wants as a response to accelerator key
    /// The default behaviour is to focus the control.</summary>
    procedure TriggerAcceleratorKey;
    /// <summary>Returns the character key which serves as the keyboard accelerator for this receiver.</summary>
    function GetAcceleratorChar: Char;
    /// <summary>Returns the index of the accelerator character within the text string of the receiver. This information
    /// is typically used to highlight the accelerator character.</summary>
    function GetAcceleratorCharIndex: Integer;
  end;

  /// <summary>Platform service to provide support for accelerator keys for quick keyboard access to controls.</summary>
  IFMXAcceleratorKeyRegistryService = interface
    ['{0D06B7CC-FAF2-45F8-B7AA-D4B84FD384B7}']
    /// <summary>This method registers an object as a Receiver of accelerator keys for a given root container (typically
    /// a form). If the object is already added, this procedure has no effect.</summary>
    procedure RegisterReceiver(const ARoot: IRoot; const AReceiver: IAcceleratorKeyReceiver);
    /// <summary>Removes the object from the database for a particular root container (typically a form). If the object
    /// is not in the database, it has no effect.</summary>
    procedure UnregisterReceiver(const ARoot: IRoot; const AReceiver: IAcceleratorKeyReceiver);
    /// <summary>Removes the entire registry of accelerator keys for a given root container (form).</summary>
    procedure RemoveRegistry(const ARoot: IRoot);
    /// <summary>Emits the accelerator key to the given root container (typically a form). If the root container has a
    /// control which can receive the accelerator key, then the accelerator action is triggered.</summary>
    function EmitAcceleratorKey(const ARoot: IRoot; const AKey: Word): Boolean;
    /// <summary>This method unregisters the receiver from the old root, and registers the receiver into the new root.
    /// To be registered or unregistered, any root must support the IAcceleratorKeyRegistry interface.</summary>
    procedure ChangeReceiverRoot(const AReceiver: IAcceleratorKeyReceiver; const AOldRoot, ANewRoot: IRoot);
    /// <summary>Processes the AText parameter string to identify any embedded accelerator key markers (the ampersand
    /// symbol). If found, Key and KeyIndex will be returned with the accelerator character and the
    /// position at which is was found. If no accelerator key is indicated in the text string, Key will be a null
    /// character and KeyIndex will be -1.</summary>
    procedure ExtractAcceleratorKey(const AText: string; out Key: Char; out KeyIndex: Integer);
  end;

implementation

end.
