VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Begin VB.Form frmEditGrid 
   Caption         =   "The main purpose here is only to learn Grid Editing .........                                Vikrant Thakker...."
   ClientHeight    =   8025
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10740
   LinkTopic       =   "Form1"
   ScaleHeight     =   8025
   ScaleWidth      =   10740
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.TextBox Text1 
      BorderStyle     =   0  'None
      Height          =   330
      Left            =   3060
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   3180
      Width           =   1215
   End
   Begin VB.CommandButton cmdClpbrd 
      Caption         =   "Copy To Clipboard"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   1485
   End
   Begin MSFlexGridLib.MSFlexGrid grid 
      Height          =   1725
      Left            =   90
      TabIndex        =   0
      Top             =   810
      Width           =   4860
      _ExtentX        =   8573
      _ExtentY        =   3043
      _Version        =   393216
      BackColor       =   12632319
      Appearance      =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "frmEditGrid"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'##########################################################################
'#                          ANASYS SOFTWARE
'#
'# Vikrant Thakker
'# vikrant_thakker@yahoo.com
'#
'# Now it has been almost an year, i have been inspired
'# by the codes submitted by guys to PSC...
'#
'# So thanx PSC for offering its most valuable services
'# free of cost to all around the world...
'#
'# My this code is only in dedication of contributing
'# a drop of water in a sea like PSC....
'#
'# Guys ! i wont mind if u dont vote...
'# But if u vote, it will boost my confidence to a great extent....
'# As u will find that i have tried very hard on commenting each and every line
'# of yhis program... Just to make it easy to learn...
'# So please vote ;-)  .... And yes... your comments are most welcome
'#
'#
'# As this is my first submission, it has been mainly
'# focused for beginners...
'#
'# As this is for beginners, i have not included
'# Database connectivity, just to avoid confusions...
'#
'#########################################################################

'# This program will also show how to validate the data entered in the cell
'# u can enter only numbers in the rate column... so i have put this
'# validation... just check it out...


Option Explicit

Dim firstrow, firstcol As Integer  ' selection started from ...

Private Sub cmdclpbrd_Click()



' If you just want a straightforward copy into the clipboard of the
' selected cells without VBCRLF (using VBCR instead), you can simply
' use :
'
' Clipboard.Clear
' Clipboard.SetText grid.Clip
'
' To Directly copy all selected cells into the clipboard
'

    Dim i As Integer, maxi As Integer, j As Long, maxj As Long
    Dim strBuffer As String

    strBuffer = ""
    Clipboard.Clear

    maxj = grid.RowSel
    maxi = grid.ColSel
'
' Use Below Code for Standard Grid.OCX Grid
'
'    For j = firstrow To maxj
'        grid.Row = j
'        For i = firstcol To maxi
'            grid.Col = i
'            If i = maxi Then
'                strBuffer = strBuffer & grid.Text & vbCrLf
'            Else
'                strBuffer = strBuffer & grid.Text & Chr(9)
'            End If
'        Next
'    Next
'
' Use Below Code for MSFlexGrid
'
    For j = firstrow To maxj
        For i = firstcol To maxi
            If i = maxi Then
                strBuffer = strBuffer & grid.TextMatrix(j, i) & vbCrLf
            Else
                strBuffer = strBuffer & grid.TextMatrix(j, i) & vbTab
            End If
        Next
    Next
    
    Clipboard.SetText strBuffer
    
    
    MsgBox "Data copied to clipboard !!!"


End Sub



Private Sub Form_Load()
    Dim lCount As Long
    
' The text box that we are using for editing grid should not be visible
    Text1.Visible = False
    
    
' To set the over all appearance of the grid

    grid.Appearance = flexFlat
    
    grid.Rows = 2
    grid.Cols = 3
    grid.FixedCols = 0

        
 ' To set the heading of the columns
 
        grid.TextMatrix(lCount, 0) = "Item Code"
        grid.TextMatrix(lCount, 1) = "Description"
        grid.TextMatrix(lCount, 2) = "Rate"
 
  
    
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    
    grid.Move ScaleLeft, cmdClpbrd.Height, ScaleWidth, ScaleHeight - (cmdClpbrd.Top + cmdClpbrd.Height)
        
End Sub



Private Sub grid_Click()
    Text1.Visible = True
    Text1.Width = grid.CellWidth
    Text1.Height = grid.CellHeight
    Text1.Top = grid.CellTop + grid.Top
    Text1.Left = grid.CellLeft + grid.Left
    Text1.Text = grid.Text
    Text1.SelStart = 0
    Text1.SelLength = Len(Text1.Text)
    Text1.ZOrder
    Text1.SetFocus
    
End Sub

Private Sub grid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        Call grid_Click
    End If
    If KeyCode = vbKeyDelete Then
        grid.Text = ""
    End If
    
End Sub

Private Sub grid_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    firstcol = grid.Col
    firstrow = grid.Row
End Sub


Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
    
'Over All working of this Sub in nutshell....

' If enter key is pressed then copy the string entered in text box to grid cell
' After copying, now move to the cell of next column
' But if the enter key is pressed when the textbox is in last column then
' Add a new row and set the text box to the first column of a new row...
' I know it may be a bit confusing for beginners, but i m sure u will
' understand this after u run the program...
    
      
' I have further commented according to the purpose of the coding lines...
' This will show u what a particular code of lines is suppose to do...
    
 
 ' If enter key is pressed then store the string entered in text box to a grid cell

'If KeyCode = vbKeyDelete Then
'MsgBox "Del"
'End If

    
    If KeyCode = vbKeyReturn Then
        grid.Text = Text1.Text
        
        

        
 ' If it is the last column of the grid
 ' (Here the last col. is 2)
 
        If grid.Col = 2 Then
        

' The Rate can only be numeric, we can not enter any non numeric character here...
        
    If Not IsNumeric(Text1.Text) Then
        MsgBox ("Enter numeric value")
        Text1.Text = ""
        Exit Sub
    End If
' Then dont move forward to next column (as this is the only last col. and we dont have any more columns to move next)

        grid.Col = grid.Col
        
' Now add a new Row

        grid.Rows = grid.Rows + 1
        
    
' And move to the new row
        
        grid.Row = grid.Row + 1
' Go to the position of 1st column (0) of new row
        
        grid.Col = 0
        Else
        
' If it is not the last column then move to the next column
            grid.Col = grid.Col + 1

            'grid.Row = grid.Row + 1
        End If
        grid.SetFocus
        Text1.Visible = False
    End If
End Sub

Private Sub Text1_LostFocus()
    Text1.Visible = False
End Sub

