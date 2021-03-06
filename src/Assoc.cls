VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Assoc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Option Explicit
'
' Assoc Class
' ===========
'
'
' Copywrite (C) 2014 Philip Wales
' This file (Assoc.cls) is distributed under the GPL-3.0 license
' Obtain a copy of the GPL-3.0 license <http://opensource.org/licenses/GPL-3.0>
'
'
Implements Showable
'
' Private Members
' ---------------
'
Private pPair As Tuple
'
'
'
Public Function Make(ByVal k, ByVal v) As Assoc

    Dim result As New Assoc
    result.Inject k, v
    Set Make = result

End Function
Friend Sub Inject(ByVal k, ByVal v)

    Set pPair = Tuple.Pack(k, v)
    
End Sub
Public Property Get key() As Variant
    
    Assign key, pPair.Item(1)
    
End Property
Public Property Get Value() As Variant
    
    Assign Value, pPair.Item(2)
    
End Property
'
'
'
Public Function Show() As String

    Show = defShow.Show(key) & " -> " & defShow.Show(Value)

End Function
Private Function Showable_Show() As String

    Showable_Show = Show

End Function
