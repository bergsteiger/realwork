{*******************************************************}
{                                                       }
{              Delphi Runtime Library                   }
{                                                       }
{          File: CFTree.h                               }
{          Copyright (c) 1998-2009, Apple Inc.          }
{          All Rights Reserved.                         }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{ !
        @header CFTree
        CFTree implements a container which stores references to other CFTrees.
        Each tree may have a parent, and a variable number of children.
 }

{$IFNDEF __COREFOUNDATION_CFTREE__}

{$DEFINE __COREFOUNDATION_CFTREE__}

{$I CFBase.inc}


{ !
        @typedef CFTreeRetainCallBack
        Type of the callback function used to add a retain to the user-specified
        info parameter.  This callback may returns the value to use whenever the
        info parameter is retained, which is usually the value parameter passed
        to this callback, but may be a different value if a different value
        should be used.
        @param info A user-supplied info parameter provided in a CFTreeContext.
        @result The retained info parameter.
 }
type
  CFTreeRetainCallBack = function(info: Pointer): Pointer; cdecl;
  {$EXTERNALSYM CFTreeRetainCallBack}

{ !
        @typedef CFTreeReleaseCallBack
        Type of the callback function used to remove a retain previously
        added to the user-specified info parameter.
        @param info A user-supplied info parameter provided in a CFTreeContext.
 }
  CFTreeReleaseCallBack = procedure(info: Pointer); cdecl;
  {$EXTERNALSYM CFTreeReleaseCallBack}

{ !
        @typedef CFTreeCopyDescriptionCallBack
        Type of the callback function used to provide a description of the
        user-specified info parameter.
        @param info A user-supplied info parameter provided in a CFTreeContext.
        @result A description of the info parameter.
 }
  CFTreeCopyDescriptionCallBack = function(info: Pointer): CFStringRef; cdecl;
  {$EXTERNALSYM CFTreeCopyDescriptionCallBack}

{ !
        @typedef CFTreeContext
        Structure containing user-specified data and callbacks for a CFTree.
        @field version The version number of the structure type being passed
                in as a parameter to the CFTree creation function.
                This structure is version 0.
        @field info A C pointer to a user-specified block of data.
        @field retain The callback used to add a retain for the info field.
                If this parameter is not a pointer to a function of the correct
                prototype, the behavior is undefined.  The value may be NULL.
        @field release The calllback used to remove a retain previously added
                for the info field.  If this parameter is not a pointer to a 
                function of the correct prototype, the behavior is undefined.
                The value may be NULL.
        @field copyDescription The callback used to provide a description of
                the info field.
 }
  PCFTreeContext = ^CFTreeContext;
  CFTreeContext = record
    version: CFIndex;
    info: Pointer;
    retain: CFTreeRetainCallBack;
    release: CFTreeReleaseCallBack;
    copyDescription: CFTreeCopyDescriptionCallBack;
  end;
  {$EXTERNALSYM CFTreeContext}

{ !
        @typedef CFTreeApplierFunction
        Type of the callback function used by the apply functions of
                CFTree.
        @param value The current value from the CFTree
        @param context The user-defined context parameter give to the apply
                function.
 }
  CFTreeApplierFunction = procedure(value: Pointer; context: Pointer); cdecl;
  {$EXTERNALSYM CFTreeApplierFunction}

{ !
        @typedef CFTreeRef
        This is the type of a reference to CFTrees.
 }
  PCFTreeRef = ^CFTreeRef;
  CFTreeRef = ^__CFTree;
  {$EXTERNALSYM CFTreeRef}
  __CFTree = record
  end;
  {$EXTERNALSYM __CFTree}

{ !
        @function CFTreeGetTypeID
        Returns the type identifier of all CFTree instances.
 }
function CFTreeGetTypeID: CFTypeID; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetTypeID';
{$EXTERNALSYM CFTreeGetTypeID}

{ !
        @function CFTreeCreate
        Creates a new mutable tree.
        @param allocator The CFAllocator which should be used to allocate
                memory for the tree and storage for its children.  This
                parameter may be NULL in which case the current default
                CFAllocator is used.  If this reference is not a valid
                CFAllocator, the behavior is undefined.
        @param context A C pointer to a CFTreeContext structure to be copied 
                and used as the context of the new tree.  The info parameter
                will be retained by the tree if a retain function is provided.
                If this value is not a valid C pointer to a CFTreeContext 
                structure-sized block of storage, the result is undefined. 
                If the version number of the storage is not a valid CFTreeContext
                version number, the result is undefined.
        @result A reference to the new CFTree.
 }
function CFTreeCreate(allocator: CFAllocatorRef; 
  context: PCFTreeContext): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeCreate';
{$EXTERNALSYM CFTreeCreate}

{ !
        @function CFTreeGetParent
        Returns the parent of the specified tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @result The parent of the tree.
 }
function CFTreeGetParent(tree: CFTreeRef): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetParent';
{$EXTERNALSYM CFTreeGetParent}

{ !
        @function CFTreeGetNextSibling
        Returns the sibling after the specified tree in the parent tree's list.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @result The next sibling of the tree.
 }
function CFTreeGetNextSibling(tree: CFTreeRef): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetNextSibling';
{$EXTERNALSYM CFTreeGetNextSibling}

{ !
        @function CFTreeGetFirstChild
        Returns the first child of the tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @result The first child of the tree.
 }
function CFTreeGetFirstChild(tree: CFTreeRef): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetFirstChild';
{$EXTERNALSYM CFTreeGetFirstChild}

{ !
        @function CFTreeGetContext
        Returns the context of the specified tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @param context A C pointer to a CFTreeContext structure to be filled in with
                the context of the specified tree.  If this value is not a valid C
                pointer to a CFTreeContext structure-sized block of storage, the
                result is undefined.  If the version number of the storage is not
                a valid CFTreeContext version number, the result is undefined.
 }
procedure CFTreeGetContext(tree: CFTreeRef; out context: CFTreeContext); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetContext';
{$EXTERNALSYM CFTreeGetContext}

{ !
        @function CFTreeGetChildCount
        Returns the number of children of the specified tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @result The number of children.
 }
function CFTreeGetChildCount(tree: CFTreeRef): CFIndex; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetChildCount';
{$EXTERNALSYM CFTreeGetChildCount}

{ !
        @function CFTreeGetChildAtIndex
        Returns the nth child of the specified tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @param idx The index of the child tree to be returned.  If this parameter
                is less than zero or greater than the number of children of the
                tree, the result is undefined.
        @result A reference to the specified child tree.
 }
function CFTreeGetChildAtIndex(tree: CFTreeRef;
  idx: CFIndex): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetChildAtIndex';
{$EXTERNALSYM CFTreeGetChildAtIndex}

{ !
        @function CFTreeGetChildren
        Fills the buffer with children from the tree.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
	@param children A C array of pointer-sized values to be filled with
		children from the tree.  If this parameter is not a valid pointer to a 
                C array of at least CFTreeGetChildCount() pointers, the behavior is undefined.
        @result A reference to the specified child tree.
 }
procedure CFTreeGetChildren(tree: CFTreeRef; out children: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeGetChildren';
{$EXTERNALSYM CFTreeGetChildren}

{ !
	@function CFTreeApplyFunctionToChildren
	Calls a function once for each child of the tree.  Note that the applier
        only operates one level deep, and does not operate on descendents further
        removed than the immediate children of the tree.
        @param heap The tree to be operated upon.  If this parameter is not a
		valid CFTree, the behavior is undefined.
	@param applier The callback function to call once for each child of
		the given tree.  If this parameter is not a pointer to a
                function of the correct prototype, the behavior is undefined.
                If there are values in the tree which the applier function does
                not expect or cannot properly apply to, the behavior is undefined.
	@param context A pointer-sized user-defined value, which is passed
		as the second parameter to the applier function, but is
		otherwise unused by this function.  If the context is not
		what is expected by the applier function, the behavior is
		undefined.
 }
procedure CFTreeApplyFunctionToChildren(tree: CFTreeRef; 
  applier: CFTreeApplierFunction; context: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeApplyFunctionToChildren';
{$EXTERNALSYM CFTreeApplyFunctionToChildren}

{ !
        @function CFTreeFindRoot
        Returns the root tree of which the specified tree is a descendent.
        @param tree The tree to be queried.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @result A reference to the root of the tree.
 }
function CFTreeFindRoot(tree: CFTreeRef): CFTreeRef; cdecl;
  external CoreFoundationLib name _PU + 'CFTreeFindRoot';
{$EXTERNALSYM CFTreeFindRoot}

{ !
        @function CFTreeSetContext
        Replaces the context of a tree.  The tree releases its retain on the
        info of the previous context, and retains the info of the new context.
        @param tree The tree to be operated on.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @param context A C pointer to a CFTreeContext structure to be copied 
                and used as the context of the new tree.  The info parameter
                will be retained by the tree if a retain function is provided.
                If this value is not a valid C pointer to a CFTreeContext 
                structure-sized block of storage, the result is undefined. 
                If the version number of the storage is not a valid CFTreeContext
                version number, the result is undefined.
 }
procedure CFTreeSetContext(tree: CFTreeRef; 
  context: PCFTreeContext); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeSetContext';
{$EXTERNALSYM CFTreeSetContext}

{ !
        @function CFTreePrependChild
        Adds the newChild to the specified tree as the first in its list of children.
        @param tree The tree to be operated on.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @param newChild The child to be added.
                If this parameter is not a valid CFTree, the behavior is undefined.
                If this parameter is a tree which is already a child of any tree,
                the behavior is undefined.
 }
procedure CFTreePrependChild(tree: CFTreeRef; newChild: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreePrependChild';
{$EXTERNALSYM CFTreePrependChild}

{ !
        @function CFTreeAppendChild
        Adds the newChild to the specified tree as the last in its list of children.
        @param tree The tree to be operated on.  If this parameter is not a valid
                CFTree, the behavior is undefined.
        @param newChild The child to be added.
                If this parameter is not a valid CFTree, the behavior is undefined.
                If this parameter is a tree which is already a child of any tree,
                the behavior is undefined.
 }
procedure CFTreeAppendChild(tree: CFTreeRef; newChild: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeAppendChild';
{$EXTERNALSYM CFTreeAppendChild}

{ !
        @function CFTreeInsertSibling
        Inserts newSibling into the the parent tree's linked list of children after
        tree.  The newSibling will have the same parent as tree.
        @param tree The tree to insert newSibling after.  If this parameter is not a valid
                CFTree, the behavior is undefined.  If the tree does not have a
                parent, the behavior is undefined.
        @param newSibling The sibling to be added.
                If this parameter is not a valid CFTree, the behavior is undefined.
                If this parameter is a tree which is already a child of any tree,
                the behavior is undefined.  
 }
procedure CFTreeInsertSibling(tree: CFTreeRef; newSibling: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeInsertSibling';
{$EXTERNALSYM CFTreeInsertSibling}

{ !
        @function CFTreeRemove
        Removes the tree from its parent.
        @param tree The tree to be removed.  If this parameter is not a valid
                CFTree, the behavior is undefined.
 }
procedure CFTreeRemove(tree: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeRemove';
{$EXTERNALSYM CFTreeRemove}

{ !
        @function CFTreeRemoveAllChildren
        Removes all the children of the tree.
        @param tree The tree to remove all children from.  If this parameter is not a valid
                CFTree, the behavior is undefined.
 }
procedure CFTreeRemoveAllChildren(tree: CFTreeRef); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeRemoveAllChildren';
{$EXTERNALSYM CFTreeRemoveAllChildren}

{ !
        @function CFTreeSortChildren
        Sorts the children of the specified tree using the specified comparator function.
        @param tree The tree to be operated on.  If this parameter is not a valid
                CFTree, the behavior is undefined.
	@param comparator The function with the comparator function type
		signature which is used in the sort operation to compare
		children of the tree with the given value. If this parameter
		is not a pointer to a function of the correct prototype, the
		the behavior is undefined. The children of the tree are sorted 
                from least to greatest according to this function.
	@param context A pointer-sized user-defined value, which is passed
		as the third parameter to the comparator function, but is
		otherwise unused by this function. If the context is not
		what is expected by the comparator function, the behavior is
		undefined.
 }
procedure CFTreeSortChildren(tree: CFTreeRef; comparator: CFComparatorFunction; 
  context: Pointer); cdecl;
  external CoreFoundationLib name _PU + 'CFTreeSortChildren';
{$EXTERNALSYM CFTreeSortChildren}


{$ENDIF !__COREFOUNDATION_CFTREE__}

