VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "TypedList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'
' TypedList
' =========
'
' Only allows elements that are of a single type.
'
' Copywrite (C) 2014 Philip Wales
' This file (TypedList.cls) is distributed under the MIT license
'
Option Explicit
' Private Members
' ---------------
'
Private this As List
Private pTypedName As String

' Public Members
' --------------
'
' None
'
' Private Methods
' ---------------
'
''
' TypeCheck:
Private Sub TypeCheck(ByVal Item As Variant, ByVal source As String)
    If (TypeName(Item) <> pTypedName) Then RaiseTypeError Item, source
End Function
''
' TypeCheckSequence:
Private Sub TypeCheckSequence(ByVal sequence As Variant, ByVal source As String)
    
    Dim element As Variant
    For Each element In sequence
        TypeCheck element, source
    Next element
    
End Sub
''
' RaiseTypeError:
Private Sub RaiseTypeError(ByVal badItem As Variant, ByVal method As String)
    Err.Raise 0, method, "Element is of type " & TypeName(badItem) & _
                         ", not " & TypedName & "."
End Sub
''
' Constructor
Private Sub Class_Initialize()
    Set this = New List
End Sub
''
' Destructor: Might be unnecessary
Private Sub Class_Terminate()
    Set this = Nothing
End Sub
'
' Public Methods
' --------------
'
''
' Enumerator: How we all would love to create our own...
Public Property Get NewEnum() As IUnknown
Attribute NewEnum.VB_UserMemId = -4
    
    Set NewEnum = this.[_NewEnum]
    
End Property
'
'  ### TypedName Property
'
Public Property Get TypedName() As String
    
    TypedName = pTypedName
    
End Property
Public Property Let TypedName(ByVal typeName_ As String)
    
    If this.Count > 0 Then
        Err.Raise 9, TypeName(Me) & ".TypedName", _
            "Can only set typename of an empty list."
    End If
    
    pTypedName = typeName_
    
End Property
'
' ### Replacement
'
''
' Item:
Public Property Let Item(ByVal index As Long, ByVal element As Variant)
Attribute Item.VB_UserMemId = 0
    
    TypeCheck element, TypeName(Me) & ".Item"
    this.index(index) = element
    
End Property
Public Property Set Item(ByVal index As Long, ByVal element As Variant)
Attribute Item.VB_UserMemId = 0
    
    TypeCheck element, TypeName(Me) & ".Item"
    Set this.index(index) = element
    
End Property
''
' Slice:
Public Property Let Slice(ByVal a As Long, ByVal b As Long, ByVal sequence As Variant)
    
    TypeCheckSequence sequence, TypeName(Me) & ".Slice"
    this.Slice(a, b) = sequence
    
End Property
'
' ### Extension
'
' Append: Vanilla `Add`
Public Sub Append(ByVal element As Variant)
    
    TypeCheck element, TypeName(Me) & ".Append"
    this.Append element
    
End Sub
''
' Extend: Append multiple sequence
Public Sub Extend(ByVal sequence As Variant)
    
    TypeCheckSequence sequence, TypeName(Me) & ".Extend"
    this.Extend sequence
    
End Sub
'
' ### Insertion
'
''
' Emplace:
Public Sub Emplace(ByVal index As Long, ByVal element As Variant)
    
    TypeCheck element, TypeName(Me) & ".Emplace"
    this.Emplace index, element
    
End Sub
''
' Insert:
Public Sub Insert(ByVal index As Long, ByVal sequence As Variant)
    
    TypeCheckSequence sequence, TypeName(Me) & ".Insert"
    collec.Insert sequence, index
    
End Sub
'
' Default Interfaces
' ------------------
'
' ### Access
'
''
' Item
Public Property Get Item(ByVal index As Long) As Variant
Attribute Item.VB_UserMemId = 0
    seq.Assign Item, this.Item(index)
End Property
''
' Slice:
Public Property Get Slice(ByVal a As Long, ByVal b As Long) As List
    Set Slice = this.Slice(a, b)
End Property
'
' ### Removal
'
''
' Remove:
Public Sub Remove(ByVal index As Long)
    this.Remove index
End Sub
''
' Clear:
Public Sub Clear(ByVal start As Long, ByVal count As Long)
    this.Clear start, count
End Sub
'
' ### Aux
'
''
' Count
Public Property Get Count() As Long
    Count = this.Count
End Property
''
' Exists: Linear search for `sought`.
Public Function Exists(ByVal sought As Variant) As Boolean
    Exists = this.Exists(sought)
End Function
''
' Repr: Represent instance as String.
Public Property Get ToString() As String
    ToString = this.ToString
End Property