Attribute VB_Name = "Module1"
Sub moderate()
Attribute moderate.VB_ProcData.VB_Invoke_Func = " \n14"

' Dimensions
Dim total As Double
Dim i As Long
Dim change As Single
Dim j As Integer
Dim start As Long
Dim rowCount As Long
Dim percentChange As Single
Dim ws As Worksheet

'Loop through each worksheet in the data set
For Each ws In Worksheets


'Create titles for new columns of data
ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"

'Initial values for variables
j = 0
total = 0
change = 0
start = 2

'Find row number of the last row of data in worksheet
rowCount = ws.Cells(Rows.Count, "A").End(xlUp).Row

For i = 2 To rowCount

    'If ticker changes
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
    
        'Update results in variables
        total = total + ws.Cells(i, 7).Value
        
        'For zero total volume
        If total = 0 Then
            
            'Print results
            ws.Range("I" & 2 + j).Value = ws.Cells(i, 1).Value
            ws.Range("J" & 2 + j).Value = 0
            ws.Range("K" & 2 + j).Value = "%" & 0
            ws.Range("L" & 2 + j).Value = 0
            
        Else
           
           'Find non-zero starting value
           If ws.Cells(start, 3) = 0 Then
                For nonzero_value = start To i
                    If ws.Cells(nonzero_value, 3).Value <> 0 Then
                        start = nonzero_value
                        Exit For
                    End If
                Next nonzero_value
            End If
            
            'Calculate yearly and percent changes
            change = (ws.Cells(i, 6) - ws.Cells(start, 3))
            percentChange = Round((change / ws.Cells(start, 3) * 100), 2)
            
            'Start of the next stock ticker
            start = i + 1
            
            'Print results
            ws.Range("I" & 2 + j).Value = ws.Cells(i, 1).Value
            ws.Range("J" & 2 + j).Value = Round(change, 2)
            ws.Range("K" & 2 + j).Value = "%" & percentChange
            ws.Range("L" & 2 + j).Value = total
           
            'Conditional formatting for positive and negative yearly change
            Select Case change
                Case Is > 0
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 4
                Case Is < 0
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 3
                Case Else
                    ws.Range("J" & 2 + j).Interior.ColorIndex = 0
            End Select
            
        End If
        
        'Reset variables if new ticker
        total = 0
        change = 0
        j = j + 1
    
    'If ticker does not change add results
    Else
        total = total + ws.Cells(i, 7).Value
    
    End If
    
    Next i
    
Next ws

    
End Sub
